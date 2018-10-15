Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OH-0008LP-C4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OB-00054d-0s
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:45 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:33 +0300
Message-Id: <20181015160633.63130-12-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 11/11] block/backup: use backup-top instead
 of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

Drop write notifiers and use filter node instead. Changes:

1. copy-before-writes now handled by filter node, so, drop all
   is_write_notifier arguments.

2. we don't have intersecting requests, so their handling is dropped.
Instead, synchronization works as follows:
when backup or backup-top starts copying of some area it firstly
clears copy-bitmap bits, and nobody touches areas, not marked with
dirty bits in copy-bitmap, so there is no intersection. Also, backup
job copy operations are surrounded by bdrv region lock, which is
actually serializing request, to not interfer with guest writes and
not read changed data from source (before reading we clear
corresponding bit in copy-bitmap, so, this area is not more handled by
backup-top).

3. To sync with in-flight requests we now just drain hook node, we
don't need rw-lock.

4. After the whole backup loop (top, full, incremental modes), we need
to check for not copied clusters, which were under backup-top operation
and we skipped them, but backup-top operation failed, error returned to
the guest and dirty bits set back.

5. Don't create additional blk, use backup-top children for copy
operations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 278 +++++++++++++++++++++++++------------------------
 1 file changed, 142 insertions(+), 136 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index eda6f22318..6a2f520b28 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -26,105 +26,61 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 
-#define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
+#include "block/backup-top.h"
 
-typedef struct CowRequest {
-    int64_t start_byte;
-    int64_t end_byte;
-    QLIST_ENTRY(CowRequest) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} CowRequest;
+#define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 
 typedef struct BackupBlockJob {
     BlockJob common;
-    BlockBackend *target;
+    BdrvChild *source;
+    BdrvChild *target;
     /* bitmap for sync=incremental */
     BdrvDirtyBitmap *sync_bitmap;
     MirrorSyncMode sync_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
-    CoRwlock flush_rwlock;
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
     bool compress;
-    NotifierWithReturn before_write;
-    QLIST_HEAD(, CowRequest) inflight_reqs;
 
     HBitmap *copy_bitmap;
     bool use_copy_range;
     int64_t copy_range_size;
 
     bool serialize_target_writes;
+
+    BlockDriverState *backup_top;
+    uint64_t backup_top_progress;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
 
-/* See if in-flight requests overlap and wait for them to complete */
-static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
-                                                       int64_t start,
-                                                       int64_t end)
-{
-    CowRequest *req;
-    bool retry;
-
-    do {
-        retry = false;
-        QLIST_FOREACH(req, &job->inflight_reqs, list) {
-            if (end > req->start_byte && start < req->end_byte) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
-                retry = true;
-                break;
-            }
-        }
-    } while (retry);
-}
-
-/* Keep track of an in-flight request */
-static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
-                              int64_t start, int64_t end)
-{
-    req->start_byte = start;
-    req->end_byte = end;
-    qemu_co_queue_init(&req->wait_queue);
-    QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
-}
-
-/* Forget about a completed request */
-static void cow_request_end(CowRequest *req)
-{
-    QLIST_REMOVE(req, list);
-    qemu_co_queue_restart_all(&req->wait_queue);
-}
-
 /* Copy range to target with a bounce buffer and return the bytes copied. If
  * error occurred, return a negative error number */
 static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       int64_t start,
                                                       int64_t end,
-                                                      bool is_write_notifier,
                                                       bool *error_is_read,
                                                       void **bounce_buffer)
 {
     int ret;
     struct iovec iov;
     QEMUIOVector qiov;
-    BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
     nbytes = MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
-        *bounce_buffer = blk_blockalign(blk, job->cluster_size);
+        *bounce_buffer = qemu_blockalign(job->source->bs, job->cluster_size);
     }
     iov.iov_base = *bounce_buffer;
     iov.iov_len = nbytes;
     qemu_iovec_init_external(&qiov, &iov, 1);
 
