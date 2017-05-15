Received: from eggs.gnu.org ([2001:4830:134:3::10]:52396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAGcg-0004AH-M3
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAGcb-0002e3-ER
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:05:18 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 May 2017 15:04:09 +0100
Message-Id: <20170515140410.14172-4-berrange@redhat.com>
In-Reply-To: <20170515140410.14172-1-berrange@redhat.com>
References: <20170515140410.14172-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v9 3/4] qemu-img: introduce --target-image-opts
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
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |  4 +--
 qemu-img.c       | 84 ++++++++++++++++++++++++++++++++++++++------------------
 qemu-img.texi    | 12 ++++++--
 3 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 469ec12..c298331 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}][-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}][-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
diff --git a/qemu-img.c b/qemu-img.c
index 4dc1d56..e0e3d31 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -60,6 +60,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_TARGET_IMAGE_OPTS = 263,
 };
 
 typedef enum OutputFormat {
@@ -1913,10 +1914,10 @@ static int convert_do_copy(ImgConvertState *s)
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
@@ -1924,7 +1925,7 @@ static int img_convert(int argc, char **argv)
     char *options = NULL;
     Error *local_err = NULL;
     bool writethrough, src_writethrough, quiet = false, image_opts = false,
-         skip_create = false, progress = false;
+         skip_create = false, progress = false, tgt_image_opts = false;
     int64_t ret = -EINVAL;
     bool force_share = false;
 
@@ -1942,6 +1943,7 @@ static int img_convert(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
+            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
@@ -2062,9 +2064,16 @@ static int img_convert(int argc, char **argv)
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
@@ -2076,12 +2085,22 @@ static int img_convert(int argc, char **argv)
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
+            goto fail_getopt;
+        } else {
+            error_report("Option help requires a format be specified");
+            goto fail_getopt;
+        }
     }
 
     if (s.src_num < 1) {
@@ -2146,22 +2165,22 @@ static int img_convert(int argc, char **argv)
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
@@ -2218,7 +2237,7 @@ static int img_convert(int argc, char **argv)
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
-        if (!drv->bdrv_co_pwritev_compressed) {
+        if (drv && !drv->bdrv_co_pwritev_compressed) {
             error_report("Compression not supported for this file format");
             ret = -1;
             goto out;
@@ -2258,19 +2277,30 @@ static int img_convert(int argc, char **argv)
         goto out;
     }
 
-    /* XXX we should allow --image-opts to trigger use of
-     * img_open() here, but then we have trouble with
-     * the bdrv_create() call which takes different params.
-     * Not critical right now, so fix can wait...
-     */
-    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
-                             false);
+    if (skip_create) {
+        s.target = img_open(tgt_image_opts, out_filename, out_fmt,
+                            flags, writethrough, quiet, false);
+    } else {
+        /* TODO ultimately we should allow --target-image-opts
+         * to be used even when -n is not given.
+         * That has to wait for bdrv_create to be improved
+         * to allow filenames in option syntax
+         */
+        s.target = img_open_file(out_filename, out_fmt, flags,
+                                 writethrough, quiet, false);
+    }
     if (!s.target) {
         ret = -1;
         goto out;
     }
     out_bs = blk_bs(s.target);
 
+    if (s.compressed && !out_bs->drv->bdrv_co_pwritev_compressed) {
+        error_report("Compression not supported for this file format");
+        ret = -1;
+        goto out;
+    }
+
     /* increase bufsectors from the default 4096 (2M) if opt_transfer
      * or discard_alignment of the out_bs is greater. Limit to 32768 (16MB)
      * as maximum. */
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
