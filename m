Received: from eggs.gnu.org ([2001:4830:134:3::10]:42311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2baj-0006pe-Dv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2bag-000146-3u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:23:53 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24780 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2baf-000135-Iz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:23:50 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-4-vsementsov@virtuozzo.com>
	<9e5c8b0a-d2f9-e051-f8fb-b9618982e6ea@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b3c404ca-54bd-7385-32eb-58addcf52714@virtuozzo.com>
Date: Thu, 12 Oct 2017 14:23:33 +0300
MIME-Version: 1.0
In-Reply-To: <9e5c8b0a-d2f9-e051-f8fb-b9618982e6ea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/5] backup: init copy_bitmap from
 sync_bitmap for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

10.10.2017 01:56, John Snow wrote:
>
> On 10/02/2017 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We should not copy non-dirty clusters in write notifiers. So,
>> initialize copy_bitmap from sync_bitmap.
>>
> ...! Duh, good find!!
>
> So, previously we'd copy extra sectors if they just so happened to be
> written to during the backup process. These would be totally redundant
> compared to the previous backups in the chain, by definition.
>
> Now, we allow the write to go through to the source image and let it
> dirty the bdrv dirty bitmap we have on standby.
>
> Good fix.
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/backup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 08efec639f..07f4ae846b 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -422,6 +422,43 @@ out:
>>       return ret;
>>   }
>>   
>> +/* init copy_bitmap from sync_bitmap */
>> +static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>> +{
>> +    BdrvDirtyBitmapIter *dbi;
>> +    int64_t offset;
>> +    int64_t end = DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap),
>> +                               job->cluster_size);
>> +
>> +    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
>> +    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
>> +        int64_t cluster = offset / job->cluster_size;
>> +        int64_t next_cluster;
>> +
>> +        offset += bdrv_dirty_bitmap_granularity(job->sync_bitmap);
>> +        if (offset >= bdrv_dirty_bitmap_size(job->sync_bitmap)) {
>> +            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
>> +            break;
>> +        }
>> +
>> +        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset);
>> +        if (offset == -1) {
>> +            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
>> +            break;
>> +        }
>> +
>> +        next_cluster = DIV_ROUND_UP(offset, job->cluster_size);
>> +        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster);
>> +        if (next_cluster >= end) {
>> +            break;
>> +        }
>> +
> Did you look into initializing this from a lower layer, e.g. a call to
> initialize-an-hbitmap-from-another-hbitmap?
>
> The loop might look a little cleaner that way and we might possibly get
> more utility out of it than a custom coded loop here in the backup code.

No, to be honest, I don't want to do it now, there are some difficulties:

1. we init from bdrv bitmap, so we'll have to add a bit strange common 
interface init-hbitmap-from-bdrv-bitmap
2 (more hard). here copy_bitmap have other size: it's granularity is 
zero, it corresponds to clusters, not to bytes, and I don't want to 
change this.
so, it's not a common case..


>
>> +        bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
>> +    }
>> +
>> +    bdrv_dirty_iter_free(dbi);
>> +}
>> +
>>   static void coroutine_fn backup_run(void *opaque)
>>   {
>>       BackupBlockJob *job = opaque;
>> @@ -435,20 +472,26 @@ static void coroutine_fn backup_run(void *opaque)
>>   
>>       nb_clusters = DIV_ROUND_UP(job->common.len, job->cluster_size);
>>       job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
>> -    hbitmap_set(job->copy_bitmap, 0, nb_clusters);
> Alright, so the last patch introduced a blunt initialization, and you've
> replaced it by more granular initializations.
>
>>   
>>       job->before_write.notify = backup_before_write_notify;
>>       bdrv_add_before_write_notifier(bs, &job->before_write);
>>   
>>       if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
>> +        /* Here we set all bits in job->copy_bitmap to allow copying clusters
>> +         * which are going to be changed (none-mode semantics). It doesn't mean
>> +         * that we want to copy _all_ clusters.
>> +         */
> Right, this is more like ALLOWING all sectors to be copied.
>
> Perhaps:
>
> "All bits are set to allow any cluster to be copied. This does not
> actually require them to be copied."
>
>> +        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
>>           while (!block_job_is_cancelled(&job->common)) {
>>               /* Yield until the job is cancelled.  We just let our before_write
>>                * notify callback service CoW requests. */
>>               block_job_yield(&job->common);
>>           }
>>       } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
>> +        backup_incremental_init_copy_bitmap(job);
>>           ret = backup_run_incremental(job);
>>       } else {
>> +        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
> Maybe you could just factor these things out entirely:
>
> if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
>    backup_incremental_init_copy_bitmap(job);
> } else {
>    hbitmap_set(job->copy_bitmap, 0, nb_clusters);
> }
>
> prior to the big switch statement.
>
>>           /* Both FULL and TOP SYNC_MODE's require copying.. */
>>           for (offset = 0; offset < job->common.len;
>>                offset += job->cluster_size) {
>>


-- 
Best regards,
Vladimir
