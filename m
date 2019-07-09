Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C079C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB03920656
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8go0PQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB03920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvVl-0003Ug-1g
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyQ-0004Mv-Mf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-0003fI-Dj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyJ-0003WL-QY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p17so10938122wrf.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K5vThfXlR4Qq387gOu9eXOu+S/m4S5yfacvAkB0HSso=;
 b=P8go0PQVZNQHHY9GY70BNCrXsi3ABbIHdUcFKUhuC7sskPnWkxzflgvMQHb2xpyR4S
 mNUGpyA60qZyzsI1A3IV8kiCQBuj16UNilGAJwqkM+pt3nVLARAvdvvR9+QGWj+qyY8U
 CzIwTZ+1GdTAdIwZoheHqZjp0E7ge7tq1/tbu9HljrshK2kyJ30CnS46gFB2TeD/Jhy0
 K84/TNVSAW4cwdonwwPdvKFSeNjlhGZf6hoqeEX4L+F+eVB/NqU/8X8O2f1KvDoFELP4
 K2NwwPEoNm11nBWgGHUYHSCthzeWFqcCvIcaFCOkKlBfO1j/3UfbUD3m+Cug3YmBa28s
 sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K5vThfXlR4Qq387gOu9eXOu+S/m4S5yfacvAkB0HSso=;
 b=hGWZbcPgftEUoJxzC9TnGN2x6pikbC/9zchYt3bYc4vPMQuNRuZ7h30b8NHvAd3Cf4
 8e+5Xb8HCWKoQtogE3SC4A78gxKDt030lGJIhHMPkmhfLMYOuGvJvp+uOD4DwcK7pPnx
 UMfCv5VLQBiDlkmMBagL8EXYmrhKbFS1OtqfyCpSXUXCYnIYcIoOfLQOq1lCIk/GOkeN
 d6efeg5wixxF26fPBOJ9vnsNOoZe4UQWjaIamHef5t3Aqx7uoLsYVy6BZACRSoeXRPkM
 fMP16TxtXYni1UW26eQ/500+Mqp3bciyKfjDuoQMS9W19xtfjlhzJ3UiP1dfAY37Lrc0
 MoBQ==
X-Gm-Message-State: APjAAAWB8mhfHSDs1x1xF/AO72FkrtmJ/zAtmuKct/RQ99m5Jz94dDVu
 FG0kSc77QOIQtoq/OEq6aQOafxem
X-Google-Smtp-Source: APXvYqy/mIv81Jr8g/6GKeoisixe1VVamQNxrmSg+PFkeI8E7QSGJlMnknIHwrpb5GMuQYbWRAoSrg==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr1561756wro.112.1562697358407; 
 Tue, 09 Jul 2019 11:35:58 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:58 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:47 +0200
Message-Id: <d1b11399ed3d3cef0b110d5d4f7cfb5d6f65a89e.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PATCH 07/11] audio: remove audio_MIN, audio_MAX
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
Cc: Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's already a MIN and MAX macro in include/qemu/osdep.h, use them
instead.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h             | 17 -----------------
 audio/alsaaudio.c         |  6 +++---
 audio/audio.c             | 20 ++++++++++----------
 audio/coreaudio.c         |  2 +-
 audio/dsoundaudio.c       |  2 +-
 audio/noaudio.c           | 10 +++++-----
 audio/ossaudio.c          |  6 +++---
 audio/paaudio.c           | 12 ++++++------
 audio/sdlaudio.c          |  6 +++---
 audio/spiceaudio.c        | 10 +++++-----
 audio/wavaudio.c          |  4 ++--
 hw/audio/ac97.c           | 10 +++++-----
 hw/audio/adlib.c          |  4 ++--
 hw/audio/cs4231a.c        |  4 ++--
 hw/audio/es1370.c         |  6 +++---
 hw/audio/gus.c            |  6 +++---
 hw/audio/hda-codec.c      | 16 ++++++++--------
 hw/audio/milkymist-ac97.c |  8 ++++----
 hw/audio/pcspk.c          |  2 +-
 hw/audio/sb16.c           |  2 +-
 hw/audio/wm8750.c         |  4 ++--
 21 files changed, 70 insertions(+), 87 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index c0722a5cda..4a95758516 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -146,23 +146,6 @@ static inline void *advance (void *p, int incr)
     return (d + incr);
 }
 
