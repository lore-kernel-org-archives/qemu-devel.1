Received: from eggs.gnu.org ([2001:4830:134:3::10]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3f-0000rQ-Py
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3d-0002M6-Ov
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:28 +0200
Message-Id: <20171026131741.5059-23-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/35] qemu-img: Change img_compare() to be
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

In the continuing quest to make more things byte-based, change
the internal iteration of img_compare().  We can finally drop the
TODO assertions added earlier, now that the entire algorithm is
byte-based and no longer has to shift from bytes to sectors.

Most of the change is mechanical ('total_sectors' becomes
'total_size', 'sector_num' becomes 'offset', 'nb_sectors' becomes
'chunk', 'progress_base' goes from sectors to bytes); some of it
is also a cleanup (sectors_to_bytes() is now unused, loss of
variable 'count' added earlier in commit 51b0a488).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 124 ++++++++++++++++++++++++-------------------------------------
 1 file changed, 48 insertions(+), 76 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 994365c6a4..02a6e27beb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1186,11 +1186,6 @@ static int compare_buffers(const uint8_t *buf1, const uint8_t *buf2,
 
 #define IO_BUF_SIZE (2 * 1024 * 1024)
 
-static int64_t sectors_to_bytes(int64_t sectors)
-{
-    return sectors << BDRV_SECTOR_BITS;
-}
-
 /*
  * Check if passed sectors are empty (not allocated or contain only 0 bytes)
  *
@@ -1241,7 +1236,7 @@ static int img_compare(int argc, char **argv)
     const char *fmt1 = NULL, *fmt2 = NULL, *cache, *filename1, *filename2;
     BlockBackend *blk1, *blk2;
     BlockDriverState *bs1, *bs2;
-    int64_t total_sectors1, total_sectors2;
+    int64_t total_size1, total_size2;
     uint8_t *buf1 = NULL, *buf2 = NULL;
     int64_t pnum1, pnum2;
     int allocated1, allocated2;
@@ -1249,9 +1244,9 @@ static int img_compare(int argc, char **argv)
     bool progress = false, quiet = false, strict = false;
     int flags;
     bool writethrough;
-    int64_t total_sectors;
-    int64_t sector_num = 0;
-    int64_t nb_sectors;
+    int64_t total_size;
+    int64_t offset = 0;
+    int64_t chunk;
     int c;
     uint64_t progress_base;
     bool image_opts = false;
@@ -1365,39 +1360,37 @@ static int img_compare(int argc, char **argv)
 
     buf1 = blk_blockalign(blk1, IO_BUF_SIZE);
     buf2 = blk_blockalign(blk2, IO_BUF_SIZE);
-    total_sectors1 = blk_nb_sectors(blk1);
-    if (total_sectors1 < 0) {
+    total_size1 = blk_getlength(blk1);
+    if (total_size1 < 0) {
         error_report("Can't get size of %s: %s",
-                     filename1, strerror(-total_sectors1));
+                     filename1, strerror(-total_size1));
         ret = 4;
         goto out;
     }
-    total_sectors2 = blk_nb_sectors(blk2);
-    if (total_sectors2 < 0) {
+    total_size2 = blk_getlength(blk2);
+    if (total_size2 < 0) {
         error_report("Can't get size of %s: %s",
-                     filename2, strerror(-total_sectors2));
+                     filename2, strerror(-total_size2));
         ret = 4;
         goto out;
     }
-    total_sectors = MIN(total_sectors1, total_sectors2);
-    progress_base = MAX(total_sectors1, total_sectors2);
+    total_size = MIN(total_size1, total_size2);
+    progress_base = MAX(total_size1, total_size2);
 
     qemu_progress_print(0, 100);
 
-    if (strict && total_sectors1 != total_sectors2) {
+    if (strict && total_size1 != total_size2) {
         ret = 1;
         qprintf(quiet, "Strict mode: Image size mismatch!\n");
         goto out;
     }
 
-    while (sector_num < total_sectors) {
+    while (offset < total_size) {
         int status1, status2;
 
-        status1 = bdrv_block_status_above(bs1, NULL,
-                                          sector_num * BDRV_SECTOR_SIZE,
-                                          (total_sectors1 - sector_num) *
-                                          BDRV_SECTOR_SIZE,
-                                          &pnum1, NULL, NULL);
+        status1 = bdrv_block_status_above(bs1, NULL, offset,
+                                          total_size1 - offset, &pnum1, NULL,
+                                          NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1405,30 +1398,24 @@ static int img_compare(int argc, char **argv)
         }
         allocated1 = status1 & BDRV_BLOCK_ALLOCATED;
 
-        status2 = bdrv_block_status_above(bs2, NULL,
-                                          sector_num * BDRV_SECTOR_SIZE,
-                                          (total_sectors2 - sector_num) *
-                                          BDRV_SECTOR_SIZE,
-                                          &pnum2, NULL, NULL);
+        status2 = bdrv_block_status_above(bs2, NULL, offset,
+                                          total_size2 - offset, &pnum2, NULL,
+                                          NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
             goto out;
         }
         allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
-        /* TODO: Relax this once comparison is byte-based, and we no longer
-         * have to worry about sector alignment */
-        assert(QEMU_IS_ALIGNED(pnum1 | pnum2, BDRV_SECTOR_SIZE));
 
         assert(pnum1 && pnum2);
-        nb_sectors = MIN(pnum1, pnum2) >> BDRV_SECTOR_BITS;
+        chunk = MIN(pnum1, pnum2);
 
         if (strict) {
             if (status1 != status2) {
                 ret = 1;
                 qprintf(quiet, "Strict mode: Offset %" PRId64
-                        " block status mismatch!\n",
-                        sectors_to_bytes(sector_num));
+                        " block status mismatch!\n", offset);
                 goto out;
             }
         }
