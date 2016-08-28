//
//  ViewController.m
//  下拉放大
//
//  Created by  wuhiwi on 16/8/24.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth (self.view.bounds.size.width)
#define kScreenHeight (self.view.bounds.size.height)
#define kHeaderImageHeight 200
#define kTableViewCellReuseidentifier @"kTableViewCellReuseidentifier"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.headerImageView];    
}

#pragma mark - setter getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(kHeaderImageHeight, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseidentifier];
    }
    return _tableView;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHeaderImageHeight, kScreenWidth, kHeaderImageHeight)];
        _headerImageView.image = [UIImage imageNamed:@"girl"];
    }
    return _headerImageView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"23123",@"432",@"312",@"312321",@"423421",@"42143",@"4213",@"42112", nil];
    }
    return _dataArray;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseidentifier];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGFloat yOffset = scrollView.contentOffset.y;
    //NSLog(@"%f",yOffset);
    
    
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    NSLog(@"yOffset===%f",yOffset);
    CGFloat xOffset = (yOffset +kHeaderImageHeight)/2;
    
    if(yOffset < -kHeaderImageHeight) {
        CGRect f =self.headerImageView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        f.origin.x= xOffset;
        //int abs(int i); // 处理int类型的取绝对值
        //double fabs(double i); //处理double类型的取绝对值
        //float fabsf(float i); //处理float类型的取绝对值
        f.size.width=kScreenWidth + fabs(xOffset)*2;
        
        self.headerImageView.frame= f;
    }
}
@end
