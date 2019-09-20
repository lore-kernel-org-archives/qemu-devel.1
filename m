Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6ED2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6ED2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLCz-0003dO-8B
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpy-00011E-3Y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpu-0004aE-91
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpo-0004WZ-40; Fri, 20 Sep 2019 11:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA21218C4277;
 Fri, 20 Sep 2019 15:28:34 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F47C60C57;
 Fri, 20 Sep 2019 15:28:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 12/22] block: Remove bdrv_recurse_is_first_non_filter()
Date: Fri, 20 Sep 2019 17:27:54 +0200
Message-Id: <20190920152804.12875-13-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 15:28:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It no longer has any users.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     |  4 ----
 include/block/block_int.h |  8 --------
 block.c                   | 33 ---------------------------------
 block/blkverify.c         | 15 ---------------
 block/copy-on-read.c      |  9 ---------
 block/quorum.c            | 18 ------------------
 block/replication.c       |  7 -------
 block/throttle.c          |  8 --------
 8 files changed, 102 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index d3ccab4722..2944980c03 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -400,10 +400,6 @@ int bdrv_amend_options(BlockDriverState *bs_new, Qem=
uOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opa=
que,
                        Error **errp);
=20
-/* external snapshots */
-bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
-                                      BlockDriverState *candidate);
-
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **e=
rrp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0be7d12f04..70f26530c9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -95,14 +95,6 @@ struct BlockDriver {
      * must implement them and return -ENOTSUP.
      */
     bool is_filter;
-    /* for snapshots block filter like Quorum can implement the
-     * following recursive callback.
-     * It's purpose is to recurse on the filter children while calling
-     * bdrv_recurse_is_first_non_filter on them.
-     * For a sample implementation look in the future Quorum block filte=
r.
-     */
-    bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
-                                             BlockDriverState *candidate=
);
     /*
      * Return true if @to_replace can be replaced by a BDS with the
      * same data as @bs without it affecting @bs's behavior (that is,
diff --git a/block.c b/block.c
index 02177bde9a..0d9b3de98f 100644
--- a/block.c
+++ b/block.c
@@ -6173,39 +6173,6 @@ int bdrv_amend_options(BlockDriverState *bs, QemuO=
pts *opts,
     return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, e=
rrp);
 }
=20
-/* This function will be called by the bdrv_recurse_is_first_non_filter =
method
- * of block filter and by bdrv_is_first_non_filter.
- * It is used to test if the given bs is the candidate or recurse more i=
n the
- * node graph.
- */
-bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
-                                      BlockDriverState *candidate)
-{
-    /* return false if basic checks fails */
-    if (!bs || !bs->drv) {
-        return false;
-    }
-
-    /* the code reached a non block filter driver -> check if the bs is
-     * the same as the candidate. It's the recursion termination conditi=
on.
-     */
-    if (!bs->drv->is_filter) {
-        return bs =3D=3D candidate;
-    }
-    /* Down this path the driver is a block filter driver */
-
-    /* If the block filter recursion method is defined use it to recurse=
 down
-     * the node graph.
-     */
-    if (bs->drv->bdrv_recurse_is_first_non_filter) {
-        return bs->drv->bdrv_recurse_is_first_non_filter(bs, candidate);
-    }
-
-    /* the driver is a block filter but don't allow to recurse -> return=
 false
-     */
-    return false;
-}
-
 /*
  * This function checks whether the given @to_replace is allowed to be
  * replaced by a node that always shows the same data as @bs.  This is
diff --git a/block/blkverify.c b/block/blkverify.c
index 0add3ab483..ba6b1853ae 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -268,20 +268,6 @@ static int blkverify_co_flush(BlockDriverState *bs)
     return bdrv_co_flush(s->test_file->bs);
 }
=20
-static bool blkverify_recurse_is_first_non_filter(BlockDriverState *bs,
-                                                  BlockDriverState *cand=
idate)
-{
-    BDRVBlkverifyState *s =3D bs->opaque;
-
-    bool perm =3D bdrv_recurse_is_first_non_filter(bs->file->bs, candida=
te);
-
-    if (perm) {
-        return true;
-    }
-
-    return bdrv_recurse_is_first_non_filter(s->test_file->bs, candidate)=
;
-}
-
 static bool blkverify_recurse_can_replace(BlockDriverState *bs,
                                           BlockDriverState *to_replace)
 {
@@ -341,7 +327,6 @@ static BlockDriver bdrv_blkverify =3D {
     .bdrv_co_flush                    =3D blkverify_co_flush,
=20
     .is_filter                        =3D true,
-    .bdrv_recurse_is_first_non_filter =3D blkverify_recurse_is_first_non=
_filter,
     .bdrv_recurse_can_replace         =3D blkverify_recurse_can_replace,
 };
=20
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 6631f30205..3204259513 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -125,13 +125,6 @@ static void cor_lock_medium(BlockDriverState *bs, bo=
ol locked)
 }
=20
=20
-static bool cor_recurse_is_first_non_filter(BlockDriverState *bs,
-                                            BlockDriverState *candidate)
-{
-    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
-}
-
-
 static BlockDriver bdrv_copy_on_read =3D {
     .format_name                        =3D "copy-on-read",
=20
@@ -151,8 +144,6 @@ static BlockDriver bdrv_copy_on_read =3D {
=20
     .bdrv_co_block_status               =3D bdrv_co_block_status_from_fi=
le,
=20
-    .bdrv_recurse_is_first_non_filter   =3D cor_recurse_is_first_non_fil=
ter,
-
     .has_variable_length                =3D true,
     .is_filter                          =3D true,
 };
diff --git a/block/quorum.c b/block/quorum.c
index 81b57dbae2..7a8f8b5475 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -808,23 +808,6 @@ static coroutine_fn int quorum_co_flush(BlockDriverS=
tate *bs)
     return result;
 }
=20
-static bool quorum_recurse_is_first_non_filter(BlockDriverState *bs,
-                                               BlockDriverState *candida=
te)
-{
-    BDRVQuorumState *s =3D bs->opaque;
-    int i;
-
-    for (i =3D 0; i < s->num_children; i++) {
-        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i].ch=
ild->bs,
-                                                     candidate);
-        if (perm) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
 static bool quorum_recurse_can_replace(BlockDriverState *bs,
                                        BlockDriverState *to_replace)
 {
@@ -1255,7 +1238,6 @@ static BlockDriver bdrv_quorum =3D {
     .bdrv_child_perm                    =3D quorum_child_perm,
=20
     .is_filter                          =3D true,
-    .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_=
filter,
     .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
=20
     .strong_runtime_opts                =3D quorum_strong_runtime_opts,
diff --git a/block/replication.c b/block/replication.c
index 99532ce521..d6681b6c84 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -306,12 +306,6 @@ out:
     return ret;
 }
=20
-static bool replication_recurse_is_first_non_filter(BlockDriverState *bs=
,
-                                                    BlockDriverState *ca=
ndidate)
-{
-    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
-}
-
 static void secondary_do_checkpoint(BDRVReplicationState *s, Error **err=
p)
 {
     Error *local_err =3D NULL;
@@ -699,7 +693,6 @@ static BlockDriver bdrv_replication =3D {
     .bdrv_co_writev             =3D replication_co_writev,
=20
     .is_filter                  =3D true,
-    .bdrv_recurse_is_first_non_filter =3D replication_recurse_is_first_n=
on_filter,
=20
     .has_variable_length        =3D true,
     .strong_runtime_opts        =3D replication_strong_runtime_opts,
diff --git a/block/throttle.c b/block/throttle.c
index 0349f42257..71f4bb0ad1 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -207,12 +207,6 @@ static void throttle_reopen_abort(BDRVReopenState *r=
eopen_state)
     reopen_state->opaque =3D NULL;
 }
=20
-static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
-                                                 BlockDriverState *candi=
date)
-{
-    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
-}
-
 static void coroutine_fn throttle_co_drain_begin(BlockDriverState *bs)
 {
     ThrottleGroupMember *tgm =3D bs->opaque;
@@ -252,8 +246,6 @@ static BlockDriver bdrv_throttle =3D {
     .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zeroes,
     .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
=20
-    .bdrv_recurse_is_first_non_filter   =3D   throttle_recurse_is_first_=
non_filter,
-
     .bdrv_attach_aio_context            =3D   throttle_attach_aio_contex=
t,
     .bdrv_detach_aio_context            =3D   throttle_detach_aio_contex=
t,
=20
--=20
2.21.0