-#ifdef __GNUC__
-#define audio_MIN(a, b) ( __extension__ ({      \
-    __typeof (a) ta = a;                        \
-    __typeof (b) tb = b;                        \
-    ((ta)>(tb)?(tb):(ta));                      \
-}))
-
-#define audio_MAX(a, b) ( __extension__ ({      \
-    __typeof (a) ta = a;                        \
-    __typeof (b) tb = b;                        \
-    ((ta)<(tb)?(tb):(ta));                      \
-}))
-#else
-#define audio_MIN(a, b) ((a)>(b)?(b):(a))
-#define audio_MAX(a, b) ((a)<(b)?(b):(a))
-#endif
-
 int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels);
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3745c823ad..6b9e0f06af 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -634,7 +634,7 @@ static void alsa_write_pending (ALSAVoiceOut *alsa)
 
     while (alsa->pending) {
         int left_till_end_samples = hw->samples - alsa->wpos;
-        int len = audio_MIN (alsa->pending, left_till_end_samples);
+        int len = MIN (alsa->pending, left_till_end_samples);
         char *src = advance (alsa->pcm_buf, alsa->wpos << hw->info.shift);
 
         while (len) {
@@ -697,7 +697,7 @@ static int alsa_run_out (HWVoiceOut *hw, int live)
         return 0;
     }
 
-    decr = audio_MIN (live, avail);
+    decr = MIN (live, avail);
     decr = audio_pcm_hw_clip_out (hw, alsa->pcm_buf, decr, alsa->pending);
     alsa->pending += decr;
     alsa_write_pending (alsa);
@@ -915,7 +915,7 @@ static int alsa_run_in (HWVoiceIn *hw)
         }
     }
 
-    decr = audio_MIN (dead, avail);
+    decr = MIN (dead, avail);
     if (!decr) {
         return 0;
     }
diff --git a/audio/audio.c b/audio/audio.c
index 82dd0e3e13..6bf30ac9b3 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -533,7 +533,7 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active) {
-            m = audio_MIN (m, sw->total_hw_samples_acquired);
+            m = MIN (m, sw->total_hw_samples_acquired);
         }
     }
     return m;
@@ -553,14 +553,14 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
                            int live, int pending)
 {
     int left = hw->samples - pending;
-    int len = audio_MIN (left, live);
+    int len = MIN (left, live);
     int clipped = 0;
 
     while (len) {
         struct st_sample *src = hw->mix_buf + hw->rpos;
         uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
         int samples_till_end_of_buf = hw->samples - hw->rpos;
-        int samples_to_clip = audio_MIN (len, samples_till_end_of_buf);
+        int samples_to_clip = MIN (len, samples_till_end_of_buf);
 
         hw->clip (dst, src, samples_to_clip);
 
@@ -614,7 +614,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
     }
 
     swlim = (live * sw->ratio) >> 32;
-    swlim = audio_MIN (swlim, samples);
+    swlim = MIN (swlim, samples);
 
     while (swlim) {
         src = hw->conv_buf + rpos;
@@ -662,7 +662,7 @@ static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active || !sw->empty) {
-            m = audio_MIN (m, sw->total_hw_samples_mixed);
+            m = MIN (m, sw->total_hw_samples_mixed);
             nb_live += 1;
         }
     }
@@ -725,7 +725,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
 
     dead = hwsamples - live;
     swlim = ((int64_t) dead << 32) / sw->ratio;
-    swlim = audio_MIN (swlim, samples);
+    swlim = MIN (swlim, samples);
     if (swlim) {
         sw->conv (sw->buf, buf, swlim);
 
@@ -737,7 +737,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
     while (swlim) {
         dead = hwsamples - live;
         left = hwsamples - wpos;
-        blck = audio_MIN (dead, left);
+        blck = MIN (dead, left);
         if (!blck) {
             break;
         }
@@ -1029,7 +1029,7 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
             n = samples;
             while (n) {
                 int till_end_of_hw = hw->samples - rpos2;
-                int to_write = audio_MIN (till_end_of_hw, n);
+                int to_write = MIN (till_end_of_hw, n);
                 int bytes = to_write << hw->info.shift;
                 int written;
 
@@ -1047,7 +1047,7 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
         }
     }
 
-    n = audio_MIN (samples, hw->samples - rpos);
+    n = MIN (samples, hw->samples - rpos);
     mixeng_clear (hw->mix_buf + rpos, n);
     mixeng_clear (hw->mix_buf, samples - n);
 }
