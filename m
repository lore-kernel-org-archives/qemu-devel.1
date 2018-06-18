Received: from eggs.gnu.org ([2001:4830:134:3::10]:52412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHm-0005L5-Fk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHk-0006Ya-Lz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:45:02 +0200
Message-Id: <20180618164504.24488-34-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 33/35] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This patch implements active synchronous mirroring.  In active mode, the
passive mechanism will still be in place and is used to copy all
initially dirty clusters off the source disk; but every write request
will write data both to the source and the target disk, so the source
cannot be dirtied faster than data is mirrored to the target.  Also,
once the block job has converged (BLOCK_JOB_READY sent), source and
target are guaranteed to stay in sync (unless an error occurs).

Active mode is completely optional and currently disabled at runtime.  A
later patch will add a way for users to enable it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180613181823.13618-13-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  18 ++++
 block/mirror.c       | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 265 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab629d1647..96f8da1322 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1051,6 +1051,24 @@
   'data': ['top', 'full', 'none', 'incremental'] }
 
 ##
+# @MirrorCopyMode:
+#
+# An enumeration whose values tell the mirror block job when to
+# trigger writes to the target.
+#
+# @background: copy data in background only.
+#
+# @write-blocking: when data is written to the source, write it
+#                  (synchronously) to the target as well.  In
+#                  addition, data is copied in background just like in
+#                  @background mode.
+#
+# Since: 3.0
+##
+{ 'enum': 'MirrorCopyMode',
+  'data': ['background', 'write-blocking'] }
+
+##
 # @BlockJobInfo:
 #
 # Information about a long-running block device operation.
