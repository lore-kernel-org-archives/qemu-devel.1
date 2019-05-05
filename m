Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hNBAZ-00066n-07
	for qemu-devel@nongnu.org; Sun, 05 May 2019 03:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hNBAX-0006rb-Uj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 03:02:42 -0400
From: Xiang Zheng <zhengxiang9@huawei.com>
Date: Sun, 5 May 2019 15:00:59 +0800
Message-ID: <20190505070059.4664-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of backend
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, peter.maydell@linaro.org, guoheyi@huawei.com, lersek@redhat.com, mreitz@redhat.com, armbru@redhat.com, kwolf@redhat.com, ard.biesheuvel@linaro.org, stefanha@redhat.com, Xiang Zheng <zhengxiang9@huawei.com>

Currently we fill the memory space with two 64MB NOR images when
using persistent UEFI variables on virt board. Actually we only use
a very small(non-zero) part of the memory while the rest significant
large(zero) part of memory is wasted.

So this patch checks the block status and only writes the non-zero part
into memory. This requires pflash devices to use sparse files for
backends.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 hw/block/block.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c76..3cb9d4c 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -15,6 +15,44 @@
 #include "qapi/qapi-types-block.h"
 
 /*
+ * Read the non-zeroes parts of @blk into @buf
+ * Reading all of the @blk is expensive if the zeroes parts of @blk
+ * is large enough. Therefore check the block status and only write
+ * the non-zeroes block into @buf.
+ *
+ * Return 0 on success, non-zero on error.
+ */
+static int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
+{
+    int ret;
+    int64_t target_size, bytes, offset = 0;
+    BlockDriverState *bs = blk_bs(blk);
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_SECTORS);
+        if (bytes <= 0) {
+            return 0;
+        }
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (!(ret & BDRV_BLOCK_ZERO)) {
+            ret = bdrv_pread(bs->file, offset, (uint8_t *) buf + offset, bytes);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        offset += bytes;
+    }
+}
+
+/*
  * Read the entire contents of @blk into @buf.
  * @blk's contents must be @size bytes, and @size must be at most
  * BDRV_REQUEST_MAX_BYTES.
@@ -53,7 +91,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
      * block device and read only on demand.
      */
     assert(size <= BDRV_REQUEST_MAX_BYTES);
-    ret = blk_pread(blk, 0, buf, size);
+    ret = blk_pread_nonzeroes(blk, buf);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "can't read block backend");
         return false;
-- 
1.8.3.1
