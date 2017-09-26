Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqks-0001uQ-Dw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqko-0005eW-3M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:29 +0200
Message-Id: <20170926142133.2498-21-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/24] qemu-img: add --shrink flag for resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

The flag is additional precaution against data loss. Perhaps in the future the
operation shrink without this flag will be blocked for all formats, but for now
we need to maintain compatibility with raw.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170918124230.8152-2-pbutsykin@virtuozzo.com
[mreitz: Added a missing space to a warning]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c             | 23 +++++++++++++++++++++++
 qemu-img-cmds.hx       |  4 ++--
 qemu-img.texi          |  6 +++++-
 tests/qemu-iotests/102 |  4 ++--
 tests/qemu-iotests/106 |  2 +-
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index df984b11b9..d6007b2a6d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -64,6 +64,7 @@ enum {
     OPTION_TARGET_IMAGE_OPTS = 263,
     OPTION_SIZE = 264,
     OPTION_PREALLOCATION = 265,
+    OPTION_SHRINK = 266,
 };
 
 typedef enum OutputFormat {
@@ -3436,6 +3437,7 @@ static int img_resize(int argc, char **argv)
         },
     };
     bool image_opts = false;
+    bool shrink = false;
 
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
@@ -3454,6 +3456,7 @@ static int img_resize(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"preallocation", required_argument, 0, OPTION_PREALLOCATION},
+            {"shrink", no_argument, 0, OPTION_SHRINK},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":f:hq",
@@ -3496,6 +3499,9 @@ static int img_resize(int argc, char **argv)
                 return 1;
             }
             break;
+        case OPTION_SHRINK:
+            shrink = true;
+            break;
         }
     }
     if (optind != argc - 1) {
@@ -3569,6 +3575,23 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
+    if (total_size < current_size && !shrink) {
+        warn_report("Shrinking an image will delete all data beyond the "
+                    "shrunken image's end. Before performing such an "
+                    "operation, make sure there is no important data there.");
+
+        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") != 0) {
+            error_report(
+              "Use the --shrink option to perform a shrink operation.");
+            ret = -1;
+            goto out;
+        } else {
+            warn_report("Using the --shrink option will suppress this message. "
+                        "Note that future versions of qemu-img may refuse to "
+                        "shrink images without this option.");
+        }
+    }
+
     ret = blk_truncate(blk, total_size, prealloc, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b47d409665..2fe31893cf 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -89,9 +89,9 @@ STEXI
 ETEXI
 
 DEF("resize", img_resize,
-    "resize [--object objectdef] [--image-opts] [-q] filename [+ | -]size")
+    "resize [--object objectdef] [--image-opts] [-q] [--shrink] filename [+ | -]size")
 STEXI
-@item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filename} [+ | -]@var{size}
+@item resize [--object @var{objectdef}] [--image-opts] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
 
 STEXI
diff --git a/qemu-img.texi b/qemu-img.texi
index 90c7eab4a8..ee5c5940d3 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -545,7 +545,7 @@ qemu-img rebase -b base.img diff.qcow2
 At this point, @code{modified.img} can be discarded, since
 @code{base.img + diff.qcow2} contains the same information.
 
-@item resize [--preallocation=@var{prealloc}] @var{filename} [+ | -]@var{size}
+@item resize [--shrink] [--preallocation=@var{prealloc}] @var{filename} [+ | -]@var{size}
 
 Change the disk image as if it had been created with @var{size}.
 
@@ -553,6 +553,10 @@ Before using this command to shrink a disk image, you MUST use file system and
 partitioning tools inside the VM to reduce allocated file systems and partition
 sizes accordingly.  Failure to do so will result in data loss!
 
+When shrinking images, the @code{--shrink} option must be given. This informs
+qemu-img that the user acknowledges all loss of data beyond the truncated
+image's end.
+
 After using this command to grow a disk image, you must use file system and
 partitioning tools inside the VM to actually begin using the new space on the
 device.
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 87db1bb1bf..d7ad8d9840 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -54,7 +54,7 @@ _make_test_img $IMG_SIZE
 $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 # Remove data cluster from image (first cluster: image header, second: reftable,
 # third: refblock, fourth: L1 table, fifth: L2 table)
-$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
+$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
 
 $QEMU_IO -c map "$TEST_IMG"
 $QEMU_IMG map "$TEST_IMG"
@@ -69,7 +69,7 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 qemu_comm_method=monitor _launch_qemu -drive if=none,file="$TEST_IMG",id=drv0
 
-$QEMU_IMG resize -f raw "$TEST_IMG" $((5 * 64 * 1024))
+$QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
 
 _send_qemu_cmd $QEMU_HANDLE 'qemu-io drv0 map' 'allocated' \
     | sed -e 's/^(qemu).*qemu-io drv0 map...$/(qemu) qemu-io drv0 map/'
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 32649578fb..bfe71f4e60 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -83,7 +83,7 @@ echo '=== Testing image shrinking ==='
 for growth_mode in falloc full off; do
     echo
     echo "--- growth_mode=$growth_mode ---"
-    $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" -${GROWTH_SIZE}K
+    $QEMU_IMG resize -f "$IMGFMT" --shrink --preallocation=$growth_mode "$TEST_IMG" -${GROWTH_SIZE}K
 done
 
 # success, all done
-- 
2.13.5
