Received: from eggs.gnu.org ([209.51.188.92]:58396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul9-0004R7-It
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Rm-Gj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul4-0003H3-2R
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id r10so8917397wrs.10
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:38:01 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:12 +0100
Message-Id: <36a8ffaf72fe3574ce3336de91482390b3c04e3f.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 39/50] audio: common rate control code for
 timer based outputs
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

This commit removes the ad-hoc rate-limiting code from noaudio and
wavaudio, and replaces them with a (slightly modified) code from
spiceaudio.  This way multiple write calls (for example when the
circular buffer wraps around) do not cause problems.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_int.h  |  9 +++++++++
 audio/audio.c      | 30 ++++++++++++++++++++++++++++
 audio/noaudio.c    | 49 +++++++++++++++++++++-------------------------
 audio/spiceaudio.c | 49 +++++++---------------------------------------
 audio/wavaudio.c   | 21 ++++++++++----------
 5 files changed, 78 insertions(+), 80 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index a5263966a8..236b523286 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -242,6 +242,15 @@ void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
 void audio_run(AudioState *s, const char *msg);
 
+typedef struct RateCtl {
+    int64_t start_ticks;
+    int64_t bytes_sent;
+} RateCtl;
+
+void audio_rate_start(RateCtl *rate);
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail);
+
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
 #define VOICE_VOLUME 3
diff --git a/audio/audio.c b/audio/audio.c
index 4b5c1712e3..798541638e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2032,3 +2032,33 @@ const char *audio_get_id(QEMUSoundCard *card)
         return "";
     }
 }
+
+void audio_rate_start(RateCtl *rate)
+{
+    memset(rate, 0, sizeof(RateCtl));
+    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail)
+{
+    int64_t now;
+    int64_t ticks;
+    int64_t bytes;
+    int64_t samples;
+    size_t ret;
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    ticks = now - rate->start_ticks;
+    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
+    samples = (bytes - rate->bytes_sent) >> info->shift;
+    if (samples < 0 || samples > 65536) {
+        AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)", samples);
+        audio_rate_start(rate);
+        samples = 0;
+    }
+
+    ret = MIN(samples << info->shift, bytes_avail);
+    rate->bytes_sent += ret;
+    return ret;
+}
diff --git a/audio/noaudio.c b/audio/noaudio.c
index dc77d1aff5..b29929dac4 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -32,32 +32,26 @@
 
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceOut;
 
 typedef struct NoVoiceIn {
     HWVoiceIn hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceIn;
 
 static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks = now - no->old_ticks;
-    bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    no->old_ticks = now;
-    return MIN(len, bytes);
+    return audio_rate_get_bytes(&hw->info, &no->rate, len);
 }
 
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
+    NoVoiceOut *no = (NoVoiceOut *) hw;
+
     audio_pcm_init_info (&hw->info, as);
+    audio_rate_start(&no->rate);
     return 0;
 }
 
@@ -68,14 +62,20 @@ static void no_fini_out (HWVoiceOut *hw)
 
 static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceOut *no = (NoVoiceOut *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
 
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
+    NoVoiceIn *no = (NoVoiceIn *) hw;
+
     audio_pcm_init_info (&hw->info, as);
+    audio_rate_start(&no->rate);
     return 0;
 }
 
@@ -86,25 +86,20 @@ static void no_fini_in (HWVoiceIn *hw)
 
 static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    size_t to_clear;
     NoVoiceIn *no = (NoVoiceIn *) hw;
