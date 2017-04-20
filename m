Received: from eggs.gnu.org ([2001:4830:134:3::10]:55231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16to-000739-Fr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tl-0003Jm-UA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:21 +0800
Message-Id: <20170420075237.18219-5-famz@redhat.com>
In-Reply-To: <20170420075237.18219-1-famz@redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 04/20] qemu-img: Add --unsafe-read option
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 34 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..b9dcd3e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -283,12 +283,15 @@ static int img_open_password(BlockBackend *blk, const char *filename,
 
 static BlockBackend *img_open_opts(const char *optstr,
                                    QemuOpts *opts, int flags, bool writethrough,
-                                   bool quiet)
+                                   bool quiet, bool unsafe)
 {
     QDict *options;
     Error *local_err = NULL;
     BlockBackend *blk;
     options = qemu_opts_to_qdict(opts, NULL);
+    if (unsafe) {
+        flags |= BDRV_O_UNSAFE_READ;
+    }
     blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", optstr);
@@ -305,7 +308,7 @@ static BlockBackend *img_open_opts(const char *optstr,
 
 static BlockBackend *img_open_file(const char *filename,
                                    const char *fmt, int flags,
-                                   bool writethrough, bool quiet)
+                                   bool writethrough, bool quiet, bool unsafe)
 {
     BlockBackend *blk;
     Error *local_err = NULL;
@@ -316,6 +319,9 @@ static BlockBackend *img_open_file(const char *filename,
         qdict_put(options, "driver", qstring_from_str(fmt));
     }
 
+    if (unsafe) {
+        flags |= BDRV_O_UNSAFE_READ;
+    }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", filename);
@@ -334,7 +340,7 @@ static BlockBackend *img_open_file(const char *filename,
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
-                              bool quiet)
+                              bool quiet, bool unsafe)
 {
     BlockBackend *blk;
     if (image_opts) {
@@ -348,9 +354,9 @@ static BlockBackend *img_open(bool image_opts,
         if (!opts) {
             return NULL;
         }
-        blk = img_open_opts(filename, opts, flags, writethrough, quiet);
+        blk = img_open_opts(filename, opts, flags, writethrough, quiet, unsafe);
     } else {
-        blk = img_open_file(filename, fmt, flags, writethrough, quiet);
+        blk = img_open_file(filename, fmt, flags, writethrough, quiet, unsafe);
     }
     return blk;
 }
@@ -650,6 +656,7 @@ static int img_check(int argc, char **argv)
     ImageCheck *check;
     bool quiet = false;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -664,9 +671,10 @@ static int img_check(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
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
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -744,7 +755,8 @@ static int img_check(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -864,6 +876,7 @@ static int img_commit(int argc, char **argv)
     CommonBlockJobCBInfo cbi;
     bool image_opts = false;
     AioContext *aio_context;
+    bool unsafe_read = false;
 
     fmt = NULL;
     cache = BDRV_DEFAULT_CACHE;
@@ -873,9 +886,10 @@ static int img_commit(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
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
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -947,7 +964,8 @@ static int img_commit(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -1206,6 +1224,7 @@ static int img_compare(int argc, char **argv)
     int c, pnum;
     uint64_t progress_base;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -1213,9 +1232,10 @@ static int img_compare(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
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
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1293,13 +1316,15 @@ static int img_compare(int argc, char **argv)
         goto out3;
     }
 
-    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet);
+    blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet,
+                    unsafe_read);
     if (!blk1) {
         ret = 2;
         goto out3;
     }
 
-    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet);
+    blk2 = img_open(image_opts, filename2, fmt2, flags, writethrough, quiet,
+                    unsafe_read);
     if (!blk2) {
         ret = 2;
         goto out2;
@@ -1941,6 +1966,7 @@ static int img_convert(int argc, char **argv)
     bool image_opts = false;
     bool wr_in_order = true;
     long num_coroutines = 8;
+    bool unsafe_read = false;
 
     fmt = NULL;
     out_fmt = "raw";
@@ -1954,9 +1980,10 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
+        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2065,6 +2092,9 @@ static int img_convert(int argc, char **argv)
         case 'W':
             wr_in_order = false;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -2132,7 +2162,8 @@ static int img_convert(int argc, char **argv)
     total_sectors = 0;
     for (bs_i = 0; bs_i < bs_n; bs_i++) {
         blk[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                             fmt, src_flags, src_writethrough, quiet);
+                             fmt, src_flags, src_writethrough, quiet,
+                             unsafe_read);
         if (!blk[bs_i]) {
             ret = -1;
             goto out;
@@ -2277,7 +2308,8 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
+                            unsafe_read);
     if (!out_blk) {
         ret = -1;
         goto out;
@@ -2448,7 +2480,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain)
+                                              bool chain, bool unsafe)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
@@ -2471,7 +2503,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
+                       unsafe);
         if (!blk) {
             goto err;
         }
@@ -2523,6 +2556,7 @@ static int img_info(int argc, char **argv)
     const char *filename, *fmt, *output;
     ImageInfoList *list;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -2535,9 +2569,10 @@ static int img_info(int argc, char **argv)
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2555,6 +2590,9 @@ static int img_info(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2594,7 +2632,8 @@ static int img_info(int argc, char **argv)
         return 1;
     }
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain);
+    list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                   unsafe_read);
     if (!list) {
         return 1;
     }
