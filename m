Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD96C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE3F2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJw133Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE3F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1u1-00015K-2J
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1iH-0004Xx-KL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1iF-0004nb-MU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1iF-0004ln-I8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fTAw2LXpm6o2l3ULPUJv57IstJ7QE7w3tfRV1jzgTZs=;
 b=AJw133BuXoD11w3kZbFXsMtWue7VIYCqYb13Kyqfg9lNKO5jjWkbhJ04/pRenTlH1q6P0j
 nUIOgcG6Jxx0kzktBUa10TkJ16U6NhmUK293dW+iAAPFAJLaM2yVZPpEiTi1riU4E8cQOJ
 uprrSBr5k70nY5yX/BBADPcYuTf5PRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-9qyj_2RfOTK4J0OZXjLglw-1; Tue, 04 Feb 2020 12:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFC51085925;
 Tue,  4 Feb 2020 17:10:01 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 039A5867FE;
 Tue,  4 Feb 2020 17:10:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 24/33] block: Make format drivers use child_of_bds
Date: Tue,  4 Feb 2020 18:08:39 +0100
Message-Id: <20200204170848.614480-25-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9qyj_2RfOTK4J0OZXjLglw-1
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
 block/qcow2.c     | 19 +++++++++++++------
 block/qed.c       |  4 ++--
 block/vdi.c       |  4 ++--
 block/vhdx.c      |  4 ++--
 block/vmdk.c      | 20 +++++++++++++++++---
 block/vpc.c       |  4 ++--
 12 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index b013e73063..62c3f42548 100644
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
index 3ed9fa63cc..d374a8427d 100644
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
index 4da74a7737..2d85d9e70a 100644
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
index af8188638c..bc64194577 100644
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
index 3d5b3b7c63..7dc9a1fa76 100644
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
index 2bf8e8eb36..bc7f7c1054 100644
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
index 94e394d608..84d913eed1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1534,8 +1534,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
     }
=20
     /* Open external data file */
-    s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs, &chil=
d_file,
-                                   0, true, &local_err);
+    s->data_file =3D bdrv_open_child(NULL, options, "data-file", bs,
+                                   &child_of_bds, BDRV_CHILD_DATA,
+                                   true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -1545,8 +1546,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         if (!s->data_file && s->image_data_file) {
             s->data_file =3D bdrv_open_child(s->image_data_file, options,
-                                           "data-file", bs, &child_file, 0=
,
-                                           false, errp);
+                                           "data-file", bs, &child_of_bds,
+                                           BDRV_CHILD_DATA, false, errp);
             if (!s->data_file) {
                 ret =3D -EINVAL;
                 goto fail;
@@ -1557,6 +1558,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverSta=
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
@@ -1805,8 +1812,8 @@ static int qcow2_open(BlockDriverState *bs, QDict *op=
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
index d15ba11959..d6222798c2 100644
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
index 987e2ed592..1736d02eee 100644
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
index be23290ac8..d8a315015d 100644
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
index 84f99d881f..497414e5f2 100644
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
+        extent_role =3D BDRV_CHILD_DATA;
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
index 5378e32d1d..9acd6edac9 100644
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
2.24.1


