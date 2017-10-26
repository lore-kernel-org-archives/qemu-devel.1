Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i35-0000MA-IB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i34-0001rH-G3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:13 +0200
Message-Id: <20171026131741.5059-8-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/35] block: Switch bdrv_make_zero() to
 byte-based
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

From: Eric Blake <eblake@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of zeroing a device to track by bytes instead of
sectors (although we are still guaranteed that we iterate by steps
that are sector-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index db8dc59c94..ad84d84888 100644
--- a/block/io.c
+++ b/block/io.c
@@ -716,38 +716,38 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
  */
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
-    int64_t target_sectors, ret, nb_sectors, sector_num = 0;
+    int64_t target_size, ret, bytes, offset = 0;
     BlockDriverState *bs = child->bs;
-    int n;
+    int n; /* sectors */
 
-    target_sectors = bdrv_nb_sectors(bs);
-    if (target_sectors < 0) {
-        return target_sectors;
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
     }
 
     for (;;) {
-        nb_sectors = MIN(target_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);
-        if (nb_sectors <= 0) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, NULL);
+        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
+                                    bytes >> BDRV_SECTOR_BITS, &n, NULL);
         if (ret < 0) {
-            error_report("error getting block status at sector %" PRId64 ": %s",
-                         sector_num, strerror(-ret));
+            error_report("error getting block status at offset %" PRId64 ": %s",
+                         offset, strerror(-ret));
             return ret;
         }
         if (ret & BDRV_BLOCK_ZERO) {
-            sector_num += n;
+            offset += n * BDRV_SECTOR_BITS;
             continue;
         }
-        ret = bdrv_pwrite_zeroes(child, sector_num << BDRV_SECTOR_BITS,
-                                 n << BDRV_SECTOR_BITS, flags);
+        ret = bdrv_pwrite_zeroes(child, offset, n * BDRV_SECTOR_SIZE, flags);
         if (ret < 0) {
-            error_report("error writing zeroes at sector %" PRId64 ": %s",
-                         sector_num, strerror(-ret));
+            error_report("error writing zeroes at offset %" PRId64 ": %s",
+                         offset, strerror(-ret));
             return ret;
         }
-        sector_num += n;
+        offset += n * BDRV_SECTOR_SIZE;
     }
 }
 
-- 
2.13.6