@@ -1203,7 +1203,7 @@ static void audio_run_capture (AudioState *s)
         rpos = hw->rpos;
         while (live) {
             int left = hw->samples - rpos;
-            int to_capture = audio_MIN (live, left);
+            int to_capture = MIN (live, left);
             struct st_sample *src;
             struct capture_callback *cb;
 
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 4bec6c8c5c..f0ab4014a8 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -413,7 +413,7 @@ static int coreaudio_run_out (HWVoiceOut *hw, int live)
                 core->live);
     }
 
-    decr = audio_MIN (core->decr, live);
+    decr = MIN (core->decr, live);
     core->decr -= decr;
 
     core->live = live - decr;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 5da4c864c3..07260f881e 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -707,7 +707,7 @@ static int dsound_run_in (HWVoiceIn *hw)
     if (!len) {
         return 0;
     }
-    len = audio_MIN (len, dead);
+    len = MIN (len, dead);
 
     err = dsound_lock_in (
         dscb,
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 9b195dc52c..14a0e4ab29 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -52,11 +52,11 @@ static int no_run_out (HWVoiceOut *hw, int live)
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - no->old_ticks;
     bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-    bytes = audio_MIN(bytes, INT_MAX);
+    bytes = MIN(bytes, INT_MAX);
     samples = bytes >> hw->info.shift;
 
     no->old_ticks = now;
-    decr = audio_MIN (live, samples);
+    decr = MIN (live, samples);
     hw->rpos = (hw->rpos + decr) % hw->samples;
     return decr;
 }
@@ -111,9 +111,9 @@ static int no_run_in (HWVoiceIn *hw)
             muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
         no->old_ticks = now;
-        bytes = audio_MIN (bytes, INT_MAX);
+        bytes = MIN (bytes, INT_MAX);
         samples = bytes >> hw->info.shift;
-        samples = audio_MIN (samples, dead);
+        samples = MIN (samples, dead);
     }
     return samples;
 }
@@ -124,7 +124,7 @@ static int no_read (SWVoiceIn *sw, void *buf, int size)
      * useless resampling/mixing */
     int samples = size >> sw->info.shift;
     int total = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    int to_clear = audio_MIN (samples, total);
+    int to_clear = MIN (samples, total);
     sw->total_hw_samples_acquired += total;
     audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
     return to_clear << sw->info.shift;
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c0af065b6f..29139ef1f5 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -388,7 +388,7 @@ static void oss_write_pending (OSSVoiceOut *oss)
         int samples_written;
         ssize_t bytes_written;
         int samples_till_end = hw->samples - oss->wpos;
-        int samples_to_write = audio_MIN (oss->pending, samples_till_end);
+        int samples_to_write = MIN (oss->pending, samples_till_end);
         int bytes_to_write = samples_to_write << hw->info.shift;
         void *pcm = advance (oss->pcm_buf, oss->wpos << hw->info.shift);
 
@@ -437,7 +437,7 @@ static int oss_run_out (HWVoiceOut *hw, int live)
 
         pos = hw->rpos << hw->info.shift;
         bytes = audio_ring_dist (cntinfo.ptr, pos, bufsize);
-        decr = audio_MIN (bytes >> hw->info.shift, live);
+        decr = MIN (bytes >> hw->info.shift, live);
     }
     else {
         err = ioctl (oss->fd, SNDCTL_DSP_GETOSPACE, &abinfo);
@@ -456,7 +456,7 @@ static int oss_run_out (HWVoiceOut *hw, int live)
             return 0;
         }
 
