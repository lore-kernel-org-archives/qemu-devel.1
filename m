Received: from eggs.gnu.org ([2001:4830:134:3::10]:53055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqe-0001oq-Uz
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqb-0003De-Kg
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:39 +0100
Message-Id: <20180302185448.6314-29-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/37] block: add BlockBackend->in_flight counter
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

From: Stefan Hajnoczi <stefanha@redhat.com>

BlockBackend currently relies on BlockDriverState->in_flight to track
requests for blk_drain().  There is a corner case where
BlockDriverState->in_flight cannot be used though: blk->root can be NULL
when there is no medium.  This results in a segfault when the NULL
pointer is dereferenced.

Introduce a BlockBackend->in_flight counter for aio requests so it works
even when blk->root == NULL.

Based on a patch by Kevin Wolf <kwolf@redhat.com>.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               |  2 +-
 block/block-backend.c | 60 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 9e4da81213..a83037c2a5 100644
--- a/block.c
+++ b/block.c
@@ -4713,7 +4713,7 @@ out:
 
 AioContext *bdrv_get_aio_context(BlockDriverState *bs)
 {
-    return bs->aio_context;
+    return bs ? bs->aio_context : qemu_get_aio_context();
 }
 
 AioWait *bdrv_get_aio_wait(BlockDriverState *bs)
diff --git a/block/block-backend.c b/block/block-backend.c
index 0266ac990b..a775a3dd2f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -73,6 +73,14 @@ struct BlockBackend {
     int quiesce_counter;
     VMChangeStateEntry *vmsh;
     bool force_allow_inactivate;
+
+    /* Number of in-flight aio requests.  BlockDriverState also counts
+     * in-flight requests but aio requests can exist even when blk->root is
+     * NULL, so we cannot rely on its counter for that case.
+     * Accessed with atomic ops.
+     */
+    unsigned int in_flight;
+    AioWait wait;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -1225,11 +1233,22 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
     return bdrv_make_zero(blk->root, flags);
 }
 
+static void blk_inc_in_flight(BlockBackend *blk)
+{
+    atomic_inc(&blk->in_flight);
+}
+
+static void blk_dec_in_flight(BlockBackend *blk)
+{
+    atomic_dec(&blk->in_flight);
+    aio_wait_kick(&blk->wait);
+}
+
 static void error_callback_bh(void *opaque)
 {
     struct BlockBackendAIOCB *acb = opaque;
 
-    bdrv_dec_in_flight(acb->common.bs);
+    blk_dec_in_flight(acb->blk);
     acb->common.cb(acb->common.opaque, acb->ret);
     qemu_aio_unref(acb);
 }
@@ -1240,7 +1259,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 {
     struct BlockBackendAIOCB *acb;
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    blk_inc_in_flight(blk);
     acb = blk_aio_get(&block_backend_aiocb_info, blk, cb, opaque);
     acb->blk = blk;
     acb->ret = ret;
@@ -1263,7 +1282,7 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
 {
     if (acb->has_returned) {
-        bdrv_dec_in_flight(acb->common.bs);
+        blk_dec_in_flight(acb->rwco.blk);
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
         qemu_aio_unref(acb);
     }
@@ -1284,7 +1303,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     BlkAioEmAIOCB *acb;
     Coroutine *co;
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    blk_inc_in_flight(blk);
     acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
     acb->rwco = (BlkRwCo) {
         .blk    = blk,
@@ -1521,14 +1540,41 @@ int blk_flush(BlockBackend *blk)
 
 void blk_drain(BlockBackend *blk)
 {
-    if (blk_bs(blk)) {
-        bdrv_drain(blk_bs(blk));
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (bs) {
+        bdrv_drained_begin(bs);
+    }
+
+    /* We may have -ENOMEDIUM completions in flight */
+    AIO_WAIT_WHILE(&blk->wait,
+            blk_get_aio_context(blk),
+            atomic_mb_read(&blk->in_flight) > 0);
+
+    if (bs) {
+        bdrv_drained_end(bs);
     }
 }
 
 void blk_drain_all(void)
 {
-    bdrv_drain_all();
+    BlockBackend *blk = NULL;
+
+    bdrv_drain_all_begin();
+
+    while ((blk = blk_all_next(blk)) != NULL) {
+        AioContext *ctx = blk_get_aio_context(blk);
+
+        aio_context_acquire(ctx);
+
+        /* We may have -ENOMEDIUM completions in flight */
+        AIO_WAIT_WHILE(&blk->wait, ctx,
+                atomic_mb_read(&blk->in_flight) > 0);
+
+        aio_context_release(ctx);
+    }
+
+    bdrv_drain_all_end();
 }
 
 void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
-- 
2.13.6
