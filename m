Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB733C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7570C206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsNvtgZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7570C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5tZ-0000M3-Kq
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jP5ra-0005vT-47
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jP5rY-0004Hi-E2
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jP5rY-0004GC-A9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587048691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lALPtScT6gir/jpjzcOMmlzfGURjh+wMxkTlrOLeOQ=;
 b=GsNvtgZTlZa44/G4YPjJ9SmaUqbq/dDvyeebPfoP0xecgju2Mt11lN0l8wptfVtYosr2OQ
 cSyMVzwH7jpWMYrXQwwVnxnYyyb9GvHZGbqm0y0+V+NNB3IsjOiTBDj+ktivgKxhKNF5wU
 gcoNccGUi2hCUxRnAgCqgeXxygBfTB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-CVTB3m1KOT6cLStpUSpbNw-1; Thu, 16 Apr 2020 10:51:20 -0400
X-MC-Unique: CVTB3m1KOT6cLStpUSpbNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76ADF100DFC5;
 Thu, 16 Apr 2020 14:51:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E50EF1001DD8;
 Thu, 16 Apr 2020 14:51:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qemu-img: Add convert --bitmaps option
Date: Thu, 16 Apr 2020 09:51:14 -0500
Message-Id: <20200416145115.699033-3-eblake@redhat.com>
In-Reply-To: <20200416145115.699033-1-eblake@redhat.com>
References: <20200416145115.699033-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: nsoffer@redhat.com, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it easier to copy all the persistent bitmaps of a source image
along with the contents, by adding a boolean flag for use with
qemu-img convert.

See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1779893

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-img.rst |  6 ++-
 qemu-img.c              | 81 +++++++++++++++++++++++++++++++++++++++--
 qemu-img-cmds.hx        |  4 +-
 3 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76c9..8c4d85e0b835 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -186,6 +186,10 @@ Parameters to convert subcommand:

 .. program:: qemu-img-convert

+.. option:: --bitmaps
+
+  Additionally copy all bitmaps
+
 .. option:: -n

   Skip the creation of the target volume
@@ -373,7 +377,7 @@ Command description:
   4
     Error on reading data

-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-=
T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PA=
RAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] O=
UTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [=
-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l=
 SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENA=
ME2 [...]] OUTPUT_FILENAME

   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img.c b/qemu-img.c
index 821cbf610e5f..6541357179c2 100644
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
@@ -71,6 +72,7 @@ enum {
     OPTION_SHRINK =3D 266,
     OPTION_SALVAGE =3D 267,
     OPTION_TARGET_IS_ZERO =3D 268,
+    OPTION_BITMAPS =3D 269,
 };

 typedef enum OutputFormat {
@@ -176,6 +178,7 @@ static void QEMU_NORETURN help(void)
            "       hiding corruption that has already occurred.\n"
            "\n"
            "Parameters to convert subcommand:\n"
+           "  '--bitmaps' copies all persistent bitmaps to destination\n"
            "  '-m' specifies how many coroutines work in parallel during t=
he convert\n"
            "       process (defaults to 8)\n"
            "  '-W' allow to write to the target out of order rather than s=
equential\n"
@@ -2054,6 +2057,47 @@ static int convert_do_copy(ImgConvertState *s)
     return s->ret;
 }

