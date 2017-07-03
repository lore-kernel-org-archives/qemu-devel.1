Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cv-0007cp-DO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cu-0004aD-ES
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:47 -0500
Message-Id: <20170703221456.30817-7-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/15] block: Switch bdrv_make_zero() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of zeroing a device to track by bytes instead of
sectors (although we are still guaranteed that we iterate by steps
that are sector-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to earlier changes
---
 block/io.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index 2377f3a..b3ba9af 100644
--- a/block/io.c
+++ b/block/io.c
@@ -669,38 +669,38 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
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
2.9.4
