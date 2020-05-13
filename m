Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A02C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4A8206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MspwXyB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A8206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYg3g-0006Z6-Vp
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 21:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg1B-0000zV-Rd
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg18-0004Eh-Ch
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589332621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUmpBgwvMBdjkU247nj6oPQM/nsn7SDDfkPeLrMF6aM=;
 b=MspwXyB3RLxg17smB9cppHz7vXg3otjh2NvkYZ7XHfdjHBigLZRnbBBaXnuC7RaKznF8dv
 4fsB1l7rb7Db/Rb6n+M7FSNQnQ++v6okva7q9oM86CqU09+f/7/frYQCEqulO3MdzMYJZM
 DEzMq6SVlMn2ORKDo25vdkOe6f1FeMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-SHre0vAjML6g4JbSxCABbA-1; Tue, 12 May 2020 21:16:57 -0400
X-MC-Unique: SHre0vAjML6g4JbSxCABbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0A17802EAD;
 Wed, 13 May 2020 01:16:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F1701A923;
 Wed, 13 May 2020 01:16:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 8/9] qemu-img: Add convert --bitmaps option
Date: Tue, 12 May 2020 20:16:47 -0500
Message-Id: <20200513011648.166876-9-eblake@redhat.com>
In-Reply-To: <20200513011648.166876-1-eblake@redhat.com>
References: <20200513011648.166876-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 21:16:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
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
---
 docs/tools/qemu-img.rst |  6 ++-
 qemu-img.c              | 85 +++++++++++++++++++++++++++++++++++++++--
 qemu-img-cmds.hx        |  4 +-
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index b6f87ec6d3c0..25156f489696 100644
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
index 0a326993d7ac..a90d1eeefcba 100644
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
@@ -2109,6 +2110,47 @@ static int convert_do_copy(ImgConvertState *s)
     return s->ret;
 }

+static int convert_copy_bitmaps(BlockDriverState *src, BlockDriverState *dst)
+{
+    BdrvDirtyBitmap *bm;
+    Error *err = NULL;
+    BlockDirtyBitmapMergeSource *merge;
+    BlockDirtyBitmapMergeSourceList *list;
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
+        merge = g_new0(BlockDirtyBitmapMergeSource, 1);
+        merge->type = QTYPE_QDICT;
+        merge->u.external.node = g_strdup(src->node_name);
+        merge->u.external.name = g_strdup(name);
+        list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
+        list->value = merge;
+        qmp_block_dirty_bitmap_merge(dst->node_name, name, list, &err);
+        qapi_free_BlockDirtyBitmapMergeSourceList(list);
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
@@ -2130,6 +2172,8 @@ static int img_convert(int argc, char **argv)
     int64_t ret = -EINVAL;
     bool force_share = false;
     bool explict_min_sparse = false;
+    bool bitmaps = false;
+    size_t nbitmaps = 0;

     ImgConvertState s = (ImgConvertState) {
         /* Need at least 4k of zeros for sparse detection */
@@ -2149,6 +2193,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2272,6 +2317,9 @@ static int img_convert(int argc, char **argv)
              */
             s.has_zero_init = true;
             break;
+        case OPTION_BITMAPS:
+            bitmaps = true;
+            break;
         }
     }

@@ -2333,7 +2381,6 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }

-
     /* ret is still -EINVAL until here */
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
@@ -2493,6 +2540,27 @@ static int img_convert(int argc, char **argv)
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
@@ -2501,9 +2569,7 @@ static int img_convert(int argc, char **argv)
     if (!skip_create) {
         open_opts = qdict_new();
         qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_abort);
-    }

-    if (!skip_create) {
         /* Create the new image */
         ret = bdrv_create(drv, out_filename, opts, &local_err);
         if (ret < 0) {
@@ -2541,6 +2607,13 @@ static int img_convert(int argc, char **argv)
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
@@ -2600,6 +2673,12 @@ static int img_convert(int argc, char **argv)
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
index bfcd9f32dddf..2791c4f58ddd 100644
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


