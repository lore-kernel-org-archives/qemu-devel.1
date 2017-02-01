Received: from eggs.gnu.org ([2001:4830:134:3::10]:56299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZB-00043N-IU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZA-0006Vb-LN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:49 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:36 -0500
Message-Id: <20170201053440.26002-2-jcody@redhat.com>
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] sheepdog: remove unused cancellation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

SheepdogAIOCB is internal to sheepdog.c, hence it is never canceled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161129113245.32724-2-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 52 ----------------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 5637e0c..5fde37a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -347,7 +347,6 @@ struct SheepdogAIOCB {
     Coroutine *coroutine;
     void (*aio_done_func)(SheepdogAIOCB *);
 
-    bool cancelable;
     int nr_pending;
 
     uint32_t min_affect_data_idx;
@@ -486,7 +485,6 @@ static inline void free_aio_req(BDRVSheepdogState *s, AIOReq *aio_req)
 {
     SheepdogAIOCB *acb = aio_req->aiocb;
 
-    acb->cancelable = false;
     QLIST_REMOVE(aio_req, aio_siblings);
     g_free(aio_req);
 
@@ -499,57 +497,8 @@ static void coroutine_fn sd_finish_aiocb(SheepdogAIOCB *acb)
     qemu_aio_unref(acb);
 }
 
-/*
- * Check whether the specified acb can be canceled
- *
- * We can cancel aio when any request belonging to the acb is:
- *  - Not processed by the sheepdog server.
- *  - Not linked to the inflight queue.
- */
-static bool sd_acb_cancelable(const SheepdogAIOCB *acb)
-{
-    BDRVSheepdogState *s = acb->common.bs->opaque;
-    AIOReq *aioreq;
-
-    if (!acb->cancelable) {
-        return false;
-    }
-
-    QLIST_FOREACH(aioreq, &s->inflight_aio_head, aio_siblings) {
-        if (aioreq->aiocb == acb) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
-static void sd_aio_cancel(BlockAIOCB *blockacb)
-{
-    SheepdogAIOCB *acb = (SheepdogAIOCB *)blockacb;
-    BDRVSheepdogState *s = acb->common.bs->opaque;
-    AIOReq *aioreq, *next;
-
-    if (sd_acb_cancelable(acb)) {
-        /* Remove outstanding requests from failed queue.  */
-        QLIST_FOREACH_SAFE(aioreq, &s->failed_aio_head, aio_siblings,
-                           next) {
-            if (aioreq->aiocb == acb) {
-                free_aio_req(s, aioreq);
-            }
-        }
-
-        assert(acb->nr_pending == 0);
-        if (acb->common.cb) {
-            acb->common.cb(acb->common.opaque, -ECANCELED);
-        }
-        sd_finish_aiocb(acb);
-    }
-}
-
 static const AIOCBInfo sd_aiocb_info = {
     .aiocb_size     = sizeof(SheepdogAIOCB),
-    .cancel_async   = sd_aio_cancel,
 };
 
 static SheepdogAIOCB *sd_aio_setup(BlockDriverState *bs, QEMUIOVector *qiov,
@@ -569,7 +518,6 @@ static SheepdogAIOCB *sd_aio_setup(BlockDriverState *bs, QEMUIOVector *qiov,
     acb->nb_sectors = nb_sectors;
 
     acb->aio_done_func = NULL;
-    acb->cancelable = true;
     acb->coroutine = qemu_coroutine_self();
     acb->ret = 0;
     acb->nr_pending = 0;
-- 
2.9.3