-        decr = audio_MIN (abinfo.bytes >> hw->info.shift, live);
+        decr = MIN (abinfo.bytes >> hw->info.shift, live);
         if (!decr) {
             return 0;
         }
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 490bcd770e..9d46f11b0a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -235,7 +235,7 @@ static void *qpa_thread_out (void *arg)
             }
         }
 
-        decr = to_mix = audio_MIN(pa->live, pa->samples >> 5);
+        decr = to_mix = MIN(pa->live, pa->samples >> 5);
         rpos = pa->rpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -244,7 +244,7 @@ static void *qpa_thread_out (void *arg)
 
         while (to_mix) {
             int error;
-            int chunk = audio_MIN (to_mix, hw->samples - rpos);
+            int chunk = MIN (to_mix, hw->samples - rpos);
             struct st_sample *src = hw->mix_buf + rpos;
 
             hw->clip (pa->pcm_buf, src, chunk);
@@ -282,7 +282,7 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
         return 0;
     }
 
-    decr = audio_MIN (live, pa->decr);
+    decr = MIN (live, pa->decr);
     pa->decr -= decr;
     pa->live = live - decr;
     hw->rpos = pa->rpos;
@@ -327,7 +327,7 @@ static void *qpa_thread_in (void *arg)
             }
         }
 
