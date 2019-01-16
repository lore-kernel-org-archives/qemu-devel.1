Received: from eggs.gnu.org ([209.51.188.92]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjulD-0004VZ-6c
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003RR-Do
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul3-0003JW-RB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r10so8917449wrs.10
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:38:02 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:13 +0100
Message-Id: <bc4fdf76b8fd8fde50bfd58116eb1a984ca9c01d.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 40/50] audio: split ctl_* functions into
 enable_* and volume_*
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

This way we no longer need vararg functions, improving compile time
error detection.  Also now it's possible to check actually what commands
are supported, without needing to manually update ctl_caps.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_int.h      |  15 ++---
 audio/audio_template.h |   1 -
 audio/alsaaudio.c      |  56 +++++++-----------
 audio/audio.c          |  45 +++++++++------
 audio/coreaudio.c      |  13 ++---
 audio/dsoundaudio.c    |  50 +++++++---------
 audio/noaudio.c        |  14 ++---
 audio/ossaudio.c       |  78 ++++++++++---------------
 audio/paaudio.c        | 126 ++++++++++++++++-------------------------
 audio/sdlaudio.c       |  17 +-----
 audio/spiceaudio.c     | 101 ++++++++++++++-------------------
 audio/wavaudio.c       |   7 +--
 12 files changed, 213 insertions(+), 310 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 236b523286..6fec4f159c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -72,7 +72,6 @@ typedef struct HWVoiceOut {
 
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceOut) entries;
 } HWVoiceOut;
@@ -93,7 +92,6 @@ typedef struct HWVoiceIn {
     size_t pos_emul, pending_emul, size_emul;
 
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceIn) entries;
 } HWVoiceIn;
@@ -145,7 +143,6 @@ struct audio_driver {
     int max_voices_in;
     int voice_size_out;
     int voice_size_in;
-    int ctl_caps;
     QLIST_ENTRY(audio_driver) next;
 };
 
@@ -167,7 +164,8 @@ struct audio_pcm_ops {
      * size may be smaller
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
-    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+    void   (*enable_out)(HWVoiceOut *hw, bool enable);
+    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
@@ -175,7 +173,8 @@ struct audio_pcm_ops {
     size_t (*buffer_size_in)(HWVoiceIn *hw);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
-    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    void   (*enable_in)(HWVoiceIn *hw, bool enable);
+    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
 };
 
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
@@ -251,12 +250,6 @@ void audio_rate_start(RateCtl *rate);
 size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
                             size_t bytes_avail);
 
-#define VOICE_ENABLE 1
-#define VOICE_DISABLE 2
-#define VOICE_VOLUME 3
-
-#define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
-
 static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >= src) ? (dst - src) : (len - src + dst);
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 07ce9ce51f..9ec565fc48 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -267,7 +267,6 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
 
     hw->s = s;
     hw->pcm_ops = drv->pcm_ops;
-    hw->ctl_caps = drv->ctl_caps;
 
     QLIST_INIT (&hw->sw_head);
 #ifdef DAC
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 1489f50dfd..446bb90ceb 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -744,34 +744,28 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
     return 0;
 }
 
-static int alsa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void alsa_enable_out(HWVoiceOut *hw, bool enable)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.alsa_out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = apdo->try_poll;
+    if (enable) {
+        bool poll_mode = apdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_out (hw)) {
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-            return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_PREPARE);
+        ldebug ("enabling voice\n");
+        if (poll_mode && alsa_poll_out (hw)) {
+            poll_mode = 0;
         }
