Received: from eggs.gnu.org ([2001:4830:134:3::10]:41588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iR-0005vD-Tp
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iR-0006FL-5z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:00 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:52 +0800
Message-Id: <20171129144956.11409-6-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 5/9] qed: Implement AioContext drain ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qed.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 821dcaa055..8ddaa31e7c 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -337,12 +337,33 @@ static void qed_cancel_need_check_timer(BDRVQEDState *s)
     timer_del(s->need_check_timer);
 }
 
+static void bdrv_qed_drained_begin(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVQEDState *s = bs->opaque;
+
+    /* Fire the timer immediately in order to start doing I/O as soon as the
+     * header is flushed.
+     */
+    if (s->need_check_timer && timer_pending(s->need_check_timer)) {
+        qed_cancel_need_check_timer(s);
+        qed_need_check_timer_entry(s);
+    }
+}
+
+static void bdrv_qed_drained_end(void *opaque)
+{
+}
+
 static void bdrv_qed_detach_aio_context(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
     qed_cancel_need_check_timer(s);
     timer_free(s->need_check_timer);
+    aio_context_del_drain_ops(bdrv_get_aio_context(bs),
+                              bdrv_qed_drained_begin, bdrv_qed_drained_end,
+                              bs);
 }
 
 static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
@@ -356,19 +377,14 @@ static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
     if (s->header.features & QED_F_NEED_CHECK) {
         qed_start_need_check_timer(s);
     }
+    aio_context_add_drain_ops(new_context,
+                              bdrv_qed_drained_begin, bdrv_qed_drained_end,
+                              bs);
 }
 
 static void coroutine_fn bdrv_qed_co_drain_begin(BlockDriverState *bs)
 {
-    BDRVQEDState *s = bs->opaque;
-
-    /* Fire the timer immediately in order to start doing I/O as soon as the
-     * header is flushed.
-     */
-    if (s->need_check_timer && timer_pending(s->need_check_timer)) {
-        qed_cancel_need_check_timer(s);
-        qed_need_check_timer_entry(s);
-    }
+    bdrv_qed_drained_begin(bs);
 }
 
 static void bdrv_qed_init_state(BlockDriverState *bs)
-- 
2.14.3
