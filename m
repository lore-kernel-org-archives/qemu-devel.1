Received: from eggs.gnu.org ([2001:4830:134:3::10]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1faSjw-0003pe-Kd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1faSjv-00051B-1B
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:21:36 -0400
From: John Snow <jsnow@redhat.com>
References: <20180703034655.792039-1-jcody@redhat.com>
	<20180703034655.792039-4-jcody@redhat.com>
	<b2981aa2-c45a-b816-dfb0-fa25b2888be1@redhat.com>
Message-ID: <d5c41d9f-4451-4315-4e80-7f64b1989a85@redhat.com>
Date: Tue, 3 Jul 2018 17:21:23 -0400
MIME-Version: 1.0
In-Reply-To: <b2981aa2-c45a-b816-dfb0-fa25b2888be1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 3/3] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>



On 07/03/2018 12:53 PM, John Snow wrote:
> 
> 
> On 07/02/2018 11:46 PM, Jeff Cody wrote:
>> From: Fam Zheng <famz@redhat.com>
>>
>> The implementation is similar to the 'qemu-img convert'. In the
>> beginning of the job, offloaded copy is attempted. If it fails, further
>> I/O will go through the existing bounce buffer code path.
>>
>> Then, as Kevin pointed out, both this and qemu-img convert can benefit
>> from a local check if one request fails because of, for example, the
>> offset is beyond EOF, but another may well be accepted by the protocol
>> layer. This will be implemented separately.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> Message-id: 20180703023758.14422-4-famz@redhat.com
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---
>>  block/backup.c     | 150 ++++++++++++++++++++++++++++++++-------------
>>  block/trace-events |   1 +
>>  2 files changed, 110 insertions(+), 41 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index d18be40caf..81895ddbe2 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -45,6 +45,8 @@ typedef struct BackupBlockJob {
>>      QLIST_HEAD(, CowRequest) inflight_reqs;
>>  
>>      HBitmap *copy_bitmap;
>> +    bool use_copy_range;
>> +    int64_t copy_range_size;
>>  } BackupBlockJob;
>>  
>>  static const BlockJobDriver backup_job_driver;
>> @@ -86,19 +88,101 @@ static void cow_request_end(CowRequest *req)
>>      qemu_co_queue_restart_all(&req->wait_queue);
>>  }
>>  
>> +/* Copy range to target with a bounce buffer and return the bytes copied. If
>> + * error occured, return a negative error number */
>> +static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
>> +                                                      int64_t start,
>> +                                                      int64_t end,
>> +                                                      bool is_write_notifier,
>> +                                                      bool *error_is_read,
>> +                                                      void **bounce_buffer)
>> +{
>> +    int ret;
>> +    struct iovec iov;
>> +    QEMUIOVector qiov;
>> +    BlockBackend *blk = job->common.blk;
>> +    int nbytes;
>> +
>> +    hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
>> +    nbytes = MIN(job->cluster_size, job->len - start);
>> +    if (!*bounce_buffer) {
>> +        *bounce_buffer = blk_blockalign(blk, job->cluster_size);
>> +    }
>> +    iov.iov_base = *bounce_buffer;
>> +    iov.iov_len = nbytes;
>> +    qemu_iovec_init_external(&qiov, &iov, 1);
>> +
>> +    ret = blk_co_preadv(blk, start, qiov.size, &qiov,
>> +                        is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
>> +    if (ret < 0) {
>> +        trace_backup_do_cow_read_fail(job, start, ret);
>> +        if (error_is_read) {
>> +            *error_is_read = true;
>> +        }
>> +        goto fail;
>> +    }
>> +
>> +    if (qemu_iovec_is_zero(&qiov)) {
>> +        ret = blk_co_pwrite_zeroes(job->target, start,
>> +                                   qiov.size, BDRV_REQ_MAY_UNMAP);
>> +    } else {
>> +        ret = blk_co_pwritev(job->target, start,
>> +                             qiov.size, &qiov,
>> +                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
>> +    }
>> +    if (ret < 0) {
>> +        trace_backup_do_cow_write_fail(job, start, ret);
>> +        if (error_is_read) {
>> +            *error_is_read = false;
>> +        }
>> +        goto fail;
>> +    }
>> +
>> +    return nbytes;
>> +fail:
>> +    hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
>> +    return ret;
>> +
>> +}
>> +
>> +/* Copy range to target and return the bytes copied. If error occured, return a
>> + * negative error number. */
>> +static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
>> +                                                int64_t start,
>> +                                                int64_t end,
>> +                                                bool is_write_notifier)
>> +{
>> +    int ret;
>> +    int nr_clusters;
>> +    BlockBackend *blk = job->common.blk;
>> +    int nbytes;
>> +
>> +    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
>> +    nbytes = MIN(job->copy_range_size, end - start);
>> +    nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
>> +    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
>> +                  nr_clusters);
>> +    ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
>> +                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
>> +    if (ret < 0) {
>> +        trace_backup_do_cow_copy_range_fail(job, start, ret);
>> +        hbitmap_set(job->copy_bitmap, start / job->cluster_size,
>> +                    nr_clusters);
>> +        return ret;
>> +    }
>> +
>> +    return nbytes;
>> +}
>> +
>>  static int coroutine_fn backup_do_cow(BackupBlockJob *job,
>>                                        int64_t offset, uint64_t bytes,
>>                                        bool *error_is_read,
>>                                        bool is_write_notifier)
>>  {
>> -    BlockBackend *blk = job->common.blk;
>>      CowRequest cow_request;
>> -    struct iovec iov;
>> -    QEMUIOVector bounce_qiov;
>> -    void *bounce_buffer = NULL;
>>      int ret = 0;
>>      int64_t start, end; /* bytes */
>> -    int n; /* bytes */
>> +    void *bounce_buffer = NULL;
>>  
>>      qemu_co_rwlock_rdlock(&job->flush_rwlock);
>>  
>> @@ -110,60 +194,38 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
>>      wait_for_overlapping_requests(job, start, end);
>>      cow_request_begin(&cow_request, job, start, end);
>>  
>> -    for (; start < end; start += job->cluster_size) {
>> +    while (start < end) {
>>          if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
>>              trace_backup_do_cow_skip(job, start);
>> +            start += job->cluster_size;
>>              continue; /* already copied */
>>          }
>> -        hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
>>  
>>          trace_backup_do_cow_process(job, start);
>>  
>> -        n = MIN(job->cluster_size, job->len - start);
>> -
>> -        if (!bounce_buffer) {
>> -            bounce_buffer = blk_blockalign(blk, job->cluster_size);
>> -        }
>> -        iov.iov_base = bounce_buffer;
>> -        iov.iov_len = n;
>> -        qemu_iovec_init_external(&bounce_qiov, &iov, 1);
>> -
>> -        ret = blk_co_preadv(blk, start, bounce_qiov.size, &bounce_qiov,
>> -                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
>> -        if (ret < 0) {
>> -            trace_backup_do_cow_read_fail(job, start, ret);
>> -            if (error_is_read) {
>> -                *error_is_read = true;
>> +        if (job->use_copy_range) {
>> +            ret = backup_cow_with_offload(job, start, end, is_write_notifier);
>> +            if (ret < 0) {
>> +                job->use_copy_range = false;
>>              }
>> -            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
>> -            goto out;
>>          }
>> -
>> -        if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
>> -            ret = blk_co_pwrite_zeroes(job->target, start,
>> -                                       bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
>> -        } else {
>> -            ret = blk_co_pwritev(job->target, start,
>> -                                 bounce_qiov.size, &bounce_qiov,
>> -                                 job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
>> +        if (!job->use_copy_range) {
>> +            ret = backup_cow_with_bounce_buffer(job, start, end, is_write_notifier,
>> +                                                error_is_read, &bounce_buffer);
>>          }
>>          if (ret < 0) {
>> -            trace_backup_do_cow_write_fail(job, start, ret);
>> -            if (error_is_read) {
>> -                *error_is_read = false;
>> -            }
>> -            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
>> -            goto out;
>> +            break;
>>          }
>>  
>>          /* Publish progress, guest I/O counts as progress too.  Note that the
>>           * offset field is an opaque progress value, it is not a disk offset.
>>           */
>> -        job->bytes_read += n;
>> -        job_progress_update(&job->common.job, n);
>> +        start += ret;
>> +        job->bytes_read += ret;
>> +        job_progress_update(&job->common.job, ret);
>> +        ret = 0;
>>      }
>>  
>> -out:
>>      if (bounce_buffer) {
>>          qemu_vfree(bounce_buffer);
>>      }
>> @@ -665,6 +727,12 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>>      } else {
>>          job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
>>      }
>> +    job->use_copy_range = true;
>> +    job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
>> +                                        blk_get_max_transfer(job->target));
>> +    job->copy_range_size = MAX(job->cluster_size,
>> +                               QEMU_ALIGN_UP(job->copy_range_size,
>> +                                             job->cluster_size));
>>  
>>      /* Required permissions are already taken with target's blk_new() */
>>      block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
>> diff --git a/block/trace-events b/block/trace-events
>> index 2d59b53fd3..c35287b48a 100644
>> --- a/block/trace-events
>> +++ b/block/trace-events
>> @@ -42,6 +42,7 @@ backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
>>  backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
>>  backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
>>  backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
>> +backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
>>  
>>  # blockdev.c
>>  qmp_block_job_cancel(void *job) "job %p"
>>
> 
> As a head's up, this breaks fleecing test 222. Not sure why just yet.
> 
The idiom is "heads up", not "head's up" ... as a heads up.

This appears to break fleecing test 222 in a fun way; when we go to
verify the reads :

```
    log('')
    log('--- Verifying Data ---')
    log('')

    for p in (patterns + zeroes):
        cmd = "read -P%s %s %s" % p
        log(cmd)
        qemu_io_log('-r', '-f', 'raw', '-c', cmd, nbd_uri)
```

it actually reads zeroes on any region that was overwritten fully or
partially, so these three regions:

patterns = [("0x5d", "0",         "64k"),
            ("0xd5", "1M",        "64k"),
            ("0xdc", "32M",       "64k"),
            ...

all read solid zeroes. Interestingly enough, the files on disk -- the
fleecing node and the base image -- are bit identical to each other.

Reverting this patch fixes the fleecing case, but it can also be fixed
by simply:

```
diff --git a/block/backup.c b/block/backup.c
index 81895ddbe2..85bc3762c5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -727,7 +727,7 @@ BlockJob *backup_job_create(const char *job_id,
BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT,
bdi.cluster_size);
     }
-    job->use_copy_range = true;
+    job->use_copy_range = false;
     job->copy_range_size =
MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
     job->copy_range_size = MAX(job->cluster_size,
```


I haven't gotten any deeper on this just yet, sorry. Will look tonight,
but otherwise I'll see you Thursday after the American holiday.

--js