-
-    case VOICE_DISABLE:
+        hw->poll_mode = poll_mode;
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PREPARE);
+    } else {
         ldebug ("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             alsa_fini_poll (&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_PAUSE);
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
 
 static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -860,35 +854,29 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
     return pos;
 }
 
-static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.alsa_in;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = apdo->try_poll;
+    if (enable) {
+        bool poll_mode = apdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_in (hw)) {
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-
-            return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_START);
+        ldebug ("enabling voice\n");
+        if (poll_mode && alsa_poll_in (hw)) {
+            poll_mode = 0;
         }
+        hw->poll_mode = poll_mode;
 
-    case VOICE_DISABLE:
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_START);
+    } else {
         ldebug ("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             alsa_fini_poll (&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_PAUSE);
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
 
 static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions **apdo,
@@ -949,13 +937,13 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .fini_out = alsa_fini_out,
     .buffer_size_out = alsa_buffer_size_out,
     .write    = alsa_write,
-    .ctl_out  = alsa_ctl_out,
+    .enable_out = alsa_enable_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
     .buffer_size_in = alsa_buffer_size_in,
     .read     = alsa_read,
-    .ctl_in   = alsa_ctl_in,
+    .enable_in = alsa_enable_in,
 };
 
 static struct audio_driver alsa_audio_driver = {
diff --git a/audio/audio.c b/audio/audio.c
index 798541638e..6bbbcd3e03 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -637,7 +637,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
         total += isamp;
     }
 
-    if (!(hw->ctl_caps & VOICE_VOLUME_CAP)) {
+    if (!hw->pcm_ops->volume_in) {
         mixeng_volume (sw->buf, ret, &sw->vol);
     }
 
@@ -724,7 +724,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     if (swlim) {
         sw->conv (sw->buf, buf, swlim);
 
-        if (!(sw->hw->ctl_caps & VOICE_VOLUME_CAP)) {
+        if (!sw->hw->pcm_ops->volume_out) {
             mixeng_volume (sw->buf, swlim, &sw->vol);
         }
     }
@@ -891,7 +891,9 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_out) {
+                        hw->pcm_ops->enable_out(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -936,7 +938,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -953,7 +957,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
                 if (nb_active == 1) {
                     hw->enabled = 0;
-                    hw->pcm_ops->ctl_in (hw, VOICE_DISABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, false);
+                    }
                 }
             }
         }
@@ -1101,7 +1107,9 @@ static void audio_run_out (AudioState *s)
 #endif
             hw->enabled = 0;
             hw->pending_disable = 0;
-            hw->pcm_ops->ctl_out (hw, VOICE_DISABLE);
+            if (hw->pcm_ops->enable_out) {
+                hw->pcm_ops->enable_out(hw, false);
+            }
             for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
                 sc->sw.active = 0;
                 audio_recalc_and_notify_capture (sc->cap);
@@ -1464,15 +1472,18 @@ static void audio_vm_change_state_handler (void *opaque, int running,
     AudioState *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
-    int op = running ? VOICE_ENABLE : VOICE_DISABLE;
 
     s->vm_running = running;
     while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
-        hwo->pcm_ops->ctl_out(hwo, op);
+        if (hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, running);
+        }
     }
 
     while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
-        hwi->pcm_ops->ctl_in(hwi, op);
+        if (hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, running);
+        }
     }
     audio_reset_timer (s);
 }
@@ -1492,8 +1503,8 @@ static void free_audio_state(AudioState *s)
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
 
-        if (hwo->enabled) {
-            hwo->pcm_ops->ctl_out (hwo, VOICE_DISABLE);
+        if (hwo->enabled && hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, false);
         }
         hwo->pcm_ops->fini_out (hwo);
 
@@ -1509,8 +1520,8 @@ static void free_audio_state(AudioState *s)
     }
 
     QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
-        if (hwi->enabled) {
-            hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
+        if (hwi->enabled && hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, false);
         }
         hwi->pcm_ops->fini_in (hwi);
         QLIST_REMOVE(hwi, entries);
@@ -1848,8 +1859,8 @@ void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
 
-        if (hw->pcm_ops->ctl_out) {
-            hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_out) {
+            hw->pcm_ops->volume_out(hw, &sw->vol);
         }
     }
 }
@@ -1863,8 +1874,8 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
 
-        if (hw->pcm_ops->ctl_in) {
-            hw->pcm_ops->ctl_in (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_in) {
+            hw->pcm_ops->volume_in(hw, &sw->vol);
         }
     }
 }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 693f6f11d7..508bee19d4 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -655,13 +655,12 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
     }
 }
 
-static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void coreaudio_enable_out (HWVoiceOut *hw, bool enable)
 {
     OSStatus status;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         /* start playback */
         if (!isPlaying(core->outputDeviceID)) {
             status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
@@ -669,9 +668,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 coreaudio_logerr (status, "Could not resume playback\n");
             }
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         /* stop playback */
         if (!audio_is_cleaning_up()) {
             if (isPlaying(core->outputDeviceID)) {
@@ -682,9 +679,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 }
             }
         }
-        break;
     }
-    return 0;
 }
 
 static void *coreaudio_audio_init(Audiodev *dev)
@@ -703,7 +698,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .buffer_size_out = coreaudio_buffer_size_out,
     .get_buffer_out = coreaudio_get_buffer_out,
     .put_buffer_out = coreaudio_put_buffer_out_nowrite,
-    .ctl_out  = coreaudio_ctl_out
+    .enable_out = coreaudio_enable_out
 };
 
 static struct audio_driver coreaudio_audio_driver = {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index e030bb29b5..da9276c268 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -363,7 +363,7 @@ static int dsound_open (dsound *s)
     return 0;
 }
 
