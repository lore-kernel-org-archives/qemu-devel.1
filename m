Received: from eggs.gnu.org ([2001:4830:134:3::10]:53490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCo-0006hC-Qs
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCn-0002MB-H8
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:12 +0200
Message-Id: <1497634636-20230-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/31] qed: Simplify request handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Now that we process a request in the same coroutine from beginning to
end and don't drop out of it any more, we can look like a proper
coroutine-based driver and simply call qed_aio_next_io() and get a
return value from it instead of spawning an additional coroutine that
reenters the parent when it's done.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 101 +++++++++++++-----------------------------------------------
 block/qed.h |   3 +-
 2 files changed, 22 insertions(+), 82 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index cd3ef55..e53f6b5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -21,10 +21,6 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/block-backend.h"
 
-static const AIOCBInfo qed_aiocb_info = {
-    .aiocb_size         = sizeof(QEDAIOCB),
-};
-
 static int bdrv_qed_probe(const uint8_t *buf, int buf_size,
                           const char *filename)
 {
@@ -253,13 +249,6 @@ static CachedL2Table *qed_new_l2_table(BDRVQEDState *s)
     return l2_table;
 }
 
-static void qed_aio_next_io(QEDAIOCB *acb);
-
-static void qed_aio_start_io(QEDAIOCB *acb)
-{
-    qed_aio_next_io(acb);
-}
-
 static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
 {
     assert(!s->allocating_write_reqs_plugged);
@@ -751,7 +740,7 @@ static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
 
 static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
 {
-    return acb->common.bs->opaque;
+    return acb->bs->opaque;
 }
 
 /**
@@ -888,28 +877,10 @@ static void qed_update_l2_table(BDRVQEDState *s, QEDTable *table, int index,
     }
 }
 
-static void qed_aio_complete_bh(void *opaque)
-{
-    QEDAIOCB *acb = opaque;
-    BDRVQEDState *s = acb_to_s(acb);
-    BlockCompletionFunc *cb = acb->common.cb;
-    void *user_opaque = acb->common.opaque;
-    int ret = acb->bh_ret;
-
-    qemu_aio_unref(acb);
-
-    /* Invoke callback */
-    qed_acquire(s);
-    cb(user_opaque, ret);
-    qed_release(s);
-}
-
-static void qed_aio_complete(QEDAIOCB *acb, int ret)
+static void qed_aio_complete(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
 
-    trace_qed_aio_complete(s, acb, ret);
-
     /* Free resources */
     qemu_iovec_destroy(&acb->cur_qiov);
     qed_unref_l2_cache_entry(acb->request.l2_table);
@@ -920,11 +891,6 @@ static void qed_aio_complete(QEDAIOCB *acb, int ret)
         acb->qiov->iov[0].iov_base = NULL;
     }
 
-    /* Arrange for a bh to invoke the completion function */
-    acb->bh_ret = ret;
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                            qed_aio_complete_bh, acb);
-
     /* Start next allocating write request waiting behind this one.  Note that
      * requests enqueue themselves when they first hit an unallocated cluster
      * but they wait until the entire request is finished before waking up the
@@ -1172,7 +1138,7 @@ static int qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset, size_t len)
         struct iovec *iov = acb->qiov->iov;
 
         if (!iov->iov_base) {
-            iov->iov_base = qemu_try_blockalign(acb->common.bs, iov->iov_len);
+            iov->iov_base = qemu_try_blockalign(acb->bs, iov->iov_len);
             if (iov->iov_base == NULL) {
                 return -ENOMEM;
             }
@@ -1231,7 +1197,7 @@ static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
 {
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
-    BlockDriverState *bs = acb->common.bs;
+    BlockDriverState *bs = acb->bs;
 
     /* Adjust offset into cluster */
     offset += qed_offset_into_cluster(s, acb->cur_pos);
@@ -1260,7 +1226,7 @@ static int qed_aio_read_data(void *opaque, int ret, uint64_t offset, size_t len)
 /**
  * Begin next I/O or complete the request
  */
