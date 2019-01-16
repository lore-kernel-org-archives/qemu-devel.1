Received: from eggs.gnu.org ([209.51.188.92]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul6-0004NG-I1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul3-0003Op-JC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul1-000306-GC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so2237343wmd.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:48 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:57 +0100
Message-Id: <75357b8d2adbf9aad6d5dd19fe6b9f9fa0964a94.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 24/50] audio: remove read and write pcm_ops
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

They just called audio_pcm_sw_read/write anyway, so it makes no sense
to have them too.  (The noaudio's read is the only exception, but it
should work with the generic code too.)

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_int.h   |  5 -----
 audio/alsaaudio.c   | 12 ------------
 audio/audio.c       |  8 ++++----
 audio/coreaudio.c   |  6 ------
 audio/dsoundaudio.c | 12 ------------
 audio/noaudio.c     | 19 -------------------
 audio/ossaudio.c    | 12 ------------
 audio/paaudio.c     | 12 ------------
 audio/sdlaudio.c    |  6 ------
 audio/spiceaudio.c  | 12 ------------
 audio/wavaudio.c    |  6 ------
 11 files changed, 4 insertions(+), 106 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 02ec6ea738..40b3515b4e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -149,13 +149,11 @@ struct audio_pcm_ops {
     int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_out)(HWVoiceOut *hw);
     int  (*run_out) (HWVoiceOut *hw, int live);
-    int  (*write)   (SWVoiceOut *sw, void *buf, int size);
     int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
 
     int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_in) (HWVoiceIn *hw);
     int  (*run_in)  (HWVoiceIn *hw);
-    int  (*read)    (SWVoiceIn *sw, void *buf, int size);
     int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
 
@@ -209,11 +207,8 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-int  audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int len);
 int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
 
-int  audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int len);
-
 int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
                            int live, int pending);
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 9dfd5fd26f..4c6bbdbc1d 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -269,11 +269,6 @@ static int alsa_poll_in (HWVoiceIn *hw)
     return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
 }
 
-static int alsa_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
@@ -995,11 +990,6 @@ static int alsa_run_in (HWVoiceIn *hw)
     return read_samples;
 }
 
-static int alsa_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
@@ -1088,13 +1078,11 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
     .run_out  = alsa_run_out,
-    .write    = alsa_write,
     .ctl_out  = alsa_ctl_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
     .run_in   = alsa_run_in,
-    .read     = alsa_read,
     .ctl_in   = alsa_ctl_in,
 };
 
diff --git a/audio/audio.c b/audio/audio.c
index 4d0d316ce3..f844411d59 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -597,7 +597,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     }
 }
 
-int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
+static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 {
     HWVoiceIn *hw = sw->hw;
     int samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
@@ -699,7 +699,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 /*
  * Soft voice (playback)
  */
-int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
+static int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
 {
     int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
     int ret = 0, pos = 0, total = 0;
@@ -857,7 +857,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
         return 0;
     }
 
-    return sw->hw->pcm_ops->write(sw, buf, size);
+    return audio_pcm_sw_write(sw, buf, size);
 }
 
 int AUD_read (SWVoiceIn *sw, void *buf, int size)
@@ -872,7 +872,7 @@ int AUD_read (SWVoiceIn *sw, void *buf, int size)
         return 0;
     }
 
-    return sw->hw->pcm_ops->read(sw, buf, size);
+    return audio_pcm_sw_read(sw, buf, size);
 }
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index b6935359ee..abbbb45d69 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -489,11 +489,6 @@ static OSStatus audioDeviceIOProc(
     return 0;
 }
 
-static int coreaudio_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -692,7 +687,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .init_out = coreaudio_init_out,
     .fini_out = coreaudio_fini_out,
     .run_out  = coreaudio_run_out,
-    .write    = coreaudio_write,
     .ctl_out  = coreaudio_ctl_out
 };
 
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 6f074c6f94..dfcb70c81a 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,11 +454,6 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int dsound_run_out (HWVoiceOut *hw, int live)
 {
     int err;
@@ -645,11 +640,6 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_read (SWVoiceIn *sw, void *buf, int len)
-{
-    return audio_pcm_sw_read (sw, buf, len);
-}
-
 static int dsound_run_in (HWVoiceIn *hw)
 {
     int err;
@@ -856,13 +846,11 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .init_out = dsound_init_out,
     .fini_out = dsound_fini_out,
     .run_out  = dsound_run_out,
-    .write    = dsound_write,
     .ctl_out  = dsound_ctl_out,
 
     .init_in  = dsound_init_in,
     .fini_in  = dsound_fini_in,
     .run_in   = dsound_run_in,
-    .read     = dsound_read,
     .ctl_in   = dsound_ctl_in
 };
 
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 823780dacb..4fe7720861 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -60,11 +60,6 @@ static int no_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
 
-static int no_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write(sw, buf, len);
-}
-
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
     audio_pcm_init_info (&hw->info, as);