-static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void dsound_enable_out(HWVoiceOut *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -373,18 +373,17 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
 
     if (!dsb) {
         dolog ("Attempt to control voice without a buffer\n");
-        return 0;
+        return;
     }
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_out (dsb, &status, s)) {
-            return -1;
+            return;
         }
 
         if (status & DSBSTATUS_PLAYING) {
             dolog ("warning: Voice is already playing\n");
-            return 0;
+            return;
         }
 
         dsound_clear_sample (hw, dsb, s);
@@ -392,28 +391,24 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
         hr = IDirectSoundBuffer_Play (dsb, 0, 0, DSBPLAY_LOOPING);
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
 
         if (status & DSBSTATUS_PLAYING) {
             hr = IDirectSoundBuffer_Stop (dsb);
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
 
 static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
@@ -463,7 +458,7 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
     return len;
 }
 
-static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void dsound_enable_in(HWVoiceIn *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -472,18 +467,17 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
 
     if (!dscb) {
         dolog ("Attempt to control capture voice without a buffer\n");
-        return -1;
+        return;
     }
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_in (dscb, &status)) {
-            return -1;
+            return;
         }
 
         if (status & DSCBSTATUS_CAPTURING) {
             dolog ("warning: Voice is already capturing\n");
-            return 0;
+            return;
         }
 
         /* clear ?? */
@@ -491,28 +485,24 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
         hr = IDirectSoundCaptureBuffer_Start (dscb, DSCBSTART_LOOPING);
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
 
         if (status & DSCBSTATUS_CAPTURING) {
             hr = IDirectSoundCaptureBuffer_Stop (dscb);
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
 
 static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
@@ -677,7 +667,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .buffer_size_out = dsound_buffer_size_out,
     .get_buffer_out = dsound_get_buffer_out,
     .put_buffer_out = dsound_put_buffer_out,
-    .ctl_out  = dsound_ctl_out,
+    .enable_out = dsound_enable_out,
 
     .init_in  = dsound_init_in,
     .fini_in  = dsound_fini_in,
@@ -685,7 +675,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .buffer_size_in = dsound_buffer_size_in,
     .get_buffer_in = dsound_get_buffer_in,
     .put_buffer_in = dsound_put_buffer_in,
-    .ctl_in   = dsound_ctl_in
+    .enable_in = dsound_enable_in,
 };
 
 static struct audio_driver dsound_audio_driver = {
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b29929dac4..c8bcfa9bca 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -60,14 +60,13 @@ static void no_fini_out (HWVoiceOut *hw)
     (void) hw;
 }
 
-static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void no_enable_out(HWVoiceOut *hw, bool enable)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
 
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -93,14 +92,13 @@ static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
     return bytes;
 }
 
-static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void no_enable_in(HWVoiceIn *hw, bool enable)
 {
     NoVoiceIn *no = (NoVoiceIn *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
 
 static void *no_audio_init(Audiodev *dev)
@@ -117,12 +115,12 @@ static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
     .write    = no_write,
-    .ctl_out  = no_ctl_out,
+    .enable_out = no_enable_out,
 
     .init_in  = no_init_in,
     .fini_in  = no_fini_in,
     .read     = no_read,
-    .ctl_in   = no_ctl_in
+    .enable_in = no_enable_in
 };
 
 static struct audio_driver no_audio_driver = {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index a93f97aa63..f12d8a95bd 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -570,59 +570,50 @@ static size_t oss_buffer_size_out(HWVoiceOut *hw)
     return oss->samples;
 }
 
-static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void oss_enable_out(HWVoiceOut *hw, bool enable)
 {
     int trig;
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.oss_out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = opdo->try_poll;
+    if (enable) {
+        bool poll_mode = opdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode) {
-                oss_poll_out (hw);
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-
-            if (!oss->mmapped) {
-                return 0;
-            }
+        ldebug ("enabling voice\n");
+        if (poll_mode) {
+            oss_poll_out (hw);
+            poll_mode = 0;
+        }
+        hw->poll_mode = poll_mode;
 
-            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->size);
-            trig = PCM_ENABLE_OUTPUT;
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
 
-    case VOICE_DISABLE:
+        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->size);
+        trig = PCM_ENABLE_OUTPUT;
+        if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
+            oss_logerr(errno,
+                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n");
+            return;
+        }
+    } else {
         if (hw->poll_mode) {
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
             hw->poll_mode = 0;
         }
 
         if (!oss->mmapped) {
-            return 0;
+            return;
         }
 
         ldebug ("disabling voice\n");
         trig = 0;
         if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
-            return -1;
+            return;
         }
