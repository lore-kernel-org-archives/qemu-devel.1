Received: from eggs.gnu.org ([2001:4830:134:3::10]:42026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWN-0000Ii-It
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWL-0008Pu-Ld
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:14 +0800
Message-Id: <20180608060417.10170-4-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] block-backend: Refactor AIO emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

BlkRwCo fields are multi-purposed. @offset is sometimes used to pass the
'req' number for blk_ioctl and blk_aio_ioctl; @iobuf is sometimes the
pointer for QEMUIOVector @qiov sometimes the ioctl @buf. This is not as
clean as it can be. As the coming copy range emulation wants to add
more differentiation in parameters, refactor a bit.

Move the per-request fields to a union and create one struct for each
type. While at it also move the bytes parameter from BlkAioEmAIOCB to
BlkRwCo.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 211 +++++++++++++++++++++++++++---------------
 1 file changed, 134 insertions(+), 77 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d55c328736..e20a204bee 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1192,62 +1192,79 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
 
 typedef struct BlkRwCo {
     BlockBackend *blk;
-    int64_t offset;
-    void *iobuf;
     int ret;
-    BdrvRequestFlags flags;
+
+    union {
+        struct {
+            int64_t offset;
+            int bytes;
+            QEMUIOVector *qiov;
+            BdrvRequestFlags flags;
+        } prwv;
+
+        struct {
+            int64_t offset;
+            int bytes;
+            void *buf;
+            BdrvRequestFlags flags;
+        } prw;
+
+        struct {
+            unsigned long int req;
+            void *buf;
+        } ioctl;
+    };
+
 } BlkRwCo;
 
 static void blk_read_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
-    QEMUIOVector *qiov = rwco->iobuf;
+    QEMUIOVector qiov;
+    struct iovec iov;
 
-    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
-                              qiov, rwco->flags);
+    iov = (struct iovec) {
+        .iov_base = rwco->prw.buf,
+        .iov_len = rwco->prw.bytes,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    rwco->ret = blk_co_preadv(rwco->blk, rwco->prw.offset, rwco->prw.bytes,
+                              &qiov, rwco->prw.flags);
 }
 
 static void blk_write_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
-    QEMUIOVector *qiov = rwco->iobuf;
-
-    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
-                               qiov, rwco->flags);
-}
-
-static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
-                   int64_t bytes, CoroutineEntry co_entry,
-                   BdrvRequestFlags flags)
-{
     QEMUIOVector qiov;
     struct iovec iov;
-    BlkRwCo rwco;
 
     iov = (struct iovec) {
-        .iov_base = buf,
-        .iov_len = bytes,
+        .iov_base = rwco->prw.buf,
+        .iov_len = rwco->prw.bytes,
     };
     qemu_iovec_init_external(&qiov, &iov, 1);
 
-    rwco = (BlkRwCo) {
-        .blk    = blk,
-        .offset = offset,
-        .iobuf  = &qiov,
-        .flags  = flags,
-        .ret    = NOT_DONE,
-    };
+    rwco->ret = blk_co_pwritev(rwco->blk, rwco->prw.offset, rwco->prw.bytes,
+                               &qiov, rwco->prw.flags);
+}
 
+static int blk_prw(BlockBackend *blk, BlkRwCo *rwco,
+                   CoroutineEntry co_entry)
+{
+
+    rwco->blk = blk;
+    rwco->ret = NOT_DONE;
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
-        co_entry(&rwco);
+        co_entry(rwco);
     } else {
-        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
+        Coroutine *co = qemu_coroutine_create(co_entry, rwco);
         bdrv_coroutine_enter(blk_bs(blk), co);
-        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
+        BDRV_POLL_WHILE(blk_bs(blk), rwco->ret == NOT_DONE);
     }
 
-    return rwco.ret;
+    return rwco->ret;
 }
 
 int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
@@ -1269,8 +1286,12 @@ int blk_pread_unthrottled(BlockBackend *blk, int64_t offset, uint8_t *buf,
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                       int bytes, BdrvRequestFlags flags)
 {
-    return blk_prw(blk, offset, NULL, bytes, blk_write_entry,
-                   flags | BDRV_REQ_ZERO_WRITE);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prwv.offset = offset,
+        .prwv.bytes = bytes,
+        .prwv.flags = flags | BDRV_REQ_ZERO_WRITE,
+    };
+    return blk_prw(blk, &rwco, blk_write_entry);
 }
 
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags)
@@ -1316,7 +1337,6 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 typedef struct BlkAioEmAIOCB {
     BlockAIOCB common;
     BlkRwCo rwco;
-    int bytes;
     bool has_returned;
 } BlkAioEmAIOCB;
 
