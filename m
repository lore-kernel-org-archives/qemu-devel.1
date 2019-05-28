Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88908C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539F9208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539F9208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVi1f-0004bo-GL
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:44:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhoB-0001dl-7D
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVho6-000244-E4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhns-0000vy-0z; Tue, 28 May 2019 15:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BC267E424;
	Tue, 28 May 2019 19:29:31 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1363D10027C2;
	Tue, 28 May 2019 19:29:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:41 +0200
Message-Id: <20190528192847.2730-16-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 28 May 2019 19:29:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/21] block: Make bdrv_root_attach_child()
 unref child_bs on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

A consequence of the previous patch is that bdrv_attach_child()
transfers the reference to child_bs from the caller to parent_bs,
which will drop it on bdrv_close() or when someone calls
bdrv_unref_child().

But this only happens when bdrv_attach_child() succeeds. If it fails
then the caller is responsible for dropping the reference to child_bs.

This patch makes bdrv_attach_child() take the reference also when
there is an error, freeing the caller for having to do it.

A similar situation happens with bdrv_root_attach_child(), so the
changes on this patch affect both functions.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20dfb3d9ccec559cdd1a9690146abad5d204a186.1557754872.git.berto=
@igalia.com
[mreitz: Removed now superfluous BdrvChild * variable in
         bdrv_open_child()]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c               | 30 ++++++++++++++++++------------
 block/block-backend.c |  3 +--
 block/quorum.c        |  1 -
 blockjob.c            |  2 +-
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index be37280dc7..1a73e310c1 100644
--- a/block.c
+++ b/block.c
@@ -2243,6 +2243,13 @@ static void bdrv_replace_child(BdrvChild *child, B=
lockDriverState *new_bs)
     }
 }
=20
+/*
+ * This function steals the reference to child_bs from the caller.
+ * That reference is later dropped by bdrv_root_unref_child().
+ *
+ * On failure NULL is returned, errp is set and the reference to
+ * child_bs is also dropped.
+ */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
                                   const BdrvChildRole *child_role,
@@ -2255,6 +2262,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
     ret =3D bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NU=
LL, errp);
     if (ret < 0) {
         bdrv_abort_perm_update(child_bs);
+        bdrv_unref(child_bs);
         return NULL;
     }
=20
@@ -2274,6 +2282,14 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState=
 *child_bs,
     return child;
 }
=20
+/*
+ * This function transfers the reference to child_bs from the caller
+ * to parent_bs. That reference is later dropped by parent_bs on
+ * bdrv_close() or if someone calls bdrv_unref_child().
+ *
+ * On failure NULL is returned, errp is set and the reference to
+ * child_bs is also dropped.
+ */
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
@@ -2401,12 +2417,9 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Blo=
ckDriverState *backing_hd,
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
-    if (update_inherits_from) {
+    if (bs->backing && update_inherits_from) {
         backing_hd->inherits_from =3D bs;
     }
-    if (!bs->backing) {
-        bdrv_unref(backing_hd);
-    }
=20
 out:
     bdrv_refresh_limits(bs, NULL);
@@ -2594,7 +2607,6 @@ BdrvChild *bdrv_open_child(const char *filename,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp)
 {
-    BdrvChild *c;
     BlockDriverState *bs;
=20
     bs =3D bdrv_open_child_bs(filename, options, bdref_key, parent, chil=
d_role,
@@ -2603,13 +2615,7 @@ BdrvChild *bdrv_open_child(const char *filename,
         return NULL;
     }
=20
-    c =3D bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
-    if (!c) {
-        bdrv_unref(bs);
-        return NULL;
-    }
-
-    return c;
+    return bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
 }
=20
 /* TODO Future callers may need to specify parent/child_role in order fo=
r
diff --git a/block/block-backend.c b/block/block-backend.c
index 4c0a8ef88d..ad3e1c882d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -392,7 +392,6 @@ BlockBackend *blk_new_open(const char *filename, cons=
t char *reference,
     blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
                                        perm, BLK_PERM_ALL, blk, errp);
     if (!blk->root) {
-        bdrv_unref(bs);
         blk_unref(blk);
         return NULL;
     }
@@ -800,12 +799,12 @@ void blk_remove_bs(BlockBackend *blk)
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
+    bdrv_ref(bs);
     blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
                                        blk->perm, blk->shared_perm, blk,=
 errp);
     if (blk->root =3D=3D NULL) {
         return -EPERM;
     }
-    bdrv_ref(bs);
=20
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (tgm->throttle_state) {
diff --git a/block/quorum.c b/block/quorum.c
index 352f729136..133ee18204 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1019,7 +1019,6 @@ static void quorum_add_child(BlockDriverState *bs, =
BlockDriverState *child_bs,
     child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format, e=
rrp);
     if (child =3D=3D NULL) {
         s->next_child_index--;
-        bdrv_unref(child_bs);
         goto out;
     }
     s->children =3D g_renew(BdrvChild *, s->children, s->num_children + =
1);
diff --git a/blockjob.c b/blockjob.c
index 9ca942ba01..cc5f18e7cd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -204,6 +204,7 @@ int block_job_add_bdrv(BlockJob *job, const char *nam=
e, BlockDriverState *bs,
 {
     BdrvChild *c;
=20
+    bdrv_ref(bs);
     c =3D bdrv_root_attach_child(bs, name, &child_job, perm, shared_perm=
,
                                job, errp);
     if (c =3D=3D NULL) {
@@ -211,7 +212,6 @@ int block_job_add_bdrv(BlockJob *job, const char *nam=
e, BlockDriverState *bs,
     }
=20
     job->nodes =3D g_slist_prepend(job->nodes, c);
-    bdrv_ref(bs);
     bdrv_op_block_all(bs, job->blocker);
=20
     return 0;
--=20
2.21.0


