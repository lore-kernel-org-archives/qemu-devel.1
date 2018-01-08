Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSLg-0007pE-4R
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSLe-00051I-8U
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:00:00 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon,  8 Jan 2018 15:59:34 +0800
Message-Id: <20180108075935.23690-2-famz@redhat.com>
In-Reply-To: <20180108075935.23690-1-famz@redhat.com>
References: <20180108075935.23690-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qemu-img: Move img_open error reporting
 to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

In the next patch one caller will have a special error handling logic
rather than reporting it. Add "Error **" parameters to functions and
give control back to callers, to make that possible.

Update iotests output accordingly.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c                 | 115 +++++++++++++++++++++++++++------------------
 tests/qemu-iotests/043.out |   6 +--
 2 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 68b375f998..828e3b3b88 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -268,24 +268,22 @@ static int print_block_option_help(const char *filename, const char *fmt)
 
 static BlockBackend *img_open_opts(const char *optstr,
                                    QemuOpts *opts, int flags, bool writethrough,
-                                   bool quiet, bool force_share)
+                                   bool quiet, bool force_share, Error **errp)
 {
     QDict *options;
-    Error *local_err = NULL;
     BlockBackend *blk;
     options = qemu_opts_to_qdict(opts, NULL);
     if (force_share) {
         if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
             && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
-            error_report("--force-share/-U conflicts with image options");
+            error_setg(errp, "--force-share/-U conflicts with image options");
             QDECREF(options);
             return NULL;
         }
         qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
     }
-    blk = blk_new_open(NULL, NULL, options, flags, &local_err);
+    blk = blk_new_open(NULL, NULL, options, flags, errp);
     if (!blk) {
-        error_reportf_err(local_err, "Could not open '%s': ", optstr);
         return NULL;
     }
     blk_set_enable_write_cache(blk, !writethrough);
@@ -297,10 +295,10 @@ static BlockBackend *img_open_file(const char *filename,
                                    QDict *options,
                                    const char *fmt, int flags,
                                    bool writethrough, bool quiet,
-                                   bool force_share)
+                                   bool force_share,
+                                   Error **errp)
 {
     BlockBackend *blk;
-    Error *local_err = NULL;
 
     if (!options) {
         options = qdict_new();
@@ -312,9 +310,8 @@ static BlockBackend *img_open_file(const char *filename,
     if (force_share) {
         qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
     }
-    blk = blk_new_open(filename, NULL, options, flags, &local_err);
+    blk = blk_new_open(filename, NULL, options, flags, errp);
     if (!blk) {
-        error_reportf_err(local_err, "Could not open '%s': ", filename);
         return NULL;
     }
     blk_set_enable_write_cache(blk, !writethrough);
@@ -340,7 +337,8 @@ static BlockBackend *img_open_new_file(const char *filename,
                                        QemuOpts *create_opts,
                                        const char *fmt, int flags,
                                        bool writethrough, bool quiet,
-                                       bool force_share)
+                                       bool force_share,
+                                       Error **errp)
 {
     QDict *options = NULL;
 
@@ -348,32 +346,32 @@ static BlockBackend *img_open_new_file(const char *filename,
     qemu_opt_foreach(create_opts, img_add_key_secrets, options, &error_abort);
 
     return img_open_file(filename, options, fmt, flags, writethrough, quiet,
-                         force_share);
+                         force_share, errp);
 }
 
 
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
-                              bool quiet, bool force_share)
+                              bool quiet, bool force_share, Error **errp)
 {
     BlockBackend *blk;
     if (image_opts) {
         QemuOpts *opts;
         if (fmt) {
-            error_report("--image-opts and --format are mutually exclusive");
+            error_setg(errp,
+                       "--image-opts and --format are mutually exclusive");
             return NULL;
         }
-        opts = qemu_opts_parse_noisily(qemu_find_opts("source"),
-                                       filename, true);
+        opts = qemu_opts_parse(qemu_find_opts("source"), filename, true, errp);
         if (!opts) {
             return NULL;
         }
         blk = img_open_opts(filename, opts, flags, writethrough, quiet,
-                            force_share);
+                            force_share, errp);
     } else {
         blk = img_open_file(filename, NULL, fmt, flags, writethrough, quiet,
-                            force_share);
+                            force_share, errp);
     }
     return blk;
 }
