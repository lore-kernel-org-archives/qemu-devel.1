Received: from eggs.gnu.org ([2001:4830:134:3::10]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNL-0002UL-A1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNJ-0008Dy-2t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:51 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 10:39:32 +0800
Message-Id: <20170314023933.12118-3-famz@redhat.com>
In-Reply-To: <20170314023933.12118-1-famz@redhat.com>
References: <20170314023933.12118-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/3] qemu-img: Add --unsafe-read option to
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 34 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 98b836b..3aaa254 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -273,12 +273,15 @@ static int img_open_password(BlockBackend *blk, const char *filename,
 
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
@@ -295,7 +298,7 @@ static BlockBackend *img_open_opts(const char *optstr,
 
 static BlockBackend *img_open_file(const char *filename,
                                    const char *fmt, int flags,
-                                   bool writethrough, bool quiet)
+                                   bool writethrough, bool quiet, bool unsafe)
 {
     BlockBackend *blk;
     Error *local_err = NULL;
@@ -306,6 +309,9 @@ static BlockBackend *img_open_file(const char *filename,
         qdict_put(options, "driver", qstring_from_str(fmt));
     }
 
+    if (unsafe) {
+        flags |= BDRV_O_UNSAFE_READ;
+    }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", filename);
@@ -324,7 +330,7 @@ static BlockBackend *img_open_file(const char *filename,
 static BlockBackend *img_open(bool image_opts,
                               const char *filename,
                               const char *fmt, int flags, bool writethrough,
-                              bool quiet)
+                              bool quiet, bool unsafe)
 {
     BlockBackend *blk;
     if (image_opts) {
@@ -338,9 +344,9 @@ static BlockBackend *img_open(bool image_opts,
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
@@ -635,6 +641,7 @@ static int img_check(int argc, char **argv)
     ImageCheck *check;
     bool quiet = false;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -649,9 +656,10 @@ static int img_check(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:r:T:q",
+        c = getopt_long(argc, argv, "hf:r:T:qU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -685,6 +693,9 @@ static int img_check(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -724,7 +735,8 @@ static int img_check(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -844,6 +856,7 @@ static int img_commit(int argc, char **argv)
     CommonBlockJobCBInfo cbi;
     bool image_opts = false;
     AioContext *aio_context;
+    bool unsafe_read = false;
 
     fmt = NULL;
     cache = BDRV_DEFAULT_CACHE;
@@ -853,9 +866,10 @@ static int img_commit(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:ht:b:dpq",
+        c = getopt_long(argc, argv, "f:ht:b:dpqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -885,6 +899,9 @@ static int img_commit(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -922,7 +939,8 @@ static int img_commit(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -1181,6 +1199,7 @@ static int img_compare(int argc, char **argv)
     int c, pnum;
     uint64_t progress_base;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -1188,9 +1207,10 @@ static int img_compare(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:F:T:pqs",
+        c = getopt_long(argc, argv, "hf:F:T:pqsU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -1218,6 +1238,9 @@ static int img_compare(int argc, char **argv)
         case 's':
             strict = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -1263,13 +1286,15 @@ static int img_compare(int argc, char **argv)
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
@@ -1911,6 +1936,7 @@ static int img_convert(int argc, char **argv)
     bool image_opts = false;
     bool wr_in_order = true;
     long num_coroutines = 8;
+    bool unsafe_read = false;
 
     fmt = NULL;
     out_fmt = "raw";
@@ -1924,9 +1950,10 @@ static int img_convert(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
+        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2030,6 +2057,9 @@ static int img_convert(int argc, char **argv)
         case 'W':
             wr_in_order = false;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT:
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
                                            optarg, true);
@@ -2097,7 +2127,8 @@ static int img_convert(int argc, char **argv)
     total_sectors = 0;
     for (bs_i = 0; bs_i < bs_n; bs_i++) {
         blk[bs_i] = img_open(image_opts, argv[optind + bs_i],
-                             fmt, src_flags, src_writethrough, quiet);
+                             fmt, src_flags, src_writethrough, quiet,
+                             unsafe_read);
         if (!blk[bs_i]) {
             ret = -1;
             goto out;
@@ -2242,7 +2273,8 @@ static int img_convert(int argc, char **argv)
      * the bdrv_create() call which takes different params.
      * Not critical right now, so fix can wait...
      */
-    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet);
+    out_blk = img_open_file(out_filename, out_fmt, flags, writethrough, quiet,
+                            unsafe_read);
     if (!out_blk) {
         ret = -1;
         goto out;
@@ -2413,7 +2445,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static ImageInfoList *collect_image_info_list(bool image_opts,
                                               const char *filename,
                                               const char *fmt,
-                                              bool chain)
+                                              bool chain, bool unsafe)
 {
     ImageInfoList *head = NULL;
     ImageInfoList **last = &head;
@@ -2436,7 +2468,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
+                       unsafe);
         if (!blk) {
             goto err;
         }
@@ -2488,6 +2521,7 @@ static int img_info(int argc, char **argv)
     const char *filename, *fmt, *output;
     ImageInfoList *list;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -2500,9 +2534,10 @@ static int img_info(int argc, char **argv)
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:h",
+        c = getopt_long(argc, argv, "f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2515,6 +2550,9 @@ static int img_info(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2554,7 +2592,8 @@ static int img_info(int argc, char **argv)
         return 1;
     }
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain);
+    list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                   unsafe_read);
     if (!list) {
         return 1;
     }
@@ -2700,6 +2739,7 @@ static int img_map(int argc, char **argv)
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     fmt = NULL;
     output = NULL;
@@ -2711,9 +2751,10 @@ static int img_map(int argc, char **argv)
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:h",
+        c = getopt_long(argc, argv, "f:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -2726,6 +2767,9 @@ static int img_map(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OUTPUT:
             output = optarg;
             break;
@@ -2762,7 +2806,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, 0, false, false, unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -2825,6 +2869,7 @@ static int img_snapshot(int argc, char **argv)
     bool quiet = false;
     Error *err = NULL;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
@@ -2833,9 +2878,10 @@ static int img_snapshot(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "la:c:d:hq",
+        c = getopt_long(argc, argv, "la:c:d:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2880,6 +2926,9 @@ static int img_snapshot(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -2906,7 +2955,8 @@ static int img_snapshot(int argc, char **argv)
     }
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet);
+    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+                   unsafe_read);
     if (!blk) {
         return 1;
     }
@@ -2970,6 +3020,7 @@ static int img_rebase(int argc, char **argv)
     int c, flags, src_flags, ret;
     bool writethrough, src_writethrough;
     int unsafe = 0;
+    int unsafe_read = 0;
     int progress = 0;
     bool quiet = false;
     Error *local_err = NULL;
@@ -2986,9 +3037,10 @@ static int img_rebase(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:F:b:upt:T:q",
+        c = getopt_long(argc, argv, "hf:F:b:upt:T:qU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3033,6 +3085,9 @@ static int img_rebase(int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        case 'U':
+            unsafe_read = 1;
+            break;
         }
     }
 
@@ -3081,7 +3136,8 @@ static int img_rebase(int argc, char **argv)
      * Ignore the old backing file for unsafe rebase in case we want to correct
      * the reference to a renamed or moved backing file.
      */
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3106,6 +3162,9 @@ static int img_rebase(int argc, char **argv)
             qdict_put(options, "driver", qstring_from_str(bs->backing_format));
         }
 
+        if (unsafe_read) {
+            src_flags |= BDRV_O_UNSAFE_READ;
+        }
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
         blk_old_backing = blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
@@ -3321,6 +3380,7 @@ static int img_resize(int argc, char **argv)
     bool quiet = false;
     BlockBackend *blk = NULL;
     QemuOpts *param;
+    bool unsafe_read = true;
 
     static QemuOptsList resize_options = {
         .name = "resize_options",
@@ -3353,9 +3413,10 @@ static int img_resize(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:hq",
+        c = getopt_long(argc, argv, "f:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3371,6 +3432,9 @@ static int img_resize(int argc, char **argv)
         case 'q':
             quiet = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -3423,7 +3487,8 @@ static int img_resize(int argc, char **argv)
     qemu_opts_del(param);
 
     blk = img_open(image_opts, filename, fmt,
-                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet);
+                   BDRV_O_RDWR | BDRV_O_RESIZE, false, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3484,6 +3549,7 @@ static int img_amend(int argc, char **argv)
     BlockBackend *blk = NULL;
     BlockDriverState *bs = NULL;
     bool image_opts = false;
+    bool unsafe_read = false;
 
     cache = BDRV_DEFAULT_CACHE;
     for (;;) {
@@ -3491,9 +3557,10 @@ static int img_amend(int argc, char **argv)
             {"help", no_argument, 0, 'h'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "ho:f:t:pq",
+        c = getopt_long(argc, argv, "ho:f:t:pqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3581,7 +3648,8 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -3749,6 +3817,7 @@ static int img_bench(int argc, char **argv)
     bool writethrough = false;
     struct timeval t1, t2;
     int i;
+    bool unsafe_read = false;
 
     for (;;) {
         static const struct option long_options[] = {
@@ -3757,9 +3826,10 @@ static int img_bench(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"pattern", required_argument, 0, OPTION_PATTERN},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"unsafe-read", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hc:d:f:no:qs:S:t:w", long_options, NULL);
+        c = getopt_long(argc, argv, "hc:d:f:no:qs:S:t:wU", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -3848,6 +3918,9 @@ static int img_bench(int argc, char **argv)
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -3895,7 +3968,8 @@ static int img_bench(int argc, char **argv)
         goto out;
     }
 
-    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
+    blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet,
+                   unsafe_read);
     if (!blk) {
         ret = -1;
         goto out;
@@ -4062,6 +4136,7 @@ static int img_dd(int argc, char **argv)
     const char *fmt = NULL;
     int64_t size = 0;
     int64_t block_count = 0, out_pos, in_pos;
+    bool unsafe_read = false;
     struct DdInfo dd = {
         .flags = 0,
         .count = 0,
@@ -4090,10 +4165,11 @@ static int img_dd(int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "unsafe-read", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, "hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4111,6 +4187,9 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case 'U':
+            unsafe_read = true;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4155,7 +4234,8 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
-    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
+    blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
+                    unsafe_read);
 
     if (!blk1) {
         ret = -1;
@@ -4223,7 +4303,7 @@ static int img_dd(int argc, char **argv)
     }
 
     blk2 = img_open(image_opts, out.filename, out_fmt, BDRV_O_RDWR,
-                    false, false);
+                    false, false, unsafe_read);
 
     if (!blk2) {
         ret = -1;
-- 
2.9.3
