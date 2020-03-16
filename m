Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97627C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EB72073C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTRjw5Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EB72073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDp07-0000Rw-6U
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDnwv-00021u-DZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDnwt-0000u8-40
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDnws-0000kN-Rd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mE4yFR491f4j8PDDbu5efgbzaxaT645qB190m9RUtLA=;
 b=PTRjw5Y6OMpMtrNWeaP4LwswEf36zqzNUilB/OQsYdgxR8mOIEkU7YvtMseaBqMHFMcLFf
 PrPJ2iTS6bp26uxdDYCeZHUY2U0fVBnjT5rT06ky6axEoxviAIf1tLRWqLE5iEcpZ4LXxi
 njbmZReYF2h/Y1daDO0m8/a4JCGDjpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-w1VAybSwOH6gU_-jpZ2bPw-1; Mon, 16 Mar 2020 07:30:20 -0400
X-MC-Unique: w1VAybSwOH6gU_-jpZ2bPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E21A800D4E;
 Mon, 16 Mar 2020 11:30:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8638FC1E;
 Mon, 16 Mar 2020 11:30:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A73359CA5; Mon, 16 Mar 2020 12:30:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] audio: change mixing engine float range to [-1.f, 1.f]
Date: Mon, 16 Mar 2020 12:30:13 +0100
Message-Id: <20200316113015.28013-5-kraxel@redhat.com>
In-Reply-To: <20200316113015.28013-1-kraxel@redhat.com>
References: <20200316113015.28013-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Currently the internal float range of the mixing engine is
[-.5f, .5f]. PulseAudio, SDL2 and libasound use a [-1.f, 1.f]
range. This means with float samples the audio playback volume
is 6dB too low and audio recording signals will be clipped in
most cases.

To avoid another scaling factor in the conv_natural_float_* and
clip_natural_float_* functions with FLOAT_MIXENG defined this
patch changes the mixing engine float range to [-1.f, 1.f].

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200308193321.20668-4-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/mixeng_template.h | 17 ++++++++---------
 audio/mixeng.c          |  4 ++--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 77cc89b9e808..fc8e1d4d9ebf 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -41,32 +41,31 @@ static inline mixeng_real glue (conv_, ET) (IN_T v)
=20
 #ifdef RECIPROCAL
 #ifdef SIGNED
-    return nv * (1.f / (mixeng_real) (IN_MAX - IN_MIN));
+    return nv * (2.f / ((mixeng_real)IN_MAX - IN_MIN));
 #else
-    return (nv - HALF) * (1.f / (mixeng_real) IN_MAX);
+    return (nv - HALF) * (2.f / (mixeng_real)IN_MAX);
 #endif
 #else  /* !RECIPROCAL */
 #ifdef SIGNED
-    return nv / (mixeng_real) ((mixeng_real) IN_MAX - IN_MIN);
+    return nv / (((mixeng_real)IN_MAX - IN_MIN) / 2.f);
 #else
-    return (nv - HALF) / (mixeng_real) IN_MAX;
+    return (nv - HALF) / ((mixeng_real)IN_MAX / 2.f);
 #endif
 #endif
 }
=20
 static inline IN_T glue (clip_, ET) (mixeng_real v)
 {
-    if (v >=3D 0.5) {
+    if (v >=3D 1.f) {
         return IN_MAX;
-    }
-    else if (v < -0.5) {
+    } else if (v < -1.f) {
         return IN_MIN;
     }
=20
 #ifdef SIGNED
-    return ENDIAN_CONVERT ((IN_T) (v * ((mixeng_real) IN_MAX - IN_MIN)));
+    return ENDIAN_CONVERT((IN_T)(v * (((mixeng_real)IN_MAX - IN_MIN) / 2.f=
)));
 #else
-    return ENDIAN_CONVERT ((IN_T) ((v * IN_MAX) + HALF));
+    return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF)=
);
 #endif
 }
=20
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 725b529be7da..739a500449ce 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -271,11 +271,11 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
 #define CONV_NATURAL_FLOAT(x) (x)
 #define CLIP_NATURAL_FLOAT(x) (x)
 #else
-static const float float_scale =3D UINT_MAX;
+static const float float_scale =3D UINT_MAX / 2.f;
 #define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
=20
 #ifdef RECIPROCAL
-static const float float_scale_reciprocal =3D 1.f / UINT_MAX;
+static const float float_scale_reciprocal =3D 2.f / UINT_MAX;
 #define CLIP_NATURAL_FLOAT(x) ((x) * float_scale_reciprocal)
 #else
 #define CLIP_NATURAL_FLOAT(x) ((x) / float_scale)
--=20
2.18.2