@@ -670,6 +668,7 @@ static int img_check(int argc, char **argv)
     bool quiet = false;
     bool image_opts = false;
     bool force_share = false;
+    Error *local_err = NULL;
 
     fmt = NULL;
     output = NULL;
@@ -769,8 +768,9 @@ static int img_check(int argc, char **argv)
     }
 
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
-                   force_share);
+                   force_share, &local_err);
     if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         return 1;
     }
     bs = blk_bs(blk);
@@ -979,8 +979,9 @@ static int img_commit(int argc, char **argv)
     }
 
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
-                   false);
+                   false, &local_err);
     if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         return 1;
     }
     bs = blk_bs(blk);
@@ -1251,6 +1252,7 @@ static int img_compare(int argc, char **argv)
     uint64_t progress_base;
     bool image_opts = false;
     bool force_share = false;
+    Error *local_err = NULL;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -1343,15 +1345,17 @@ static int img_compare(int argc, char **argv)
     }
 
     blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet,
-                    force_share);
+                    force_share, &local_err);
     if (!blk1) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename1);
         ret = 2;
         goto out3;
     }
 
     blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet,
-                    force_share);
+                    force_share, &local_err);
     if (!blk2) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename2);
         ret = 2;
         goto out2;
     }
@@ -2121,8 +2125,10 @@ static int img_convert(int argc, char **argv)
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
                                fmt, src_flags, src_writethrough, quiet,
-                               force_share);
+                               force_share, &local_err);
         if (!s.src[bs_i]) {
+            error_reportf_err(local_err, "Could not open '%s': ",
+                              argv[optind + bs_i]);
             ret = -1;
             goto out;
         }
@@ -2273,7 +2279,7 @@ static int img_convert(int argc, char **argv)
 
     if (skip_create) {
         s.target = img_open(tgt_image_opts, out_filename, out_fmt,
-                            flags, writethrough, quiet, false);
+                            flags, writethrough, quiet, false, &local_err);
     } else {
         /* TODO ultimately we should allow --target-image-opts
          * to be used even when -n is not given.
@@ -2281,9 +2287,11 @@ static int img_convert(int argc, char **argv)
          * to allow filenames in option syntax
          */
         s.target = img_open_new_file(out_filename, opts, out_fmt,
-                                     flags, writethrough, quiet, false);
+                                     flags, writethrough, quiet, false,
+                                     &local_err);
     }
     if (!s.target) {
+        error_reportf_err(local_err, "Could not open '%s': ", out_filename);
         ret = -1;
         goto out;
     }
@@ -2439,12 +2447,13 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain, bool force_share)
+                                              bool chain, bool force_share,
+                                              Error **errp)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
     GHashTable *filenames;
-    Error *err = NULL;
+    Error *local_err = NULL;
 
     filenames = g_hash_table_new_full(g_str_hash, str_equal_func, NULL, NULL);
 
@@ -2455,23 +2464,24 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         ImageInfoList *elem;
 
         if (g_hash_table_lookup_extended(filenames, filename, NULL, NULL)) {
-            error_report("Backing file '%s' creates an infinite loop.",
-                         filename);
+            error_setg(errp,
+                       "Backing file '%s' creates an infinite loop",
+                       filename);
             goto err;
         }
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
                        BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
-                       force_share);
+                       force_share, errp);
         if (!blk) {
             goto err;
         }
         bs = blk_bs(blk);
 
