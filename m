Received: from eggs.gnu.org ([2001:4830:134:3::10]:53377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TS-0003mk-U6
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TR-0008KT-Lj
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:02 +0200
Message-Id: <20180813022006.7216-14-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 13/17] mirror: Linearize mirror_co_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

This function inlines mirror_read_complete() and mirror_write_complete()
into mirror_co_read() (which is thus renamed to mirror_co_copy()).  In
addition, freeing of the I/O vector is removed from
mirror_iteration_done() and put into an own function mirror_free_qiov()
(which is called by mirror_co_copy()).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 118 ++++++++++++++++++++-----------------------------
 1 file changed, 48 insertions(+), 70 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f3df7dd984..62fd499799 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -154,26 +154,16 @@ static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
     }
 }
 
-static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret,
-                                               QEMUIOVector *qiov)
+static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
-    struct iovec *iov;
     int64_t chunk_num;
-    int i, nb_chunks;
+    int nb_chunks;
 
     trace_mirror_iteration_done(s, op->offset, op->bytes, ret);
 
     s->in_flight--;
     s->bytes_in_flight -= op->bytes;
-    if (qiov) {
-        iov = qiov->iov;
-        for (i = 0; i < qiov->niov; i++) {
-            MirrorBuffer *buf = (MirrorBuffer *) iov[i].iov_base;
-            QSIMPLEQ_INSERT_TAIL(&s->buf_free, buf, next);
-            s->buf_free_count++;
-        }
-    }
 
     chunk_num = op->offset / s->granularity;
     nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
@@ -188,53 +178,11 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret,
             job_progress_update(&s->common.job, op->bytes);
         }
     }
-    if (qiov) {
-        qemu_iovec_destroy(qiov);
-    }
 
     qemu_co_queue_restart_all(&op->waiting_requests);
     g_free(op);
 }
 
-static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret,
-                                               QEMUIOVector *qiov)
-{
-    MirrorBlockJob *s = op->s;
-
-    if (ret < 0) {
-        BlockErrorAction action;
-
-        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
-        action = mirror_error_action(s, false, -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
-            s->ret = ret;
-        }
-    }
-    mirror_iteration_done(op, ret, qiov);
-}
-
-static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret,
-                                              QEMUIOVector *qiov)
-{
-    MirrorBlockJob *s = op->s;
-
-    if (ret < 0) {
-        BlockErrorAction action;
-
-        bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
-        action = mirror_error_action(s, true, -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
-            s->ret = ret;
-        }
-
-        mirror_iteration_done(op, ret, qiov);
-    } else {
-        ret = blk_co_pwritev(s->target, op->offset,
-                             qiov->size, qiov, 0);
-        mirror_write_complete(op, ret, qiov);
-    }
-}
-
 /* Clip bytes relative to offset to not exceed end-of-file */
 static inline int64_t mirror_clip_bytes(MirrorBlockJob *s,
                                         int64_t offset,
@@ -322,6 +270,19 @@ static void coroutine_fn mirror_co_alloc_qiov(MirrorBlockJob *s,
     }
 }
 
+static void mirror_free_qiov(MirrorBlockJob *s, QEMUIOVector *qiov)
+{
+    struct iovec *iov = qiov->iov;
+    int i;
+
+    for (i = 0; i < qiov->niov; i++) {
+        MirrorBuffer *buf = (MirrorBuffer *) iov[i].iov_base;
+        QSIMPLEQ_INSERT_TAIL(&s->buf_free, buf, next);
+        s->buf_free_count++;
+    }
+    qemu_iovec_destroy(qiov);
+}
+
 /*
  * Restrict *bytes to how much we can actually handle, and align the
  * [*offset, *bytes] range to clusters if COW is needed.
@@ -351,24 +312,41 @@ static void mirror_align_for_copy(MirrorBlockJob *s,
     assert(QEMU_IS_ALIGNED(*bytes, BDRV_SECTOR_SIZE));
 }
 
-/* Perform a mirror copy operation. */
-static void coroutine_fn mirror_co_read(void *opaque)
+/*
+ * Perform a mirror copy operation.
+ *
+ * On error, -errno is returned and *failed_on_read is set to the
+ * appropriate value.
+ */
+static int coroutine_fn mirror_co_copy(MirrorBlockJob *s,
+                                       int64_t offset, int64_t bytes,
+                                       bool *failed_on_read)
 {
-    MirrorOp *op = opaque;
-    MirrorBlockJob *s = op->s;
     QEMUIOVector qiov;
-    uint64_t ret;
+    int ret;
 
-    mirror_co_alloc_qiov(s, &qiov, op->offset, op->bytes);
+    mirror_co_alloc_qiov(s, &qiov, offset, bytes);
 
     /* Copy the dirty cluster.  */
     s->in_flight++;
-    s->bytes_in_flight += op->bytes;
-    trace_mirror_one_iteration(s, op->offset, op->bytes);
+    s->bytes_in_flight += bytes;
+    trace_mirror_one_iteration(s, offset, bytes);
+
+    ret = bdrv_co_preadv(s->mirror_top_bs->backing, offset, bytes, &qiov, 0);
+    if (ret < 0) {
+        *failed_on_read = true;
+        goto fail;
+    }
 
-    ret = bdrv_co_preadv(s->mirror_top_bs->backing, op->offset, op->bytes,
-                         &qiov, 0);
-    mirror_read_complete(op, ret, &qiov);
+    ret = blk_co_pwritev(s->target, offset, bytes, &qiov, 0);
+    if (ret < 0) {
+        *failed_on_read = false;
+        goto fail;
+    }
+
+fail:
+    mirror_free_qiov(s, &qiov);
+    return ret;
 }
 
 static int coroutine_fn mirror_co_zero(MirrorBlockJob *s,
@@ -395,6 +373,7 @@ static void coroutine_fn mirror_co_perform(void *opaque)
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
     AioContext *aio_context;
+    bool failed_on_read = false;
     int ret;
 
     aio_context = blk_get_aio_context(s->common.blk);
@@ -402,8 +381,8 @@ static void coroutine_fn mirror_co_perform(void *opaque)
 
     switch (op->mirror_method) {
     case MIRROR_METHOD_COPY:
-        mirror_co_read(opaque);
-        goto done;
+        ret = mirror_co_copy(s, op->offset, op->bytes, &failed_on_read);
+        break;
     case MIRROR_METHOD_ZERO:
         ret = mirror_co_zero(s, op->offset, op->bytes);
         break;
@@ -418,15 +397,14 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         BlockErrorAction action;
 
         bdrv_set_dirty_bitmap(s->dirty_bitmap, op->offset, op->bytes);
-        action = mirror_error_action(s, false, -ret);
+        action = mirror_error_action(s, failed_on_read, -ret);
         if (action == BLOCK_ERROR_ACTION_REPORT && s->ret >= 0) {
             s->ret = ret;
         }
     }
 
-    mirror_iteration_done(op, ret, NULL);
+    mirror_iteration_done(op, ret);
 
-done:
     aio_context_release(aio_context);
 }
 
-- 
2.17.1
