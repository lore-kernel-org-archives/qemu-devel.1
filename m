Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC373C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94015207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL78qZBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94015207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4yM-0006b2-QJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4xQ-0005i9-71
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:19:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4xM-0007bh-UX
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589905144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHAa6CE19YbhTcjh3UW/cpIxhc6WPc5Uno7Wwy23QTw=;
 b=EL78qZBpDxtoNRWdHMwEi7RZ8QPAaCGZyoQhjsA8rikGsnMgsiZRFnMQCSfEIRZtG0V87t
 B9vf6kJ0naAA13uv60OlQiI/z2m2WXsGf9FSh2Ihv1SKNeCK5ArOy4MUP9CQbPxfqSq1SI
 XzOQaPBuhY/NgRva3YbPP0+hNB+V/XI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-_ZIJYDmTPPeUyoTLzIp_9Q-1; Tue, 19 May 2020 12:18:57 -0400
X-MC-Unique: _ZIJYDmTPPeUyoTLzIp_9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5B78018A6;
 Tue, 19 May 2020 16:18:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF64F1002394;
 Tue, 19 May 2020 16:18:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 7/7] qemu-img: Add bitmap sub-command
Date: Tue, 19 May 2020 11:18:40 -0500
Message-Id: <20200519161840.810320-8-eblake@redhat.com>
In-Reply-To: <20200519161840.810320-1-eblake@redhat.com>
References: <20200519161840.810320-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include actions for --add, --remove, --clear, --enable, --disable, and
--merge (note that --clear is a bit of fluff, because the same can be
accomplished by removing a bitmap and then adding a new one in its
place, but it matches what QMP commands exist).  Listing is omitted,
because it does not require a bitmap name and because it was already
possible with 'qemu-img info'.  A single command line can play one or
more bitmap commands in sequence on the same bitmap name (although all
added bitmaps share the same granularity, and and all merged bitmaps
come from the same source file).  Merge defaults to other bitmaps in
the primary image, but can also be told to merge bitmaps from a
distinct image.

While this supports --image-opts for the file being modified, I did
not think it worth the extra complexity to support that for the source
file in a cross-file merges.  Likewise, I chose to have --merge only
take a single source rather than following the QMP support for
multiple merges in one go (although you can still use more than one
--merge in the command line); in part because qemu-img is offline and
therefore atomicity is not an issue.

Upcoming patches will add iotest coverage of these commands while
also testing other features.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513011648.166876-7-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/tools/qemu-img.rst |  24 ++++
 qemu-img.c              | 249 ++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx        |   7 ++
 3 files changed, 280 insertions(+)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 3b6223b5d630..38d464ea3f23 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -281,6 +281,30 @@ Command description:
   For write tests, by default a buffer filled with zeros is written. This can be
   overridden with a pattern byte specified by *PATTERN*.

+.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
+
+  Perform one or more modifications of the persistent bitmap *BITMAP*
+  in the disk image *FILENAME*.  The various modifications are:
+
+  ``--add`` to create *BITMAP*, enabled to record future edits.
+
+  ``--remove`` to remove *BITMAP*.
+
+  ``--clear`` to clear *BITMAP*.
+
+  ``--enable`` to change *BITMAP* to start recording future edits.
+
+  ``--disable`` to change *BITMAP* to stop recording future edits.
+
+  ``--merge`` to merge the contents of *SOURCE_BITMAP* into *BITMAP*.
+
+  Additional options include ``-g`` which sets a non-default
+  *GRANULARITY* for ``--add``, and ``-b`` and ``-F`` which select an
+  alternative source file for all *SOURCE* bitmaps used by
+  ``--merge``.
+
+  To see what bitmaps are present in an image, use ``qemu-img info``.
+
 .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--output=OFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME

   Perform a consistency check on the disk image *FILENAME*. The command can
diff --git a/qemu-img.c b/qemu-img.c
index 4740de082fab..98c008372c93 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -28,6 +28,7 @@
 #include "qemu-common.h"
 #include "qemu-version.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
