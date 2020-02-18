Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E75C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E1D20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxzWtTDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E1D20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42f3-0001HR-92
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42F0-0007j2-T2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Ey-000222-Ga
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35425
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Ey-00021u-CS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKo2uT2e+aj3mNWpYL1H8pNIORZ+byTLeJNhOG6ihyg=;
 b=GxzWtTDK6bB04DQVBe5s+P99VGeb0UZw3TLczxqycZV6l1tTAZYn0N42ckQnvPCPhnzg+V
 t1aMKXvQLoazS/tSiwwfsbiXiCryWOVb/dAVtWaE6IhzgyNXVjyt2ee5sugv4QtViycp9l
 W2mw8CHMH/2CqmkzHUpiO49o+i9Hwhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-xO7zMe6aN4eSTTkc1K4WqA-1; Tue, 18 Feb 2020 07:44:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3DF71005512;
 Tue, 18 Feb 2020 12:44:31 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C867A1BC6D;
 Tue, 18 Feb 2020 12:44:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 33/33] block: Drop @child_class from bdrv_child_perm()
Date: Tue, 18 Feb 2020 13:42:42 +0100
Message-Id: <20200218124242.584644-34-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xO7zMe6aN4eSTTkc1K4WqA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementations should decide the necessary permissions based on @role.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                     | 45 ++++++++++++++++---------------------
 block/backup-top.c          |  3 +--
 block/blkdebug.c            |  3 +--
 block/blklogwrites.c        |  3 +--
 block/commit.c              |  1 -
 block/copy-on-read.c        |  1 -
 block/mirror.c              |  1 -
 block/quorum.c              |  1 -
 block/replication.c         |  1 -
 block/vvfat.c               |  4 +---
 include/block/block_int.h   |  4 +---
 tests/test-bdrv-drain.c     | 19 +---------------
 tests/test-bdrv-graph-mod.c |  1 -
 13 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/block.c b/block.c
index 986f99415c..00c491dd91 100644
--- a/block.c
+++ b/block.c
@@ -1788,13 +1788,13 @@ bool bdrv_is_writable(BlockDriverState *bs)
 }
=20
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_=
bs,
-                            BdrvChild *c, const BdrvChildClass *child_clas=
s,
-                            BdrvChildRole role, BlockReopenQueue *reopen_q=
ueue,
+                            BdrvChild *c, BdrvChildRole role,
+                            BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     assert(bs->drv && bs->drv->bdrv_child_perm);
-    bs->drv->bdrv_child_perm(bs, c, child_class, role, reopen_queue,
+    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
                              parent_perm, parent_shared,
                              nperm, nshared);
     /* TODO Take force_share from reopen_queue */
@@ -1888,7 +1888,7 @@ static int bdrv_check_perm(BlockDriverState *bs, Bloc=
kReopenQueue *q,
         uint64_t cur_perm, cur_shared;
         bool child_tighten_restr;
=20
-        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, q,
+        bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore_c=
hildren,
@@ -1955,7 +1955,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint6=
4_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -2183,7 +2183,7 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, Bd=
rvChild *c, Error **errp)
     uint64_t perms, shared;
=20
     bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
-    bdrv_child_perm(bs, c->bs, c, c->klass, c->role, NULL,
+    bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                     parent_perms, parent_shared, &perms, &shared);
=20
     return bdrv_child_try_set_perm(c, perms, shared, errp);
@@ -2195,7 +2195,6 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, Bd=
rvChild *c, Error **errp)
  * filtered child.
  */
 static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildClass *child_class,
                                       BdrvChildRole role,
                                       BlockReopenQueue *reopen_queue,
                                       uint64_t perm, uint64_t shared,
@@ -2206,13 +2205,12 @@ static void bdrv_filter_default_perms(BlockDriverSt=
ate *bs, BdrvChild *c,
 }
=20
 static void bdrv_default_perms_for_backing(BlockDriverState *bs, BdrvChild=
 *c,
-                                           const BdrvChildClass *child_cla=
ss,
                                            BdrvChildRole role,
                                            BlockReopenQueue *reopen_queue,
                                            uint64_t perm, uint64_t shared,
                                            uint64_t *nperm, uint64_t *nsha=
red)
 {
-    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW));
+    assert(role & BDRV_CHILD_COW);
=20
     /*
      * We want consistent read from backing files if the parent needs it.
@@ -2243,7 +2241,6 @@ static void bdrv_default_perms_for_backing(BlockDrive=
rState *bs, BdrvChild *c,
 }
=20
 static void bdrv_default_perms_for_metadata(BlockDriverState *bs, BdrvChil=
d *c,
-                                            const BdrvChildClass *child_cl=
ass,
                                             BdrvChildRole role,
                                             BlockReopenQueue *reopen_queue=
,
                                             uint64_t perm, uint64_t shared=
,
@@ -2251,7 +2248,7 @@ static void bdrv_default_perms_for_metadata(BlockDriv=
erState *bs, BdrvChild *c,
 {
     int flags;
=20
-    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_METADATA=
));
+    assert(role & BDRV_CHILD_METADATA);
=20
     flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
=20
@@ -2259,7 +2256,7 @@ static void bdrv_default_perms_for_metadata(BlockDriv=
erState *bs, BdrvChild *c,
      * Apart from the modifications below, the same permissions are
      * forwarded and left alone as for filters
      */
