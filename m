Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AF420722
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5n5Ke99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AF420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxSx-0002I4-4h
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxC8-0004HH-8w
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxC6-0006zF-RS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35115
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxC6-0006xY-NY
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnsWeFh7mi9mM734/yKRZzTXrsmfCVWnsv94mvxwEi0=;
 b=Y5n5Ke991qNZ/0B/p1Aw3dfP7brhG2YPbpO/HBJNFQQPiAYJUflAxzs9P8uoDDiWgP9ZdY
 URAddI6599owkZzZ4WZ3mSOhp9SgyJpQyAqK7709XZQC614saq0P68pyDLqY62IEcFpLoJ
 9bfy0Eh0LEJNYTAPsdssMOgPOdnKIbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fPd4JhAeP2Wa6KS2yb4Zxw-1; Wed, 27 Nov 2019 08:17:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC7F8026AB;
 Wed, 27 Nov 2019 13:17:15 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC84C5C219;
 Wed, 27 Nov 2019 13:17:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 20/31] block: Make backing files child_of_bds children
Date: Wed, 27 Nov 2019 14:16:13 +0100
Message-Id: <20191127131624.1062403-21-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: fPd4JhAeP2Wa6KS2yb4Zxw-1
X-Mimecast-Spam-Score: 0
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                 | 26 ++++++++++++++++++++------
 block/backup-top.c      |  2 +-
 block/vvfat.c           |  3 ++-
 tests/test-bdrv-drain.c | 13 +++++++------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 4b8c33dccc..63fe19fd73 100644
--- a/block.c
+++ b/block.c
@@ -2725,6 +2725,20 @@ static bool bdrv_inherits_from_recursive(BlockDriver=
State *child,
     return child !=3D NULL;
 }
=20
+/*
+ * Return the BdrvChildRole for @bs's backing child.  bs->backing is
+ * mostly used for COW backing children (role =3D COW), but also for
+ * filtered children (role =3D FILTERED | PRIMARY).
+ */
+static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
+{
+    if (bs->drv && bs->drv->is_filter) {
+        return BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
+    } else {
+        return BDRV_CHILD_COW;
+    }
+}
+
 /*
  * Sets the backing file link of a BDS. A new reference is created; caller=
s
  * which don't need their own reference any more must call bdrv_unref().
@@ -2752,8 +2766,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockD=
riverState *backing_hd,
         goto out;
     }
=20
-    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_ba=
cking,
-                                    0, errp);
+    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_of=
_bds,
+                                    bdrv_backing_role(bs), errp);
     /* If backing_hd was already part of bs's backing chain, and
      * inherits_from pointed recursively to bs then let's update it to
      * point directly to bs (else it will become NULL). */
@@ -2850,7 +2864,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDic=
t *parent_options,
     }
=20
     backing_hd =3D bdrv_open_inherit(backing_filename, reference, options,=
 0, bs,
-                                   &child_backing, 0, errp);
+                                   &child_of_bds, BDRV_CHILD_COW, errp);
     if (!backing_hd) {
         bs->open_flags |=3D BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -3670,8 +3684,8 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, =
Error **errp)
         if (state->replace_backing_bs && state->new_backing_bs) {
             uint64_t nperm, nshared;
             bdrv_child_perm(state->bs, state->new_backing_bs,
-                            NULL, &child_backing, 0, bs_queue,
-                            state->perm, state->shared_perm,
+                            NULL, &child_of_bds, bdrv_backing_role(state->=
bs),
+                            bs_queue, state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret =3D bdrv_check_update_perm(state->new_backing_bs, NULL,
                                          nperm, nshared, NULL, NULL, errp)=
;
@@ -6642,7 +6656,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         drv->bdrv_gather_child_options(bs, opts, backing_overridden);
     } else {
         QLIST_FOREACH(child, &bs->children, next) {
-            if (child->klass =3D=3D &child_backing && !backing_overridden)=
 {
+            if (child =3D=3D bs->backing && !backing_overridden) {
                 /* We can skip the backing BDS if it has not been overridd=
en */
                 continue;
             }
diff --git a/block/backup-top.c b/block/backup-top.c
index 811bc67fc7..ce97c0146a 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -138,7 +138,7 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         return;
     }
=20
-    if (child_class =3D=3D &child_file) {
+    if (!(role & BDRV_CHILD_FILTERED)) {
         /*
          * Target child
          *
diff --git a/block/vvfat.c b/block/vvfat.c
index 0c2f77bece..b8096763d5 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3228,7 +3228,8 @@ static void vvfat_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
 {
     BDRVVVFATState *s =3D bs->opaque;
=20
-    assert(c =3D=3D s->qcow || child_class =3D=3D &child_backing);
+    assert(c =3D=3D s->qcow ||
+           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW)));
=20
     if (c =3D=3D s->qcow) {
         /* This is a private node, nobody should try to attach to it */
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index b3d7960bd0..15393a0140 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -96,7 +96,7 @@ static void bdrv_test_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
      * bdrv_format_default_perms() accepts only these two, so disguise
      * detach_by_driver_cb_parent as one of them.
      */
-    if (child_class !=3D &child_file && child_class !=3D &child_backing) {
+    if (child_class !=3D &child_file && child_class !=3D &child_of_bds) {
         child_class =3D &child_file;
     }
=20
@@ -1399,8 +1399,8 @@ static void test_detach_indirect(bool by_parent_cb)
     bdrv_ref(a);
     child_b =3D bdrv_attach_child(parent_b, b, "PB-B", &child_file, 0,
                                 &error_abort);
-    child_a =3D bdrv_attach_child(parent_b, a, "PB-A", &child_backing, 0,
-                                &error_abort);
+    child_a =3D bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
+                                BDRV_CHILD_COW, &error_abort);
=20
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
@@ -1793,7 +1793,7 @@ static void test_drop_intermediate_poll(void)
     int i;
     int ret;
=20
-    chain_child_class =3D child_backing;
+    chain_child_class =3D child_of_bds;
     chain_child_class.update_filename =3D drop_intermediate_poll_update_fi=
lename;
=20
     for (i =3D 0; i < 3; i++) {
@@ -1816,7 +1816,7 @@ static void test_drop_intermediate_poll(void)
             /* Takes the reference to chain[i - 1] */
             chain[i]->backing =3D bdrv_attach_child(chain[i], chain[i - 1]=
,
                                                   "chain", &chain_child_cl=
ass,
-                                                  0, &error_abort);
+                                                  BDRV_CHILD_COW, &error_a=
bort);
         }
     }
=20
@@ -2034,7 +2034,8 @@ static void do_test_replace_child_mid_drain(int old_d=
rain_count,
=20
     bdrv_ref(old_child_bs);
     parent_bs->backing =3D bdrv_attach_child(parent_bs, old_child_bs, "chi=
ld",
-                                           &child_backing, 0, &error_abort=
);
+                                           &child_of_bds, BDRV_CHILD_COW,
+                                           &error_abort);
=20
     for (i =3D 0; i < old_drain_count; i++) {
         bdrv_drained_begin(old_child_bs);
--=20
2.23.0


