Received: from eggs.gnu.org ([2001:4830:134:3::10]:57825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRe2-0000of-Oi
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRdz-0003tx-UF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:11:42 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 27 Feb 2017 21:09:40 +0100
Message-Id: <1488226184-9044-40-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
References: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 39/43] block: Pass BdrvChild to
 bdrv_aligned_preadv/pwritev and copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is where we want to check the permissions, so we need to have the
BdrvChild around where they are stored.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index d5c4544..2592ca1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -925,9 +925,11 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
 }
 
-static int coroutine_fn bdrv_co_do_copy_on_readv(BlockDriverState *bs,
+static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
         int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
 {
+    BlockDriverState *bs = child->bs;
+
     /* Perform I/O through a temporary buffer so that users who scribble over
      * their read buffer while the operation is in progress do not end up
      * modifying the image file.  This is critical for zero-copy guest I/O
@@ -1001,10 +1003,11 @@ err:
  * handles copy on read, zeroing after EOF, and fragmentation of large
  * reads; any other features must be implemented by the caller.
  */
-static int coroutine_fn bdrv_aligned_preadv(BlockDriverState *bs,
+static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
     int64_t align, QEMUIOVector *qiov, int flags)
 {
+    BlockDriverState *bs = child->bs;
     int64_t total_bytes, max_bytes;
     int ret = 0;
     uint64_t bytes_remaining = bytes;
@@ -1050,7 +1053,7 @@ static int coroutine_fn bdrv_aligned_preadv(BlockDriverState *bs,
         }
 
         if (!ret || pnum != nb_sectors) {
-            ret = bdrv_co_do_copy_on_readv(bs, offset, bytes, qiov);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
             goto out;
         }
     }
@@ -1158,7 +1161,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     }
 
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
-    ret = bdrv_aligned_preadv(bs, &req, offset, bytes, align,
+    ret = bdrv_aligned_preadv(child, &req, offset, bytes, align,
                               use_local_qiov ? &local_qiov : qiov,
                               flags);
     tracked_request_end(&req);
@@ -1306,10 +1309,11 @@ fail:
  * Forwards an already correctly aligned write request to the BlockDriver,
  * after possibly fragmenting it.
  */
-static int coroutine_fn bdrv_aligned_pwritev(BlockDriverState *bs,
+static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
     int64_t align, QEMUIOVector *qiov, int flags)
 {
+    BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     bool waited;
     int ret;
@@ -1397,12 +1401,13 @@ static int coroutine_fn bdrv_aligned_pwritev(BlockDriverState *bs,
     return ret;
 }
 
-static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
+static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
                                                 int64_t offset,
                                                 unsigned int bytes,
                                                 BdrvRequestFlags flags,
                                                 BdrvTrackedRequest *req)
 {
+    BlockDriverState *bs = child->bs;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
     struct iovec iov;
@@ -1430,7 +1435,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
         mark_request_serialising(req, align);
         wait_serialising_requests(req);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret = bdrv_aligned_preadv(bs, req, offset & ~(align - 1), align,
+        ret = bdrv_aligned_preadv(child, req, offset & ~(align - 1), align,
                                   align, &local_qiov, 0);
         if (ret < 0) {
             goto fail;
@@ -1438,7 +1443,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
 
         memset(buf + head_padding_bytes, 0, zero_bytes);
-        ret = bdrv_aligned_pwritev(bs, req, offset & ~(align - 1), align,
+        ret = bdrv_aligned_pwritev(child, req, offset & ~(align - 1), align,
                                    align, &local_qiov,
                                    flags & ~BDRV_REQ_ZERO_WRITE);
         if (ret < 0) {
@@ -1452,7 +1457,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
     if (bytes >= align) {
         /* Write the aligned part in the middle. */
         uint64_t aligned_bytes = bytes & ~(align - 1);
-        ret = bdrv_aligned_pwritev(bs, req, offset, aligned_bytes, align,
+        ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
                                    NULL, flags);
         if (ret < 0) {
             goto fail;
@@ -1468,7 +1473,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
         mark_request_serialising(req, align);
         wait_serialising_requests(req);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret = bdrv_aligned_preadv(bs, req, offset, align,
+        ret = bdrv_aligned_preadv(child, req, offset, align,
                                   align, &local_qiov, 0);
         if (ret < 0) {
             goto fail;
@@ -1476,7 +1481,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BlockDriverState *bs,
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
 
         memset(buf, 0, bytes);
-        ret = bdrv_aligned_pwritev(bs, req, offset, align, align,
+        ret = bdrv_aligned_pwritev(child, req, offset, align, align,
                                    &local_qiov, flags & ~BDRV_REQ_ZERO_WRITE);
     }
 fail:
@@ -1523,7 +1528,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
 
     if (!qiov) {
-        ret = bdrv_co_do_zero_pwritev(bs, offset, bytes, flags, &req);
+        ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
         goto out;
     }
 
@@ -1542,7 +1547,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         qemu_iovec_init_external(&head_qiov, &head_iov, 1);
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret = bdrv_aligned_preadv(bs, &req, offset & ~(align - 1), align,
+        ret = bdrv_aligned_preadv(child, &req, offset & ~(align - 1), align,
                                   align, &head_qiov, 0);
         if (ret < 0) {
             goto fail;
@@ -1584,8 +1589,8 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         qemu_iovec_init_external(&tail_qiov, &tail_iov, 1);
 
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret = bdrv_aligned_preadv(bs, &req, (offset + bytes) & ~(align - 1), align,
-                                  align, &tail_qiov, 0);
+        ret = bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(align - 1),
+                                  align, align, &tail_qiov, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -1603,7 +1608,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         bytes = ROUND_UP(bytes, align);
     }
 
-    ret = bdrv_aligned_pwritev(bs, &req, offset, bytes, align,
+    ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
                                use_local_qiov ? &local_qiov : qiov,
                                flags);
 
-- 
1.8.3.1