@@ -1340,9 +1360,8 @@ static void blk_aio_complete_bh(void *opaque)
     blk_aio_complete(acb);
 }
 
-static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
-                                void *iobuf, CoroutineEntry co_entry,
-                                BdrvRequestFlags flags,
+static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, const BlkRwCo *rwco,
+                                CoroutineEntry co_entry,
                                 BlockCompletionFunc *cb, void *opaque)
 {
     BlkAioEmAIOCB *acb;
@@ -1350,14 +1369,9 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
 
     blk_inc_in_flight(blk);
     acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
-    acb->rwco = (BlkRwCo) {
-        .blk    = blk,
-        .offset = offset,
-        .iobuf  = iobuf,
-        .flags  = flags,
-        .ret    = NOT_DONE,
-    };
-    acb->bytes = bytes;
+    acb->rwco = *rwco;
+    acb->rwco.blk = blk;
+    acb->rwco.ret = NOT_DONE;
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
@@ -1376,11 +1390,11 @@ static void blk_aio_read_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb = opaque;
     BlkRwCo *rwco = &acb->rwco;
-    QEMUIOVector *qiov = rwco->iobuf;
+    QEMUIOVector *qiov = rwco->prwv.qiov;
 
-    assert(qiov->size == acb->bytes);
-    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
-                              qiov, rwco->flags);
+    assert(qiov->size == rwco->prwv.bytes);
+    rwco->ret = blk_co_preadv(rwco->blk, rwco->prwv.offset, rwco->prwv.bytes,
+                              qiov, rwco->prwv.flags);
     blk_aio_complete(acb);
 }
 
@@ -1388,11 +1402,11 @@ static void blk_aio_write_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb = opaque;
     BlkRwCo *rwco = &acb->rwco;
-    QEMUIOVector *qiov = rwco->iobuf;
+    QEMUIOVector *qiov = rwco->prwv.qiov;
 
-    assert(!qiov || qiov->size == acb->bytes);
-    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, acb->bytes,
-                               qiov, rwco->flags);
+    assert(!qiov || qiov->size == rwco->prwv.bytes);
+    rwco->ret = blk_co_pwritev(rwco->blk, rwco->prwv.offset, rwco->prwv.bytes,
+                               qiov, rwco->prwv.flags);
     blk_aio_complete(acb);
 }
 
@@ -1400,13 +1414,22 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                   int count, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, count, NULL, blk_aio_write_entry,
-                        flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prwv.offset = offset,
+        .prwv.bytes = count,
+        .prwv.flags = flags | BDRV_REQ_ZERO_WRITE,
+    };
+    return blk_aio_prwv(blk, &rwco, blk_aio_write_entry, cb, opaque);
 }
 
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
 {
-    int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prw.offset = offset,
+        .prw.bytes = count,
+        .prw.buf = buf,
+    };
+    int ret = blk_prw(blk, &rwco, blk_read_entry);
     if (ret < 0) {
         return ret;
     }
@@ -1416,8 +1439,13 @@ int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
 int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int count,
                BdrvRequestFlags flags)
 {
-    int ret = blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
-                      flags);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prw.offset = offset,
+        .prw.bytes = count,
+        .prw.buf = (void *)buf,
+        .prw.flags = flags,
+    };
+    int ret = blk_prw(blk, &rwco, blk_write_entry);
     if (ret < 0) {
         return ret;
     }
@@ -1455,16 +1483,26 @@ BlockAIOCB *blk_aio_preadv(BlockBackend *blk, int64_t offset,
                            QEMUIOVector *qiov, BdrvRequestFlags flags,
                            BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, qiov->size, qiov,
-                        blk_aio_read_entry, flags, cb, opaque);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prwv.offset = offset,
+        .prwv.bytes = qiov->size,
+        .prwv.flags = flags,
+        .prwv.qiov = qiov,
+    };
+    return blk_aio_prwv(blk, &rwco, blk_aio_read_entry, cb, opaque);
 }
 
 BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
                             QEMUIOVector *qiov, BdrvRequestFlags flags,
                             BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, qiov->size, qiov,
