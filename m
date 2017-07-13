Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgM8-00066i-BX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgM5-0006Jo-90
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:44 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:04 -0500
Message-Id: <20170713154711.32374-17-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 16/23] qemu-img: Drop redundant error
 message in compare
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

If a read error is encountered during 'qemu-img compare', we
were printing the "Error while reading offset ..." message twice.
Update the testsuite for the improved output.

Further simplify the code by hoisting the error code conversion
into the helper function, rather than repeating it at the callers.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 qemu-img.c                 | 19 +++++--------------
 tests/qemu-iotests/074.out |  2 --
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e54c47a..c0fd773 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1190,8 +1190,10 @@ static int64_t sectors_to_bytes(int64_t sectors)
 /*
  * Check if passed sectors are empty (not allocated or contain only 0 bytes)
  *
- * Returns 0 in case sectors are filled with 0, 1 if sectors contain non-zero
- * data and negative value on error.
+ * Intended for use by 'qemu-img compare': Returns 0 in case sectors are
+ * filled with 0, 1 if sectors contain non-zero data (this is a comparison
+ * failure), and 4 on error (the exit status for read errors), after emitting
+ * an error message.
  *
  * @param blk:  BlockBackend for the image
  * @param sect_num: Number of first sector to check
@@ -1212,7 +1214,7 @@ static int check_empty_sectors(BlockBackend *blk, int64_t sect_num,
     if (ret < 0) {
         error_report("Error while reading offset %" PRId64 " of %s: %s",
                      sectors_to_bytes(sect_num), filename, strerror(-ret));
-        return ret;
+        return 4;
     }
     idx = find_nonzero(buffer, sect_count * BDRV_SECTOR_SIZE);
     if (idx >= 0) {
@@ -1467,11 +1469,6 @@ static int img_compare(int argc, char **argv)
                                           filename2, buf1, quiet);
             }
             if (ret) {
-                if (ret < 0) {
-                    error_report("Error while reading offset %" PRId64 ": %s",
-                                 sectors_to_bytes(sector_num), strerror(-ret));
-                    ret = 4;
-                }
                 goto out;
             }
         }
@@ -1516,12 +1513,6 @@ static int img_compare(int argc, char **argv)
                 ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
                                           filename_over, buf1, quiet);
                 if (ret) {
-                    if (ret < 0) {
-                        error_report("Error while reading offset %" PRId64
-                                     " of %s: %s", sectors_to_bytes(sector_num),
-                                     filename_over, strerror(-ret));
-                        ret = 4;
-                    }
                     goto out;
                 }
             }
diff --git a/tests/qemu-iotests/074.out b/tests/qemu-iotests/074.out
index 8fba5ae..ede66c3 100644
--- a/tests/qemu-iotests/074.out
+++ b/tests/qemu-iotests/074.out
@@ -4,7 +4,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
-qemu-img: Error while reading offset 0: Input/output error
 4
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=0
@@ -12,7 +11,6 @@ Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=0
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
-qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 Warning: Image size mismatch!
 4
 Cleanup
-- 
2.9.4
