Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A6C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FD020409
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK+FBA5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FD020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxfU-0000vy-Sw
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCO-0004Yc-RN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCI-0007A6-J7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCI-00079g-Cr
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY6xy+sqYq1EUM9e/fysnZY/wgtuBSWkBmMhSUEH1Vc=;
 b=gK+FBA5TqexYT3DckwogbLd/hg6wHnghwXQzCyg/5h0b29YVmzmUq3wGDItqWIdG/mx3Rz
 ZYaz6dyrPtPWFsjLk+qX3gH2YE9oX530Awyde9jD7pjFSyGbBGSsIEcv/O/NNKP4DxMLu2
 97Fr38X2T/R2G3/4daLibrfZSel0akI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-eL_goe7XO5eKsCunsOCehA-1; Wed, 27 Nov 2019 08:17:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFC4E106C012;
 Wed, 27 Nov 2019 13:17:29 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E8101001281;
 Wed, 27 Nov 2019 13:17:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 26/31] block: Use bdrv_default_perms()
Date: Wed, 27 Nov 2019 14:16:19 +0100
Message-Id: <20191127131624.1062403-27-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eL_goe7XO5eKsCunsOCehA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_default_perms() can decide which permission profile to use based on
the BdrvChildRole, so block drivers do not need to select it explicitly.

The blkverify driver now no longer shares the WRITE permission for the
image to verify.  We thus have to adjust two places in
test-block-iothread not to take it.  (Note that in theory, blkverify
should behave like quorum in this regard and share neither WRITE nor
RESIZE for both of its children.  In practice, it does not really
matter, because blkverify is used only for debugging, so we might as
well keep its permissions rather liberal.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup-top.c          |  4 ++--
 block/blkdebug.c            |  4 ++--
 block/blklogwrites.c        |  9 ++-------
 block/blkreplay.c           |  2 +-
 block/blkverify.c           |  2 +-
 block/bochs.c               |  2 +-
 block/cloop.c               |  2 +-
 block/crypto.c              |  2 +-
 block/dmg.c                 |  2 +-
 block/parallels.c           |  2 +-
 block/qcow.c                |  2 +-
 block/qcow2.c               |  2 +-
 block/qed.c                 |  2 +-
 block/raw-format.c          |  2 +-
 block/throttle.c            |  2 +-
 block/vdi.c                 |  2 +-
 block/vhdx.c                |  2 +-
 block/vmdk.c                |  2 +-
 block/vpc.c                 |  2 +-
 tests/test-bdrv-drain.c     | 10 +++++-----
 tests/test-bdrv-graph-mod.c |  2 +-
 tests/test-block-iothread.c | 17 ++++++++++++++---
 22 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index eccd6bfae0..54e499744f 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -149,8 +149,8 @@ static void backup_top_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D BLK_PERM_WRITE;
     } else {
         /* Source child */
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
-                                  perm, shared, nperm, nshared);
+        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+                           perm, shared, nperm, nshared);
=20
         if (perm & BLK_PERM_WRITE) {
             *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index b31fa40b0e..a925d8295e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -1003,8 +1003,8 @@ static void blkdebug_child_perm(BlockDriverState *bs,=
 BdrvChild *c,
 {
     BDRVBlkdebugState *s =3D bs->opaque;
=20
-    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
-                              perm, shared, nperm, nshared);
+    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+                       perm, shared, nperm, nshared);
=20
     *nperm |=3D s->take_child_perms;
     *nshared &=3D ~s->unshare_child_perms;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 3ee991b38e..48091c2788 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -296,13 +296,8 @@ static void blk_log_writes_child_perm(BlockDriverState=
 *bs, BdrvChild *c,
         return;
     }
=20
-    if (!strcmp(c->name, "log")) {
-        bdrv_format_default_perms(bs, c, child_class, role, ro_q, perm, sh=
rd,
-                                  nperm, nshrd);
-    } else {
-        bdrv_filter_default_perms(bs, c, child_class, role, ro_q, perm, sh=
rd,
-                                  nperm, nshrd);
-    }
+    bdrv_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
+                       nperm, nshrd);
 }
=20
 static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **er=
