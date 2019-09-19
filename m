Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C56A21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C56A21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAs9D-000464-OU
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvn-0005Ap-1r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvg-0000H7-EP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvg-0000GP-1X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19B653175295;
 Thu, 19 Sep 2019 08:36:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EFE0196AE;
 Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C0F239CAB; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:12 +0200
Message-Id: <20190919083629.29998-10-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 08:36:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/26] spiceaudio: port to the new audio backend
 api
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
Message-id: 71731ff2437028514284394de0f60d195d42e593.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/spiceaudio.c | 116 ++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 74 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 26873c7f22a5..ff4e4dcbb022 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -51,7 +51,7 @@ typedef struct SpiceVoiceOut {
     SpiceRateCtl          rate;
     int                   active;
     uint32_t              *frame;
-    uint32_t              *fpos;
+    uint32_t              fpos;
     uint32_t              fsize;
 } SpiceVoiceOut;
=20
@@ -60,7 +60,6 @@ typedef struct SpiceVoiceIn {
     SpiceRecordInstance   sin;
     SpiceRateCtl          rate;
     int                   active;
-    uint32_t              samples[LINE_IN_SAMPLES];
 } SpiceVoiceIn;
=20
 static const SpicePlaybackInterface playback_sif =3D {
@@ -152,44 +151,40 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
=20
-static size_t line_out_run (HWVoiceOut *hw, size_t live)
+static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
-    SpiceVoiceOut *out =3D container_of (hw, SpiceVoiceOut, hw);
-    size_t rpos, decr;
-    size_t samples;
+    SpiceVoiceOut *out =3D container_of(hw, SpiceVoiceOut, hw);
+    size_t decr;
=20
-    if (!live) {
-        return 0;
+    if (!out->frame) {
+        spice_server_playback_get_buffer(&out->sin, &out->frame, &out->f=
size);
+        out->fpos =3D 0;
     }
=20
-    decr =3D rate_get_samples (&hw->info, &out->rate);
-    decr =3D MIN (live, decr);
+    if (out->frame) {
+        decr =3D rate_get_samples(&hw->info, &out->rate);
+        decr =3D MIN(out->fsize - out->fpos, decr);
=20
-    samples =3D decr;
-    rpos =3D hw->rpos;
-    while (samples) {
-        int left_till_end_samples =3D hw->samples - rpos;
-        int len =3D MIN (samples, left_till_end_samples);
+        *size =3D decr << hw->info.shift;
+    } else {
+        rate_start(&out->rate);
+    }
+    return out->frame + out->fpos;
+}
+
+static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size=
)
+{
+    SpiceVoiceOut *out =3D container_of(hw, SpiceVoiceOut, hw);
=20
-        if (!out->frame) {
-            spice_server_playback_get_buffer (&out->sin, &out->frame, &o=
ut->fsize);
-            out->fpos =3D out->frame;
-        }
-        if (out->frame) {
-            len =3D MIN (len, out->fsize);
-            hw->clip (out->fpos, hw->mix_buf + rpos, len);
-            out->fsize -=3D len;
-            out->fpos  +=3D len;
-            if (out->fsize =3D=3D 0) {
-                spice_server_playback_put_samples (&out->sin, out->frame=
);
-                out->frame =3D out->fpos =3D NULL;
-            }
-        }
-        rpos =3D (rpos + len) % hw->samples;
-        samples -=3D len;
+    assert(buf =3D=3D out->frame + out->fpos && out->fpos <=3D out->fsiz=
e);
+    out->fpos +=3D size >> 2;
+
+    if (out->fpos =3D=3D out->fsize) { /* buffer full */
+        spice_server_playback_put_samples(&out->sin, out->frame);
+        out->frame =3D NULL;
     }
-    hw->rpos =3D rpos;
-    return decr;
+
+    return size;
 }
=20
 static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
@@ -211,9 +206,9 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...=
)
         }
         out->active =3D 0;
         if (out->frame) {
-            memset (out->fpos, 0, out->fsize << 2);
+            memset(out->frame + out->fpos, 0, (out->fsize - out->fpos) <=
< 2);
             spice_server_playback_put_samples (&out->sin, out->frame);
-            out->frame =3D out->fpos =3D NULL;
+            out->frame =3D NULL;
         }
         spice_server_playback_stop (&out->sin);
         break;
@@ -275,49 +270,20 @@ static void line_in_fini (HWVoiceIn *hw)
     spice_server_remove_interface (&in->sin.base);
 }
=20
-static size_t line_in_run(HWVoiceIn *hw)
+static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
-    size_t num_samples;
-    int ready;
-    size_t len[2];
-    uint64_t delta_samp;
-    const uint32_t *samples;
+    uint64_t delta_samp =3D rate_get_samples(&hw->info, &in->rate);
+    uint64_t to_read =3D MIN(len >> 2, delta_samp);
+    size_t ready =3D spice_server_record_get_samples(&in->sin, buf, to_r=
ead);
=20
-    if (!(num_samples =3D hw->samples - audio_pcm_hw_get_live_in (hw))) =
{
-        return 0;
-    }
-
-    delta_samp =3D rate_get_samples (&hw->info, &in->rate);
-    num_samples =3D MIN (num_samples, delta_samp);
-
-    ready =3D spice_server_record_get_samples (&in->sin, in->samples, nu=
m_samples);
-    samples =3D in->samples;
+    /* XXX: do we need this? */
     if (ready =3D=3D 0) {
-        static const uint32_t silence[LINE_IN_SAMPLES];
-        samples =3D silence;
-        ready =3D LINE_IN_SAMPLES;
+        memset(buf, 0, to_read << 2);
+        ready =3D to_read;
     }
=20
-    num_samples =3D MIN (ready, num_samples);
-
-    if (hw->wpos + num_samples > hw->samples) {
-        len[0] =3D hw->samples - hw->wpos;
-        len[1] =3D num_samples - len[0];
-    } else {
-        len[0] =3D num_samples;
-        len[1] =3D 0;
-    }
-
-    hw->conv (hw->conv_buf + hw->wpos, samples, len[0]);
-
-    if (len[1]) {
-        hw->conv (hw->conv_buf, samples + len[0], len[1]);
-    }
-
-    hw->wpos =3D (hw->wpos + num_samples) % hw->samples;
-
-    return num_samples;
+    return ready << 2;
 }
=20
 static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
@@ -366,12 +332,14 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...=
)
 static struct audio_pcm_ops audio_callbacks =3D {
     .init_out =3D line_out_init,
     .fini_out =3D line_out_fini,
-    .run_out  =3D line_out_run,
+    .write    =3D audio_generic_write,
+    .get_buffer_out =3D line_out_get_buffer,
+    .put_buffer_out =3D line_out_put_buffer,
     .ctl_out  =3D line_out_ctl,
=20
     .init_in  =3D line_in_init,
     .fini_in  =3D line_in_fini,
-    .run_in   =3D line_in_run,
+    .read     =3D line_in_read,
     .ctl_in   =3D line_in_ctl,
 };
=20
--=20
2.18.1


