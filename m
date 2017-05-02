Received: from eggs.gnu.org ([2001:4830:134:3::10]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5YeN-0004h4-Vs
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5YeK-0001Xy-Oq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:19:35 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 15:18:56 +0100
Message-Id: <20170502141858.24805-4-berrange@redhat.com>
In-Reply-To: <20170502141858.24805-1-berrange@redhat.com>
References: <20170502141858.24805-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 3/5] qemu-img: introduce --target-image-opts
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The '--image-opts' flag indicates whether the source filename
includes options. The target filename has to remain in the
plain filename format though, since it needs to be passed to
bdrv_create().  When using --skip-create though, it would be
possible to use image-opts syntax. This adds --target-image-opts
to indicate that the target filename includes options. Currently
this mandates use of the --skip-create flag too.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |  4 +--
 qemu-img.c       | 77 +++++++++++++++++++++++++++++++++++++-------------------
 qemu-img.texi    | 12 +++++++--
 3 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index bf4ce59..c97572e 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
diff --git a/qemu-img.c b/qemu-img.c
index d8fdcb1..94c8cea 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -59,6 +59,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_TARGET_IMAGE_OPTS = 263,
 };
 
 typedef enum OutputFormat {
@@ -1889,10 +1890,10 @@ static int convert_do_copy(ImgConvertState *s)
 static int img_convert(int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = 0;
-    const char *fmt = NULL, *out_fmt = "raw", *cache = "unsafe",
+    const char *fmt = NULL, *out_fmt = NULL, *cache = "unsafe",
                *src_cache = BDRV_DEFAULT_CACHE, *out_baseimg = NULL,
                *out_filename, *out_baseimg_param, *snapshot_name = NULL;
-    BlockDriver *drv, *proto_drv;
+    BlockDriver *drv = NULL, *proto_drv = NULL;
     BlockDriverInfo bdi;
     BlockDriverState *out_bs;
     QemuOpts *opts = NULL, *sn_opts = NULL;
@@ -1900,7 +1901,7 @@ static int img_convert(int argc, char **argv)
     char *options = NULL;
     Error *local_err = NULL;
     bool writethrough, src_writethrough, quiet = false, image_opts = false,
-         skip_create = false, progress = false;
+        skip_create = false, progress = false, tgt_image_opts = false;
     int64_t ret = -EINVAL;
 
     ImgConvertState s = (ImgConvertState) {
@@ -1916,6 +1917,7 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
@@ -2033,9 +2035,16 @@ static int img_convert(int argc, char **argv)
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
@@ -2047,12 +2056,22 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
 
+    if (tgt_image_opts && !skip_create) {
+        error_report("--target-image-opts requires use of -n flag");
+        goto fail_getopt;
+    }
+
     s.src_num = argc - optind - 1;
     out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
 
     if (options && has_help_option(options)) {
-        ret = print_block_option_help(out_filename, out_fmt);
-        goto fail_getopt;
+        if (out_fmt) {
+            ret = print_block_option_help(out_filename, out_fmt);
+            goto out;
+        } else {
+            error_report("Option help requires a format be specified");
+            goto fail_getopt;
+        }
     }
 
     if (s.src_num < 1) {
@@ -2116,22 +2135,22 @@ static int img_convert(int argc, char **argv)
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
@@ -2188,7 +2207,7 @@ static int img_convert(int argc, char **argv)
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
-        if (!drv->bdrv_co_pwritev_compressed) {
+        if (drv && !drv->bdrv_co_pwritev_compressed) {
             error_report("Compression not supported for this file format");
             ret = -1;
             goto out;
@@ -2228,12 +2247,18 @@ static int img_convert(int argc, char **argv)
         goto out;
     }
 
-    /* XXX we should allow --image-opts to trigger use of
-     * img_open() here, but then we have trouble with
-     * the bdrv_create() call which takes different params.
-     * Not critical right now, so fix can wait...
-     */
-    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    if (skip_create) {
+        s.target = img_open(tgt_image_opts, out_filename, out_fmt,
+                            flags, writethrough, quiet);
+    } else {
+        /* TODO ultimately we should allow --target-image-opts
+         * to be used even when -n is not given.
+         * That has to wait for bdrv_create to be improved
+         * to allow filenames in option syntax
+         */
+        s.target = img_open_file(out_filename, out_fmt, flags,
+                                 writethrough, quiet);
+    }
     if (!s.target) {
         ret = -1;
         goto out;
diff --git a/qemu-img.texi b/qemu-img.texi
index 50a2364..5b925ec 100644
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
+Indicates that the @var{output_filename} parameter(s) are to be interpreted as
+a full option string, not a plain filename. This parameter is mutually
+exclusive with the @var{-O} parameters. It is currently required to also use
+the @var{-n} parameter to skip image creation. This restriction may be relaxed
+in a future release.
 
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
-- 
2.9.3
