Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30667C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CE22082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CE22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRek5-0005hJ-8D
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRefg-0001i5-B8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hReff-0003eX-0H
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:21:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefe-0003PU-Ou; Fri, 17 May 2019 11:21:18 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hRefZ-0005qt-Qj; Fri, 17 May 2019 18:21:13 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 17 May 2019 18:21:10 +0300
Message-Id: <20190517152111.206494-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190517152111.206494-1-vsementsov@virtuozzo.com>
References: <20190517152111.206494-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: support external bitmaps in
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
 qapi/block-core.json | 22 ++++++++++++++++---
 block/dirty-bitmap.c |  9 +++++---
 blockdev.c           | 50 +++++++++++++++++++++++++++++---------------
 3 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..dcc935d655 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2003,19 +2003,35 @@
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
             '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bool' } }
 
+##
+# @BlockDirtyBitmapMergeSource:
+#
+# @local: name of the bitmap, attached to the same node as target bitmap.
+#
+# @external: bitmap with specified node
+#
+# Since: 4.1
+##
+{ 'alternate': 'BlockDirtyBitmapMergeSource',
+  'data': { 'local': 'str',
+            'external': 'BlockDirtyBitmap' } }
+
 ##
 # @BlockDirtyBitmapMerge:
 #
-# @node: name of device/node which the bitmap is tracking
+# @node: name of device/node which the @target bitmap is tracking
 #
 # @target: name of the destination dirty bitmap
 #
-# @bitmaps: name(s) of the source dirty bitmap(s)
+# @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
+#           specifed BlockDirtyBitmap elements. The latter are supported
+#           since 4.1.
 #
 # Since: 4.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
-  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
+  'data': { 'node': 'str', 'target': 'str',
+            'bitmaps': ['BlockDirtyBitmapMergeSource'] } }
 
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
index 79fbac8450..64ccef735b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2112,11 +2112,10 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }
 
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp);
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target,
+        BlockDirtyBitmapMergeSourceList *bitmaps,
+        HBitmap **backup, Error **errp);
 
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
@@ -2965,15 +2964,14 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp)
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target,
+        BlockDirtyBitmapMergeSourceList *bitmaps,
+        HBitmap **backup, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *dst, *src, *anon;
-    strList *lst;
+    BlockDirtyBitmapMergeSourceList *lst;
     Error *local_err = NULL;
 
     dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
@@ -2988,11 +2986,28 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
     }
 
     for (lst = bitmaps; lst; lst = lst->next) {
-        src = bdrv_find_dirty_bitmap(bs, lst->value);
-        if (!src) {
-            error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
-            dst = NULL;
-            goto out;
+        switch (lst->value->type) {
+            const char *name, *node;
+        case QTYPE_QSTRING:
+            name = lst->value->u.local;
+            src = bdrv_find_dirty_bitmap(bs, name);
+            if (!src) {
+                error_setg(errp, "Dirty bitmap '%s' not found", name);
+                dst = NULL;
+                goto out;
+            }
+            break;
+        case QTYPE_QDICT:
+            node = lst->value->u.external.node;
+            name = lst->value->u.external.name;
+            src = block_dirty_bitmap_lookup(node, name, NULL, errp);
+            if (!src) {
+                dst = NULL;
+                goto out;
+            }
+            break;
+        default:
+            abort();
         }
 
         bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
@@ -3012,7 +3027,8 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
 }
 
 void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
-                                  strList *bitmaps, Error **errp)
+                                  BlockDirtyBitmapMergeSourceList *bitmaps,
+                                  Error **errp)
 {
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
-- 
2.18.0


