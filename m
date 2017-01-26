Received: from eggs.gnu.org ([2001:4830:134:3::10]:55785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrZ-0008IU-F5
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhrU-0003om-0V
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:05:09 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 11:04:34 +0000
Message-Id: <20170126110435.2777-6-berrange@redhat.com>
In-Reply-To: <20170126110435.2777-1-berrange@redhat.com>
References: <20170126110435.2777-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/6] qemu-img: introduce --target-image-opts
 for 'convert' command
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

The '--image-opts' flags indicates whether the source filename
includes options. The target filename has to remain in the
plain filename format though, since it needs to be passed to
bdrv_create().  When using --skip-create though, it would be
possible to use image-opts syntax. This adds --target-image-opts
to indicate that the target filename includes options. Currently
this mandates use of the --skip-create flag too.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |   8 ++--
 qemu-img.c       | 131 ++++++++++++++++++++++++++++++++++++-------------------
 qemu-img.texi    |  12 ++++-
 3 files changed, 99 insertions(+), 52 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index ef691fa..aba83b3 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,15 +40,15 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
-    "dd [--image-opts] [-n] [-f fmt] [-O output_fmt] [-o options] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
+    "dd [--image-opts] [--target-image-opts] [-n] [-f fmt] [-O output_fmt] [-o options] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
 STEXI
