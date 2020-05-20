Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4477020873
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD5CdLcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4477020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWpI-0002Qd-Ea
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 18:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWmM-0005Cv-Fh
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:01:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWmL-0005k3-5D
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590012092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrKQgds3eX8I9cRTZDXZqk4YQTzwfFUE4ypxtX5Xnk8=;
 b=UD5CdLcbX7DUon67HG//gZWup8Zcip4etmKJDor/2L4c4pM7XgWmDZej8p/G11zpvilgP4
 5SPHHzUvUQ10z+eSnDL2273JZ45tcVLn3ogH7vvGr7OG2442PRbDpFqsmbJj6aE5d7Ywut
 0RLIeo/PGh2kDkh6/hmd3e+EpGi1YwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-HTbuTbnKMbS1USsIA3gEUg-1; Wed, 20 May 2020 18:01:25 -0400
X-MC-Unique: HTbuTbnKMbS1USsIA3gEUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65F90800053;
 Wed, 20 May 2020 22:01:24 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DED356EA28;
 Wed, 20 May 2020 22:01:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/5] qemu-img: Add convert --bitmaps option
Date: Wed, 20 May 2020 17:01:17 -0500
Message-Id: <20200520220118.1037094-5-eblake@redhat.com>
In-Reply-To: <20200520220118.1037094-1-eblake@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 18:01:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it easier to copy all the persistent bitmaps of (the top layer
of) a source image along with its guest-visible contents, by adding a
boolean flag for use with qemu-img convert.  This is basically
shorthand, as the same effect could be accomplished with a series of
'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
commands, or by QMP commands.

Note that this command will fail in the same scenarios where 'qemu-img
measure --bitmaps' fails, when either the source or the destanation
lacks persistent bitmap support altogether.

See also https://bugzilla.redhat.com/show_bug.cgi?id=1779893

While touching this, clean up a couple coding issues spotted in the
same function: an extra blank line, and merging back-to-back 'if
(!skip_create)' blocks.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513011648.166876-9-eblake@redhat.com>
---
 docs/tools/qemu-img.rst |  6 +++-
 qemu-img.c              | 77 +++++++++++++++++++++++++++++++++++++++--
 qemu-img-cmds.hx        |  4 +--
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 9a8112fc9f58..35050fc51070 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -162,6 +162,10 @@ Parameters to convert subcommand:

 .. program:: qemu-img-convert

+.. option:: --bitmaps
+
+  Additionally copy all persistent bitmaps from the top layer of the source
+
 .. option:: -n

   Skip the creation of the target volume
@@ -397,7 +401,7 @@ Command description:
   4
     Error on reading data

-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME

   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img.c b/qemu-img.c
index c1bafb57023a..1494d8f5c409 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -192,6 +192,7 @@ static void QEMU_NORETURN help(void)
            "       hiding corruption that has already occurred.\n"
            "\n"
            "Parameters to convert subcommand:\n"
+           "  '--bitmaps' copies all top-level persistent bitmaps to destination\n"
            "  '-m' specifies how many coroutines work in parallel during the convert\n"
            "       process (defaults to 8)\n"
            "  '-W' allow to write to the target out of order rather than sequential\n"
@@ -2139,6 +2140,39 @@ static int convert_do_copy(ImgConvertState *s)
     return s->ret;
 }

+static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState *dst)
+{
+    BdrvDirtyBitmap *bm;
+    Error *err = NULL;
+
+    FOR_EACH_DIRTY_BITMAP(src, bm) {
+        const char *name;
+
+        if (!bdrv_dirty_bitmap_get_persistence(bm)) {
+            continue;
+        }
+        name = bdrv_dirty_bitmap_name(bm);
+        qmp_block_dirty_bitmap_add(dst->node_name, name,
+                                   true, bdrv_dirty_bitmap_granularity(bm),
+                                   true, true,
+                                   true, !bdrv_dirty_bitmap_enabled(bm),
+                                   &err);
+        if (err) {
+            error_reportf_err(err, "Failed to create bitmap %s: ", name);
+            return -1;
+        }
+
+        do_dirty_bitmap_merge(dst->node_name, name, src->node_name, name,
+                              &err);
+        if (err) {
+            error_reportf_err(err, "Failed to populate bitmap %s: ", name);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 #define MAX_BUF_SECTORS 32768

 static int img_convert(int argc, char **argv)
@@ -2160,6 +2194,8 @@ static int img_convert(int argc, char **argv)
     int64_t ret = -EINVAL;
     bool force_share = false;
     bool explict_min_sparse = false;
+    bool bitmaps = false;
+    size_t nbitmaps = 0;

     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -2179,6 +2215,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2304,6 +2341,9 @@ static int img_convert(int argc, char **argv)
              */
             s.has_zero_init = true;
             break;
+        case OPTION_BITMAPS:
+            bitmaps = true;
+            break;
         }
     }

@@ -2365,7 +2405,6 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }

-
     /* ret is still -EINVAL until here */
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
@@ -2525,6 +2564,27 @@ static int img_convert(int argc, char **argv)
         }
     }

+    /* Determine how many bitmaps need copying */
+    if (bitmaps) {
+        BdrvDirtyBitmap *bm;
+
+        if (s.src_num > 1) {
+            error_report("Copying bitmaps only possible with single source");
+            ret = -1;
+            goto out;
+        }
+        if (!bdrv_supports_persistent_dirty_bitmap(blk_bs(s.src[0]))) {
+            error_report("Source lacks bitmap support");
+            ret = -1;
+            goto out;
+        }
+        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
+            if (bdrv_dirty_bitmap_get_persistence(bm)) {
+                nbitmaps++;
+            }
+        }
+    }
+
     /*
      * The later open call will need any decryption secrets, and
      * bdrv_create() will purge "opts", so extract them now before
@@ -2533,9 +2593,7 @@ static int img_convert(int argc, char **argv)
     if (!skip_create) {
         open_opts = qdict_new();
         qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abort);
-    }

-    if (!skip_create) {
         /* Create the new image */
         ret = bdrv_create(drv, out_filename, opts, &local_err);
         if (ret < 0) {
@@ -2573,6 +2631,13 @@ static int img_convert(int argc, char **argv)
     }
     out_bs = blk_bs(s.target);

+    if (nbitmaps > 0 && !bdrv_supports_persistent_dirty_bitmap(out_bs)) {
+        error_report("Format driver '%s' does not support bitmaps",
+                     out_fmt);
+        ret = -1;
+        goto out;
+    }
+
     if (s.compressed && !block_driver_can_compress(out_bs->drv)) {
         error_report("Compression not supported for this file format");
         ret = -1;
@@ -2632,6 +2697,12 @@ static int img_convert(int argc, char **argv)
     }

     ret = convert_do_copy(&s);
+
+    /* Now copy the bitmaps */
+    if (nbitmaps > 0 && ret == 0) {
+        ret = convert_copy_bitmaps(blk_bs(s.src[0]), out_bs);
+    }
+
 out:
     if (!ret) {
         qemu_progress_print(100, 0);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 235cc5fffadc..e9beb15e614e 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -46,9 +46,9 @@ SRST
 ERST

 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
 SRST
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 ERST

 DEF("create", img_create,
-- 
2.26.2


