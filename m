Received: from eggs.gnu.org ([2001:4830:134:3::10]:46409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d1VJy-0008Kg-Aa
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d1VJu-0003Yd-Cy
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:57:46 -0400
From: jemmy858585@gmail.com
Date: Fri, 21 Apr 2017 17:57:34 +0800
Message-Id: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2] qemu-img: use blk_co_pwrite_zeroes for zero
 sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

when the buffer is zero, blk_co_pwrite_zeroes is more effectively than
blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces
the time when converts the qcow2 image with lots of zero.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
v2 changelog:
    unify the compressed and non-compressed code paths
---
 qemu-img.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..60c9adf 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1661,6 +1661,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
+        BdrvRequestFlags flags = s->compressed ? BDRV_REQ_WRITE_COMPRESSED : 0;
+
         switch (status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
@@ -1670,43 +1672,21 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
             break;
 
         case BLK_DATA:
-            /* We must always write compressed clusters as a whole, so don't
-             * try to find zeroed parts in the buffer. We can only save the
-             * write if the buffer is completely zeroed and we're allowed to
-             * keep the target sparse. */
-            if (s->compressed) {
-                if (s->has_zero_init && s->min_sparse &&
-                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
-                {
-                    assert(!s->target_has_backing);
-                    break;
-                }
-
-                iov.iov_base = buf;
-                iov.iov_len = n << BDRV_SECTOR_BITS;
-                qemu_iovec_init_external(&qiov, &iov, 1);
-
-                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov,
-                                     BDRV_REQ_WRITE_COMPRESSED);
-                if (ret < 0) {
-                    return ret;
-                }
-                break;
-            }
-
-            /* If there is real non-zero data or we're told to keep the target
-             * fully allocated (-S 0), we must write it. Otherwise we can treat
+            /* If we're told to keep the target fully allocated (-S 0) or there
+             * is real non-zero data, we must write it. Otherwise we can treat
              * it as zero sectors. */
             if (!s->min_sparse ||
-                is_allocated_sectors_min(buf, n, &n, s->min_sparse))
-            {
+                (!s->compressed &&
+                 is_allocated_sectors_min(buf, n, &n, s->min_sparse)) ||
+                (s->compressed &&
+                 !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))) {
+
                 iov.iov_base = buf;
                 iov.iov_len = n << BDRV_SECTOR_BITS;
                 qemu_iovec_init_external(&qiov, &iov, 1);
 
                 ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, 0);
+                                     n << BDRV_SECTOR_BITS, &qiov, flags);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1716,6 +1696,7 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
 
         case BLK_ZERO:
             if (s->has_zero_init) {
+                assert(!s->target_has_backing);
                 break;
             }
             ret = blk_co_pwrite_zeroes(s->target,
-- 
1.8.3.1
