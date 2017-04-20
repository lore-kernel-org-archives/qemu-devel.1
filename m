Received: from eggs.gnu.org ([2001:4830:134:3::10]:40296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d17c9-0002PE-Kr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d17c6-0006T8-GG
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:38:57 -0400
From: jemmy858585@gmail.com
Date: Thu, 20 Apr 2017 16:38:46 +0800
Message-Id: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH] qemu-img: use blk_co_pwrite_zeroes for zero
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
 qemu-img.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..0256539 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1675,13 +1675,20 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
              * write if the buffer is completely zeroed and we're allowed to
              * keep the target sparse. */
             if (s->compressed) {
-                if (s->has_zero_init && s->min_sparse &&
-                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
-                {
-                    assert(!s->target_has_backing);
-                    break;
+                if (buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)) {
+                    if (s->has_zero_init && s->min_sparse) {
+                        assert(!s->target_has_backing);
+                        break;
+                    } else {
+                        ret = blk_co_pwrite_zeroes(s->target,
+                                           sector_num << BDRV_SECTOR_BITS,
+                                           n << BDRV_SECTOR_BITS, 0);
+                        if (ret < 0) {
+                            return ret;
+                        }
+                        break;
+                    }
                 }
-
                 iov.iov_base = buf;
                 iov.iov_len = n << BDRV_SECTOR_BITS;
                 qemu_iovec_init_external(&qiov, &iov, 1);
-- 
1.8.3.1
