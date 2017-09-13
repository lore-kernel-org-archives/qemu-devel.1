Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCIT-00019T-L2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCIR-0006aX-HP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:07 +0200
Message-Id: <20170913181910.29688-16-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 15/18] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This patch implements active synchronous mirroring.  In active mode, the
passive mechanism will still be in place and is used to copy all
initially dirty clusters off the source disk; but every write request
will write data both to the source and the target disk, so the source
cannot be dirtied faster than data is mirrored to the target.  Also,
once the block job has converged (BLOCK_JOB_READY sent), source and
target are guaranteed to stay in sync (unless an error occurs).

Optionally, dirty data can be copied to the target disk on read
operations, too.

Active mode is completely optional and currently disabled at runtime.  A
later patch will add a way for users to enable it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  23 +++++++
 block/mirror.c       | 187 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 205 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index bb11815608..e072cfa67c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -938,6 +938,29 @@
   'data': ['top', 'full', 'none', 'incremental'] }
 
 ##
+# @MirrorCopyMode:
+#
+# An enumeration whose values tell the mirror block job when to
+# trigger writes to the target.
+#
+# @passive: copy data in background only.
+#
+# @active-write: when data is written to the source, write it
+#                (synchronously) to the target as well.  In addition,
+#                data is copied in background just like in @passive
+#                mode.
+#
+# @active-read-write: write data to the target (synchronously) both
+#                     when it is read from and written to the source.
+#                     In addition, data is copied in background just
+#                     like in @passive mode.
+#
+# Since: 2.11
+##
+{ 'enum': 'MirrorCopyMode',
+  'data': ['passive', 'active-write', 'active-read-write'] }
+
+##
 # @BlockJobType:
 #
 # Type of a block job.
