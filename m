Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXi4-0007Qi-Lv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXi3-0001pP-Fk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:40:56 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:40:33 +0100
Message-Id: <20170313214045.26857-2-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 04/16] qemu-img: Expose PreallocMode
 for resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add a --preallocation command line option to qemu-img resize which can
be used to set the PreallocMode parameter of blk_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c    | 33 ++++++++++++++++++++++++++++++---
 qemu-img.texi |  7 ++++++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 3e637a932b..a5fdd30202 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu-version.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qerror.h"
@@ -59,6 +60,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_PREALLOCATION = 263,
 };
 
 typedef enum OutputFormat {
@@ -3317,9 +3319,10 @@ static int img_resize(int argc, char **argv)
     Error *err = NULL;
     int c, ret, relative;
     const char *filename, *fmt, *size;
-    int64_t n, total_size;
+    int64_t n, total_size, current_size;
     bool quiet = false;
     BlockBackend *blk = NULL;
+    PreallocMode prealloc = PREALLOC_MODE_OFF;
     QemuOpts *param;
 
     static QemuOptsList resize_options = {
@@ -3353,6 +3356,7 @@ static int img_resize(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"preallocation", required_argument, 0, OPTION_PREALLOCATION},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, "f:hq",
@@ -3382,6 +3386,15 @@ static int img_resize(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case OPTION_PREALLOCATION:
+            prealloc = qapi_enum_parse(PreallocMode_lookup, optarg,
+                                       PREALLOC_MODE__MAX, PREALLOC_MODE__MAX,
+                                       NULL);
+            if (prealloc == PREALLOC_MODE__MAX) {
+                error_report("Invalid preallocation mode '%s'", optarg);
+                return 1;
+            }
+            break;
         }
     }
     if (optind != argc - 1) {
@@ -3429,8 +3442,16 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
+    current_size = blk_getlength(blk);
+    if (current_size < 0) {
+        error_report("Failed to inquire current image length: %s\n",
+                     strerror(-current_size));
+        ret = -1;
+        goto out;
+    }
+
     if (relative) {
-        total_size = blk_getlength(blk) + n * relative;
+        total_size = current_size + n * relative;
     } else {
         total_size = n;
     }
@@ -3440,7 +3461,13 @@ static int img_resize(int argc, char **argv)
         goto out;
     }
 
-    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, &err);
+    if (total_size <= current_size && prealloc != PREALLOC_MODE_OFF) {
+        error_report("Preallocation can only be used for growing images");
+        ret = -1;
+        goto out;
+    }
+
+    ret = blk_truncate(blk, total_size, prealloc, &err);
     if (!ret) {
         qprintf(quiet, "Image resized.\n");
     } else {
diff --git a/qemu-img.texi b/qemu-img.texi
index c81db3e81c..ad46fa5f05 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -490,7 +490,7 @@ qemu-img rebase -b base.img diff.qcow2
 At this point, @code{modified.img} can be discarded, since
 @code{base.img + diff.qcow2} contains the same information.
 
-@item resize @var{filename} [+ | -]@var{size}
+@item resize [--preallocation=@var{prealloc}] @var{filename} [+ | -]@var{size}
 
 Change the disk image as if it had been created with @var{size}.
 
@@ -502,6 +502,11 @@ After using this command to grow a disk image, you must use file system and
 partitioning tools inside the VM to actually begin using the new space on the
 device.
 
+When growing an image, the @code{--preallocation} option may be used to specify
+how the additional image area should be allocated on the host.  See the format
+description in the @code{NOTES} section which values are allowed.  Using this
+option may result in more data being allocated than necessary.
+
 @item amend [-p] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 
 Amends the image format specific @var{options} for the image file
-- 
2.12.0
