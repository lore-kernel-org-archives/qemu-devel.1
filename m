Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E311C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5326920665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeU6-0004JK-GJ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeBK-0003l0-FP
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeBF-0000vr-D3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeBE-0000uf-Tm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E10893082133;
 Tue, 24 Sep 2019 06:20:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19CDA5D9DC;
 Tue, 24 Sep 2019 06:19:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3E7629C7F; Tue, 24 Sep 2019 08:19:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] audio: split ctl_* functions into enable_* and volume_*
Date: Tue, 24 Sep 2019 08:19:51 +0200
Message-Id: <20190924061951.27916-17-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 24 Sep 2019 06:20:06 +0000 (UTC)
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

This way we no longer need vararg functions, improving compile time
error detection.  Also now it's possible to check actually what commands
are supported, without needing to manually update ctl_caps.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 2b08b3773569c5be055d0a0fb2f29ff64e79f0f4.1568927990.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h      |  15 ++---
 audio/audio_template.h |   1 -
 audio/alsaaudio.c      |  62 ++++++++------------
 audio/audio.c          |  45 +++++++++------
 audio/coreaudio.c      |  13 ++---
 audio/dsoundaudio.c    |  50 +++++++---------
 audio/noaudio.c        |  14 ++---
 audio/ossaudio.c       |  79 ++++++++++---------------
 audio/paaudio.c        | 127 ++++++++++++++++-------------------------
 audio/sdlaudio.c       |  17 +-----
 audio/spiceaudio.c     | 102 ++++++++++++++-------------------
 audio/wavaudio.c       |   7 +--
 12 files changed, 217 insertions(+), 315 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 778615ccafa4..22a703c13e1c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -74,7 +74,6 @@ typedef struct HWVoiceOut {
     size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceOut) entries;
 } HWVoiceOut;
@@ -96,7 +95,6 @@ typedef struct HWVoiceIn {
=20
     size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceIn) entries;
 } HWVoiceIn;
@@ -148,7 +146,6 @@ struct audio_driver {
     int max_voices_in;
     int voice_size_out;
     int voice_size_in;
-    int ctl_caps;
     QLIST_ENTRY(audio_driver) next;
 };
=20
@@ -168,14 +165,16 @@ struct audio_pcm_ops {
      * size may be smaller
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
-    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+    void   (*enable_out)(HWVoiceOut *hw, bool enable);
+    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
=20
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque)=
;
     void   (*fini_in) (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
-    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    void   (*enable_in)(HWVoiceIn *hw, bool enable);
+    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
 };
=20
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
@@ -251,12 +250,6 @@ void audio_rate_start(RateCtl *rate);
 size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
                             size_t bytes_avail);
=20
-#define VOICE_ENABLE 1
-#define VOICE_DISABLE 2
-#define VOICE_VOLUME 3
-
-#define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
-
 static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >=3D src) ? (dst - src) : (len - src + dst);
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 87c6d2d27102..235d1acbbebb 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -254,7 +254,6 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
=20
     hw->s =3D s;
     hw->pcm_ops =3D drv->pcm_ops;
-    hw->ctl_caps =3D drv->ctl_caps;
=20
     QLIST_INIT (&hw->sw_head);
 #ifdef DAC
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 19124d09d845..cfe42284a6aa 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -731,34 +731,28 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const=
 char *typ, int ctl)
     return 0;
 }
=20
-static int alsa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void alsa_enable_out(HWVoiceOut *hw, bool enable)
 {
     ALSAVoiceOut *alsa =3D (ALSAVoiceOut *) hw;
     AudiodevAlsaPerDirectionOptions *apdo =3D alsa->dev->u.alsa.out;
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode =3D apdo->try_poll;
+    if (enable) {
+        bool poll_mode =3D apdo->try_poll;
=20
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_out (hw)) {
-                poll_mode =3D 0;
-            }
-            hw->poll_mode =3D poll_mode;
-            return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_P=
REPARE);
+        ldebug("enabling voice\n");
+        if (poll_mode && alsa_poll_out(hw)) {
+            poll_mode =3D 0;
         }
