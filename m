Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgP-0005nr-GX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgM-0003jT-C5
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:50 +0800
Message-Id: <20170421035606.448-5-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 04/20] qemu-img: Add --share-rw option to
 subcommands
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

Similar to share-rw qdev property, this will force the opened images to
allow shared write permission of other programs.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 119 insertions(+), 36 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ed24371..df88a79 100644
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
@@ -283,12 +284,15 @@ static int img_open_password(BlockBackend *blk, const char *filename,
 
 static BlockBackend *img_open_opts(const char *optstr,
                                    QemuOpts *opts, int flags, bool writethrough,
-                                   bool quiet)
+                                   bool quiet, bool share_rw)
 {
     QDict *options;
     Error *local_err = NULL;
     BlockBackend *blk;
     options = qemu_opts_to_qdict(opts, NULL);
+    if (share_rw) {
+        qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
+    }
     blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", optstr);
@@ -305,17 +309,19 @@ static BlockBackend *img_open_opts(const char *optstr,
 
 static BlockBackend *img_open_file(const char *filename,
                                    const char *fmt, int flags,
-                                   bool writethrough, bool quiet)
+                                   bool writethrough, bool quiet, bool share_rw)
 {
     BlockBackend *blk;
     Error *local_err = NULL;
-    QDict *options = NULL;
+    QDict *options = qdict_new();
 
     if (fmt) {
-        options = qdict_new();
         qdict_put(options, "driver", qstring_from_str(fmt));
     }
 
+    if (share_rw) {
+        qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
+    }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", filename);
@@ -334,7 +340,7 @@ static BlockBackend *img_open_file(const char *filename,
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
-                              bool quiet)
+                              bool quiet, bool share_rw)
 {
     BlockBackend *blk;
     if (image_opts) {
@@ -348,9 +354,9 @@ static BlockBackend *img_open(bool image_opts,
         if (!opts) {
             return NULL;
         }
-        blk = img_open_opts(filename, opts, flags, writethrough, quiet);
+        blk = img_open_opts(filename, opts, flags, writethrough, quiet, share_rw);
     } else {
-        blk = img_open_file(filename, fmt, flags, writethrough, quiet);
+        blk = img_open_file(filename, fmt, flags, writethrough, quiet, share_rw);
     }
     return blk;
 }
@@ -650,6 +656,7 @@ static int img_check(int argc, char **argv)
     ImageCheck *check;
     bool quiet = false;
     bool image_opts = false;
+    bool share_rw = false;
 
     fmt = NULL;
     output = NULL;
@@ -664,9 +671,10 @@ static int img_check(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:r:T:q",
+        c = getopt_long(argc, argv, ":hf:r:T:qU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -705,6 +713,9 @@ static int img_check(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -744,7 +755,8 @@ static int img_check(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   share_rw);
     if (!blk) {
         return 1;
     }
@@ -864,6 +876,7 @@ static int img_commit(int argc, char **argv)
     CommonBlockJobCBInfo cbi;
     bool image_opts = false;
     AioContext *aio_context;
+    bool share_rw = false;
 
     fmt = NULL;
     cache = BDRV_DEFAULT_CACHE;
@@ -873,9 +886,10 @@ static int img_commit(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:ht:b:dpq",
+        c = getopt_long(argc, argv, ":f:ht:b:dpqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -910,6 +924,9 @@ static int img_commit(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -947,7 +964,8 @@ static int img_commit(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   share_rw);
     if (!blk) {
         return 1;
     }
@@ -1206,6 +1224,7 @@ static int img_compare(int argc, char **argv)
     int c, pnum;
     uint64_t progress_base;
     bool image_opts = false;
+    bool share_rw = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -1213,9 +1232,10 @@ static int img_compare(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:T:pqs",
+        c = getopt_long(argc, argv, ":hf:F:T:pqsU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1248,6 +1268,9 @@ static int img_compare(int argc, char **argv)
         case 's':
             strict = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1293,13 +1316,15 @@ static int img_compare(int argc, char **argv)
         goto out3;
     }
 
-    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet);
+    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet,
+                    share_rw);
     if (!blk1) {
         ret = 2;
         goto out3;
     }
 
-    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet);
+    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet,
+                    share_rw);
     if (!blk2) {
         ret = 2;
         goto out2;
@@ -1934,6 +1959,7 @@ static int img_convert(int argc, char **argv)
     bool writethrough, src_writethrough, quiet = false, image_opts = false,
          compress = false, skip_create = false, progress = false;
     int64_t ret = -EINVAL;
+    bool share_rw = false;
 
     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -1948,9 +1974,10 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
+        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2054,6 +2081,9 @@ static int img_convert(int argc, char **argv)
         case 'W':
             s.wr_in_order = false;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -2117,7 +2147,8 @@ static int img_convert(int argc, char **argv)
 
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                                fmt, src_flags, src_writethrough, quiet);
+                               fmt, src_flags, src_writethrough, quiet,
+                               share_rw);
         if (!s.src[bs_i]) {
             ret = -1;
             goto out;
@@ -2262,7 +2293,8 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    s.target = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
+                             share_rw);
     if (!s.target) {
         ret = -1;
         goto out;
@@ -2413,7 +2445,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain)
+                                              bool chain, bool share_rw)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
@@ -2436,7 +2468,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
+                       share_rw);
         if (!blk) {
             goto err;
         }
