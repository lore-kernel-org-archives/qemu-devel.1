Received: from eggs.gnu.org ([2001:4830:134:3::10]:53094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2T3-0003Qf-Sc
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2T2-0007vY-QE
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:53 +0200
Message-Id: <20180813022006.7216-5-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 04/17] mirror: Remove bytes_handled, part 1
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

By moving the mirror_align_for_copy() call from mirror_co_read() to
mirror_perform(), we can drop bytes_handled from MirrorOp.

mirror_align_for_copy() takes a uint64_t * for @bytes, so this commit
changes mirror_perform()'s @bytes parameter to uint64_t, too; but it
still asserts that its value does not exceed UINT_MAX (necessary because
it may be assigned to bytes_handled, which is returned and may thus not
exceed UINT_MAX).  This assertion is removed in a later patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 34cb8293b2..3234b8b687 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -91,10 +91,6 @@ struct MirrorOp {
     int64_t offset;
     uint64_t bytes;
 
-    /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
-     * mirror_co_discard() before yielding for the first time */
-    int64_t *bytes_handled;
-
     bool is_pseudo_op;
     bool is_active_write;
     CoQueue waiting_requests;
@@ -343,14 +339,7 @@ static void mirror_align_for_copy(MirrorBlockJob *s,
     assert(QEMU_IS_ALIGNED(*bytes, BDRV_SECTOR_SIZE));
 }
 
-/* Perform a mirror copy operation.
- *
- * *op->bytes_handled is set to the number of bytes copied after and
- * including offset, excluding any bytes copied prior to offset due
- * to alignment.  This will be op->bytes if no alignment is necessary,
- * or (new_end - op->offset) if the tail is rounded up or down due to
- * alignment or buffer limit.
- */
+/* Perform a mirror copy operation. */
 static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
@@ -358,7 +347,6 @@ static void coroutine_fn mirror_co_read(void *opaque)
     int nb_chunks;
     uint64_t ret;
 
-    mirror_align_for_copy(s, &op->offset, &op->bytes, op->bytes_handled);
     nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
 
     while (s->buf_free_count < nb_chunks) {
@@ -396,7 +384,6 @@ static void coroutine_fn mirror_co_zero(void *opaque)
 
     op->s->in_flight++;
     op->s->bytes_in_flight += op->bytes;
-    *op->bytes_handled = op->bytes;
 
     ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
                                op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
@@ -410,25 +397,33 @@ static void coroutine_fn mirror_co_discard(void *opaque)
 
     op->s->in_flight++;
     op->s->bytes_in_flight += op->bytes;
-    *op->bytes_handled = op->bytes;
 
     ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes);
     mirror_write_complete(op, ret);
 }
 
 static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
-                               unsigned bytes, MirrorMethod mirror_method)
+                               uint64_t bytes, MirrorMethod mirror_method)
 {
     MirrorOp *op;
     Coroutine *co;
-    int64_t bytes_handled = -1;
+    int64_t bytes_handled;
+
+    /* FIXME: Drop this assertion */
+    assert(bytes <= UINT_MAX);
+
+    if (mirror_method == MIRROR_METHOD_COPY) {
+        mirror_align_for_copy(s, &offset, &bytes, &bytes_handled);
+        assert(bytes_handled <= UINT_MAX);
+    } else {
+        bytes_handled = bytes;
+    }
 
     op = g_new(MirrorOp, 1);
     *op = (MirrorOp){
         .s              = s,
         .offset         = offset,
         .bytes          = bytes,
-        .bytes_handled  = &bytes_handled,
     };
     qemu_co_queue_init(&op->waiting_requests);
 
@@ -448,16 +443,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 
     QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
-    /* At this point, ownership of op has been moved to the coroutine
-     * and the object may already be freed */
-
-    /* Assert that this value has been set */
-    assert(bytes_handled >= 0);
 
-    /* Same assertion as in mirror_co_read() (and for mirror_co_read()
-     * and mirror_co_discard(), bytes_handled == op->bytes, which
-     * is the @bytes parameter given to this function) */
-    assert(bytes_handled <= UINT_MAX);
     return bytes_handled;
 }
 
-- 
2.17.1