-
-    case VOICE_DISABLE:
-        ldebug ("disabling voice\n");
+        hw->poll_mode =3D poll_mode;
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PREPARE);
+    } else {
+        ldebug("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode =3D 0;
-            alsa_fini_poll (&alsa->pollhlp);
+            alsa_fini_poll(&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_PAUSE=
);
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
=20
 static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv=
_opaque)
@@ -841,35 +835,29 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, s=
ize_t len)
     return pos;
 }
=20
-static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 {
     ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
     AudiodevAlsaPerDirectionOptions *apdo =3D alsa->dev->u.alsa.in;
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode =3D apdo->try_poll;
+    if (enable) {
+        bool poll_mode =3D apdo->try_poll;
=20
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_in (hw)) {
-                poll_mode =3D 0;
-            }
-            hw->poll_mode =3D poll_mode;
-
-            return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_ST=
ART);
+        ldebug("enabling voice\n");
+        if (poll_mode && alsa_poll_in(hw)) {
+            poll_mode =3D 0;
         }
+        hw->poll_mode =3D poll_mode;
=20
-    case VOICE_DISABLE:
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_START);
+    } else {
         ldebug ("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode =3D 0;
-            alsa_fini_poll (&alsa->pollhlp);
+            alsa_fini_poll(&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_PAUSE)=
;
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
=20
 static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apd=
o)
@@ -924,12 +912,12 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
     .init_out =3D alsa_init_out,
     .fini_out =3D alsa_fini_out,
     .write    =3D alsa_write,
-    .ctl_out  =3D alsa_ctl_out,
+    .enable_out =3D alsa_enable_out,
=20
     .init_in  =3D alsa_init_in,
     .fini_in  =3D alsa_fini_in,
     .read     =3D alsa_read,
-    .ctl_in   =3D alsa_ctl_in,
+    .enable_in =3D alsa_enable_in,
 };
=20
 static struct audio_driver alsa_audio_driver =3D {
diff --git a/audio/audio.c b/audio/audio.c
index fab1e3571838..7128ee98dc97 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -636,7 +636,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *=
buf, size_t size)
         total +=3D isamp;
     }
=20
-    if (!(hw->ctl_caps & VOICE_VOLUME_CAP)) {
+    if (!hw->pcm_ops->volume_in) {
         mixeng_volume (sw->buf, ret, &sw->vol);
     }
=20
@@ -723,7 +723,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void=
 *buf, size_t size)
     if (swlim) {
         sw->conv (sw->buf, buf, swlim);
=20
-        if (!(sw->hw->ctl_caps & VOICE_VOLUME_CAP)) {
+        if (!sw->hw->pcm_ops->volume_out) {
             mixeng_volume (sw->buf, swlim, &sw->vol);
         }
     }
@@ -890,7 +890,9 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
             if (!hw->enabled) {
                 hw->enabled =3D 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_out) {
+                        hw->pcm_ops->enable_out(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -935,7 +937,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
             if (!hw->enabled) {
                 hw->enabled =3D 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -952,7 +956,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
=20
                 if (nb_active =3D=3D 1) {
                     hw->enabled =3D 0;
-                    hw->pcm_ops->ctl_in (hw, VOICE_DISABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, false);
+                    }
                 }
             }
         }
@@ -1105,7 +1111,9 @@ static void audio_run_out (AudioState *s)
 #endif
             hw->enabled =3D 0;
             hw->pending_disable =3D 0;
-            hw->pcm_ops->ctl_out (hw, VOICE_DISABLE);
+            if (hw->pcm_ops->enable_out) {
+                hw->pcm_ops->enable_out(hw, false);
+            }
             for (sc =3D hw->cap_head.lh_first; sc; sc =3D sc->entries.le=
_next) {
                 sc->sw.active =3D 0;
                 audio_recalc_and_notify_capture (sc->cap);
@@ -1470,15 +1478,18 @@ static void audio_vm_change_state_handler (void *=
opaque, int running,
     AudioState *s =3D opaque;
     HWVoiceOut *hwo =3D NULL;
     HWVoiceIn *hwi =3D NULL;
-    int op =3D running ? VOICE_ENABLE : VOICE_DISABLE;
=20
     s->vm_running =3D running;
     while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
-        hwo->pcm_ops->ctl_out(hwo, op);
+        if (hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, running);
+        }
     }
=20
     while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
-        hwi->pcm_ops->ctl_in(hwi, op);
+        if (hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, running);
+        }
     }
     audio_reset_timer (s);
 }