diff --git a/block/mirror.c b/block/mirror.c
index 8fea619a68..c429aa77bb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -54,8 +54,12 @@ typedef struct MirrorBlockJob {
     Error *replace_blocker;
     bool is_none_mode;
     BlockMirrorBackingMode backing_mode;
+    MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
     bool synced;
+    /* Set when the target is synced (dirty bitmap is clean, nothing
+     * in flight) and the job is running in active mode */
+    bool actively_synced;
     bool should_complete;
     int64_t granularity;
     size_t buf_size;
@@ -77,6 +81,7 @@ typedef struct MirrorBlockJob {
     int target_cluster_size;
     int max_iov;
     bool initial_zeroing_ongoing;
+    int in_active_write_counter;
 
     /* Signals that we are no longer accessing source and target and the mirror
      * BDS should thus relinquish all permissions */
@@ -112,6 +117,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
                                             int error)
 {
     s->synced = false;
+    s->actively_synced = false;
     if (read) {
         return block_job_error_action(&s->common, s->on_source_error,
                                       true, error);
@@ -283,13 +289,12 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     return ret;
 }
 
-static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
+static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
 {
     MirrorOp *op;
 
     QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
-        if (!op->is_active_write) {
-            /* Only non-active operations use up in-flight slots */
+        if (op->is_active_write == active) {
             qemu_co_queue_wait(&op->waiting_requests, NULL);
             return;
         }
@@ -297,6 +302,12 @@ static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
     abort();
 }
 
+static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
+{
+    /* Only non-active operations use up in-flight slots */
+    mirror_wait_for_any_operation(s, false);
+}
+
 /* Submit async read while handling COW.
  * Returns: The number of bytes copied after and including offset,
  *          excluding any bytes copied prior to offset due to alignment.
@@ -861,6 +872,7 @@ static void coroutine_fn mirror_run(void *opaque)
         /* Report BLOCK_JOB_READY and wait for complete. */
         block_job_event_ready(&s->common);
         s->synced = true;
+        s->actively_synced = true;
         while (!block_job_is_cancelled(&s->common) && !s->should_complete) {
             block_job_yield(&s->common);
         }
@@ -912,6 +924,12 @@ static void coroutine_fn mirror_run(void *opaque)
         int64_t cnt, delta;
         bool should_complete;
 
+        /* Do not start passive operations while there are active
+         * writes in progress */
+        while (s->in_active_write_counter) {
+            mirror_wait_for_any_operation(s, true);
+        }
+
         if (s->ret < 0) {
             ret = s->ret;
             goto immediate_exit;
@@ -961,6 +979,9 @@ static void coroutine_fn mirror_run(void *opaque)
                  */
                 block_job_event_ready(&s->common);
                 s->synced = true;
+                if (s->copy_mode != MIRROR_COPY_MODE_PASSIVE) {
+                    s->actively_synced = true;
+                }
             }
 
             should_complete = s->should_complete ||
@@ -1195,16 +1216,171 @@ static BdrvChildRole source_child_role = {
     .drained_end        = source_child_cb_drained_end,
 };
 
+static void do_sync_target_write(MirrorBlockJob *job, uint64_t offset,
+                                 uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    BdrvDirtyBitmapIter *iter;
+    QEMUIOVector target_qiov;
+    uint64_t dirty_offset;
+    int dirty_bytes;
+
+    qemu_iovec_init(&target_qiov, qiov->niov);
+
+    iter = bdrv_dirty_iter_new(job->dirty_bitmap, offset >> BDRV_SECTOR_BITS);
+
+    while (true) {
+        bool valid_area;
+        int ret;
+
+        bdrv_dirty_bitmap_lock(job->dirty_bitmap);
+        valid_area = bdrv_dirty_iter_next_area(iter, offset + bytes,
+                                               &dirty_offset, &dirty_bytes);
+        bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
+        if (!valid_area) {
+            break;
+        }
+
+        job->common.len += dirty_bytes;
+
+        assert(dirty_offset - offset <= SIZE_MAX);
+        if (qiov) {
+            qemu_iovec_reset(&target_qiov);
+            qemu_iovec_concat(&target_qiov, qiov,
+                              dirty_offset - offset, dirty_bytes);
+        }
+
+        ret = blk_co_pwritev(job->target, dirty_offset, dirty_bytes,
+                             qiov ? &target_qiov : NULL, flags);
+        if (ret >= 0) {
+            assert(dirty_offset % BDRV_SECTOR_SIZE == 0);
+            assert(dirty_bytes % BDRV_SECTOR_SIZE == 0);
+            bdrv_reset_dirty_bitmap(job->dirty_bitmap,
+                                    dirty_offset >> BDRV_SECTOR_BITS,
+                                    dirty_bytes >> BDRV_SECTOR_BITS);
+
+            job->common.offset += dirty_bytes;
+        } else {
+            BlockErrorAction action;
+
+            action = mirror_error_action(job, false, -ret);
+            if (action == BLOCK_ERROR_ACTION_REPORT) {
+                if (!job->ret) {
+                    job->ret = ret;
+                }
+                break;
+            }
+        }
+    }
+
+    bdrv_dirty_iter_free(iter);
+    qemu_iovec_destroy(&target_qiov);
+}
+
+static MirrorOp *coroutine_fn active_write_prepare(MirrorBlockJob *s,
+                                                   uint64_t offset,
+                                                   uint64_t bytes)
+{
+    MirrorOp *op;
+    uint64_t start_chunk = offset / s->granularity;
+    uint64_t end_chunk = DIV_ROUND_UP(offset + bytes, s->granularity);
+
+    op = g_new(MirrorOp, 1);
+    *op = (MirrorOp){
+        .s                  = s,
+        .offset             = offset,
+        .bytes              = bytes,
+        .is_active_write    = true,
+    };
+    qemu_co_queue_init(&op->waiting_requests);
+    QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
+
+    s->in_active_write_counter++;
+
+    mirror_wait_on_conflicts(op, s, offset, bytes);
+
+    bitmap_set(s->in_flight_bitmap, start_chunk, end_chunk - start_chunk);
+
+    return op;
+}
+
+static void coroutine_fn active_write_settle(MirrorOp *op)
+{
+    uint64_t start_chunk = op->offset / op->s->granularity;
+    uint64_t end_chunk = DIV_ROUND_UP(op->offset + op->bytes,
+                                      op->s->granularity);
+
+    if (!--op->s->in_active_write_counter && op->s->actively_synced) {
+        /* Assert that we are back in sync once all active write
+         * operations are settled */
+        assert(!bdrv_get_dirty_count(op->s->dirty_bitmap));
+    }
+    bitmap_clear(op->s->in_flight_bitmap, start_chunk, end_chunk - start_chunk);
+    QTAILQ_REMOVE(&op->s->ops_in_flight, op, next);
+    qemu_co_queue_restart_all(&op->waiting_requests);
+    g_free(op);
+}
+
 static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
     uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+    MirrorOp *op = NULL;
+    MirrorBDSOpaque *s = bs->opaque;
+    int ret = 0;
+    bool copy_to_target;
+
+    copy_to_target = s->job->ret >= 0 &&
+                     s->job->copy_mode == MIRROR_COPY_MODE_ACTIVE_READ_WRITE;
+
+    if (copy_to_target) {
+        op = active_write_prepare(s->job, offset, bytes);
+    }
+
+    ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (copy_to_target) {
+        do_sync_target_write(s->job, offset, bytes, qiov, 0);
+    }
+
+out:
+    if (copy_to_target) {
+        active_write_settle(op);
+    }
+    return ret;
 }
 
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
     uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+    MirrorOp *op = NULL;
+    MirrorBDSOpaque *s = bs->opaque;
+    int ret = 0;
+    bool copy_to_target;
+
+    copy_to_target = s->job->ret >= 0 &&
+                     (s->job->copy_mode == MIRROR_COPY_MODE_ACTIVE_WRITE ||
+                      s->job->copy_mode == MIRROR_COPY_MODE_ACTIVE_READ_WRITE);
+
+    if (copy_to_target) {
+        op = active_write_prepare(s->job, offset, bytes);
+    }
+
+    ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (copy_to_target) {
+        do_sync_target_write(s->job, offset, bytes, qiov, flags);
+    }
+
+out:
+    if (copy_to_target) {
+        active_write_settle(op);
+    }
+    return ret;
 }
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
@@ -1398,6 +1574,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->on_target_error = on_target_error;
     s->is_none_mode = is_none_mode;
     s->backing_mode = backing_mode;
+    s->copy_mode = MIRROR_COPY_MODE_PASSIVE;
     s->base = base;
     s->granularity = granularity;
     s->buf_size = ROUND_UP(buf_size, granularity);
-- 
2.13.5