-@item dd [--image-opts] [-n] [-f @var{fmt}] [-O @var{output_fmt}] [-o @var{options}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
+@item dd [--image-opts] [--target-image-opts] [-n] [-f @var{fmt}] [-O @var{output_fmt}] [-o @var{options}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
 ETEXI
 
 DEF("info", img_info,
diff --git a/qemu-img.c b/qemu-img.c
index 8f91a95..a751781 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -59,6 +59,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_TARGET_IMAGE_OPTS = 263,
 };
 
 typedef enum OutputFormat {
@@ -1763,7 +1764,7 @@ static int img_convert(int argc, char **argv)
     int progress = 0, flags, src_flags;
     bool writethrough, src_writethrough;
     const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_filename;
-    BlockDriver *drv, *proto_drv;
+    BlockDriver *drv = NULL, *proto_drv = NULL;
     BlockBackend **blk = NULL, *out_blk = NULL;
     BlockDriverState **bs = NULL, *out_bs = NULL;
     int64_t total_sectors;
@@ -1781,9 +1782,10 @@ static int img_convert(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     ImgConvertState state;
     bool image_opts = false;
+    bool tgt_image_opts = false;
 
+    out_fmt = NULL;
     fmt = NULL;
-    out_fmt = "raw";
     cache = "unsafe";
     src_cache = BDRV_DEFAULT_CACHE;
     out_baseimg = NULL;
@@ -1794,6 +1796,7 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
@@ -1898,15 +1901,27 @@ static int img_convert(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case OPTION_TARGET_IMAGE_OPTS:
+            tgt_image_opts = true;
+            break;
         }
     }
 
+    if (!out_fmt && !tgt_image_opts) {
+        out_fmt = "raw";
+    }
+
     if (qemu_opts_foreach(&qemu_object_opts,
                           user_creatable_add_opts_foreach,
                           NULL, NULL)) {
         goto fail_getopt;
     }
 
+    if (tgt_image_opts && !skip_create) {
+        error_report("--target-image-opts requires use of -n flag");
+        goto fail_getopt;
+    }
+
     /* Initialize before goto out */
     if (quiet) {
         progress = 0;
@@ -1916,7 +1931,7 @@ static int img_convert(int argc, char **argv)
     bs_n = argc - optind - 1;
     out_filename = bs_n >= 1 ? argv[argc - 1] : NULL;
 
-    if (options && has_help_option(options)) {
+    if (out_fmt && options && has_help_option(options)) {
         ret = print_block_option_help(out_filename, out_fmt);
         goto out;
     }
@@ -1985,22 +2000,22 @@ static int img_convert(int argc, char **argv)
         goto out;
     }
 
-    /* Find driver and parse its options */
-    drv = bdrv_find_format(out_fmt);
-    if (!drv) {
-        error_report("Unknown file format '%s'", out_fmt);
-        ret = -1;
-        goto out;
-    }
+    if (!skip_create) {
+        /* Find driver and parse its options */
+        drv = bdrv_find_format(out_fmt);
+        if (!drv) {
+            error_report("Unknown file format '%s'", out_fmt);
+            ret = -1;
+            goto out;
+        }
 
-    proto_drv = bdrv_find_protocol(out_filename, true, &local_err);
-    if (!proto_drv) {
-        error_report_err(local_err);
-        ret = -1;
-        goto out;
-    }
+        proto_drv = bdrv_find_protocol(out_filename, true, &local_err);
+        if (!proto_drv) {
+            error_report_err(local_err);
+            ret = -1;
+            goto out;
+        }
 
-    if (!skip_create) {
         if (!drv->create_opts) {
             error_report("Format driver '%s' does not support image creation",
                          drv->format_name);
@@ -2089,12 +2104,18 @@ static int img_convert(int argc, char **argv)
         goto out;
     }
 
-    /* XXX we should allow --image-opts to trigger use of
-     * img_open() here, but then we have trouble with
-     * the bdrv_create() call which takes different params.
-     * Not critical right now, so fix can wait...
-     */
-    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    if (skip_create) {
+        out_blk = img_open(tgt_image_opts, out_filename, out_fmt,
+                           flags, writethrough, quiet);
+    } else {
+        /* TODO ultimately we should allow --target-image-opts
+         * to be used even when -n is not given.
+         * That has to wait for bdrv_create to be improved
+         * to allow filenames in option syntax
+         */
+        out_blk = img_open_file(out_filename, out_fmt,
+                                flags, writethrough, quiet);
+    }
     if (!out_blk) {
         ret = -1;
         goto out;
@@ -3917,8 +3938,9 @@ static int img_dd(int argc, char **argv)
     QemuOptsList *create_opts = NULL;
     Error *local_err = NULL;
     bool image_opts = false;
+    bool tgt_image_opts = false;
     int c, i, skip_create = 0;
-    const char *out_fmt = "raw";
+    const char *out_fmt = NULL;
     const char *fmt = NULL;
     char *optionstr = NULL;
     int64_t size = 0, out_size;
@@ -3952,6 +3974,7 @@ static int img_dd(int argc, char **argv)
         { "help", no_argument, 0, 'h'},
         { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
         { 0, 0, 0, 0 }
     };
 
@@ -4001,9 +4024,21 @@ static int img_dd(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case OPTION_TARGET_IMAGE_OPTS:
+            tgt_image_opts = true;
+            break;
         }
     }
 
+    if (tgt_image_opts && !skip_create) {
+        error_report("--target-image-opts requires use of -n flag");
+        goto out;
+    }
+
+    if (!out_fmt && !tgt_image_opts) {
+        out_fmt = "raw";
+    }
+
     for (i = optind; i < argc; i++) {
         int j;
         arg = g_strdup(argv[i]);
@@ -4043,7 +4078,7 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
-    if (optionstr && has_help_option(optionstr)) {
+    if (out_fmt && optionstr && has_help_option(optionstr)) {
         ret = print_block_option_help(out.filename, out_fmt);
         goto out;
     }
@@ -4061,21 +4096,21 @@ static int img_dd(int argc, char **argv)
         goto out;
     }
 
-    drv = bdrv_find_format(out_fmt);
-    if (!drv) {
-        error_report("Unknown file format");
-        ret = -1;
-        goto out;
-    }
-    proto_drv = bdrv_find_protocol(out.filename, true, &local_err);
+    if (!skip_create) {
+        drv = bdrv_find_format(out_fmt);
+        if (!drv) {
+            error_report("Unknown file format");
+            ret = -1;
+            goto out;
+        }
+        proto_drv = bdrv_find_protocol(out.filename, true, &local_err);
 
-    if (!proto_drv) {
-        error_report_err(local_err);
-        ret = -1;
-        goto out;
-    }
+        if (!proto_drv) {
+            error_report_err(local_err);
+            ret = -1;
+            goto out;
+        }
 
-    if (!skip_create) {
         if (!drv->create_opts) {
             error_report("Format driver '%s' does not support image creation",
                          drv->format_name);
@@ -4125,7 +4160,6 @@ static int img_dd(int argc, char **argv)
 
     if (!skip_create) {
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, out_size, &error_abort);
-
         ret = bdrv_create(drv, out.filename, opts, &local_err);
         if (ret < 0) {
             error_reportf_err(local_err,
@@ -4136,13 +4170,18 @@ static int img_dd(int argc, char **argv)
         }
     }
 
-    /* TODO, we can't honour --image-opts for the target,
-     * since it needs to be given in a format compatible
-     * with the bdrv_create() call above which does not
-     * support image-opts style.
-     */
-    blk2 = img_open_file(out.filename, out_fmt, BDRV_O_RDWR,
-                         false, false);
+    if (skip_create) {
+        blk2 = img_open(tgt_image_opts, out.filename, out_fmt,
+                        BDRV_O_RDWR, false, false);
+    } else {
+        /* TODO ultimately we should allow --target-image-opts
+         * to be used even when -n is not given.
+         * That has to wait for bdrv_create to be improved
+         * to allow filenames in option syntax
+         */
+        blk2 = img_open_file(out.filename, out_fmt,
+                             BDRV_O_RDWR, false, false);
+    }
 
     if (!blk2) {
         ret = -1;
diff --git a/qemu-img.texi b/qemu-img.texi
index 9a391d4..dfdfb65 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -45,9 +45,17 @@ keys.
 
 @item --image-opts
 
-Indicates that the @var{filename} parameter is to be interpreted as a
+Indicates that the source @var{filename} parameter is to be interpreted as a
 full option string, not a plain filename. This parameter is mutually
-exclusive with the @var{-f} and @var{-F} parameters.
+exclusive with the @var{-f} parameter.
+
+@item --target-image-opts
+
+Indicates that the target @var{filename} parameter(s) are to be interpreted a
+a full option string, not a plain filename. This parameter is mutually
+exclusive with the @var{-F} or @var{-O} parameters. It is currently required
+to also use the @var{-n} parameter to skip image creation. This restriction
+will be relaxed in a future release.
 
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
-- 
2.9.3
