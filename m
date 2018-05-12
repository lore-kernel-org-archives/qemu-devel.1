Received: from eggs.gnu.org ([2001:4830:134:3::10]:40342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIE-0006SQ-Ae
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIB-0006Ym-PB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:36 -0400
Message-Id: <20180512012537.22478-12-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 11/12] qemu-img: add bitmap dump
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img-cmds.hx |   6 ++
 qemu-img.c       | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 2fe31893cf..d25f359f5a 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -22,6 +22,12 @@ STEXI
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
 ETEXI
 
+DEF("bitmap", img_bitmap,
+    "bitmap dump [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename [bitmap]")
+STEXI
+@item bitmap dump [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename} [@var{bitmap}]
+ETEXI
+
 DEF("check", img_check,
     "check [-q] [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 STEXI
diff --git a/qemu-img.c b/qemu-img.c
index e31e38f674..1141216617 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2881,6 +2881,191 @@ out1:
     return ret < 0;
 }
 
+static BitmapMapping *get_bitmap_mapping(BdrvDirtyBitmap *bitmap)
+{
+    BdrvDirtyBitmapIter *it = bdrv_dirty_iter_new(bitmap);
+    BitmapMapping *bm = g_new0(BitmapMapping, 1);
+    BitmapEntry *entry;
+    BitmapEntryList *tmp, **last;
+    int64_t offset;
+    int64_t zero_offset;
+
+    bm->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
+    bm->entries = NULL;
+    last = &bm->entries;
+
+    while (true) {
+        offset = bdrv_dirty_iter_next(it);
+        if (offset == -1) {
+            break;
+        }
+
+        zero_offset = bdrv_dirty_bitmap_next_zero(bitmap, offset);
+        if (zero_offset == -1) {
+            zero_offset = bdrv_dirty_bitmap_size(bitmap);
+        }
+
+        entry = g_new0(BitmapEntry, 1);
+        entry->offset = offset;
+        entry->length = zero_offset - offset;
+
+        tmp = g_new0(BitmapEntryList, 1);
+        tmp->value = entry;
+        *last = tmp;
+        last = &tmp->next;
+
+        if (zero_offset >= bdrv_dirty_bitmap_size(bitmap)) {
+            break;
+        }
+        bdrv_set_dirty_iter(it, zero_offset);
+    }
+
+    bdrv_dirty_iter_free(it);
+    return bm;
+}
+
+static void dump_bitmap_mapping_json(BitmapMapping *bm, int indent,
+                                     FILE *stream)
+{
+    QString *str;
+    QObject *obj;
+    Visitor *v = qobject_output_visitor_new(&obj);
+    const int pretty = 1;
+
+    visit_type_BitmapMapping(v, NULL, &bm, &error_abort);
+    visit_complete(v, &obj);
+    str = qobject_to_json_opt(obj, pretty, indent);
+    assert(str != NULL);
+    fprintf(stream, "%*s%s", 4 * indent, "", qstring_get_str(str));
+    qobject_unref(obj);
+    visit_free(v);
+    qobject_unref(str);
+}
+
+static void dump_bitmap_mapping_human(BitmapMapping *bm, FILE *stream)
+{
+    BitmapEntryList *bl = bm->entries;
+
+    fprintf(stream, "# %s\n", bm->name);
+    fprintf(stream, "%-16s%-16s\n", "Offset", "Length");
+    for ( ; bl; bl = bl->next) {
+        BitmapEntry *be = bl->value;
+        fprintf(stream, "%-16"PRId64"%-16"PRId64"\n", be->offset, be->length);
+    }
+}
+
+static void dump_bitmap_mapping(BitmapMapping *bm, OutputFormat output_format,
+                                int indent, FILE *stream)
+{
+    switch (output_format) {
+    case OFORMAT_JSON:
+        dump_bitmap_mapping_json(bm, indent, stream);
+        return;
+    case OFORMAT_HUMAN:
+        dump_bitmap_mapping_human(bm, stream);
+        return;
+    }
+}
+
+/* img_bitmap subcommands: dump */
+
+typedef struct BitmapOpts {
+    CommonOpts base;
+    const char *name;
+    uint32_t granularity;
+} BitmapOpts;
+
+static int bitmap_cmd_dump(BlockDriverState *bs, BitmapOpts *opts)
+{
+    BdrvDirtyBitmap *bitmap;
+    BitmapMapping *bm;
+    bool printed;
+    OutputFormat ofmt = opts->base.output_format;
+
+    if (opts->name) {
+        bitmap = bdrv_find_dirty_bitmap(bs, opts->name);
+        if (bitmap) {
+            bm = get_bitmap_mapping(bitmap);
+            dump_bitmap_mapping(bm, ofmt, 0, stdout);
+            qapi_free_BitmapMapping(bm);
+        } else {
+            if (ofmt == OFORMAT_HUMAN) {
+                fprintf(stdout, "Bitmap '%s' not found\n", opts->name);
+            }
+        }
+    } else {
+        if (ofmt == OFORMAT_JSON) {
+            fprintf(stdout, "[\n");
+        }
+        for (bitmap = NULL, printed = false;
+             (bitmap = bdrv_dirty_bitmap_next(bs, bitmap)); printed = true) {
+            if (printed) {
+                fprintf(stdout, ofmt == OFORMAT_JSON ? ",\n" : "\n");
+            }
+            bm = get_bitmap_mapping(bitmap);
+            dump_bitmap_mapping(bm, ofmt, 1, stdout);
+            qapi_free_BitmapMapping(bm);
+        }
+        if (ofmt == OFORMAT_JSON) {
+            fprintf(stdout, "%s%s", printed ? "\n" : "", "]\n");
+        }
+        if (ofmt == OFORMAT_HUMAN && printed == false) {
+            fprintf(stdout, "No bitmaps are present in this image.\n");
+        }
+    }
+
+    return 0;
+}
+
+static int img_bitmap(int argc, char **argv)
+{
+    const char *cmd;
+    BitmapOpts *opts;
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    const char *bname = NULL;
+    int flags = 0;
+    int ret = EXIT_SUCCESS;
+    int (* handler)(BlockDriverState *b, BitmapOpts *opts);
+
+    if (argc < 2) {
+        error_report("Expected a bitmap subcommand: <dump>");
+        return EXIT_FAILURE;
+    }
+    cmd = argv[1];
+    if (strcmp(cmd, "dump") == 0) {
+        handler = bitmap_cmd_dump;
+    } else {
+        error_report("Unrecognized bitmap subcommand '%s'", cmd);
+        return EXIT_FAILURE;
+    }
+
+    opts = g_new0(BitmapOpts, 1);
+    if (parse_opts_common(&opts->base, --argc, ++argv)) {
+        return EXIT_FAILURE;
+    }
+    parse_positional(argc, argv, 0, &opts->base.filename, "filename");
+    parse_positional(argc, argv, 1, &bname, "bitmap");
+    parse_unexpected(argc, argv);
+
+    blk = img_open(opts->base.image_opts, opts->base.filename, opts->base.fmt,
+                   flags, false, false, opts->base.force_share);
+    if (!blk) {
+        ret = EXIT_FAILURE;
+        goto out;
+    }
+    bs = blk_bs(blk);
+
+    if (handler(bs, opts)) {
+        ret = EXIT_FAILURE;
+    }
+
+    blk_unref(blk);
+ out:
+    g_free(opts);
+    return ret;
+}
+
 #define SNAPSHOT_LIST   1
 #define SNAPSHOT_CREATE 2
 #define SNAPSHOT_APPLY  3
-- 
2.14.3
