Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E744C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5005B2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVniiNmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5005B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1ib-0004a7-CR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hB-0002aU-61
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1h9-0001gj-53
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1h8-0001av-Qj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/f0cZ3XtsApd8wL5CbUS9lUmtpXiyfHiGST4zz7iy8=;
 b=AVniiNmMfX50spYpY6YnZCCD8o+v7wL3ip4+4M5U7mFgQU495k1n/2PQXT+MnuIxhf0E9R
 YV7sqURoqNwEGh4ljCbOwKpFR5K+jvbXTlnYGKcQbBDxlJRVafIV00T02tT9f26bYyjEGX
 fRKDnAFkut7qrSxz52NJgMxTwWiDGKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-8RfkD3NbOmyk4kWIN239GA-1; Tue, 04 Feb 2020 12:08:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447721336561;
 Tue,  4 Feb 2020 17:08:54 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C40819C69;
 Tue,  4 Feb 2020 17:08:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/33] block: Add BlockDriver.is_format
Date: Tue,  4 Feb 2020 18:08:16 +0100
Message-Id: <20200204170848.614480-2-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8RfkD3NbOmyk4kWIN239GA-1
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

We want to unify child_format and child_file at some point.  One of the
important things that set format drivers apart from other drivers is
that they do not expect other format nodes under them (except in the
backing chain).  That means we need something on which to distinguish
format drivers from others, and hence this flag.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/bochs.c             | 1 +
 block/cloop.c             | 1 +
 block/crypto.c            | 2 ++
 block/dmg.c               | 1 +
 block/parallels.c         | 1 +
 block/qcow.c              | 1 +
 block/qcow2.c             | 1 +
 block/qed.c               | 1 +
 block/raw-format.c        | 1 +
 block/vdi.c               | 1 +
 block/vhdx.c              | 1 +
 block/vmdk.c              | 1 +
 block/vpc.c               | 1 +
 include/block/block_int.h | 7 +++++++
 14 files changed, 21 insertions(+)

diff --git a/block/bochs.c b/block/bochs.c
index 32bb83b268..e7bbeaa1c4 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -301,6 +301,7 @@ static BlockDriver bdrv_bochs =3D {
     .bdrv_refresh_limits =3D bochs_refresh_limits,
     .bdrv_co_preadv =3D bochs_co_preadv,
     .bdrv_close=09=09=3D bochs_close,
+    .is_format          =3D true,
 };
=20
 static void bdrv_bochs_init(void)
diff --git a/block/cloop.c b/block/cloop.c
index 4de94876d4..f90f1a4b4c 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -297,6 +297,7 @@ static BlockDriver bdrv_cloop =3D {
     .bdrv_refresh_limits =3D cloop_refresh_limits,
     .bdrv_co_preadv =3D cloop_co_preadv,
     .bdrv_close     =3D cloop_close,
+    .is_format      =3D true,
 };
=20
 static void bdrv_cloop_init(void)
diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..b81f673a51 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -673,6 +673,8 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
=20
+    .is_format          =3D true,
+
     .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
 };
=20
diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..ef3c6e771d 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -753,6 +753,7 @@ static BlockDriver bdrv_dmg =3D {
     .bdrv_child_perm     =3D bdrv_format_default_perms,
     .bdrv_co_preadv =3D dmg_co_preadv,
     .bdrv_close     =3D dmg_close,
+    .is_format      =3D true,
 };
=20
 static void bdrv_dmg_init(void)
