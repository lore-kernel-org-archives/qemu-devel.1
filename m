Received: from eggs.gnu.org ([2001:4830:134:3::10]:36194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9w-0001Y8-2n
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9o-0006n7-Lv
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:07 +0200
Message-Id: <1494513181-7900-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/58] qemu-img: Add --force-share option to
 subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This will force the opened images to allow sharing all permissions with other
programs.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 36 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index f3b0ab4..418f061 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -28,6 +28,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qbool.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
@@ -283,12 +284,20 @@ static int img_open_password(BlockBackend *blk, const char *filename,
 
 static BlockBackend *img_open_opts(const char *optstr,
                                    QemuOpts *opts, int flags, bool writethrough,
-                                   bool quiet)
+                                   bool quiet, bool force_share)
 {
     QDict *options;
     Error *local_err = NULL;
     BlockBackend *blk;
     options = qemu_opts_to_qdict(opts, NULL);
+    if (force_share) {
+        if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
+            && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
+            error_report("--force-share/-U conflicts with image options");
+            return NULL;
+        }
+        qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+    }
     blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", optstr);
@@ -305,17 +314,20 @@ static BlockBackend *img_open_opts(const char *optstr,
 
 static BlockBackend *img_open_file(const char *filename,
                                    const char *fmt, int flags,
-                                   bool writethrough, bool quiet)
+                                   bool writethrough, bool quiet,
+                                   bool force_share)
 {
     BlockBackend *blk;
     Error *local_err = NULL;
-    QDict *options = NULL;
+    QDict *options = qdict_new();
 
     if (fmt) {
-        options = qdict_new();
         qdict_put_str(options, "driver", fmt);
     }
 
+    if (force_share) {
+        qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+    }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", filename);
@@ -334,7 +346,7 @@ static BlockBackend *img_open_file(const char *filename,
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
-                              bool quiet)
+                              bool quiet, bool force_share)
 {
     BlockBackend *blk;
     if (image_opts) {
@@ -348,9 +360,11 @@ static BlockBackend *img_open(bool image_opts,
         if (!opts) {
             return NULL;
         }
-        blk = img_open_opts(filename, opts, flags, writethrough, quiet);
+        blk = img_open_opts(filename, opts, flags, writethrough, quiet,
+                            force_share);
     } else {
-        blk = img_open_file(filename, fmt, flags, writethrough, quiet);
+        blk = img_open_file(filename, fmt, flags, writethrough, quiet,
+                            force_share);
     }
     return blk;
 }
@@ -650,6 +664,7 @@ static int img_check(int argc, char **argv)
     ImageCheck *check;
     bool quiet = false;
     bool image_opts = false;
+    bool force_share = false;
 
     fmt = NULL;
     output = NULL;
@@ -664,9 +679,10 @@ static int img_check(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:r:T:q",
+        c = getopt_long(argc, argv, ":hf:r:T:qU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -705,6 +721,9 @@ static int img_check(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -744,7 +763,8 @@ static int img_check(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   force_share);
     if (!blk) {
         return 1;
     }
@@ -947,7 +967,8 @@ static int img_commit(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   false);
     if (!blk) {
         return 1;
     }
@@ -1206,6 +1227,7 @@ static int img_compare(int argc, char **argv)
     int c, pnum;
     uint64_t progress_base;
     bool image_opts = false;
+    bool force_share = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -1213,9 +1235,10 @@ static int img_compare(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:T:pqs",
+        c = getopt_long(argc, argv, ":hf:F:T:pqsU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1248,6 +1271,9 @@ static int img_compare(int argc, char **argv)
         case 's':
             strict = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1293,13 +1319,15 @@ static int img_compare(int argc, char **argv)
         goto out3;
     }
 
-    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet);
+    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet,
+                    force_share);
     if (!blk1) {
         ret = 2;
         goto out3;
     }
 
-    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet);
+    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet,
+                    force_share);
     if (!blk2) {
         ret = 2;
         goto out2;
@@ -1902,6 +1930,7 @@ static int img_convert(int argc, char **argv)
     bool writethrough, src_writethrough, quiet = false, image_opts = false,
          skip_create = false, progress = false;
     int64_t ret = -EINVAL;
+    bool force_share = false;
 
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -1916,9 +1945,10 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
+        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2021,6 +2051,9 @@ static int img_convert(int argc, char **argv)
         case 'W':
             s.wr_in_order = false;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *object_opts;
             object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2080,7 +2113,8 @@ static int img_convert(int argc, char **argv)
 
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet);
+                               fmt, src_flags, src_writethrough, quiet,
+                               force_share);
         if (!s.src[bs_i]) {
             ret = -1;
             goto out;
@@ -2233,7 +2267,8 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
+                             false);
     if (!s.target) {
         ret = -1;
         goto out;
@@ -2384,7 +2419,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain)
+                                              bool chain, bool force_share)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
@@ -2407,7 +2442,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
+                       force_share);
         if (!blk) {
             goto err;
         }
