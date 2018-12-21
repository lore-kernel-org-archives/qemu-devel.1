Received: from eggs.gnu.org ([2001:4830:134:3::10]:60947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSX0-00010q-Vl
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSWz-0008QG-Cl
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:40:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gaSWz-0008PV-7D
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:40:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id m22so7030139wml.3
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:40:29 -0800 (PST)
Received: from localhost ([91.201.22.4]) by smtp.gmail.com with ESMTPSA id
	o5sm20010347wmg.25.2018.12.21.13.40.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 21 Dec 2018 13:40:27 -0800 (PST)
Message-Id: <d2d7e46b7faa704dd8e85e92079aae57e0721301.1545426882.git.yaroslav.isakov@gmail.com>
In-Reply-To: <cover.1545426882.git.yaroslav.isakov@gmail.com>
References: <cover.1545426882.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Fri, 21 Dec 2018 01:21:55 +0100
Subject: [Qemu-devel] [PATCH 1/3] Allow audio driver to pass DB value to
 underlying drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
---
 audio/audio.c               | 15 +++++++++++++--
 audio/audio.h               |  6 ++++--
 audio/mixeng.h              |  6 ++++--
 hw/audio/ac97.c             |  4 ++--
 hw/audio/hda-codec-common.h |  2 +-
 hw/audio/hda-codec.c        |  8 ++++++--
 hw/audio/lm4549.c           |  2 +-
 hw/audio/wm8750.c           | 18 ++++++++++++------
 hw/display/xlnx_dp.c        |  3 ++-
 hw/usb/dev-audio.c          |  6 ++++--
 10 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 1ace47f510..939958d154 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -146,6 +146,9 @@ const struct mixeng_volume nominal_volume = {
     .r = 1ULL << 32,
     .l = 1ULL << 32,
 #endif
+    .db_known = false,
+    .r_db = 0,
+    .l_db = 0
 };
 
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
@@ -2089,7 +2092,8 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
     }
 }
 
-void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
+void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol,
+                         bool db_known, double lvol_db, double rvol_db)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -2097,6 +2101,9 @@ void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.mute = mute;
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.db_known = db_known;
+        sw->vol.l_db = lvol_db;
+        sw->vol.r_db = rvol_db;
 
         if (hw->pcm_ops->ctl_out) {
             hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
@@ -2104,7 +2111,8 @@ void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
     }
 }
 
-void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
+void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol,
+                        bool db_known, double lvol_db, double rvol_db)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
@@ -2112,6 +2120,9 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.mute = mute;
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.db_known = db_known;
+        sw->vol.l_db = lvol_db;
+        sw->vol.r_db = rvol_db;
 
         if (hw->pcm_ops->ctl_in) {
             hw->pcm_ops->ctl_in (hw, VOICE_VOLUME, sw);
diff --git a/audio/audio.h b/audio/audio.h
index f4339a185e..5fe3841a74 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -117,8 +117,10 @@ int  AUD_is_active_out (SWVoiceOut *sw);
 void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 
-void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol);
-void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol);
+void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol,
+                         bool db_known, double lvol_db, double rvol_db);
+void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol,
+                        bool db_known, double lvol_db, double rvol_db);
 
 SWVoiceIn *AUD_open_in (
     QEMUSoundCard *card,
diff --git a/audio/mixeng.h b/audio/mixeng.h
index b53a5ef99a..e66f6c0e0a 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -27,10 +27,12 @@
 
 #ifdef FLOAT_MIXENG
 typedef float mixeng_real;
-struct mixeng_volume { int mute; mixeng_real r; mixeng_real l; };
+struct mixeng_volume { int mute; mixeng_real r; mixeng_real l;
+                       bool db_known; double r_db; double l_db; };
 struct st_sample { mixeng_real l; mixeng_real r; };
 #else
-struct mixeng_volume { int mute; int64_t r; int64_t l; };
+struct mixeng_volume { int mute; int64_t r; int64_t l;
+                       bool db_known; double r_db; double l_db;};
 struct st_sample { int64_t l; int64_t r; };
 #endif
 
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index d799533aa9..051f62acd9 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -470,7 +470,7 @@ static void update_combined_volume_out (AC97LinkState *s)
     lvol = (lvol * plvol) / 255;
     rvol = (rvol * prvol) / 255;
 
-    AUD_set_volume_out (s->voice_po, mute, lvol, rvol);
+    AUD_set_volume_out (s->voice_po, mute, lvol, rvol, false, 0, 0);
 }
 
 static void update_volume_in (AC97LinkState *s)
@@ -481,7 +481,7 @@ static void update_volume_in (AC97LinkState *s)
     get_volume (mixer_load (s, AC97_Record_Gain_Mute), 0x0f, 0,
                 &mute, &lvol, &rvol);
 
