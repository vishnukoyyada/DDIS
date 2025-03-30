create database the_shop;
-- \connect the_shop in psql

create table items (
  item_id varchar(10) not null,
  title varchar(100) not null unique,
  type varchar(100) not null,
  category varchar(100) not null,
  subcategory varchar(100) not null,
  manufacturer varchar(100) not null,
  manufacturer_description text null,
  release_year int not null,
  avg_rating decimal(2,1) null,
  ratings int null,
  sales int null,
  primary key (item_id));

create table users (
  uid varchar(10) not null,
  first_name varchar(100) not null,
  last_name varchar(100) not null,
  email varchar(100) not null unique,
  password varchar(200) not null,
  city varchar(100) not null,
  country varchar(100) not null,
  purchases int null,
  sales int null,
  purchases_sum decimal(16,2) null,
  sales_sum decimal(16,2) null,
  balance decimal(16,2) null,
  primary key (uid));

create table sales (
  sale_id varchar(20) not null,
  seller_uid varchar(10) not null,
  buyer_uid varchar(10) null,
  item_id varchar(10) not null,
  quantity int default 1,
  price_per_item decimal(7,2),
  price_total decimal(7,2),
  state varchar(20) not null,
  seller_description text,
  date_offered timestamp,
  date_sold timestamp,
  batch int,
  primary key (sale_id),
  constraint fk_sales_seller foreign key (seller_uid) references users(uid),
  constraint fk_sales_buyer foreign key (buyer_uid) references users(uid),
  constraint fk_sales_item foreign key (item_id) references items(item_id));

create index sales_batch_idx on sales(batch);

create table reviews (
  sale_id varchar(20) not null,
  reviewer_uid varchar(10) not null,
  item_id varchar(10) not null,
  rating int check (rating between 1 and 5),
  text text,
  date_created timestamp,
  batch int,
  primary key (sale_id),
  constraint fk_reviews_buyer foreign key (reviewer_uid) references users(uid),
  constraint fk_reviews_item foreign key (item_id) references items(item_id));

create index reviews_batch_idx on reviews(batch);