Received: from eggs.gnu.org ([2001:4830:134:3::10]:47049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2bsm-0000fz-GS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2bsj-0007J3-Sa
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:42:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13120 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2bsj-0007Ii-Aa
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:42:29 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-5-vsementsov@virtuozzo.com>
	<a7594875-cd6f-8195-4b86-d7f67ad9f208@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2cb5ac95-e27c-2d13-b557-9dedc1f86473@virtuozzo.com>
Date: Thu, 12 Oct 2017 14:42:13 +0300
MIME-Version: 1.0
In-Reply-To: <a7594875-cd6f-8195-4b86-d7f67ad9f208@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/5] backup: simplify non-dirty bits
 progress processing
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

10.10.2017 02:44, John Snow wrote:
>
> On 10/02/2017 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Set fake progress for non-dirty clusters in copy_bitmap initialization,
>> to. It simplifies code and allows further refactoring.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Motivation (some of these paragraphs may be needed in commit message...)
>>
> lol! "pick and choose which paragraphs look good, stick some up there,
> maybe?"
>
>> 1. Current behavior is not good: setting fake progress leads to progress
>> hopping, so actually for sparse disk progress say nothing. We just move
>> all these hops to the beginning.
>>
> To be fair, if it's sparse, the first update will be very soon.
>
>> 2. Big hop in the beginning is possible now too: if there is a hole at
>> the beginning of virtual disk.
>>
>> 3. Now, there are some excuses for old behavior in comparison to new one:
>> backup progress is linear, cluster by cluster. But in future cluster
>> copying will be done by several coroutine-workers, several requests in
>> parallel, so it will make no sense to publish fake progress by parts in
>> parallel with non-sequential requests.
>>
> I agree.
>
>> 4. Actually it's just a point of view: when we are actually skip clusters?
>> If go through disk sequentially, it's logical to say, that we skip clusters
>> between copied portions to the left and to the right of them. But even know
>> copying progress is not sequential because of write notifiers.
>> If copying is async, non-sequential, we can say in the very beginning, that
>> we skip these clusters and do not think about them later.
>>
> Good observation.
>
>> So, I don't want to maintain portions of fake progress in the new backup
>> architecture. I understand, that this patch will change user's view
>> of backup progress, but formally it doesn't change: progress hops are just
>> moved to the beginning. Progress was meaningless for incremental backup and
>> it remains meaningless.
>>
> Haha. Not meaningless, but it does carry less information than other
> progress meters. It is effectively a % complete meter, with a really bad
> estimate.
>
>> But what should we do with progress, really? It's obvious, that we need at
>> least one more field for block job status, for example, "skipped", which
>> would be amount of bytes which are not really processed but skipped by the
>> block job. So, more real progress may be calculated (by management tool) like
>>
>> (job.offset - job.skipped) / (job.len - job.skipped)
>>
> I'm not sure we actually need a new field... let's just say that the job
> length is the number of bytes described by the incremental backup. Every
> time we copy some, move offset forward. This would give a more
> appropriately linear/accurate sense of the progress.
>
> I think we are allowed to do this as I think we promise that these
> progress numbers mean essentially nothing...

I'm not sure, length is published field, it is available in libvirt. 
IMHO, If we change it semantics it should
firstly break our iotests but what it will break for users is 
unpredictable..

>
> New fields that actually *do* report meaningful information, however,
> could be added. bytesCopied would be a prime candidate.

so you suggest to change semantics of one field and add another
I suggest to just add one field, it's safer I think.

>
>> And this progress will be more precise if information about skipped bytes
>> is provided earlier, and current patch is close to this idea.
>>
>> So, if you agree, I can make a patch for 'skipped' too, but it actually not
>> related to the series, so I hope that current patch will be merged anyway.
>> (I need it for backup refactoring, not for accurate progress)
>>
>>   block/backup.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 07f4ae846b..52df7bb19e 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -369,7 +369,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>       int64_t offset;
>>       int64_t cluster;
>>       int64_t end;
>> -    int64_t last_cluster = -1;
>>       BdrvDirtyBitmapIter *dbi;
>>   
>>       granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
>> @@ -380,12 +379,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>       while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
>>           cluster = offset / job->cluster_size;
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
>> @@ -407,14 +400,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
>>           if (granularity < job->cluster_size) {
>>               bdrv_set_dirty_iter(dbi, cluster * job->cluster_size);
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
>> @@ -456,6 +441,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>>           bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
>>       }
>>   
>> +    job->common.offset = job->common.len -
>> +                         hbitmap_count(job->copy_bitmap) * job->cluster_size;
>> +
>>       bdrv_dirty_iter_free(dbi);
>>   }
>>   
>>
> Anything that makes less lines of code is nice, though, so if we cannot
> reduce the length of the job:
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Thank you!

-- 
Best regards,
Vladimir
