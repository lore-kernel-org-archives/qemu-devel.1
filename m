Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E0CA9EA3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A698221D80
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A698221D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMvK-0008Bg-M4
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-0006Ew-4X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtT-000723-8o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtS-00070m-PM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5C9CC08E2B0;
 Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 629535C1B2;
 Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 53A579AC3; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] audio: support more than two channels in volume setting
Date: Fri, 18 Oct 2019 09:41:38 +0200
Message-Id: <20191018074144.24071-8-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
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
Message-id: 5d3dd2ee3baaa62805e79c3901abb7415ae32461.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.h      | 10 ++++++++++
 audio/audio_int.h  |  4 ++--
 audio/audio.c      | 30 ++++++++++++++++++++++--------
 audio/paaudio.c    | 20 ++++++++++++--------
 audio/spiceaudio.c | 14 ++++++++------
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index c74abb8c4718..0db3c7dd5e06 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -124,6 +124,16 @@ uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, Q=
EMUAudioTimeStamp *ts);
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t=
 rvol);
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t r=
vol);
=20
+#define AUDIO_MAX_CHANNELS 16
+typedef struct Volume {
+    bool mute;
+    int channels;
+    uint8_t vol[AUDIO_MAX_CHANNELS];
+} Volume;
+
+void audio_set_volume_out(SWVoiceOut *sw, Volume *vol);
+void audio_set_volume_in(SWVoiceIn *sw, Volume *vol);
+
 SWVoiceIn *AUD_open_in (
     QEMUSoundCard *card,
     SWVoiceIn *sw,
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 22a703c13e1c..9176db249b23 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -166,7 +166,7 @@ struct audio_pcm_ops {
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
     void   (*enable_out)(HWVoiceOut *hw, bool enable);
-    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
+    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
=20
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque)=
;
     void   (*fini_in) (HWVoiceIn *hw);
@@ -174,7 +174,7 @@ struct audio_pcm_ops {
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
     void   (*enable_in)(HWVoiceIn *hw, bool enable);
-    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
+    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
=20
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
diff --git a/audio/audio.c b/audio/audio.c
index d616a4af98bd..f1c145dfcdeb 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1891,31 +1891,45 @@ void AUD_del_capture (CaptureVoiceOut *cap, void =
*cb_opaque)
 }
=20
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t=
 rvol)
+{
+    Volume vol =3D { .mute =3D mute, .channels =3D 2, .vol =3D { lvol, r=
vol } };
+    audio_set_volume_out(sw, &vol);
+}
+
+void audio_set_volume_out(SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw =3D sw->hw;
=20
-        sw->vol.mute =3D mute;
-        sw->vol.l =3D nominal_volume.l * lvol / 255;
-        sw->vol.r =3D nominal_volume.r * rvol / 255;
+        sw->vol.mute =3D vol->mute;
+        sw->vol.l =3D nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r =3D nominal_volume.l * vol->vol[vol->channels > 1 ? 1 =
: 0] /
+            255;
=20
         if (hw->pcm_ops->volume_out) {
-            hw->pcm_ops->volume_out(hw, &sw->vol);
+            hw->pcm_ops->volume_out(hw, vol);
         }
     }
 }
=20
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t r=
vol)
+{
+    Volume vol =3D { .mute =3D mute, .channels =3D 2, .vol =3D { lvol, r=
vol } };
+    audio_set_volume_in(sw, &vol);
+}
+
+void audio_set_volume_in(SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw =3D sw->hw;
=20
-        sw->vol.mute =3D mute;
-        sw->vol.l =3D nominal_volume.l * lvol / 255;
-        sw->vol.r =3D nominal_volume.r * rvol / 255;
+        sw->vol.mute =3D vol->mute;
+        sw->vol.l =3D nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r =3D nominal_volume.r * vol->vol[vol->channels > 1 ? 1 =
: 0] /
+            255;
=20
         if (hw->pcm_ops->volume_in) {
-            hw->pcm_ops->volume_in(hw, &sw->vol);
+            hw->pcm_ops->volume_in(hw, vol);
         }
     }
 }
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 77cd0bc0d026..292c8c9ff4c0 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -532,20 +532,22 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
=20
-static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
 {
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c =3D pa->g->conn;
+    int i;
=20
 #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
=20
-    v.channels =3D 2;
-    v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT=
32_MAX;
-    v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT=
32_MAX;
+    v.channels =3D vol->channels;
+    for (i =3D 0; i < vol->channels; ++i) {
+        v.values[i] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i=
]) / 255;
+    }
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
@@ -572,20 +574,22 @@ static void qpa_volume_out(HWVoiceOut *hw, struct m=
ixeng_volume *vol)
     pa_threaded_mainloop_unlock(c->mainloop);
 }
=20
-static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
 {
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c =3D pa->g->conn;
+    int i;
=20
 #ifdef PA_CHECK_VERSION
     pa_cvolume_init (&v);
 #endif
=20
-    v.channels =3D 2;
-    v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT=
32_MAX;
-    v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT=
32_MAX;
+    v.channels =3D vol->channels;
+    for (i =3D 0; i < vol->channels; ++i) {
+        v.values[i] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i=
]) / 255;
+    }
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 9860f9c5e16c..6ed7f7a79e39 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -179,13 +179,14 @@ static void line_out_enable(HWVoiceOut *hw, bool en=
able)
 }
=20
 #if ((SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && (SPICE_INTERFACE_PLAYBAC=
K_MINOR >=3D 2))
-static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 {
     SpiceVoiceOut *out =3D container_of(hw, SpiceVoiceOut, hw);
     uint16_t svol[2];
=20
-    svol[0] =3D vol->l / ((1ULL << 16) + 1);
-    svol[1] =3D vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels =3D=3D 2);
+    svol[0] =3D vol->vol[0] * 257;
+    svol[1] =3D vol->vol[1] * 257;
     spice_server_playback_set_volume(&out->sin, 2, svol);
     spice_server_playback_set_mute(&out->sin, vol->mute);
 }
@@ -262,13 +263,14 @@ static void line_in_enable(HWVoiceIn *hw, bool enab=
le)
 }
=20
 #if ((SPICE_INTERFACE_RECORD_MAJOR >=3D 2) && (SPICE_INTERFACE_RECORD_MI=
NOR >=3D 2))
-static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void line_in_volume(HWVoiceIn *hw, Volume *vol)
 {
     SpiceVoiceIn *in =3D container_of(hw, SpiceVoiceIn, hw);
     uint16_t svol[2];
=20
-    svol[0] =3D vol->l / ((1ULL << 16) + 1);
-    svol[1] =3D vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels =3D=3D 2);
+    svol[0] =3D vol->vol[0] * 257;
+    svol[1] =3D vol->vol[1] * 257;
     spice_server_record_set_volume(&in->sin, 2, svol);
     spice_server_record_set_mute(&in->sin, vol->mute);
 }
--=20
2.18.1