@@ -117,18 +112,6 @@ static int no_run_in (HWVoiceIn *hw)
     return samples;
 }
 
-static int no_read (SWVoiceIn *sw, void *buf, int size)
-{
-    /* use custom code here instead of audio_pcm_sw_read() to avoid
-     * useless resampling/mixing */
-    int samples = size >> sw->info.shift;
-    int total = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    int to_clear = MIN (samples, total);
-    sw->total_hw_samples_acquired += total;
-    audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
-    return to_clear << sw->info.shift;
-}
-
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     (void) hw;
@@ -150,13 +133,11 @@ static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
     .run_out  = no_run_out,
-    .write    = no_write,
     .ctl_out  = no_ctl_out,
 
     .init_in  = no_init_in,
     .fini_in  = no_fini_in,
     .run_in   = no_run_in,
-    .read     = no_read,
     .ctl_in   = no_ctl_in
 };
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index bbcc44129d..3eee7a3970 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -133,11 +133,6 @@ static void oss_poll_in (HWVoiceIn *hw)
     qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
 
-static int oss_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int aud_to_ossfmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
@@ -787,11 +782,6 @@ static int oss_run_in (HWVoiceIn *hw)
     return read_samples;
 }
 
-static int oss_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
@@ -860,13 +850,11 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .init_out = oss_init_out,
     .fini_out = oss_fini_out,
     .run_out  = oss_run_out,
-    .write    = oss_write,
     .ctl_out  = oss_ctl_out,
 
     .init_in  = oss_init_in,
     .fini_in  = oss_fini_in,
     .run_in   = oss_run_in,
-    .read     = oss_read,
     .ctl_in   = oss_ctl_in
 };
 
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 7758d304ca..f5b924d50c 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -294,11 +294,6 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
 
-static int qpa_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 /* capture */
 static void *qpa_thread_in (void *arg)
 {
@@ -387,11 +382,6 @@ static int qpa_run_in (HWVoiceIn *hw)
     return incr;
 }
 
-static int qpa_read (SWVoiceIn *sw, void *buf, int len)
-{
-    return audio_pcm_sw_read (sw, buf, len);
-}
-
 static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
 {
     int format;
@@ -988,13 +978,11 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .run_out  = qpa_run_out,
-    .write    = qpa_write,
     .ctl_out  = qpa_ctl_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .run_in   = qpa_run_in,
-    .read     = qpa_read,
     .ctl_in   = qpa_ctl_in
 };
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index fc61038b77..ab9166d054 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -325,11 +325,6 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 #endif
 }
 
-static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int sdl_run_out (HWVoiceOut *hw, int live)
 {
     int decr;
@@ -483,7 +478,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .init_out = sdl_init_out,
     .fini_out = sdl_fini_out,
     .run_out  = sdl_run_out,
-    .write    = sdl_write_out,
     .ctl_out  = sdl_ctl_out,
 };
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b9160991d2..f963853ed8 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -192,11 +192,6 @@ static int line_out_run (HWVoiceOut *hw, int live)
     return decr;
 }
 
-static int line_out_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
@@ -325,11 +320,6 @@ static int line_in_run (HWVoiceIn *hw)
     return num_samples;
 }
 
-static int line_in_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
@@ -377,13 +367,11 @@ static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
     .fini_out = line_out_fini,
     .run_out  = line_out_run,
-    .write    = line_out_write,
     .ctl_out  = line_out_ctl,
 
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
     .run_in   = line_in_run,
-    .read     = line_in_read,
     .ctl_in   = line_in_ctl,
 };
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 723028a466..dda6993fb9 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -82,11 +82,6 @@ static int wav_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
 
-static int wav_write_out (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 /* VICE code: Store number as little endian. */
 static void le_store (uint8_t *buf, uint32_t val, int len)
 {
@@ -238,7 +233,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
     .run_out  = wav_run_out,
-    .write    = wav_write_out,
     .ctl_out  = wav_ctl_out,
 };
 
-- 
2.20.1
