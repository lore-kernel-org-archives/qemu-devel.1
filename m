Received: from eggs.gnu.org ([209.51.188.92]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjulA-0004Rk-25
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003QW-5q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul3-0003F2-Ne
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x431.google.com with SMTP id l9so8888786wrt.13
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:59 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:10 +0100
Message-Id: <4d2457aead94211b435d153732e987cc75b0eabd.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 37/50] audio: unify input and output mixeng
 buffer management
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

Usage notes: hw->samples became hw->{mix,conv}_buf->size, except before
initialization (audio_pcm_hw_alloc_resources_*), hw->samples gives the
initial size of the STSampleBuffer.  The next commit tries to fix this
inconsistency.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_int.h      |  12 ++--
 audio/audio_template.h |  19 +++---
 audio/audio.c          | 130 ++++++++++++++++++++---------------------
 audio/ossaudio.c       |   2 +-
 4 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 1f6ec15e18..97d159f28e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -51,6 +51,11 @@ struct audio_pcm_info {
 
 typedef struct SWVoiceCap SWVoiceCap;
 
+typedef struct STSampleBuffer {
+    size_t pos, size;
+    st_sample samples[];
+} STSampleBuffer;
+
 typedef struct HWVoiceOut {
     AudioState *s;
     int enabled;
@@ -59,11 +64,9 @@ typedef struct HWVoiceOut {
     struct audio_pcm_info info;
 
     f_sample *clip;
-
-    size_t rpos;
     uint64_t ts_helper;
 
-    struct st_sample *mix_buf;
+    STSampleBuffer *mix_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
@@ -83,11 +86,10 @@ typedef struct HWVoiceIn {
 
     t_sample *conv;
 
-    size_t wpos;
     size_t total_samples_captured;
     uint64_t ts_helper;
 
-    struct st_sample *conv_buf;
+    STSampleBuffer *conv_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index fcab583cfc..83ffc62183 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -76,16 +76,15 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
     HWBUF = NULL;
 }
 
-static bool glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
+static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    HWBUF = audio_calloc(__func__, hw->samples, sizeof(struct st_sample));
-    if (!HWBUF) {
-        dolog("Could not allocate " NAME " buffer (%zu samples)\n",
-              hw->samples);
-        return false;
+    size_t samples = hw->samples;
+    if (audio_bug(__func__, samples == 0)) {
+        dolog("Attempted to allocate empty buffer\n");
     }
 
-    return true;
+    HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
+    HWBUF->size = samples;
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -104,7 +103,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
 {
     int samples;
 
-    samples = ((int64_t) sw->hw->samples << 32) / sw->ratio;
+    samples = ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
 
     sw->buf = audio_calloc(__func__, samples, sizeof(struct st_sample));
     if (!sw->buf) {
@@ -280,9 +279,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
 
-    if (!glue(audio_pcm_hw_alloc_resources_, TYPE)(hw)) {
-        goto err1;
-    }
+    glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
 
     QLIST_INSERT_HEAD (&s->glue (hw_head_, TYPE), hw, entries);
     glue (s->nb_hw_voices_, TYPE) -= 1;
diff --git a/audio/audio.c b/audio/audio.c
index 8bfc122e60..b5dbf5228b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -545,8 +545,8 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
-    if (audio_bug(__func__, live > hw->samples)) {
-        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->conv_buf->size)) {
+        dolog("live=%zu hw->conv_buf->size=%zu\n", live, hw->conv_buf->size);
         return 0;
     }
     return live;
@@ -555,17 +555,17 @@ static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 {
     size_t clipped = 0;
-    size_t pos = hw->rpos;
+    size_t pos = hw->mix_buf->pos;
 
     while (len) {
-        st_sample *src = hw->mix_buf + pos;
+        st_sample *src = hw->mix_buf->samples + pos;
         uint8_t *dst = advance (pcm_buf, clipped << hw->info.shift);
-        size_t samples_till_end_of_buf = hw->samples - pos;
+        size_t samples_till_end_of_buf = hw->mix_buf->size - pos;
         size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
 
         hw->clip (dst, src, samples_to_clip);
 
-        pos = (pos + samples_to_clip) % hw->samples;
+        pos = (pos + samples_to_clip) % hw->mix_buf->size;
         len -= samples_to_clip;
         clipped += samples_to_clip;
     }
@@ -580,17 +580,17 @@ static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *sw)
     ssize_t live = hw->total_samples_captured - sw->total_hw_samples_acquired;
     ssize_t rpos;
 
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live < 0 || live > hw->conv_buf->size)) {
+        dolog("live=%zu hw->conv_buf->size=%zu\n", live, hw->conv_buf->size);
         return 0;
     }
 
-    rpos = hw->wpos - live;
+    rpos = hw->conv_buf->pos - live;
     if (rpos >= 0) {
         return rpos;
     }
     else {
-        return hw->samples + rpos;
+        return hw->conv_buf->size + rpos;
     }
 }
 
@@ -600,11 +600,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
     size_t samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
     struct st_sample *src, *dst = sw->buf;
 
-    rpos = audio_pcm_sw_get_rpos_in (sw) % hw->samples;
+    rpos = audio_pcm_sw_get_rpos_in(sw) % hw->conv_buf->size;
 
     live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live > hw->samples)) {
-        dolog("live_in=%zu hw->samples=%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->conv_buf->size)) {
+        dolog("live_in=%zu hw->conv_buf->size=%zu\n", live, hw->conv_buf->size);
         return 0;
     }
 
@@ -617,11 +617,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
     swlim = MIN (swlim, samples);
 
     while (swlim) {
-        src = hw->conv_buf + rpos;
-        if (hw->wpos > rpos) {
-            isamp = hw->wpos - rpos;
+        src = hw->conv_buf->samples + rpos;
+        if (hw->conv_buf->pos > rpos) {
+            isamp = hw->conv_buf->pos - rpos;
         } else {
-            isamp = hw->samples - rpos;
+            isamp = hw->conv_buf->size - rpos;
         }
 
         if (!isamp) {
@@ -631,7 +631,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -= osamp;
-        rpos = (rpos + isamp) % hw->samples;
+        rpos = (rpos + isamp) % hw->conv_buf->size;
         dst += osamp;
         ret += osamp;
         total += isamp;
@@ -679,8 +679,8 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     if (nb_live1) {
         size_t live = smin;
 
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog("live=%zu hw->mix_buf->size=%zu\n", live, hw->mix_buf->size);
             return 0;
         }
         return live;
@@ -700,11 +700,11 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
         return size;
     }
 
-    hwsamples = sw->hw->samples;
+    hwsamples = sw->hw->mix_buf->size;
 
     live = sw->total_hw_samples_mixed;
     if (audio_bug(__func__, live > hwsamples)) {
-        dolog("live=%zu hw->samples=%zu\n", live, hwsamples);
+        dolog("live=%zu hw->mix_buf->size=%zu\n", live, hwsamples);
         return 0;
     }
 
@@ -715,7 +715,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
         return 0;
     }
 
-    wpos = (sw->hw->rpos + live) % hwsamples;
+    wpos = (sw->hw->mix_buf->pos + live) % hwsamples;
     samples = size >> sw->info.shift;
 
     dead = hwsamples - live;
@@ -741,7 +741,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
         st_rate_flow_mix (
             sw->rate,
             sw->buf + pos,
-            sw->hw->mix_buf + wpos,
+            sw->hw->mix_buf->samples + wpos,
             &isamp,
             &osamp
             );
@@ -869,7 +869,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
 {
-    return sw->hw->samples << sw->hw->info.shift;
+    return sw->hw->mix_buf->size << sw->hw->info.shift;
 }
 
 void AUD_set_active_out (SWVoiceOut *sw, int on)
@@ -970,8 +970,9 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live > sw->hw->samples)) {
-        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->conv_buf->size)) {
+        dolog("live=%zu sw->hw->conv_buf->size=%zu\n", live,
+              sw->hw->conv_buf->size);
         return 0;
     }
 