@@ -1498,8 +1509,8 @@ static void free_audio_state(AudioState *s)
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
=20
-        if (hwo->enabled) {
-            hwo->pcm_ops->ctl_out (hwo, VOICE_DISABLE);
+        if (hwo->enabled && hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, false);
         }
         hwo->pcm_ops->fini_out (hwo);
=20
@@ -1515,8 +1526,8 @@ static void free_audio_state(AudioState *s)
     }
=20
     QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
-        if (hwi->enabled) {
-            hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
+        if (hwi->enabled && hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, false);
         }
         hwi->pcm_ops->fini_in (hwi);
         QLIST_REMOVE(hwi, entries);
@@ -1838,8 +1849,8 @@ void AUD_set_volume_out (SWVoiceOut *sw, int mute, =
uint8_t lvol, uint8_t rvol)
         sw->vol.l =3D nominal_volume.l * lvol / 255;
         sw->vol.r =3D nominal_volume.r * rvol / 255;
=20
-        if (hw->pcm_ops->ctl_out) {
-            hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_out) {
+            hw->pcm_ops->volume_out(hw, &sw->vol);
         }
     }
 }
@@ -1853,8 +1864,8 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, ui=
nt8_t lvol, uint8_t rvol)
         sw->vol.l =3D nominal_volume.l * lvol / 255;
         sw->vol.r =3D nominal_volume.r * rvol / 255;
=20
-        if (hw->pcm_ops->ctl_in) {
-            hw->pcm_ops->ctl_in (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_in) {
+            hw->pcm_ops->volume_in(hw, &sw->vol);
         }
     }
 }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 5cde42f9826c..1427c9f622d9 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -648,13 +648,12 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
     }
 }
=20
-static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
     OSStatus status;
     coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         /* start playback */
         if (!isPlaying(core->outputDeviceID)) {
             status =3D AudioDeviceStart(core->outputDeviceID, core->iopr=
ocid);
@@ -662,9 +661,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd=
, ...)
                 coreaudio_logerr (status, "Could not resume playback\n")=
;
             }
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         /* stop playback */
         if (!audio_is_cleaning_up()) {
             if (isPlaying(core->outputDeviceID)) {
@@ -675,9 +672,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd=
, ...)
                 }
             }
         }
-        break;
     }
-    return 0;
 }
=20
 static void *coreaudio_audio_init(Audiodev *dev)
@@ -695,7 +690,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops =3D {
     .write    =3D coreaudio_write,
     .get_buffer_out =3D coreaudio_get_buffer_out,
     .put_buffer_out =3D coreaudio_put_buffer_out_nowrite,
-    .ctl_out  =3D coreaudio_ctl_out
+    .enable_out =3D coreaudio_enable_out
 };
=20
 static struct audio_driver coreaudio_audio_driver =3D {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 9960247814c7..d4a4757445b0 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -361,7 +361,7 @@ static int dsound_open (dsound *s)
     return 0;
 }
=20
-static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void dsound_enable_out(HWVoiceOut *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -371,18 +371,17 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd,=
 ...)
