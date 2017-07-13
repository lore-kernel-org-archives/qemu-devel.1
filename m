Received: from eggs.gnu.org ([2001:4830:134:3::10]:54176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLm-0005VD-Qs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLl-00069c-OA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:01 -0500
Message-Id: <20170713154711.32374-14-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/23] qemu-img: Simplify logic in
 img_compare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>

As long as we are querying the status for a chunk smaller than
the known image size, we are guaranteed that a successful return
will have set pnum to a non-zero size (pnum is zero only for
queries beyond the end of the file).  Use that to slightly
simplify the calculation of the current chunk size being compared.
Likewise, we don't have to shrink the amount of data operated on
until we know we have to read the file, and therefore have to fit
in the bounds of our buffer.  Also, note that 'total_sectors_over'
is equivalent to 'progress_base'.

With these changes in place, sectors_to_process() is now dead code,
and can be removed.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 qemu-img.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 06a0106..bc21d00 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1165,11 +1165,6 @@ static int64_t sectors_to_bytes(int64_t sectors)
     return sectors << BDRV_SECTOR_BITS;
 }

-static int64_t sectors_to_process(int64_t total, int64_t from)
-{
-    return MIN(total - from, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
-}
-
 /*
  * Check if passed sectors are empty (not allocated or contain only 0 bytes)
  *
@@ -1366,13 +1361,9 @@ static int img_compare(int argc, char **argv)
         goto out;
     }

-    for (;;) {
+    while (sector_num < total_sectors) {
         int64_t status1, status2;

-        nb_sectors = sectors_to_process(total_sectors, sector_num);
-        if (nb_sectors <= 0) {
-            break;
-        }
         status1 = bdrv_block_status_above(bs1, NULL,
                                           sector_num * BDRV_SECTOR_SIZE,
                                           (total_sectors1 - sector_num) *
@@ -1396,14 +1387,9 @@ static int img_compare(int argc, char **argv)
             goto out;
         }
         allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
-        if (pnum1) {
-            nb_sectors = MIN(nb_sectors,
-                             DIV_ROUND_UP(pnum1, BDRV_SECTOR_SIZE));
-        }
-        if (pnum2) {
-            nb_sectors = MIN(nb_sectors,
-                             DIV_ROUND_UP(pnum2, BDRV_SECTOR_SIZE));
-        }
+
+        assert(pnum1 && pnum2);
+        nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);

         if (strict) {
             if ((status1 & ~BDRV_BLOCK_OFFSET_MASK) !=
@@ -1416,9 +1402,10 @@ static int img_compare(int argc, char **argv)
             }
         }
         if ((status1 & BDRV_BLOCK_ZERO) && (status2 & BDRV_BLOCK_ZERO)) {
-            nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);
+            /* nothing to do */
         } else if (allocated1 == allocated2) {
             if (allocated1) {
+                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
                 ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
                                 nb_sectors << BDRV_SECTOR_BITS);
                 if (ret < 0) {
@@ -1447,7 +1434,7 @@ static int img_compare(int argc, char **argv)
                 }
             }
         } else {
-
+            nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
             if (allocated1) {
                 ret = check_empty_sectors(blk1, sector_num, nb_sectors,
                                           filename1, buf1, quiet);
@@ -1470,30 +1457,24 @@ static int img_compare(int argc, char **argv)

     if (total_sectors1 != total_sectors2) {
         BlockBackend *blk_over;
-        int64_t total_sectors_over;
         const char *filename_over;

         qprintf(quiet, "Warning: Image size mismatch!\n");
         if (total_sectors1 > total_sectors2) {
-            total_sectors_over = total_sectors1;
             blk_over = blk1;
             filename_over = filename1;
         } else {
-            total_sectors_over = total_sectors2;
             blk_over = blk2;
             filename_over = filename2;
         }

-        for (;;) {
+        while (sector_num < progress_base) {
             int64_t count;

-            nb_sectors = sectors_to_process(total_sectors_over, sector_num);
-            if (nb_sectors <= 0) {
-                break;
-            }
             ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
                                           sector_num * BDRV_SECTOR_SIZE,
-                                          nb_sectors * BDRV_SECTOR_SIZE,
+                                          (progress_base - sector_num) *
+                                          BDRV_SECTOR_SIZE,
                                           &count);
             if (ret < 0) {
                 ret = 3;
@@ -1507,6 +1488,7 @@ static int img_compare(int argc, char **argv)
             assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
             nb_sectors = count >> BDRV_SECTOR_BITS;
             if (ret) {
+                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
                 ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
                                           filename_over, buf1, quiet);
                 if (ret) {
-- 
2.9.4