@@ -2488,6 +2521,7 @@ static int img_info(int argc, char **argv)
     const char *filename, *fmt, *output;
     ImageInfoList *list;
     bool image_opts = false;
+    bool share_rw = false;
 
     fmt = NULL;
     output = NULL;
@@ -2500,9 +2534,10 @@ static int img_info(int argc, char **argv)
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2520,6 +2555,9 @@ static int img_info(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2559,7 +2597,8 @@ static int img_info(int argc, char **argv)
         return 1;
     }
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain);
+    list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                   share_rw);
     if (!list) {
         return 1;
     }
@@ -2705,6 +2744,7 @@ static int img_map(int argc, char **argv)
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
     bool image_opts = false;
+    bool share_rw = false;
 
     fmt = NULL;
     output = NULL;
@@ -2716,9 +2756,10 @@ static int img_map(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2736,6 +2777,9 @@ static int img_map(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2772,7 +2816,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, share_rw);
     if (!blk) {
         return 1;
     }
@@ -2835,6 +2879,7 @@ static int img_snapshot(int argc, char **argv)
     bool quiet = false;
     Error *err = NULL;
     bool image_opts = false;
+    bool share_rw = false;
 
     bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
@@ -2843,9 +2888,10 @@ static int img_snapshot(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:hq",
+        c = getopt_long(argc, argv, ":la:c:d:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2895,6 +2941,9 @@ static int img_snapshot(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2921,7 +2970,8 @@ static int img_snapshot(int argc, char **argv)
     }
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet);
+    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+                   share_rw);
     if (!blk) {
         return 1;
     }
@@ -2985,6 +3035,7 @@ static int img_rebase(int argc, char **argv)
     int c, flags, src_flags, ret;
     bool writethrough, src_writethrough;
     int unsafe = 0;
+    bool share_rw = 0;
     int progress = 0;
     bool quiet = false;
     Error *local_err = NULL;
@@ -3001,9 +3052,10 @@ static int img_rebase(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:q",
+        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3053,6 +3105,9 @@ static int img_rebase(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         }
     }
 
@@ -3101,7 +3156,8 @@ static int img_rebase(int argc, char **argv)
      * Ignore the old backing file for unsafe rebase in case we want to correct
      * the reference to a renamed or moved backing file.
      */
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   share_rw);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3126,6 +3182,9 @@ static int img_rebase(int argc, char **argv)
             qdict_put(options, "driver", qstring_from_str(bs->backing_format));
         }
 
+        if (share_rw) {
+            qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bool(true));
+        }
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
         blk_old_backing = blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
@@ -3341,6 +3400,7 @@ static int img_resize(int argc, char **argv)
     bool quiet = false;
     BlockBackend *blk = NULL;
     QemuOpts *param;
+    bool share_rw = false;
 
     static QemuOptsList resize_options = {
         .name = "resize_options",
@@ -3373,9 +3433,10 @@ static int img_resize(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hq",
+        c = getopt_long(argc, argv, ":f:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3396,6 +3457,9 @@ static int img_resize(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -3448,7 +3512,8 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
+                   share_rw);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3509,6 +3574,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk = NULL;
     BlockDriverState *bs = NULL;
     bool image_opts = false;
+    bool share_rw = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3516,9 +3582,10 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":ho:f:t:pq",
+        c = getopt_long(argc, argv, ":ho:f:t:pqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3560,6 +3627,9 @@ static int img_amend(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -3611,7 +3681,8 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   share_rw);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3779,6 +3850,7 @@ static int img_bench(int argc, char **argv)
     bool writethrough = false;
     struct timeval t1, t2;
     int i;
+    bool share_rw = false;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -3787,9 +3859,10 @@ static int img_bench(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"pattern", required_argument, 0, OPTION_PATTERN},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"share-rw", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:w", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -3883,6 +3956,9 @@ static int img_bench(int argc, char **argv)
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -3930,7 +4006,8 @@ static int img_bench(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   share_rw);
     if (!blk) {
         ret = -1;
         goto out;
@@ -4097,6 +4174,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
+    bool share_rw = false;
     struct DdInfo dd = {
         .flags = 0,
         .count = 0,
@@ -4125,10 +4203,11 @@ static int img_dd(int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "share-rw", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4148,6 +4227,9 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case 'U':
+            share_rw = true;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4192,7 +4274,8 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
+    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
+                    share_rw);
 
     if (!blk1) {
         ret = -1;
@@ -4260,7 +4343,7 @@ static int img_dd(int argc, char **argv)
     }
 
     blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+                    false, false, share_rw);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
