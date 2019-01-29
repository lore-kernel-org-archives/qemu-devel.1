Received: from eggs.gnu.org ([209.51.188.92]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goUqN-0006ME-2s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goUXn-00007P-0Q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:39:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 29 Jan 2019 17:38:00 +0300
Message-Id: <20190129143800.88563-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190129143800.88563-1-vsementsov@virtuozzo.com>
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 89 ++++++++++++------------------------------------------
 1 file changed, 20 insertions(+), 69 deletions(-)

diff --git a/block/io.c b/block/io.c
index bd9d688f8b..80961910a6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -842,17 +842,13 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
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
@@ -879,13 +875,8 @@ int bdrv_write(BdrvChild *child, int64_t sector_num,
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
@@ -949,17 +940,12 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 
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
 
@@ -977,17 +963,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base   = (void *) buf,
-        .iov_len    = bytes,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return bdrv_pwritev(child, offset, &qiov);
 }
 
@@ -1164,7 +1145,6 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     void *bounce_buffer;
 
     BlockDriver *drv = bs->drv;
-    struct iovec iov;
     QEMUIOVector local_qiov;
     int64_t cluster_offset;
     int64_t cluster_bytes;
@@ -1229,9 +1209,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
 
         if (ret <= 0) {
             /* Must copy-on-read; use the bounce buffer */
-            iov.iov_base = bounce_buffer;
-            iov.iov_len = pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
-            qemu_iovec_init_external(&local_qiov, &iov, 1);
+            qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
             ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
                                      &local_qiov, 0);
@@ -1476,7 +1454,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 {
     BlockDriver *drv = bs->drv;
     QEMUIOVector qiov;
-    struct iovec iov = {0};
+    void *buf = NULL;
     int ret = 0;
     bool need_flush = false;
     int head = 0;
@@ -1546,16 +1524,15 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
                 need_flush = true;
             }
             num = MIN(num, max_transfer);
-            iov.iov_len = num;
-            if (iov.iov_base == NULL) {
-                iov.iov_base = qemu_try_blockalign(bs, num);
-                if (iov.iov_base == NULL) {
+            if (buf == NULL) {
+                buf = qemu_try_blockalign(bs, num);
+                if (buf == NULL) {
                     ret = -ENOMEM;
                     goto fail;
                 }
-                memset(iov.iov_base, 0, num);
+                memset(buf, 0, num);
             }
-            qemu_iovec_init_external(&qiov, &iov, 1);
+            qemu_iovec_init_buf(&qiov, buf, num);
 
             ret = bdrv_driver_pwritev(bs, offset, num, &qiov, write_flags);
 
@@ -1563,8 +1540,8 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
              * all future requests.
              */
             if (num < max_transfer) {
-                qemu_vfree(iov.iov_base);
-                iov.iov_base = NULL;
+                qemu_vfree(buf);
+                buf = NULL;
             }
         }
 
@@ -1576,7 +1553,7 @@ fail:
     if (ret == 0 && need_flush) {
         ret = bdrv_co_flush(bs);
     }
-    qemu_vfree(iov.iov_base);
+    qemu_vfree(buf);
     return ret;
 }
 
@@ -1762,7 +1739,6 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     BlockDriverState *bs = child->bs;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
-    struct iovec iov;
     uint64_t align = bs->bl.request_alignment;
     unsigned int head_padding_bytes, tail_padding_bytes;
     int ret = 0;
@@ -1774,11 +1750,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
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
@@ -1884,17 +1856,12 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
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
@@ -1923,7 +1890,6 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 
     if ((offset + bytes) & (align - 1)) {
         QEMUIOVector tail_qiov;
-        struct iovec tail_iov;
         size_t tail_bytes;
         bool waited;
 
@@ -1932,11 +1898,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
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
@@ -2465,15 +2427,9 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
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
@@ -2490,14 +2446,9 @@ int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
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
