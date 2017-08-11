Received: from eggs.gnu.org ([2001:4830:134:3::10]:50196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dfz7J-0005HS-MY
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 21:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dfz7I-0007xP-96
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 21:52:01 -0400
References: <e8abd17c-6003-6bf4-11da-309457467965@virtuozzo.com>
	<0731e80d-6a92-b1e8-d6b4-31cdb19f7cb3@virtuozzo.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <68203d39-2da3-037c-1ee9-9e3a2a3f064c@gmail.com>
Date: Fri, 11 Aug 2017 09:51:40 +0800
MIME-Version: 1.0
In-Reply-To: <0731e80d-6a92-b1e8-d6b4-31cdb19f7cb3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] block replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wen Congyang <wencongyang2@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Zhang Hailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

在 8/10/2017 8:26 PM, Vladimir Sementsov-Ogievskiy 写道:
> 09.08.2017 17:11, Vladimir Sementsov-Ogievskiy wrote:
>> Hi Wen!
>>
>> I'm trying to understand block/replication code and have a question.
>>
>> Why should we block the region from intersecting cow requests when 
>> read? If I understand correctly
>>
>> regardless of writes to the secondary-disk we have consistent view of 
>> it through hidden-disk:
>>
>> Even if we are intersecting with some writes to secondary-disk (and 
>> corresponding cow-requests), the
>>
>> data in secondary disk will not be updated until backed up to 
>> hidden-disk, therefore, for read we have two
>>
>> options:
>>
>> 1. read old data from secondary-disk (unallocated region in 
>> hidden-disk means data in secondary-disk is not updated yet)
>>
>> 2. read backed-up data from hidden-disk (data in secondary-disk may be 
>> already updated but we don't care)
>>
>> (the whole region to read may consists of parts, corresponding to 1 or 
>> 2, but this should be ok too)
>>
>> Where am I wrong?
> 
> Ok, now I think this is needed to prevent intersecting of writes and 
> reads on hidden-disk. If it so, I think it is better to use serializing 

Hi, Vladimir. Pls refer 
https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg03025.html

BTW, wen's email has changed, also CC Zhang Hailiang, Zhang Chen, Li Zhijian

> requests
> mechanism (just serialize all requests on hidden-disk, and on write wait 
> for all intersecting serializing requests, on read wait for intersecting 
> serializing writes) - it may require additional
> option for BlockDriverState, but it is more generic and more clear than 
> export internal backup things to lock disk region. This also can be 
> reused for image-fleecing scheme
> (which is based on same pattern  [active-disk is backing for temp-disk, 
> backup sync=none from active to temp, read from temp])
> 
>>
>>
>> ======
>>
>> static coroutine_fn int replication_co_readv(BlockDriverState *bs,
>>                                              int64_t sector_num,
>>                                              int remaining_sectors,
>>                                              QEMUIOVector *qiov)
>> {
>>     BDRVReplicationState *s = bs->opaque;
>>     BdrvChild *child = s->secondary_disk;
>>     BlockJob *job = NULL;
>>     CowRequest req;
>>     int ret;
>>
>>     if (s->mode == REPLICATION_MODE_PRIMARY) {
>>         /* We only use it to forward primary write requests */
>>         return -EIO;
>> }
>>
>>     ret = replication_get_io_status(s);
>>     if (ret < 0) {
>>         return ret;
>> }
>>
>>     if (child && child->bs) {
>>         job = child->bs->job;
>> }
>>
>>     if (job) {
>>         uint64_t remaining_bytes = remaining_sectors * BDRV_SECTOR_SIZE;
>>
>> backup_wait_for_overlapping_requests(child->bs->job,
>>                                              sector_num * 
>> BDRV_SECTOR_SIZE,
>> remaining_bytes);
>>         backup_cow_request_begin(&req, child->bs->job,
>>                                  sector_num * BDRV_SECTOR_SIZE,
>> remaining_bytes);
>>         ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors,
>> qiov);
>> backup_cow_request_end(&req);
>>         goto out;
>> }
>>
>>     ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors, qiov);
>> out:
>>     return replication_return_value(s, ret);
>> }
>>
> 

-- 
Thanks
     -Xie
