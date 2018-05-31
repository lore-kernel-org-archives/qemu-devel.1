Received: from eggs.gnu.org ([2001:4830:134:3::10]:43344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fODQp-0003TI-7C
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fODQj-0001lB-LX
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:35:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 May 2018 10:34:45 +0800
Message-Id: <20180531023445.5923-3-famz@redhat.com>
In-Reply-To: <20180531023445.5923-1-famz@redhat.com>
References: <20180531023445.5923-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

The implementation is similar to the 'qemu-img convert'. In the
beginning of the job, offloaded copy is attempted. If it fails, further
I/O will go through the existing bounce buffer code path.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/backup.c     | 93 +++++++++++++++++++++++++++++++++++-------------------
 block/trace-events |  1 +
 2 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 4e228e959b..ab189693f4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -45,6 +45,8 @@ typedef struct BackupBlockJob {
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
     HBitmap *copy_bitmap;
+    bool use_copy_range;
+    int64_t copy_range_size;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
@@ -111,49 +113,70 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     for (; start < end; start += job->cluster_size) {
+retry:
         if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
             trace_backup_do_cow_skip(job, start);
             continue; /* already copied */
         }
-        hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
 
         trace_backup_do_cow_process(job, start);
 
-        n = MIN(job->cluster_size, job->len - start);
-
-        if (!bounce_buffer) {
-            bounce_buffer = blk_blockalign(blk, job->cluster_size);
-        }
-        iov.iov_base = bounce_buffer;
-        iov.iov_len = n;
-        qemu_iovec_init_external(&bounce_qiov, &iov, 1);
-
-        ret = blk_co_preadv(blk, start, bounce_qiov.size, &bounce_qiov,
-                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
-        if (ret < 0) {
-            trace_backup_do_cow_read_fail(job, start, ret);
-            if (error_is_read) {
-                *error_is_read = true;
+        if (!job->use_copy_range) {
+            hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
+            n = MIN(job->cluster_size, job->len - start);
+            if (!bounce_buffer) {
+                bounce_buffer = blk_blockalign(blk, job->cluster_size);
             }
-            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
-            goto out;
-        }
+            iov.iov_base = bounce_buffer;
+            iov.iov_len = n;
+            qemu_iovec_init_external(&bounce_qiov, &iov, 1);
 
-        if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
-            ret = blk_co_pwrite_zeroes(job->target, start,
-                                       bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
+            ret = blk_co_preadv(blk, start, bounce_qiov.size, &bounce_qiov,
+                                is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+            if (ret < 0) {
+                trace_backup_do_cow_read_fail(job, start, ret);
+                if (error_is_read) {
+                    *error_is_read = true;
+                }
+                hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+                goto out;
+            }
+
+            if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
+                ret = blk_co_pwrite_zeroes(job->target, start,
+                                           bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
+            } else {
+                ret = blk_co_pwritev(job->target, start,
+                                     bounce_qiov.size, &bounce_qiov,
+                                     job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+            }
+            if (ret < 0) {
+                trace_backup_do_cow_write_fail(job, start, ret);
+                if (error_is_read) {
+                    *error_is_read = false;
+                }
+                hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+                goto out;
+            }
         } else {
-            ret = blk_co_pwritev(job->target, start,
-                                 bounce_qiov.size, &bounce_qiov,
-                                 job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
-        }
-        if (ret < 0) {
-            trace_backup_do_cow_write_fail(job, start, ret);
-            if (error_is_read) {
-                *error_is_read = false;
+            int nr_clusters;
+
+            assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+            n = MIN(job->copy_range_size, job->len - start);
+            n = MIN(bytes, n);
+            nr_clusters = DIV_ROUND_UP(n, job->cluster_size);
+            hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
+                          nr_clusters);
+            ret = blk_co_copy_range(blk, start, job->target, start, n,
+                                    is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+            if (ret < 0) {
+                job->use_copy_range = false;
+                trace_backup_do_cow_copy_range_fail(job, start, ret);
+                hbitmap_set(job->copy_bitmap, start / job->cluster_size,
+                            nr_clusters);
+                /* Retry with bounce buffer. */
+                goto retry;
             }
-            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
-            goto out;
         }
 
         /* Publish progress, guest I/O counts as progress too.  Note that the
@@ -665,6 +688,12 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
+    job->use_copy_range = true;
+    job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
+                                        blk_get_max_transfer(job->target));
+    job->copy_range_size = MAX(job->cluster_size,
+                               QEMU_ALIGN_UP(job->copy_range_size,
+                                             job->cluster_size));
 
     /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/trace-events b/block/trace-events
index 2d59b53fd3..c35287b48a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -42,6 +42,7 @@ backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
 backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
+backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
 
 # blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
-- 
2.14.3