@@ -71,6 +72,12 @@ enum {
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
     OPTION_TARGET_IS_ZERO = 268,
+    OPTION_ADD = 269,
+    OPTION_REMOVE = 270,
+    OPTION_CLEAR = 271,
+    OPTION_ENABLE = 272,
+    OPTION_DISABLE = 273,
+    OPTION_MERGE = 274,
 };

 typedef enum OutputFormat {
@@ -169,6 +176,14 @@ static void QEMU_NORETURN help(void)
            "  '-n' skips the target volume creation (useful if the volume is created\n"
            "       prior to running qemu-img)\n"
            "\n"
+           "Parameters to bitmap subcommand:\n"
+           "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
+           "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
+           "       or '--merge source'\n"
+           "  '-g granularity' sets the granularity for '--add' actions\n"
+           "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
+           "       bitmaps from an alternative file\n"
+           "\n"
            "Parameters to check subcommand:\n"
            "  '-r' tries to repair any inconsistencies that are found during the check.\n"
            "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
@@ -4502,6 +4517,240 @@ out:
     return 0;
 }

+enum ImgBitmapAct {
+    BITMAP_ADD,
+    BITMAP_REMOVE,
+    BITMAP_CLEAR,
+    BITMAP_ENABLE,
+    BITMAP_DISABLE,
+    BITMAP_MERGE,
+};
+typedef struct ImgBitmapAction {
+    enum ImgBitmapAct act;
+    const char *src; /* only used for merge */
+    QSIMPLEQ_ENTRY(ImgBitmapAction) next;
+} ImgBitmapAction;
+
+static int img_bitmap(int argc, char **argv)
+{
+    Error *err = NULL;
+    int c, ret = 1;
+    QemuOpts *opts = NULL;
+    const char *fmt = NULL, *src_fmt = NULL, *src_filename = NULL;
+    const char *filename, *bitmap;
+    BlockBackend *blk = NULL, *src = NULL;
+    BlockDriverState *bs = NULL, *src_bs = NULL;
+    bool image_opts = false;
+    int64_t granularity = 0;
+    bool add = false, merge = false;
+    QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
+    ImgBitmapAction *act, *act_next;
+    const char *op;
+
+    QSIMPLEQ_INIT(&actions);
+
+    for (;;) {
+        static const struct option long_options[] = {
+            {"help", no_argument, 0, 'h'},
+            {"object", required_argument, 0, OPTION_OBJECT},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"add", no_argument, 0, OPTION_ADD},
+            {"remove", no_argument, 0, OPTION_REMOVE},
+            {"clear", no_argument, 0, OPTION_CLEAR},
+            {"enable", no_argument, 0, OPTION_ENABLE},
+            {"disable", no_argument, 0, OPTION_DISABLE},
+            {"merge", required_argument, 0, OPTION_MERGE},
+            {"granularity", required_argument, 0, 'g'},
+            {"source-file", required_argument, 0, 'b'},
+            {"source-format", required_argument, 0, 'F'},
+            {0, 0, 0, 0}
+        };
+        c = getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
+        if (c == -1) {
+            break;
+        }
+
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
+        case 'b':
+            src_filename = optarg;
+            break;
+        case 'f':
+            fmt = optarg;
+            break;
+        case 'F':
+            src_fmt = optarg;
+            break;
+        case 'g':
+            granularity = cvtnum(optarg);
+            if (granularity < 0) {
+                error_report("Invalid granularity specified");
+                return 1;
+            }
+            break;
+        case OPTION_ADD:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_ADD;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            add = true;
+            break;
+        case OPTION_REMOVE:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_REMOVE;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            break;
+        case OPTION_CLEAR:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_CLEAR;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            break;
+        case OPTION_ENABLE:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_ENABLE;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            break;
+        case OPTION_DISABLE:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_DISABLE;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            break;
+        case OPTION_MERGE:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_MERGE;
+            act->src = optarg;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            merge = true;
+            break;
+        case OPTION_OBJECT:
+            opts = qemu_opts_parse_noisily(&qemu_object_opts, optarg, true);
+            if (!opts) {
+                goto out;
+            }
+            break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        }
+    }
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          qemu_img_object_print_help, &error_fatal)) {
+        goto out;
+    }
+
+    if (QSIMPLEQ_EMPTY(&actions)) {
+        error_report("Need at least one of --add, --remove, --clear, "
+                     "--enable, --disable, or --merge");
+        goto out;
+    }
+
+    if (granularity && !add) {
+        error_report("granularity only supported with --add");
+        goto out;
+    }
+    if (src_fmt && !src_filename) {
+        error_report("-F only supported with -b");
+        goto out;
+    }
+    if (src_filename && !merge) {
+        error_report("Merge bitmap source file only supported with "
+                     "--merge");
+        goto out;
+    }
+
+    if (optind != argc - 2) {
+        error_report("Expecting filename and bitmap name");
+        goto out;
+    }
+
+    filename = argv[optind];
+    bitmap = argv[optind + 1];
+
+    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
+                   false);
+    if (!blk) {
+        goto out;
+    }
+    bs = blk_bs(blk);
+    if (src_filename) {
+        src = img_open(false, src_filename, src_fmt, 0, false, false, false);
+        if (!src) {
+            goto out;
+        }
+        src_bs = blk_bs(src);
+    } else {
+        src_bs = bs;
+    }
+
+    QSIMPLEQ_FOREACH_SAFE(act, &actions, next, act_next) {
+        switch (act->act) {
+        case BITMAP_ADD:
+            qmp_block_dirty_bitmap_add(bs->node_name, bitmap,
+                                       !!granularity, granularity, true, true,
+                                       false, false, &err);
+            op = "add";
+            break;
+        case BITMAP_REMOVE:
+            qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
+            op = "remove";
+            break;
+        case BITMAP_CLEAR:
+            qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
+            op = "clear";
+            break;
+        case BITMAP_ENABLE:
+            qmp_block_dirty_bitmap_enable(bs->node_name, bitmap, &err);
+            op = "enable";
+            break;
+        case BITMAP_DISABLE:
+            qmp_block_dirty_bitmap_disable(bs->node_name, bitmap, &err);
+            op = "disable";
+            break;
+        case BITMAP_MERGE: {
+            BlockDirtyBitmapMergeSource *merge_src;
+            BlockDirtyBitmapMergeSourceList *list;
+
+            merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
+            merge_src->type = QTYPE_QDICT;
+            merge_src->u.external.node = g_strdup(src_bs->node_name);
+            merge_src->u.external.name = g_strdup(act->src);
+            list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
+            list->value = merge_src;
+            qmp_block_dirty_bitmap_merge(bs->node_name, bitmap, list, &err);
+            qapi_free_BlockDirtyBitmapMergeSourceList(list);
+            op = "merge";
+            break;
+        }
+        default:
+            g_assert_not_reached();
+        }
+
+        if (err) {
+            error_reportf_err(err, "Operation %s on bitmap %s failed: ",
+                              op, bitmap);
+            goto out;
+        }
+        g_free(act);
+    }
+
+    ret = 0;
+
+ out:
+    blk_unref(src);
+    blk_unref(blk);
+    qemu_opts_del(opts);
+    return ret;
+}
+
 #define C_BS      01
 #define C_COUNT   02
 #define C_IF      04
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index cfe8f375870c..a87d3cb264ce 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -20,6 +20,13 @@ DEF("bench", img_bench,
 SRST
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 ERST
+
+DEF("bitmap", img_bitmap,
+    "bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b source_file [-F source_fmt]] [-g granularity] [--object objectdef] [--image-opts | -f fmt] filename bitmap")
+SRST
+.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
+ERST
+
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 SRST
-- 
2.26.2


