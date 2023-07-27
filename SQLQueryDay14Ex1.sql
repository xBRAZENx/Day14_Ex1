drop database ExerciseDb
create database ExerciseDb
use ExerciseDb

create table Products(PId int primary key identity(1000,1),PName nvarchar(50),PPrice float,PTax as PPrice*0.10 persisted,
PCompany nvarchar(50) check(PCompany = 'SamSung' or PCompany = 'Apple' or PCompany = 'Redmi' or PCompany = 'HTC'),
PQty int check (PQty >=1) default 1)
insert into Products values ('charger',1500.99,'Redmi',2)
insert into Products values ('laptop',50000.99,'Apple',3)
insert into Products values ('powerbank',1600.99,'Redmi',5)
insert into Products values ('cover',150.99,'Apple',7)
insert into Products values ('screen',15000.99,'HTC',8)
insert into Products values ('tablet',10000.99,'SamSung',1)
insert into Products values ('cable',1800.99,'HTC',9)
insert into Products values ('coolingpad',1350.99,'Apple',7)
insert into Products values ('adapter',1500.99,'Redmi',6)
insert into Products values ('headphone',5000.99,'Redmi',4)
select * from Products

alter proc disp_details
with encryption
as
begin
select PId,PName,PPrice+PTax as 'Price with Tax',PCompany,PQty*(PPrice*PTax) as 'Total Price' from Products
end

execute disp_details

create proc TTax
@Pcy nvarchar(50),
@TTax float out
with encryption
as
begin
select  @TTax=sum(PTax) from Products where PCompany=@Pcy
end


declare @pcompany float
execute TTax 'Apple',@Pcompany out
print @Pcompany