-    AUD_set_volume_in (s->voice_pi, mute, lvol, rvol);
+    AUD_set_volume_in (s->voice_pi, mute, lvol, rvol, false, 0, 0);
 }
 
 static void set_volume (AC97LinkState *s, int index, uint32_t val)
diff --git a/hw/audio/hda-codec-common.h b/hw/audio/hda-codec-common.h
index b4fdb51e8b..59cbb7224e 100644
--- a/hw/audio/hda-codec-common.h
+++ b/hw/audio/hda-codec-common.h
@@ -32,7 +32,7 @@
     (AC_AMPCAP_MUTE |                                                   \
      (QEMU_HDA_AMP_STEPS << AC_AMPCAP_OFFSET_SHIFT)    |                \
      (QEMU_HDA_AMP_STEPS << AC_AMPCAP_NUM_STEPS_SHIFT) |                \
-     (3                  << AC_AMPCAP_STEP_SIZE_SHIFT))
+     (QEMU_HDA_AMP_STEP_SIZE << AC_AMPCAP_STEP_SIZE_SHIFT))
 #else
 #define QEMU_HDA_ID_OUTPUT  ((QEMU_HDA_ID_VENDOR << 16) | 0x11)
 #define QEMU_HDA_ID_DUPLEX  ((QEMU_HDA_ID_VENDOR << 16) | 0x21)
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 617a1c1016..09f9da344b 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -119,6 +119,8 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
                               0x1fc /* 16 -> 96 kHz */)
 #define QEMU_HDA_AMP_NONE    (0)
 #define QEMU_HDA_AMP_STEPS   0x4a
+#define QEMU_HDA_AMP_STEP_SIZE 3
+#define QEMU_HDA_AMP_DB_OF_STEP ((QEMU_HDA_AMP_STEP_SIZE + 1) * 0.25)
 
 #define   PARAM mixemu
 #define   HDA_MIXER
@@ -451,9 +453,11 @@ static void hda_audio_set_amp(HDAAudioStream *st)
         return;
     }
     if (st->output) {
-        AUD_set_volume_out(st->voice.out, muted, left, right);
+        AUD_set_volume_out(st->voice.out, muted, left, right,
+                           false, 0, 0);
     } else {
-        AUD_set_volume_in(st->voice.in, muted, left, right);
+        AUD_set_volume_in(st->voice.in, muted, left, right,
+                          false, 0, 0);
     }
 }
 
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index a46f2301af..6f0d0328c5 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -304,7 +304,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque)
         &as
     );
 
-    AUD_set_volume_out(s->voice, 0, 255, 255);
+    AUD_set_volume_out(s->voice, 0, 255, 255, false, 0, 0);
 
     s->voice_is_active = 0;
 
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index f4aa838f62..8127e3d440 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -144,30 +144,36 @@ static void wm8750_vol_update(WM8750State *s)
 
     AUD_set_volume_in(s->adc_voice[0], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
+                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]),
+                    false, 0, 0);
     AUD_set_volume_in(s->adc_voice[1], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
+                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]),
+                    false, 0, 0);
     AUD_set_volume_in(s->adc_voice[2], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
+                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]),
+                    false, 0, 0);
 
     /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
 
     /* Speaker: LOUT2VOL ROUT2VOL */
     AUD_set_volume_out(s->dac_voice[0], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
+                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]),
+                    false, 0, 0);
 
     /* Headphone: LOUT1VOL ROUT1VOL */
     AUD_set_volume_out(s->dac_voice[1], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
+                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]),
+                    false, 0, 0);
 
     /* MONOOUT: MONOVOL MONOVOL */
     AUD_set_volume_out(s->dac_voice[2], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
+                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
+                    false, 0, 0);
 }
 
 static void wm8750_set_format(WM8750State *s)
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index cc0f9bc9cc..948e05810b 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1271,7 +1271,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
                                            s,
                                            xlnx_dp_audio_callback,
                                            &as);
-    AUD_set_volume_out(s->amixer_output_stream, 0, 255, 255);
+    AUD_set_volume_out(s->amixer_output_stream, 0, 255, 255,
+                       false, 0, 0);
     xlnx_dp_audio_activate(s);
 }
 
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index ee43e4914d..355205f554 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -500,7 +500,8 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
                     s->out.mute, s->out.vol[0], s->out.vol[1]);
         }
         AUD_set_volume_out(s->out.voice, s->out.mute,
-                           s->out.vol[0], s->out.vol[1]);
+                           s->out.vol[0], s->out.vol[1],
+                           false, 0, 0);
     }
 
     return ret;
@@ -653,7 +654,8 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
 
     s->out.voice = AUD_open_out(&s->card, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
-    AUD_set_volume_out(s->out.voice, s->out.mute, s->out.vol[0], s->out.vol[1]);
+    AUD_set_volume_out(s->out.voice, s->out.mute, s->out.vol[0], s->out.vol[1],
+                       false, 0, 0);
     AUD_set_active_out(s->out.voice, 0);
 }
 
-- 
2.18.1