diff --git a/block/mirror.c b/block/mirror.c
index 7da5e43c0d..99b9b92c30 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -51,8 +51,12 @@ typedef struct MirrorBlockJob {
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
@@ -74,6 +78,7 @@ typedef struct MirrorBlockJob {
     int target_cluster_size;
     int max_iov;
     bool initial_zeroing_ongoing;
+    int in_active_write_counter;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -91,6 +96,7 @@ struct MirrorOp {
     int64_t *bytes_handled;
 
     bool is_pseudo_op;
+    bool is_active_write;
     CoQueue waiting_requests;
 
     QTAILQ_ENTRY(MirrorOp) next;
@@ -106,6 +112,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
                                             int error)
 {
     s->synced = false;
+    s->actively_synced = false;
     if (read) {
         return block_job_error_action(&s->common, s->on_source_error,
                                       true, error);
@@ -272,7 +279,7 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     return ret;
 }
 
-static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
+static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
 {
     MirrorOp *op;
 
@@ -282,7 +289,7 @@ static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
          * caller of this function.  Since there is only one pseudo op
          * at any given time, we will always find some real operation
          * to wait on. */
-        if (!op->is_pseudo_op) {
+        if (!op->is_pseudo_op && op->is_active_write == active) {
             qemu_co_queue_wait(&op->waiting_requests, NULL);
             return;
         }
@@ -290,6 +297,12 @@ static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
     abort();
 }
 
+static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
+{
+    /* Only non-active operations use up in-flight slots */
+    mirror_wait_for_any_operation(s, false);
+}
+
 /* Perform a mirror copy operation.
  *
  * *op->bytes_handled is set to the number of bytes copied after and
@@ -846,6 +859,7 @@ static void coroutine_fn mirror_run(void *opaque)
         /* Transition to the READY state and wait for complete. */
         job_transition_to_ready(&s->common.job);
         s->synced = true;
+        s->actively_synced = true;
         while (!job_is_cancelled(&s->common.job) && !s->should_complete) {
             job_yield(&s->common.job);
         }
@@ -897,6 +911,12 @@ static void coroutine_fn mirror_run(void *opaque)
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
@@ -942,6 +962,9 @@ static void coroutine_fn mirror_run(void *opaque)
                  */
                 job_transition_to_ready(&s->common.job);
                 s->synced = true;
+                if (s->copy_mode != MIRROR_COPY_MODE_BACKGROUND) {
+                    s->actively_synced = true;
+                }
             }
 
             should_complete = s->should_complete ||
@@ -1140,16 +1163,232 @@ static const BlockJobDriver commit_active_job_driver = {
     .drain                  = mirror_drain,
 };
 
+static void do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, int flags)
+{
+    BdrvDirtyBitmapIter *iter;
+    QEMUIOVector target_qiov;
+    uint64_t dirty_offset;
+    int dirty_bytes;
+
+    if (qiov) {
+        qemu_iovec_init(&target_qiov, qiov->niov);
+    }
+
+    iter = bdrv_dirty_iter_new(job->dirty_bitmap);
+    bdrv_set_dirty_iter(iter, offset);
+
+    while (true) {
+        bool valid_area;
+        int ret;
+
+        bdrv_dirty_bitmap_lock(job->dirty_bitmap);
+        valid_area = bdrv_dirty_iter_next_area(iter, offset + bytes,
+                                               &dirty_offset, &dirty_bytes);
+        if (!valid_area) {
+            bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
+            break;
+        }
+
+        bdrv_reset_dirty_bitmap_locked(job->dirty_bitmap,
+                                       dirty_offset, dirty_bytes);
+        bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
+
+        job_progress_increase_remaining(&job->common.job, dirty_bytes);
+
+        assert(dirty_offset - offset <= SIZE_MAX);
+        if (qiov) {
+            qemu_iovec_reset(&target_qiov);
+            qemu_iovec_concat(&target_qiov, qiov,
+                              dirty_offset - offset, dirty_bytes);
+        }
+
+        switch (method) {
+        case MIRROR_METHOD_COPY:
+            ret = blk_co_pwritev(job->target, dirty_offset, dirty_bytes,
+                                 qiov ? &target_qiov : NULL, flags);
+            break;
+
+        case MIRROR_METHOD_ZERO:
+            assert(!qiov);
+            ret = blk_co_pwrite_zeroes(job->target, dirty_offset, dirty_bytes,
+                                       flags);
+            break;
+
+        case MIRROR_METHOD_DISCARD:
+            assert(!qiov);
+            ret = blk_co_pdiscard(job->target, dirty_offset, dirty_bytes);
+            break;
+
+        default:
+            abort();
+        }
+
+        if (ret >= 0) {
+            job_progress_update(&job->common.job, dirty_bytes);
+        } else {
+            BlockErrorAction action;
+
+            bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_offset, dirty_bytes);
+            job->actively_synced = false;
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
+    if (qiov) {
+        qemu_iovec_destroy(&target_qiov);
+    }
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
+        BdrvChild *source = op->s->mirror_top_bs->backing;
+
+        if (QLIST_FIRST(&source->bs->parents) == source &&
+            QLIST_NEXT(source, next_parent) == NULL)
+        {
+            /* Assert that we are back in sync once all active write
+             * operations are settled.
+             * Note that we can only assert this if the mirror node
+             * is the source node's only parent. */
+            assert(!bdrv_get_dirty_count(op->s->dirty_bitmap));
+        }
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
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
+static int coroutine_fn bdrv_mirror_top_do_write(BlockDriverState *bs,
+    MirrorMethod method, uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
+    int flags)
+{
+    MirrorOp *op = NULL;
+    MirrorBDSOpaque *s = bs->opaque;
+    int ret = 0;
+    bool copy_to_target;
+
+    copy_to_target = s->job->ret >= 0 &&
+                     s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
+
+    if (copy_to_target) {
+        op = active_write_prepare(s->job, offset, bytes);
+    }
+
+    switch (method) {
+    case MIRROR_METHOD_COPY:
+        ret = bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+        break;
+
+    case MIRROR_METHOD_ZERO:
+        ret = bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+        break;
+
+    case MIRROR_METHOD_DISCARD:
+        ret = bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
+        break;
+
+    default:
+        abort();
+    }
+
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (copy_to_target) {
+        do_sync_target_write(s->job, method, offset, bytes, qiov, flags);
+    }
+
+out:
+    if (copy_to_target) {
+        active_write_settle(op);
+    }
+    return ret;
+}
+
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
     uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+    MirrorBDSOpaque *s = bs->opaque;
+    QEMUIOVector bounce_qiov;
+    void *bounce_buf;
+    int ret = 0;
+    bool copy_to_target;
+
+    copy_to_target = s->job->ret >= 0 &&
+                     s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
+
+    if (copy_to_target) {
+        /* The guest might concurrently modify the data to write; but
+         * the data on source and destination must match, so we have
+         * to use a bounce buffer if we are going to write to the
+         * target now. */
+        bounce_buf = qemu_blockalign(bs, bytes);
+        iov_to_buf_full(qiov->iov, qiov->niov, 0, bounce_buf, bytes);
+
+        qemu_iovec_init(&bounce_qiov, 1);
+        qemu_iovec_add(&bounce_qiov, bounce_buf, bytes);
+        qiov = &bounce_qiov;
+    }
+
+    ret = bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, offset, bytes, qiov,
+                                   flags);
+
+    if (copy_to_target) {
+        qemu_iovec_destroy(&bounce_qiov);
+        qemu_vfree(bounce_buf);
+    }
+
+    return ret;
 }
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
@@ -1164,13 +1403,15 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, offset, bytes, NULL,
+                                    flags);
 }
 
 static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
     int64_t offset, int bytes)
 {
-    return bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
+    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_DISCARD, offset, bytes,
+                                    NULL, 0);
 }
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
@@ -1340,6 +1581,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->on_target_error = on_target_error;
     s->is_none_mode = is_none_mode;
     s->backing_mode = backing_mode;
+    s->copy_mode = MIRROR_COPY_MODE_BACKGROUND;
     s->base = base;
     s->granularity = granularity;
     s->buf_size = ROUND_UP(buf_size, granularity);
-- 
2.13.6
