Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B84C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CA92084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7NQwN8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CA92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1iu-000521-Ks
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hT-00031X-OV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hQ-0002RL-Ej
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hQ-0002QO-9j
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+m/eQwiKcGkVhbIVGwOrh8nF2aL0JzZM+uae3PmGdpM=;
 b=I7NQwN8cirSv4UaM+FXHdzsJcTNZkeTxmqHL0xcQhpjlqyfQS4wymraA5A2UdJ0P7rjtXE
 SKXL187f1U6IkPtzHGec85KyNQqEoz2oI12rtHrd1hRszF64pB6XUyO+NHzt28TcNbF4U6
 d2CPuOfVisroUb2trCP9LbsLvviknVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-_g7HyTpgOQq7qhU372a32g-1; Tue, 04 Feb 2020 12:09:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F5AD1085927;
 Tue,  4 Feb 2020 17:09:06 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65E9F86C4A;
 Tue,  4 Feb 2020 17:09:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/33] block: Pass BdrvChildRole to bdrv_child_perm()
Date: Tue,  4 Feb 2020 18:08:20 +0100
Message-Id: <20200204170848.614480-6-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _g7HyTpgOQq7qhU372a32g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                     | 22 ++++++++++++----------
 block/backup-top.c          |  3 ++-
 block/blkdebug.c            |  5 +++--
 block/blklogwrites.c        |  9 +++++----
 block/commit.c              |  1 +
 block/copy-on-read.c        |  1 +
 block/mirror.c              |  1 +
 block/quorum.c              |  1 +
 block/replication.c         |  1 +
 block/vvfat.c               |  1 +
 include/block/block_int.h   |  5 ++++-
 tests/test-bdrv-drain.c     |  5 +++--
 tests/test-bdrv-graph-mod.c |  1 +
 13 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index c576377650..7fa7830428 100644
--- a/block.c
+++ b/block.c
@@ -1764,12 +1764,12 @@ bool bdrv_is_writable(BlockDriverState *bs)
=20
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_=
bs,
                             BdrvChild *c, const BdrvChildClass *child_clas=
s,
-                            BlockReopenQueue *reopen_queue,
+                            BdrvChildRole role, BlockReopenQueue *reopen_q=
ueue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, child_class, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, child_class, role, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -1863,7 +1863,7 @@ static int bdrv_check_perm(BlockDriverState *bs, Bloc=
kReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
=20
-        bdrv_child_perm(bs, c->bs, c, c->klass, q,
+        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_c=
hildren,
@@ -1930,7 +1930,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint6=
4_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->klass, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -2158,14 +2158,15 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, =
BdrvChild *c, Error **errp)
     uint64_t perms, shared;
=20
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->klass, NULL, parent_perms, parent_sha=
red,
-                    &perms, &shared);
+    bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+                    parent_perms, parent_shared, &perms, &shared);
=20
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
=20
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2176,6 +2177,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, =
BdrvChild *c,
=20
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
@@ -2188,7 +2190,7 @@ void bdrv_format_default_perms(BlockDriverState *bs, =
BdrvChild *c,
=20
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
                                   perm, shared, &perm, &shared);
=20
         /* Format drivers may touch metadata even if the guest doesn't wri=
te */
@@ -2464,7 +2466,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent=
_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
=20
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, NULL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, child_role, NU=
LL,
                     perm, shared_perm, &perm, &shared_perm);
=20
     child =3D bdrv_root_attach_child(child_bs, child_name, child_class,
@@ -3502,7 +3504,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, =
Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_backing, bs_queue,
+                            NULL, &child_backing, 0, bs_queue,
                             state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret =3D bdrv_check_update_perm(state->new_backing_bs, NULL,
@@ -3616,7 +3618,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, Blo=
ckDriverState *bs,
         } else {
             uint64_t nperm, nshared;
=20
-            bdrv_child_perm(parent->state.bs, bs, c, c->klass, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->klass, c->role, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
=20
diff --git a/block/backup-top.c b/block/backup-top.c
index 3c812358ce..36ed71413b 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -118,6 +118,7 @@ static void backup_top_refresh_filename(BlockDriverStat=
e *bs)
=20
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                   const BdrvChildClass *child_class,
+                                  BdrvChildRole role,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
                                   uint64_t *nperm, uint64_t *nshared)
@@ -148,7 +149,7 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_filter_default_perms(bs, c, child_class, reopen_queue,
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
                                   perm, shared, nperm, nshared);
=20
         if (perm & BLK_PERM_WRITE) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index c91e78d5c8..8dd8ed6055 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -994,14 +994,15 @@ static int blkdebug_reopen_prepare(BDRVReopenState *r=
eopen_state,
=20
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
                                 const BdrvChildClass *child_class,
+                                BdrvChildRole role,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
                                 uint64_t *nperm, uint64_t *nshared)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
=20
-    bdrv_filter_default_perms(bs, c, child_class, reopen_queue, perm, shar=
ed,
-                              nperm, nshared);
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, nperm, nshared);
=20
     *nperm |=3D s->take_child_perms;
     *nshared &=3D ~s->unshare_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 739db6dcf6..4faf912ef1 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -283,6 +283,7 @@ static int64_t blk_log_writes_getlength(BlockDriverStat=
e *bs)
=20
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
                                       const BdrvChildClass *child_class,
+                                      BdrvChildRole role,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
                                       uint64_t *nperm, uint64_t *nshrd)