=20
     if (!dsb) {
         dolog ("Attempt to control voice without a buffer\n");
-        return 0;
+        return;
     }
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_out (dsb, &status, s)) {
-            return -1;
+            return;
         }
=20
         if (status & DSBSTATUS_PLAYING) {
             dolog ("warning: Voice is already playing\n");
-            return 0;
+            return;
         }
=20
         dsound_clear_sample (hw, dsb, s);
@@ -390,28 +389,24 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd,=
 ...)
         hr =3D IDirectSoundBuffer_Play (dsb, 0, 0, DSBPLAY_LOOPING);
         if (FAILED (hr)) {
             dsound_logerr (hr, "Could not start playing buffer\n");
-            return -1;
+            return;
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         if (dsound_get_status_out (dsb, &status, s)) {
-            return -1;
+            return;
         }
=20
         if (status & DSBSTATUS_PLAYING) {
             hr =3D IDirectSoundBuffer_Stop (dsb);
             if (FAILED (hr)) {
                 dsound_logerr (hr, "Could not stop playing buffer\n");
-                return -1;
+                return;
             }
         }
         else {
             dolog ("warning: Voice is not playing\n");
         }
-        break;
     }
-    return 0;
 }
=20
 static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
@@ -461,7 +456,7 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, v=
oid *buf, size_t len)
     return len;
 }
=20
-static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void dsound_enable_in(HWVoiceIn *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -470,18 +465,17 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, .=
..)
=20
     if (!dscb) {
         dolog ("Attempt to control capture voice without a buffer\n");
-        return -1;
+        return;
     }
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_in (dscb, &status)) {
-            return -1;
+            return;
         }
=20
         if (status & DSCBSTATUS_CAPTURING) {
             dolog ("warning: Voice is already capturing\n");
-            return 0;
+            return;
         }
=20
         /* clear ?? */
@@ -489,28 +483,24 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, .=
..)
         hr =3D IDirectSoundCaptureBuffer_Start (dscb, DSCBSTART_LOOPING)=
;
         if (FAILED (hr)) {
             dsound_logerr (hr, "Could not start capturing\n");
-            return -1;
+            return;
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         if (dsound_get_status_in (dscb, &status)) {
-            return -1;
+            return;
         }
=20
         if (status & DSCBSTATUS_CAPTURING) {
             hr =3D IDirectSoundCaptureBuffer_Stop (dscb);
             if (FAILED (hr)) {
                 dsound_logerr (hr, "Could not stop capturing\n");
-                return -1;
+                return;
             }
         }
         else {
             dolog ("warning: Voice is not capturing\n");
         }
-        break;
     }
-    return 0;
 }
=20
 static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
@@ -674,14 +664,14 @@ static struct audio_pcm_ops dsound_pcm_ops =3D {
     .write    =3D audio_generic_write,
     .get_buffer_out =3D dsound_get_buffer_out,
     .put_buffer_out =3D dsound_put_buffer_out,
-    .ctl_out  =3D dsound_ctl_out,
+    .enable_out =3D dsound_enable_out,
=20
     .init_in  =3D dsound_init_in,
     .fini_in  =3D dsound_fini_in,
     .read     =3D audio_generic_read,
     .get_buffer_in =3D dsound_get_buffer_in,
     .put_buffer_in =3D dsound_put_buffer_in,
-    .ctl_in   =3D dsound_ctl_in
+    .enable_in =3D dsound_enable_in,
 };
=20
 static struct audio_driver dsound_audio_driver =3D {
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 9f1cc67df942..ec8a287f3689 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -62,14 +62,13 @@ static void no_fini_out (HWVoiceOut *hw)
     (void) hw;
 }
