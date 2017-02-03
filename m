Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbV-0003AN-Ic
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbS-0001pD-Pm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Feb 2017 12:02:51 +0000
Message-Id: <20170203120254.15062-4-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-1-berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] qemu-img: add support for conv=nocreat,
 notrunc args to dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -n arg to the convert command allows use of a pre-existing image,
rather than creating a new image. This adds equivalent functionality
to the dd command using the 'conv' arg. If 'conv=nocreat' is used,
then it will assume the image already exists. The existing image
will be truncated to match the required output size. 'conv=notrunc'
cna be used to preserve the existing image size.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |   4 +-
 qemu-img.c       | 137 +++++++++++++++++++++++++++++++++++++++++--------------
 qemu-img.texi    |  10 +++-
 3 files changed, 115 insertions(+), 36 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index f054599..b2c5424 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ STEXI
 ETEXI
 
 DEF("dd", img_dd,
-    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
+    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] [conv=nocreat,notrunc] if=input of=output")
 STEXI
-@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] [conv=nocreat,notrunc] if=@var{input} of=@var{output}
 ETEXI
 
 DEF("info", img_info,
diff --git a/qemu-img.c b/qemu-img.c
index 629f9e9..c9ab9e5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -174,7 +174,9 @@ static void QEMU_NORETURN help(void)
            "  'count=N' copy only N input blocks\n"
            "  'if=FILE' read from FILE\n"
            "  'of=FILE' write to FILE\n"
-           "  'skip=N' skip N bs-sized blocks at the start of input\n";
+           "  'skip=N' skip N bs-sized blocks at the start of input\n"
+           "  'conv=nocreat' don't create the output file\n"
+           "  'conv=notrunc' don't truncate the output file\n";
 
     printf("%s\nSupported formats:", help_msg);
     bdrv_iterate_format(format_print, NULL);
@@ -3814,11 +3816,13 @@ out:
     return 0;
 }
 
-#define C_BS      01
-#define C_COUNT   02
-#define C_IF      04
-#define C_OF      010
-#define C_SKIP    020
+#define C_BS      (1 << 0)
+#define C_COUNT   (1 << 1)
+#define C_IF      (1 << 2)
+#define C_OF      (1 << 3)
+#define C_SKIP    (1 << 4)
+#define C_NOCREAT (1 << 5)
+#define C_NOTRUNC (1 << 6)
 
 struct DdInfo {
     unsigned int flags;
@@ -3906,6 +3910,31 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
 
+static int img_dd_conv(const char *arg,
+                       struct DdIo *in, struct DdIo *out,
+                       struct DdInfo *dd)
+{
+    char **flags, **tmp;
+
+    tmp = flags = g_strsplit(arg, ",", 0);
+
+    while (tmp && *tmp) {
+        if (g_str_equal(*tmp, "noconv")) {
+            dd->flags |= C_NOCREAT;
+        } else if (g_str_equal(*tmp, "notrunc")) {
+            dd->flags |= C_NOTRUNC;
+        } else {
+            error_report("invalid conv argument: '%s'", *tmp);
+            g_strfreev(flags);
+            return 1;
+        }
+        tmp++;
+    }
+
+    g_strfreev(flags);
+    return 0;
+}
+
 static int img_dd(int argc, char **argv)
 {
     int ret = 0;
@@ -3920,7 +3949,7 @@ static int img_dd(int argc, char **argv)
     int c, i;
     const char *out_fmt = "raw";
     const char *fmt = NULL;
-    int64_t size = 0;
+    int64_t size = 0, out_size;
     int64_t block_count = 0, out_pos, in_pos;
     struct DdInfo dd = {
         .flags = 0,
@@ -3945,6 +3974,7 @@ static int img_dd(int argc, char **argv)
         { "if", img_dd_if, C_IF },
         { "of", img_dd_of, C_OF },
         { "skip", img_dd_skip, C_SKIP },
+        { "conv", img_dd_conv, 0 },
         { NULL, NULL, 0 }
     };
     const struct option long_options[] = {
@@ -3954,7 +3984,7 @@ static int img_dd(int argc, char **argv)
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, "hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hnf:O:", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4051,22 +4081,25 @@ static int img_dd(int argc, char **argv)
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
+    if (!(dd.flags & C_NOCREAT)) {
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
@@ -4083,19 +4116,22 @@ static int img_dd(int argc, char **argv)
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
+    if (!(dd.flags & C_NOCREAT)) {
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
@@ -4111,6 +4147,41 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
+    if (dd.flags & C_NOCREAT) {
+        if (dd.flags & C_NOTRUNC) {
+            int64_t existing_size = blk_getlength(blk2);
+            if (existing_size < 0) {
+                error_report("unable to get output image length: %s",
+                             strerror(-existing_size));
+                ret = -1;
+                goto out;
+            } else if (existing_size < out_size) {
+                /* Not large enough, so we must enlarge it */
+                ret = blk_truncate(blk2, out_size);
+                if (ret < 0) {
+                    error_reportf_err(local_err,
+                                      "%s: error while enlarging output image: ",
+                                      out.filename);
+                    ret = -1;
+                    goto out;
+                }
+            }
+        } else {
+            /* dd would truncate to 0 length, then append out_size
+             * worth of data. Our images don't grow on demand, so
+             * we just truncate to final output size straight away
+             */
+            ret = blk_truncate(blk2, out_size);
+            if (ret < 0) {
+                error_reportf_err(local_err,
+                                  "%s: error while truncating output image: ",
+                                  out.filename);
+                ret = -1;
+                goto out;
+            }
+        }
+    }
+
     if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
                               size < in.offset * in.bsz)) {
         /* We give a warning if the skip option is bigger than the input
diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae3..9f10562 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -326,7 +326,7 @@ skipped. This is useful for formats such as @code{rbd} if the target
 volume has already been created with site specific options that cannot
 be supplied through qemu-img.
 
-@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] [conv=nocreat,notrunc] if=@var{input} of=@var{output}
 
 Dd copies from @var{input} file to @var{output} file converting it from
 @var{fmt} format to @var{output_fmt} format.
@@ -337,6 +337,14 @@ dd will stop reading input after reading @var{blocks} input blocks.
 
 The size syntax is similar to dd(1)'s size syntax.
 
+If the @code{conv=nocreat} option is specified, the target volume creation
+will be skipped. Its length will be truncated to match data length, if it
+is longer than the required data size. If the @code{conv=notrunc} option
+is specified, no file size shrinking will be done. If the existing output
+file is too small it will be enlarged to fit. These options are useful for
+formats such as @code{rbd} if the target volume has already been created
+with site specific options that cannot be supplied through qemu-img.
+
 @item info [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] @var{filename}
 
 Give information about the disk image @var{filename}. Use it in
-- 
2.9.3
