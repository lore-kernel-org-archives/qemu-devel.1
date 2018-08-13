Received: from eggs.gnu.org ([2001:4830:134:3::10]:53281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TK-0003de-FP
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TJ-0008Gw-GN
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:59 +0200
Message-Id: <20180813022006.7216-11-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 10/17] mirror: Create mirror_co_alloc_qiov()
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

By pulling this function out of mirror_co_read(), the latter becomes
simpler.  This is important so the following patches can make it more
complicated again.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 6330269156..2a131d8b99 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -293,6 +293,29 @@ static inline void coroutine_fn
     mirror_co_wait_for_any_operation(s, false);
 }
 
+/* Allocate a QEMUIOVector from the mirror buffer pool (s->buf_free) */
+static void coroutine_fn mirror_co_alloc_qiov(MirrorBlockJob *s,
+                                              QEMUIOVector *qiov,
+                                              int64_t offset, uint64_t bytes)
+{
+    int nb_chunks = DIV_ROUND_UP(bytes, s->granularity);
+
+    while (s->buf_free_count < nb_chunks) {
+        trace_mirror_yield_in_flight(s, offset, s->in_flight);
+        mirror_co_wait_for_free_in_flight_slot(s);
+    }
+
+    qemu_iovec_init(qiov, nb_chunks);
+    while (nb_chunks-- > 0) {
+        MirrorBuffer *buf = QSIMPLEQ_FIRST(&s->buf_free);
+        size_t remaining = bytes - qiov->size;
+
+        QSIMPLEQ_REMOVE_HEAD(&s->buf_free, next);
+        s->buf_free_count--;
+        qemu_iovec_add(qiov, buf, MIN(s->granularity, remaining));
+    }
+}
+
 /*
  * Restrict *bytes to how much we can actually handle, and align the
  * [*offset, *bytes] range to clusters if COW is needed.
@@ -327,28 +350,9 @@ static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
-    int nb_chunks;
     uint64_t ret;
 
-    nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
-
-    while (s->buf_free_count < nb_chunks) {
-        trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
-        mirror_co_wait_for_free_in_flight_slot(s);
-    }
-
-    /* Now make a QEMUIOVector taking enough granularity-sized chunks
-     * from s->buf_free.
-     */
-    qemu_iovec_init(&op->qiov, nb_chunks);
-    while (nb_chunks-- > 0) {
-        MirrorBuffer *buf = QSIMPLEQ_FIRST(&s->buf_free);
-        size_t remaining = op->bytes - op->qiov.size;
-
-        QSIMPLEQ_REMOVE_HEAD(&s->buf_free, next);
-        s->buf_free_count--;
-        qemu_iovec_add(&op->qiov, buf, MIN(s->granularity, remaining));
-    }
+    mirror_co_alloc_qiov(s, &op->qiov, op->offset, op->bytes);
 
     /* Copy the dirty cluster.  */
     s->in_flight++;
-- 
2.17.1
