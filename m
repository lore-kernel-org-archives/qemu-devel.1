Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIE-0006SU-Ay
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIB-0006Ye-Ms
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:35 -0400
Message-Id: <20180512012537.22478-11-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/12] qemu-img: split off common chunk of
 map command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

It will be re-used for a bitmap listing command.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img.c | 192 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 110 insertions(+), 82 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea62d2d61e..e31e38f674 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -69,8 +69,8 @@ enum {
 };
 
 typedef enum OutputFormat {
-    OFORMAT_JSON,
     OFORMAT_HUMAN,
+    OFORMAT_JSON,
 } OutputFormat;
 
 /* Default to cache=writeback as data integrity is not important for qemu-img */
@@ -2728,96 +2728,122 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     return true;
 }
 
+typedef struct CommonOpts {
+    OutputFormat output_format;
+    const char *filename;
+    const char *fmt;
+    bool force_share;
+    bool image_opts;
+} CommonOpts;
+
+static int parse_opts_common(CommonOpts *opts, int argc, char **argv)
+{
+    int c;
+
+    for (;;) {
+        int option_index = 0;
+        static const struct option long_options[] = {
+            {"help", no_argument, 0, 'h'},
+            {"format", required_argument, 0, 'f'},
+            {"output", required_argument, 0, OPTION_OUTPUT},
+            {"object", required_argument, 0, OPTION_OBJECT},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"force-share", no_argument, 0, 'U'},
+            {0, 0, 0, 0}
+        };
+        c = getopt_long(argc, argv, ":f:hU",
+                        long_options, &option_index);
+        if (c == -1) {
+            break;
+        }
+        switch (c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
+        case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
+        case 'h':
+            help();
+            break;
+        case 'f':
+            opts->fmt = optarg;
+            break;
+        case 'U':
+            opts->force_share = true;
+            break;
+        case OPTION_OUTPUT:
+            if (optarg && !strcmp(optarg, "json")) {
+                opts->output_format = OFORMAT_JSON;
+            } else if (optarg && !strcmp(optarg, "human")) {
+                opts->output_format = OFORMAT_HUMAN;
+            } else {
+                error_report("--output must be used with human or json as argument.");
+                return -EINVAL;
+            }
+            break;
+        case OPTION_OBJECT: {
+            QemuOpts *opts;
+            opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                return -EINVAL;
+            }
+        }   break;
+        case OPTION_IMAGE_OPTS:
+            opts->image_opts = true;
+            break;
+        }
+    }
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, NULL)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void parse_positional(int argc, char *argv[],
+                             bool opt, const char **str, const char *name) {
+    if (!opt && optind >= argc) {
+        error_exit("Expecting '%s' positional parameter", name);
+    } else if (optind < argc) {
+        *str = argv[optind++];
+    }
+}
+
+static void parse_unexpected(int argc, char *argv[]) {
+    if (optind != argc) {
+        error_exit("Unexpected argument '%s'\n", argv[optind]);
+    }
+}
+
 static int img_map(int argc, char **argv)
 {
-    int c;
-    OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
     int64_t length;
+    int ret = 0;
     MapEntry curr = { .length = 0 }, next;
-    int ret = 0;
-    bool image_opts = false;
-    bool force_share = false;
+    CommonOpts *opts;
 
-    fmt = NULL;
-    output = NULL;
-    for (;;) {
-        int option_index = 0;
-        static const struct option long_options[] = {
-            {"help", no_argument, 0, 'h'},
-            {"format", required_argument, 0, 'f'},
-            {"output", required_argument, 0, OPTION_OUTPUT},
-            {"object", required_argument, 0, OPTION_OBJECT},
-            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
-            {0, 0, 0, 0}
-        };
-        c = getopt_long(argc, argv, ":f:hU",
-                        long_options, &option_index);
-        if (c == -1) {
-            break;
-        }
-        switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
-        case 'h':
-            help();
-            break;
-        case 'f':
-            fmt = optarg;
-            break;
-        case 'U':
-            force_share = true;
-            break;
-        case OPTION_OUTPUT:
-            output = optarg;
-            break;
-        case OPTION_OBJECT: {
-            QemuOpts *opts;
-            opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                           optarg, true);
-            if (!opts) {
-                return 1;
-            }
-        }   break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        }
-    }
-    if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
-    }
-    filename = argv[optind];
-
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
-    if (qemu_opts_foreach(&qemu_object_opts,
-                          user_creatable_add_opts_foreach,
-                          NULL, NULL)) {
-        return 1;
+    opts = g_new0(CommonOpts, 1);
+    if (parse_opts_common(opts, argc, argv)) {
+        return EXIT_FAILURE;
     }
+    parse_positional(argc, argv, 0, &opts->filename, "filename");
+    parse_unexpected(argc, argv);
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
+    blk = img_open(opts->image_opts, opts->filename, opts->fmt, 0,
+                   false, false, opts->force_share);
     if (!blk) {
-        return 1;
+        ret = -1;
+        goto out1;
     }
     bs = blk_bs(blk);
 
-    if (output_format == OFORMAT_HUMAN) {
+    if (opts->output_format == OFORMAT_HUMAN) {
         printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");
     }
 
@@ -2832,7 +2858,7 @@ static int img_map(int argc, char **argv)
 
         if (ret < 0) {
             error_report("Could not read file metadata: %s", strerror(-ret));
-            goto out;
+            goto out2;
         }
 
         if (entry_mergeable(&curr, &next)) {
@@ -2841,15 +2867,17 @@ static int img_map(int argc, char **argv)
         }
 
         if (curr.length > 0) {
-            dump_map_entry(output_format, &curr, &next);
+            dump_map_entry(opts->output_format, &curr, &next);
         }
         curr = next;
     }
 
-    dump_map_entry(output_format, &curr, NULL);
+    dump_map_entry(opts->output_format, &curr, NULL);
 
-out:
+out2:
     blk_unref(blk);
+out1:
+    g_free(opts);
     return ret < 0;
 }
 
-- 
2.14.3