-        break;
     }
-    return 0;
 }
 
 static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -715,32 +706,25 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
     return pos;
 }
 
-static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void oss_enable_in(HWVoiceIn *hw, bool enable)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.oss_out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = opdo->try_poll;
+    if (enable) {
+        bool poll_mode = opdo->try_poll;
 
-            if (poll_mode) {
-                oss_poll_in (hw);
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
+        if (poll_mode) {
+            oss_poll_in (hw);
+            poll_mode = 0;
         }
-        break;
-
-    case VOICE_DISABLE:
+        hw->poll_mode = poll_mode;
+    } else {
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
         }
-        break;
     }
-    return 0;
 }
 
 static void oss_init_per_direction(AudiodevOssPerDirectionOptions **opdo,
@@ -786,13 +770,13 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .buffer_size_out = oss_buffer_size_out,
     .get_buffer_out = oss_get_buffer_out,
     .put_buffer_out = oss_put_buffer_out,
-    .ctl_out  = oss_ctl_out,
+    .enable_out = oss_enable_out,
 
     .init_in  = oss_init_in,
     .fini_in  = oss_fini_in,
     .read     = oss_read,
     .buffer_size_in = oss_buffer_size_in,
-    .ctl_in   = oss_ctl_in
+    .enable_in = oss_enable_in
 };
 
 static struct audio_driver oss_audio_driver = {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index cfa4e895c7..a45469066b 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -458,7 +458,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
 
-static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
 {
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     pa_operation *op;
@@ -469,48 +469,36 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
 
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceOut *sw;
-            va_list ap;
+    v.channels = 2;
+    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
+    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
 
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceOut *);
-            va_end (ap);
+    pa_threaded_mainloop_lock(c->mainloop);
 
-            v.channels = 2;
-            v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
-            v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op = pa_context_set_sink_input_volume(c->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
-            if (!op)
-                qpa_logerr (pa_context_errno(c->context),
-                            "set_sink_input_volume() failed\n");
-            else
-                pa_operation_unref (op);
-
-            op = pa_context_set_sink_input_mute(c->context,
-                pa_stream_get_index (pa->stream),
-               sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr (pa_context_errno(c->context),
-                            "set_sink_input_mute() failed\n");
-            } else {
-                pa_operation_unref (op);
-            }
+    op = pa_context_set_sink_input_volume(c->context,
+                                          pa_stream_get_index(pa->stream),
+                                          &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_sink_input_volume() failed\n");
+    } else {
+        pa_operation_unref (op);
+    }
 
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    op = pa_context_set_sink_input_mute(c->context,
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
 
-static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
 {
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     pa_operation *op;
@@ -521,46 +509,33 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     pa_cvolume_init (&v);
 #endif
 
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceIn *sw;
-            va_list ap;
+    v.channels = 2;
+    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
+    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
 
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceIn *);
-            va_end (ap);
+    pa_threaded_mainloop_lock(c->mainloop);
 
-            v.channels = 2;
-            v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
-            v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op = pa_context_set_source_output_volume(c->context,
-                pa_stream_get_index(pa->stream),
-                &v, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_volume() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            op = pa_context_set_source_output_mute(c->context,
-                pa_stream_get_index (pa->stream),
-                sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_mute() failed\n");
-            } else {
-                pa_operation_unref (op);
-            }
+    op = pa_context_set_source_output_volume(c->context,
+        pa_stream_get_index(pa->stream),
+        &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_volume() failed\n");
+    } else {
+        pa_operation_unref(op);
+    }
 
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    op = pa_context_set_source_output_mute(c->context,
+        pa_stream_get_index(pa->stream),
+        vol->mute, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_mute() failed\n");
+    } else {
+        pa_operation_unref (op);
     }
-    return 0;
+
+    pa_threaded_mainloop_unlock(c->mainloop);
 }
 
 /* common */
@@ -708,13 +683,13 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
     .buffer_size_out = qpa_buffer_size_out,
-    .ctl_out  = qpa_ctl_out,
+    .volume_out = qpa_volume_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .read     = qpa_read,
     .buffer_size_in = qpa_buffer_size_in,
-    .ctl_in   = qpa_ctl_in
+    .volume_in = qpa_volume_in
 };
 
 static struct audio_driver pa_audio_driver = {
@@ -728,7 +703,6 @@ static struct audio_driver pa_audio_driver = {
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (PAVoiceOut),
     .voice_size_in  = sizeof (PAVoiceIn),
-    .ctl_caps       = VOICE_VOLUME_CAP
 };
 
 static void register_audio_pa(void)
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 4df35ce31a..93554df119 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -378,20 +378,9 @@ static size_t sdl_buffer_size_out(HWVoiceOut *hw)
     return sdl->samples;
 }
 
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
 
 static void *sdl_audio_init(Audiodev *dev)
@@ -449,7 +438,7 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .buffer_size_out = sdl_buffer_size_out,
     .get_buffer_out = sdl_get_buffer_out,
     .put_buffer_out = sdl_put_buffer_out_nowrite,
-    .ctl_out  = sdl_ctl_out,
+    .enable_out = sdl_enable_out,
 };
 
 static struct audio_driver sdl_audio_driver = {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 2495866c82..771ecacf27 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -153,22 +153,20 @@ static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
     return size;
 }
 
-static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
+static void line_out_enable(HWVoiceOut *hw, bool enable)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (out->active) {
-            break;
+            return;
         }
         out->active = 1;
         audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!out->active) {
-            break;
+            return;
         }
         out->active = 0;
         if (out->frame) {
@@ -177,29 +175,21 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
             out->frame = NULL;
         }
         spice_server_playback_stop (&out->sin);
