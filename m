Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23612C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B72206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkItaxz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B72206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40KA-0006b5-3R
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40E0-0001pX-25
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Dy-0007Tw-AM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42106
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Dy-0007Th-5x
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tBUdMXFjuNS9B5/OxkBBXbM0EpKz4wBlh7jc2FjNIk=;
 b=MkItaxz5Idf9G0ClXof9AhjbkIEKlULbT0ca88JZFyMvdrTZ/eNd2mUVLOeB2LRt/jhQiu
 zVGsLW+Zsf164XWryN9hJeOV2YLm5AOG9477pptAFla3olIYsc2Mz1s/lptqi11/dAGbVB
 g1eGQ1sSZybrilVi5TqSoviyuOI6eQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-4GJE_XP0MDa9fBhNgtygAQ-1; Tue, 18 Feb 2020 05:35:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E0D18A6EC2;
 Tue, 18 Feb 2020 10:35:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C33290772;
 Tue, 18 Feb 2020 10:35:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 10/19] block: Remove bdrv_recurse_is_first_non_filter()
Date: Tue, 18 Feb 2020 11:34:45 +0100
Message-Id: <20200218103454.296704-11-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 4GJE_XP0MDa9fBhNgtygAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

It no longer has any users.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   | 33 ---------------------------------
 block/blkverify.c         | 15 ---------------
 block/copy-on-read.c      |  9 ---------
 block/filter-compress.c   |  9 ---------
 block/quorum.c            | 18 ------------------
 block/replication.c       |  7 -------
 block/throttle.c          |  8 --------
 include/block/block.h     |  4 ----
 include/block/block_int.h |  8 --------
 9 files changed, 111 deletions(-)

diff --git a/block.c b/block.c
index 7efe8f3b03..ca2cfbcb62 100644
--- a/block.c
+++ b/block.c
@@ -6202,39 +6202,6 @@ int bdrv_amend_options(BlockDriverState *bs, QemuOpt=
s *opts,
     return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, err=
p);
 }
