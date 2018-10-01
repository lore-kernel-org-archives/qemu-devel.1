Received: from eggs.gnu.org ([2001:4830:134:3::10]:40632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSi-0005BV-7U
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSe-0002wS-9Q
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:28 +0300
Message-Id: <20181001102928.20533-19-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 18/18] block/backup: use fleecing-hook
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Drop write notifiers and use filter node instead. Changes:

1. copy-before-writes now handled by filter node, so, drop all
   is_write_notifier arguments.

2. we don't have intersecting requests, so their handling is dropped.
Instead, synchronization works as follows:
when backup or fleecing-hook starts copying of some area it firstly
clears copy-bitmap bits, and nobody touches areas, not marked with
dirty bits in copy-bitmap, so there no intersection. Also, read
requests are marked serializing, to not interfer with guest writes and
not read changed data from source (before reading we clear
corresponding bit in copy-bitmap, so, this area is not more handled by
fleecing-hook).

3. To sync with in-flight requests we no just drain hook node, we don't
need rw-lock.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 142 ++++++++++++++++---------------------------------
 1 file changed, 45 insertions(+), 97 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 6cab54dea4..9c85b23d68 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -29,13 +29,6 @@
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 
-typedef struct CowRequest {
-    int64_t start_byte;
-    int64_t end_byte;
-    QLIST_ENTRY(CowRequest) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} CowRequest;
-
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockBackend *target;
@@ -44,13 +37,10 @@ typedef struct BackupBlockJob {
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
 
     BdrvDirtyBitmap *copy_bitmap;
     bool copy_bitmap_created;
@@ -58,53 +48,18 @@ typedef struct BackupBlockJob {
     int64_t copy_range_size;
 
     bool serialize_target_writes;
+
+    BlockDriverState *hook;
+    uint64_t fleecing_hook_progress;
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
@@ -113,7 +68,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     QEMUIOVector qiov;
     BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+    int read_flags = BDRV_REQ_SERIALISING;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(start % job->cluster_size == 0);
@@ -161,15 +116,13 @@ fail:
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
     BlockBackend *blk = job->common.blk;
     int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+    int read_flags = BDRV_REQ_SERIALISING;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
@@ -192,24 +145,18 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
 
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
+    uint64_t fleecing_hook_progress;
 
     start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
 
     trace_backup_do_cow_enter(job, start, offset, bytes);
 
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
     while (start < end) {
         if (!bdrv_get_dirty_locked(NULL, job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
@@ -220,13 +167,13 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
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
@@ -238,7 +185,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
          */
         start += ret;
         job->bytes_read += ret;
-        job_progress_update(&job->common.job, ret);
+        fleecing_hook_progress = bdrv_fleecing_hook_progress(job->hook);
+        job_progress_update(&job->common.job, ret + fleecing_hook_progress -
+                            job->fleecing_hook_progress);
+        job->fleecing_hook_progress = fleecing_hook_progress;
         ret = 0;
     }
 
@@ -246,29 +196,11 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
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
@@ -312,6 +244,8 @@ static void backup_clean(Job *job)
         bdrv_release_dirty_bitmap(blk_bs(s->common.blk), s->copy_bitmap);
         s->copy_bitmap = NULL;
     }
+
+    bdrv_fleecing_hook_drop(s->hook);
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
@@ -396,8 +330,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
             if (yield_and_check(job)) {
                 goto out;
             }
-            ret = backup_do_cow(job, offset,
-                                job->cluster_size, &error_is_read, false);
+            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
             {
@@ -441,9 +374,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     BlockDriverState *bs = blk_bs(s->common.blk);
     int64_t offset;
     int ret = 0;
-
-    QLIST_INIT(&s->inflight_reqs);
-    qemu_co_rwlock_init(&s->flush_rwlock);
+    uint64_t fleecing_hook_progress;
 
     job_progress_set_remaining(job, s->len);
 
@@ -455,15 +386,12 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         bdrv_set_dirty_bitmap(s->copy_bitmap, 0, s->len);
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
+            /* Yield until the job is cancelled.  We just let our fleecing-hook
+             * fileter driver service CbW requests. */
             job_yield(job);
         }
     } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
@@ -514,7 +442,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
                 ret = alloced;
             } else {
                 ret = backup_do_cow(s, offset, s->cluster_size,
-                                    &error_is_read, false);
+                                    &error_is_read);
             }
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
@@ -530,11 +458,13 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         }
     }
 
-    notifier_with_return_remove(&s->before_write);
+    /* wait pending CBW operations in fleecing hook */
+    bdrv_drain(s->hook);
 
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&s->flush_rwlock);
-    qemu_co_rwlock_unlock(&s->flush_rwlock);
+    fleecing_hook_progress = bdrv_fleecing_hook_progress(s->hook);
+    job_progress_update(job, ret + fleecing_hook_progress -
+                        s->fleecing_hook_progress);
+    s->fleecing_hook_progress = fleecing_hook_progress;
 
     return ret;
 }
@@ -573,6 +503,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int64_t cluster_size;
     BdrvDirtyBitmap *copy_bitmap = NULL;
     bool copy_bitmap_created = false;
+    BlockDriverState *hook;
 
     assert(bs);
     assert(target);
@@ -669,6 +600,19 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    /* bdrv_get_device_name will not help to find device name starting from
+     * @bs after fleecing hook append, so let's calculate job_id before. Do
+     * it in the same way like block_job_create
+     */
+    if (job_id == NULL && !(creation_flags & JOB_INTERNAL)) {
+        job_id = bdrv_get_device_name(bs);
+    }
+
+    hook = bdrv_fleecing_hook_append(bs, target, x_copy_bitmap, errp);
+    if (!hook) {
+        return NULL;
+    }
+
     len = bdrv_getlength(bs);
     if (len < 0) {
         error_setg_errno(errp, -len, "unable to get length for '%s'",
@@ -718,6 +662,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     job->len = len;
+    job->hook = hook;
 
     return &job->common;
 
@@ -733,6 +678,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         backup_clean(&job->common.job);
         job_early_fail(&job->common.job);
     }
+    if (hook) {
+        bdrv_fleecing_hook_drop(hook);
+    }
 
     return NULL;
 }
-- 
2.18.0