-        bdrv_query_image_info(bs, &info, &err);
-        if (err) {
-            error_report_err(err);
+        bdrv_query_image_info(bs, &info, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
             blk_unref(blk);
             goto err;
         }
@@ -2488,9 +2498,10 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
             if (info->has_full_backing_filename) {
                 filename = info->full_backing_filename;
             } else if (info->has_backing_filename) {
-                error_report("Could not determine absolute backing filename,"
-                             " but backing filename '%s' present",
-                             info->backing_filename);
+                error_setg(errp,
+                           "Could not determine absolute backing filename,"
+                           " but backing filename '%s' present",
+                           info->backing_filename);
                 goto err;
             }
             if (info->has_backing_filename_format) {
@@ -2516,6 +2527,7 @@ static int img_info(int argc, char **argv)
     ImageInfoList *list;
     bool image_opts = false;
     bool force_share = false;
+    Error *local_err = NULL;
 
     fmt = NULL;
     output = NULL;
@@ -2592,8 +2604,9 @@ static int img_info(int argc, char **argv)
     }
 
     list = collect_image_info_list(image_opts, filename, fmt, chain,
-                                   force_share);
+                                   force_share, &local_err);
     if (!list) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         return 1;
     }
 
@@ -2739,6 +2752,7 @@ static int img_map(int argc, char **argv)
     int ret = 0;
     bool image_opts = false;
     bool force_share = false;
+    Error *local_err = NULL;
 
     fmt = NULL;
     output = NULL;
@@ -2810,8 +2824,10 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, force_share,
+                   &local_err);
     if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         return 1;
     }
     bs = blk_bs(blk);
@@ -2961,8 +2977,9 @@ static int img_snapshot(int argc, char **argv)
 
     /* Open the image */
     blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
-                   force_share);
+                   force_share, &err);
     if (!blk) {
+        error_reportf_err(err, "Could not open '%s': ", filename);
         return 1;
     }
     bs = blk_bs(blk);
@@ -3147,8 +3164,9 @@ static int img_rebase(int argc, char **argv)
      * the reference to a renamed or moved backing file.
      */
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
-                   false);
+                   false, &local_err);
     if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         ret = -1;
         goto out;
     }
@@ -3507,8 +3525,9 @@ static int img_resize(int argc, char **argv)
 
     blk = img_open(image_opts, filename, fmt,
                    BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
-                   false);
+                   false, &err);
     if (!blk) {
+        error_reportf_err(err, "Could not open '%s': ", filename);
         ret = -1;
         goto out;
     }
@@ -3693,8 +3712,9 @@ static int img_amend(int argc, char **argv)
     }
 
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
-                   false);
+                   false, &err);
     if (!blk) {
+        error_reportf_err(err, "Could not open '%s': ", filename);
         ret = -1;
         goto out;
     }
@@ -3862,6 +3882,7 @@ static int img_bench(int argc, char **argv)
     struct timeval t1, t2;
     int i;
     bool force_share = false;
+    Error *local_err = NULL;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -4018,8 +4039,9 @@ static int img_bench(int argc, char **argv)
     }
 
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
-                   force_share);
+                   force_share, &local_err);
     if (!blk) {
+        error_reportf_err(local_err, "Could not open '%s': ", filename);
         ret = -1;
         goto out;
     }
@@ -4301,9 +4323,10 @@ static int img_dd(int argc, char **argv)
     }
 
     blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
-                    force_share);
+                    force_share, &local_err);
 
     if (!blk1) {
+        error_reportf_err(local_err, "Could not open '%s': ", in.filename);
         ret = -1;
         goto out;
     }
@@ -4374,10 +4397,11 @@ static int img_dd(int argc, char **argv)
      * support image-opts style.
      */
     blk2 = img_open_file(out.filename, NULL, out_fmt, BDRV_O_RDWR,
-                         false, false, false);
+                         false, false, false, &local_err);
 
     if (!blk2) {
         ret = -1;
+        error_reportf_err(local_err, "Could not open '%s': ", out.filename);
         goto out;
     }
 
@@ -4600,8 +4624,9 @@ static int img_measure(int argc, char **argv)
 
     if (filename) {
         in_blk = img_open(image_opts, filename, fmt, 0,
-                          false, false, force_share);
+                          false, false, force_share, &local_err);
         if (!in_blk) {
+            error_reportf_err(local_err, "Could not open '%s': ", filename);
             goto out;
         }
 
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index b37d2a3807..840f333678 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -2,19 +2,19 @@ QA output created by 043
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 == backing file references self ==
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
 
 == parent references self ==
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.3.base
 
 == ancestor references another ancestor ==
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infinite loop.
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infinite loop
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.1.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.2.base
-- 
2.14.3