@@ -294,11 +295,11 @@ static void blk_log_writes_child_perm(BlockDriverStat=
e *bs, BdrvChild *c,
     }
=20
     if (!strcmp(c->name, "log")) {
-        bdrv_format_default_perms(bs, c, child_class, ro_q, perm, shrd, np=
erm,
-                                  nshrd);
+        bdrv_format_default_perms(bs, c, child_class, role, ro_q, perm, sh=
rd,
+                                  nperm, nshrd);
     } else {
-        bdrv_filter_default_perms(bs, c, child_class, ro_q, perm, shrd, np=
erm,
-                                  nshrd);
+        bdrv_filter_default_perms(bs, c, child_class, role, ro_q, perm, sh=
rd,
+                                  nperm, nshrd);
     }
 }
=20
diff --git a/block/commit.c b/block/commit.c
index f2ccb11874..e0cbe46d75 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -237,6 +237,7 @@ static void bdrv_commit_top_refresh_filename(BlockDrive=
rState *bs)
=20
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildClass *child_class,
+                                       BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index a2c4e6dc58..a2d92ac394 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -52,6 +52,7 @@ static int cor_open(BlockDriverState *bs, QDict *options,=
 int flags,
=20
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
                            const BdrvChildClass *child_class,
+                           BdrvChildRole role,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
diff --git a/block/mirror.c b/block/mirror.c
index d8506af45a..25c5e8b622 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1485,6 +1485,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDri=
verState *bs)
=20
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildClass *child_class,
+                                       BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
diff --git a/block/quorum.c b/block/quorum.c
index e53d02bbcd..62fe37856d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1170,6 +1170,7 @@ static char *quorum_dirname(BlockDriverState *bs, Err=
or **errp)
=20
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
                               const BdrvChildClass *child_class,
+                              BdrvChildRole role,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
                               uint64_t *nperm, uint64_t *nshared)
diff --git a/block/replication.c b/block/replication.c
index c05df1bc16..9ca5c9368e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -161,6 +161,7 @@ static void replication_close(BlockDriverState *bs)
=20
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
                                    const BdrvChildClass *child_class,
+                                   BdrvChildRole role,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
diff --git a/block/vvfat.c b/block/vvfat.c
index 0c0b224947..e9f64b0b24 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3220,6 +3220,7 @@ err:
=20
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
                              uint64_t *nperm, uint64_t *nshared)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4817c2d38c..24f4f65593 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -556,7 +556,7 @@ struct BlockDriver {
      * the parents in @parent_perm and @parent_shared.
      *
      * If @c is NULL, return the permissions for attaching a new child for=
 the
-     * given @child_class.
+     * given @child_class and @role.
      *
      * If @reopen_queue is non-NULL, don't return the currently needed
      * permissions, but those that will be needed after applying the
@@ -564,6 +564,7 @@ struct BlockDriver {
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildClass *child_class,
+                             BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
@@ -1258,6 +1259,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, Bd=
rvChild *c, Error **errp);
  * all children */
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole child_role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
@@ -1268,6 +1270,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, =
BdrvChild *c,
  * CONSISTENT_READ and doesn't share WRITE. */
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
+                               BdrvChildRole child_role,
                                BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c03705ea37..b3d7960bd0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -87,6 +87,7 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverSt=
ate *bs,
=20
 static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
                                  const BdrvChildClass *child_class,
+                                 BdrvChildRole role,
                                  BlockReopenQueue *reopen_queue,
                                  uint64_t perm, uint64_t shared,
                                  uint64_t *nperm, uint64_t *nshared)
@@ -99,8 +100,8 @@ static void bdrv_test_child_perm(BlockDriverState *bs, B=
drvChild *c,
         child_class =3D &child_file;
     }
=20
-    bdrv_format_default_perms(bs, c, child_class, reopen_queue, perm, shar=
ed,
-                              nperm, nshared);
+    bdrv_format_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, nperm, nshared);
 }
=20
 static int bdrv_test_change_backing_file(BlockDriverState *bs,
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 8b8c186c9f..3707e2533c 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -31,6 +31,7 @@ static BlockDriver bdrv_pass_through =3D {
=20
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
                                          const BdrvChildClass *child_class=
,
+                                         BdrvChildRole role,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
                                          uint64_t *nperm, uint64_t *nshare=
d)
--=20
2.24.1