-    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+    bdrv_filter_default_perms(bs, c, role, reopen_queue,
                               perm, shared, &perm, &shared);
=20
     /* Format drivers may touch metadata even if the guest doesn't write *=
/
@@ -2285,19 +2282,18 @@ static void bdrv_default_perms_for_metadata(BlockDr=
iverState *bs, BdrvChild *c,
 }
=20
 static void bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c=
,
-                                        const BdrvChildClass *child_class,
                                         BdrvChildRole role,
                                         BlockReopenQueue *reopen_queue,
                                         uint64_t perm, uint64_t shared,
                                         uint64_t *nperm, uint64_t *nshared=
)
 {
-    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_DATA));
+    assert(role & BDRV_CHILD_DATA);
=20
     /*
      * Apart from the modifications below, the same permissions are
      * forwarded and left alone as for filters
      */
-    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+    bdrv_filter_default_perms(bs, c, role, reopen_queue,
                               perm, shared, &perm, &shared);
=20
     /*
@@ -2317,24 +2313,21 @@ static void bdrv_default_perms_for_data(BlockDriver=
State *bs, BdrvChild *c,
 }
=20
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
-                        const BdrvChildClass *child_class, BdrvChildRole r=
ole,
-                        BlockReopenQueue *reopen_queue,
+                        BdrvChildRole role, BlockReopenQueue *reopen_queue=
,
                         uint64_t perm, uint64_t shared,
                         uint64_t *nperm, uint64_t *nshared)
 {
-    assert(child_class =3D=3D &child_of_bds);
-
     if (role & BDRV_CHILD_FILTERED) {
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+        bdrv_filter_default_perms(bs, c, role, reopen_queue,
                                   perm, shared, nperm, nshared);
     } else if (role & BDRV_CHILD_COW) {
-        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
+        bdrv_default_perms_for_backing(bs, c, role, reopen_queue,
                                        perm, shared, nperm, nshared);
     } else if (role & BDRV_CHILD_METADATA) {
-        bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_q=
ueue,
+        bdrv_default_perms_for_metadata(bs, c, role, reopen_queue,
                                         perm, shared, nperm, nshared);
     } else if (role & BDRV_CHILD_DATA) {
-        bdrv_default_perms_for_data(bs, c, child_class, role, reopen_queue=
,
+        bdrv_default_perms_for_data(bs, c, role, reopen_queue,
                                     perm, shared, nperm, nshared);
     } else {
         g_assert_not_reached();
@@ -2577,7 +2570,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent=
_bs,
     bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
=20
     assert(parent_bs->drv);
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_class, child_role, NU=
LL,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
                     perm, shared_perm, &perm, &shared_perm);
=20
     child =3D bdrv_root_attach_child(child_bs, child_name, child_class,
@@ -3650,7 +3643,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, =
Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_of_bds, bdrv_backing_role(state->=
bs),
+                            NULL, bdrv_backing_role(state->bs),
                             bs_queue, state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret =3D bdrv_check_update_perm(state->new_backing_bs, NULL,
@@ -3764,7 +3757,7 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, Blo=
ckDriverState *bs,
         } else {
             uint64_t nperm, nshared;
=20
-            bdrv_child_perm(parent->state.bs, bs, c, c->klass, c->role, q,
+            bdrv_child_perm(parent->state.bs, bs, c, c->role, q,
                             parent->state.perm, parent->state.shared_perm,
                             &nperm, &nshared);
=20
diff --git a/block/backup-top.c b/block/backup-top.c
index 00dbad44b5..351ced39ea 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -121,7 +121,6 @@ static void backup_top_refresh_filename(BlockDriverStat=
e *bs)
 }
=20
 static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                  const BdrvChildClass *child_class,
                                   BdrvChildRole role,
                                   BlockReopenQueue *reopen_queue,
                                   uint64_t perm, uint64_t shared,
@@ -153,7 +152,7 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+        bdrv_default_perms(bs, c, role, reopen_queue,
                            perm, shared, nperm, nshared);
=20
         if (perm & BLK_PERM_WRITE) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index a925d8295e..7194bc7f06 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -995,7 +995,6 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reo=
pen_state,
 }
=20
 static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                const BdrvChildClass *child_class,
                                 BdrvChildRole role,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
@@ -1003,7 +1002,7 @@ static void blkdebug_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
 {
     BDRVBlkdebugState *s =3D bs->opaque;
=20
-    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+    bdrv_default_perms(bs, c, role, reopen_queue,
                        perm, shared, nperm, nshared);
=20
     *nperm |=3D s->take_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 8684fb1c74..6753bd9a3e 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -283,7 +283,6 @@ static int64_t blk_log_writes_getlength(BlockDriverStat=
e *bs)
 }
=20
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                      const BdrvChildClass *child_class,
                                       BdrvChildRole role,
                                       BlockReopenQueue *ro_q,
                                       uint64_t perm, uint64_t shrd,
@@ -295,7 +294,7 @@ static void blk_log_writes_child_perm(BlockDriverState =
*bs, BdrvChild *c,
         return;
     }
=20
-    bdrv_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
+    bdrv_default_perms(bs, c, role, ro_q, perm, shrd,
                        nperm, nshrd);
 }
=20
diff --git a/block/commit.c b/block/commit.c
index 6d094c8cd1..7bf05e69da 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -223,7 +223,6 @@ static void bdrv_commit_top_refresh_filename(BlockDrive=
rState *bs)
 }
=20
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildClass *child_class,
                                        BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index c857ea0da7..a6e3c74a68 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -52,7 +52,6 @@ static int cor_open(BlockDriverState *bs, QDict *options,=
 int flags,
 #define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
=20
 static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
-                           const BdrvChildClass *child_class,
                            BdrvChildRole role,
                            BlockReopenQueue *reopen_queue,
                            uint64_t perm, uint64_t shared,
diff --git a/block/mirror.c b/block/mirror.c
index 25c5e8b622..78f5939fac 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1484,7 +1484,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDri=
verState *bs)
 }
=20
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                       const BdrvChildClass *child_class,
                                        BdrvChildRole role,
                                        BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
diff --git a/block/quorum.c b/block/quorum.c
index 616ac3a927..7cf7ab1546 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1153,7 +1153,6 @@ static char *quorum_dirname(BlockDriverState *bs, Err=
or **errp)
 }
=20
 static void quorum_child_perm(BlockDriverState *bs, BdrvChild *c,
-                              const BdrvChildClass *child_class,
                               BdrvChildRole role,
                               BlockReopenQueue *reopen_queue,
                               uint64_t perm, uint64_t shared,
diff --git a/block/replication.c b/block/replication.c
index ec512ae1c3..5843367944 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -161,7 +161,6 @@ static void replication_close(BlockDriverState *bs)
 }
=20
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                   const BdrvChildClass *child_class,
                                    BdrvChildRole role,
                                    BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
diff --git a/block/vvfat.c b/block/vvfat.c
index d4f4218924..6e36ad3175 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3213,7 +3213,6 @@ err:
 }
=20
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildClass *child_class,
                              BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
@@ -3221,8 +3220,7 @@ static void vvfat_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
 {
     BDRVVVFATState *s =3D bs->opaque;
=20
-    assert(c =3D=3D s->qcow ||
-           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW)));
+    assert(c =3D=3D s->qcow || (role & BDRV_CHILD_COW));
=20
     if (c =3D=3D s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1609e40b58..9c58b64903 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -563,7 +563,6 @@ struct BlockDriver {
      * @reopen_queue.
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
-                             const BdrvChildClass *child_class,
                              BdrvChildRole role,
                              BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
@@ -1261,8 +1260,7 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
  * child_of_bds child class and set an appropriate BdrvChildRole.
  */
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
-                        const BdrvChildClass *child_class, BdrvChildRole r=
ole,
-                        BlockReopenQueue *reopen_queue,
+                        BdrvChildRole role, BlockReopenQueue *reopen_queue=
,
                         uint64_t perm, uint64_t shared,
                         uint64_t *nperm, uint64_t *nshared);