-    ret = blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
+    ret = bdrv_co_preadv(job->source, start, qiov.size, &qiov, 0);
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -134,12 +90,12 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     }
 
     if (qemu_iovec_is_zero(&qiov)) {
-        ret = blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, write_flags | BDRV_REQ_MAY_UNMAP);
+        ret = bdrv_co_pwrite_zeroes(job->target, start, qiov.size,
+                                    write_flags | BDRV_REQ_MAY_UNMAP);
     } else {
-        ret = blk_co_pwritev(job->target, start,
-                             qiov.size, &qiov, write_flags |
-                             (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
+        ret = bdrv_co_pwritev(job->target, start,
+                              qiov.size, &qiov, write_flags |
+                              (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
     }
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
@@ -159,15 +115,11 @@ fail:
 /* Copy range to target and return the bytes copied. If error occurred, return a
  * negative error number. */
 static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
-                                                int64_t start,
-                                                int64_t end,
-                                                bool is_write_notifier)
+                                                int64_t start, int64_t end)
 {
     int ret;
     int nr_clusters;
-    BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
@@ -175,8 +127,8 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     nbytes = MIN(job->copy_range_size, end - start);
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
     hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_clusters);
-    ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, write_flags);
+    ret = bdrv_co_copy_range(job->source, start, job->target, start, nbytes,
+                             0, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
         hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clusters);
@@ -188,24 +140,18 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
-                                      bool *error_is_read,
-                                      bool is_write_notifier)
+                                      bool *error_is_read)
 {
-    CowRequest cow_request;
     int ret = 0;
     int64_t start, end; /* bytes */
     void *bounce_buffer = NULL;
-
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
+    uint64_t backup_top_progress;
 
     start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
 
     trace_backup_do_cow_enter(job, start, offset, bytes);
 
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
     while (start < end) {
         if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
@@ -216,13 +162,13 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         trace_backup_do_cow_process(job, start);
 
         if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, end, is_write_notifier);
+            ret = backup_cow_with_offload(job, start, end);
             if (ret < 0) {
                 job->use_copy_range = false;
             }
         }
         if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, end, is_write_notifier,
+            ret = backup_cow_with_bounce_buffer(job, start, end,
                                                 error_is_read, &bounce_buffer);
         }
         if (ret < 0) {
@@ -234,7 +180,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
          */
         start += ret;
         job->bytes_read += ret;
-        job_progress_update(&job->common.job, ret);
+        backup_top_progress = bdrv_backup_top_progress(job->backup_top);
+        job_progress_update(&job->common.job, ret + backup_top_progress -
+                            job->backup_top_progress);
+        job->backup_top_progress = backup_top_progress;
         ret = 0;
     }
 
@@ -242,33 +191,15 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         qemu_vfree(bounce_buffer);
     }
 
-    cow_request_end(&cow_request);
-
     trace_backup_do_cow_return(job, offset, bytes, ret);
 
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
-
     return ret;
 }
 
-static int coroutine_fn backup_before_write_notify(
-        NotifierWithReturn *notifier,
-        void *opaque)
-{
-    BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
-    BdrvTrackedRequest *req = opaque;
-
-    assert(req->bs == blk_bs(job->common.blk));
-    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
-
-    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
-    BlockDriverState *bs = blk_bs(job->common.blk);
+    BlockDriverState *bs = job->source->bs;
 
     if (ret < 0) {
         /* Merge the successor back into the parent, delete nothing. */
@@ -300,21 +231,23 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    assert(s->target);
-    blk_unref(s->target);
+
+    /* We must clean it to not crash in backup_drain. */
     s->target = NULL;
 
     if (s->copy_bitmap) {
         hbitmap_free(s->copy_bitmap);
         s->copy_bitmap = NULL;
     }
+
+    bdrv_backup_top_drop(s->backup_top);
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
 
-    blk_set_aio_context(s->target, aio_context);
+    bdrv_set_aio_context(s->target->bs, aio_context);
 }
 
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -340,10 +273,10 @@ static void backup_drain(BlockJob *job)
      * of backup_complete...
      */
     if (s->target) {
-        BlockBackend *target = s->target;
-        blk_ref(target);
-        blk_drain(target);
-        blk_unref(target);
+        BlockDriverState *target = s->target->bs;
+        bdrv_ref(target);
+        bdrv_drain(target);
+        bdrv_unref(target);
     }
 }
 