rp)
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 71628f4d56..be8cdb6b60 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -138,7 +138,7 @@ static BlockDriver bdrv_blkreplay =3D {
     .instance_size          =3D 0,
=20
     .bdrv_open              =3D blkreplay_open,
-    .bdrv_child_perm        =3D bdrv_filter_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
     .bdrv_getlength         =3D blkreplay_getlength,
=20
     .bdrv_co_preadv         =3D blkreplay_co_preadv,
diff --git a/block/blkverify.c b/block/blkverify.c
index 7df4cb8007..4192f79d89 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -321,7 +321,7 @@ static BlockDriver bdrv_blkverify =3D {
     .bdrv_parse_filename              =3D blkverify_parse_filename,
     .bdrv_file_open                   =3D blkverify_open,
     .bdrv_close                       =3D blkverify_close,
-    .bdrv_child_perm                  =3D bdrv_filter_default_perms,
+    .bdrv_child_perm                  =3D bdrv_default_perms,
     .bdrv_getlength                   =3D blkverify_getlength,
     .bdrv_refresh_filename            =3D blkverify_refresh_filename,
     .bdrv_dirname                     =3D blkverify_dirname,
diff --git a/block/bochs.c b/block/bochs.c
index 15f9807954..96779743b2 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -297,7 +297,7 @@ static BlockDriver bdrv_bochs =3D {
     .instance_size=09=3D sizeof(BDRVBochsState),
     .bdrv_probe=09=09=3D bochs_probe,
     .bdrv_open=09=09=3D bochs_open,
-    .bdrv_child_perm     =3D bdrv_format_default_perms,
+    .bdrv_child_perm     =3D bdrv_default_perms,
     .bdrv_refresh_limits =3D bochs_refresh_limits,
     .bdrv_co_preadv =3D bochs_co_preadv,
     .bdrv_close=09=09=3D bochs_close,
diff --git a/block/cloop.c b/block/cloop.c
index 6662af7470..4cf73fe5c6 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -293,7 +293,7 @@ static BlockDriver bdrv_cloop =3D {
     .instance_size  =3D sizeof(BDRVCloopState),
     .bdrv_probe     =3D cloop_probe,
     .bdrv_open      =3D cloop_open,
-    .bdrv_child_perm     =3D bdrv_format_default_perms,
+    .bdrv_child_perm     =3D bdrv_default_perms,
     .bdrv_refresh_limits =3D cloop_refresh_limits,
     .bdrv_co_preadv =3D cloop_co_preadv,
     .bdrv_close     =3D cloop_close,
diff --git a/block/crypto.c b/block/crypto.c
index b5e31aee6f..644690ddfd 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -659,7 +659,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_close         =3D block_crypto_close,
     /* This driver doesn't modify LUKS metadata except when creating image=
.
      * Allow share-rw=3Don as a special case. */
-    .bdrv_child_perm    =3D bdrv_filter_default_perms,
+    .bdrv_child_perm    =3D bdrv_default_perms,
     .bdrv_co_create     =3D block_crypto_co_create_luks,
     .bdrv_co_create_opts =3D block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   =3D block_crypto_co_truncate,
diff --git a/block/dmg.c b/block/dmg.c
index 479d764d82..e9df59b01b 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -750,7 +750,7 @@ static BlockDriver bdrv_dmg =3D {
     .bdrv_probe     =3D dmg_probe,
     .bdrv_open      =3D dmg_open,
     .bdrv_refresh_limits =3D dmg_refresh_limits,
-    .bdrv_child_perm     =3D bdrv_format_default_perms,
+    .bdrv_child_perm     =3D bdrv_default_perms,
     .bdrv_co_preadv =3D dmg_co_preadv,
     .bdrv_close     =3D dmg_close,
 };
diff --git a/block/parallels.c b/block/parallels.c
index 8ff7bfcc40..5ed41bcac6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -904,7 +904,7 @@ static BlockDriver bdrv_parallels =3D {
     .bdrv_probe=09=09=3D parallels_probe,
     .bdrv_open=09=09=3D parallels_open,
     .bdrv_close=09=09=3D parallels_close,
-    .bdrv_child_perm          =3D bdrv_format_default_perms,
+    .bdrv_child_perm          =3D bdrv_default_perms,
     .bdrv_co_block_status     =3D parallels_co_block_status,
     .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
     .bdrv_co_flush_to_os      =3D parallels_co_flush_to_os,
diff --git a/block/qcow.c b/block/qcow.c
index c81a687195..7f1400e597 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1179,7 +1179,7 @@ static BlockDriver bdrv_qcow =3D {
     .bdrv_probe=09=09=3D qcow_probe,
     .bdrv_open=09=09=3D qcow_open,
     .bdrv_close=09=09=3D qcow_close,
-    .bdrv_child_perm        =3D bdrv_format_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
     .bdrv_reopen_prepare    =3D qcow_reopen_prepare,
     .bdrv_co_create         =3D qcow_co_create,
     .bdrv_co_create_opts    =3D qcow_co_create_opts,
diff --git a/block/qcow2.c b/block/qcow2.c
index 22d70ce62f..6954fe4a86 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5504,7 +5504,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_reopen_commit   =3D qcow2_reopen_commit,
     .bdrv_reopen_abort    =3D qcow2_reopen_abort,
     .bdrv_join_options    =3D qcow2_join_options,
-    .bdrv_child_perm      =3D bdrv_format_default_perms,
+    .bdrv_child_perm      =3D bdrv_default_perms,
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
     .bdrv_has_zero_init   =3D qcow2_has_zero_init,
diff --git a/block/qed.c b/block/qed.c
index eaa042c426..8c0d87484f 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1669,7 +1669,7 @@ static BlockDriver bdrv_qed =3D {
     .bdrv_open                =3D bdrv_qed_open,
     .bdrv_close               =3D bdrv_qed_close,
     .bdrv_reopen_prepare      =3D bdrv_qed_reopen_prepare,
-    .bdrv_child_perm          =3D bdrv_format_default_perms,
+    .bdrv_child_perm          =3D bdrv_default_perms,
     .bdrv_co_create           =3D bdrv_qed_co_create,
     .bdrv_co_create_opts      =3D bdrv_qed_co_create_opts,
     .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
diff --git a/block/raw-format.c b/block/raw-format.c
index 6c46dee996..060ae04655 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -588,7 +588,7 @@ BlockDriver bdrv_raw =3D {
     .bdrv_reopen_commit   =3D &raw_reopen_commit,
     .bdrv_reopen_abort    =3D &raw_reopen_abort,
     .bdrv_open            =3D &raw_open,
-    .bdrv_child_perm      =3D bdrv_filter_default_perms,
+    .bdrv_child_perm      =3D bdrv_default_perms,
     .bdrv_co_create_opts  =3D &raw_co_create_opts,
     .bdrv_co_preadv       =3D &raw_co_preadv,
     .bdrv_co_pwritev      =3D &raw_co_pwritev,
diff --git a/block/throttle.c b/block/throttle.c
index 47b0a3522d..0ebbad0743 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -237,7 +237,7 @@ static BlockDriver bdrv_throttle =3D {
     .bdrv_close                         =3D   throttle_close,
     .bdrv_co_flush                      =3D   throttle_co_flush,
=20
-    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
+    .bdrv_child_perm                    =3D   bdrv_default_perms,
=20
     .bdrv_getlength                     =3D   throttle_getlength,
=20
diff --git a/block/vdi.c b/block/vdi.c
index 0046f7f332..77354aa441 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -1037,7 +1037,7 @@ static BlockDriver bdrv_vdi =3D {
     .bdrv_open =3D vdi_open,
     .bdrv_close =3D vdi_close,
     .bdrv_reopen_prepare =3D vdi_reopen_prepare,
-    .bdrv_child_perm          =3D bdrv_format_default_perms,
+    .bdrv_child_perm          =3D bdrv_default_perms,
     .bdrv_co_create      =3D vdi_co_create,
     .bdrv_co_create_opts =3D vdi_co_create_opts,
     .bdrv_has_zero_init  =3D vdi_has_zero_init,
diff --git a/block/vhdx.c b/block/vhdx.c
index 4c7bbd3d51..49897269fa 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2232,7 +2232,7 @@ static BlockDriver bdrv_vhdx =3D {
     .bdrv_open              =3D vhdx_open,
     .bdrv_close             =3D vhdx_close,
     .bdrv_reopen_prepare    =3D vhdx_reopen_prepare,
-    .bdrv_child_perm        =3D bdrv_format_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
     .bdrv_co_readv          =3D vhdx_co_readv,
     .bdrv_co_writev         =3D vhdx_co_writev,
     .bdrv_co_create         =3D vhdx_co_create,
diff --git a/block/vmdk.c b/block/vmdk.c
index 41e7cc0c8d..e1c2842855 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -3055,7 +3055,7 @@ static BlockDriver bdrv_vmdk =3D {
     .bdrv_open                    =3D vmdk_open,
     .bdrv_co_check                =3D vmdk_co_check,
     .bdrv_reopen_prepare          =3D vmdk_reopen_prepare,
-    .bdrv_child_perm              =3D bdrv_format_default_perms,
+    .bdrv_child_perm              =3D bdrv_default_perms,
     .bdrv_co_preadv               =3D vmdk_co_preadv,
     .bdrv_co_pwritev              =3D vmdk_co_pwritev,
     .bdrv_co_pwritev_compressed   =3D vmdk_co_pwritev_compressed,
diff --git a/block/vpc.c b/block/vpc.c
index 8cb64beef7..fc204361af 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1238,7 +1238,7 @@ static BlockDriver bdrv_vpc =3D {
     .bdrv_open              =3D vpc_open,
     .bdrv_close             =3D vpc_close,
     .bdrv_reopen_prepare    =3D vpc_reopen_prepare,
-    .bdrv_child_perm        =3D bdrv_format_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
     .bdrv_co_create         =3D vpc_co_create,
     .bdrv_co_create_opts    =3D vpc_co_create_opts,
=20
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 91567ca97d..0da5a3a6a1 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -93,15 +93,15 @@ static void bdrv_test_child_perm(BlockDriverState *bs, =
BdrvChild *c,
                                  uint64_t *nperm, uint64_t *nshared)
 {
     /*
-     * bdrv_format_default_perms() accepts only these two, so disguise
+     * bdrv_default_perms() accepts only these two, so disguise
      * detach_by_driver_cb_parent as one of them.
      */
     if (child_class !=3D &child_file && child_class !=3D &child_of_bds) {
         child_class =3D &child_of_bds;
     }
=20
-    bdrv_format_default_perms(bs, c, child_class, role, reopen_queue,
-                              perm, shared, nperm, nshared);
+    bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+                       perm, shared, nperm, nshared);
 }
=20
 static int bdrv_test_change_backing_file(BlockDriverState *bs,
@@ -1137,7 +1137,7 @@ static BlockDriver bdrv_test_top_driver =3D {
     .bdrv_close             =3D bdrv_test_top_close,
     .bdrv_co_preadv         =3D bdrv_test_top_co_preadv,
=20
-    .bdrv_child_perm        =3D bdrv_format_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
 };
=20
 typedef struct TestCoDeleteByDrainData {
@@ -1966,7 +1966,7 @@ static BlockDriver bdrv_replace_test =3D {
     .bdrv_co_drain_begin    =3D bdrv_replace_test_co_drain_begin,
     .bdrv_co_drain_end      =3D bdrv_replace_test_co_drain_end,
=20
-    .bdrv_child_perm        =3D bdrv_format_default_perms,
+    .bdrv_child_perm        =3D bdrv_default_perms,
 };
=20
 static void coroutine_fn test_replace_child_mid_drain_read_co(void *opaque=
)
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 6ae91ff171..a2d0318b16 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -26,7 +26,7 @@
=20
 static BlockDriver bdrv_pass_through =3D {
     .format_name =3D "pass-through",
-    .bdrv_child_perm =3D bdrv_filter_default_perms,
+    .bdrv_child_perm =3D bdrv_default_perms,
 };
=20
 static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 0c861809f0..d928d2c6d9 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -481,8 +481,13 @@ static void test_propagate_basic(void)
     BlockDriverState *bs_a, *bs_b, *bs_verify;
     QDict *options;
=20
-    /* Create bs_a and its BlockBackend */
-    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
+    /*
+     * Create bs_a and its BlockBackend.  We cannot take the RESIZE
+     * permission because blkverify will not share it on the test
+     * image.
+     */
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL & ~BLK_PERM_RESIZ=
E,
+                  BLK_PERM_ALL);
     bs_a =3D bdrv_new_open_driver(&bdrv_test, "bs_a", BDRV_O_RDWR, &error_=
abort);
     blk_insert_bs(blk, bs_a, &error_abort);
=20
@@ -565,7 +570,13 @@ static void test_propagate_diamond(void)
     qdict_put_str(options, "raw", "bs_c");
=20
     bs_verify =3D bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort=
);
-    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
+    /*
+     * Do not take the RESIZE permission: This would require the same
+     * from bs_c and thus from bs_a; however, blkverify will not share
+     * it on bs_b, and thus it will not be available for bs_a.
+     */
+    blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL & ~BLK_PERM_RESIZ=
E,
+                  BLK_PERM_ALL);
     blk_insert_bs(blk, bs_verify, &error_abort);
=20
     /* Switch the AioContext */
--=20
2.23.0


