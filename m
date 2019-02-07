Received: from eggs.gnu.org ([209.51.188.92]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrv-0002zB-3h
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrt-00025f-QQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:30 +0300
Message-Id: <20190207102445.71998-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 02/17] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

While being here, use qemu_try_blockalign0 as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 89 ++++++++++++------------------------------------------
 1 file changed, 20 insertions(+), 69 deletions(-)

diff --git a/block/io.c b/block/io.c
index 213ca03d8d..2ba603c7bc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -843,17 +843,13 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
 static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
                       int nb_sectors, bool is_write, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = (void *)buf,
-        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf,
+                                            nb_sectors * BDRV_SECTOR_SIZE);
 
     if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
         return -EINVAL;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_prwv_co(child, sector_num << BDRV_SECTOR_BITS,
                         &qiov, is_write, flags);
 }
@@ -880,13 +876,8 @@ int bdrv_write(BdrvChild *child, int64_t sector_num,
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = NULL,
-        .iov_len = bytes,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_prwv_co(child, offset, &qiov, true,
                         BDRV_REQ_ZERO_WRITE | flags);
 }
@@ -950,17 +941,12 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = (void *)buf,
-        .iov_len = bytes,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_preadv(child, offset, &qiov);
 }
 
@@ -978,17 +964,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base   = (void *) buf,
-        .iov_len    = bytes,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_pwritev(child, offset, &qiov);
 }
 
@@ -1165,7 +1146,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     void *bounce_buffer;
 
     BlockDriver *drv = bs->drv;
-    struct iovec iov;
     QEMUIOVector local_qiov;
     int64_t cluster_offset;
     int64_t cluster_bytes;
@@ -1230,9 +1210,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
 
         if (ret <= 0) {
             /* Must copy-on-read; use the bounce buffer */
-            iov.iov_base = bounce_buffer;
-            iov.iov_len = pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
-            qemu_iovec_init_external(&local_qiov, &iov, 1);
+            pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
+            qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
             ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
                                      &local_qiov, 0);
@@ -1477,7 +1456,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 {
     BlockDriver *drv = bs->drv;
     QEMUIOVector qiov;
-    struct iovec iov = {0};
+    void *buf = NULL;
     int ret = 0;
     bool need_flush = false;
     int head = 0;
@@ -1547,16 +1526,14 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
                 need_flush = true;
             }
             num = MIN(num, max_transfer);
-            iov.iov_len = num;
-            if (iov.iov_base == NULL) {
-                iov.iov_base = qemu_try_blockalign(bs, num);
-                if (iov.iov_base == NULL) {
+            if (buf == NULL) {
+                buf = qemu_try_blockalign0(bs, num);
+                if (buf == NULL) {
                     ret = -ENOMEM;
                     goto fail;
                 }
-                memset(iov.iov_base, 0, num);
             }
-            qemu_iovec_init_external(&qiov, &iov, 1);
+            qemu_iovec_init_buf(&qiov, buf, num);
 
             ret = bdrv_driver_pwritev(bs, offset, num, &qiov, write_flags);
 
@@ -1564,8 +1541,8 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
              * all future requests.
              */
             if (num < max_transfer) {
-                qemu_vfree(iov.iov_base);
-                iov.iov_base = NULL;
+                qemu_vfree(buf);
+                buf = NULL;
             }
         }
 
@@ -1577,7 +1554,7 @@ fail:
     if (ret == 0 && need_flush) {
         ret = bdrv_co_flush(bs);
     }
-    qemu_vfree(iov.iov_base);
+    qemu_vfree(buf);
     return ret;
 }
 
@@ -1763,7 +1740,6 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     BlockDriverState *bs = child->bs;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
-    struct iovec iov;
     uint64_t align = bs->bl.request_alignment;
     unsigned int head_padding_bytes, tail_padding_bytes;
     int ret = 0;
@@ -1775,11 +1751,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
         buf = qemu_blockalign(bs, align);
-        iov = (struct iovec) {
-            .iov_base   = buf,
-            .iov_len    = align,
-        };
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+        qemu_iovec_init_buf(&local_qiov, buf, align);
     }
     if (head_padding_bytes) {
         uint64_t zero_bytes = MIN(bytes, align - head_padding_bytes);
@@ -1885,17 +1857,12 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
     if (offset & (align - 1)) {
         QEMUIOVector head_qiov;
-        struct iovec head_iov;
 
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
 
         head_buf = qemu_blockalign(bs, align);
-        head_iov = (struct iovec) {
-            .iov_base   = head_buf,
-            .iov_len    = align,
-        };
-        qemu_iovec_init_external(&head_qiov, &head_iov, 1);
+        qemu_iovec_init_buf(&head_qiov, head_buf, align);
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret = bdrv_aligned_preadv(child, &req, offset & ~(align - 1), align,
@@ -1924,7 +1891,6 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
     if ((offset + bytes) & (align - 1)) {
         QEMUIOVector tail_qiov;
-        struct iovec tail_iov;
         size_t tail_bytes;
         bool waited;
 
@@ -1933,11 +1899,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         assert(!waited || !use_local_qiov);
 
         tail_buf = qemu_blockalign(bs, align);
-        tail_iov = (struct iovec) {
-            .iov_base   = tail_buf,
-            .iov_len    = align,
-        };
-        qemu_iovec_init_external(&tail_qiov, &tail_iov, 1);
+        qemu_iovec_init_buf(&tail_qiov, tail_buf, align);
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret = bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(align - 1),
@@ -2468,15 +2430,9 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base   = (void *) buf,
-        .iov_len    = size,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
     int ret;
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     ret = bdrv_writev_vmstate(bs, &qiov, pos);
     if (ret < 0) {
         return ret;
@@ -2493,14 +2449,9 @@ int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
                       int64_t pos, int size)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base   = buf,
-        .iov_len    = size,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
     int ret;
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     ret = bdrv_readv_vmstate(bs, &qiov, pos);
     if (ret < 0) {
         return ret;
-- 
2.18.0
