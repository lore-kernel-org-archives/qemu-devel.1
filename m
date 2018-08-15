Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplz4-0001ij-E3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fplz2-00078Y-6q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 22:56:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Aug 2018 21:56:14 -0500
Message-Id: <20180815025614.53588-3-eblake@redhat.com>
In-Reply-To: <20180815025614.53588-1-eblake@redhat.com>
References: <20180815025614.53588-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

For feature parity with dd, we want to be able to specify
the offset within the output file, just as we can specify
the offset for the input (in particular, this makes copying
a subset range of guest-visible bytes from one file to
another much easier).

The code style for 'qemu-img dd' was pretty hard to read;
unfortunately this patch focuses only on adding the new
feature in the existing style rather than trying to improve
the overall flow, other than switching octal constants to
hex.  Oh well.

Also, switch the test to use an offset of 0 instead of 1,
to test skip= and seek= on their own; as it is, this is
effectively quadrupling the test runtime, which starts
to make this test borderline on whether it should still
belong to './check -g quick'.  And I didn't bother to
reindent the test shell code for the new nested loop.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c                 |  41 ++++--
 tests/qemu-iotests/160     |  12 +-
 tests/qemu-iotests/160.out | 304 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 336 insertions(+), 21 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d72f0f0ec94..ee01a18f331 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -195,7 +195,8 @@ static void QEMU_NORETURN help(void)
            "  'count=N' copy only N input blocks\n"
            "  'if=FILE' read from FILE\n"
            "  'of=FILE' write to FILE\n"
-           "  'skip=N' skip N bs-sized blocks at the start of input\n";
+           "  'skip=N' skip N bs-sized blocks at the start of input\n"
+           "  'seek=N' skip N bs-sized blocks at the start of output\n";

     printf("%s\nSupported formats:", help_msg);
     bdrv_iterate_format(format_print, NULL);
@@ -4296,11 +4297,12 @@ out:
     return 0;
 }

-#define C_BS      01
-#define C_COUNT   02
-#define C_IF      04
-#define C_OF      010
-#define C_SKIP    020
+#define C_BS      0x1
+#define C_COUNT   0x2
+#define C_IF      0x4
+#define C_OF      0x8
+#define C_SKIP    0x10
+#define C_SEEK    0x20

 struct DdInfo {
     unsigned int flags;
@@ -4383,6 +4385,20 @@ static int img_dd_skip(const char *arg,
     return 0;
 }

+static int img_dd_seek(const char *arg,
+                       struct DdIo *in, struct DdIo *out,
+                       struct DdInfo *dd)
+{
+    out->offset = cvtnum(arg);
+
+    if (out->offset < 0) {
+        error_report("invalid number: '%s'", arg);
+        return 1;
+    }
+
+    return 0;
+}
+
 static int img_dd(int argc, char **argv)
 {
     int ret = 0;
@@ -4399,6 +4415,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos, end;
+    int64_t seek = 0;
     bool force_share = false;
     struct DdInfo dd = {
         .flags = 0,
@@ -4423,6 +4440,7 @@ static int img_dd(int argc, char **argv)
         { "if", img_dd_if, C_IF },
         { "of", img_dd_of, C_OF },
         { "skip", img_dd_skip, C_SKIP },
+        { "seek", img_dd_seek, C_SEEK },
         { NULL, NULL, 0 }
     };
     const struct option long_options[] = {
@@ -4574,7 +4592,14 @@ static int img_dd(int argc, char **argv)
         size = dd.count * in.bsz;
     }

-    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
+    if (dd.flags & C_SEEK && out.offset * out.bsz > INT64_MAX - size) {
+        error_report("Seek too large for '%s'", out.filename);
+        ret = -1;
+        goto out;
+    }
+    seek = out.offset * out.bsz;
+
+    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size + seek, &error_abort);
     end = size + in_pos;

     ret = bdrv_create(drv, out.filename, opts, &local_err);
@@ -4617,7 +4642,7 @@ static int img_dd(int argc, char **argv)
         }
         in_pos += in_ret;