=20
-static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void no_enable_out(HWVoiceOut *hw, bool enable)
 {
     NoVoiceOut *no =3D (NoVoiceOut *) hw;
=20
-    if (cmd =3D=3D VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
=20
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_o=
paque)
@@ -96,14 +95,13 @@ static size_t no_read(HWVoiceIn *hw, void *buf, size_=
t size)
     return bytes;
 }
=20
-static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void no_enable_in(HWVoiceIn *hw, bool enable)
 {
     NoVoiceIn *no =3D (NoVoiceIn *) hw;
=20
-    if (cmd =3D=3D VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
=20
 static void *no_audio_init(Audiodev *dev)
@@ -120,12 +118,12 @@ static struct audio_pcm_ops no_pcm_ops =3D {
     .init_out =3D no_init_out,
     .fini_out =3D no_fini_out,
     .write    =3D no_write,
-    .ctl_out  =3D no_ctl_out,
+    .enable_out =3D no_enable_out,
=20
     .init_in  =3D no_init_in,
     .fini_in  =3D no_fini_in,
     .read     =3D no_read,
-    .ctl_in   =3D no_ctl_in
+    .enable_in =3D no_enable_in
 };
=20
 static struct audio_driver no_audio_driver =3D {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 76c082d5e2a5..0c4451e972de 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -563,60 +563,50 @@ static int oss_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
     return 0;
 }
=20
-static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void oss_enable_out(HWVoiceOut *hw, bool enable)
 {
     int trig;
     OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode =3D opdo->try_poll;
+    if (enable) {
+        bool poll_mode =3D opdo->try_poll;
=20
-            ldebug ("enabling voice\n");
-            if (poll_mode) {
-                oss_poll_out (hw);
-                poll_mode =3D 0;
-            }
-            hw->poll_mode =3D poll_mode;
-
-            if (!oss->mmapped) {
-                return 0;
-            }
+        ldebug("enabling voice\n");
+        if (poll_mode) {
+            oss_poll_out(hw);
+            poll_mode =3D 0;
+        }
+        hw->poll_mode =3D poll_mode;
=20
-            audio_pcm_info_clear_buf(
-                &hw->info, hw->buf_emul, hw->mix_buf->size);
-            trig =3D PCM_ENABLE_OUTPUT;
-            if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
-                oss_logerr (
-                    errno,
-                    "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n"
-                    );
-                return -1;
-            }
+        if (!oss->mmapped) {
+            return;
         }
-        break;
=20
-    case VOICE_DISABLE:
+        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->s=
ize);
+        trig =3D PCM_ENABLE_OUTPUT;
+        if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
+            oss_logerr(errno,
+                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n=
");
+            return;
+        }
+    } else {
         if (hw->poll_mode) {
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
             hw->poll_mode =3D 0;
         }
=20
         if (!oss->mmapped) {
-            return 0;
+            return;
         }
=20
         ldebug ("disabling voice\n");
         trig =3D 0;
         if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
-            return -1;
+            return;
         }
-        break;
     }
-    return 0;
 }
=20
 static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_=
opaque)
@@ -703,32 +693,25 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, si=
ze_t len)
     return pos;
 }
=20
-static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void oss_enable_in(HWVoiceIn *hw, bool enable)
 {
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
     AudiodevOssPerDirectionOptions *opdo =3D oss->dev->u.oss.out;
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode =3D opdo->try_poll;
+    if (enable) {
+        bool poll_mode =3D opdo->try_poll;
=20
-            if (poll_mode) {
-                oss_poll_in (hw);
-                poll_mode =3D 0;
-            }
-            hw->poll_mode =3D poll_mode;
+        if (poll_mode) {
+            oss_poll_in(hw);
+            poll_mode =3D 0;
         }
-        break;
-
-    case VOICE_DISABLE:
+        hw->poll_mode =3D poll_mode;
+    } else {
         if (hw->poll_mode) {
             hw->poll_mode =3D 0;
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
         }
-        break;
     }
-    return 0;
 }
=20
 static void oss_init_per_direction(AudiodevOssPerDirectionOptions *opdo)
