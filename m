Received: from eggs.gnu.org ([2001:4830:134:3::10]:55026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplz1-0001hH-1N
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplyz-00077u-L3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Aug 2018 21:56:13 -0500
Message-Id: <20180815025614.53588-2-eblake@redhat.com>
In-Reply-To: <20180815025614.53588-1-eblake@redhat.com>
References: <20180815025614.53588-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-img: Fix dd with skip= and count=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

When both skip= and count= are active, qemu-img dd was not copying
enough data. It didn't help that the code made the same check for
dd.flags & C_SKIP in two separate places. Compute 'size' as the
amount of bytes to be read, and 'end' as the offset to end at,
rather than trying to cram both meanings into a single variable
(which only worked as long as we had at most one of those two
limiting factors to worry about, but not both).

Enhance the test to cover more combinations, and expose the problem.

Signed-off-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org
---
 qemu-img.c                 | 39 ++++++++++++++++---------------------
 tests/qemu-iotests/160     |  9 ++++++---
 tests/qemu-iotests/160.out | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1acddf693c6..d72f0f0ec94 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4398,7 +4398,7 @@ static int img_dd(int argc, char **argv)
     const char *out_fmt = "raw";
     const char *fmt = NULL;
     int64_t size = 0;
-    int64_t block_count = 0, out_pos, in_pos;
+    int64_t block_count = 0, out_pos, in_pos, end;
     bool force_share = false;
     struct DdInfo dd = {
         .flags = 0,
@@ -4559,19 +4559,23 @@ static int img_dd(int argc, char **argv)
         goto out;
     }

+    /* Overflow means the specified offset is beyond input image's size */
+    if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
+                              size < in.bsz * in.offset)) {
+        size = 0;
+        error_report("%s: cannot skip to specified offset", in.filename);
+    } else {
+        size -= in.offset * in.bsz;
+        in_pos = in.offset * in.bsz;
+    }
+
     if (dd.flags & C_COUNT && dd.count <= INT64_MAX / in.bsz &&
         dd.count * in.bsz < size) {
         size = dd.count * in.bsz;
     }

-    /* Overflow means the specified offset is beyond input image's size */
-    if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
-                              size < in.bsz * in.offset)) {
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, 0, &error_abort);
-    } else {
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                            size - in.bsz * in.offset, &error_abort);
-    }
+    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
+    end = size + in_pos;

     ret = bdrv_create(drv, out.filename, opts, &local_err);
     if (ret < 0) {
@@ -4595,24 +4599,13 @@ static int img_dd(int argc, char **argv)
         goto out;
     }

-    if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
-                              size < in.offset * in.bsz)) {
-        /* We give a warning if the skip option is bigger than the input
-         * size and create an empty output disk image (i.e. like dd(1)).
-         */
-        error_report("%s: cannot skip to specified offset", in.filename);
-        in_pos = size;
-    } else {
-        in_pos = in.offset * in.bsz;
-    }
-
     in.buf = g_new(uint8_t, in.bsz);

-    for (out_pos = 0; in_pos < size; block_count++) {
+    for (out_pos = 0; in_pos < end; block_count++) {
         int in_ret, out_ret;

-        if (in_pos + in.bsz > size) {
-            in_ret = blk_pread(blk1, in_pos, in.buf, size - in_pos);
+        if (in_pos + in.bsz > end) {
+            in_ret = blk_pread(blk1, in_pos, in.buf, end - in_pos);
         } else {
             in_ret = blk_pread(blk1, in_pos, in.buf, in.bsz);
         }
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 5c910e5bfc1..48380a3aafc 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -44,6 +44,7 @@ _supported_os Linux
 TEST_SKIP_BLOCKS="1 2 30 30K"

 for skip in $TEST_SKIP_BLOCKS; do
+  for count in '' 'count=1 '; do
     echo
     echo "== Creating image =="

@@ -53,17 +54,19 @@ for skip in $TEST_SKIP_BLOCKS; do
     $QEMU_IO -c "write -P 0xa 24 512k" "$TEST_IMG" | _filter_qemu_io

     echo
-    echo "== Converting the image with dd with skip=$skip =="
+    echo "== Converting the image with dd with ${count}skip=$skip =="

-    $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" skip="$skip" -O "$IMGFMT" \
+    $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" $count skip="$skip" -O "$IMGFMT" \
         2> /dev/null
     TEST_IMG="$TEST_IMG.out" _check_test_img
-    dd if="$TEST_IMG" of="$TEST_IMG.out.dd" skip="$skip" status=none
+    dd if="$TEST_IMG" of="$TEST_IMG.out.dd" $count skip="$skip" status=none

     echo
     echo "== Compare the images with qemu-img compare =="

     $QEMU_IMG compare "$TEST_IMG.out.dd" "$TEST_IMG.out"
+    rm "$TEST_IMG.out.dd"
+  done
 done

 echo
diff --git a/tests/qemu-iotests/160.out b/tests/qemu-iotests/160.out
index 9cedc803566..6147a8493d6 100644
--- a/tests/qemu-iotests/160.out
+++ b/tests/qemu-iotests/160.out
@@ -18,6 +18,18 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

+== Converting the image with dd with count=1 skip=1 ==
+No errors were found on the image.
+
+== Compare the images with qemu-img compare ==
+Images are identical.
+
+== Creating image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+No errors were found on the image.
+wrote 524288/524288 bytes at offset 24
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == Converting the image with dd with skip=2 ==
 No errors were found on the image.

@@ -30,6 +42,18 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

+== Converting the image with dd with count=1 skip=2 ==
+No errors were found on the image.
+
+== Compare the images with qemu-img compare ==
+Images are identical.
+
+== Creating image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+No errors were found on the image.
+wrote 524288/524288 bytes at offset 24
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == Converting the image with dd with skip=30 ==
 No errors were found on the image.

@@ -42,10 +66,34 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

+== Converting the image with dd with count=1 skip=30 ==
+No errors were found on the image.
+
+== Compare the images with qemu-img compare ==
+Images are identical.
+
+== Creating image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+No errors were found on the image.
+wrote 524288/524288 bytes at offset 24
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == Converting the image with dd with skip=30K ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
 Images are identical.

+== Creating image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+No errors were found on the image.
+wrote 524288/524288 bytes at offset 24
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== Converting the image with dd with count=1 skip=30K ==
+No errors were found on the image.
+
+== Compare the images with qemu-img compare ==
+Images are identical.
+
 *** done
-- 
2.14.4
