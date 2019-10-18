Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780EBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E96821897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E96821897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN14-0005qg-LI
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtX-0006Gs-Rt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-00073m-Bu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtV-00072R-2E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1A45302C096;
 Fri, 18 Oct 2019 07:41:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFA15C1B2;
 Fri, 18 Oct 2019 07:41:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9556D31EC0; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] paaudio: fix channel order for usb-audio 5.1 and 7.1
 streams
Date: Fri, 18 Oct 2019 09:41:44 +0200
Message-Id: <20191018074144.24071-14-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 18 Oct 2019 07:41:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 2900e462d27bd73277ae083d037c32b1b4451ee2.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 292c8c9ff4c0..df541a72d3a9 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -339,17 +339,59 @@ static pa_stream *qpa_simple_new (
         pa_stream_direction_t dir,
         const char *dev,
         const pa_sample_spec *ss,
-        const pa_channel_map *map,
         const pa_buffer_attr *attr,
         int *rerror)
 {
     int r;
-    pa_stream *stream;
+    pa_stream *stream =3D NULL;
     pa_stream_flags_t flags;
+    pa_channel_map map;
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
-    stream =3D pa_stream_new(c->context, name, ss, map);
+    pa_channel_map_init(&map);
+    map.channels =3D ss->channels;
+
+    /*
+     * TODO: This currently expects the only frontend supporting more th=
an 2
+     * channels is the usb-audio.  We will need some means to set channe=
l
+     * order when a new frontend gains multi-channel support.
+     */
+    switch (ss->channels) {
+    case 1:
+        map.map[0] =3D PA_CHANNEL_POSITION_MONO;
+        break;
+
+    case 2:
+        map.map[0] =3D PA_CHANNEL_POSITION_LEFT;
+        map.map[1] =3D PA_CHANNEL_POSITION_RIGHT;
+        break;
+
+    case 6:
+        map.map[0] =3D PA_CHANNEL_POSITION_FRONT_LEFT;
+        map.map[1] =3D PA_CHANNEL_POSITION_FRONT_RIGHT;
+        map.map[2] =3D PA_CHANNEL_POSITION_CENTER;
+        map.map[3] =3D PA_CHANNEL_POSITION_LFE;
+        map.map[4] =3D PA_CHANNEL_POSITION_REAR_LEFT;
+        map.map[5] =3D PA_CHANNEL_POSITION_REAR_RIGHT;
+        break;
+
+    case 8:
+        map.map[0] =3D PA_CHANNEL_POSITION_FRONT_LEFT;
+        map.map[1] =3D PA_CHANNEL_POSITION_FRONT_RIGHT;
+        map.map[2] =3D PA_CHANNEL_POSITION_CENTER;
+        map.map[3] =3D PA_CHANNEL_POSITION_LFE;
+        map.map[4] =3D PA_CHANNEL_POSITION_REAR_LEFT;
+        map.map[5] =3D PA_CHANNEL_POSITION_REAR_RIGHT;
+        map.map[6] =3D PA_CHANNEL_POSITION_SIDE_LEFT;
+        map.map[7] =3D PA_CHANNEL_POSITION_SIDE_RIGHT;
+
+    default:
+        dolog("Internal error: unsupported channel count %d\n", ss->chan=
nels);
+        goto fail;
+    }
+
+    stream =3D pa_stream_new(c->context, name, ss, &map);
     if (!stream) {
         goto fail;
     }
@@ -422,7 +464,6 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
         &ba,                    /* buffering attributes */
         &error
         );
@@ -471,7 +512,6 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-        NULL,                   /* channel map */
         &ba,                    /* buffering attributes */
         &error
         );
--=20
2.18.1