@@ -767,12 +750,12 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
     .write    =3D oss_write,
     .get_buffer_out =3D oss_get_buffer_out,
     .put_buffer_out =3D oss_put_buffer_out,
-    .ctl_out  =3D oss_ctl_out,
+    .enable_out =3D oss_enable_out,
=20
     .init_in  =3D oss_init_in,
     .fini_in  =3D oss_fini_in,
     .read     =3D oss_read,
-    .ctl_in   =3D oss_ctl_in
+    .enable_in =3D oss_enable_in
 };
=20
 static struct audio_driver oss_audio_driver =3D {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 75fce5320269..ed31f863f7fe 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -452,7 +452,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
=20
-static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
 {
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
     pa_operation *op;
@@ -463,49 +463,36 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ..=
.)
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
=20
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceOut *sw;
-            va_list ap;
+    v.channels =3D 2;
+    v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT=
32_MAX;
+    v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT=
32_MAX;
=20
-            va_start (ap, cmd);
-            sw =3D va_arg (ap, SWVoiceOut *);
-            va_end (ap);
+    pa_threaded_mainloop_lock(c->mainloop);
=20
-            v.channels =3D 2;
-            v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
-            v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op =3D pa_context_set_sink_input_volume(c->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_sink_input_volume() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            op =3D pa_context_set_sink_input_mute(c->context,
-                pa_stream_get_index (pa->stream),
-               sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_sink_input_mute() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
+    op =3D pa_context_set_sink_input_volume(c->context,
+                                          pa_stream_get_index(pa->stream=
),
+                                          &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_sink_input_volume() failed\n");
+    } else {
+        pa_operation_unref(op);
+    }
=20
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    op =3D pa_context_set_sink_input_mute(c->context,
+                                        pa_stream_get_index(pa->stream),
+                                        vol->mute, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_sink_input_mute() failed\n");
+    } else {
+        pa_operation_unref(op);
     }
-    return 0;
+
+    pa_threaded_mainloop_unlock(c->mainloop);
 }
=20
-static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
 {
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
     pa_operation *op;
@@ -516,46 +503,33 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     pa_cvolume_init (&v);
 #endif
=20
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceIn *sw;
-            va_list ap;
+    v.channels =3D 2;
+    v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT=
32_MAX;
+    v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT=
32_MAX;
=20
-            va_start (ap, cmd);
-            sw =3D va_arg (ap, SWVoiceIn *);
-            va_end (ap);
+    pa_threaded_mainloop_lock(c->mainloop);
=20
-            v.channels =3D 2;
-            v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
-            v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op =3D pa_context_set_source_output_volume(c->context,
-                pa_stream_get_index(pa->stream),
-                &v, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_volume() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            op =3D pa_context_set_source_output_mute(c->context,
-                pa_stream_get_index (pa->stream),
-                sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_mute() failed\n");
-            } else {
-                pa_operation_unref (op);
-            }
+    op =3D pa_context_set_source_output_volume(c->context,
+        pa_stream_get_index(pa->stream),
+        &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_volume() failed\n");
+    } else {
+        pa_operation_unref(op);
+    }
=20
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    op =3D pa_context_set_source_output_mute(c->context,
+        pa_stream_get_index(pa->stream),
+        vol->mute, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_mute() failed\n");
+    } else {
+        pa_operation_unref(op);
     }
-    return 0;
+
+    pa_threaded_mainloop_unlock(c->mainloop);
 }
=20
 static int qpa_validate_per_direction_opts(Audiodev *dev,
@@ -724,12 +698,12 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
     .init_out =3D qpa_init_out,
     .fini_out =3D qpa_fini_out,
     .write    =3D qpa_write,
-    .ctl_out  =3D qpa_ctl_out,
+    .volume_out =3D qpa_volume_out,
=20
     .init_in  =3D qpa_init_in,
     .fini_in  =3D qpa_fini_in,
     .read     =3D qpa_read,
-    .ctl_in   =3D qpa_ctl_in
+    .volume_in =3D qpa_volume_in
 };
=20
 static struct audio_driver pa_audio_driver =3D {
@@ -743,7 +717,6 @@ static struct audio_driver pa_audio_driver =3D {
     .max_voices_in  =3D INT_MAX,
     .voice_size_out =3D sizeof (PAVoiceOut),
     .voice_size_in  =3D sizeof (PAVoiceIn),
-    .ctl_caps       =3D VOICE_VOLUME_CAP
 };
=20
 static void register_audio_pa(void)
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index f7ac8cd10188..5c6bcfcb3e9d 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -285,20 +285,9 @@ static int sdl_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
     return 0;
 }
=20
-static int sdl_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void sdl_enable_out(HWVoiceOut *hw, bool enable)
 {
-    (void) hw;
-
-    switch (cmd) {
-    case VOICE_ENABLE:
-        SDL_PauseAudio (0);
-        break;
-
-    case VOICE_DISABLE:
-        SDL_PauseAudio (1);
-        break;
-    }
-    return 0;
+    SDL_PauseAudio(!enable);
 }
=20
 static void *sdl_audio_init(Audiodev *dev)
@@ -334,7 +323,7 @@ static struct audio_pcm_ops sdl_pcm_ops =3D {
     .write    =3D sdl_write,
     .get_buffer_out =3D sdl_get_buffer_out,
     .put_buffer_out =3D sdl_put_buffer_out_nowrite,
-    .ctl_out  =3D sdl_ctl_out,
+    .enable_out =3D sdl_enable_out,
 };
=20
 static struct audio_driver sdl_audio_driver =3D {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 4ce4f94c6dca..9860f9c5e16c 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -153,22 +153,20 @@ static size_t line_out_put_buffer(HWVoiceOut *hw, v=
oid *buf, size_t size)
     return size;
 }
=20
-static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
+static void line_out_enable(HWVoiceOut *hw, bool enable)
 {
     SpiceVoiceOut *out =3D container_of (hw, SpiceVoiceOut, hw);
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (out->active) {
-            break;
+            return;
         }
         out->active =3D 1;
         audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!out->active) {
-            break;
+            return;
         }
         out->active =3D 0;
         if (out->frame) {
@@ -177,29 +175,21 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, .=
..)
             out->frame =3D NULL;
         }
         spice_server_playback_stop (&out->sin);
-        break;
-    case VOICE_VOLUME:
-        {
+    }
+}
+
 #if ((SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && (SPICE_INTERFACE_PLAYBAC=
K_MINOR >=3D 2))
-            SWVoiceOut *sw;
-            va_list ap;
-            uint16_t vol[2];
+static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceOut *out =3D container_of(hw, SpiceVoiceOut, hw);
+    uint16_t svol[2];
=20
-            va_start (ap, cmd);
-            sw =3D va_arg (ap, SWVoiceOut *);
-            va_end (ap);
-
-            vol[0] =3D sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] =3D sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_playback_set_volume (&out->sin, 2, vol);
-            spice_server_playback_set_mute (&out->sin, sw->vol.mute);
+    svol[0] =3D vol->l / ((1ULL << 16) + 1);
+    svol[1] =3D vol->r / ((1ULL << 16) + 1);
+    spice_server_playback_set_volume(&out->sin, 2, svol);
+    spice_server_playback_set_mute(&out->sin, vol->mute);
+}
 #endif
