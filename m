Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1Z-0000lW-9X
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1Y-0004bH-0e
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1X-0004al-NT
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:17 +0800
Message-Id: <20170717034825.1524-8-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] block: invoke .bdrv_drain callback in
 coroutine context and from AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This will let the callback take a CoMutex in the next patch.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-8-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 42 +++++++++++++++++++++++++++++++++---------
 block/qed.c               |  6 +++---
 include/block/block_int.h |  2 +-
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index b413727..aece54c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -149,6 +149,37 @@ bool bdrv_requests_pending(BlockDriverState *bs)
     return false;
 }
 
+typedef struct {
+    Coroutine *co;
+    BlockDriverState *bs;
+    bool done;
+} BdrvCoDrainData;
+
+static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
+{
+    BdrvCoDrainData *data = opaque;
+    BlockDriverState *bs = data->bs;
+
+    bs->drv->bdrv_co_drain(bs);
+
+    /* Set data->done before reading bs->wakeup.  */
+    atomic_mb_set(&data->done, true);
+    bdrv_wakeup(bs);
+}
+
+static void bdrv_drain_invoke(BlockDriverState *bs)
+{
+    BdrvCoDrainData data = { .bs = bs, .done = false };
+
+    if (!bs->drv || !bs->drv->bdrv_co_drain) {
+        return;
+    }
+
+    data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
+    bdrv_coroutine_enter(bs, data.co);
+    BDRV_POLL_WHILE(bs, !data.done);
+}
+
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *tmp;
@@ -156,9 +187,8 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
 
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
-    if (bs->drv && bs->drv->bdrv_drain) {
-        bs->drv->bdrv_drain(bs);
-    }
+    /* Ensure any pending metadata writes are submitted to bs->file.  */
+    bdrv_drain_invoke(bs);
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
@@ -184,12 +214,6 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     return waited;
 }
 
-typedef struct {
-    Coroutine *co;
-    BlockDriverState *bs;
-    bool done;
-} BdrvCoDrainData;
-
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
     BdrvCoDrainData *data = opaque;
diff --git a/block/qed.c b/block/qed.c
index 5792796..6625320 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -350,7 +350,7 @@ static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
     }
 }
 
-static void bdrv_qed_drain(BlockDriverState *bs)
+static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -359,7 +359,7 @@ static void bdrv_qed_drain(BlockDriverState *bs)
      */
     if (s->need_check_timer && timer_pending(s->need_check_timer)) {
         qed_cancel_need_check_timer(s);
-        qed_need_check_timer_cb(s);
+        qed_need_check_timer_entry(s);
     }
 }
 
@@ -1548,7 +1548,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_check               = bdrv_qed_check,
     .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
     .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
-    .bdrv_drain               = bdrv_qed_drain,
+    .bdrv_co_drain            = bdrv_qed_co_drain,
 };
 
 static void bdrv_qed_init(void)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 669a279..5c6b761 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -324,7 +324,7 @@ struct BlockDriver {
      * Drain and stop any internal sources of requests in the driver, and
      * remain so until next I/O callback (e.g. bdrv_co_writev) is called.
      */
-    void (*bdrv_drain)(BlockDriverState *bs);
+    void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
 
     void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
                            Error **errp);
-- 
2.9.4
