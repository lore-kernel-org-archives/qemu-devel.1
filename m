Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBE-0005OK-V8
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBE-0003o5-0q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 26 Apr 2018 08:43:04 -0500
Message-Id: <20180426134305.642080-3-eblake@redhat.com>
In-Reply-To: <20180426134305.642080-1-eblake@redhat.com>
References: <20180426134305.642080-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] vvfat: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based calls
into the block layer from the vvfat driver.

Ideally, the vvfat driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vvfat.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 1569783b0f9..ba27f86a951 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1503,8 +1503,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
                 DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
                              " allocated\n", sector_num,
                              n >> BDRV_SECTOR_BITS));
-                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
-                              n >> BDRV_SECTOR_BITS)) {
+                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_BITS,
+                               buf + i * 0x200, n) < 0) {
                     return -1;
                 }
                 i += (n >> BDRV_SECTOR_BITS) - 1;
@@ -1992,7 +1992,8 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
                         if (res) {
                             return -1;
                         }
-                        res = bdrv_write(s->qcow, offset, s->cluster_buffer, 1);
+                        res = bdrv_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
+                                          s->cluster_buffer, BDRV_SECTOR_SIZE);
                         if (res) {
                             return -2;
                         }
@@ -2155,7 +2156,7 @@ DLOG(checkpoint());
      * - get modified FAT
      * - compare the two FATs (TODO)
      * - get buffer for marking used clusters
-     * - recurse direntries from root (using bs->bdrv_read to make
+     * - recurse direntries from root (using bs->bdrv_pread to make
      *    sure to get the new data)
      *   - check that the FAT agrees with the size
      *   - count the number of clusters occupied by this directory and
@@ -2902,9 +2903,9 @@ static int handle_deletes(BDRVVVFATState* s)
 /*
  * synchronize mapping with new state:
  *
- * - copy FAT (with bdrv_read)
+ * - copy FAT (with bdrv_pread)
  * - mark all filenames corresponding to mappings as deleted
- * - recurse direntries from root (using bs->bdrv_read)
+ * - recurse direntries from root (using bs->bdrv_pread)
  * - delete files corresponding to mappings marked as deleted
  */
 static int do_commit(BDRVVVFATState* s)
@@ -2924,10 +2925,10 @@ static int do_commit(BDRVVVFATState* s)
         return ret;
     }

-    /* copy FAT (with bdrv_read) */
+    /* copy FAT (with bdrv_pread) */
     memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);

-    /* recurse direntries from root (using bs->bdrv_read) */
+    /* recurse direntries from root (using bs->bdrv_pread) */
     ret = commit_direntries(s, 0, -1);
     if (ret) {
         fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
@@ -3041,7 +3042,8 @@ DLOG(checkpoint());
      * Use qcow backend. Commit later.
      */
 DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
-    ret = bdrv_write(s->qcow, sector_num, buf, nb_sectors);
+    ret = bdrv_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE, buf,
+                      nb_sectors * BDRV_SECTOR_SIZE);
     if (ret < 0) {
         fprintf(stderr, "Error writing to qcow backend\n");
         return ret;
-- 
2.14.3
