Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E7C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic/vQXwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0OZ-0001Jk-0L
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0K8-0005Mk-7P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0Jr-0004g2-5C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0Jo-0004XI-GI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587504032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1p+XEQXqhHd/4LsBuiMrXV5IvjDV2boahY1DBkB22o=;
 b=ic/vQXwvlXMSE7dxchKdmyQyZ783Vc6Ehr2z9CGCA2QiLF7QllqXe3hyEd7U4x0ovpusw+
 YH+EXz0Sxjx1mNLQXNA5OBUvW+e2CnAZHkN5/UlbndBwrEuxSsjki0DQU7Zu74E0riKxrB
 cwt28NBXzMd5PP222+rkZS0RVkOeI1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-hiDAlmN0Ng-7kxGmVX7MQA-1; Tue, 21 Apr 2020 17:20:29 -0400
X-MC-Unique: hiDAlmN0Ng-7kxGmVX7MQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B131818C35A0;
 Tue, 21 Apr 2020 21:20:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE392A18B6;
 Tue, 21 Apr 2020 21:20:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] qemu-img: Add bitmap sub-command
Date: Tue, 21 Apr 2020 16:20:16 -0500
Message-Id: <20200421212019.170707-4-eblake@redhat.com>
In-Reply-To: <20200421212019.170707-1-eblake@redhat.com>
References: <20200421212019.170707-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 15:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: nsoffer@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include actions for --add, --remove, --clear, --enable, --disable, and
--merge (note that --clear is a bit of fluff, because the same can be
accomplished by removing a bitmap and then adding a new one in its
place, but it matches what QMP commands exist).  Listing is omitted,
because it does not require a bitmap name and because it was already
possible with 'qemu-img info'.  Merge can work either from another
bitmap in the same image, or from a bitmap in a distinct image.

While this supports --image-opts for the file being modified, I did
not think it worth the extra complexity to support that for the source
file in a cross-file bitmap merge.  Likewise, I chose to have --merge
only take a single source rather than following the QMP support for
multiple merges in one go; in part to simplify the command line, and
in part because an offline image can achieve the same effect by
multiple qemu-img bitmap --merge calls.  We can enhance that if needed
in the future (the same way that 'qemu-img convert' has a mode that
concatenates multiple sources into one destination).

Upcoming patches will add iotest coverage of these commands while
also testing other features.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-img.rst |  24 +++++
 qemu-img.c              | 198 ++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx        |   7 ++
 3 files changed, 229 insertions(+)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 7d08c48d308f..4f3b0e2c9ace 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -281,6 +281,30 @@ Command description:
   For write tests, by default a buffer filled with zeros is written. This =
can be
   overridden with a pattern byte specified by *PATTERN*.

+.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove | --cle=
ar | --enable | --disable | --merge SOURCE_BITMAP [-b SOURCE_FILE [-F SOURC=
E_FMT]]} [--object OBJECTDEF] [--image-opts] [-f FMT] FILENAME BITMAP
+
+  Perform a modification of the persistent bitmap *BITMAP* in the disk
+  image *FILENAME*.  The various modifications are:
+
+  ``--add`` to create *BITMAP*, with additional options ``-g`` to
+  specify a non-default *GRANULARITY*, or whether the bitmap should be
+  ``--disabled`` instead of enabled.
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
+  This defaults to requiring a source bitmap from the same *FILENAME*,
+  but can also be used for cross-image merge by supplying ``-b`` to
+  specify a different *SOURCE_FILE*.
+
+  To see what bitmaps are present in an image, use ``qemu-img info``.
+
 .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--out=
put=3DOFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME

   Perform a consistency check on the disk image *FILENAME*. The command ca=
n
diff --git a/qemu-img.c b/qemu-img.c
index 821cbf610e5f..02ebd870faa1 100644
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
     OPTION_SHRINK =3D 266,
     OPTION_SALVAGE =3D 267,
     OPTION_TARGET_IS_ZERO =3D 268,
+    OPTION_ADD =3D 269,
+    OPTION_REMOVE =3D 270,
+    OPTION_CLEAR =3D 271,
+    OPTION_ENABLE =3D 272,
+    OPTION_DISABLE =3D 273,
+    OPTION_MERGE =3D 274,
 };

 typedef enum OutputFormat {
@@ -4438,6 +4445,197 @@ out:
     return 0;
 }