@@ -994,12 +995,13 @@ static size_t audio_get_free(SWVoiceOut *sw)
 
     live = sw->total_hw_samples_mixed;
 
-    if (audio_bug(__func__, live > sw->hw->samples)) {
-        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->mix_buf->size)) {
+        dolog("live=%zu sw->hw->mix_buf->size=%zu\n", live,
+              sw->hw->mix_buf->size);
         return 0;
     }
 
-    dead = sw->hw->samples - live;
+    dead = sw->hw->mix_buf->size - live;
 
 #ifdef DEBUG_OUT
     dolog ("%s: get_free live %d dead %d ret %" PRId64 "\n",
@@ -1024,12 +1026,12 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
 
             n = samples;
             while (n) {
-                size_t till_end_of_hw = hw->samples - rpos2;
+                size_t till_end_of_hw = hw->mix_buf->size - rpos2;
                 size_t to_write = MIN(till_end_of_hw, n);
                 size_t bytes = to_write << hw->info.shift;
                 size_t written;
 
-                sw->buf = hw->mix_buf + rpos2;
+                sw->buf = hw->mix_buf->samples + rpos2;
                 written = audio_pcm_sw_write (sw, NULL, bytes);
                 if (written - bytes) {
                     dolog("Could not mix %zu bytes into a capture "
@@ -1038,14 +1040,14 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
                     break;
                 }
                 n -= to_write;
-                rpos2 = (rpos2 + to_write) % hw->samples;
+                rpos2 = (rpos2 + to_write) % hw->mix_buf->size;
             }
         }
     }
 