-            break;
-        }
-    }
-
-    return 0;
-}
=20
 /* record */
=20
@@ -251,48 +241,38 @@ static size_t line_in_read(HWVoiceIn *hw, void *buf=
, size_t len)
     return ready << 2;
 }
=20
-static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
+static void line_in_enable(HWVoiceIn *hw, bool enable)
 {
     SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
=20
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (in->active) {
-            break;
+            return;
         }
         in->active =3D 1;
         audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!in->active) {
-            break;
+            return;
         }
         in->active =3D 0;
         spice_server_record_stop (&in->sin);
-        break;
-    case VOICE_VOLUME:
-        {
+    }
+}
+
 #if ((SPICE_INTERFACE_RECORD_MAJOR >=3D 2) && (SPICE_INTERFACE_RECORD_MI=
NOR >=3D 2))
-            SWVoiceIn *sw;
-            va_list ap;
-            uint16_t vol[2];
+static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceIn *in =3D container_of(hw, SpiceVoiceIn, hw);
+    uint16_t svol[2];
=20
-            va_start (ap, cmd);
-            sw =3D va_arg (ap, SWVoiceIn *);
-            va_end (ap);
-
-            vol[0] =3D sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] =3D sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_record_set_volume (&in->sin, 2, vol);
-            spice_server_record_set_mute (&in->sin, sw->vol.mute);
+    svol[0] =3D vol->l / ((1ULL << 16) + 1);
+    svol[1] =3D vol->r / ((1ULL << 16) + 1);
+    spice_server_record_set_volume(&in->sin, 2, svol);
+    spice_server_record_set_mute(&in->sin, vol->mute);
+}
 #endif