-                        blk_aio_write_entry, flags, cb, opaque);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prwv.offset = offset,
+        .prwv.bytes = qiov->size,
+        .prwv.flags = flags,
+        .prwv.qiov = qiov,
+    };
+    return blk_aio_prwv(blk, &rwco, blk_aio_write_entry, cb, opaque);
 }
 
 static void blk_aio_flush_entry(void *opaque)
@@ -1479,7 +1517,8 @@ static void blk_aio_flush_entry(void *opaque)
 BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, 0, 0, NULL, blk_aio_flush_entry, 0, cb, opaque);
+    BlkRwCo rwco = { };
+    return blk_aio_prwv(blk, &rwco, blk_aio_flush_entry, cb, opaque);
 }
 
 static void blk_aio_pdiscard_entry(void *opaque)
@@ -1487,7 +1526,7 @@ static void blk_aio_pdiscard_entry(void *opaque)
     BlkAioEmAIOCB *acb = opaque;
     BlkRwCo *rwco = &acb->rwco;
 
-    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->offset, acb->bytes);
+    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->prwv.offset, rwco->prwv.bytes);
     blk_aio_complete(acb);
 }
 
@@ -1495,8 +1534,11 @@ BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
                              int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, 0,
-                        cb, opaque);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prwv.offset = offset,
+        .prwv.bytes = bytes,
+    };
+    return blk_aio_prwv(blk, &rwco, blk_aio_pdiscard_entry, cb, opaque);
 }
 
 void blk_aio_cancel(BlockAIOCB *acb)
@@ -1521,15 +1563,17 @@ int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 static void blk_ioctl_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
-    QEMUIOVector *qiov = rwco->iobuf;
 
-    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
-                             qiov->iov[0].iov_base);
+    rwco->ret = blk_co_ioctl(rwco->blk, rwco->ioctl.req, rwco->ioctl.buf);
 }
 
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 {
-    return blk_prw(blk, req, buf, 0, blk_ioctl_entry, 0);
+    BlkRwCo rwco = (BlkRwCo) {
+        .ioctl.req = req,
+        .ioctl.buf = buf,
+    };
+    return blk_prw(blk, &rwco, blk_ioctl_entry);
 }
 
 static void blk_aio_ioctl_entry(void *opaque)
@@ -1537,7 +1581,7 @@ static void blk_aio_ioctl_entry(void *opaque)
     BlkAioEmAIOCB *acb = opaque;
     BlkRwCo *rwco = &acb->rwco;
 
-    rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
+    rwco->ret = blk_co_ioctl(rwco->blk, rwco->ioctl.req, rwco->ioctl.buf);
 
     blk_aio_complete(acb);
 }
@@ -1545,7 +1589,11 @@ static void blk_aio_ioctl_entry(void *opaque)
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
                           BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, opaque);
+    BlkRwCo rwco = (BlkRwCo) {
+        .ioctl.req = req,
+        .ioctl.buf = buf,
+    };
+    return blk_aio_prwv(blk, &rwco, blk_aio_ioctl_entry, cb, opaque);
 }
 
 int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
@@ -1575,7 +1623,8 @@ static void blk_flush_entry(void *opaque)
 
 int blk_flush(BlockBackend *blk)
 {
-    return blk_prw(blk, 0, NULL, 0, blk_flush_entry, 0);
+    BlkRwCo rwco = { };
+    return blk_prw(blk, &rwco, blk_flush_entry);
 }
 
 void blk_drain(BlockBackend *blk)
@@ -1985,8 +2034,13 @@ int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
                           int count)
 {
-    return blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
-                   BDRV_REQ_WRITE_COMPRESSED);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prw.offset = offset,
+        .prw.buf = (void *)buf,
+        .prw.bytes = count,
+        .prw.flags = BDRV_REQ_WRITE_COMPRESSED,
+    };
+    return blk_prw(blk, &rwco, blk_write_entry);
 }
 
 int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
@@ -2003,14 +2057,17 @@ int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
 static void blk_pdiscard_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
-    QEMUIOVector *qiov = rwco->iobuf;
 
-    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
+    rwco->ret = blk_co_pdiscard(rwco->blk, rwco->prw.offset, rwco->prw.bytes);
 }
 
 int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
-    return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
+    BlkRwCo rwco = (BlkRwCo) {
+        .prw.offset = offset,
+        .prw.bytes = bytes,
+    };
+    return blk_prw(blk, &rwco, blk_pdiscard_entry);
 }
 
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
-- 
2.17.0