-    n = MIN(samples, hw->samples - rpos);
-    mixeng_clear(hw->mix_buf + rpos, n);
-    mixeng_clear(hw->mix_buf, samples - n);
+    n = MIN(samples, hw->mix_buf->size - rpos);
+    mixeng_clear(hw->mix_buf->samples + rpos, n);
+    mixeng_clear(hw->mix_buf->samples, samples - n);
 }
 
 static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
@@ -1063,7 +1065,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
 
         live -= proc;
         clipped += proc;
-        hw->rpos = (hw->rpos + proc) % hw->samples;
+        hw->mix_buf->pos = (hw->mix_buf->pos + proc) % hw->mix_buf->size;
 
         if (proc == 0 || proc < decr) {
             break;
@@ -1087,8 +1089,8 @@ static void audio_run_out (AudioState *s)
             live = 0;
         }
 
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog ("live=%zu hw->samples=%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog ("live=%zu hw->mix_buf->size=%zu\n", live, hw->mix_buf->size);
             continue;
         }
 
@@ -1119,13 +1121,13 @@ static void audio_run_out (AudioState *s)
             continue;
         }
 
-        prev_rpos = hw->rpos;
+        prev_rpos = hw->mix_buf->pos;
         played = audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
-        if (audio_bug(__func__, hw->rpos >= hw->samples)) {
-            dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
-                  hw->rpos, hw->samples, played);
-            hw->rpos = 0;
+        if (audio_bug(__func__, hw->mix_buf->pos >= hw->mix_buf->size)) {
+            dolog("hw->mix_buf->pos=%zu hw->mix_buf->size=%zu played=%zu\n",
+                  hw->mix_buf->pos, hw->mix_buf->size, played);
+            hw->mix_buf->pos = 0;
         }
 
 #ifdef DEBUG_OUT
@@ -1182,6 +1184,7 @@ static void audio_run_out (AudioState *s)
 static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
 {
     size_t conv = 0;
+    STSampleBuffer *conv_buf = hw->conv_buf;
 
     while (samples) {
         size_t proc;
@@ -1195,10 +1198,10 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
         }
 
         proc = MIN(size >> hw->info.shift,
-                   hw->samples - hw->wpos);
+                   conv_buf->size - conv_buf->pos);
 