-            break;
-        }
-    }
-
-    return 0;
-}
=20
 static struct audio_pcm_ops audio_callbacks =3D {
     .init_out =3D line_out_init,
@@ -300,12 +280,19 @@ static struct audio_pcm_ops audio_callbacks =3D {
     .write    =3D audio_generic_write,
     .get_buffer_out =3D line_out_get_buffer,
     .put_buffer_out =3D line_out_put_buffer,
-    .ctl_out  =3D line_out_ctl,
+    .enable_out =3D line_out_enable,
+#if (SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && \
+        (SPICE_INTERFACE_PLAYBACK_MINOR >=3D 2)
+    .volume_out =3D line_out_volume,
+#endif
=20
     .init_in  =3D line_in_init,
     .fini_in  =3D line_in_fini,
     .read     =3D line_in_read,
-    .ctl_in   =3D line_in_ctl,
+    .enable_in =3D line_in_enable,
+#if ((SPICE_INTERFACE_RECORD_MAJOR >=3D 2) && (SPICE_INTERFACE_RECORD_MI=
NOR >=3D 2))
+    .volume_in =3D line_in_volume,
+#endif
 };
=20
 static struct audio_driver spice_audio_driver =3D {
@@ -318,9 +305,6 @@ static struct audio_driver spice_audio_driver =3D {
     .max_voices_in  =3D 1,
     .voice_size_out =3D sizeof (SpiceVoiceOut),
     .voice_size_in  =3D sizeof (SpiceVoiceIn),
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >=3D 1) && (SPICE_INTERFACE_PLAYBAC=
K_MINOR >=3D 2))
-    .ctl_caps       =3D VOICE_VOLUME_CAP
-#endif
 };
=20
 void qemu_spice_audio_init (void)
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 85f5ff9c28bc..47efdc1b1eab 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -173,14 +173,13 @@ static void wav_fini_out (HWVoiceOut *hw)
     wav->f =3D NULL;
 }
=20
-static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void wav_enable_out(HWVoiceOut *hw, bool enable)
 {
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
=20
-    if (cmd =3D=3D VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&wav->rate);
     }
-    return 0;
 }
=20
 static void *wav_audio_init(Audiodev *dev)
@@ -198,7 +197,7 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
     .init_out =3D wav_init_out,
     .fini_out =3D wav_fini_out,
     .write    =3D wav_write_out,
-    .ctl_out  =3D wav_ctl_out,
+    .enable_out =3D wav_enable_out,
 };
=20
 static struct audio_driver wav_audio_driver =3D {
--=20
2.18.1


