Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A45C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D095620C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7e5-0008MC-4t
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XK-0000yF-Pr
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XI-00042w-Qx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XD-00040A-77; Fri, 09 Aug 2019 12:14:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FB9A20ABB;
 Fri,  9 Aug 2019 16:14:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E9045D9C3;
 Fri,  9 Aug 2019 16:14:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:34 +0200
Message-Id: <20190809161407.11920-10-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 09 Aug 2019 16:14:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 09/42] block: Include filters when freezing
 backing chain
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to make filters work in backing chains, the associated
functions must be able to deal with them and freeze all filter links, be
they COW or R/W filter links.

In the process, rename these functions to reflect that they now act on
generalized chains of filter nodes instead of backing chains alone.

While at it, add some comments that note which functions require their
caller to ensure that a given child link is not frozen, and how the
callers do so.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 10 +++---
 block.c               | 81 +++++++++++++++++++++++++------------------
 block/commit.c        |  8 ++---
 block/mirror.c        |  4 +--
 block/stream.c        |  8 ++---
 5 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..f6f09b95cd 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -364,11 +364,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs);
 BlockDriverState *bdrv_find_base(BlockDriverState *bs);
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState=
 *base,
-                                  Error **errp);
-int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *ba=
se,
-                              Error **errp);
-void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState =
*base);
+bool bdrv_is_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                          Error **errp);
+int bdrv_freeze_chain(BlockDriverState *bs, BlockDriverState *base,
+                      Error **errp);
+void bdrv_unfreeze_chain(BlockDriverState *bs, BlockDriverState *base);
=20
=20
 typedef struct BdrvCheckResult {
diff --git a/block.c b/block.c
index adf82efb0e..650c00d182 100644
--- a/block.c
+++ b/block.c
@@ -2303,12 +2303,15 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
  * If @new_bs is not NULL, bdrv_check_perm() must be called beforehand, =
as this
  * function uses bdrv_set_perm() to update the permissions according to =
the new
  * reference that @new_bs gets.
+ *
+ * Callers must ensure that child->frozen is false.
  */
 static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new_b=
s)
 {
     BlockDriverState *old_bs =3D child->bs;
     uint64_t perm, shared_perm;
=20
+    /* Asserts that child->frozen =3D=3D false */
     bdrv_replace_child_noperm(child, new_bs);
=20
     /*
@@ -2468,6 +2471,7 @@ static void bdrv_detach_child(BdrvChild *child)
     g_free(child);
 }
=20
+/* Callers must ensure that child->frozen is false. */
 void bdrv_root_unref_child(BdrvChild *child)
 {
     BlockDriverState *child_bs;
@@ -2477,10 +2481,6 @@ void bdrv_root_unref_child(BdrvChild *child)
     bdrv_unref(child_bs);
 }
=20
-/**
- * Clear all inherits_from pointers from children and grandchildren of
- * @root that point to @root, where necessary.
- */
 static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *=
child)
 {
     BdrvChild *c;
@@ -2505,6 +2505,7 @@ static void bdrv_unset_inherits_from(BlockDriverSta=
te *root, BdrvChild *child)
     }
 }
=20
+/* Callers must ensure that child->frozen is false. */
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 {
     if (child =3D=3D NULL) {
@@ -2548,7 +2549,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
     bool update_inherits_from =3D bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
=20
-    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
+    if (bdrv_is_chain_frozen(bs, child_bs(bs->backing), errp)) {
         return;
     }
=20
@@ -2557,6 +2558,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
     }
=20
     if (bs->backing) {
+        /* Cannot be frozen, we checked that above */
         bdrv_unref_child(bs, bs->backing);
     }
=20
@@ -3674,8 +3676,7 @@ static int bdrv_reopen_parse_backing(BDRVReopenStat=
e *reopen_state,
             return -EPERM;
         }
         /* Check if the backing link that we want to replace is frozen *=
/
-        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_=
bs),
-                                         errp)) {
+        if (bdrv_is_chain_frozen(overlay_bs, backing_bs(overlay_bs), err=
p)) {
             return -EPERM;
         }
         reopen_state->replace_backing_bs =3D true;
@@ -4029,6 +4030,7 @@ static void bdrv_close(BlockDriverState *bs)
=20
     if (bs->drv) {
         if (bs->drv->bdrv_close) {
+            /* Must unfreeze all children, so bdrv_unref_child() works *=
/
             bs->drv->bdrv_close(bs);
         }
         bs->drv =3D NULL;
@@ -4398,20 +4400,22 @@ BlockDriverState *bdrv_find_base(BlockDriverState=
 *bs)
 }
=20
 /*
- * Return true if at least one of the backing links between @bs and
- * @base is frozen. @errp is set if that's the case.
+ * Return true if at least one of the (COW and R/W) filter links
+ * between @bs and @base is frozen. @errp is set if that's the case.
  * @base must be reachable from @bs, or NULL.
  */
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState=
 *base,
-                                  Error **errp)
+bool bdrv_is_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                          Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
+
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing && i->backing->frozen) {
+        if (child && child->frozen) {
             error_setg(errp, "Cannot change '%s' link from '%s' to '%s'"=
,
-                       i->backing->name, i->node_name,
-                       backing_bs(i)->node_name);
+                       child->name, i->node_name, child->bs->node_name);
             return true;
         }
     }
