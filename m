Received: from eggs.gnu.org ([2001:4830:134:3::10]:34082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVxA0-0003ab-L9
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVx9z-0001tC-7H
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:13:04 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:38650 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVx9y-0001sx-NV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:13:03 -0500
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-4-git-send-email-vsementsov@virtuozzo.com>
	<20170124071726.GC27126@lemon.Home>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c7ab4cec-2d0d-8a49-7fc3-fe617d5f61fd@virtuozzo.com>
Date: Tue, 24 Jan 2017 12:12:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170124071726.GC27126@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/21] backup: improve non-dirty bits
 progress processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

24.01.2017 10:17, Fam Zheng wrote:
> On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
>> Set fake progress for non-dirty clusters in copy_bitmap initialization,
>> to:
>> 1. set progress in the same place where corresponding clusters are
>> consumed from copy_bitmap (or not initialized, as here)
>> 2. earlier progress information for user
>> 3. simplify the code
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/backup.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 621b1c0..f1f87f6 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -383,7 +383,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>       int64_t sector;
>>       int64_t cluster;
>>       int64_t end;
>> -    int64_t last_cluster = -1;
>>       int64_t sectors_per_cluster = cluster_size_sectors(job);
>>       BdrvDirtyBitmapIter *dbi;
>>   
>> @@ -395,12 +394,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>       while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
>>           cluster = sector / sectors_per_cluster;
>>   
>> -        /* Fake progress updates for any clusters we skipped */
>> -        if (cluster != last_cluster + 1) {
>> -            job->common.offset += ((cluster - last_cluster - 1) *
>> -                                   job->cluster_size);
>> -        }
>> -
>>           for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
>>               do {
>>                   if (yield_and_check(job)) {
>> @@ -422,14 +415,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>           if (granularity < job->cluster_size) {
>>               bdrv_set_dirty_iter(dbi, cluster * sectors_per_cluster);
>>           }
>> -
>> -        last_cluster = cluster - 1;
>> -    }
>> -
>> -    /* Play some final catchup with the progress meter */
>> -    end = DIV_ROUND_UP(job->common.len, job->cluster_size);
>> -    if (last_cluster + 1 < end) {
>> -        job->common.offset += ((end - last_cluster - 1) * job->cluster_size);
>>       }
>>   
>>   out:
>> @@ -462,6 +447,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>>           bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_cluster);
>>       }
>>   
>> +    job->common.offset = job->common.len -
>> +                         hbitmap_count(job->copy_bitmap) * job->cluster_size;
>> +
>>       bdrv_dirty_iter_free(dbi);
>>   }
> Is this effectively moving the progress reporting from cluster copying to dirty
> bitmap initialization? If so the progress will stay "100%" once
> backup_incremental_init_copy_bitmap returns, but the backup has merely started.
> I don't think this is a good idea.
>
> Fam

Currently progress tracking for incremental backup is bad too. Holes are 
bad for progress in any way. To make good progress we should calculate 
it like (cluters _physically_ copied) / (full amount of clusters to be 
_physically_ copied). And with current qapi scheme it is not possible. 
This formula may be approximated by (offset - skipped_clusters) / (len - 
skipped_clusters), where offset and len are old good len, and 
skipped_clusters should be added to query_block_jobs. And with such 
approximation it is obvious that it will be more presize if we skip all 
clusters that should be skipped earlier. The best way of course is to 
skip them in initialization. It is not possible (if I understand things 
right) for full mode, as it skips clusters using get_block_status which 
may be long operation, so we should start notifier handling before 
skipping operation is finished...

Any way, it is work of management tool to show beautiful progress, qemu 
only provides information for it, and with current scheme, the only way 
to provide information about cluster skipping in copying progress is by 
offset field. And it is not bad to provide this information earlier. And 
again, to produce really beautiful progress we at least need one more 
field - skipped_clusters.


-- 
Best regards,
Vladimir