-        out_ret = blk_pwrite(blk2, out_pos, in.buf, in_ret, 0);
+        out_ret = blk_pwrite(blk2, out_pos + seek, in.buf, in_ret, 0);

         if (out_ret < 0) {
             error_report("error while writing to output image file: %s",
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 48380a3aafc..0096911e75e 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -1,6 +1,6 @@
 #! /bin/bash
 #
-# qemu-img dd test for the skip option
+# qemu-img dd test for the skip/seek option
 #
 # Copyright (C) 2016 Reda Sallahi
 #
@@ -41,10 +41,11 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux

-TEST_SKIP_BLOCKS="1 2 30 30K"
+TEST_SKIP_BLOCKS="0 2 30 30K"

 for skip in $TEST_SKIP_BLOCKS; do
   for count in '' 'count=1 '; do
+   for seek in $TEST_SKIP_BLOCKS; do
     echo
     echo "== Creating image =="

@@ -54,18 +55,19 @@ for skip in $TEST_SKIP_BLOCKS; do
     $QEMU_IO -c "write -P 0xa 24 512k" "$TEST_IMG" | _filter_qemu_io

     echo
-    echo "== Converting the image with dd with ${count}skip=$skip =="
+    echo "== Converting the image with dd with ${count}skip=$skip seek=$seek =="

-    $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" $count skip="$skip" -O "$IMGFMT" \
+    $QEMU_IMG dd if="$TEST_IMG" of="$TEST_IMG.out" $count skip="$skip" seek="$seek" -O "$IMGFMT" \
         2> /dev/null
     TEST_IMG="$TEST_IMG.out" _check_test_img
-    dd if="$TEST_IMG" of="$TEST_IMG.out.dd" $count skip="$skip" status=none
+    dd if="$TEST_IMG" of="$TEST_IMG.out.dd" $count skip="$skip" seek="$seek" status=none

     echo
     echo "== Compare the images with qemu-img compare =="

     $QEMU_IMG compare "$TEST_IMG.out.dd" "$TEST_IMG.out"
     rm "$TEST_IMG.out.dd"
+   done
   done
 done

diff --git a/tests/qemu-iotests/160.out b/tests/qemu-iotests/160.out
index 6147a8493d6..b93ecad05cf 100644
--- a/tests/qemu-iotests/160.out
+++ b/tests/qemu-iotests/160.out
@@ -6,7 +6,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with skip=1 ==
+== Converting the image with dd with skip=0 seek=0 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -18,7 +18,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with count=1 skip=1 ==
+== Converting the image with dd with skip=0 seek=2 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -30,7 +30,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with skip=2 ==
+== Converting the image with dd with skip=0 seek=30 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -42,7 +42,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with count=1 skip=2 ==
+== Converting the image with dd with skip=0 seek=30K ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -54,7 +54,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with skip=30 ==
+== Converting the image with dd with count=1 skip=0 seek=0 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -66,7 +66,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with count=1 skip=30 ==
+== Converting the image with dd with count=1 skip=0 seek=2 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -78,7 +78,7 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with skip=30K ==
+== Converting the image with dd with count=1 skip=0 seek=30 ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
@@ -90,7 +90,295 @@ No errors were found on the image.
 wrote 524288/524288 bytes at offset 24
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-== Converting the image with dd with count=1 skip=30K ==
+== Converting the image with dd with count=1 skip=0 seek=30K ==
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
+== Converting the image with dd with skip=2 seek=0 ==
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
+== Converting the image with dd with skip=2 seek=2 ==
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
+== Converting the image with dd with skip=2 seek=30 ==
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
+== Converting the image with dd with skip=2 seek=30K ==
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
+== Converting the image with dd with count=1 skip=2 seek=0 ==
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
+== Converting the image with dd with count=1 skip=2 seek=2 ==
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
+== Converting the image with dd with count=1 skip=2 seek=30 ==
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
+== Converting the image with dd with count=1 skip=2 seek=30K ==
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
+== Converting the image with dd with skip=30 seek=0 ==
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
+== Converting the image with dd with skip=30 seek=2 ==
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
+== Converting the image with dd with skip=30 seek=30 ==
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
+== Converting the image with dd with skip=30 seek=30K ==
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
+== Converting the image with dd with count=1 skip=30 seek=0 ==
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
+== Converting the image with dd with count=1 skip=30 seek=2 ==
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
+== Converting the image with dd with count=1 skip=30 seek=30 ==
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
+== Converting the image with dd with count=1 skip=30 seek=30K ==
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
+== Converting the image with dd with skip=30K seek=0 ==
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
+== Converting the image with dd with skip=30K seek=2 ==
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
+== Converting the image with dd with skip=30K seek=30 ==
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
+== Converting the image with dd with skip=30K seek=30K ==
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
+== Converting the image with dd with count=1 skip=30K seek=0 ==
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
+== Converting the image with dd with count=1 skip=30K seek=2 ==
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
+== Converting the image with dd with count=1 skip=30K seek=30 ==
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
+== Converting the image with dd with count=1 skip=30K seek=30K ==
 No errors were found on the image.

 == Compare the images with qemu-img compare ==
-- 
2.14.4
