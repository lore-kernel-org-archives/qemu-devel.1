Received: from eggs.gnu.org ([2001:4830:134:3::10]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkf-0008Ma-4n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkd-0007Gw-Nm
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:45 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 20 Feb 2017 15:19:20 +0000
Message-Id: <20170220151921.22842-4-berrange@redhat.com>
In-Reply-To: <20170220151921.22842-1-berrange@redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] qemu-img: introduce --target-image-opts
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The '--image-opts' flags indicates whether the source filename
includes options. The target filename has to remain in the
plain filename format though, since it needs to be passed to
bdrv_create().  When using --skip-create though, it would be
possible to use image-opts syntax. This adds --target-image-opts
to indicate that the target filename includes options. Currently
this mandates use of the --skip-create flag too.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img-cmds.hx |  4 +--
 qemu-img.c       | 84 +++++++++++++++++++++++++++++++++++++++-----------------
 qemu-img.texi    | 12 ++++++--
 3 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index f054599..f838e58 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -40,9 +40,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("dd", img_dd,
diff --git a/qemu-img.c b/qemu-img.c
index d8a737f..e48e676 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -59,6 +59,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_TARGET_IMAGE_OPTS = 263,
 };
 
 typedef enum OutputFormat {
@@ -1765,7 +1766,7 @@ static int img_convert(int argc, char **argv)
     int progress = 0, flags, src_flags;
     bool writethrough, src_writethrough;
     const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_filename;
-    BlockDriver *drv, *proto_drv;
+    BlockDriver *drv = NULL, *proto_drv = NULL;
     BlockBackend **blk = NULL, *out_blk = NULL;
     BlockDriverState **bs = NULL, *out_bs = NULL;
     int64_t total_sectors;
@@ -1783,9 +1784,10 @@ static int img_convert(int argc, char **argv)
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
@@ -1796,6 +1798,7 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
@@ -1900,15 +1903,27 @@ static int img_convert(int argc, char **argv)
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
@@ -1919,8 +1934,13 @@ static int img_convert(int argc, char **argv)
     out_filename = bs_n >= 1 ? argv[argc - 1] : NULL;
 
     if (options && has_help_option(options)) {
-        ret = print_block_option_help(out_filename, out_fmt);
-        goto out;
+        if (out_fmt) {
+            ret = print_block_option_help(out_filename, out_fmt);
+            goto out;
+        } else {
+            error_report("Option help requires a format be specified");
+            goto fail_getopt;
+        }
     }
 
     if (bs_n < 1) {
@@ -1987,22 +2007,22 @@ static int img_convert(int argc, char **argv)
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
@@ -2051,7 +2071,7 @@ static int img_convert(int argc, char **argv)
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
-        if (!drv->bdrv_co_pwritev_compressed) {
+        if (drv && !drv->bdrv_co_pwritev_compressed) {
             error_report("Compression not supported for this file format");
             ret = -1;
             goto out;
@@ -2091,18 +2111,32 @@ static int img_convert(int argc, char **argv)
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
     }
     out_bs = blk_bs(out_blk);
 
+    if (compress) {
+        if (!out_bs->drv->bdrv_co_pwritev_compressed) {
+            error_report("Compression not supported for this file format");
+            ret = -1;
+            goto out;
+        }
+    }
+
     /* increase bufsectors from the default 4096 (2M) if opt_transfer
      * or discard_alignment of the out_bs is greater. Limit to 32768 (16MB)
      * as maximum. */
diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae3..d525e3a 100644
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
+exclusive with the @var{-O} parameters. It is currently required to also use
+the @var{-n} parameter to skip image creation. This restriction may be relaxed
+in a future release.
 
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
-- 
2.9.3