-        incr = to_grab = audio_MIN(pa->dead, pa->samples >> 5);
+        incr = to_grab = MIN(pa->dead, pa->samples >> 5);
         wpos = pa->wpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -336,7 +336,7 @@ static void *qpa_thread_in (void *arg)
 
         while (to_grab) {
             int error;
-            int chunk = audio_MIN (to_grab, hw->samples - wpos);
+            int chunk = MIN (to_grab, hw->samples - wpos);
             void *buf = advance (pa->pcm_buf, wpos);
 
             if (qpa_simple_read (pa, buf,
@@ -375,7 +375,7 @@ static int qpa_run_in (HWVoiceIn *hw)
 
     live = audio_pcm_hw_get_live_in (hw);
     dead = hw->samples - live;
-    incr = audio_MIN (dead, pa->incr);
+    incr = MIN (dead, pa->incr);
     pa->incr -= incr;
     pa->dead = dead - incr;
     hw->wpos = pa->wpos;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index e7179ff1d4..42f7614124 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -193,10 +193,10 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 
     /* dolog ("in callback samples=%d live=%d\n", samples, sdl->live); */
 
-    to_mix = audio_MIN(samples, sdl->live);
+    to_mix = MIN(samples, sdl->live);
     decr = to_mix;
     while (to_mix) {
-        int chunk = audio_MIN(to_mix, hw->samples - hw->rpos);
+        int chunk = MIN(to_mix, hw->samples - hw->rpos);
         struct st_sample *src = hw->mix_buf + hw->rpos;
 
         /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
@@ -236,7 +236,7 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
                 sdl->live);
     }
 
-    decr = audio_MIN (sdl->decr, live);
+    decr = MIN (sdl->decr, live);
     sdl->decr -= decr;
 
     sdl->live = live;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 0ead5ae43a..6f4a0558f8 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -164,20 +164,20 @@ static int line_out_run (HWVoiceOut *hw, int live)
     }
 
     decr = rate_get_samples (&hw->info, &out->rate);
-    decr = audio_MIN (live, decr);
+    decr = MIN (live, decr);
 
     samples = decr;
     rpos = hw->rpos;
     while (samples) {
         int left_till_end_samples = hw->samples - rpos;
-        int len = audio_MIN (samples, left_till_end_samples);
+        int len = MIN (samples, left_till_end_samples);
 
         if (!out->frame) {
             spice_server_playback_get_buffer (&out->sin, &out->frame, &out->fsize);
             out->fpos = out->frame;
         }
         if (out->frame) {
-            len = audio_MIN (len, out->fsize);
+            len = MIN (len, out->fsize);
             hw->clip (out->fpos, hw->mix_buf + rpos, len);
             out->fsize -= len;
             out->fpos  += len;
@@ -295,7 +295,7 @@ static int line_in_run (HWVoiceIn *hw)
     }
 
     delta_samp = rate_get_samples (&hw->info, &in->rate);
-    num_samples = audio_MIN (num_samples, delta_samp);
+    num_samples = MIN (num_samples, delta_samp);
 
     ready = spice_server_record_get_samples (&in->sin, in->samples, num_samples);
     samples = in->samples;
@@ -305,7 +305,7 @@ static int line_in_run (HWVoiceIn *hw)
         ready = LINE_IN_SAMPLES;
     }
 
-    num_samples = audio_MIN (ready, num_samples);
+    num_samples = MIN (ready, num_samples);
 
     if (hw->wpos + num_samples > hw->samples) {
         len[0] = hw->samples - hw->wpos;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 803b6cb1f3..bbf3f3b346 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -59,12 +59,12 @@ static int wav_run_out (HWVoiceOut *hw, int live)
     }
 
     wav->old_ticks = now;
-    decr = audio_MIN (live, samples);
+    decr = MIN (live, samples);
     samples = decr;
     rpos = hw->rpos;
     while (samples) {
         int left_till_end_samples = hw->samples - rpos;
-        int convert_samples = audio_MIN (samples, left_till_end_samples);
+        int convert_samples = MIN (samples, left_till_end_samples);
 
         src = hw->mix_buf + rpos;
         dst = advance (wav->pcm_buf, rpos << hw->info.shift);
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 0d8e524233..060bafdac3 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -964,7 +964,7 @@ static int write_audio (AC97LinkState *s, AC97BusMasterRegs *r,
     uint32_t temp = r->picb << 1;
     uint32_t written = 0;
     int to_copy = 0;
-    temp = audio_MIN (temp, max);
+    temp = MIN (temp, max);
 
     if (!temp) {
         *stop = 1;
@@ -973,7 +973,7 @@ static int write_audio (AC97LinkState *s, AC97BusMasterRegs *r,
 
     while (temp) {
         int copied;
-        to_copy = audio_MIN (temp, sizeof (tmpbuf));
+        to_copy = MIN (temp, sizeof (tmpbuf));
         pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
         copied = AUD_write (s->voice_po, tmpbuf, to_copy);
         dolog ("write_audio max=%x to_copy=%x copied=%x\n",
@@ -1019,7 +1019,7 @@ static void write_bup (AC97LinkState *s, int elapsed)
     }
 
     while (elapsed) {
-        int temp = audio_MIN (elapsed, sizeof (s->silence));
+        int temp = MIN (elapsed, sizeof (s->silence));
         while (temp) {
             int copied = AUD_write (s->voice_po, s->silence, temp);
             if (!copied)
@@ -1040,7 +1040,7 @@ static int read_audio (AC97LinkState *s, AC97BusMasterRegs *r,
     int to_copy = 0;
     SWVoiceIn *voice = (r - s->bm_regs) == MC_INDEX ? s->voice_mc : s->voice_pi;
 
-    temp = audio_MIN (temp, max);
+    temp = MIN (temp, max);
 
     if (!temp) {
         *stop = 1;
@@ -1049,7 +1049,7 @@ static int read_audio (AC97LinkState *s, AC97BusMasterRegs *r,
 
     while (temp) {
         int acquired;
-        to_copy = audio_MIN (temp, sizeof (tmpbuf));
+        to_copy = MIN (temp, sizeof (tmpbuf));
         acquired = AUD_read (voice, tmpbuf, to_copy);
         if (!acquired) {
             *stop = 1;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index df2e781788..1b32c4ff7f 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -195,7 +195,7 @@ static void adlib_callback (void *opaque, int free)
         return;
     }
 
-    to_play = audio_MIN (s->left, samples);
+    to_play = MIN (s->left, samples);
     while (to_play) {
         written = write_audio (s, to_play);
 
@@ -210,7 +210,7 @@ static void adlib_callback (void *opaque, int free)
         }
     }
 
-    samples = audio_MIN (samples, s->samples - s->pos);
+    samples = MIN (samples, s->samples - s->pos);
     if (!samples) {
         return;
     }
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index e3ea830b47..ca3af8a987 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -535,7 +535,7 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
         int copied;
         size_t to_copy;
 
-        to_copy = audio_MIN (temp, left);
+        to_copy = MIN (temp, left);
         if (to_copy > sizeof (tmpbuf)) {
             to_copy = sizeof (tmpbuf);
         }
@@ -578,7 +578,7 @@ static int cs_dma_read (void *opaque, int nchan, int dma_pos, int dma_len)
         till = (s->dregs[Playback_Lower_Base_Count]
             | (s->dregs[Playback_Upper_Base_Count] << 8)) << s->shift;
         till -= s->transferred;
-        copy = audio_MIN (till, copy);
+        copy = MIN (till, copy);
     }
 
     if ((copy <= 0) || (dma_len <= 0)) {
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 7589671d20..50b144ded0 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -645,7 +645,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     int size = d->frame_cnt & 0xffff;
     int left = ((size - cnt + 1) << 2) + d->leftover;
     int transferred = 0;
-    int temp = audio_MIN (max, audio_MIN (left, csc_bytes));
+    int temp = MIN (max, MIN (left, csc_bytes));
     int index = d - &s->chan[0];
 
     addr += (cnt << 2) + d->leftover;
@@ -654,7 +654,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
         while (temp) {
             int acquired, to_copy;
 
-            to_copy = audio_MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
             acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
             if (!acquired)
                 break;
@@ -672,7 +672,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
         while (temp) {
             int copied, to_copy;
 
-            to_copy = audio_MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy = MIN ((size_t) temp, sizeof (tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
             copied = AUD_write (voice, tmpbuf, to_copy);
             if (!copied)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 566864bc9e..325efd8df7 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -117,7 +117,7 @@ static void GUS_callback (void *opaque, int free)
     GUSState *s = opaque;
 
     samples = free >> s->shift;
-    to_play = audio_MIN (samples, s->left);
+    to_play = MIN (samples, s->left);
 
     while (to_play) {
         int written = write_audio (s, to_play);
@@ -132,7 +132,7 @@ static void GUS_callback (void *opaque, int free)
         net += written;
     }
 
-    samples = audio_MIN (samples, s->samples);
+    samples = MIN (samples, s->samples);
     if (samples) {
         gus_mixvoices (&s->emu, s->freq, samples, s->mixbuf);
 
@@ -192,7 +192,7 @@ static int GUS_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     ldebug ("read DMA %#x %d\n", dma_pos, dma_len);
     mode = k->has_autoinitialization(s->isa_dma, s->emu.gusdma);
     while (left) {
-        int to_copy = audio_MIN ((size_t) left, sizeof (tmpbuf));
+        int to_copy = MIN ((size_t) left, sizeof (tmpbuf));
         int copied;
 
         ldebug ("left=%d to_copy=%d pos=%d\n", left, to_copy, pos);
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 967a10f189..c8f513d3ff 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -234,10 +234,10 @@ static void hda_audio_input_timer(void *opaque)
         goto out_timer;
     }
 
-    int64_t to_transfer = audio_MIN(wpos - rpos, wanted_rpos - rpos);
+    int64_t to_transfer = MIN(wpos - rpos, wanted_rpos - rpos);
     while (to_transfer) {
         uint32_t start = (rpos & B_MASK);
-        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk = MIN(B_SIZE - start, to_transfer);
         int rc = hda_codec_xfer(
                 &st->state->hda, st->stream, false, st->buf + start, chunk);
         if (!rc) {
@@ -262,13 +262,13 @@ static void hda_audio_input_cb(void *opaque, int avail)
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
 
-    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
+    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), avail);
 
     hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >> 1)));
 
     while (to_transfer) {
         uint32_t start = (uint32_t) (wpos & B_MASK);
-        uint32_t chunk = (uint32_t) audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
         uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
         wpos += read;
         to_transfer -= read;
@@ -298,10 +298,10 @@ static void hda_audio_output_timer(void *opaque)
         goto out_timer;
     }
 
-    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
+    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
     while (to_transfer) {
         uint32_t start = (wpos & B_MASK);
-        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk = MIN(B_SIZE - start, to_transfer);
         int rc = hda_codec_xfer(
                 &st->state->hda, st->stream, true, st->buf + start, chunk);
         if (!rc) {
@@ -326,7 +326,7 @@ static void hda_audio_output_cb(void *opaque, int avail)
     int64_t wpos = st->wpos;
     int64_t rpos = st->rpos;
 
-    int64_t to_transfer = audio_MIN(wpos - rpos, avail);
+    int64_t to_transfer = MIN(wpos - rpos, avail);
 
     if (wpos - rpos == B_SIZE) {
         /* drop buffer, reset timer adjust */
@@ -341,7 +341,7 @@ static void hda_audio_output_cb(void *opaque, int avail)
 
     while (to_transfer) {
         uint32_t start = (uint32_t) (rpos & B_MASK);
-        uint32_t chunk = (uint32_t) audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
         uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
         rpos += written;
         to_transfer -= written;
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 4835229326..929b856587 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -184,7 +184,7 @@ static void ac97_in_cb(void *opaque, int avail_b)
     MilkymistAC97State *s = opaque;
     uint8_t buf[4096];
     uint32_t remaining = s->regs[R_U_REMAINING];
-    int temp = audio_MIN(remaining, avail_b);
+    int temp = MIN(remaining, avail_b);
     uint32_t addr = s->regs[R_U_ADDR];
     int transferred = 0;
 
@@ -198,7 +198,7 @@ static void ac97_in_cb(void *opaque, int avail_b)
     while (temp) {
         int acquired, to_copy;
 
-        to_copy = audio_MIN(temp, sizeof(buf));
+        to_copy = MIN(temp, sizeof(buf));
         acquired = AUD_read(s->voice_in, buf, to_copy);
         if (!acquired) {
             break;
@@ -227,7 +227,7 @@ static void ac97_out_cb(void *opaque, int free_b)
     MilkymistAC97State *s = opaque;
     uint8_t buf[4096];
     uint32_t remaining = s->regs[R_D_REMAINING];
-    int temp = audio_MIN(remaining, free_b);
+    int temp = MIN(remaining, free_b);
     uint32_t addr = s->regs[R_D_ADDR];
     int transferred = 0;
 
@@ -241,7 +241,7 @@ static void ac97_out_cb(void *opaque, int free_b)
     while (temp) {
         int copied, to_copy;
 
-        to_copy = audio_MIN(temp, sizeof(buf));
+        to_copy = MIN(temp, sizeof(buf));
         cpu_physical_memory_read(addr, buf, to_copy);
         copied = AUD_write(s->voice_out, buf, to_copy);
         if (!copied) {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 01127304c2..6bb1455c1b 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -103,7 +103,7 @@ static void pcspk_callback(void *opaque, int free)
     }
 
     while (free > 0) {
-        n = audio_MIN(s->samples - s->play_pos, (unsigned int)free);
+        n = MIN(s->samples - s->play_pos, (unsigned int)free);
         n = AUD_write(s->voice, &s->sample_buf[s->play_pos], n);
         if (!n)
             break;
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6b604979cf..5182eba8eb 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1168,7 +1168,7 @@ static int write_audio (SB16State *s, int nchan, int dma_pos,
         int copied;
         size_t to_copy;
 
-        to_copy = audio_MIN (temp, left);
+        to_copy = MIN (temp, left);
         if (to_copy > sizeof (tmpbuf)) {
             to_copy = sizeof (tmpbuf);
         }
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index dfb4156ff4..ab04bfa2c3 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -69,7 +69,7 @@ static inline void wm8750_in_load(WM8750State *s)
 {
     if (s->idx_in + s->req_in <= sizeof(s->data_in))
         return;
-    s->idx_in = audio_MAX(0, (int) sizeof(s->data_in) - s->req_in);
+    s->idx_in = MAX(0, (int) sizeof(s->data_in) - s->req_in);
     AUD_read(*s->in[0], s->data_in + s->idx_in,
              sizeof(s->data_in) - s->idx_in);
 }
@@ -100,7 +100,7 @@ static void wm8750_audio_out_cb(void *opaque, int free_b)
         wm8750_out_flush(s);
     } else
         s->req_out = free_b - s->idx_out;
- 
+
     s->data_req(s->opaque, s->req_out >> 2, s->req_in >> 2);
 }
 
-- 
2.22.0