@@ -386,21 +319,43 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     bool error_is_read;
     int64_t offset;
     HBitmapIter hbi;
+    void *lock = NULL;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((offset = hbitmap_iter_next(&hbi)) != -1) {
+    while (hbitmap_count(job->copy_bitmap)) {
+        offset = hbitmap_iter_next(&hbi);
+        if (offset == -1) {
+            /* we may have skipped some clusters, which were handled by
+             * backup-top, but failed and finished by returning error to
+             * the guest and set dirty bit back.
+             */
+            hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
+            offset = hbitmap_iter_next(&hbi);
+            assert(offset);
+        }
+
+        lock = bdrv_co_try_lock(job->source, offset, job->cluster_size);
+        /* Dirty bit is set, which means that there are no in-flight
+         * write requests on this area. We must succeed.
+         */
+        assert(lock);
+
         do {
             if (yield_and_check(job)) {
+                bdrv_co_unlock(lock);
                 return 0;
             }
-            ret = backup_do_cow(job, offset,
-                                job->cluster_size, &error_is_read, false);
+            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
             {
+                bdrv_co_unlock(lock);
                 return ret;
             }
         } while (ret < 0);
+
+        bdrv_co_unlock(lock);
+        lock = NULL;
     }
 
     return 0;
@@ -432,12 +387,10 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
+    BlockDriverState *bs = s->source->bs;
     int64_t offset;
     int ret = 0;
-
-    QLIST_INIT(&s->inflight_reqs);
-    qemu_co_rwlock_init(&s->flush_rwlock);
+    uint64_t backup_top_progress;
 
     job_progress_set_remaining(job, s->len);
 
@@ -447,26 +400,37 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         hbitmap_set(s->copy_bitmap, 0, s->len);
     }
 
-    s->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
-
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
         /* All bits are set in copy_bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied. */
         while (!job_is_cancelled(job)) {
-            /* Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests. */
+            /* Yield until the job is cancelled.  We just let our backup-top
+             * fileter driver service CbW requests. */
             job_yield(job);
         }
     } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         ret = backup_run_incremental(s);
     } else {
+        bool retry;
+        void *lock;
+
+iteration:
+        retry = false;
+        lock = NULL;
+
         /* Both FULL and TOP SYNC_MODE's require copying.. */
         for (offset = 0; offset < s->len;
              offset += s->cluster_size) {
             bool error_is_read;
             int alloced = 0;
 
+            if (retry) {
+                retry = false;
+            } else if (lock) {
+                bdrv_co_unlock(lock);
+                lock = NULL;
+            }
+
             if (yield_and_check(s)) {
                 break;
             }
@@ -498,6 +462,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
                 /* If the above loop never found any sectors that are in
                  * the topmost image, skip this backup. */
                 if (alloced == 0) {
+                    hbitmap_reset(s->copy_bitmap, offset, s->cluster_size);
                     continue;
                 }
             }
@@ -505,8 +470,19 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
             if (alloced < 0) {
                 ret = alloced;
             } else {
+                if (!hbitmap_get(s->copy_bitmap, offset)) {
+                    trace_backup_do_cow_skip(job, offset);
+                    continue; /* already copied */
+                }
+                if (!lock) {
+                    lock = bdrv_co_try_lock(s->source, offset, s->cluster_size);
+                    /* Dirty bit is set, which means that there are no in-flight
+                     * write requests on this area. We must succeed.
+                     */
+                    assert(lock);
+                }
                 ret = backup_do_cow(s, offset, s->cluster_size,
-                                    &error_is_read, false);
+                                    &error_is_read);
             }
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
@@ -516,17 +492,33 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
                     break;
                 } else {
                     offset -= s->cluster_size;
+                    retry = true;
                     continue;
                 }
             }
         }
