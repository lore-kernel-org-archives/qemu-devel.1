Received: from eggs.gnu.org ([2001:4830:134:3::10]:41133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1P-0005nH-Bj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1M-0007x5-4c
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:18:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  2 May 2017 16:18:14 +0800
Message-Id: <20170502081832.9546-5-famz@redhat.com>
In-Reply-To: <20170502081832.9546-1-famz@redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v16 04/22] qemu-img: Add --force-share option
 to subcommands
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

This will force the opened images to allow sharing all permissions with other
programs.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 118 insertions(+), 36 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7044884..4d77d3d 100644
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
         qdict_put(options, "driver", qstring_from_str(fmt));
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
@@ -1930,6 +1958,7 @@ static int img_convert(int argc, char **argv)
     bool writethrough, src_writethrough, quiet = false, image_opts = false,
          skip_create = false, progress = false;
     int64_t ret = -EINVAL;
+    bool force_share = false;
 
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -1944,9 +1973,10 @@ static int img_convert(int argc, char **argv)
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
@@ -2049,6 +2079,9 @@ static int img_convert(int argc, char **argv)
         case 'W':
             s.wr_in_order = false;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *object_opts;
             object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2108,7 +2141,8 @@ static int img_convert(int argc, char **argv)
 
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                               fmt, src_flags, src_writethrough, quiet);
+                               fmt, src_flags, src_writethrough, quiet,
+                               force_share);
         if (!s.src[bs_i]) {
             ret = -1;
             goto out;
@@ -2261,7 +2295,8 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
+                             false);
     if (!s.target) {
         ret = -1;
         goto out;
@@ -2412,7 +2447,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain)
+                                              bool chain, bool force_share)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
@@ -2435,7 +2470,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
+                       force_share);
         if (!blk) {
             goto err;
         }
@@ -2487,6 +2523,7 @@ static int img_info(int argc, char **argv)
     const char *filename, *fmt, *output;
     ImageInfoList *list;
     bool image_opts = false;
+    bool force_share = false;
 
     fmt = NULL;
     output = NULL;
@@ -2499,9 +2536,10 @@ static int img_info(int argc, char **argv)
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
@@ -2519,6 +2557,9 @@ static int img_info(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2558,7 +2599,8 @@ static int img_info(int argc, char **argv)
         return 1;
     }
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain);
+    list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                   force_share);
     if (!list) {
         return 1;
     }
@@ -2704,6 +2746,7 @@ static int img_map(int argc, char **argv)
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
     bool image_opts = false;
+    bool force_share = false;
 
     fmt = NULL;
     output = NULL;
@@ -2715,9 +2758,10 @@ static int img_map(int argc, char **argv)
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
@@ -2735,6 +2779,9 @@ static int img_map(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2771,7 +2818,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
     if (!blk) {
         return 1;
     }
@@ -2834,6 +2881,7 @@ static int img_snapshot(int argc, char **argv)
     bool quiet = false;
     Error *err = NULL;
     bool image_opts = false;
+    bool force_share = false;
 
     bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
@@ -2842,9 +2890,10 @@ static int img_snapshot(int argc, char **argv)
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
@@ -2894,6 +2943,9 @@ static int img_snapshot(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2920,7 +2972,8 @@ static int img_snapshot(int argc, char **argv)
     }
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet);
+    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+                   force_share);
     if (!blk) {
         return 1;
     }
@@ -2984,6 +3037,7 @@ static int img_rebase(int argc, char **argv)
     int c, flags, src_flags, ret;
     bool writethrough, src_writethrough;
     int unsafe = 0;
+    bool force_share = false;
     int progress = 0;
     bool quiet = false;
     Error *local_err = NULL;
@@ -3000,9 +3054,10 @@ static int img_rebase(int argc, char **argv)
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
@@ -3052,6 +3107,9 @@ static int img_rebase(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         }
     }
 
@@ -3100,7 +3158,8 @@ static int img_rebase(int argc, char **argv)
      * Ignore the old backing file for unsafe rebase in case we want to correct
      * the reference to a renamed or moved backing file.
      */
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3125,6 +3184,13 @@ static int img_rebase(int argc, char **argv)
             qdict_put(options, "driver", qstring_from_str(bs->backing_format));
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
@@ -3137,11 +3203,13 @@ static int img_rebase(int argc, char **argv)
         }
 
         if (out_baseimg[0]) {
+            options = qdict_new();
             if (out_basefmt) {
-                options = qdict_new();
                 qdict_put(options, "driver", qstring_from_str(out_basefmt));
-            } else {
-                options = NULL;
+            }
+            if (force_share) {
+                qdict_put(options, BDRV_OPT_FORCE_SHARE,
+                          qbool_from_bool(true));
             }
 
             blk_new_backing = blk_new_open(out_baseimg, NULL,
@@ -3447,7 +3515,8 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3610,7 +3679,8 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   false);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3778,6 +3848,7 @@ static int img_bench(int argc, char **argv)
     bool writethrough = false;
     struct timeval t1, t2;
     int i;
+    bool force_share = false;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -3786,9 +3857,10 @@ static int img_bench(int argc, char **argv)
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
@@ -3882,6 +3954,9 @@ static int img_bench(int argc, char **argv)
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -3929,7 +4004,8 @@ static int img_bench(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   force_share);
     if (!blk) {
         ret = -1;
         goto out;
@@ -4096,6 +4172,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
+    bool force_share = false;
     struct DdInfo dd = {
         .flags = 0,
         .count = 0,
@@ -4124,10 +4201,11 @@ static int img_dd(int argc, char **argv)
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
@@ -4147,6 +4225,9 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4191,7 +4272,8 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
+    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
+                    force_share);
 
     if (!blk1) {
         ret = -1;
@@ -4259,7 +4341,7 @@ static int img_dd(int argc, char **argv)
     }
 
     blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+                    false, false, false);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
