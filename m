Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCBC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F4C20665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F4C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCePJ-0007kC-8Z
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeBA-0003bo-2H
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB7-0000s3-68
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB6-0000rK-Ms
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2A0013A82;
 Tue, 24 Sep 2019 06:19:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD79910018F8;
 Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EAFC79CA7; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] spiceaudio: port to the new audio backend api
Date: Tue, 24 Sep 2019 08:19:46 +0200
Message-Id: <20190924061951.27916-12-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 24 Sep 2019 06:19:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kővágó@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 4d3356df9ccbffee2f710b93d456443c81e3f011.1568927990.git.DirtY=
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