diff --git a/block/parallels.c b/block/parallels.c
index 7a01997659..30eda982bd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -910,6 +910,7 @@ static BlockDriver bdrv_parallels =3D {
     .bdrv_co_flush_to_os      =3D parallels_co_flush_to_os,
     .bdrv_co_readv  =3D parallels_co_readv,
     .bdrv_co_writev =3D parallels_co_writev,
+    .is_format      =3D true,
     .supports_backing =3D true,
     .bdrv_co_create      =3D parallels_co_create,
     .bdrv_co_create_opts =3D parallels_co_create_opts,
diff --git a/block/qcow.c b/block/qcow.c
index fce8989868..0e4f09934c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1184,6 +1184,7 @@ static BlockDriver bdrv_qcow =3D {
     .bdrv_co_create         =3D qcow_co_create,
     .bdrv_co_create_opts    =3D qcow_co_create_opts,
     .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
+    .is_format              =3D true,
     .supports_backing       =3D true,
     .bdrv_refresh_limits    =3D qcow_refresh_limits,
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index ef96606f8d..8e057556eb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5566,6 +5566,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_save_vmstate    =3D qcow2_save_vmstate,
     .bdrv_load_vmstate    =3D qcow2_load_vmstate,
=20
+    .is_format                  =3D true,
     .supports_backing           =3D true,
     .bdrv_change_backing_file   =3D qcow2_change_backing_file,
=20
diff --git a/block/qed.c b/block/qed.c
index d8c4e5fb1e..eb6139acbc 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1663,6 +1663,7 @@ static BlockDriver bdrv_qed =3D {
     .format_name              =3D "qed",
     .instance_size            =3D sizeof(BDRVQEDState),
     .create_opts              =3D &qed_create_opts,
+    .is_format                =3D true,
     .supports_backing         =3D true,
=20
     .bdrv_probe               =3D bdrv_qed_probe,
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a76ec7dd2..2429ff0d23 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -567,6 +567,7 @@ BlockDriver bdrv_raw =3D {
     .bdrv_co_copy_range_to  =3D &raw_co_copy_range_to,
     .bdrv_co_truncate     =3D &raw_co_truncate,
     .bdrv_getlength       =3D &raw_getlength,
+    .is_format            =3D true,
     .has_variable_length  =3D true,
     .bdrv_measure         =3D &raw_measure,
     .bdrv_get_info        =3D &raw_get_info,
diff --git a/block/vdi.c b/block/vdi.c
index 0142da7233..7e87b205b5 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -1051,6 +1051,7 @@ static BlockDriver bdrv_vdi =3D {
=20
     .bdrv_get_info =3D vdi_get_info,
=20
+    .is_format =3D true,
     .create_opts =3D &vdi_create_opts,
     .bdrv_co_check =3D vdi_co_check,
 };
diff --git a/block/vhdx.c b/block/vhdx.c
index f02d2611be..d3c1619026 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2241,6 +2241,7 @@ static BlockDriver bdrv_vhdx =3D {
     .bdrv_co_check          =3D vhdx_co_check,
     .bdrv_has_zero_init     =3D vhdx_has_zero_init,
=20
+    .is_format              =3D true,
     .create_opts            =3D &vhdx_create_opts,
 };
=20
diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d997..631fcd15ab 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -3058,6 +3058,7 @@ static BlockDriver bdrv_vmdk =3D {
     .bdrv_get_info                =3D vmdk_get_info,
     .bdrv_gather_child_options    =3D vmdk_gather_child_options,
=20
+    .is_format                    =3D true,
     .supports_backing             =3D true,
     .create_opts                  =3D &vmdk_create_opts,
 };
diff --git a/block/vpc.c b/block/vpc.c
index a65550298e..7cf0f87a16 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1248,6 +1248,7 @@ static BlockDriver bdrv_vpc =3D {
=20
     .bdrv_get_info          =3D vpc_get_info,
=20
+    .is_format              =3D true,
     .create_opts            =3D &vpc_create_opts,
     .bdrv_has_zero_init     =3D vpc_has_zero_init,
     .strong_runtime_opts    =3D vpc_strong_runtime_opts,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 589a797fab..7fb40281e4 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -94,6 +94,13 @@ struct BlockDriver {
      * must implement them and return -ENOTSUP.
      */
     bool is_filter;
+    /*
+     * Set to true if the BlockDriver is a format driver.  Format nodes
+     * generally do not expect their children to be other format nodes
+     * (except for backing files), and so format probing is disabled
+     * on those children.
+     */
+    bool is_format;
     /*
      * Return true if @to_replace can be replaced by a BDS with the
      * same data as @bs without it affecting @bs's behavior (that is,
--=20
2.24.1


