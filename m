Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D6C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B470820724
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdd9vVhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B470820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0Mc-0007DG-Ng
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0K8-0005NH-Rm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0Jt-0004jC-Bc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0Jo-0004ZS-Px
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587504034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyNwNlAI3/UdDqYJZEEjujm56+3KWTXeD6WEShYsXQA=;
 b=Mdd9vVhp8iE8ItFRe+Tio+lNjWeQ45x/HNOKYXbrLRVWhQV0QsVS/FR+vAaVjETW+a+48l
 F6SpUkrdStOseamKIujKJ6ICzkqZmf4O9oiXLEC4COl/3PcdDJ7wHjVVLKgdP2u/l/gPHP
 b1NJAXaHtvWYGh14d+4j5TIG//qI0AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-ScnwtlOKOW2q3x_BJBXpvA-1; Tue, 21 Apr 2020 17:20:30 -0400
X-MC-Unique: ScnwtlOKOW2q3x_BJBXpvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F601800D53;
 Tue, 21 Apr 2020 21:20:29 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71D69A18BC;
 Tue, 21 Apr 2020 21:20:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] qemu-img: Add convert --bitmaps option
Date: Tue, 21 Apr 2020 16:20:18 -0500
Message-Id: <20200421212019.170707-6-eblake@redhat.com>
In-Reply-To: <20200421212019.170707-1-eblake@redhat.com>
References: <20200421212019.170707-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 17:20:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

Make it easier to copy all the persistent bitmaps of a source image
along with the contents, by adding a boolean flag for use with
qemu-img convert.  This is basically shorthand, as the same effect
could be accomplished with a series of 'qemu-img bitmap --add' and
'qemu-img bitmap --merge -b source' commands, or by QMP commands.

See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1779893

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-img.rst |  6 +++-
 qemu-img.c              | 80 +++++++++++++++++++++++++++++++++++++++--
 qemu-img-cmds.hx        |  4 +--
 3 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 4f3b0e2c9ace..430fb5b46e43 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -162,6 +162,10 @@ Parameters to convert subcommand:

 .. program:: qemu-img-convert

+.. option:: --bitmaps
+
+  Additionally copy all bitmaps
+
 .. option:: -n

   Skip the creation of the target volume
@@ -397,7 +401,7 @@ Command description:
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
index e1127273f21e..6cfc1f52ef98 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -78,6 +78,7 @@ enum {
     OPTION_ENABLE =3D 272,
     OPTION_DISABLE =3D 273,
     OPTION_MERGE =3D 274,
+    OPTION_BITMAPS =3D 275,
 };

 typedef enum OutputFormat {
@@ -183,6 +184,7 @@ static void QEMU_NORETURN help(void)
            "       hiding corruption that has already occurred.\n"
            "\n"
            "Parameters to convert subcommand:\n"
+           "  '--bitmaps' copies all persistent bitmaps to destination\n"
            "  '-m' specifies how many coroutines work in parallel during t=
he convert\n"
            "       process (defaults to 8)\n"
            "  '-W' allow to write to the target out of order rather than s=
equential\n"
@@ -2061,6 +2063,47 @@ static int convert_do_copy(ImgConvertState *s)
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
@@ -2082,6 +2125,8 @@ static int img_convert(int argc, char **argv)
     int64_t ret =3D -EINVAL;
     bool force_share =3D false;
     bool explict_min_sparse =3D false;
+    bool bitmaps =3D false;
+    size_t nbitmaps =3D 0;

     ImgConvertState s =3D (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -2101,6 +2146,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS=
},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {0, 0, 0, 0}
         };
         c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2232,6 +2278,9 @@ static int img_convert(int argc, char **argv)
              */
             s.has_zero_init =3D true;
             break;
+        case OPTION_BITMAPS:
+            bitmaps =3D true;
+            break;
         }
     }

@@ -2293,7 +2342,6 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }

-
     /* ret is still -EINVAL until here */
     ret =3D bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough=
);
     if (ret < 0) {
@@ -2453,6 +2501,28 @@ static int img_convert(int argc, char **argv)
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
@@ -2461,9 +2531,7 @@ static int img_convert(int argc, char **argv)
     if (!skip_create) {
         open_opts =3D qdict_new();
         qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abor=
t);
-    }

-    if (!skip_create) {
         /* Create the new image */
         ret =3D bdrv_create(drv, out_filename, opts, &local_err);
         if (ret < 0) {
@@ -2560,6 +2628,12 @@ static int img_convert(int argc, char **argv)
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
index bf0035e226c8..cf574792bd99 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ SRST
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
2.26.2