@@ -2740,6 +2779,7 @@ static int img_map(int argc, char **argv)
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -2751,9 +2791,10 @@ static int img_map(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:h",
+        c = getopt_long(argc, argv, ":f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2771,6 +2812,9 @@ static int img_map(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2807,7 +2851,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -2870,6 +2914,7 @@ static int img_snapshot(int argc, char **argv)
     bool quiet = false;
     Error *err = NULL;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
@@ -2878,9 +2923,10 @@ static int img_snapshot(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:hq",
+        c = getopt_long(argc, argv, ":la:c:d:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2930,6 +2976,9 @@ static int img_snapshot(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2956,7 +3005,8 @@ static int img_snapshot(int argc, char **argv)
     }
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet);
+    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -3020,6 +3070,7 @@ static int img_rebase(int argc, char **argv)
     int c, flags, src_flags, ret;
     bool writethrough, src_writethrough;
     int unsafe = 0;
+    bool unsafe_read = 0;
     int progress = 0;
     bool quiet = false;
     Error *local_err = NULL;
@@ -3036,9 +3087,10 @@ static int img_rebase(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:q",
+        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3088,6 +3140,9 @@ static int img_rebase(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         }
     }
 
@@ -3136,7 +3191,8 @@ static int img_rebase(int argc, char **argv)
      * Ignore the old backing file for unsafe rebase in case we want to correct
      * the reference to a renamed or moved backing file.
      */
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3161,6 +3217,9 @@ static int img_rebase(int argc, char **argv)
             qdict_put(options, "driver", qstring_from_str(bs->backing_format));
         }
 
+        if (unsafe_read) {
+            src_flags |= BDRV_O_UNSAFE_READ;
+        }
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
         blk_old_backing = blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
@@ -3376,6 +3435,7 @@ static int img_resize(int argc, char **argv)
     bool quiet = false;
     BlockBackend *blk = NULL;
     QemuOpts *param;
+    bool unsafe_read = true;
 
     static QemuOptsList resize_options = {
         .name = "resize_options",
@@ -3408,9 +3468,10 @@ static int img_resize(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hq",
+        c = getopt_long(argc, argv, ":f:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3431,6 +3492,9 @@ static int img_resize(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -3483,7 +3547,8 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3544,6 +3609,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk = NULL;
     BlockDriverState *bs = NULL;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3551,9 +3617,10 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":ho:f:t:pq",
+        c = getopt_long(argc, argv, ":ho:f:t:pqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3646,7 +3713,8 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3814,6 +3882,7 @@ static int img_bench(int argc, char **argv)
     bool writethrough = false;
     struct timeval t1, t2;
     int i;
+    bool unsafe_read = false;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -3822,9 +3891,10 @@ static int img_bench(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"pattern", required_argument, 0, OPTION_PATTERN},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:w", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -3918,6 +3988,9 @@ static int img_bench(int argc, char **argv)
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -3965,7 +4038,8 @@ static int img_bench(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -4132,6 +4206,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
+    bool unsafe_read = false;
     struct DdInfo dd = {
         .flags = 0,
         .count = 0,
@@ -4160,10 +4235,11 @@ static int img_dd(int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "unsafe-read", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4183,6 +4259,9 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4227,7 +4306,8 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
+    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
+                    unsafe_read);
 
     if (!blk1) {
         ret = -1;
@@ -4295,7 +4375,7 @@ static int img_dd(int argc, char **argv)
     }
 
     blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+                    false, false, unsafe_read);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
