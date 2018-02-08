Received: from eggs.gnu.org ([2001:4830:134:3::10]:49339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpqA-0007j4-BN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpq6-0003bZ-8e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ejpq6-0003VL-2Q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Feb 2018 17:18:05 +0000
Message-Id: <20180208171807.24267-2-stefanha@redhat.com>
In-Reply-To: <20180208171807.24267-1-stefanha@redhat.com>
References: <20180208171807.24267-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] block: add BlockBackend->in_flight counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 block.c               |  2 +-
 block/block-backend.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index a8da4f2b25..140f7919f8 100644
--- a/block.c
+++ b/block.c
@@ -4716,7 +4716,7 @@ out:
 
 AioContext *bdrv_get_aio_context(BlockDriverState *bs)
 {
-    return bs->aio_context;
+    return bs ? bs->aio_context : qemu_get_aio_context();
 }
 
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7abc..4811d8bc55 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -71,6 +71,13 @@ struct BlockBackend {
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
 };
 
 typedef struct BlockBackendAIOCB {
@@ -1223,11 +1230,21 @@ int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
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
@@ -1238,7 +1255,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 {
     struct BlockBackendAIOCB *acb;
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    blk_inc_in_flight(blk);
     acb = blk_aio_get(&block_backend_aiocb_info, blk, cb, opaque);
     acb->blk = blk;
     acb->ret = ret;
@@ -1261,7 +1278,7 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
 {
     if (acb->has_returned) {
-        bdrv_dec_in_flight(acb->common.bs);
+        blk_dec_in_flight(acb->rwco.blk);
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
         qemu_aio_unref(acb);
     }
@@ -1282,7 +1299,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     BlkAioEmAIOCB *acb;
     Coroutine *co;
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    blk_inc_in_flight(blk);
     acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
     acb->rwco = (BlkRwCo) {
         .blk    = blk,
@@ -1519,14 +1536,42 @@ int blk_flush(BlockBackend *blk)
 
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
+    /* We may have aio requests like -ENOMEDIUM in flight */
+    while (atomic_mb_read(&blk->in_flight) > 0) {
+        aio_poll(blk_get_aio_context(blk), true);
+    }
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
+        /* We may have aio requests like -ENOMEDIUM in flight */
+        while (atomic_mb_read(&blk->in_flight) > 0) {
+            aio_poll(blk_get_aio_context(blk), true);
+        }
+
+        aio_context_release(ctx);
+    }
+
+    bdrv_drain_all_end();
 }
 
 void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
-- 
2.14.3
