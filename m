Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D769C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E211525123
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211525123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXlv6-0001Rs-30
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXlqU-0006DT-Si
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXldZ-0001qF-OX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:00:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:39524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldU-00012C-Im; Mon, 03 Jun 2019 08:00:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldG-0002hc-Pt; Mon, 03 Jun 2019 15:00:07 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 15:00:04 +0300
Message-Id: <20190603120005.37394-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190603120005.37394-1-vsementsov@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/4] qapi: implement block-dirty-bitmap-remove
 transaction action
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
	armbru@redhat.com, mreitz@redhat.com,
	nshirokovskiy@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is used to do transactional movement of the bitmap (which is
possible in conjunction with merge command). Transactional bitmap
movement is needed in scenarios with external snapshot, when we don't
want to leave copy of the bitmap in the base image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/transaction.json |  2 ++
 blockdev.c            | 74 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 95edb78227..da95b804aa 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -45,6 +45,7 @@
 #
 # - @abort: since 1.6
 # - @block-dirty-bitmap-add: since 2.5
+# - @block-dirty-bitmap-remove: since 4.1
 # - @block-dirty-bitmap-clear: since 2.5
 # - @block-dirty-bitmap-enable: since 4.0
 # - @block-dirty-bitmap-disable: since 4.0
@@ -61,6 +62,7 @@
   'data': {
        'abort': 'Abort',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
+       'block-dirty-bitmap-remove': 'BlockDirtyBitmap',
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
        'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
diff --git a/blockdev.c b/blockdev.c
index 5b3eef0d3e..0d9aa7f0a1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2135,6 +2135,46 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                                 errp);
 }
 
+static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
+        const char *node, const char *name, bool release,
+        BlockDriverState **bitmap_bs, Error **errp);
+
+static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
+                                              Error **errp)
+{
+    BlockDirtyBitmap *action;
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    if (action_check_completion_mode(common, errp) < 0) {
+        return;
+    }
+
+    action = common->action->u.block_dirty_bitmap_remove.data;
+
+    state->bitmap = do_block_dirty_bitmap_remove(action->node, action->name,
+                                                 false, &state->bs, errp);
+    if (state->bitmap) {
+        bdrv_dirty_bitmap_hide(state->bitmap);
+    }
+}
+
+static void block_dirty_bitmap_remove_abort(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    bdrv_dirty_bitmap_unhide(state->bitmap);
+}
+
+static void block_dirty_bitmap_remove_commit(BlkActionState *common)
+{
+    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
+                                             common, common);
+
+    bdrv_release_dirty_bitmap(state->bs, state->bitmap);
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2212,6 +2252,12 @@ static const BlkActionOps actions[] = {
         .commit = block_dirty_bitmap_free_backup,
         .abort = block_dirty_bitmap_restore,
     },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_REMOVE] = {
+        .instance_size = sizeof(BlockDirtyBitmapState),
+        .prepare = block_dirty_bitmap_remove_prepare,
+        .commit = block_dirty_bitmap_remove_commit,
+        .abort = block_dirty_bitmap_remove_abort,
+    },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup job,
      * these jobs do not necessarily adhere to transaction semantics.
@@ -2870,20 +2916,21 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
 }
 
-void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
-                                   Error **errp)
+static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
+        const char *node, const char *name, bool release,
+        BlockDriverState **bitmap_bs, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
-        return;
+        return NULL;
     }
 
     if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
                                 errp)) {
-        return;
+        return NULL;
     }
 
     if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
@@ -2893,13 +2940,28 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         aio_context_acquire(aio_context);
         bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
         aio_context_release(aio_context);
+
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-            return;
+            return NULL;
         }
     }
 
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    if (release) {
+        bdrv_release_dirty_bitmap(bs, bitmap);
+    }
+
+    if (bitmap_bs) {
+        *bitmap_bs = bs;
+    }
+
+    return bitmap;
+}
+
+void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
+                                   Error **errp)
+{
+    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
 }
 
 /**
-- 
2.18.0


