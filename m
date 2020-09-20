Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D4C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D062085B
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D062085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK36T-0003K1-QA
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yI-00042d-Qn
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:57 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:34972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yF-0006Gf-Nz
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:54 -0400
Received: from fwd26.aul.t-online.de (fwd26.aul.t-online.de [172.20.26.131])
 by mailout10.t-online.de (Postfix) with SMTP id 0E2BE4165931;
 Sun, 20 Sep 2020 19:17:50 +0200 (CEST)
Received: from linpower.localnet
 (rfpdq-ZJohcQrlbGTEh0LqOW6-npuHtiDqYLq0Mwpb8pxPvILaI32YHrS+BynlRZhi@[93.236.144.216])
 by fwd26.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2yC-0oazw00; Sun, 20 Sep 2020 19:17:48 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 05E7733550B; Sun, 20 Sep 2020 19:17:30 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 8/9] audio: restore mixing-engine playback buffer size
Date: Sun, 20 Sep 2020 19:17:28 +0200
Message-Id: <20200920171729.15861-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: rfpdq-ZJohcQrlbGTEh0LqOW6-npuHtiDqYLq0Mwpb8pxPvILaI32YHrS+BynlRZhi
X-TOI-EXPURGATEID: 150726::1600622268-0000FB7B-5EC4546F/0/0 CLEAN NORMAL
X-TOI-MSGID: 51c93e08-6bab-4c47-a915-e2c6f1151bed
Received-SPF: none client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:17:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ff095e5231 "audio: api for mixeng code free backends"
introduced another FIFO for the audio subsystem with exactly the
same size as the mixing-engine FIFO. Most audio backends use
this generic FIFO. The generic FIFO used together with the
mixing-engine FIFO doubles the audio FIFO size, because that's
just two independent FIFOs connected together in series.

For audio playback this nearly doubles the playback latency.

This patch restores the effective mixing-engine playback buffer
size to a pre v4.2.0 size by only accepting the amount of
samples for the mixing-engine queue which the downstream queue
accepts.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/alsaaudio.c   |  1 +
 audio/audio.c       | 68 +++++++++++++++++++++++++++++++++------------
 audio/audio_int.h   |  7 ++++-
 audio/coreaudio.c   |  3 ++
 audio/dsoundaudio.c |  6 ++++
 audio/jackaudio.c   |  1 +
 audio/noaudio.c     |  1 +
 audio/ossaudio.c    | 12 ++++++++
 audio/paaudio.c     |  6 ++++
 audio/sdlaudio.c    |  3 ++
 audio/spiceaudio.c  |  6 ++++
 audio/wavaudio.c    |  1 +
 12 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index a8e62542f9..80235ddf94 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -923,6 +923,7 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
     .write    = alsa_write,
+    .buffer_get_free = audio_generic_buffer_get_free,
     .run_buffer_out = audio_generic_run_buffer_out,
     .enable_out = alsa_enable_out,
 
diff --git a/audio/audio.c b/audio/audio.c
index a2c4c55477..b908e041dd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -700,12 +700,18 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     return 0;
 }
 
