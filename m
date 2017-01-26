Received: from eggs.gnu.org ([2001:4830:134:3::10]:55688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrL-00085y-Vf
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrK-0003jv-PJ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:04:55 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 11:04:32 +0000
Message-Id: <20170126110435.2777-4-berrange@redhat.com>
In-Reply-To: <20170126110435.2777-1-berrange@redhat.com>
References: <20170126110435.2777-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to dd
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -n arg to the convert command allows use of a pre-existing image,
rather than creating a new image. This adds a -n arg to the dd command
to get feature parity.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |  4 +--
 qemu-img.c       | 79 ++++++++++++++++++++++++++++++++++++--------------------
 qemu-img.texi    |  7 ++++-
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index f054599..6732713 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ STEXI
 ETEXI
 
 DEF("dd", img_dd,
-    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
+    "dd [--image-opts] [-n] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
-@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [-n] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 ETEXI
 
 DEF("info", img_info,
diff --git a/qemu-img.c b/qemu-img.c
index 629f9e9..4d8d041 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3917,10 +3917,10 @@ static int img_dd(int argc, char **argv)
     QemuOptsList *create_opts = NULL;
     Error *local_err = NULL;
     bool image_opts = false;
-    int c, i;
+    int c, i, skip_create = 0;
     const char *out_fmt = "raw";
     const char *fmt = NULL;
-    int64_t size = 0;
+    int64_t size = 0, out_size;
     int64_t block_count = 0, out_pos, in_pos;
     struct DdInfo dd = {
         .flags = 0,
@@ -3954,7 +3954,7 @@ static int img_dd(int argc, char **argv)
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, "hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hnf:O:", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -3965,6 +3965,9 @@ static int img_dd(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'n':
+            skip_create = 1;
+            break;
         case '?':
             error_report("Try 'qemu-img --help' for more information.");
             ret = -1;
@@ -4051,22 +4054,25 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    if (!drv->create_opts) {
-        error_report("Format driver '%s' does not support image creation",
-                     drv->format_name);
-        ret = -1;
-        goto out;
-    }
-    if (!proto_drv->create_opts) {
-        error_report("Protocol driver '%s' does not support image creation",
-                     proto_drv->format_name);
-        ret = -1;
-        goto out;
-    }
-    create_opts = qemu_opts_append(create_opts, drv->create_opts);
-    create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
 
-    opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    if (!skip_create) {
+        if (!drv->create_opts) {
+            error_report("Format driver '%s' does not support image creation",
+                         drv->format_name);
+            ret = -1;
+            goto out;
+        }
+        if (!proto_drv->create_opts) {
+            error_report("Protocol driver '%s' does not support image creation",
+                         proto_drv->format_name);
+            ret = -1;
+            goto out;
+        }
+        create_opts = qemu_opts_append(create_opts, drv->create_opts);
+        create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
+
+        opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    }
 
     size = blk_getlength(blk1);
     if (size < 0) {
@@ -4083,19 +4089,22 @@ static int img_dd(int argc, char **argv)
     /* Overflow means the specified offset is beyond input image's size */
     if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
                               size < in.bsz * in.offset)) {
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, 0, &error_abort);
+        out_size = 0;
     } else {
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                            size - in.bsz * in.offset, &error_abort);
+        out_size = size - in.bsz * in.offset;
     }
 
-    ret = bdrv_create(drv, out.filename, opts, &local_err);
-    if (ret < 0) {
-        error_reportf_err(local_err,
-                          "%s: error while creating output image: ",
-                          out.filename);
-        ret = -1;
-        goto out;
+    if (!skip_create) {
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, out_size, &error_abort);
+
+        ret = bdrv_create(drv, out.filename, opts, &local_err);
+        if (ret < 0) {
+            error_reportf_err(local_err,
+                              "%s: error while creating output image: ",
+                              out.filename);
+            ret = -1;
+            goto out;
+        }
     }
 
     /* TODO, we can't honour --image-opts for the target,
@@ -4111,6 +4120,20 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
+    if (skip_create) {
+        int64_t existing_size = blk_getlength(blk2);
+        if (existing_size < 0) {
+            error_report("unable to get output image length: %s",
+                         strerror(-existing_size));
+            ret = -1;
+            goto out;
+        } else if (existing_size < out_size) {
+            error_report("output file is smaller than input data length");
+            ret = -1;
+            goto out;
+        }
+    }
+
     if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
                               size < in.offset * in.bsz)) {
         /* We give a warning if the skip option is bigger than the input
diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae3..b952d6a 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -326,7 +326,7 @@ skipped. This is useful for formats such as @code{rbd} if the target
 volume has already been created with site specific options that cannot
 be supplied through qemu-img.
 
-@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [-n] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
 @var{fmt} format to @var{output_fmt} format.
@@ -337,6 +337,11 @@ dd will stop reading input after reading @var{blocks} input blocks.
 
 The size syntax is similar to dd(1)'s size syntax.
 
+If the @code{-n} option is specified, the target volume creation will be
+skipped. This is useful for formats such as @code{rbd} if the target
+volume has already been created with site specific options that cannot
+be supplied through qemu-img.
+
 @item info [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] @var{filename}
 
 Give information about the disk image @var{filename}. Use it in
-- 
2.9.3
