Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C8C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDFC24927
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDFC24927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYo5f-0003Vb-Ns
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 05:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2j-000627-L4; Wed, 13 May 2020 05:51:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:53972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2f-0003Z3-72; Wed, 13 May 2020 05:51:13 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jYo2V-0001e4-By; Wed, 13 May 2020 12:50:59 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 05/15] block: Include filters when freezing backing chain
Date: Wed, 13 May 2020 12:50:46 +0300
Message-Id: <1589363456-1035571-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 05:51:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

In order to make filters work in backing chains, the associated
functions must be able to deal with them and freeze all filter links, be
they COW or R/W filter links.

In the process, rename these functions to reflect that they now act on
generalized chains of filter nodes instead of backing chains alone.

While at it, add some comments that note which functions require their
caller to ensure that a given child link is not frozen, and how the
callers do so.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block.c               | 81 ++++++++++++++++++++++++++++++---------------------
 block/commit.c        |  8 ++---
 block/mirror.c        |  4 +--
 block/stream.c        |  8 ++---
 include/block/block.h |  6 ++--
 5 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/block.c b/block.c
index 5b4ebfe..459412e 100644
--- a/block.c
+++ b/block.c
@@ -2513,12 +2513,15 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
  * If @new_bs is not NULL, bdrv_check_perm() must be called beforehand, as this
  * function uses bdrv_set_perm() to update the permissions according to the new
  * reference that @new_bs gets.
+ *
+ * Callers must ensure that child->frozen is false.
  */
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
     uint64_t perm, shared_perm;
 
+    /* Asserts that child->frozen == false */
     bdrv_replace_child_noperm(child, new_bs);
 
     /*
@@ -2676,6 +2679,7 @@ static void bdrv_detach_child(BdrvChild *child)
     g_free(child);
 }
 
+/* Callers must ensure that child->frozen is false. */
 void bdrv_root_unref_child(BdrvChild *child)
 {
     BlockDriverState *child_bs;
@@ -2685,10 +2689,6 @@ void bdrv_root_unref_child(BdrvChild *child)
     bdrv_unref(child_bs);
 }
 
-/**
- * Clear all inherits_from pointers from children and grandchildren of
- * @root that point to @root, where necessary.
- */
 static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *child)
 {
     BdrvChild *c;
@@ -2713,6 +2713,7 @@ static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *child)
     }
 }
 
+/* Callers must ensure that child->frozen is false. */
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 {
     if (child == NULL) {
@@ -2756,7 +2757,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
 
-    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
+    if (bdrv_is_chain_frozen(bs, child_bs(bs->backing), errp)) {
         return;
     }
 
@@ -2765,6 +2766,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     }
 
     if (bs->backing) {
+        /* Cannot be frozen, we checked that above */
         bdrv_unref_child(bs, bs->backing);
         bs->backing = NULL;
     }
@@ -3912,8 +3914,7 @@ static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
             return -EPERM;
         }
         /* Check if the backing link that we want to replace is frozen */
-        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
-                                         errp)) {
+        if (bdrv_is_chain_frozen(overlay_bs, backing_bs(overlay_bs), errp)) {
             return -EPERM;
         }
         reopen_state->replace_backing_bs = true;
@@ -4248,6 +4249,7 @@ static void bdrv_close(BlockDriverState *bs)
 
     if (bs->drv) {
         if (bs->drv->bdrv_close) {
+            /* Must unfreeze all children, so bdrv_unref_child() works */
             bs->drv->bdrv_close(bs);
         }
         bs->drv = NULL;
@@ -4617,20 +4619,22 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
 }
 
 /*
- * Return true if at least one of the backing links between @bs and
- * @base is frozen. @errp is set if that's the case.
+ * Return true if at least one of the (COW and R/W) filter links
+ * between @bs and @base is frozen. @errp is set if that's the case.
  * @base must be reachable from @bs, or NULL.
  */
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
-                                  Error **errp)
+bool bdrv_is_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                          Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
+
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filtered_child(i);
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing && i->backing->frozen) {
+        if (child && child->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'",
-                       i->backing->name, i->node_name,
-                       backing_bs(i)->node_name);
+                       child->name, i->node_name, child->bs->node_name);
             return true;
         }
     }
@@ -4639,32 +4643,35 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 }
 
 /*
- * Freeze all backing links between @bs and @base.
+ * Freeze all (COW and R/W) filter links between @bs and @base.
  * If any of the links is already frozen the operation is aborted and
  * none of the links are modified.
  * @base must be reachable from @bs, or NULL.
  * Returns 0 on success. On failure returns < 0 and sets @errp.
  */
