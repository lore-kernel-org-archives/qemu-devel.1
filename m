Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3f-0000qJ-30
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3d-0002Lr-Nz
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:26 +0200
Message-Id: <20171026131741.5059-21-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/35] qemu-img: Change compare_sectors() to be
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
compare_sectors(), renaming it to compare_buffers() in the
process.  Note that one caller (qemu-img compare) only cares
about the first difference, while the other (qemu-img rebase)
cares about how many consecutive sectors have the same
equal/different status; however, this patch does not bother to
micro-optimize the compare case to avoid the comparisons of
sectors beyond the first mismatch.  Both callers are always
passing valid buffers in, so the initial check for buffer size
can be turned into an assertion.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 55 +++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 66d595be3d..c6b6263853 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1156,31 +1156,28 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
 }
 
 /*
- * Compares two buffers sector by sector. Returns 0 if the first sector of both
- * buffers matches, non-zero otherwise.
+ * Compares two buffers sector by sector. Returns 0 if the first
+ * sector of each buffer matches, non-zero otherwise.
  *
- * pnum is set to the number of sectors (including and immediately following
- * the first one) that are known to have the same comparison result
+ * pnum is set to the sector-aligned size of the buffer prefix that
+ * has the same matching status as the first sector.
  */
-static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
-    int *pnum)
+static int compare_buffers(const uint8_t *buf1, const uint8_t *buf2,
+                           int64_t bytes, int64_t *pnum)
 {
     bool res;
-    int i;
+    int64_t i = MIN(bytes, BDRV_SECTOR_SIZE);
 
-    if (n <= 0) {
-        *pnum = 0;
-        return 0;
-    }
+    assert(bytes > 0);
 
-    res = !!memcmp(buf1, buf2, 512);
-    for(i = 1; i < n; i++) {
-        buf1 += 512;
-        buf2 += 512;
+    res = !!memcmp(buf1, buf2, i);
+    while (i < bytes) {
+        int64_t len = MIN(bytes - i, BDRV_SECTOR_SIZE);
 
-        if (!!memcmp(buf1, buf2, 512) != res) {
+        if (!!memcmp(buf1 + i, buf2 + i, len) != res) {
             break;
         }
+        i += len;
     }
 
     *pnum = i;
@@ -1255,7 +1252,7 @@ static int img_compare(int argc, char **argv)
     int64_t total_sectors;
     int64_t sector_num = 0;
     int64_t nb_sectors;
-    int c, pnum;
+    int c;
     uint64_t progress_base;
     bool image_opts = false;
     bool force_share = false;
@@ -1439,6 +1436,8 @@ static int img_compare(int argc, char **argv)
             /* nothing to do */
         } else if (allocated1 == allocated2) {
             if (allocated1) {
+                int64_t pnum;
+
                 nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
                 ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
                                 nb_sectors << BDRV_SECTOR_BITS);
@@ -1458,11 +1457,11 @@ static int img_compare(int argc, char **argv)
                     ret = 4;
                     goto out;
                 }
-                ret = compare_sectors(buf1, buf2, nb_sectors, &pnum);
-                if (ret || pnum != nb_sectors) {
+                ret = compare_buffers(buf1, buf2,
+                                      nb_sectors * BDRV_SECTOR_SIZE, &pnum);
+                if (ret || pnum != nb_sectors * BDRV_SECTOR_SIZE) {
                     qprintf(quiet, "Content mismatch at offset %" PRId64 "!\n",
-                            sectors_to_bytes(
-                                ret ? sector_num : sector_num + pnum));
+                            sectors_to_bytes(sector_num) + (ret ? 0 : pnum));
                     ret = 1;
                     goto out;
                 }
@@ -3354,16 +3353,16 @@ static int img_rebase(int argc, char **argv)
             /* If they differ, we need to write to the COW file */
             uint64_t written = 0;
 
-            while (written < n) {
-                int pnum;
+            while (written < n * BDRV_SECTOR_SIZE) {
+                int64_t pnum;
 
-                if (compare_sectors(buf_old + written * 512,
-                    buf_new + written * 512, n - written, &pnum))
+                if (compare_buffers(buf_old + written,
+                                    buf_new + written,
+                                    n * BDRV_SECTOR_SIZE - written, &pnum))
                 {
                     ret = blk_pwrite(blk,
-                                     (sector + written) << BDRV_SECTOR_BITS,
-                                     buf_old + written * 512,
-                                     pnum << BDRV_SECTOR_BITS, 0);
+                                     (sector << BDRV_SECTOR_BITS) + written,
+                                     buf_old + written, pnum, 0);
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
                             strerror(-ret));
-- 
2.13.6
