Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAM6-0003FB-Ra
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAM5-0005D7-HC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:18:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:12 +0200
Message-Id: <20180613181823.13618-4-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/14] block/mirror: Use CoQueue to wait on
 in-flight ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

Attach a CoQueue to each in-flight operation so if we need to wait for
any we can use it to wait instead of just blindly yielding and hoping
for some operation to wake us.

A later patch will use this infrastructure to allow requests accessing
the same area of the virtual disk to specifically wait for each other.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 47122482ff..7fb1074c72 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/coroutine.h"
 #include "trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
@@ -33,6 +34,8 @@ typedef struct MirrorBuffer {
     QSIMPLEQ_ENTRY(MirrorBuffer) next;
 } MirrorBuffer;
 
+typedef struct MirrorOp MirrorOp;
+
 typedef struct MirrorBlockJob {
     BlockJob common;
     BlockBackend *target;
@@ -65,15 +68,15 @@ typedef struct MirrorBlockJob {
     unsigned long *in_flight_bitmap;
     int in_flight;
     int64_t bytes_in_flight;
+    QTAILQ_HEAD(MirrorOpList, MirrorOp) ops_in_flight;
     int ret;
     bool unmap;
-    bool waiting_for_io;
     int target_cluster_size;
     int max_iov;
     bool initial_zeroing_ongoing;
 } MirrorBlockJob;
 
-typedef struct MirrorOp {
+struct MirrorOp {
     MirrorBlockJob *s;
     QEMUIOVector qiov;
     int64_t offset;
@@ -82,7 +85,11 @@ typedef struct MirrorOp {
     /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
      * mirror_co_discard() before yielding for the first time */
     int64_t *bytes_handled;
-} MirrorOp;
+
+    CoQueue waiting_requests;
+
+    QTAILQ_ENTRY(MirrorOp) next;
+};
 
 typedef enum MirrorMethod {
     MIRROR_METHOD_COPY,
@@ -123,7 +130,9 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 
     chunk_num = op->offset / s->granularity;
     nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
+
     bitmap_clear(s->in_flight_bitmap, chunk_num, nb_chunks);
+    QTAILQ_REMOVE(&s->ops_in_flight, op, next);
     if (ret >= 0) {
         if (s->cow_bitmap) {
             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
@@ -133,11 +142,9 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
         }
     }
     qemu_iovec_destroy(&op->qiov);
-    g_free(op);
 
-    if (s->waiting_for_io) {
-        qemu_coroutine_enter(s->common.job.co);
-    }
+    qemu_co_queue_restart_all(&op->waiting_requests);
+    g_free(op);
 }
 
 static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
@@ -227,10 +234,11 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
 
 static inline void mirror_wait_for_io(MirrorBlockJob *s)
 {
-    assert(!s->waiting_for_io);
-    s->waiting_for_io = true;
-    qemu_coroutine_yield();
-    s->waiting_for_io = false;
+    MirrorOp *op;
+
+    op = QTAILQ_FIRST(&s->ops_in_flight);
+    assert(op);
+    qemu_co_queue_wait(&op->waiting_requests, NULL);
 }
 
 /* Perform a mirror copy operation.
@@ -340,6 +348,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
         .bytes          = bytes,
         .bytes_handled  = &bytes_handled,
     };
+    qemu_co_queue_init(&op->waiting_requests);
 
     switch (mirror_method) {
     case MIRROR_METHOD_COPY:
@@ -355,6 +364,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
         abort();
     }
 
+    QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
     /* At this point, ownership of op has been moved to the coroutine
      * and the object may already be freed */
@@ -1282,6 +1292,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    QTAILQ_INIT(&s->ops_in_flight);
+
     trace_mirror_start(bs, s, opaque);
     job_start(&s->common.job);
     return;
-- 
2.17.1
