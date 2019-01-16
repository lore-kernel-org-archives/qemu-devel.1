Received: from eggs.gnu.org ([209.51.188.92]:58319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul8-0004P0-1L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003SR-KV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul4-0003ND-7Y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id t27so8961186wra.6
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:38:05 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:17 +0100
Message-Id: <a5778e84daa6f06d99cd0fd90bc14856d8abcf15.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 44/50] audio: support more than two channels
 in volume setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h      | 10 ++++++++++
 audio/audio_int.h  |  4 ++--
 audio/audio.c      | 28 ++++++++++++++++++++--------
 audio/paaudio.c    | 20 ++++++++++++--------
 audio/spiceaudio.c | 14 ++++++++------
 5 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 2db27bba7b..bfb7ab2197 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -123,6 +123,16 @@ uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol);
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol);
 
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
index 6fec4f159c..cef749d647 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -165,7 +165,7 @@ struct audio_pcm_ops {
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
     void   (*enable_out)(HWVoiceOut *hw, bool enable);
-    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
+    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
@@ -174,7 +174,7 @@ struct audio_pcm_ops {
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
     void   (*enable_in)(HWVoiceIn *hw, bool enable);
-    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
+    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
 
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
diff --git a/audio/audio.c b/audio/audio.c
index db42d89dc3..a5ee0c4324 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1901,31 +1901,43 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
 }
 
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
+{
+    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
+    audio_set_volume_out(sw, &vol);
+}
+
+void audio_set_volume_out(SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
 
-        sw->vol.mute = mute;
-        sw->vol.l = nominal_volume.l * lvol / 255;
-        sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.mute = vol->mute;
+        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] / 255;
 
         if (hw->pcm_ops->volume_out) {
-            hw->pcm_ops->volume_out(hw, &sw->vol);
+            hw->pcm_ops->volume_out(hw, vol);
         }
     }
 }
 
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
+{
+    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
+    audio_set_volume_in(sw, &vol);
+}
+
+void audio_set_volume_in(SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
 
-        sw->vol.mute = mute;
-        sw->vol.l = nominal_volume.l * lvol / 255;
-        sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.mute = vol->mute;
+        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] / 255;
 
         if (hw->pcm_ops->volume_in) {
-            hw->pcm_ops->volume_in(hw, &sw->vol);
+            hw->pcm_ops->volume_in(hw, vol);
         }
     }
 }
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 01c5df278b..0d67c03b4c 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -537,20 +537,22 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
 
-static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
 {
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c = pa->g->conn;
+    int i;
 
 #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
 
-    v.channels = 2;
-    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
-    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+    v.channels = vol->channels;
+    for (i = 0; i < vol->channels; ++i) {
+        v.values[i] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i]) / 255;
+    }
 
     pa_threaded_mainloop_lock(c->mainloop);
 
@@ -577,20 +579,22 @@ static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
     pa_threaded_mainloop_unlock(c->mainloop);
 }
 
-static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
 {
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c = pa->g->conn;
+    int i;
 
 #ifdef PA_CHECK_VERSION
     pa_cvolume_init (&v);
 #endif
 
-    v.channels = 2;
-    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
-    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+    v.channels = vol->channels;
+    for (i = 0; i < vol->channels; ++i) {
+        v.values[i] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i]) / 255;
+    }
 
     pa_threaded_mainloop_lock(c->mainloop);
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 771ecacf27..b26d10434b 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -179,13 +179,14 @@ static void line_out_enable(HWVoiceOut *hw, bool enable)
 }
 
 #if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
     uint16_t svol[2];
 
-    svol[0] = vol->l / ((1ULL << 16) + 1);
-    svol[1] = vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels == 2);
+    svol[0] = vol->vol[0] * 257;
+    svol[1] = vol->vol[1] * 257;
     spice_server_playback_set_volume(&out->sin, 2, svol);
     spice_server_playback_set_mute(&out->sin, vol->mute);
 }
@@ -266,13 +267,14 @@ static void line_in_enable(HWVoiceIn *hw, bool enable)
 }
 
 #if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
-static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void line_in_volume(HWVoiceIn *hw, Volume *vol)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
     uint16_t svol[2];
 
-    svol[0] = vol->l / ((1ULL << 16) + 1);
-    svol[1] = vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels == 2);
+    svol[0] = vol->vol[0] * 257;
+    svol[1] = vol->vol[1] * 257;
     spice_server_record_set_volume(&in->sin, 2, svol);
     spice_server_record_set_mute(&in->sin, vol->mute);
 }
-- 
2.20.1