=20
-/* This function will be called by the bdrv_recurse_is_first_non_filter me=
thod
- * of block filter and by bdrv_is_first_non_filter.
- * It is used to test if the given bs is the candidate or recurse more in =
the
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
-     * the same as the candidate. It's the recursion termination condition=
.
-     */
-    if (!bs->drv->is_filter) {
-        return bs =3D=3D candidate;
-    }
-    /* Down this path the driver is a block filter driver */
-
-    /* If the block filter recursion method is defined use it to recurse d=
own
-     * the node graph.
-     */
-    if (bs->drv->bdrv_recurse_is_first_non_filter) {
-        return bs->drv->bdrv_recurse_is_first_non_filter(bs, candidate);
-    }
-
-    /* the driver is a block filter but don't allow to recurse -> return f=
alse
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
-                                                  BlockDriverState *candid=
ate)
-{
-    BDRVBlkverifyState *s =3D bs->opaque;
-
-    bool perm =3D bdrv_recurse_is_first_non_filter(bs->file->bs, candidate=
);
-
-    if (perm) {
-        return true;
-    }
-
-    return bdrv_recurse_is_first_non_filter(s->test_file->bs, candidate);
-}
-
 static bool blkverify_recurse_can_replace(BlockDriverState *bs,
                                           BlockDriverState *to_replace)
 {
@@ -341,7 +327,6 @@ static BlockDriver bdrv_blkverify =3D {
     .bdrv_co_flush                    =3D blkverify_co_flush,
=20
     .is_filter                        =3D true,
-    .bdrv_recurse_is_first_non_filter =3D blkverify_recurse_is_first_non_f=
ilter,
     .bdrv_recurse_can_replace         =3D blkverify_recurse_can_replace,
 };
=20
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index e95223d3cb..242d3ff055 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -118,13 +118,6 @@ static void cor_lock_medium(BlockDriverState *bs, bool=
 locked)
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
@@ -143,8 +136,6 @@ static BlockDriver bdrv_copy_on_read =3D {
=20
     .bdrv_co_block_status               =3D bdrv_co_block_status_from_file=
,
=20
-    .bdrv_recurse_is_first_non_filter   =3D cor_recurse_is_first_non_filte=
r,
-
     .has_variable_length                =3D true,
     .is_filter                          =3D true,
 };
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 60137fb680..82c315b298 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -128,13 +128,6 @@ static void compress_lock_medium(BlockDriverState *bs,=
 bool locked)
 }
=20
=20
-static bool compress_recurse_is_first_non_filter(BlockDriverState *bs,
-                                                 BlockDriverState *candida=
te)
-{
-    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
-}
-
-
 static BlockDriver bdrv_compress =3D {
     .format_name                        =3D "compress",
=20
@@ -154,8 +147,6 @@ static BlockDriver bdrv_compress =3D {
=20
     .bdrv_co_block_status               =3D bdrv_co_block_status_from_file=
,
=20
-    .bdrv_recurse_is_first_non_filter   =3D compress_recurse_is_first_non_=
filter,
-
     .has_variable_length                =3D true,
     .is_filter                          =3D true,
 };
diff --git a/block/quorum.c b/block/quorum.c
index 3ece6e4382..f57b0402d9 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -796,23 +796,6 @@ static coroutine_fn int quorum_co_flush(BlockDriverSta=
te *bs)
     return result;
 }
=20
-static bool quorum_recurse_is_first_non_filter(BlockDriverState *bs,
-                                               BlockDriverState *candidate=
)
-{
-    BDRVQuorumState *s =3D bs->opaque;
-    int i;
-
-    for (i =3D 0; i < s->num_children; i++) {
-        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i]->bs,
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
@@ -1216,7 +1199,6 @@ static BlockDriver bdrv_quorum =3D {
     .bdrv_child_perm                    =3D quorum_child_perm,
=20
     .is_filter                          =3D true,
-    .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non_fi=
lter,
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
-static bool replication_recurse_is_first_non_filter(BlockDriverState *bs,
-                                                    BlockDriverState *cand=
idate)
-{
-    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
-}
-
 static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
 {
     Error *local_err =3D NULL;
@@ -699,7 +693,6 @@ static BlockDriver bdrv_replication =3D {
     .bdrv_co_writev             =3D replication_co_writev,
=20
     .is_filter                  =3D true,
-    .bdrv_recurse_is_first_non_filter =3D replication_recurse_is_first_non=
_filter,
=20
     .has_variable_length        =3D true,
     .strong_runtime_opts        =3D replication_strong_runtime_opts,
diff --git a/block/throttle.c b/block/throttle.c
index 0349f42257..71f4bb0ad1 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -207,12 +207,6 @@ static void throttle_reopen_abort(BDRVReopenState *reo=
pen_state)
     reopen_state->opaque =3D NULL;
 }
=20
-static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
-                                                 BlockDriverState *candida=
te)
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
-    .bdrv_recurse_is_first_non_filter   =3D   throttle_recurse_is_first_no=
n_filter,
-
     .bdrv_attach_aio_context            =3D   throttle_attach_aio_context,
     .bdrv_detach_aio_context            =3D   throttle_detach_aio_context,
=20
diff --git a/include/block/block.h b/include/block/block.h
index a6c0f6668e..cd6b5b95aa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -391,10 +391,6 @@ int bdrv_amend_options(BlockDriverState *bs_new, QemuO=
pts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaqu=
e,
                        Error **errp);
=20
-/* external snapshots */
-bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
-                                      BlockDriverState *candidate);
-
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **err=
p);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index eaefac210e..6f9fd5e20e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -94,14 +94,6 @@ struct BlockDriver {
      * must implement them and return -ENOTSUP.
      */
     bool is_filter;
-    /* for snapshots block filter like Quorum can implement the
-     * following recursive callback.
-     * It's purpose is to recurse on the filter children while calling
-     * bdrv_recurse_is_first_non_filter on them.
-     * For a sample implementation look in the future Quorum block filter.
-     */
-    bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
-                                             BlockDriverState *candidate);
     /*
      * Return true if @to_replace can be replaced by a BDS with the
      * same data as @bs without it affecting @bs's behavior (that is,
--=20
2.24.1


