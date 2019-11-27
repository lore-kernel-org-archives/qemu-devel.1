Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E067620678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYzrlbFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E067620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxZN-0001bo-L7
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCB-0004MA-JU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxC9-00072S-H6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxC9-000720-CL
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpnf7A3bRGai3XjiqQd0xf68d651MGdOwTiuaDbZYtM=;
 b=fYzrlbFO5K7S0ITF4440E0LSBUzs1ap4ay/SBNZ9OcrSarSpMaq+nXepo7lyZFJlnu0t/8
 dF8XgBWJJ+AY26Q34OPCL7azTl9fzPBtFmjdGCS0wYoHwPJ3939+kg64TQmm5HeOfu5YTo
 s4Q80iXwVpjE5v8a/rty4v7tdnR3wm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-VEEpQCiKM0-JLX1Clh8M5A-1; Wed, 27 Nov 2019 08:17:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37EDE1010C26;
 Wed, 27 Nov 2019 13:17:20 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 941621001DE1;
 Wed, 27 Nov 2019 13:17:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 22/31] block: Make format drivers use child_of_bds
Date: Wed, 27 Nov 2019 14:16:15 +0100
Message-Id: <20191127131624.1062403-23-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VEEpQCiKM0-JLX1Clh8M5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Commonly, they need to pass the BDRV_CHILD_IMAGE set as the
BdrvChildRole; but there are exceptions for drivers with external data
files (qcow2 and vmdk).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/bochs.c     |  4 ++--
 block/cloop.c     |  4 ++--
 block/crypto.c    |  4 ++--
 block/dmg.c       |  4 ++--
 block/parallels.c |  4 ++--
 block/qcow.c      |  4 ++--
 block/qcow2.c     | 20 +++++++++++++++-----
 block/qed.c       |  4 ++--
 block/vdi.c       |  4 ++--
 block/vhdx.c      |  4 ++--
 block/vmdk.c      | 20 +++++++++++++++++---
 block/vpc.c       |  4 ++--
 12 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index cd399a4ad3..15f9807954 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -110,8 +110,8 @@ static int bochs_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
         return ret;
     }
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/cloop.c b/block/cloop.c
index 42a8b0f107..6662af7470 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -71,8 +71,8 @@ static int cloop_open(BlockDriverState *bs, QDict *option=
s, int flags,
         return ret;
     }
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 737042010a..b5e31aee6f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -200,8 +200,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat=
 format,
     unsigned int cflags =3D 0;
     QDict *cryptoopts =3D NULL;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/dmg.c b/block/dmg.c
index 9fcd59af8d..479d764d82 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -439,8 +439,8 @@ static int dmg_open(BlockDriverState *bs, QDict *option=
s, int flags,
         return ret;
     }
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/parallels.c b/block/parallels.c
index 769e4d0e29..8ff7bfcc40 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -728,8 +728,8 @@ static int parallels_open(BlockDriverState *bs, QDict *=
options, int flags,
     Error *local_err =3D NULL;
     char *buf;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 3138894eab..c81a687195 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -130,8 +130,8 @@ static int qcow_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     encryptfmt =3D qdict_get_try_str(encryptopts, "format");
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         ret =3D -EINVAL;
         goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 89a4e5a4e4..22d70ce62f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1535,8 +1535,10 @@ static int coroutine_fn qcow2_do_open(BlockDriverSta=
te *bs, QDict *options,
     }
=20
     /* Open external data file */
-    s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs, &chil=
d_file,
-                                   0, true, &local_err);
+    s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs,
+                                   &child_of_bds,
+                                   BDRV_CHILD_DATA | BDRV_CHILD_PROTOCOL,
+                                   true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -1546,7 +1548,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         if (!s->data_file && s->image_data_file) {
             s->data_file =3D bdrv_open_child(s->image_data_file, options,
-                                           "data-file", bs, &child_file, 0=
,
+                                           "data-file", bs, &child_of_bds,
+                                           BDRV_CHILD_DATA |
+                                           BDRV_CHILD_PROTOCOL,
                                            false, errp);
             if (!s->data_file) {
                 ret =3D -EINVAL;
@@ -1558,6 +1562,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverSta=
te *bs, QDict *options,
             ret =3D -EINVAL;
             goto fail;
         }
+
+        /* No data here */
+        bs->file->role &=3D ~BDRV_CHILD_DATA;
+
+        /* Must succeed because we have given up permissions if anything *=
/
+        bdrv_child_refresh_perms(bs, bs->file, &error_abort);
     } else {
         if (s->data_file) {
             error_setg(errp, "'data-file' can only be set for images with =
an "
@@ -1805,8 +1815,8 @@ static int qcow2_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         .ret =3D -EINPROGRESS
     };
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/qed.c b/block/qed.c
index 2c30287b3c..eaa042c426 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -547,8 +547,8 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
         .ret =3D -EINPROGRESS
     };
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vdi.c b/block/vdi.c
index 67eb41e45b..0046f7f332 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -378,8 +378,8 @@ static int vdi_open(BlockDriverState *bs, QDict *option=
s, int flags,
     Error *local_err =3D NULL;
     QemuUUID uuid_link, uuid_parent;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index 0ac1b45994..4c7bbd3d51 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -997,8 +997,8 @@ static int vhdx_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
     uint64_t signature;
     Error *local_err =3D NULL;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 468401ce0c..41e7cc0c8d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1089,6 +1089,7 @@ static int vmdk_parse_extents(const char *desc, Block=
DriverState *bs,
     char *desc_file_dir =3D NULL;
     char *extent_path;
     BdrvChild *extent_file;
+    BdrvChildRole extent_role;
     BDRVVmdkState *s =3D bs->opaque;
     VmdkExtent *extent;
     char extent_opt_prefix[32];
@@ -1151,8 +1152,15 @@ static int vmdk_parse_extents(const char *desc, Bloc=
kDriverState *bs,
         ret =3D snprintf(extent_opt_prefix, 32, "extents.%d", s->num_exten=
ts);
         assert(ret < 32);
=20
+        extent_role =3D BDRV_CHILD_DATA | BDRV_CHILD_PROTOCOL;
+        if (strcmp(type, "FLAT") !=3D 0 && strcmp(type, "VMFS") !=3D 0) {
+            /* non-flat extents have metadata */
+            extent_role |=3D BDRV_CHILD_METADATA;
+        }
+
         extent_file =3D bdrv_open_child(extent_path, options, extent_opt_p=
refix,
-                                      bs, &child_file, 0, false, &local_er=
r);
+                                      bs, &child_of_bds, extent_role, fals=
e,
+                                      &local_err);
         g_free(extent_path);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -1257,8 +1265,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     uint32_t magic;
     Error *local_err =3D NULL;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
@@ -1277,6 +1285,12 @@ static int vmdk_open(BlockDriverState *bs, QDict *op=
tions, int flags,
             s->desc_offset =3D 0x200;
             break;
         default:
+            /* No data in the descriptor file */
+            bs->file->role &=3D ~BDRV_CHILD_DATA;
+
+            /* Must succeed because we have given up permissions if anythi=
ng */
+            bdrv_child_refresh_perms(bs, bs->file, &error_abort);
+
             ret =3D vmdk_open_desc_file(bs, flags, buf, options, errp);
             break;
     }
diff --git a/block/vpc.c b/block/vpc.c
index 6748dc369b..8cb64beef7 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -228,8 +228,8 @@ static int vpc_open(BlockDriverState *bs, QDict *option=
s, int flags,
     int ret;
     int64_t bs_size;
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
--=20
2.23.0