+    int64_t bytes = audio_rate_get_bytes(&hw->info, &no->rate, size);
 
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks = now - no->old_ticks;
-    int64_t bytes =
-        muldiv64 (ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    no->old_ticks = now;
-    to_clear = MIN(bytes, size);
-
-    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift);
-    return to_clear;
+    audio_pcm_info_clear_buf(&hw->info, buf, bytes >> hw->info.shift);
+    return bytes;
 }
 
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceIn *no = (NoVoiceIn *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 709245e453..2495866c82 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -40,15 +40,10 @@
 #define LINE_IN_SAMPLES (256 * 4)
 #endif
 
-typedef struct SpiceRateCtl {
-    int64_t               start_ticks;
-    int64_t               bytes_sent;
-} SpiceRateCtl;
-
 typedef struct SpiceVoiceOut {
     HWVoiceOut            hw;
     SpicePlaybackInstance sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
     uint32_t              *frame;
     uint32_t              fpos;
@@ -58,7 +53,7 @@ typedef struct SpiceVoiceOut {
 typedef struct SpiceVoiceIn {
     HWVoiceIn             hw;
     SpiceRecordInstance   sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
 } SpiceVoiceIn;
 
@@ -89,32 +84,6 @@ static void spice_audio_fini (void *opaque)
     /* nothing */
 }
 
-static void rate_start (SpiceRateCtl *rate)
-{
-    memset (rate, 0, sizeof (*rate));
-    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-}
-
-static int rate_get_samples (struct audio_pcm_info *info, SpiceRateCtl *rate)
-{
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-    int64_t samples;
-
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks = now - rate->start_ticks;
-    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
-    samples = (bytes - rate->bytes_sent) >> info->shift;
-    if (samples < 0 || samples > 65536) {
-        error_report("Resetting rate control (%" PRId64 " samples)", samples);
-        rate_start(rate);
-        samples = 0;
-    }
-    rate->bytes_sent += samples << info->shift;
-    return samples;
-}
-
 /* playback */
 
 static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
@@ -158,17 +127,14 @@ static void line_out_fini (HWVoiceOut *hw)
 static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
-    size_t decr;
 
     if (!out->frame) {
         spice_server_playback_get_buffer(&out->sin, &out->frame, &out->fsize);
         out->fpos = 0;
     }
 
-    decr = rate_get_samples(&hw->info, &out->rate);
-    decr = MIN(out->fsize - out->fpos, decr);
-
-    *size = decr << hw->info.shift;
+    *size = audio_rate_get_bytes(&hw->info, &out->rate,
+                                 (out->fsize - out->fpos) << hw->info.shift);
     return out->frame + out->fpos;
 }
 
@@ -197,7 +163,7 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
             break;
         }
         out->active = 1;
-        rate_start (&out->rate);
+        audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
         break;
     case VOICE_DISABLE:
@@ -277,8 +243,7 @@ static void line_in_fini (HWVoiceIn *hw)
 static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    uint64_t delta_samp = rate_get_samples(&hw->info, &in->rate);
-    uint64_t to_read = MIN(len >> 2, delta_samp);
+    uint64_t to_read = audio_rate_get_bytes(&hw->info, &in->rate, len) >> 2;
     size_t ready = spice_server_record_get_samples(&in->sin, buf, to_read);
 
     /* XXX: do we need this? */
@@ -300,7 +265,7 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
             break;
         }
         in->active = 1;
-        rate_start (&in->rate);
+        audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
         break;
     case VOICE_DISABLE:
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 0a0e76d2d9..f977d96b9c 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -33,21 +33,15 @@
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
-    int64_t old_ticks;
+    RateCtl rate;
     int total_samples;
 } WAVVoiceOut;
 
 static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks = now - wav->old_ticks;
-    int64_t bytes =
-        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-    bytes = MIN(bytes, len);
-    bytes = bytes >> hw->info.shift << hw->info.shift;
-    wav->old_ticks = now;
+    int64_t bytes = audio_rate_get_bytes(&hw->info, &wav->rate, len);
+    assert(bytes >> hw->info.shift << hw->info.shift == bytes);
 
     if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
         dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
@@ -127,6 +121,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
                strerror(errno));
         return -1;
     }
+
+    audio_rate_start(&wav->rate);
     return 0;
 }
 
@@ -176,8 +172,11 @@ static void wav_fini_out (HWVoiceOut *hw)
 
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    WAVVoiceOut *wav = (WAVVoiceOut *) hw;
+
+    if (cmd == VOICE_ENABLE) {
+        audio_rate_start(&wav->rate);
+    }
     return 0;
 }
 
-- 
2.20.1