-        break;
-    case VOICE_VOLUME:
-        {
+    }
+}
+
 #if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-            SWVoiceOut *sw;
-            va_list ap;
-            uint16_t vol[2];
+static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
+    uint16_t svol[2];
 
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceOut *);
-            va_end (ap);
-
-            vol[0] = sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] = sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_playback_set_volume (&out->sin, 2, vol);
-            spice_server_playback_set_mute (&out->sin, sw->vol.mute);
+    svol[0] = vol->l / ((1ULL << 16) + 1);
+    svol[1] = vol->r / ((1ULL << 16) + 1);
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
 
 /* record */
 
@@ -255,48 +245,38 @@ static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
     return ready << 2;
 }
 
-static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
+static void line_in_enable(HWVoiceIn *hw, bool enable)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (in->active) {
-            break;
+            return;
         }
         in->active = 1;
         audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!in->active) {
-            break;
+            return;
         }
         in->active = 0;
         spice_server_record_stop (&in->sin);
-        break;
-    case VOICE_VOLUME:
-        {
+    }
+}
+
 #if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
-            SWVoiceIn *sw;
-            va_list ap;
-            uint16_t vol[2];
+static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
+    uint16_t svol[2];
 
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceIn *);
-            va_end (ap);
-
-            vol[0] = sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] = sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_record_set_volume (&in->sin, 2, vol);
-            spice_server_record_set_mute (&in->sin, sw->vol.mute);
+    svol[0] = vol->l / ((1ULL << 16) + 1);
+    svol[1] = vol->r / ((1ULL << 16) + 1);
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
 
 static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
@@ -305,13 +285,19 @@ static struct audio_pcm_ops audio_callbacks = {
     .buffer_size_out = line_out_buffer_size,
     .get_buffer_out = line_out_get_buffer,
     .put_buffer_out = line_out_put_buffer,
-    .ctl_out  = line_out_ctl,
+    .enable_out = line_out_enable,
+#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
+    .volume_out = line_out_volume,
+#endif
 
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
     .read     = line_in_read,
     .buffer_size_in = line_in_buffer_size,
-    .ctl_in   = line_in_ctl,
+    .enable_in = line_in_enable,
+#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
+    .volume_in = line_in_volume,
+#endif
 };
 
 static struct audio_driver spice_audio_driver = {
@@ -324,9 +310,6 @@ static struct audio_driver spice_audio_driver = {
     .max_voices_in  = 1,
     .voice_size_out = sizeof (SpiceVoiceOut),
     .voice_size_in  = sizeof (SpiceVoiceIn),
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-    .ctl_caps       = VOICE_VOLUME_CAP
-#endif
 };
 
 void qemu_spice_audio_init (void)
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index f977d96b9c..672d5fc337 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -170,14 +170,13 @@ static void wav_fini_out (HWVoiceOut *hw)
     wav->f = NULL;
 }
 
-static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void wav_enable_out(HWVoiceOut *hw, bool enable)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&wav->rate);
     }
-    return 0;
 }
 
 static void *wav_audio_init(Audiodev *dev)
@@ -195,7 +194,7 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
     .write    = wav_write_out,
-    .ctl_out  = wav_ctl_out,
+    .enable_out = wav_enable_out,
 };
 
 static struct audio_driver wav_audio_driver = {
-- 
2.20.1
