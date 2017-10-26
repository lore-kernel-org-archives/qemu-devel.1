Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3f-0000qf-6Y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3d-0002MB-Px
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:27 +0200
Message-Id: <20171026131741.5059-22-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/35] qemu-img: Change img_rebase() to be
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
the internal iteration of img_rebase().  We can finally drop the
TODO assertion added earlier, now that the entire algorithm is
byte-based and no longer has to shift from bytes to sectors.

Most of the change is mechanical ('num_sectors' becomes 'size',
'sector' becomes 'offset', 'n' goes from sectors to bytes); some
of it is also a cleanup (use of MIN() instead of open-coding,
loss of variable 'count' added earlier in commit d6a644bb).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 84 +++++++++++++++++++++++++-------------------------------------
 1 file changed, 34 insertions(+), 50 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c6b6263853..994365c6a4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3248,70 +3248,58 @@ static int img_rebase(int argc, char **argv)
      * the image is the same as the original one at any time.
      */
     if (!unsafe) {
-        int64_t num_sectors;
-        int64_t old_backing_num_sectors;
-        int64_t new_backing_num_sectors = 0;
-        uint64_t sector;
-        int n;
-        int64_t count;
+        int64_t size;
+        int64_t old_backing_size;
+        int64_t new_backing_size = 0;
+        uint64_t offset;
+        int64_t n;
         float local_progress = 0;
 
         buf_old = blk_blockalign(blk, IO_BUF_SIZE);
         buf_new = blk_blockalign(blk, IO_BUF_SIZE);
 
-        num_sectors = blk_nb_sectors(blk);
-        if (num_sectors < 0) {
+        size = blk_getlength(blk);
+        if (size < 0) {
             error_report("Could not get size of '%s': %s",
-                         filename, strerror(-num_sectors));
+                         filename, strerror(-size));
             ret = -1;
             goto out;
         }
-        old_backing_num_sectors = blk_nb_sectors(blk_old_backing);
-        if (old_backing_num_sectors < 0) {
+        old_backing_size = blk_getlength(blk_old_backing);
+        if (old_backing_size < 0) {
             char backing_name[PATH_MAX];
 
             bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
             error_report("Could not get size of '%s': %s",
-                         backing_name, strerror(-old_backing_num_sectors));
+                         backing_name, strerror(-old_backing_size));
             ret = -1;
             goto out;
         }
         if (blk_new_backing) {
-            new_backing_num_sectors = blk_nb_sectors(blk_new_backing);
-            if (new_backing_num_sectors < 0) {
+            new_backing_size = blk_getlength(blk_new_backing);
+            if (new_backing_size < 0) {
                 error_report("Could not get size of '%s': %s",
-                             out_baseimg, strerror(-new_backing_num_sectors));
+                             out_baseimg, strerror(-new_backing_size));
                 ret = -1;
                 goto out;
             }
         }
 
-        if (num_sectors != 0) {
-            local_progress = (float)100 /
-                (num_sectors / MIN(num_sectors, IO_BUF_SIZE / 512));
+        if (size != 0) {
+            local_progress = (float)100 / (size / MIN(size, IO_BUF_SIZE));
         }
 
-        for (sector = 0; sector < num_sectors; sector += n) {
-
-            /* How many sectors can we handle with the next read? */
-            if (sector + (IO_BUF_SIZE / 512) <= num_sectors) {
-                n = (IO_BUF_SIZE / 512);
-            } else {
-                n = num_sectors - sector;
-            }
+        for (offset = 0; offset < size; offset += n) {
+            /* How many bytes can we handle with the next read? */
+            n = MIN(IO_BUF_SIZE, size - offset);
 
             /* If the cluster is allocated, we don't need to take action */
-            ret = bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,
-                                    n << BDRV_SECTOR_BITS, &count);
+            ret = bdrv_is_allocated(bs, offset, n, &n);
             if (ret < 0) {
                 error_report("error while reading image metadata: %s",
                              strerror(-ret));
                 goto out;
             }
-            /* TODO relax this once bdrv_is_allocated does not enforce
-             * sector alignment */
-            assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-            n = count >> BDRV_SECTOR_BITS;
             if (ret) {
                 continue;
             }
@@ -3320,30 +3308,28 @@ static int img_rebase(int argc, char **argv)
              * Read old and new backing file and take into consideration that
              * backing files may be smaller than the COW image.
              */
-            if (sector >= old_backing_num_sectors) {
-                memset(buf_old, 0, n * BDRV_SECTOR_SIZE);
+            if (offset >= old_backing_size) {
+                memset(buf_old, 0, n);
             } else {
-                if (sector + n > old_backing_num_sectors) {
-                    n = old_backing_num_sectors - sector;
+                if (offset + n > old_backing_size) {
+                    n = old_backing_size - offset;
                 }
 
-                ret = blk_pread(blk_old_backing, sector << BDRV_SECTOR_BITS,
-                                buf_old, n << BDRV_SECTOR_BITS);
+                ret = blk_pread(blk_old_backing, offset, buf_old, n);
                 if (ret < 0) {
                     error_report("error while reading from old backing file");
                     goto out;
                 }
             }
 
-            if (sector >= new_backing_num_sectors || !blk_new_backing) {
-                memset(buf_new, 0, n * BDRV_SECTOR_SIZE);
+            if (offset >= new_backing_size || !blk_new_backing) {
+                memset(buf_new, 0, n);
             } else {
-                if (sector + n > new_backing_num_sectors) {
-                    n = new_backing_num_sectors - sector;
+                if (offset + n > new_backing_size) {
+                    n = new_backing_size - offset;
                 }
 
-                ret = blk_pread(blk_new_backing, sector << BDRV_SECTOR_BITS,
-                                buf_new, n << BDRV_SECTOR_BITS);
+                ret = blk_pread(blk_new_backing, offset, buf_new, n);
                 if (ret < 0) {
                     error_report("error while reading from new backing file");
                     goto out;
@@ -3353,15 +3339,13 @@ static int img_rebase(int argc, char **argv)
             /* If they differ, we need to write to the COW file */
             uint64_t written = 0;
 
-            while (written < n * BDRV_SECTOR_SIZE) {
+            while (written < n) {
                 int64_t pnum;
 
-                if (compare_buffers(buf_old + written,
-                                    buf_new + written,
-                                    n * BDRV_SECTOR_SIZE - written, &pnum))
+                if (compare_buffers(buf_old + written, buf_new + written,
+                                    n - written, &pnum))
                 {
-                    ret = blk_pwrite(blk,
-                                     (sector << BDRV_SECTOR_BITS) + written,
+                    ret = blk_pwrite(blk, offset + written,
                                      buf_old + written, pnum, 0);
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
-- 
2.13.6