-        hw->conv(hw->conv_buf + hw->wpos, buf, proc);
-        hw->wpos = (hw->wpos + proc) % hw->samples;
+        hw->conv(conv_buf->samples + conv_buf->pos, buf, proc);
+        conv_buf->pos = (conv_buf->pos + proc) % conv_buf->size;
 
         samples -= proc;
         conv += proc;
@@ -1218,9 +1221,10 @@ static void audio_run_in (AudioState *s)
 
         if (replay_mode != REPLAY_MODE_PLAY) {
             captured = audio_pcm_hw_run_in(
-                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
+                hw, hw->conv_buf->size - audio_pcm_hw_get_live_in(hw));
         }
-        replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
+        replay_audio_in(&captured, hw->conv_buf->samples, &hw->conv_buf->pos,
+                        hw->conv_buf->size);
 
         min = audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured += captured - min;
@@ -1251,14 +1255,14 @@ static void audio_run_capture (AudioState *s)
         SWVoiceOut *sw;
 
         captured = live = audio_pcm_hw_get_live_out (hw, NULL);
-        rpos = hw->rpos;
+        rpos = hw->mix_buf->pos;
         while (live) {
-            size_t left = hw->samples - rpos;
+            size_t left = hw->mix_buf->size - rpos;
             size_t to_capture = MIN(live, left);
             struct st_sample *src;
             struct capture_callback *cb;
 
-            src = hw->mix_buf + rpos;
+            src = hw->mix_buf->samples + rpos;
             hw->clip (cap->buf, src, to_capture);
             mixeng_clear (src, to_capture);
 
@@ -1266,10 +1270,10 @@ static void audio_run_capture (AudioState *s)
                 cb->ops.capture (cb->opaque, cap->buf,
                                  to_capture << hw->info.shift);
             }
-            rpos = (rpos + to_capture) % hw->samples;
+            rpos = (rpos + to_capture) % hw->mix_buf->size;
             live -= to_capture;
         }
-        hw->rpos = rpos;
+        hw->mix_buf->pos = rpos;
 
         for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
             if (!sw->active && sw->empty) {
@@ -1317,7 +1321,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
     ssize_t start;
 
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->samples << hw->info.shift;
+        size_t calc_size = hw->conv_buf->size << hw->info.shift;
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
         hw->pos_emul = hw->pending_emul = 0;
@@ -1353,7 +1357,7 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->samples << hw->info.shift;
+        size_t calc_size = hw->mix_buf->size << hw->info.shift;
 
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
@@ -1761,21 +1765,16 @@ CaptureVoiceOut *AUD_add_capture(
 
         /* XXX find a more elegant way */
         hw->samples = 4096 * 4;
-        hw->mix_buf = audio_calloc(__func__, hw->samples,
-                                   sizeof(struct st_sample));
-        if (!hw->mix_buf) {
-            dolog("Could not allocate capture mix buffer (%zu samples)\n",
-                  hw->samples);
-            goto err2;
-        }
+        audio_pcm_hw_alloc_resources_out(hw);
 
         audio_pcm_init_info (&hw->info, as);
 
-        cap->buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
+        cap->buf = audio_calloc(__func__, hw->mix_buf->size,
+                                1 << hw->info.shift);
         if (!cap->buf) {
             dolog ("Could not allocate capture buffer "
                    "(%zu samples, each %d bytes)\n",
-                   hw->samples, 1 << hw->info.shift);
+                   hw->mix_buf->size, 1 << hw->info.shift);
             goto err3;
         }
 
@@ -1795,7 +1794,6 @@ CaptureVoiceOut *AUD_add_capture(
 
     err3:
         g_free (cap->hw.mix_buf);
-    err2:
         g_free (cap);
     err1:
         g_free (cb);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 774a41fbf9..957d14eb8e 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -584,7 +584,7 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
 
-            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
+            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->size);
             trig = PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
-- 
2.20.1