-int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
-                              Error **errp)
+int bdrv_freeze_chain(BlockDriverState *bs, BlockDriverState *base,
+                      Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
 
-    if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
+    if (bdrv_is_chain_frozen(bs, base, errp)) {
         return -EPERM;
     }
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing && backing_bs(i)->never_freeze) {
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filtered_child(i);
+        if (child && child->bs->never_freeze) {
             error_setg(errp, "Cannot freeze '%s' link to '%s'",
-                       i->backing->name, backing_bs(i)->node_name);
+                       child->name, child->bs->node_name);
             return -EPERM;
         }
     }
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing) {
-            i->backing->frozen = true;
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filtered_child(i);
+        if (child) {
+            child->frozen = true;
         }
     }
 
@@ -4672,18 +4679,21 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
 }
 
 /*
- * Unfreeze all backing links between @bs and @base. The caller must
- * ensure that all links are frozen before using this function.
+ * Unfreeze all (COW and R/W) filter links between @bs and @base. The
+ * caller must ensure that all links are frozen before using this
+ * function.
  * @base must be reachable from @bs, or NULL.
  */
-void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base)
+void bdrv_unfreeze_chain(BlockDriverState *bs, BlockDriverState *base)
 {
     BlockDriverState *i;
+    BdrvChild *child;
 
-    for (i = bs; i != base; i = backing_bs(i)) {
-        if (i->backing) {
-            assert(i->backing->frozen);
-            i->backing->frozen = false;
+    for (i = bs; i != base; i = child_bs(child)) {
+        child = bdrv_filtered_child(i);
+        if (child) {
+            assert(child->frozen);
+            child->frozen = false;
         }
     }
 }
@@ -4786,8 +4796,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
             }
         }
 
-        /* Do the actual switch in the in-memory graph.
-         * Completes bdrv_check_update_perm() transaction internally. */
+        /*
+         * Do the actual switch in the in-memory graph.
+         * Completes bdrv_check_update_perm() transaction internally.
+         * c->frozen is false, we have checked that above.
+         */
         bdrv_ref(base);
         bdrv_replace_child(c, base);
         bdrv_unref(top);
diff --git a/block/commit.c b/block/commit.c
index 445a280..e1f45a4 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -47,7 +47,7 @@ static int commit_prepare(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
-    bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+    bdrv_unfreeze_chain(s->commit_top_bs, s->base_bs);
     s->chain_frozen = false;
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
@@ -67,7 +67,7 @@ static void commit_abort(Job *job)
     BlockDriverState *top_bs = blk_bs(s->top);
 
     if (s->chain_frozen) {
-        bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+        bdrv_unfreeze_chain(s->commit_top_bs, s->base_bs);
     }
 
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
@@ -317,7 +317,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
-    if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
+    if (bdrv_freeze_chain(commit_top_bs, base, errp) < 0) {
         goto fail;
     }
     s->chain_frozen = true;
@@ -358,7 +358,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
 fail:
     if (s->chain_frozen) {
-        bdrv_unfreeze_backing_chain(commit_top_bs, base);
+        bdrv_unfreeze_chain(commit_top_bs, base);
     }
     if (s->base) {
         blk_unref(s->base);
diff --git a/block/mirror.c b/block/mirror.c
index b6de24b..4b187e6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -648,7 +648,7 @@ static int mirror_exit_common(Job *job)
     target_bs = blk_bs(s->target);
 
     if (bdrv_chain_contains(src, target_bs)) {
-        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
+        bdrv_unfreeze_chain(mirror_top_bs, target_bs);
     }
 
     bdrv_release_dirty_bitmap(s->dirty_bitmap);
@@ -1713,7 +1713,7 @@ static BlockJob *mirror_start_job(
             }
         }
 
-        if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
+        if (bdrv_freeze_chain(mirror_top_bs, target, errp) < 0) {
             goto fail;
         }
     }
diff --git a/block/stream.c b/block/stream.c
index aa2e7af..3cca1f9 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -53,7 +53,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
+        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
 
@@ -66,7 +66,7 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, s->bottom);
+    bdrv_unfreeze_chain(bs, s->bottom);
     s->chain_frozen = false;
 
     if (bs->backing) {
@@ -225,7 +225,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
     BlockDriverState *bottom = bdrv_find_overlay(bs, base);
 
-    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
+    if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
         return;
     }
 
@@ -276,5 +276,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, bottom);
+    bdrv_unfreeze_chain(bs, bottom);
 }
diff --git a/include/block/block.h b/include/block/block.h
index 4de8d8f..e55143d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -360,11 +360,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs);
 BlockDriverState *bdrv_find_base(BlockDriverState *bs);
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+bool bdrv_is_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
                                   Error **errp);
-int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
+int bdrv_freeze_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
-void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+void bdrv_unfreeze_chain(BlockDriverState *bs, BlockDriverState *base);
 int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
 
 
-- 
1.8.3.1


