Received: from eggs.gnu.org ([209.51.188.92]:58196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0004MC-Kf
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul3-0003Np-CR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukx-0003CT-V0
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so8904123wrr.12
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:57 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:07 +0100
Message-Id: <1735f2dd5b1825aaf294ff8f80dcd8d3c26a72c1.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 34/50] spiceaudio: port to the new audio
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
 audio/spiceaudio.c | 112 +++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 74 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 1a777bba17..d1605d3939 100644
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
 
@@ -60,7 +60,6 @@ typedef struct SpiceVoiceIn {
     SpiceRecordInstance   sin;
     SpiceRateCtl          rate;
     int                   active;
-    uint32_t              samples[LINE_IN_SAMPLES];
 } SpiceVoiceIn;
 
 static const SpicePlaybackInterface playback_sif = {
@@ -152,44 +151,36 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
 
-static size_t line_out_run (HWVoiceOut *hw, size_t live)
+static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
-    SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
-    size_t rpos, decr;
-    size_t samples;
+    SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
+    size_t decr;
 
-    if (!live) {
-        return 0;
+    if (!out->frame) {
+        spice_server_playback_get_buffer(&out->sin, &out->frame, &out->fsize);
+        out->fpos = 0;
     }
 
-    decr = rate_get_samples (&hw->info, &out->rate);
-    decr = MIN (live, decr);
+    decr = rate_get_samples(&hw->info, &out->rate);
+    decr = MIN(out->fsize - out->fpos, decr);
 
-    samples = decr;
-    rpos = hw->rpos;
-    while (samples) {
-        int left_till_end_samples = hw->samples - rpos;
-        int len = MIN (samples, left_till_end_samples);
+    *size = decr << hw->info.shift;
+    return out->frame + out->fpos;
+}
 
-        if (!out->frame) {
-            spice_server_playback_get_buffer (&out->sin, &out->frame, &out->fsize);
-            out->fpos = out->frame;
-        }
-        if (out->frame) {
-            len = MIN (len, out->fsize);
-            hw->clip (out->fpos, hw->mix_buf + rpos, len);
-            out->fsize -= len;
-            out->fpos  += len;
-            if (out->fsize == 0) {
-                spice_server_playback_put_samples (&out->sin, out->frame);
-                out->frame = out->fpos = NULL;
-            }
-        }
-        rpos = (rpos + len) % hw->samples;
-        samples -= len;
+static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
+{
+    SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
+
+    out->fpos += size >> 2;
+    assert(buf == out->frame + out->fpos && out->fpos <= out->fsize);
+
+    if (out->fpos == out->fsize) { /* buffer full */
+        spice_server_playback_put_samples(&out->sin, out->frame);
+        out->frame = NULL;
     }
-    hw->rpos = rpos;
-    return decr;
+
+    return size;
 }
 
 static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
@@ -211,9 +202,9 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
         }
         out->active = 0;
         if (out->frame) {
-            memset (out->fpos, 0, out->fsize << 2);
+            memset(out->frame + out->fpos, 0, (out->fsize - out->fpos) << 2);
             spice_server_playback_put_samples (&out->sin, out->frame);
-            out->frame = out->fpos = NULL;
+            out->frame = NULL;
         }
         spice_server_playback_stop (&out->sin);
         break;
@@ -275,49 +266,20 @@ static void line_in_fini (HWVoiceIn *hw)
     spice_server_remove_interface (&in->sin.base);
 }
 
-static size_t line_in_run(HWVoiceIn *hw)
+static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    size_t num_samples;
-    int ready;
-    size_t len[2];
-    uint64_t delta_samp;
-    const uint32_t *samples;
+    uint64_t delta_samp = rate_get_samples(&hw->info, &in->rate);
+    uint64_t to_read = MIN(len >> 2, delta_samp);
+    size_t ready = spice_server_record_get_samples(&in->sin, buf, to_read);
 
-    if (!(num_samples = hw->samples - audio_pcm_hw_get_live_in (hw))) {
-        return 0;
-    }
-
-    delta_samp = rate_get_samples (&hw->info, &in->rate);
-    num_samples = MIN (num_samples, delta_samp);
-
-    ready = spice_server_record_get_samples (&in->sin, in->samples, num_samples);
-    samples = in->samples;
+    /* XXX: do we need this? */
     if (ready == 0) {
-        static const uint32_t silence[LINE_IN_SAMPLES];
-        samples = silence;
-        ready = LINE_IN_SAMPLES;
+        memset(buf, 0, to_read << 2);
+        ready = to_read;
     }
 
-    num_samples = MIN (ready, num_samples);
-
-    if (hw->wpos + num_samples > hw->samples) {
-        len[0] = hw->samples - hw->wpos;
-        len[1] = num_samples - len[0];
-    } else {
-        len[0] = num_samples;
-        len[1] = 0;
-    }
-
-    hw->conv (hw->conv_buf + hw->wpos, samples, len[0]);
-
-    if (len[1]) {
-        hw->conv (hw->conv_buf, samples + len[0], len[1]);
-    }
-
-    hw->wpos = (hw->wpos + num_samples) % hw->samples;
-
-    return num_samples;
+    return ready << 2;
 }
 
 static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
@@ -366,12 +328,14 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
 static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
     .fini_out = line_out_fini,
-    .run_out  = line_out_run,
+    .write    = audio_generic_write,
+    .get_buffer_out = line_out_get_buffer,
+    .put_buffer_out = line_out_put_buffer,
     .ctl_out  = line_out_ctl,
 
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
-    .run_in   = line_in_run,
+    .read     = line_in_read,
     .ctl_in   = line_in_ctl,
 };
 
-- 
2.20.1
