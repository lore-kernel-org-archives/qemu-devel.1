Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxZ-0001ik-HN
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxY-0000fv-04
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlxX-0000fT-Nt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:34:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:33:27 +0100
Message-Id: <20170613133329.23653-8-stefanha@redhat.com>
In-Reply-To: <20170613133329.23653-1-stefanha@redhat.com>
References: <20170613133329.23653-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v7 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The measure subcommand calculates the size required by a new image file.
This can be used by users or management tools that need to allocate
space on an LVM volume, SAN LUN, etc before creating or converting an
image file.

Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v7:
 * Really use UINT64_MAX everywhere instead of ~0ULL [Berto]
v5:
 * Use UINT64_MAX instead of ~0ULL [Berto]
 * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
   [Berto]
---
 qemu-img.c       | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx |   6 ++
 qemu-img.texi    |  30 +++++++
 3 files changed, 270 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d..33a7580 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -61,6 +61,7 @@ enum {
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
     OPTION_TARGET_IMAGE_OPTS = 263,
+    OPTION_SIZE = 264,
 };
 
 typedef enum OutputFormat {
@@ -4448,6 +4449,239 @@ out:
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
+        {"force-share", no_argument, 0, 'U'},
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
+    bool force_share = false;
+    QemuOpts *opts = NULL;
+    QemuOpts *object_opts = NULL;
+    QemuOpts *sn_opts = NULL;
+    QemuOptsList *create_opts = NULL;
+    bool image_opts = false;
+    uint64_t img_size = UINT64_MAX;
+    BlockMeasureInfo *info = NULL;
+    Error *local_err = NULL;
+    int ret = 1;
+    int c;
+
+    while ((c = getopt_long(argc, argv, "hf:O:o:l:U",
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
+        case 'U':
+            force_share = true;
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
+    if (filename && img_size != UINT64_MAX) {
+        error_report("--size N cannot be used together with a filename.");
+        goto out;
+    }
+    if (!filename && img_size == UINT64_MAX) {
+        error_report("Either --size N or one filename must be specified.");
+        goto out;
+    }
+
+    if (filename) {
+        in_blk = img_open(image_opts, filename, fmt, 0,
+                          false, false, force_share);
+        if (!in_blk) {
+            goto out;
+        }
+
+        if (sn_opts) {
+            bdrv_snapshot_load_tmp(blk_bs(in_blk),
+                    qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
+                    qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
+                    &local_err);
+        } else if (snapshot_name != NULL) {
+            bdrv_snapshot_load_tmp_by_id_or_name(blk_bs(in_blk),
+                    snapshot_name, &local_err);
+        }
+        if (local_err) {
+            error_reportf_err(local_err, "Failed to load snapshot: ");
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
+    create_opts = qemu_opts_append(create_opts, bdrv_file.create_opts);
+    opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    if (options) {
+        qemu_opts_do_parse(opts, options, NULL, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_report("Invalid options for file format '%s'", out_fmt);
+            goto out;
+        }
+    }
+    if (img_size != UINT64_MAX) {
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
+    }
+
+    info = bdrv_measure(drv, opts, in_blk ? blk_bs(in_blk) : NULL, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        goto out;
+    }
+
+    if (output_format == OFORMAT_HUMAN) {
+        printf("required size: %" PRIu64 "\n", info->required);
+        printf("fully allocated size: %" PRIu64 "\n", info->fully_allocated);
+    } else {
+        dump_json_block_measure_info(info);
+    }
+
+    ret = 0;
+
+out:
+    qapi_free_BlockMeasureInfo(info);
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
index a39fcdb..ac5946b 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -63,6 +63,12 @@ STEXI
 @item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
 ETEXI
 
+DEF("measure", img_measure,
+"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
+STEXI
+@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
+ETEXI
+
 DEF("snapshot", img_snapshot,
     "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
 STEXI
diff --git a/qemu-img.texi b/qemu-img.texi
index 5b925ec..3db035f 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -438,6 +438,36 @@ preallocated.
 For more information, consult @file{include/block/block.h} in QEMU's
 source code.
 
+@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
+
+Calculate the file size required for a new image.  This information can be used
+to size logical volumes or SAN LUNs appropriately for the image that will be
+placed in them.  The values reported are guaranteed to be large enough to fit
+the image.  The command can output in the format @var{ofmt} which is either
+@code{human} or @code{json}.
+
+If the size @var{N} is given then act as if creating a new empty image file
+using @command{qemu-img create}.  If @var{filename} is given then act as if
+converting an existing image file using @command{qemu-img convert}.  The format
+of the new file is given by @var{fmt} while the format of an existing file is
+given by @var{output_fmt}.
+
+A snapshot in an existing image can be specified using @var{snapshot_param}.
+
+The following fields are reported:
+@example
+required size: 524288
+fully allocated size: 1074069504
+@end example
+
+The @code{required size} is the file size of the new image.  It may be smaller
+than the virtual disk size if the image format supports compact representation.
+
+The @code{fully allocated size} is the file size of the new image once data has
+been written to all sectors.  This is the maximum size that the image file can
+occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
+and other advanced image format features.
+
 @item snapshot [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot} ] @var{filename}
 
 List, apply, create or delete snapshots in image @var{filename}.
-- 
2.9.4