+        if (lock) {
+            bdrv_co_unlock(lock);
+            lock = NULL;
+        }
+        if (ret == 0 && !job_is_cancelled(job) &&
+            hbitmap_count(s->copy_bitmap))
+        {
+            /* we may have skipped some clusters, which were handled by
+             * backup-top, but failed and finished by returning error to
+             * the guest and set dirty bit back.
+             */
+            goto iteration;
+        }
     }
 
-    notifier_with_return_remove(&s->before_write);
+    /* wait pending CBW operations in backup-top */
+    bdrv_drain(s->backup_top);
 
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&s->flush_rwlock);
-    qemu_co_rwlock_unlock(&s->flush_rwlock);
+    backup_top_progress = bdrv_backup_top_progress(s->backup_top);
+    job_progress_update(job, ret + backup_top_progress -
+                        s->backup_top_progress);
+    s->backup_top_progress = backup_top_progress;
 
     return ret;
 }
@@ -563,6 +555,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int ret;
     int64_t cluster_size;
     HBitmap *copy_bitmap = NULL;
+    BlockDriverState *backup_top;
+    uint64_t all_except_resize = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
+                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
 
     assert(bs);
     assert(target);
@@ -653,24 +648,29 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
 
+    /* bdrv_get_device_name will not help to find device name starting from
+     * @bs after backup-top append, so let's calculate job_id before. Do
+     * it in the same way like block_job_create
+     */
+    if (job_id == NULL && !(creation_flags & JOB_INTERNAL)) {
+        job_id = bdrv_get_device_name(bs);
+    }
+
+    backup_top = bdrv_backup_top_append(bs, target, copy_bitmap, errp);
+    if (!backup_top) {
+        return NULL;
+    }
+
     /* job->len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, txn, bs,
-                           BLK_PERM_CONSISTENT_READ,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
-                           speed, creation_flags, cb, opaque, errp);
+    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0,
+                           all_except_resize, speed, creation_flags,
+                           cb, opaque, errp);
     if (!job) {
         goto error;
     }
 
-    /* The target must match the source in size, so no resize here either */
-    job->target = blk_new(BLK_PERM_WRITE,
-                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
-    ret = blk_insert_bs(job->target, target, errp);
-    if (ret < 0) {
-        goto error;
-    }
+    job->source = backup_top->backing;
+    job->target = ((BDRVBackupTopState *)backup_top->opaque)->target;
 
     job->on_source_error = on_source_error;
     job->on_target_error = on_target_error;
@@ -685,16 +685,19 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->copy_bitmap = copy_bitmap;
     copy_bitmap = NULL;
     job->use_copy_range = true;
-    job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
-                                        blk_get_max_transfer(job->target));
+    job->copy_range_size =
+            MIN_NON_ZERO(MIN_NON_ZERO(INT_MAX,
+                                      job->source->bs->bl.max_transfer),
+                         job->target->bs->bl.max_transfer);
     job->copy_range_size = MAX(job->cluster_size,
                                QEMU_ALIGN_UP(job->copy_range_size,
                                              job->cluster_size));
 
-    /* Required permissions are already taken with target's blk_new() */
-    block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
+    /* The target must match the source in size, so no resize here either */
+    block_job_add_bdrv(&job->common, "target", target, 0, all_except_resize,
                        &error_abort);
     job->len = len;
+    job->backup_top = backup_top;
 
     return &job->common;
 
@@ -710,6 +713,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         backup_clean(&job->common.job);
         job_early_fail(&job->common.job);
     }
+    if (backup_top) {
+        bdrv_backup_top_drop(backup_top);
+    }
 
     return NULL;
 }
-- 
2.18.0
