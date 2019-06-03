Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980FC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9392B277F1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9392B277F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoi4-0003c4-IN
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVu-0001Qn-6r
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVs-000193-4U
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoVZ-000077-Hi; Mon, 03 Jun 2019 11:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F069A3107B2D;
	Mon,  3 Jun 2019 15:04:00 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05E4C68878;
	Mon,  3 Jun 2019 15:03:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:21 +0200
Message-Id: <20190603150233.6614-17-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 15:04:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/28] block: Adjust AioContexts when attaching
 nodes
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far, we only made sure that updating the AioContext of a node
affected the whole subtree. However, if a node is newly attached to a
new parent, we also need to make sure that both the subtree of the node
and the parent are in the same AioContext. This tries to move the new
child node to the parent AioContext and returns an error if this isn't
possible.

BlockBackends now actually apply their AioContext to their root node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  1 +
 block.c                   | 35 ++++++++++++++++++++++++++++++++++-
 block/block-backend.c     |  9 ++++-----
 blockjob.c                | 10 ++++++++--
 tests/test-bdrv-drain.c   |  6 ++++--
 5 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..06df2bda1b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1163,6 +1163,7 @@ void hmp_drive_add_node(Monitor *mon, const char *o=
ptstr);
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
+                                  AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
diff --git a/block.c b/block.c
index 69ceac6377..7d9ed1a724 100644
--- a/block.c
+++ b/block.c
@@ -2249,14 +2249,19 @@ static void bdrv_replace_child(BdrvChild *child, =
BlockDriverState *new_bs)
  *
  * On failure NULL is returned, errp is set and the reference to
  * child_bs is also dropped.
+ *
+ * The caller must hold the AioContext lock @child_bs, but not that of @=
ctx
+ * (unless @child_bs is already in @ctx).
  */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
+                                  AioContext *ctx,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp)
 {
     BdrvChild *child;
+    Error *local_err =3D NULL;
     int ret;
=20
     ret =3D bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NU=
LL, errp);
@@ -2276,6 +2281,31 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState=
 *child_bs,
         .opaque         =3D opaque,
     };
=20
+    /* If the AioContexts don't match, first try to move the subtree of
+     * child_bs into the AioContext of the new parent. If this doesn't w=
ork,
+     * try moving the parent into the AioContext of child_bs instead. */
+    if (bdrv_get_aio_context(child_bs) !=3D ctx) {
+        ret =3D bdrv_try_set_aio_context(child_bs, ctx, &local_err);
+        if (ret < 0 && child_role->can_set_aio_ctx) {
+            GSList *ignore =3D g_slist_prepend(NULL, child);;
+            ctx =3D bdrv_get_aio_context(child_bs);
+            if (child_role->can_set_aio_ctx(child, ctx, &ignore, NULL)) =
{
+                error_free(local_err);
+                ret =3D 0;
+                g_slist_free(ignore);
+                ignore =3D g_slist_prepend(NULL, child);;
+                child_role->set_aio_ctx(child, ctx, &ignore);
+            }
+            g_slist_free(ignore);
+        }
+        if (ret < 0) {
+            error_propagate(errp, local_err);
+            g_free(child);
+            bdrv_abort_perm_update(child_bs);
+            return NULL;
+        }
+    }
+
     /* This performs the matching bdrv_set_perm() for the above check. *=
/
     bdrv_replace_child(child, child_bs);
=20
@@ -2289,6 +2319,9 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
  *
  * On failure NULL is returned, errp is set and the reference to
  * child_bs is also dropped.
+ *
+ * If @parent_bs and @child_bs are in different AioContexts, the caller =
must
+ * hold the AioContext lock for @child_bs, but not for @parent_bs.
  */
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
@@ -2302,11 +2335,11 @@ BdrvChild *bdrv_attach_child(BlockDriverState *pa=
rent_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
=20
     assert(parent_bs->drv);
-    assert(bdrv_get_aio_context(parent_bs) =3D=3D bdrv_get_aio_context(c=
hild_bs));
     bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
                     perm, shared_perm, &perm, &shared_perm);