@@ -1438,59 +1425,54 @@ static int img_compare(int argc, char **argv)
             if (allocated1) {
                 int64_t pnum;
 
-                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
-                ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
-                                nb_sectors << BDRV_SECTOR_BITS);
+                chunk = MIN(chunk, IO_BUF_SIZE);
+                ret = blk_pread(blk1, offset, buf1, chunk);
                 if (ret < 0) {
-                    error_report("Error while reading offset %" PRId64 " of %s:"
-                                 " %s", sectors_to_bytes(sector_num), filename1,
-                                 strerror(-ret));
+                    error_report("Error while reading offset %" PRId64
+                                 " of %s: %s",
+                                 offset, filename1, strerror(-ret));
                     ret = 4;
                     goto out;
                 }
-                ret = blk_pread(blk2, sector_num << BDRV_SECTOR_BITS, buf2,
-                                nb_sectors << BDRV_SECTOR_BITS);
+                ret = blk_pread(blk2, offset, buf2, chunk);
                 if (ret < 0) {
                     error_report("Error while reading offset %" PRId64
-                                 " of %s: %s", sectors_to_bytes(sector_num),
-                                 filename2, strerror(-ret));
+                                 " of %s: %s",
+                                 offset, filename2, strerror(-ret));
                     ret = 4;
                     goto out;
                 }
-                ret = compare_buffers(buf1, buf2,
-                                      nb_sectors * BDRV_SECTOR_SIZE, &pnum);
-                if (ret || pnum != nb_sectors * BDRV_SECTOR_SIZE) {
+                ret = compare_buffers(buf1, buf2, chunk, &pnum);
+                if (ret || pnum != chunk) {
                     qprintf(quiet, "Content mismatch at offset %" PRId64 "!\n",
-                            sectors_to_bytes(sector_num) + (ret ? 0 : pnum));
+                            offset + (ret ? 0 : pnum));
                     ret = 1;
                     goto out;
                 }
             }
         } else {
-            nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
+            chunk = MIN(chunk, IO_BUF_SIZE);
             if (allocated1) {
-                ret = check_empty_sectors(blk1, sector_num * BDRV_SECTOR_SIZE,
-                                          nb_sectors * BDRV_SECTOR_SIZE,
+                ret = check_empty_sectors(blk1, offset, chunk,
                                           filename1, buf1, quiet);
             } else {
-                ret = check_empty_sectors(blk2, sector_num * BDRV_SECTOR_SIZE,
-                                          nb_sectors * BDRV_SECTOR_SIZE,
+                ret = check_empty_sectors(blk2, offset, chunk,
                                           filename2, buf1, quiet);
             }
             if (ret) {
                 goto out;
             }
         }
-        sector_num += nb_sectors;
-        qemu_progress_print(((float) nb_sectors / progress_base)*100, 100);
+        offset += chunk;
+        qemu_progress_print(((float) chunk / progress_base) * 100, 100);
     }
 
-    if (total_sectors1 != total_sectors2) {
+    if (total_size1 != total_size2) {
         BlockBackend *blk_over;
         const char *filename_over;
 
         qprintf(quiet, "Warning: Image size mismatch!\n");
-        if (total_sectors1 > total_sectors2) {
+        if (total_size1 > total_size2) {
             blk_over = blk1;
             filename_over = filename1;
         } else {
@@ -1498,14 +1480,10 @@ static int img_compare(int argc, char **argv)
             filename_over = filename2;
         }
 
-        while (sector_num < progress_base) {
-            int64_t count;
-
-            ret = bdrv_block_status_above(blk_bs(blk_over), NULL,
-                                          sector_num * BDRV_SECTOR_SIZE,
-                                          (progress_base - sector_num) *
-                                          BDRV_SECTOR_SIZE,
-                                          &count, NULL, NULL);
+        while (offset < progress_base) {
+            ret = bdrv_block_status_above(blk_bs(blk_over), NULL, offset,
+                                          progress_base - offset, &chunk,
+                                          NULL, NULL);
             if (ret < 0) {
                 ret = 3;
                 error_report("Sector allocation test failed for %s",
@@ -1513,22 +1491,16 @@ static int img_compare(int argc, char **argv)
                 goto out;
 
             }
-            /* TODO relax this once bdrv_block_status_above does not enforce
-             * sector alignment */
-            assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-            nb_sectors = count >> BDRV_SECTOR_BITS;
             if (ret & BDRV_BLOCK_ALLOCATED && !(ret & BDRV_BLOCK_ZERO)) {
-                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
-                ret = check_empty_sectors(blk_over,
-                                          sector_num * BDRV_SECTOR_SIZE,
-                                          nb_sectors * BDRV_SECTOR_SIZE,
+                chunk = MIN(chunk, IO_BUF_SIZE);
+                ret = check_empty_sectors(blk_over, offset, chunk,
                                           filename_over, buf1, quiet);
                 if (ret) {
                     goto out;
                 }
             }
-            sector_num += nb_sectors;
-            qemu_progress_print(((float) nb_sectors / progress_base)*100, 100);
+            offset += chunk;
+            qemu_progress_print(((float) chunk / progress_base) * 100, 100);
         }
     }
 
-- 
2.13.6