+static int img_bitmap(int argc, char **argv)
+{
+    Error *err =3D NULL;
+    int c, ret =3D -1;
+    QemuOpts *opts =3D NULL;
+    const char *fmt =3D NULL, *src_fmt =3D NULL, *src_filename =3D NULL;
+    const char *filename, *bitmap;
+    BlockBackend *blk =3D NULL, *src =3D NULL;
+    BlockDriverState *bs =3D NULL, *src_bs =3D NULL;
+    bool image_opts =3D false;
+    unsigned long granularity =3D 0;
+    bool add =3D false, remove =3D false, clear =3D false;
+    bool enable =3D false, disable =3D false, add_disabled =3D false;
+    const char *merge =3D NULL;
+
+    for (;;) {
+        static const struct option long_options[] =3D {
+            {"help", no_argument, 0, 'h'},
+            {"object", required_argument, 0, OPTION_OBJECT},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"add", no_argument, 0, OPTION_ADD},
+            {"remove", no_argument, 0, OPTION_REMOVE},
+            {"clear", no_argument, 0, OPTION_CLEAR},
+            {"enable", no_argument, 0, OPTION_ENABLE},
+            {"disable", no_argument, 0, OPTION_DISABLE},
+            {"disabled", no_argument, 0, OPTION_DISABLE},
+            {"merge", required_argument, 0, OPTION_MERGE},
+            {"granularity", required_argument, 0, 'g'},
+            {"source-file", required_argument, 0, 'b'},
+            {"source-format", required_argument, 0, 'F'},
+            {0, 0, 0, 0}
+        };
+        c =3D getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
+        if (c =3D=3D -1) {
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
+            src_filename =3D optarg;
+            break;
+        case 'f':
+            fmt =3D optarg;
+            break;
+        case 'F':
+            src_fmt =3D optarg;
+            break;
+        case 'g':
+            if (qemu_strtosz(optarg, NULL, &granularity)) {
+                error_report("Invalid granularity specified");
+                return 1;
+            }
+            break;
+        case OPTION_ADD:
+            add =3D true;
+            break;
+        case OPTION_REMOVE:
+            remove =3D true;
+            break;
+        case OPTION_CLEAR:
+            clear =3D true;
+            break;
+        case OPTION_ENABLE:
+            enable =3D true;
+            break;
+        case OPTION_DISABLE:
+            disable =3D true;
+            break;
+        case OPTION_MERGE:
+            merge =3D optarg;
+            break;
+        case OPTION_OBJECT:
+            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                goto out;
+            }
+            break;
+        case OPTION_IMAGE_OPTS:
+            image_opts =3D true;
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
+    if (add && disable) {
+        disable =3D false;
+        add_disabled =3D true;
+    }
+    if (add + remove + clear + enable + disable + !!merge !=3D 1) {
+        error_report("Need exactly one mode of --add, --remove, --clear, "
+                     "--enable, --disable, or --merge");
+        goto out;
+    }
+    if (granularity && !add) {
+        error_report("granularity only supported with --add");
+        goto out;
+    }
+    if (src_fmt && !src_filename) {
+        error_report("-F only supported with -b");
+        goto out;
+    }
+    if (src_filename && !merge) {
+        error_report("alternate source file only supported with --merge");
+        goto out;
+    }
+
+    if (optind !=3D argc - 2) {
+        error_report("Expecting filename and bitmap name");
+        goto out;
+    }
+
+    filename =3D argv[optind];
+    bitmap =3D argv[optind + 1];
+
+    blk =3D img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
+                   false);
+    if (!blk) {
+        goto out;
+    }
+    bs =3D blk_bs(blk);
+
+    if (add) {
+        qmp_block_dirty_bitmap_add(bs->node_name, bitmap,
+                                   !!granularity, granularity, true, true,
+                                   true, add_disabled, &err);
+    } else if (remove) {
+        qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
+    } else if (clear) {
+        qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
+    } else if (enable) {
+        qmp_block_dirty_bitmap_enable(bs->node_name, bitmap, &err);
+    } else if (disable) {
+        qmp_block_dirty_bitmap_disable(bs->node_name, bitmap, &err);
+    } else if (merge) {
+        BlockDirtyBitmapMergeSource *merge_src;
+        BlockDirtyBitmapMergeSourceList *list;
+
+        if (src_filename) {
+            src =3D img_open(NULL, src_filename, src_fmt, 0, false, false,
+                           false);
+            if (!src) {
+                goto out;
+            }
+            src_bs =3D blk_bs(src);
+        } else {
+            src_bs =3D bs;
+        }
+
+        merge_src =3D g_new0(BlockDirtyBitmapMergeSource, 1);
+        merge_src->type =3D QTYPE_QDICT;
+        merge_src->u.external.node =3D g_strdup(src_bs->node_name);
+        merge_src->u.external.name =3D g_strdup(merge);
+        list =3D g_new0(BlockDirtyBitmapMergeSourceList, 1);
+        list->value =3D merge_src;
+        qmp_block_dirty_bitmap_merge(bs->node_name, bitmap, list, &err);
+        qapi_free_BlockDirtyBitmapMergeSourceList(list);
+    }
+
+    if (err) {
+        error_reportf_err(err, "Bitmap %s operation failed", bitmap);
+        ret =3D -1;
+        goto out;
+    }
+
+    ret =3D 0;
+
+ out:
+    blk_unref(src);
+    blk_unref(blk);
+    qemu_opts_del(opts);
+    if (ret) {
+        return 1;
+    }
+    return 0;
+}
+
 #define C_BS      01
 #define C_COUNT   02
 #define C_IF      04
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df40..bf0035e226c8 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -20,6 +20,13 @@ DEF("bench", img_bench,
 SRST
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q=
] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 ERST
+
+DEF("bitmap", img_bitmap,
+    "bitmap {--add [-g granularity] [--disabled] | --remove | --clear | --=
enable | --disable | --merge source_bitmap [-b source_file [-F source_fmt]]=
} [--object objectdef] [--image-opts] [-f fmt] filename bitmap")
+SRST
+.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove | --cle=
ar | --enable | --disable | --merge SOURCE_BITMAP [-b SOURCE_FILE [-F SOURC=
E_FMT]]} [--object OBJECTDEF] [--image-opts] [-f FMT] FILENAME BITMAP
+ERST
+
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=3Do=
fmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
 SRST
--=20
2.26.2