+static size_t audio_pcm_hw_get_free(HWVoiceOut *hw)
+{
+    return hw->pcm_ops->buffer_get_free(hw) / hw->info.bytes_per_frame;
+}
+
 /*
  * Soft voice (playback)
  */
 static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
 {
-    size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
+    size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, limit;
+    size_t blck;
     size_t ret = 0, pos = 0, total = 0;
 
     if (!sw) {
@@ -728,27 +734,28 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     }
 
     wpos = (sw->hw->mix_buf->pos + live) % hwsamples;
-    samples = size / sw->info.bytes_per_frame;
 
     dead = hwsamples - live;
-    swlim = ((int64_t) dead << 32) / sw->ratio;
-    swlim = MIN (swlim, samples);
-    if (swlim) {
-        sw->conv (sw->buf, buf, swlim);
+    limit = audio_pcm_hw_get_free(sw->hw);
+    samples = ((int64_t)MIN(dead, limit) << 32) / sw->ratio;
+    limit = size / sw->info.bytes_per_frame;
+    samples = MIN(samples, limit);
+    if (samples) {
+        sw->conv(sw->buf, buf, samples);
 
         if (sw->hw->pcm_ops && !sw->hw->pcm_ops->volume_out) {
-            mixeng_volume (sw->buf, swlim, &sw->vol);
+            mixeng_volume(sw->buf, samples, &sw->vol);
         }
     }
 
-    while (swlim) {
+    while (samples) {
         dead = hwsamples - live;
         left = hwsamples - wpos;
         blck = MIN (dead, left);
         if (!blck) {
             break;
         }
-        isamp = swlim;
+        isamp = samples;
         osamp = blck;
         st_rate_flow_mix (
             sw->rate,
@@ -758,7 +765,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
             &osamp
             );
         ret += isamp;
-        swlim -= isamp;
+        samples -= isamp;
         pos += isamp;
         live += osamp;
         wpos = (wpos + osamp) % hwsamples;
@@ -1018,6 +1025,11 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     return (((int64_t) live << 32) / sw->ratio) * sw->info.bytes_per_frame;
 }
 
+static size_t audio_sw_bytes_free(SWVoiceOut *sw, size_t free)
+{
+    return (((int64_t)free << 32) / sw->ratio) * sw->info.bytes_per_frame;
+}
+
 static size_t audio_get_free(SWVoiceOut *sw)
 {
     size_t live, dead;
@@ -1037,13 +1049,11 @@ static size_t audio_get_free(SWVoiceOut *sw)
     dead = sw->hw->mix_buf->size - live;
 
 #ifdef DEBUG_OUT
-    dolog ("%s: get_free live %d dead %d ret %" PRId64 "\n",
-           SW_NAME (sw),
-           live, dead, (((int64_t) dead << 32) / sw->ratio) *
-           sw->info.bytes_per_frame);
+    dolog("%s: get_free live %d dead %d sw_bytes %d\n",
+          SW_NAME(sw), live, dead, audio_sw_bytes_free(sw, dead));
 #endif
 
-    return (((int64_t) dead << 32) / sw->ratio) * sw->info.bytes_per_frame;
+    return dead;
 }
 
 static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
@@ -1180,7 +1190,10 @@ static void audio_run_out (AudioState *s)
         if (!live) {
             for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
                 if (sw->active) {
-                    free = audio_get_free (sw);
+                    size_t sw_free = audio_get_free(sw);
+                    size_t hw_free = audio_pcm_hw_get_free(hw);
+
+                    free = audio_sw_bytes_free(sw, MIN(sw_free, hw_free));
                     if (free > 0) {
                         sw->callback.fn (sw->callback.opaque, free);
                     }
@@ -1230,7 +1243,10 @@ static void audio_run_out (AudioState *s)
             }
 
             if (sw->active) {
-                free = audio_get_free (sw);
+                size_t sw_free = audio_get_free(sw);
+                size_t hw_free = audio_pcm_hw_get_free(hw);
+
+                free = audio_sw_bytes_free(sw, MIN(sw_free, hw_free));
                 if (free > 0) {
                     sw->callback.fn (sw->callback.opaque, free);
                 }
@@ -1437,6 +1453,15 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
     hw->pending_emul -= size;
 }
 
+size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
+{
+    if (hw->buf_emul) {
+        return hw->size_emul - hw->pending_emul;
+    } else {
+        return hw->samples * hw->info.bytes_per_frame;
+    }
+}
+
 void audio_generic_run_buffer_out(HWVoiceOut *hw)
 {
     while (hw->pending_emul) {
@@ -1826,6 +1851,14 @@ void AUD_remove_card (QEMUSoundCard *card)
     g_free (card->name);
 }
 
+static size_t capture_buffer_get_free(HWVoiceOut *hw)
+{
+    return INT_MAX;
+}
+
+static struct audio_pcm_ops capture_pcm_ops = {
+    .buffer_get_free = capture_buffer_get_free,
+};
 
 CaptureVoiceOut *AUD_add_capture(
     AudioState *s,
@@ -1872,6 +1905,7 @@ CaptureVoiceOut *AUD_add_capture(
 
         hw = &cap->hw;
         hw->s = s;
+        hw->pcm_ops = &capture_pcm_ops;
         QLIST_INIT (&hw->sw_head);
         QLIST_INIT (&cap->cb_head);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 4775857bf2..bb9425bc60 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -154,10 +154,14 @@ struct audio_pcm_ops {
     void   (*fini_out)(HWVoiceOut *hw);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     void   (*run_buffer_out)(HWVoiceOut *hw);
+    /*
+     * Get the free output buffer size. This is an upper limit. The size
+     * returned by function get_buffer_out may be smaller.
+     */
+    size_t (*buffer_get_free)(HWVoiceOut *hw);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
      * returns the buffer, and writes it's size to size (in bytes)
-     * this is unrelated to the above buffer_size_out function
      */
     void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
     /*
@@ -181,6 +185,7 @@ struct audio_pcm_ops {
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
 void audio_generic_run_buffer_out(HWVoiceOut *hw);
+size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
 size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size);
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 4b4365660f..deff0f2419 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -409,6 +409,7 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, const char *fn_name)
         coreaudio_unlock(core, "coreaudio_" #name);             \
         return ret;                                             \
     }
+COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                        (hw, size))
 COREAUDIO_WRAPPER_FUNC(put_buffer_out, size_t,
@@ -670,6 +671,8 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .fini_out = coreaudio_fini_out,
   /* wrapper for audio_generic_write */
     .write    = coreaudio_write,
+  /* wrapper for audio_generic_buffer_get_free */
+    .buffer_get_free = coreaudio_buffer_get_free,
   /* wrapper for audio_generic_get_buffer_out */
     .get_buffer_out = coreaudio_get_buffer_out,
   /* wrapper for audio_generic_put_buffer_out */
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 4cdf19ab67..a0c61fb11c 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -411,6 +411,11 @@ static void dsound_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
+static size_t dsound_buffer_get_free(HWVoiceOut *hw)
+{
+    return INT_MAX;
+}
+
 static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
@@ -686,6 +691,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .init_out = dsound_init_out,
     .fini_out = dsound_fini_out,
     .write    = audio_generic_write,
+    .buffer_get_free = dsound_buffer_get_free,
     .get_buffer_out = dsound_get_buffer_out,
     .put_buffer_out = dsound_put_buffer_out,
     .enable_out = dsound_enable_out,
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 72ed7c4929..07848d9991 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -628,6 +628,7 @@ static struct audio_pcm_ops jack_pcm_ops = {
     .init_out       = qjack_init_out,
     .fini_out       = qjack_fini_out,
     .write          = qjack_write,
+    .buffer_get_free = audio_generic_buffer_get_free,
     .run_buffer_out = audio_generic_run_buffer_out,
     .enable_out     = qjack_enable_out,
 
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 05798ea210..0b932056fa 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -118,6 +118,7 @@ static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
     .write    = no_write,
+    .buffer_get_free = audio_generic_buffer_get_free,
     .run_buffer_out = audio_generic_run_buffer_out,
     .enable_out = no_enable_out,
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index a7dcaa31ad..7c46fef68c 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -391,6 +391,17 @@ static void oss_run_buffer_out(HWVoiceOut *hw)
     }
 }
 
+static size_t oss_buffer_get_free(HWVoiceOut *hw)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *)hw;
+
+    if (oss->mmapped) {
+        return oss_get_available_bytes(oss);
+    } else {
+        return audio_generic_buffer_get_free(hw);
+    }
+}
+
 static void *oss_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
@@ -754,6 +765,7 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .init_out = oss_init_out,
     .fini_out = oss_fini_out,
     .write    = oss_write,
+    .buffer_get_free = oss_buffer_get_free,
     .run_buffer_out = oss_run_buffer_out,
     .get_buffer_out = oss_get_buffer_out,
     .put_buffer_out = oss_put_buffer_out,
diff --git a/audio/paaudio.c b/audio/paaudio.c
index b052084698..0cb0c83546 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -202,6 +202,11 @@ unlock_and_fail:
     return 0;
 }
 
+static size_t qpa_buffer_get_free(HWVoiceOut *hw)
+{
+    return INT_MAX;
+}
+
 static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     PAVoiceOut *p = (PAVoiceOut *) hw;
@@ -860,6 +865,7 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
+    .buffer_get_free = qpa_buffer_get_free,
     .get_buffer_out = qpa_get_buffer_out,
     .put_buffer_out = qpa_write, /* pa handles it */
     .volume_out = qpa_volume_out,
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 21b7a0484b..cb931d0fda 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -253,6 +253,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         return ret;                                                     \
     }
 
+SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
 SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                  (hw, size), *size = 0, sdl_unlock)
 SDL_WRAPPER_FUNC(put_buffer_out, size_t,
@@ -350,6 +351,8 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .fini_out = sdl_fini_out,
   /* wrapper for audio_generic_write */
     .write    = sdl_write,
+  /* wrapper for audio_generic_buffer_get_free */
+    .buffer_get_free = sdl_buffer_get_free,
   /* wrapper for audio_generic_get_buffer_out */
     .get_buffer_out = sdl_get_buffer_out,
   /* wrapper for audio_generic_put_buffer_out */
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index c062742622..1fb0571dcc 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -120,6 +120,11 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
 
+static size_t line_out_buffer_get_free(HWVoiceOut *hw)
+{
+    return INT_MAX;
+}
+
 static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
@@ -282,6 +287,7 @@ static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
     .fini_out = line_out_fini,
     .write    = audio_generic_write,
+    .buffer_get_free = line_out_buffer_get_free,
     .get_buffer_out = line_out_get_buffer,
     .put_buffer_out = line_out_put_buffer,
     .enable_out = line_out_enable,
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 20e6853f85..ac666335c7 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -197,6 +197,7 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
     .write    = wav_write_out,
+    .buffer_get_free = audio_generic_buffer_get_free,
     .run_buffer_out = audio_generic_run_buffer_out,
     .enable_out = wav_enable_out,
 };
-- 
2.26.2


