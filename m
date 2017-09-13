Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsA9k-00027B-MT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsA9j-0006Rz-QY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:04:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 13 Sep 2017 11:03:27 -0500
Message-Id: <20170913160333.23622-18-eblake@redhat.com>
In-Reply-To: <20170913160333.23622-1-eblake@redhat.com>
References: <20170913160333.23622-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 17/23] qemu-img: Change
 check_empty_sectors() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Continue on the quest to make more things byte-based instead of
sector-based.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 qemu-img.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 3e1e373e8f..2e05f92e85 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1202,30 +1202,29 @@ static int64_t sectors_to_bytes(int64_t sectors)
  * an error message.
  *
  * @param blk:  BlockBackend for the image
- * @param sect_num: Number of first sector to check
- * @param sect_count: Number of sectors to check
+ * @param offset: Starting offset to check
+ * @param bytes: Number of bytes to check
  * @param filename: Name of disk file we are checking (logging purpose)
  * @param buffer: Allocated buffer for storing read data
  * @param quiet: Flag for quiet mode
  */
-static int check_empty_sectors(BlockBackend *blk, int64_t sect_num,
-                               int sect_count, const char *filename,
+static int check_empty_sectors(BlockBackend *blk, int64_t offset,
+                               int64_t bytes, const char *filename,
                                uint8_t *buffer, bool quiet)
 {
     int ret = 0;
     int64_t idx;

-    ret = blk_pread(blk, sect_num << BDRV_SECTOR_BITS, buffer,
-                    sect_count << BDRV_SECTOR_BITS);
+    ret = blk_pread(blk, offset, buffer, bytes);
     if (ret < 0) {
         error_report("Error while reading offset %" PRId64 " of %s: %s",
-                     sectors_to_bytes(sect_num), filename, strerror(-ret));
+                     offset, filename, strerror(-ret));
         return 4;
     }
-    idx = find_nonzero(buffer, sect_count * BDRV_SECTOR_SIZE);
+    idx = find_nonzero(buffer, bytes);
     if (idx >= 0) {
         qprintf(quiet, "Content mismatch at offset %" PRId64 "!\n",
-                sectors_to_bytes(sect_num) + idx);
+                offset + idx);
         return 1;
     }

@@ -1468,10 +1467,12 @@ static int img_compare(int argc, char **argv)
         } else {
             nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
             if (allocated1) {
-                ret = check_empty_sectors(blk1, sector_num, nb_sectors,
+                ret = check_empty_sectors(blk1, sector_num * BDRV_SECTOR_SIZE,
+                                          nb_sectors * BDRV_SECTOR_SIZE,
                                           filename1, buf1, quiet);
             } else {
-                ret = check_empty_sectors(blk2, sector_num, nb_sectors,
+                ret = check_empty_sectors(blk2, sector_num * BDRV_SECTOR_SIZE,
+                                          nb_sectors * BDRV_SECTOR_SIZE,
                                           filename2, buf1, quiet);
             }
             if (ret) {
@@ -1516,7 +1517,9 @@ static int img_compare(int argc, char **argv)
             nb_sectors = count >> BDRV_SECTOR_BITS;
             if (ret & BDRV_BLOCK_ALLOCATED && !(ret & BDRV_BLOCK_ZERO)) {
                 nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
-                ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
+                ret = check_empty_sectors(blk_over,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          nb_sectors * BDRV_SECTOR_SIZE,
                                           filename_over, buf1, quiet);
                 if (ret) {
                     goto out;
-- 
2.13.5