-static void qed_aio_next_io(QEDAIOCB *acb)
+static int qed_aio_next_io(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
     uint64_t offset;
@@ -1282,16 +1248,15 @@ static void qed_aio_next_io(QEDAIOCB *acb)
 
         /* Complete request */
         if (acb->cur_pos >= acb->end_pos) {
-            qed_aio_complete(acb, 0);
-            return;
+            ret = 0;
+            break;
         }
 
         /* Find next cluster and start I/O */
         len = acb->end_pos - acb->cur_pos;
         ret = qed_find_cluster(s, &acb->request, acb->cur_pos, &len, &offset);
         if (ret < 0) {
-            qed_aio_complete(acb, ret);
-            return;
+            break;
         }
 
         if (acb->flags & QED_AIOCB_WRITE) {
@@ -1301,56 +1266,32 @@ static void qed_aio_next_io(QEDAIOCB *acb)
         }
 
         if (ret < 0 && ret != -EAGAIN) {
-            qed_aio_complete(acb, ret);
-            return;
+            break;
         }
     }
-}
 
-typedef struct QEDRequestCo {
-    Coroutine *co;
-    bool done;
-    int ret;
-} QEDRequestCo;
-
-static void qed_co_request_cb(void *opaque, int ret)
-{
-    QEDRequestCo *co = opaque;
-
-    co->done = true;
-    co->ret = ret;
-    qemu_coroutine_enter_if_inactive(co->co);
+    trace_qed_aio_complete(s, acb, ret);
+    qed_aio_complete(acb);
+    return ret;
 }
 
 static int coroutine_fn qed_co_request(BlockDriverState *bs, int64_t sector_num,
                                        QEMUIOVector *qiov, int nb_sectors,
                                        int flags)
 {
-    QEDRequestCo co = {
-        .co     = qemu_coroutine_self(),
-        .done   = false,
+    QEDAIOCB acb = {
+        .bs         = bs,
+        .cur_pos    = (uint64_t) sector_num * BDRV_SECTOR_SIZE,
+        .end_pos    = (sector_num + nb_sectors) * BDRV_SECTOR_SIZE,
+        .qiov       = qiov,
+        .flags      = flags,
     };
-    QEDAIOCB *acb = qemu_aio_get(&qed_aiocb_info, bs, qed_co_request_cb, &co);
-
-    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors, &co, flags);
+    qemu_iovec_init(&acb.cur_qiov, qiov->niov);
 
-    acb->flags = flags;
-    acb->qiov = qiov;
-    acb->qiov_offset = 0;
-    acb->cur_pos = (uint64_t)sector_num * BDRV_SECTOR_SIZE;
-    acb->end_pos = acb->cur_pos + nb_sectors * BDRV_SECTOR_SIZE;
-    acb->backing_qiov = NULL;
-    acb->request.l2_table = NULL;
-    qemu_iovec_init(&acb->cur_qiov, qiov->niov);
+    trace_qed_aio_setup(bs->opaque, &acb, sector_num, nb_sectors, NULL, flags);
 
     /* Start request */
-    qed_aio_start_io(acb);
-
-    if (!co.done) {
-        qemu_coroutine_yield();
-    }
-
-    return co.ret;
+    return qed_aio_next_io(&acb);
 }
 
 static int coroutine_fn bdrv_qed_co_readv(BlockDriverState *bs,
diff --git a/block/qed.h b/block/qed.h
index 37558e4..fb80943 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -129,8 +129,7 @@ enum {
 };
 
 typedef struct QEDAIOCB {
-    BlockAIOCB common;
-    int bh_ret;                     /* final return status for completion bh */
+    BlockDriverState *bs;
     QSIMPLEQ_ENTRY(QEDAIOCB) next;  /* next request */
     int flags;                      /* QED_AIOCB_* bits ORed together */
     uint64_t end_pos;               /* request end on block device, in bytes */
-- 
1.8.3.1