@@ -2459,6 +2495,7 @@ static int img_info(int argc, char **argv)
     const char *filename, *fmt, *output;
     ImageInfoList *list;
     bool image_opts = false;
+    bool force_share = false;
 
     fmt = NULL;
     output = NULL;
@@ -2471,9 +2508,10 @@ static int img_info(int argc, char **argv)
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2491,6 +2529,9 @@ static int img_info(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2530,7 +2571,8 @@ static int img_info(int argc, char **argv)
         return 1;
     }
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain);
+    list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                   force_share);
     if (!list) {
         return 1;
     }
@@ -2676,6 +2718,7 @@ static int img_map(int argc, char **argv)
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
     bool image_opts = false;
+    bool force_share = false;
 
     fmt = NULL;
     output = NULL;
@@ -2687,9 +2730,10 @@ static int img_map(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2707,6 +2751,9 @@ static int img_map(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2743,7 +2790,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
     if (!blk) {
         return 1;
     }
@@ -2806,6 +2853,7 @@ static int img_snapshot(int argc, char **argv)
     bool quiet = false;
     Error *err = NULL;
     bool image_opts = false;
+    bool force_share = false;
 
     bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
@@ -2814,9 +2862,10 @@ static int img_snapshot(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:hq",
+        c = getopt_long(argc, argv, ":la:c:d:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2866,6 +2915,9 @@ static int img_snapshot(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2892,7 +2944,8 @@ static int img_snapshot(int argc, char **argv)
     }
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet);
+    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+                   force_share);
     if (!blk) {
         return 1;
     }
@@ -2956,6 +3009,7 @@ static int img_rebase(int argc, char **argv)
     int c, flags, src_flags, ret;
     bool writethrough, src_writethrough;
     int unsafe = 0;
+    bool force_share = false;
     int progress = 0;
     bool quiet = false;
     Error *local_err = NULL;
@@ -2972,9 +3026,10 @@ static int img_rebase(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:q",
+        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3024,6 +3079,9 @@ static int img_rebase(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         }
     }
 
@@ -3072,7 +3130,8 @@ static int img_rebase(int argc, char **argv)
      * Ignore the old backing file for unsafe rebase in case we want to correct
      * the reference to a renamed or moved backing file.
      */
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3097,6 +3156,13 @@ static int img_rebase(int argc, char **argv)
             qdict_put_str(options, "driver", bs->backing_format);
         }
 
+        if (force_share) {
+            if (!options) {
+                options = qdict_new();
+            }
+            qdict_put(options, BDRV_OPT_FORCE_SHARE,
+                      qbool_from_bool(true));
+        }
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
         blk_old_backing = blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
@@ -3109,11 +3175,12 @@ static int img_rebase(int argc, char **argv)
         }
 
         if (out_baseimg[0]) {
+            options = qdict_new();
             if (out_basefmt) {
-                options = qdict_new();
                 qdict_put_str(options, "driver", out_basefmt);
-            } else {
-                options = NULL;
+            }
+            if (force_share) {
+                qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
             }
 
             blk_new_backing = blk_new_open(out_baseimg, NULL,
@@ -3419,7 +3486,8 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3573,7 +3641,8 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3741,6 +3810,7 @@ static int img_bench(int argc, char **argv)
     bool writethrough = false;
     struct timeval t1, t2;
     int i;
+    bool force_share = false;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -3749,9 +3819,10 @@ static int img_bench(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"pattern", required_argument, 0, OPTION_PATTERN},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:w", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -3845,6 +3916,9 @@ static int img_bench(int argc, char **argv)
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -3892,7 +3966,8 @@ static int img_bench(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   force_share);
     if (!blk) {
         ret = -1;
         goto out;
@@ -4059,6 +4134,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
+    bool force_share = false;
     struct DdInfo dd = {
         .flags = 0,
         .count = 0,
@@ -4087,10 +4163,11 @@ static int img_dd(int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "force-share", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4110,6 +4187,9 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4154,7 +4234,8 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
+    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
+                    force_share);
 
     if (!blk1) {
         ret = -1;
@@ -4222,7 +4303,7 @@ static int img_dd(int argc, char **argv)
     }
 
     blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+                    false, false, false);
 
     if (!blk2) {
         ret = -1;
-- 
1.8.3.1