@@ -4420,32 +4424,35 @@ bool bdrv_is_backing_chain_frozen(BlockDriverStat=
e *bs, BlockDriverState *base,
 }
=20
 /*
- * Freeze all backing links between @bs and @base.
+ * Freeze all (COW and R/W) filter links between @bs and @base.
  * If any of the links is already frozen the operation is aborted and
  * none of the links are modified.
  * @base must be reachable from @bs, or NULL.
  * Returns 0 on success. On failure returns < 0 and sets @errp.
  */
-int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *ba=
se,
-                              Error **errp)
+int bdrv_freeze_chain(BlockDriverState *bs, BlockDriverState *base,
+                      Error **errp)
 {
     BlockDriverState *i;
+    BdrvChild *child;
=20
-    if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
+    if (bdrv_is_chain_frozen(bs, base, errp)) {
         return -EPERM;
     }
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing && backing_bs(i)->never_freeze) {
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+        if (child && child->bs->never_freeze) {
             error_setg(errp, "Cannot freeze '%s' link to '%s'",
-                       i->backing->name, backing_bs(i)->node_name);
+                       child->name, child->bs->node_name);
             return -EPERM;
         }
     }
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing) {
-            i->backing->frozen =3D true;
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+        if (child) {
+            child->frozen =3D true;
         }
     }
=20
@@ -4453,18 +4460,21 @@ int bdrv_freeze_backing_chain(BlockDriverState *b=
s, BlockDriverState *base,
 }
=20
 /*
- * Unfreeze all backing links between @bs and @base. The caller must
- * ensure that all links are frozen before using this function.
+ * Unfreeze all (COW and R/W) filter links between @bs and @base. The
+ * caller must ensure that all links are frozen before using this
+ * function.
  * @base must be reachable from @bs, or NULL.
  */
-void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState =
*base)
+void bdrv_unfreeze_chain(BlockDriverState *bs, BlockDriverState *base)
 {
     BlockDriverState *i;
+    BdrvChild *child;
=20
-    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
-        if (i->backing) {
-            assert(i->backing->frozen);
-            i->backing->frozen =3D false;
+    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
+        child =3D bdrv_filtered_child(i);
+        if (child) {
+            assert(child->frozen);
+            child->frozen =3D false;
         }
     }
 }
@@ -4567,8 +4577,11 @@ int bdrv_drop_intermediate(BlockDriverState *top, =
BlockDriverState *base,
             }
         }
=20
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
index 19915603ae..5a7672c7c7 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -68,7 +68,7 @@ static int commit_prepare(Job *job)
 {
     CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job);
=20
-    bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+    bdrv_unfreeze_chain(s->commit_top_bs, s->base_bs);
     s->chain_frozen =3D false;
=20
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE bef=
ore
@@ -88,7 +88,7 @@ static void commit_abort(Job *job)
     BlockDriverState *top_bs =3D blk_bs(s->top);
=20
     if (s->chain_frozen) {
-        bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+        bdrv_unfreeze_chain(s->commit_top_bs, s->base_bs);
     }
=20
     /* Make sure commit_top_bs and top stay around until bdrv_replace_no=
de() */
@@ -331,7 +331,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
         }
     }
=20
-    if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
+    if (bdrv_freeze_chain(commit_top_bs, base, errp) < 0) {
         goto fail;
     }
     s->chain_frozen =3D true;
@@ -372,7 +372,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
=20
 fail:
     if (s->chain_frozen) {
-        bdrv_unfreeze_backing_chain(commit_top_bs, base);
+        bdrv_unfreeze_chain(commit_top_bs, base);
     }
     if (s->base) {
         blk_unref(s->base);
diff --git a/block/mirror.c b/block/mirror.c
index a8f2d7a305..54bafdf176 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -633,7 +633,7 @@ static int mirror_exit_common(Job *job)
     s->prepared =3D true;
=20
     if (bdrv_chain_contains(src, target_bs)) {
-        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
+        bdrv_unfreeze_chain(mirror_top_bs, target_bs);
     }
=20
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
@@ -1707,7 +1707,7 @@ static BlockJob *mirror_start_job(
             }
         }
=20
-        if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) =
{
+        if (bdrv_freeze_chain(mirror_top_bs, target, errp) < 0) {
             goto fail;
         }
     }
diff --git a/block/stream.c b/block/stream.c
index 6ac1e7bec4..4c8b89884a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,7 +54,7 @@ static void stream_abort(Job *job)
=20
     if (s->chain_frozen) {
         BlockJob *bjob =3D &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
+        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
=20
@@ -67,7 +67,7 @@ static int stream_prepare(Job *job)
     Error *local_err =3D NULL;
     int ret =3D 0;
=20
-    bdrv_unfreeze_backing_chain(bs, s->bottom);
+    bdrv_unfreeze_chain(bs, s->bottom);
     s->chain_frozen =3D false;
=20
     if (bs->backing) {
@@ -233,7 +233,7 @@ void stream_start(const char *job_id, BlockDriverStat=
e *bs,
     int basic_flags =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHAN=
GED;
     BlockDriverState *bottom =3D bdrv_find_overlay(bs, base);
=20
-    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
+    if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
         return;
     }
=20
@@ -284,5 +284,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, bottom);
+    bdrv_unfreeze_chain(bs, bottom);
 }
--=20
2.21.0


