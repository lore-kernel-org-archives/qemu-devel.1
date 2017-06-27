Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPtlx-0007u9-TX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPsLE-0004gN-St
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:23:49 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Jun 2017 17:22:45 +0200
Message-Id: <20170627152248.10446-8-pbonzini@redhat.com>
In-Reply-To: <20170627152248.10446-1-pbonzini@redhat.com>
References: <20170627152248.10446-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] block: invoke .bdrv_drain callback in
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
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

This will let the callback take a CoMutex in the next patch.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                | 42 +++++++++++++++++++++++++++++++++---------
 block/qed.c               |  6 +++---
 include/block/block_int.h |  2 +-
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 9bba730a7e..68f19bbe69 100644
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
index 3ffdc1716d..454b7f0f2b 100644
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
 
@@ -1540,7 +1540,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_check               = bdrv_qed_check,
     .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
     .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
-    .bdrv_drain               = bdrv_qed_drain,
+    .bdrv_co_drain            = bdrv_qed_co_drain,
 };
 
 static void bdrv_qed_init(void)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602150..6d3fbbfc1e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -321,7 +321,7 @@ struct BlockDriver {
      * Drain and stop any internal sources of requests in the driver, and
      * remain so until next I/O callback (e.g. bdrv_co_writev) is called.
      */
-    void (*bdrv_drain)(BlockDriverState *bs);
+    void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
 
     void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
                            Error **errp);
-- 
2.13.0
