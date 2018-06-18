Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHc-00057f-El
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHa-0006Pz-QO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:52 +0200
Message-Id: <20180618164504.24488-24-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/35] block/mirror: Convert to coroutines
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

In order to talk to the source BDS (and maybe in the future to the
target BDS as well) directly, we need to convert our existing AIO
requests into coroutine I/O requests.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180613181823.13618-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 152 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 90 insertions(+), 62 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 043bb7beaf..dcc19ae288 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -78,6 +78,10 @@ typedef struct MirrorOp {
     QEMUIOVector qiov;
     int64_t offset;
     uint64_t bytes;
+
+    /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
+     * mirror_co_discard() before yielding for the first time */
+    int64_t *bytes_handled;
 } MirrorOp;
 
 typedef enum MirrorMethod {
@@ -99,7 +103,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
     }
 }
 
-static void mirror_iteration_done(MirrorOp *op, int ret)
+static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
     struct iovec *iov;
@@ -136,9 +140,8 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
     }
 }
 
-static void mirror_write_complete(void *opaque, int ret)
+static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
 {
-    MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
 
     aio_context_acquire(blk_get_aio_context(s->common.blk));
@@ -155,9 +158,8 @@ static void mirror_write_complete(void *opaque, int ret)
     aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
-static void mirror_read_complete(void *opaque, int ret)
+static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
 {
-    MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
 
     aio_context_acquire(blk_get_aio_context(s->common.blk));
@@ -172,8 +174,9 @@ static void mirror_read_complete(void *opaque, int ret)
 
         mirror_iteration_done(op, ret);
     } else {
-        blk_aio_pwritev(s->target, op->offset, &op->qiov,
-                        0, mirror_write_complete, op);
+        ret = blk_co_pwritev(s->target, op->offset,
+                             op->qiov.size, &op->qiov, 0);
+        mirror_write_complete(op, ret);
     }
     aio_context_release(blk_get_aio_context(s->common.blk));
 }
@@ -230,60 +233,57 @@ static inline void mirror_wait_for_io(MirrorBlockJob *s)
     s->waiting_for_io = false;
 }
 
-/* Submit async read while handling COW.
- * Returns: The number of bytes copied after and including offset,
- *          excluding any bytes copied prior to offset due to alignment.
- *          This will be @bytes if no alignment is necessary, or
- *          (new_end - offset) if tail is rounded up or down due to
- *          alignment or buffer limit.
+/* Perform a mirror copy operation.
+ *
+ * *op->bytes_handled is set to the number of bytes copied after and
+ * including offset, excluding any bytes copied prior to offset due
+ * to alignment.  This will be op->bytes if no alignment is necessary,
+ * or (new_end - op->offset) if the tail is rounded up or down due to
+ * alignment or buffer limit.
  */
