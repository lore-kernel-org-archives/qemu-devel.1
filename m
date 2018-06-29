Received: from eggs.gnu.org ([2001:4830:134:3::10]:55526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYsiD-0006xH-JY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYsiC-0003fI-AI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:41:17 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 15:40:52 +0300
Message-Id: <20180629124052.331406-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 2/2] block: postpone the coroutine executing
 if the BDS's is drained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, reitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-stable@nongnu.org
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Fixes the problem of ide request appearing when the BDS is in
the "drained section".

Without the patch the request can come and be processed by the main
event loop, as the ide requests are processed by the main event loop
and the main event loop doesn't stop when its context is in the
"drained section".
The request execution is postponed until the end of "drained section".

The patch doesn't modify ide specific code, as well as any other
device code. Instead, it modifies the infrastructure of asynchronous
Block Backend requests, in favor of postponing the requests arisen
when in "drained section" to remove the possibility of request appearing
for all the infrastructure clients.

This approach doesn't make vCPU processing the request wait untill
the end of request processing.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/block-backend.c | 58 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d55c328736..68dcd704d2 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1318,6 +1318,7 @@ typedef struct BlkAioEmAIOCB {
     BlkRwCo rwco;
     int bytes;
     bool has_returned;
+    CoroutineEntry *co_entry;
 } BlkAioEmAIOCB;
 
 static const AIOCBInfo blk_aio_em_aiocb_info = {
@@ -1340,16 +1341,55 @@ static void blk_aio_complete_bh(void *opaque)
     blk_aio_complete(acb);
 }
 
+static void blk_aio_create_co(void *opaque)
+{
+    BlockDriverState *current_bs;
+    AioContext *ctx;
+    BlkAioEmAIOCB *acb = (BlkAioEmAIOCB *) opaque;
+    BlockBackend *blk = acb->rwco.blk;
+
+    /* The check makes sense if the action was postponed until the context
+     * is enabled for external requests: if a BlockDriverState of a BlockBackend
+     * was changed, for example on making a new snapshot, update BlockDriverState
+     * in ACB and try to run the coroutine in the changed BDS context
+     */
+    current_bs = blk_bs(blk);
+
+    if (current_bs != acb->common.bs) {
+        acb->common.bs = current_bs;
+    }
+
+    ctx = blk_get_aio_context(blk);
+    /* If a request comes from device (e.g. ide controller) when
+     * the context disabled, postpone the request until the context is
+     * enabled for external requests.
+     * Otherwise, create a couroutine and enter it right now
+     */
+    aio_context_acquire(ctx);
+    if (aio_external_disabled(ctx)) {
+        AioPostponedAction *action = aio_create_postponed_action(
+                                                blk_aio_create_co, acb);
+        aio_postpone_action(ctx, action);
+    } else {
+        Coroutine *co = qemu_coroutine_create(acb->co_entry, acb);
+        blk_inc_in_flight(blk);
+        bdrv_coroutine_enter(acb->common.bs, co);
+
+        acb->has_returned = true;
+        if (acb->rwco.ret != NOT_DONE) {
+            aio_bh_schedule_oneshot(ctx, blk_aio_complete_bh, acb);
+        }
+    }
+    aio_context_release(ctx);
+}
+
 static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
                                 void *iobuf, CoroutineEntry co_entry,
                                 BdrvRequestFlags flags,
                                 BlockCompletionFunc *cb, void *opaque)
 {
-    BlkAioEmAIOCB *acb;
-    Coroutine *co;
 
-    blk_inc_in_flight(blk);
-    acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
+    BlkAioEmAIOCB *acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
     acb->rwco = (BlkRwCo) {
         .blk    = blk,
         .offset = offset,
@@ -1359,15 +1399,9 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     };
     acb->bytes = bytes;
     acb->has_returned = false;
+    acb->co_entry = co_entry;
 
-    co = qemu_coroutine_create(co_entry, acb);
-    bdrv_coroutine_enter(blk_bs(blk), co);
-
-    acb->has_returned = true;
-    if (acb->rwco.ret != NOT_DONE) {
-        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
-                                blk_aio_complete_bh, acb);
-    }
+    blk_aio_create_co(acb);
 
     return &acb->common;
 }
-- 
2.17.0