=20
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 655fd0d085..1107271840 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -85,23 +85,6 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverS=
tate *bs,
     return 0;
 }
=20
-static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
-                                 const BdrvChildClass *child_class,
-                                 BdrvChildRole role,
-                                 BlockReopenQueue *reopen_queue,
-                                 uint64_t perm, uint64_t shared,
-                                 uint64_t *nperm, uint64_t *nshared)
-{
-    /*
-     * bdrv_default_perms() accepts nothing else, so disguise
-     * detach_by_driver_cb_parent.
-     */
-    child_class =3D &child_of_bds;
-
-    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
-                       perm, shared, nperm, nshared);
-}
-
 static int bdrv_test_change_backing_file(BlockDriverState *bs,
                                          const char *backing_file,
                                          const char *backing_fmt)
@@ -119,7 +102,7 @@ static BlockDriver bdrv_test =3D {
     .bdrv_co_drain_begin    =3D bdrv_test_co_drain_begin,
     .bdrv_co_drain_end      =3D bdrv_test_co_drain_end,
=20
-    .bdrv_child_perm        =3D bdrv_test_child_perm,
+    .bdrv_child_perm        =3D bdrv_default_perms,
=20
     .bdrv_change_backing_file =3D bdrv_test_change_backing_file,
 };
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index a2d0318b16..f93f3168b0 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -30,7 +30,6 @@ static BlockDriver bdrv_pass_through =3D {
 };
=20
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
-                                         const BdrvChildClass *child_class=
,
                                          BdrvChildRole role,
                                          BlockReopenQueue *reopen_queue,
                                          uint64_t perm, uint64_t shared,
--=20
2.24.1


