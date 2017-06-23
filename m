Received: from eggs.gnu.org ([2001:4830:134:3::10]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMW-0001qK-NA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMV-00085r-Fp
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:47 +0200
Message-Id: <1498234919-27316-50-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 49/61] qed: Implement .bdrv_co_readv/writev
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

Most of the qed code is now synchronous and matches the coroutine model.
One notable exception is the serialisation between requests which can
still schedule a callback. Before we can replace this with coroutine
locks, let's convert the driver's external interfaces to the coroutine
versions.

We need to be careful to handle both requests that call the completion
callback directly from the calling coroutine (i.e. fully synchronous
code) and requests that involve some callback, so that we need to yield
and wait for the completion callback coming from outside the coroutine.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 97 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index e762169..a5111fd 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1322,16 +1322,32 @@ static void qed_aio_next_io(QEDAIOCB *acb)
     }
 }
 
-static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
-                                 int64_t sector_num,
-                                 QEMUIOVector *qiov, int nb_sectors,
-                                 BlockCompletionFunc *cb,
-                                 void *opaque, int flags)
+typedef struct QEDRequestCo {
+    Coroutine *co;
+    bool done;
+    int ret;
+} QEDRequestCo;
+
+static void qed_co_request_cb(void *opaque, int ret)
 {
-    QEDAIOCB *acb = qemu_aio_get(&qed_aiocb_info, bs, cb, opaque);
+    QEDRequestCo *co = opaque;
 
-    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors,
-                        opaque, flags);
+    co->done = true;
+    co->ret = ret;
+    qemu_coroutine_enter_if_inactive(co->co);
+}
+
+static int coroutine_fn qed_co_request(BlockDriverState *bs, int64_t sector_num,
+                                       QEMUIOVector *qiov, int nb_sectors,
+                                       int flags)
+{
+    QEDRequestCo co = {
+        .co     = qemu_coroutine_self(),
+        .done   = false,
+    };
+    QEDAIOCB *acb = qemu_aio_get(&qed_aiocb_info, bs, qed_co_request_cb, &co);
+
+    trace_qed_aio_setup(bs->opaque, acb, sector_num, nb_sectors, &co, flags);
 
     acb->flags = flags;
     acb->qiov = qiov;
@@ -1344,43 +1360,26 @@ static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
 
     /* Start request */
     qed_aio_start_io(acb);
-    return &acb->common;
-}
 
-static BlockAIOCB *bdrv_qed_aio_readv(BlockDriverState *bs,
-                                      int64_t sector_num,
-                                      QEMUIOVector *qiov, int nb_sectors,
-                                      BlockCompletionFunc *cb,
-                                      void *opaque)
-{
-    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
+    if (!co.done) {
+        qemu_coroutine_yield();
+    }
+
+    return co.ret;
 }
 
-static BlockAIOCB *bdrv_qed_aio_writev(BlockDriverState *bs,
-                                       int64_t sector_num,
-                                       QEMUIOVector *qiov, int nb_sectors,
-                                       BlockCompletionFunc *cb,
-                                       void *opaque)
+static int coroutine_fn bdrv_qed_co_readv(BlockDriverState *bs,
+                                          int64_t sector_num, int nb_sectors,
+                                          QEMUIOVector *qiov)
 {
-    return qed_aio_setup(bs, sector_num, qiov, nb_sectors, cb,
-                         opaque, QED_AIOCB_WRITE);
+    return qed_co_request(bs, sector_num, qiov, nb_sectors, 0);
 }
 
-typedef struct {
-    Coroutine *co;
-    int ret;
-    bool done;
-} QEDWriteZeroesCB;
-
-static void coroutine_fn qed_co_pwrite_zeroes_cb(void *opaque, int ret)
+static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
+                                           int64_t sector_num, int nb_sectors,
+                                           QEMUIOVector *qiov)
 {
-    QEDWriteZeroesCB *cb = opaque;
-
-    cb->done = true;
-    cb->ret = ret;
-    if (cb->co) {
-        aio_co_wake(cb->co);
-    }
+    return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WRITE);
 }
 
 static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
@@ -1388,9 +1387,7 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                                                   int count,
                                                   BdrvRequestFlags flags)
 {
-    BlockAIOCB *blockacb;
     BDRVQEDState *s = bs->opaque;
-    QEDWriteZeroesCB cb = { .done = false };
     QEMUIOVector qiov;
     struct iovec iov;
 
@@ -1407,19 +1404,9 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
     iov.iov_len = count;
 
     qemu_iovec_init_external(&qiov, &iov, 1);
-    blockacb = qed_aio_setup(bs, offset >> BDRV_SECTOR_BITS, &qiov,
-                             count >> BDRV_SECTOR_BITS,
-                             qed_co_pwrite_zeroes_cb, &cb,
-                             QED_AIOCB_WRITE | QED_AIOCB_ZERO);
-    if (!blockacb) {
-        return -EIO;
-    }
-    if (!cb.done) {
-        cb.co = qemu_coroutine_self();
-        qemu_coroutine_yield();
-    }
-    assert(cb.done);
-    return cb.ret;
+    return qed_co_request(bs, offset >> BDRV_SECTOR_BITS, &qiov,
+                          count >> BDRV_SECTOR_BITS,
+                          QED_AIOCB_WRITE | QED_AIOCB_ZERO);
 }
 
 static int bdrv_qed_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
@@ -1615,8 +1602,8 @@ static BlockDriver bdrv_qed = {
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
-    .bdrv_aio_readv           = bdrv_qed_aio_readv,
-    .bdrv_aio_writev          = bdrv_qed_aio_writev,
+    .bdrv_co_readv            = bdrv_qed_co_readv,
+    .bdrv_co_writev           = bdrv_qed_co_writev,
     .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
     .bdrv_truncate            = bdrv_qed_truncate,
     .bdrv_getlength           = bdrv_qed_getlength,
-- 
1.8.3.1
