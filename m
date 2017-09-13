Received: from eggs.gnu.org ([2001:4830:134:3::10]:36762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGw-0008LA-G5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGv-0005FA-7y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:20:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:18:58 +0200
Message-Id: <20170913181910.29688-7-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 06/18] block/mirror: Use CoQueue to wait on
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Attach a CoQueue to each in-flight operation so if we need to wait for
any we can use it to wait instead of just blindly yielding and hoping
for some operation to wake us.

A later patch will use this infrastructure to allow requests accessing
the same area of the virtual disk to specifically wait for each other.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2b3297aa61..81253fbad1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/coroutine.h"
 #include "trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
@@ -34,6 +35,8 @@ typedef struct MirrorBuffer {
     QSIMPLEQ_ENTRY(MirrorBuffer) next;
 } MirrorBuffer;
 
+typedef struct MirrorOp MirrorOp;
+
 typedef struct MirrorBlockJob {
     BlockJob common;
     RateLimit limit;
@@ -67,15 +70,15 @@ typedef struct MirrorBlockJob {
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
@@ -83,7 +86,11 @@ typedef struct MirrorOp {
 
     /* Set by mirror_co_read() before yielding for the first time */
     uint64_t bytes_copied;
-} MirrorOp;
+
+    CoQueue waiting_requests;
+
+    QTAILQ_ENTRY(MirrorOp) next;
+};
 
 typedef enum MirrorMethod {
     MIRROR_METHOD_COPY,
@@ -124,7 +131,9 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 
     chunk_num = op->offset / s->granularity;
     nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
+
     bitmap_clear(s->in_flight_bitmap, chunk_num, nb_chunks);
+    QTAILQ_REMOVE(&s->ops_in_flight, op, next);
     if (ret >= 0) {
         if (s->cow_bitmap) {
             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
@@ -134,11 +143,9 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
         }
     }
     qemu_iovec_destroy(&op->qiov);
-    g_free(op);
 
-    if (s->waiting_for_io) {
-        qemu_coroutine_enter(s->common.co);
-    }
+    qemu_co_queue_restart_all(&op->waiting_requests);
+    g_free(op);
 }
 
 static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
@@ -233,10 +240,11 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
 
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
 
 /* Submit async read while handling COW.
@@ -342,6 +350,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
         .offset = offset,
         .bytes  = bytes,
     };
+    qemu_co_queue_init(&op->waiting_requests);
 
     switch (mirror_method) {
     case MIRROR_METHOD_COPY:
@@ -357,6 +366,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
         abort();
     }
 
+    QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
 
     if (mirror_method == MIRROR_METHOD_COPY) {
@@ -1292,6 +1302,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    QTAILQ_INIT(&s->ops_in_flight);
+
     trace_mirror_start(bs, s, opaque);
     block_job_start(&s->common);
     return;
-- 
2.13.5
