Received: from eggs.gnu.org ([209.51.188.92]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul7-0004Oo-Pd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Qv-7L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul3-0003Cs-SN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id m1so3894497wml.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:58 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:08 +0100
Message-Id: <25bee185c67bcaf474d9d0b87b2a15a98cbf0a01.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 35/50] wavaudio: port to the new audio
 backend api
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
 audio/wavaudio.c | 54 ++++++++----------------------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index a805e5e94b..31db03aadb 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -34,52 +34,28 @@ typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
     int64_t old_ticks;
-    void *pcm_buf;
     int total_samples;
 } WAVVoiceOut;
 
-static size_t wav_run_out(HWVoiceOut *hw, size_t live)
+static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    size_t rpos, decr, samples;
-    uint8_t *dst;
-    struct st_sample *src;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     int64_t ticks = now - wav->old_ticks;
     int64_t bytes =
         muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
-    if (bytes > INT_MAX) {
-        samples = INT_MAX >> hw->info.shift;
-    }
-    else {
-        samples = bytes >> hw->info.shift;
-    }
-
+    bytes = MIN(bytes, len);
+    bytes = bytes >> hw->info.shift << hw->info.shift;
     wav->old_ticks = now;
-    decr = MIN (live, samples);
-    samples = decr;
-    rpos = hw->rpos;
-    while (samples) {
-        int left_till_end_samples = hw->samples - rpos;
-        int convert_samples = MIN (samples, left_till_end_samples);
 
-        src = hw->mix_buf + rpos;
-        dst = advance (wav->pcm_buf, rpos << hw->info.shift);
-
-        hw->clip (dst, src, convert_samples);
-        if (fwrite (dst, convert_samples << hw->info.shift, 1, wav->f) != 1) {
-            dolog ("wav_run_out: fwrite of %d bytes failed\nReaons: %s\n",
-                   convert_samples << hw->info.shift, strerror (errno));
-        }
-
-        rpos = (rpos + convert_samples) % hw->samples;
-        samples -= convert_samples;
-        wav->total_samples += convert_samples;
+    if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
+        dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
+              bytes, strerror(errno));
     }
 
-    hw->rpos = rpos;
-    return decr;
+    wav->total_samples += bytes >> hw->info.shift;
+    return bytes;
 }
 
 /* VICE code: Store number as little endian. */
@@ -135,13 +111,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
 
     hw->samples = 1024;
-    wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!wav->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        return -1;
-    }
-
     le_store (hdr + 22, hw->info.nchannels, 2);
     le_store (hdr + 24, hw->info.freq, 4);
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
@@ -151,8 +120,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     if (!wav->f) {
         dolog ("Failed to open wave file `%s'\nReason: %s\n",
                wav_path, strerror(errno));
-        g_free (wav->pcm_buf);
-        wav->pcm_buf = NULL;
         return -1;
     }
 
@@ -206,9 +173,6 @@ static void wav_fini_out (HWVoiceOut *hw)
                wav->f, strerror (errno));
     }
     wav->f = NULL;
-
-    g_free (wav->pcm_buf);
-    wav->pcm_buf = NULL;
 }
 
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -232,7 +196,7 @@ static void wav_audio_fini (void *opaque)
 static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
-    .run_out  = wav_run_out,
+    .write    = wav_write_out,
     .ctl_out  = wav_ctl_out,
 };
 
-- 
2.20.1
