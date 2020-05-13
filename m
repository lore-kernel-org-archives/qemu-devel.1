Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7359C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0058206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC4pzfQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0058206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYg65-0001Fl-Tm
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 21:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg17-0000tl-HQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg13-0004C3-BZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589332616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9g9xjXwdt/uuQhCzsOyxmPoChlwl2arCETyJH/3Rpvw=;
 b=bC4pzfQrb1HbWYaX0Cosdjb0ur3i0IW6xsWW1HgPh1O8oqtMAdkywFqvmtX3L4F+7H0Ixb
 lxFKVfpkkhJbHwT2d3NsAFThPsY3FoXCL9Rz9OkzNi3/xMtVL5s2TpJpltjrWea9GIcA6h
 vzyioNewkHx7a2hRFoBOyfwxxjYE9D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BHrXGJNOMsKGVzgM-bvROg-1; Tue, 12 May 2020 21:16:54 -0400
X-MC-Unique: BHrXGJNOMsKGVzgM-bvROg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C930A107ACCA;
 Wed, 13 May 2020 01:16:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD401A923;
 Wed, 13 May 2020 01:16:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/9] blockdev: Promote several bitmap functions to
 non-static
Date: Tue, 12 May 2020 20:16:43 -0500
Message-Id: <20200513011648.166876-5-eblake@redhat.com>
In-Reply-To: <20200513011648.166876-1-eblake@redhat.com>
References: <20200513011648.166876-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 21:16:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will split blockdev.c, which will require accessing
some previously-static functions from more than one .c file.  But part
of promoting a function to public is picking a naming scheme that does
not reek of exposing too many internals (two of the three functions
were named starting with 'do_').  To make future code motion easier,
perform the function rename and non-static promotion into its own
patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 12 +++++++++++
 blockdev.c                | 45 ++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5bcd6aa39f6c..cd85899ea2b5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1344,4 +1344,16 @@ int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
                                             Error **errp);
 extern QemuOptsList bdrv_create_opts_simple;

+BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
+                                           const char *name,
+                                           BlockDriverState **pbs,
+                                           Error **errp);
+BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
+                                          BlockDirtyBitmapMergeSourceList *bms,
+                                          HBitmap **backup, Error **errp);
+BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
+                                           bool release,
+                                           BlockDriverState **bitmap_bs,
+                                           Error **errp);
+
 #endif /* BLOCK_INT_H */
diff --git a/blockdev.c b/blockdev.c
index b3c840ec0312..fbeb38437869 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1197,10 +1197,10 @@ out_aio_context:
  *
  * @return: A bitmap object on success, or NULL on failure.
  */
-static BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
-                                                  const char *name,
-                                                  BlockDriverState **pbs,
-                                                  Error **errp)
+BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
+                                           const char *name,
+                                           BlockDriverState **pbs,
+                                           Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
@@ -2171,11 +2171,6 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
-        const char *node, const char *target,
-        BlockDirtyBitmapMergeSourceList *bitmaps,
-        HBitmap **backup, Error **errp);
-
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
 {
@@ -2189,15 +2184,11 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,

     action = common->action->u.block_dirty_bitmap_merge.data;

-    state->bitmap = do_block_dirty_bitmap_merge(action->node, action->target,
-                                                action->bitmaps, &state->backup,
-                                                errp);
+    state->bitmap = block_dirty_bitmap_merge(action->node, action->target,
+                                             action->bitmaps, &state->backup,
+                                             errp);
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
-        const char *node, const char *name, bool release,
-        BlockDriverState **bitmap_bs, Error **errp);
-
 static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
                                               Error **errp)
 {
@@ -2211,8 +2202,8 @@ static void block_dirty_bitmap_remove_prepare(BlkActionState *common,

     action = common->action->u.block_dirty_bitmap_remove.data;

-    state->bitmap = do_block_dirty_bitmap_remove(action->node, action->name,
-                                                 false, &state->bs, errp);
+    state->bitmap = block_dirty_bitmap_remove(action->node, action->name,
+                                              false, &state->bs, errp);
     if (state->bitmap) {
         bdrv_dirty_bitmap_skip_store(state->bitmap, true);
         bdrv_dirty_bitmap_set_busy(state->bitmap, true);
@@ -2504,9 +2495,10 @@ out:
     aio_context_release(aio_context);
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
-        const char *node, const char *name, bool release,
-        BlockDriverState **bitmap_bs, Error **errp)
+BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
+                                           bool release,
+                                           BlockDriverState **bitmap_bs,
+                                           Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
@@ -2548,7 +2540,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                                    Error **errp)
 {
-    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
+    block_dirty_bitmap_remove(node, name, true, NULL, errp);
 }

 /**
@@ -2609,10 +2601,9 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
-        const char *node, const char *target,
-        BlockDirtyBitmapMergeSourceList *bitmaps,
-        HBitmap **backup, Error **errp)
+BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
+                                          BlockDirtyBitmapMergeSourceList *bitmaps,
+                                          HBitmap **backup, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *dst, *src, *anon;
@@ -2675,7 +2666,7 @@ void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
                                   BlockDirtyBitmapMergeSourceList *bitmaps,
                                   Error **errp)
 {
-    do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
+    block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }

 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
-- 
2.26.2