+static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState *d=
st)
+{
+    BdrvDirtyBitmap *bm;
+    Error *err =3D NULL;
+    BlockDirtyBitmapMergeSource *merge;
+    BlockDirtyBitmapMergeSourceList *list;
+
+    FOR_EACH_DIRTY_BITMAP(src, bm) {
+        const char *name;
+
+        if (!bdrv_dirty_bitmap_get_persistence(bm)) {
+            continue;
+        }
+        name =3D bdrv_dirty_bitmap_name(bm);
+        qmp_block_dirty_bitmap_add(dst->node_name, name,
+                                   true, bdrv_dirty_bitmap_granularity(bm)=
,
+                                   true, true,
+                                   true, !bdrv_dirty_bitmap_enabled(bm),
+                                   &err);
+        if (err) {
+            error_reportf_err(err, "Failed to create bitmap %s: ", name);
+            return -1;
+        }
+
+        merge =3D g_new0(BlockDirtyBitmapMergeSource, 1);
+        merge->type =3D QTYPE_QDICT;
+        merge->u.external.node =3D g_strdup(src->node_name);
+        merge->u.external.name =3D g_strdup(name);
+        list =3D g_new0(BlockDirtyBitmapMergeSourceList, 1);
+        list->value =3D merge;
+        qmp_block_dirty_bitmap_merge(dst->node_name, name, list, &err);
+        qapi_free_BlockDirtyBitmapMergeSourceList(list);
+        if (err) {
+            error_reportf_err(err, "Failed to populate bitmap %s: ", name)=
;
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 #define MAX_BUF_SECTORS 32768

 static int img_convert(int argc, char **argv)
@@ -2075,6 +2119,8 @@ static int img_convert(int argc, char **argv)
     int64_t ret =3D -EINVAL;
     bool force_share =3D false;
     bool explict_min_sparse =3D false;
+    bool bitmaps =3D false;
+    size_t nbitmaps =3D 0;

     ImgConvertState s =3D (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -2094,6 +2140,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS=
},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2225,6 +2272,9 @@ static int img_convert(int argc, char **argv)
              */
             s.has_zero_init =3D true;
             break;
+        case OPTION_BITMAPS:
+            bitmaps =3D true;
+            break;
         }
     }

@@ -2286,7 +2336,6 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }

-
     /* ret is still -EINVAL until here */
     ret =3D bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough=
);
     if (ret < 0) {
@@ -2446,6 +2495,28 @@ static int img_convert(int argc, char **argv)
         }
     }

+    /* Determine how many bitmaps need copying */
+    if (bitmaps) {
+        BdrvDirtyBitmap *bm;
+
+        if (s.src_num > 1) {
+            error_report("Copying bitmaps only possible with single source=
");
+            ret =3D -1;
+            goto out;
+        }
+        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
+            if (bdrv_dirty_bitmap_get_persistence(bm)) {
+                nbitmaps++;
+            }
+        }
+        if (nbitmaps > 0 && drv && !drv->bdrv_co_can_store_new_dirty_bitma=
p) {
+            error_report("Format driver '%s' does not support bitmaps",
+                         out_fmt);
+            ret =3D -1;
+            goto out;
+        }
+    }
+
     /*
      * The later open call will need any decryption secrets, and
      * bdrv_create() will purge "opts", so extract them now before
@@ -2454,9 +2525,7 @@ static int img_convert(int argc, char **argv)
     if (!skip_create) {
         open_opts =3D qdict_new();
         qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abor=
t);
-    }

-    if (!skip_create) {
         /* Create the new image */
         ret =3D bdrv_create(drv, out_filename, opts, &local_err);
         if (ret < 0) {
@@ -2553,6 +2622,12 @@ static int img_convert(int argc, char **argv)
     }

     ret =3D convert_do_copy(&s);
+
+    /* Now copy the bitmaps */
+    if (nbitmaps > 0 && ret =3D=3D 0) {
+        ret =3D convert_copy_bitmaps(blk_bs(s.src[0]), out_bs);
+    }
+
 out:
     if (!ret) {
         qemu_progress_print(100, 0);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df40..37cb36335218 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -39,9 +39,9 @@ SRST
 ERST

 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--=
target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_c=
ache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-=
S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [..=
.]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--=
target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cach=
e] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapsh=
ot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [f=
ilename2 [...]] output_filename")
 SRST
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-=
T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PA=
RAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENA=
ME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-op=
ts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [=
-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l=
 SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILE=
NAME [FILENAME2 [...]] OUTPUT_FILENAME
 ERST

 DEF("create", img_create,
--=20
2.26.0


