Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cae-0001X2-2x
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cab-00019g-Oj
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:13 +0200
Message-Id: <1493411622-5343-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/34] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Peter Lieven <pl@kamp.de>

img_convert has been around before there was an ImgConvertState or
a block backend, but it has never been modified to directly use
these structs. Change this by parsing parameters directly into
the ImgConvertState and directly use BlockBackend where possible.
Furthermore variable initialization has been reworked and sorted.

Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 201 +++++++++++++++++++++++++------------------------------------
 1 file changed, 81 insertions(+), 120 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bbe1574..b94fc11 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1522,7 +1522,7 @@ typedef struct ImgConvertState {
     int min_sparse;
     size_t cluster_sectors;
     size_t buf_sectors;
-    int num_coroutines;
+    long num_coroutines;
     int running_coroutines;
     Coroutine *co[MAX_COROUTINES];
     int64_t wait_sector_num[MAX_COROUTINES];
@@ -1916,39 +1916,29 @@ static int convert_do_copy(ImgConvertState *s)
 
 static int img_convert(int argc, char **argv)
 {
-    int c, bs_n, bs_i, compress, cluster_sectors, skip_create;
-    int64_t ret = 0;
-    int progress = 0, flags, src_flags;
-    bool writethrough, src_writethrough;
-    const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_filename;
+    int c, bs_i, flags, src_flags = 0;
+    const char *fmt = NULL, *out_fmt = "raw", *cache = "unsafe",
+               *src_cache = BDRV_DEFAULT_CACHE, *out_baseimg = NULL,
+               *out_filename, *out_baseimg_param, *snapshot_name = NULL;
     BlockDriver *drv, *proto_drv;
-    BlockBackend **blk = NULL, *out_blk = NULL;
-    BlockDriverState **bs = NULL, *out_bs = NULL;
-    int64_t total_sectors;
-    int64_t *bs_sectors = NULL;
-    size_t bufsectors = IO_BUF_SIZE / BDRV_SECTOR_SIZE;
     BlockDriverInfo bdi;
-    QemuOpts *opts = NULL;
+    BlockDriverState *out_bs;
+    QemuOpts *opts = NULL, *sn_opts = NULL;
     QemuOptsList *create_opts = NULL;
-    const char *out_baseimg_param;
     char *options = NULL;
-    const char *snapshot_name = NULL;
-    int min_sparse = 8; /* Need at least 4k of zeros for sparse detection */
-    bool quiet = false;
     Error *local_err = NULL;
-    QemuOpts *sn_opts = NULL;
-    ImgConvertState state;
-    bool image_opts = false;
-    bool wr_in_order = true;
-    long num_coroutines = 8;
+    bool writethrough, src_writethrough, quiet = false, image_opts = false,
+         skip_create = false, progress = false;
+    int64_t ret = -EINVAL;
+
+    ImgConvertState s = (ImgConvertState) {
+        /* Need at least 4k of zeros for sparse detection */
+        .min_sparse         = 8,
+        .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
+        .wr_in_order        = true,
+        .num_coroutines     = 8,
+    };
 
-    fmt = NULL;
-    out_fmt = "raw";
-    cache = "unsafe";
-    src_cache = BDRV_DEFAULT_CACHE;
-    out_baseimg = NULL;
-    compress = 0;
-    skip_create = 0;
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
@@ -1981,22 +1971,19 @@ static int img_convert(int argc, char **argv)
             out_baseimg = optarg;
             break;
         case 'c':
-            compress = 1;
+            s.compressed = true;
             break;
         case 'e':
             error_report("option -e is deprecated, please use \'-o "
                   "encryption\' instead!");
-            ret = -1;
             goto fail_getopt;
         case '6':
             error_report("option -6 is deprecated, please use \'-o "
                   "compat6\' instead!");
-            ret = -1;
             goto fail_getopt;
         case 'o':
             if (!is_valid_option_list(optarg)) {
                 error_report("Invalid option list: %s", optarg);
-                ret = -1;
                 goto fail_getopt;
             }
             if (!options) {
@@ -2017,7 +2004,6 @@ static int img_convert(int argc, char **argv)
                 if (!sn_opts) {
                     error_report("Failed in parsing snapshot param '%s'",
                                  optarg);
-                    ret = -1;
                     goto fail_getopt;
                 }
             } else {
@@ -2031,15 +2017,14 @@ static int img_convert(int argc, char **argv)
             sval = cvtnum(optarg);
             if (sval < 0) {
                 error_report("Invalid minimum zero buffer size for sparse output specified");
-                ret = -1;
                 goto fail_getopt;
             }
 
-            min_sparse = sval / BDRV_SECTOR_SIZE;
+            s.min_sparse = sval / BDRV_SECTOR_SIZE;
             break;
         }
         case 'p':
-            progress = 1;
+            progress = true;
             break;
         case 't':
             cache = optarg;
@@ -2051,19 +2036,18 @@ static int img_convert(int argc, char **argv)
             quiet = true;
             break;
         case 'n':
-            skip_create = 1;
+            skip_create = true;
             break;
         case 'm':
-            if (qemu_strtol(optarg, NULL, 0, &num_coroutines) ||
-                num_coroutines < 1 || num_coroutines > MAX_COROUTINES) {
+            if (qemu_strtol(optarg, NULL, 0, &s.num_coroutines) ||
+                s.num_coroutines < 1 || s.num_coroutines > MAX_COROUTINES) {
                 error_report("Invalid number of coroutines. Allowed number of"
                              " coroutines is between 1 and %d", MAX_COROUTINES);
-                ret = -1;
                 goto fail_getopt;
             }
             break;
         case 'W':
-            wr_in_order = false;
+            s.wr_in_order = false;
             break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2084,83 +2068,79 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
 
-    if (!wr_in_order && compress) {
+    if (!s.wr_in_order && s.compressed) {
         error_report("Out of order write and compress are mutually exclusive");
-        ret = -1;
         goto fail_getopt;
     }
 
-    /* Initialize before goto out */
-    if (quiet) {
-        progress = 0;
-    }
-    qemu_progress_init(progress, 1.0);
-
-    bs_n = argc - optind - 1;
-    out_filename = bs_n >= 1 ? argv[argc - 1] : NULL;
+    s.src_num = argc - optind - 1;
+    out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
 
     if (options && has_help_option(options)) {
         ret = print_block_option_help(out_filename, out_fmt);
-        goto out;
+        goto fail_getopt;
     }
 
-    if (bs_n < 1) {
-        error_exit("Must specify image file name");
+    if (s.src_num < 1) {
+        error_report("Must specify image file name");
+        goto fail_getopt;
     }
 
 
-    if (bs_n > 1 && out_baseimg) {
+    if (s.src_num > 1 && out_baseimg) {
         error_report("-B makes no sense when concatenating multiple input "
                      "images");
-        ret = -1;
-        goto out;
+        goto fail_getopt;
     }
 
-    src_flags = 0;
+    /* ret is still -EINVAL until here */
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
         error_report("Invalid source cache option: %s", src_cache);
-        goto out;
+        goto fail_getopt;
     }
 
+    /* Initialize before goto out */
+    if (quiet) {
+        progress = false;
+    }
+    qemu_progress_init(progress, 1.0);
     qemu_progress_print(0, 100);
 
-    blk = g_new0(BlockBackend *, bs_n);
-    bs = g_new0(BlockDriverState *, bs_n);
-    bs_sectors = g_new(int64_t, bs_n);
+    s.src = g_new0(BlockBackend *, s.src_num);
+    s.src_sectors = g_new(int64_t, s.src_num);
 
-    total_sectors = 0;
-    for (bs_i = 0; bs_i < bs_n; bs_i++) {
-        blk[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                             fmt, src_flags, src_writethrough, quiet);
-        if (!blk[bs_i]) {
+    for (bs_i = 0; bs_i < s.src_num; bs_i++) {
+        s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
+                               fmt, src_flags, src_writethrough, quiet);
+        if (!s.src[bs_i]) {
             ret = -1;
             goto out;
         }
-        bs[bs_i] = blk_bs(blk[bs_i]);
-        bs_sectors[bs_i] = blk_nb_sectors(blk[bs_i]);
-        if (bs_sectors[bs_i] < 0) {
+        s.src_sectors[bs_i] = blk_nb_sectors(s.src[bs_i]);
+        if (s.src_sectors[bs_i] < 0) {
             error_report("Could not get size of %s: %s",
-                         argv[optind + bs_i], strerror(-bs_sectors[bs_i]));
+                         argv[optind + bs_i], strerror(-s.src_sectors[bs_i]));
             ret = -1;
             goto out;
         }
-        total_sectors += bs_sectors[bs_i];
+        s.total_sectors += s.src_sectors[bs_i];
     }
 
     if (sn_opts) {
-        bdrv_snapshot_load_tmp(bs[0],
+        bdrv_snapshot_load_tmp(blk_bs(s.src[0]),
                                qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
                                qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
                                &local_err);
     } else if (snapshot_name != NULL) {
-        if (bs_n > 1) {
+        if (s.src_num > 1) {
             error_report("No support for concatenating multiple snapshot");
             ret = -1;
             goto out;
         }
 
-        bdrv_snapshot_load_tmp_by_id_or_name(bs[0], snapshot_name, &local_err);
+        bdrv_snapshot_load_tmp_by_id_or_name(blk_bs(s.src[0]), snapshot_name,
+                                             &local_err);
     }
     if (local_err) {
         error_reportf_err(local_err, "Failed to load snapshot: ");
@@ -2211,7 +2191,7 @@ static int img_convert(int argc, char **argv)
             }
         }
 
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, total_sectors * 512,
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, s.total_sectors * 512,
                             &error_abort);
         ret = add_old_style_options(out_fmt, opts, out_baseimg, NULL);
         if (ret < 0) {
@@ -2224,9 +2204,10 @@ static int img_convert(int argc, char **argv)
     if (out_baseimg_param) {
         out_baseimg = out_baseimg_param;
     }
+    s.target_has_backing = (bool) out_baseimg;
 
     /* Check if compression is supported */
-    if (compress) {
+    if (s.compressed) {
         bool encryption =
             qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT, false);
         const char *preallocation =
@@ -2265,7 +2246,7 @@ static int img_convert(int argc, char **argv)
         }
     }
 
-    flags = min_sparse ? (BDRV_O_RDWR | BDRV_O_UNMAP) : BDRV_O_RDWR;
+    flags = s.min_sparse ? (BDRV_O_RDWR | BDRV_O_UNMAP) : BDRV_O_RDWR;
     ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
     if (ret < 0) {
         error_report("Invalid cache option: %s", cache);
@@ -2277,64 +2258,48 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
-    if (!out_blk) {
+    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    if (!s.target) {
         ret = -1;
         goto out;
     }
-    out_bs = blk_bs(out_blk);
+    out_bs = blk_bs(s.target);
 
     /* increase bufsectors from the default 4096 (2M) if opt_transfer
      * or discard_alignment of the out_bs is greater. Limit to 32768 (16MB)
      * as maximum. */
-    bufsectors = MIN(32768,
-                     MAX(bufsectors,
-                         MAX(out_bs->bl.opt_transfer >> BDRV_SECTOR_BITS,
-                             out_bs->bl.pdiscard_alignment >>
-                             BDRV_SECTOR_BITS)));
+    s.buf_sectors = MIN(32768,
+                        MAX(s.buf_sectors,
+                            MAX(out_bs->bl.opt_transfer >> BDRV_SECTOR_BITS,
+                                out_bs->bl.pdiscard_alignment >>
+                                BDRV_SECTOR_BITS)));
 
     if (skip_create) {
-        int64_t output_sectors = blk_nb_sectors(out_blk);
+        int64_t output_sectors = blk_nb_sectors(s.target);
         if (output_sectors < 0) {
             error_report("unable to get output image length: %s",
                          strerror(-output_sectors));
             ret = -1;
             goto out;
-        } else if (output_sectors < total_sectors) {
+        } else if (output_sectors < s.total_sectors) {
             error_report("output file is smaller than input file");
             ret = -1;
             goto out;
         }
     }
 
-    cluster_sectors = 0;
     ret = bdrv_get_info(out_bs, &bdi);
     if (ret < 0) {
-        if (compress) {
+        if (s.compressed) {
             error_report("could not get block driver info");
             goto out;
         }
     } else {
-        compress = compress || bdi.needs_compressed_writes;
-        cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
-    }
-
-    state = (ImgConvertState) {
-        .src                = blk,
-        .src_sectors        = bs_sectors,
-        .src_num            = bs_n,
-        .total_sectors      = total_sectors,
-        .target             = out_blk,
-        .compressed         = compress,
-        .target_has_backing = (bool) out_baseimg,
-        .min_sparse         = min_sparse,
-        .cluster_sectors    = cluster_sectors,
-        .buf_sectors        = bufsectors,
-        .wr_in_order        = wr_in_order,
-        .num_coroutines     = num_coroutines,
-    };
-    ret = convert_do_copy(&state);
+        s.compressed = s.compressed || bdi.needs_compressed_writes;
+        s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
+    }
 
+    ret = convert_do_copy(&s);
 out:
     if (!ret) {
         qemu_progress_print(100, 0);
@@ -2343,22 +2308,18 @@ out:
     qemu_opts_del(opts);
     qemu_opts_free(create_opts);
     qemu_opts_del(sn_opts);
-    blk_unref(out_blk);
-    g_free(bs);
-    if (blk) {
-        for (bs_i = 0; bs_i < bs_n; bs_i++) {
-            blk_unref(blk[bs_i]);
+    blk_unref(s.target);
+    if (s.src) {
+        for (bs_i = 0; bs_i < s.src_num; bs_i++) {
+            blk_unref(s.src[bs_i]);
         }
-        g_free(blk);
+        g_free(s.src);
     }
-    g_free(bs_sectors);
+    g_free(s.src_sectors);
 fail_getopt:
     g_free(options);
 
-    if (ret) {
-        return 1;
-    }
-    return 0;
+    return !!ret;
 }
 
 
-- 
1.8.3.1
