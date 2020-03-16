Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92844C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA37205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cpipz1As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA37205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpD1-0004ff-V2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDnwu-00021c-M1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDnwt-0000ty-1m
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDnws-0000md-RL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJxoln7e7LAPr0w6x0CSFvMFj00f8t79mjPRS95ptHM=;
 b=Cpipz1AsNSfYlOQ1OXdBeB7OqNedADxJ4RQObekJVwKezZtEAiTMkDcBVALsIbZFwQU8Ry
 gV7RNnXSbR5+4R/D/CpM5WFtL5q1hcsSxeM8kFzxYk7130NCStxaxW1LJJGzQdyYJIYYke
 lp3zj9WKkoNTxpEVaZYWD9vqHOVMu5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-XXtxCJIyM3uO3Fir5zYsiA-1; Mon, 16 Mar 2020 07:30:20 -0400
X-MC-Unique: XXtxCJIyM3uO3Fir5zYsiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CC9D107ACC9;
 Mon, 16 Mar 2020 11:30:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A6F891841;
 Mon, 16 Mar 2020 11:30:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94BB19D1F; Mon, 16 Mar 2020 12:30:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] audio: change naming scheme of FLOAT_CONV macros
Date: Mon, 16 Mar 2020 12:30:11 +0100
Message-Id: <20200316113015.28013-3-kraxel@redhat.com>
In-Reply-To: <20200316113015.28013-1-kraxel@redhat.com>
References: <20200316113015.28013-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

This patch changes the naming scheme of the FLOAT_CONV_TO and
FLOAT_CONV_FROM macros to the scheme used in mixeng_template.h.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200308193321.20668-2-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/mixeng.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index c14b0d874ce5..b57fad83bf3b 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -268,17 +268,17 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
 };
=20
 #ifdef FLOAT_MIXENG
-#define FLOAT_CONV_TO(x) (x)
-#define FLOAT_CONV_FROM(x) (x)
+#define CONV_NATURAL_FLOAT(x) (x)
+#define CLIP_NATURAL_FLOAT(x) (x)
 #else
 static const float float_scale =3D UINT_MAX;
-#define FLOAT_CONV_TO(x) ((x) * float_scale)
+#define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
=20
 #ifdef RECIPROCAL
 static const float float_scale_reciprocal =3D 1.f / UINT_MAX;
-#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)
+#define CLIP_NATURAL_FLOAT(x) ((x) * float_scale_reciprocal)
 #else
-#define FLOAT_CONV_FROM(x) ((x) / float_scale)
+#define CLIP_NATURAL_FLOAT(x) ((x) / float_scale)
 #endif
 #endif
=20
@@ -288,7 +288,7 @@ static void conv_natural_float_to_mono(struct st_sample=
 *dst, const void *src,
     float *in =3D (float *)src;
=20
     while (samples--) {
-        dst->r =3D dst->l =3D FLOAT_CONV_TO(*in++);
+        dst->r =3D dst->l =3D CONV_NATURAL_FLOAT(*in++);
         dst++;
     }
 }
@@ -299,8 +299,8 @@ static void conv_natural_float_to_stereo(struct st_samp=
le *dst, const void *src,
     float *in =3D (float *)src;
=20
     while (samples--) {
-        dst->l =3D FLOAT_CONV_TO(*in++);
-        dst->r =3D FLOAT_CONV_TO(*in++);
+        dst->l =3D CONV_NATURAL_FLOAT(*in++);
+        dst->r =3D CONV_NATURAL_FLOAT(*in++);
         dst++;
     }
 }
@@ -316,7 +316,7 @@ static void clip_natural_float_from_mono(void *dst, con=
st struct st_sample *src,
     float *out =3D (float *)dst;
=20
     while (samples--) {
-        *out++ =3D FLOAT_CONV_FROM(src->l) + FLOAT_CONV_FROM(src->r);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->l) + CLIP_NATURAL_FLOAT(src->r)=
;
         src++;
     }
 }
@@ -327,8 +327,8 @@ static void clip_natural_float_from_stereo(
     float *out =3D (float *)dst;
=20
     while (samples--) {
-        *out++ =3D FLOAT_CONV_FROM(src->l);
-        *out++ =3D FLOAT_CONV_FROM(src->r);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->l);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->r);
         src++;
     }
 }
--=20
2.18.2


