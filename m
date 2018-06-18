Received: from eggs.gnu.org ([2001:4830:134:3::10]:52234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHd-00059W-Ph
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHc-0006R8-EE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:54 +0200
Message-Id: <20180618164504.24488-26-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/35] block/mirror: Wait for in-flight op
 conflicts
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

This patch makes the mirror code differentiate between simply waiting
for any operation to complete (mirror_wait_for_free_in_flight_slot())
and specifically waiting for all operations touching a certain range of
the virtual disk to complete (mirror_wait_on_conflicts()).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180613181823.13618-5-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index e2348b818a..5df6515731 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/coroutine.h"
+#include "qemu/range.h"
 #include "trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
@@ -86,6 +87,7 @@ struct MirrorOp {
      * mirror_co_discard() before yielding for the first time */
     int64_t *bytes_handled;
 
+    bool is_pseudo_op;
     CoQueue waiting_requests;
 
     QTAILQ_ENTRY(MirrorOp) next;
@@ -110,6 +112,41 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
     }
 }
 
+static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
+                                                  MirrorBlockJob *s,
+                                                  uint64_t offset,
+                                                  uint64_t bytes)
+{
+    uint64_t self_start_chunk = offset / s->granularity;
+    uint64_t self_end_chunk = DIV_ROUND_UP(offset + bytes, s->granularity);
+    uint64_t self_nb_chunks = self_end_chunk - self_start_chunk;
+
+    while (find_next_bit(s->in_flight_bitmap, self_end_chunk,
+                         self_start_chunk) < self_end_chunk &&
+           s->ret >= 0)
+    {
+        MirrorOp *op;
+
+        QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
+            uint64_t op_start_chunk = op->offset / s->granularity;
+            uint64_t op_nb_chunks = DIV_ROUND_UP(op->offset + op->bytes,
+                                                 s->granularity) -
+                                    op_start_chunk;
+
+            if (op == self) {
+                continue;
+            }
+
+            if (ranges_overlap(self_start_chunk, self_nb_chunks,
+                               op_start_chunk, op_nb_chunks))
+            {
+                qemu_co_queue_wait(&op->waiting_requests, NULL);
+                break;
+            }
+        }
+    }
+}
+
 static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
@@ -232,13 +269,22 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     return ret;
 }
 
-static inline void mirror_wait_for_io(MirrorBlockJob *s)
+static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
 {
     MirrorOp *op;
 
-    op = QTAILQ_FIRST(&s->ops_in_flight);
-    assert(op);
-    qemu_co_queue_wait(&op->waiting_requests, NULL);
+    QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
+        /* Do not wait on pseudo ops, because it may in turn wait on
+         * some other operation to start, which may in fact be the
+         * caller of this function.  Since there is only one pseudo op
+         * at any given time, we will always find some real operation
+         * to wait on. */
+        if (!op->is_pseudo_op) {
+            qemu_co_queue_wait(&op->waiting_requests, NULL);
+            return;
+        }
+    }
+    abort();
 }
 
 /* Perform a mirror copy operation.
@@ -282,7 +328,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
 
     while (s->buf_free_count < nb_chunks) {
         trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
-        mirror_wait_for_io(s);
+        mirror_wait_for_free_in_flight_slot(s);
     }
 
     /* Now make a QEMUIOVector taking enough granularity-sized chunks
@@ -382,8 +428,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
     BlockDriverState *source = s->source;
-    int64_t offset, first_chunk;
-    uint64_t delay_ns = 0;
+    MirrorOp *pseudo_op;
+    int64_t offset;
+    uint64_t delay_ns = 0, ret = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
@@ -399,11 +446,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     }
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);
 
-    first_chunk = offset / s->granularity;
-    while (test_bit(first_chunk, s->in_flight_bitmap)) {
-        trace_mirror_yield_in_flight(s, offset, s->in_flight);
-        mirror_wait_for_io(s);
-    }
+    mirror_wait_on_conflicts(NULL, s, offset, 1);
 
     job_pause_point(&s->common.job);
 
@@ -440,6 +483,21 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
                                    nb_chunks * s->granularity);
     bdrv_dirty_bitmap_unlock(s->dirty_bitmap);
 
+    /* Before claiming an area in the in-flight bitmap, we have to
+     * create a MirrorOp for it so that conflicting requests can wait
+     * for it.  mirror_perform() will create the real MirrorOps later,
+     * for now we just create a pseudo operation that will wake up all
+     * conflicting requests once all real operations have been
+     * launched. */
+    pseudo_op = g_new(MirrorOp, 1);
+    *pseudo_op = (MirrorOp){
+        .offset         = offset,
+        .bytes          = nb_chunks * s->granularity,
+        .is_pseudo_op   = true,
+    };
+    qemu_co_queue_init(&pseudo_op->waiting_requests);
+    QTAILQ_INSERT_TAIL(&s->ops_in_flight, pseudo_op, next);
+
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
         int ret;
@@ -475,11 +533,12 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
         while (s->in_flight >= MAX_IN_FLIGHT) {
             trace_mirror_yield_in_flight(s, offset, s->in_flight);
-            mirror_wait_for_io(s);
+            mirror_wait_for_free_in_flight_slot(s);
         }
 
         if (s->ret < 0) {
-            return 0;
+            ret = 0;
+            goto fail;
         }
 
         io_bytes = mirror_clip_bytes(s, offset, io_bytes);
@@ -494,7 +553,14 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         nb_chunks -= DIV_ROUND_UP(io_bytes, s->granularity);
         delay_ns = block_job_ratelimit_get_delay(&s->common, io_bytes_acct);
     }
-    return delay_ns;
+
+    ret = delay_ns;
+fail:
+    QTAILQ_REMOVE(&s->ops_in_flight, pseudo_op, next);
+    qemu_co_queue_restart_all(&pseudo_op->waiting_requests);
+    g_free(pseudo_op);
+
+    return ret;
 }
 
 static void mirror_free_init(MirrorBlockJob *s)
@@ -521,7 +587,7 @@ static void mirror_free_init(MirrorBlockJob *s)
 static void mirror_wait_for_all_io(MirrorBlockJob *s)
 {
     while (s->in_flight > 0) {
-        mirror_wait_for_io(s);
+        mirror_wait_for_free_in_flight_slot(s);
     }
 }
 
@@ -676,7 +742,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             if (s->in_flight >= MAX_IN_FLIGHT) {
                 trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
                                    s->in_flight);
-                mirror_wait_for_io(s);
+                mirror_wait_for_free_in_flight_slot(s);
                 continue;
             }
 
@@ -849,7 +915,7 @@ static void coroutine_fn mirror_run(void *opaque)
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
                 trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
-                mirror_wait_for_io(s);
+                mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt != 0) {
                 delay_ns = mirror_iteration(s);
-- 
2.13.6
