Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DCC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E28820833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRG4U-0005Ko-B1
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:05:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRFTy-0007uh-JC
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRFTv-00087H-HK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:27:34 -0400
Received: from relay.sw.ru ([185.231.240.75]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRFTv-00085E-A2; Thu, 16 May 2019 08:27:31 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hRFTp-0006Eb-Vd; Thu, 16 May 2019 15:27:26 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 16 May 2019 15:27:24 +0300
Message-Id: <20190516122725.132334-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190516122725.132334-1-vsementsov@virtuozzo.com>
References: <20190516122725.132334-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/2] qapi: support external bitmaps in
 block-dirty-bitmap-merge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new optional parameter making possible to merge bitmaps from
different nodes. It is needed to maintain external snapshots during
incremental backup chain history.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 13 ++++++++++---
 block/dirty-bitmap.c |  9 ++++++---
 blockdev.c           | 46 ++++++++++++++++++++++++++++++--------------
 3 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..933b50771a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2006,16 +2006,23 @@
 ##
 # @BlockDirtyBitmapMerge:
 #
-# @node: name of device/node which the bitmap is tracking
+# @node: name of device/node which the @target and @bitmaps bitmaps are
+#        tracking
 #
 # @target: name of the destination dirty bitmap
 #
-# @bitmaps: name(s) of the source dirty bitmap(s)
+# @bitmaps: name(s) of the source dirty bitmap(s). The field is optional
+#           since 4.1.
+#
+# @external-bitmaps: additional list of source dirty bitmaps with specified
+#                    nodes, which allows merging bitmaps between different
+#                    nodes. (Since: 4.1)
 #
 # Since: 4.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
-  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
+  'data': { 'node': 'str', 'target': 'str', '*bitmaps': ['str'],
+            '*external-bitmaps': ['BlockDirtyBitmap'] } }
 
 ##
 # @block-dirty-bitmap-add:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 59e6ebb861..49646a30e6 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -816,10 +816,10 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 {
     bool ret;
 
-    /* only bitmaps from one bds are supported */
-    assert(dest->mutex == src->mutex);
-
     qemu_mutex_lock(dest->mutex);
+    if (src->mutex != dest->mutex) {
+        qemu_mutex_lock(src->mutex);
+    }
 
     if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
         goto out;
@@ -845,4 +845,7 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
 out:
     qemu_mutex_unlock(dest->mutex);
+    if (src->mutex != dest->mutex) {
+        qemu_mutex_unlock(src->mutex);
+    }
 }
diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..8d37ce5943 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2112,11 +2112,9 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }
 
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp);
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target, strList *bitmaps,
+        BlockDirtyBitmapList *external_bitmaps, HBitmap **backup, Error **errp);
 
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
@@ -2132,8 +2130,9 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
     action = common->action->u.block_dirty_bitmap_merge.data;
 
     state->bitmap = do_block_dirty_bitmap_merge(action->node, action->target,
-                                                action->bitmaps, &state->backup,
-                                                errp);
+                                                action->bitmaps,
+                                                action->external_bitmaps,
+                                                &state->backup, errp);
 }
 
 static void abort_prepare(BlkActionState *common, Error **errp)
@@ -2965,15 +2964,14 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp)
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target, strList *bitmaps,
+        BlockDirtyBitmapList *external_bitmaps, HBitmap **backup, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *dst, *src, *anon;
     strList *lst;
+    BlockDirtyBitmapList *ext_lst;
     Error *local_err = NULL;
 
     dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
@@ -3003,6 +3001,22 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
         }
     }
 
+    for (ext_lst = external_bitmaps; ext_lst; ext_lst = ext_lst->next) {
+        src = block_dirty_bitmap_lookup(ext_lst->value->node,
+                                        ext_lst->value->name, NULL, errp);
+        if (!src) {
+            dst = NULL;
+            goto out;
+        }
+
+        bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            dst = NULL;
+            goto out;
+        }
+    }
+
     /* Merge into dst; dst is unchanged on failure. */
     bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
 
@@ -3012,9 +3026,13 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
 }
 
 void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
-                                  strList *bitmaps, Error **errp)
+                                  bool has_bitmaps, strList *bitmaps,
+                                  bool has_external_bitmaps,
+                                  BlockDirtyBitmapList *external_bitmaps,
+                                  Error **errp)
 {
-    do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
+    do_block_dirty_bitmap_merge(node, target, bitmaps, external_bitmaps, NULL,
+                                errp);
 }
 
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
-- 
2.18.0