-static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
-                               uint64_t bytes)
+static void coroutine_fn mirror_co_read(void *opaque)
 {
+    MirrorOp *op = opaque;
+    MirrorBlockJob *s = op->s;
     BlockBackend *source = s->common.blk;
     int nb_chunks;
     uint64_t ret;
-    MirrorOp *op;
     uint64_t max_bytes;
 
     max_bytes = s->granularity * s->max_iov;
 
     /* We can only handle as much as buf_size at a time. */
-    bytes = MIN(s->buf_size, MIN(max_bytes, bytes));
-    assert(bytes);
-    assert(bytes < BDRV_REQUEST_MAX_BYTES);
-    ret = bytes;
+    op->bytes = MIN(s->buf_size, MIN(max_bytes, op->bytes));
+    assert(op->bytes);
+    assert(op->bytes < BDRV_REQUEST_MAX_BYTES);
+    *op->bytes_handled = op->bytes;
 
     if (s->cow_bitmap) {
-        ret += mirror_cow_align(s, &offset, &bytes);
+        *op->bytes_handled += mirror_cow_align(s, &op->offset, &op->bytes);
     }
-    assert(bytes <= s->buf_size);
+    /* Cannot exceed BDRV_REQUEST_MAX_BYTES + INT_MAX */
+    assert(*op->bytes_handled <= UINT_MAX);
+    assert(op->bytes <= s->buf_size);
     /* The offset is granularity-aligned because:
      * 1) Caller passes in aligned values;
      * 2) mirror_cow_align is used only when target cluster is larger. */
-    assert(QEMU_IS_ALIGNED(offset, s->granularity));
+    assert(QEMU_IS_ALIGNED(op->offset, s->granularity));
     /* The range is sector-aligned, since bdrv_getlength() rounds up. */
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
-    nb_chunks = DIV_ROUND_UP(bytes, s->granularity);
+    assert(QEMU_IS_ALIGNED(op->bytes, BDRV_SECTOR_SIZE));
+    nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
 
     while (s->buf_free_count < nb_chunks) {
-        trace_mirror_yield_in_flight(s, offset, s->in_flight);
+        trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
         mirror_wait_for_io(s);
     }
 
-    /* Allocate a MirrorOp that is used as an AIO callback.  */
-    op = g_new(MirrorOp, 1);
-    op->s = s;
-    op->offset = offset;
-    op->bytes = bytes;
-
     /* Now make a QEMUIOVector taking enough granularity-sized chunks
      * from s->buf_free.
      */
     qemu_iovec_init(&op->qiov, nb_chunks);
     while (nb_chunks-- > 0) {
         MirrorBuffer *buf = QSIMPLEQ_FIRST(&s->buf_free);
-        size_t remaining = bytes - op->qiov.size;
+        size_t remaining = op->bytes - op->qiov.size;
 
         QSIMPLEQ_REMOVE_HEAD(&s->buf_free, next);
         s->buf_free_count--;
@@ -292,53 +292,81 @@ static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
 
     /* Copy the dirty cluster.  */
     s->in_flight++;
-    s->bytes_in_flight += bytes;
-    trace_mirror_one_iteration(s, offset, bytes);
+    s->bytes_in_flight += op->bytes;
+    trace_mirror_one_iteration(s, op->offset, op->bytes);
 
-    blk_aio_preadv(source, offset, &op->qiov, 0, mirror_read_complete, op);
-    return ret;
+    ret = blk_co_preadv(source, op->offset, op->bytes, &op->qiov, 0);
+    mirror_read_complete(op, ret);
 }
 
-static void mirror_do_zero_or_discard(MirrorBlockJob *s,
-                                      int64_t offset,
-                                      uint64_t bytes,
-                                      bool is_discard)
+static void coroutine_fn mirror_co_zero(void *opaque)
 {
-    MirrorOp *op;
+    MirrorOp *op = opaque;
+    int ret;
 
-    /* Allocate a MirrorOp that is used as an AIO callback. The qiov is zeroed
-     * so the freeing in mirror_iteration_done is nop. */
-    op = g_new0(MirrorOp, 1);
-    op->s = s;
-    op->offset = offset;
-    op->bytes = bytes;
+    op->s->in_flight++;
+    op->s->bytes_in_flight += op->bytes;
+    *op->bytes_handled = op->bytes;
 
-    s->in_flight++;
-    s->bytes_in_flight += bytes;
-    if (is_discard) {
-        blk_aio_pdiscard(s->target, offset,
-                         op->bytes, mirror_write_complete, op);
-    } else {
-        blk_aio_pwrite_zeroes(s->target, offset,
-                              op->bytes, s->unmap ? BDRV_REQ_MAY_UNMAP : 0,
-                              mirror_write_complete, op);
-    }
+    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
+                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
+    mirror_write_complete(op, ret);
+}
+
+static void coroutine_fn mirror_co_discard(void *opaque)
+{
+    MirrorOp *op = opaque;
+    int ret;
+
+    op->s->in_flight++;
+    op->s->bytes_in_flight += op->bytes;
+    *op->bytes_handled = op->bytes;
+
+    ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes);
+    mirror_write_complete(op, ret);
 }
 
 static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
                                unsigned bytes, MirrorMethod mirror_method)
 {
+    MirrorOp *op;
+    Coroutine *co;
+    int64_t bytes_handled = -1;
+
+    op = g_new(MirrorOp, 1);
+    *op = (MirrorOp){
+        .s              = s,
+        .offset         = offset,
+        .bytes          = bytes,
+        .bytes_handled  = &bytes_handled,
+    };
+
     switch (mirror_method) {
     case MIRROR_METHOD_COPY:
-        return mirror_do_read(s, offset, bytes);
+        co = qemu_coroutine_create(mirror_co_read, op);
+        break;
     case MIRROR_METHOD_ZERO:
+        co = qemu_coroutine_create(mirror_co_zero, op);
+        break;
     case MIRROR_METHOD_DISCARD:
-        mirror_do_zero_or_discard(s, offset, bytes,
-                                  mirror_method == MIRROR_METHOD_DISCARD);
-        return bytes;
+        co = qemu_coroutine_create(mirror_co_discard, op);
+        break;
     default:
         abort();
     }
+
+    qemu_coroutine_enter(co);
+    /* At this point, ownership of op has been moved to the coroutine
+     * and the object may already be freed */
+
+    /* Assert that this value has been set */
+    assert(bytes_handled >= 0);
+
+    /* Same assertion as in mirror_co_read() (and for mirror_co_read()
+     * and mirror_co_discard(), bytes_handled == op->bytes, which
+     * is the @bytes parameter given to this function) */
+    assert(bytes_handled <= UINT_MAX);
+    return bytes_handled;
 }
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
-- 
2.13.6
