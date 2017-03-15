Received: from eggs.gnu.org ([2001:4830:134:3::10]:49922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5G5-0000y1-UL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5G0-0000ZA-LH
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1co5G0-0000Yl-DR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Mar 2017 17:29:38 +0800
Message-Id: <20170315092940.1367-7-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-1-stefanha@redhat.com>
References: <20170315092940.1367-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC v2 6/8] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The measure subcommand calculates the size required by a new image file.
This can be used by users or management tools that need to allocate
space on an LVM volume, SAN LUN, etc before creating or converting an
image file.

Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c       | 213 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx |   9 +++
 2 files changed, 222 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 98b836b..e8c6dcc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -59,6 +59,7 @@ enum {
     OPTION_PATTERN = 260,
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
+    OPTION_SIZE = 263,
 };
 
 typedef enum OutputFormat {
@@ -4287,6 +4288,218 @@ out:
     return 0;
 }
 
+static void dump_json_block_measure_info(BlockMeasureInfo *info)
+{
+    QString *str;
+    QObject *obj;
+    Visitor *v = qobject_output_visitor_new(&obj);
+
+    visit_type_BlockMeasureInfo(v, NULL, &info, &error_abort);
+    visit_complete(v, &obj);
+    str = qobject_to_json_pretty(obj);
+    assert(str != NULL);
+    printf("%s\n", qstring_get_str(str));
+    qobject_decref(obj);
+    visit_free(v);
+    QDECREF(str);
+}
+
+static int img_measure(int argc, char **argv)
+{
+    static const struct option long_options[] = {
+        {"help", no_argument, 0, 'h'},
+        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"object", required_argument, 0, OPTION_OBJECT},
+        {"output", required_argument, 0, OPTION_OUTPUT},
+        {"size", required_argument, 0, OPTION_SIZE},
+        {0, 0, 0, 0}
+    };
+    OutputFormat output_format = OFORMAT_HUMAN;
+    BlockBackend *in_blk = NULL;
+    BlockDriver *drv;
+    const char *filename = NULL;
+    const char *fmt = NULL;
+    const char *out_fmt = "raw";
+    char *options = NULL;
+    char *snapshot_name = NULL;
+    QemuOpts *opts = NULL;
+    QemuOpts *object_opts = NULL;
+    QemuOpts *sn_opts = NULL;
+    QemuOptsList *create_opts = NULL;
+    bool image_opts = false;
+    uint64_t img_size = ~0ULL;
+    BlockMeasureInfo info;
+    Error *local_err = NULL;
+    int ret = 1;
+    int c;
+
+    while ((c = getopt_long(argc, argv, "hf:O:o:l:",
+                            long_options, NULL)) != -1) {
+        switch (c) {
+        case '?':
+        case 'h':
+            help();
+            break;
+        case 'f':
+            fmt = optarg;
+            break;
+        case 'O':
+            out_fmt = optarg;
+            break;
+        case 'o':
+            if (!is_valid_option_list(optarg)) {
+                error_report("Invalid option list: %s", optarg);
+                goto out;
+            }
+            if (!options) {
+                options = g_strdup(optarg);
+            } else {
+                char *old_options = options;
+                options = g_strdup_printf("%s,%s", options, optarg);
+                g_free(old_options);
+            }
+            break;
+        case 'l':
+            if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
+                sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
+                                                  optarg, false);
+                if (!sn_opts) {
+                    error_report("Failed in parsing snapshot param '%s'",
+                                 optarg);
+                    goto out;
+                }
+            } else {
+                snapshot_name = optarg;
+            }
+            break;
+        case OPTION_OBJECT:
+            object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                                  optarg, true);
+            if (!object_opts) {
+                goto out;
+            }
+            break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case OPTION_OUTPUT:
+            if (!strcmp(optarg, "json")) {
+                output_format = OFORMAT_JSON;
+            } else if (!strcmp(optarg, "human")) {
+                output_format = OFORMAT_HUMAN;
+            } else {
+                error_report("--output must be used with human or json "
+                             "as argument.");
+                goto out;
+            }
+            break;
+        case OPTION_SIZE:
+        {
+            int64_t sval;
+
+            sval = cvtnum(optarg);
+            if (sval < 0) {
+                if (sval == -ERANGE) {
+                    error_report("Image size must be less than 8 EiB!");
+                } else {
+                    error_report("Invalid image size specified! You may use "
+                                 "k, M, G, T, P or E suffixes for ");
+                    error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                                 "petabytes and exabytes.");
+                }
+                goto out;
+            }
+            img_size = (uint64_t)sval;
+        }
+        break;
+        }
+    }
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, NULL)) {
+        goto out;
+    }
+
+    if (argc - optind > 1) {
+        error_report("At most one filename argument is allowed.");
+        goto out;
+    } else if (argc - optind == 1) {
+        filename = argv[optind];
+    }
+
+    if (!filename &&
+        (object_opts || image_opts || fmt || snapshot_name || sn_opts)) {
+        error_report("--object, --image-opts, -f, and -l "
+                     "require a filename argument.");
+        goto out;
+    }
+    if (filename && img_size != ~0ULL) {
+        error_report("--size N cannot be used together with a filename.");
+        goto out;
+    }
+    if (!filename && img_size == ~0ULL) {
+        error_report("Either --size N or one filename must be specified.");
+        goto out;
+    }
+
+    if (filename) {
+        in_blk = img_open(image_opts, filename, fmt, 0, false, false);
+        if (!in_blk) {
+            goto out;
+        }
+    }
+
+    drv = bdrv_find_format(out_fmt);
+    if (!drv) {
+        error_report("Unknown file format '%s'", out_fmt);
+        goto out;
+    }
+    if (!drv->create_opts) {
+        error_report("Format driver '%s' does not support image creation",
+                     drv->format_name);
+        goto out;
+    }
+
+    create_opts = qemu_opts_append(create_opts, drv->create_opts);
+    opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    if (options) {
+        qemu_opts_do_parse(opts, options, NULL, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_report("Invalid options for file format '%s'", out_fmt);
+            goto out;
+        }
+    }
+    if (img_size != ~0ULL) {
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
+    }
+
+    bdrv_measure(drv, opts, in_blk ? blk_bs(in_blk) : NULL, &info, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto out;
+    }
+
+    if (output_format == OFORMAT_HUMAN) {
+        printf("required bytes: %" PRIu64 "\n", info.required_bytes);
+        printf("fully allocated bytes: %" PRIu64 "\n",
+               info.fully_allocated_bytes);
+    } else {
+        dump_json_block_measure_info(&info);
+    }
+
+    ret = 0;
+
+out:
+    qemu_opts_del(object_opts);
+    qemu_opts_del(opts);
+    qemu_opts_del(sn_opts);
+    qemu_opts_free(create_opts);
+    g_free(options);
+    blk_unref(in_blk);
+    return ret;
+}
 
 static const img_cmd_t img_cmds[] = {
 #define DEF(option, callback, arg_string)        \
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 9c9702c..57ef70f 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -85,5 +85,14 @@ DEF("amend", img_amend,
     "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
 STEXI
 @item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
+ETEXI
+
+DEF("measure", img_measure,
+"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
+STEXI
+@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
+ETEXI
+
+STEXI
 @end table
 ETEXI
-- 
2.9.3