=20
     child =3D bdrv_root_attach_child(child_bs, child_name, child_role,
+                                   bdrv_get_aio_context(parent_bs),
                                    perm, shared_perm, parent_bs, errp);
     if (child =3D=3D NULL) {
         return NULL;
diff --git a/block/block-backend.c b/block/block-backend.c
index f03f14acb0..f5d9407d20 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -392,7 +392,7 @@ BlockBackend *blk_new_open(const char *filename, cons=
t char *reference,
         return NULL;
     }
=20
-    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
+    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root, blk->c=
tx,
                                        perm, BLK_PERM_ALL, blk, errp);
     if (!blk->root) {
         blk_unref(blk);
@@ -803,7 +803,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState=
 *bs, Error **errp)
 {
     ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
     bdrv_ref(bs);
-    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
+    blk->root =3D bdrv_root_attach_child(bs, "root", &child_root, blk->c=
tx,
                                        blk->perm, blk->shared_perm, blk,=
 errp);
     if (blk->root =3D=3D NULL) {
         return -EPERM;
@@ -1861,10 +1861,9 @@ AioContext *blk_get_aio_context(BlockBackend *blk)
 {
     BlockDriverState *bs =3D blk_bs(blk);
=20
-    /* FIXME The AioContext of bs and blk can be inconsistent. For the m=
oment,
-     * we prefer the one of bs for compatibility. */
     if (bs) {
-        return bdrv_get_aio_context(blk_bs(blk));
+        AioContext *ctx =3D bdrv_get_aio_context(blk_bs(blk));
+        assert(ctx =3D=3D blk->ctx);
     }
=20
     return blk->ctx;
diff --git a/blockjob.c b/blockjob.c
index 29517ae162..931d675c0c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -205,8 +205,14 @@ int block_job_add_bdrv(BlockJob *job, const char *na=
me, BlockDriverState *bs,
     BdrvChild *c;
=20
     bdrv_ref(bs);
-    c =3D bdrv_root_attach_child(bs, name, &child_job, perm, shared_perm=
,
-                               job, errp);
+    if (job->job.aio_context !=3D qemu_get_aio_context()) {
+        aio_context_release(job->job.aio_context);
+    }
+    c =3D bdrv_root_attach_child(bs, name, &child_job, job->job.aio_cont=
ext,
+                               perm, shared_perm, job, errp);
+    if (job->job.aio_context !=3D qemu_get_aio_context()) {
+        aio_context_acquire(job->job.aio_context);
+    }
     if (c =3D=3D NULL) {
         return -EPERM;
     }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fabbd52d93..16ea2b813f 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -912,6 +912,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
                                   &error_abort);
     blk_target =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PER=
M_ALL);
     blk_insert_bs(blk_target, target, &error_abort);
+    blk_set_allow_aio_context_change(blk_target, true);
=20
     aio_context_acquire(ctx);
     tjob =3D block_job_create("job0", &test_job_driver, NULL, src,
@@ -972,7 +973,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
     g_assert_false(job->job.paused);
     g_assert_true(job->job.busy); /* We're in qemu_co_sleep_ns() */
=20
-    do_drain_begin(drain_type, target);
+    do_drain_begin_unlocked(drain_type, target);
=20
     if (drain_type =3D=3D BDRV_DRAIN_ALL) {
         /* bdrv_drain_all() drains both src and target */
@@ -983,7 +984,7 @@ static void test_blockjob_common_drain_node(enum drai=
n_type drain_type,
     g_assert_true(job->job.paused);
     g_assert_false(job->job.busy); /* The job is paused */
=20
-    do_drain_end(drain_type, target);
+    do_drain_end_unlocked(drain_type, target);
=20
     if (use_iothread) {
         /* paused is reset in the I/O thread, wait for it */
@@ -1002,6 +1003,7 @@ static void test_blockjob_common_drain_node(enum dr=
ain_type drain_type,
=20
     if (use_iothread) {
         blk_set_aio_context(blk_src, qemu_get_aio_context(), &error_abor=
t);
+        blk_set_aio_context(blk_target, qemu_get_aio_context(), &error_a=
bort);
     }
     aio_context_release(ctx);
=20
--=20
2.20.1


