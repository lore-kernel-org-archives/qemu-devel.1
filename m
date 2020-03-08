Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0238DC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE192067C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE192067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1iY-0004x9-1o
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g5-0002M3-4Q
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g4-0006zS-2I
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:33 -0400
Received: from mailout03.t-online.de ([194.25.134.81]:34764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jB1g3-0006y8-O0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:32 -0400
Received: from fwd30.aul.t-online.de (fwd30.aul.t-online.de [172.20.26.135])
 by mailout03.t-online.de (Postfix) with SMTP id 3BF4B427E7BA;
 Sun,  8 Mar 2020 20:33:30 +0100 (CET)
Received: from linpower.localnet
 (bKrPuwZpghIMNnwLloP6R4aXGWFA3l4WO3GmYYVfqsj5gGep5BSwUkf0Y5u7mHrgLk@[79.208.31.100])
 by fwd30.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1g2-3QOuAq0; Sun, 8 Mar 2020 20:33:30 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 978482006CE; Sun,  8 Mar 2020 20:33:21 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 4/6] audio: change mixing engine float range to [-1.f, 1.f]
Date: Sun,  8 Mar 2020 20:33:19 +0100
Message-Id: <20200308193321.20668-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: bKrPuwZpghIMNnwLloP6R4aXGWFA3l4WO3GmYYVfqsj5gGep5BSwUkf0Y5u7mHrgLk
X-TOI-MSGID: 89289e91-17ab-489f-bae7-5654794d4ba6
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.81
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the internal float range of the mixing engine is
[-.5f, .5f]. PulseAudio, SDL2 and libasound use a [-1.f, 1.f]
range. This means with float samples the audio playback volume
is 6dB too low and audio recording signals will be clipped in
most cases.

To avoid another scaling factor in the conv_natural_float_* and
clip_natural_float_* functions with FLOAT_MIXENG defined this
patch changes the mixing engine float range to [-1.f, 1.f].

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/mixeng.c          |  4 ++--
 audio/mixeng_template.h | 17 ++++++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index 725b529be7..739a500449 100644
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
diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 77cc89b9e8..fc8e1d4d9e 100644
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
-    return ENDIAN_CONVERT ((IN_T) (v * ((mixeng_real) IN_MAX - IN_MIN)))=
;
+    return ENDIAN_CONVERT((IN_T)(v * (((mixeng_real)IN_MAX - IN_MIN) / 2=
.f)));
 #else
-    return ENDIAN_CONVERT ((IN_T) ((v * IN_MAX) + HALF));
+    return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HAL=
F));
 #endif
 }
=20
--=20
2.16.4


