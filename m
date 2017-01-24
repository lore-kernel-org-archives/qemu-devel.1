Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVwyM-00088l-H6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVwyH-0002fR-Q6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:01:02 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:16793 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVwyH-0002eu-Eg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:00:57 -0500
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
	<20170124070938.GB27126@lemon.Home>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ecdbc4c4-f908-9895-2ff8-0129dbaa41d4@virtuozzo.com>
Date: Tue, 24 Jan 2017 12:00:41 +0300
MIME-Version: 1.0
In-Reply-To: <20170124070938.GB27126@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/21] backup: init copy_bitmap from
 sync_bitmap for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

24.01.2017 10:09, Fam Zheng wrote:
> On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
>> We should not copy non-dirty clusters in write notifiers. So,
>> initialize copy_bitmap from sync_bitmap.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/backup.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 6b27e55..621b1c0 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -437,6 +437,34 @@ out:
>>       return ret;
>>   }
>>   
>> +/* init copy_bitmap from sync_bitmap */
>> +static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>> +{
>> +    int64_t sector;
>> +    BdrvDirtyBitmapIter *dbi;
>> +    uint32_t sect_gran =
>> +        bdrv_dirty_bitmap_granularity(job->sync_bitmap) >> BDRV_SECTOR_BITS;
>> +    int64_t sz = bdrv_dirty_bitmap_size(job->sync_bitmap);
>> +    int64_t sectors_per_cluster = cluster_size_sectors(job);
>> +    uint32_t cl_gran = MAX(1, sect_gran / sectors_per_cluster);
>> +
>> +    dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);
>> +    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
>> +        int64_t cluster = sector / sectors_per_cluster;
>> +        int64_t next_sector = (cluster + cl_gran) * sectors_per_cluster;
>> +
>> +        hbitmap_set(job->copy_bitmap, cluster, cl_gran);
>> +
>> +        if (next_sector >= sz) {
>> +            break;
>> +        }
>> +
>> +        bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_cluster);
>> +    }
>> +
>> +    bdrv_dirty_iter_free(dbi);
>> +}
>> +
>>   static void coroutine_fn backup_run(void *opaque)
>>   {
>>       BackupBlockJob *job = opaque;
>> @@ -453,20 +481,22 @@ static void coroutine_fn backup_run(void *opaque)
>>       end = DIV_ROUND_UP(job->common.len, job->cluster_size);
>>   
>>       job->copy_bitmap = hbitmap_alloc(end, 0);
>> -    hbitmap_set(job->copy_bitmap, 0, end);
>>   
>>       job->before_write.notify = backup_before_write_notify;
>>       bdrv_add_before_write_notifier(bs, &job->before_write);
>>   
>>       if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
>> +        hbitmap_set(job->copy_bitmap, 0, end);
> This is confusing. It seems job->copy_bitmap is actually a superset of clusters
> to copy instead of the exact one?  Because "none" mode doesn't need blanket copy
> - only overwritten clusters are copied...

We can't guess, what clusters should be copied finally in none mode. 
None mode is done by allowing only notifier handling and no linear 
copying. But notifier handling will copy only clusters marked in 
copy_bitmap, so I set it from 0 to end.

>
>>           while (!block_job_is_cancelled(&job->common)) {
>>               /* Yield until the job is cancelled.  We just let our before_write
>>                * notify callback service CoW requests. */
>>               block_job_yield(&job->common);
>>           }
>>       } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
>> +        backup_incremental_init_copy_bitmap(job);
> ... But here you are only marking bits in sync_bitmap.
>
> Fam
>
>>           ret = backup_run_incremental(job);
>>       } else {
>> +        hbitmap_set(job->copy_bitmap, 0, end);
>>           /* Both FULL and TOP SYNC_MODE's require copying.. */
>>           for (; start < end; start++) {
>>               bool error_is_read;
>> -- 
>> 1.8.3.1
>>


-- 
Best regards,
Vladimir
