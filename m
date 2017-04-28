Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbV-0002Ho-Om
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbU-0001cf-PP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:35:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:39 +0200
Message-Id: <1493411622-5343-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/34] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
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

From: Lidong Chen <lidongchen@tencent.com>

When the buffer is zero, blk_co_pwrite_zeroes is more effective than
blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. This patch can reduce
the time for converting qcow2 images with lots of zero data.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Message-id: 1493261907-18734-1-git-send-email-lidongchen@tencent.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9b6e728..c719636 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1649,6 +1649,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
+        BdrvRequestFlags flags = s->compressed ? BDRV_REQ_WRITE_COMPRESSED : 0;
+
         switch (status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
@@ -1658,43 +1660,24 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
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
-             * it as zero sectors. */
+            /* If we're told to keep the target fully allocated (-S 0) or there
+             * is real non-zero data, we must write it. Otherwise we can treat
+             * it as zero sectors.
+             * Compressed clusters need to be written as a whole, so in that
+             * case we can only save the write if the buffer is completely
+             * zeroed. */
             if (!s->min_sparse ||
-                is_allocated_sectors_min(buf, n, &n, s->min_sparse))
+                (!s->compressed &&
+                 is_allocated_sectors_min(buf, n, &n, s->min_sparse)) ||
+                (s->compressed &&
+                 !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
                 iov.iov_base = buf;
                 iov.iov_len = n << BDRV_SECTOR_BITS;
                 qemu_iovec_init_external(&qiov, &iov, 1);
 
                 ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
-                                     n << BDRV_SECTOR_BITS, &qiov, 0);
+                                     n << BDRV_SECTOR_BITS, &qiov, flags);
                 if (ret < 0) {
                     return ret;
                 }
@@ -1704,6 +1687,7 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
 
         case BLK_ZERO:
             if (s->has_zero_init) {
+                assert(!s->target_has_backing);
                 break;
             }
             ret = blk_co_pwrite_zeroes(s->target,
-- 
1.8.3.1
