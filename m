Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkm6-0000qV-BA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkm0-00071O-0P
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:22 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 13 Jun 2017 15:16:36 +0300
Message-Id: <20170613121639.17853-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/4] qemu-img: add --shrink flag for resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pbutsykin@virtuozzo.com, den@openvz.org

The flag as additional precaution of data loss. Perhaps in the future the
operation shrink without this flag will be banned, but while we need to
maintain compatibility.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 qemu-img-cmds.hx       |  4 ++--
 qemu-img.c             | 15 +++++++++++++++
 qemu-img.texi          |  5 ++++-
 tests/qemu-iotests/102 |  4 ++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index a39fcdba71..3b2eab9d20 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -76,9 +76,9 @@ STEXI
 ETEXI
 
 DEF("resize", img_resize,
-    "resize [--object objectdef] [--image-opts] [-q] filename [+ | -]size")
+    "resize [--object objectdef] [--image-opts] [-q] [--shrink] filename [+ | -]size")
 STEXI
-@item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filename} [+ | -]@var{size}
+@item resize [--object @var{objectdef}] [--image-opts] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
 
 DEF("amend", img_amend,
diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d7f1..bfe5f61b0b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -61,6 +61,7 @@ enum {
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
     OPTION_TARGET_IMAGE_OPTS = 263,
+    OPTION_SHRINK = 264,
 };
 
 typedef enum OutputFormat {
@@ -3452,6 +3453,7 @@ static int img_resize(int argc, char **argv)
         },
     };
     bool image_opts = false;
+    bool shrink = false;
 
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
@@ -3469,6 +3471,7 @@ static int img_resize(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"shrink", no_argument, 0, OPTION_SHRINK},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":f:hq",
@@ -3503,6 +3506,9 @@ static int img_resize(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case OPTION_SHRINK:
+            shrink = true;
+            break;
         }
     }
     if (optind != argc - 1) {
@@ -3562,6 +3568,15 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
+    if (total_size < blk_getlength(blk) && !shrink) {
+        qprintf(quiet, "Warning: shrinking of the image can lead to data loss. "
+                       "Before performing shrink operation you must make sure "
+                       "that the shrink part of image doesn't contain important"
+                       " data.\n");
+        qprintf(quiet,
+                "If you don't want to see this message use --shrink option.\n");
+    }
+
     ret = blk_truncate(blk, total_size, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
diff --git a/qemu-img.texi b/qemu-img.texi
index 5b925ecf41..c2b694cd00 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -499,7 +499,7 @@ qemu-img rebase -b base.img diff.qcow2
 At this point, @code{modified.img} can be discarded, since
 @code{base.img + diff.qcow2} contains the same information.
 
-@item resize @var{filename} [+ | -]@var{size}
+@item resize [--shrink] @var{filename} [+ | -]@var{size}
 
 Change the disk image as if it had been created with @var{size}.
 
@@ -507,6 +507,9 @@ Before using this command to shrink a disk image, you MUST use file system and
 partitioning tools inside the VM to reduce allocated file systems and partition
 sizes accordingly.  Failure to do so will result in data loss!
 
+If @code{--shrink} is specified, warning about data loss doesn't print for
+the shrink operation.
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
-- 
2.13.0
