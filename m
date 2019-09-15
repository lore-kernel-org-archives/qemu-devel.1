Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB2C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A98E20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4oG9ViE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A98E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aKs-0002Fw-6A
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7r-0006Gx-Ul
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7p-00022b-Fm
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:33373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7p-00022K-5b
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c4so2493479edl.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V77nQ6717tiqStvGYOQBd2dQ85v6ib6ygSXWUJLT3tk=;
 b=P4oG9ViEzB2It3t4eZ09nBY24qOJkwoXbxDxEJiLeu3CE7dNo1V/HIOYGrG5IYCwHw
 eKk1Di9M/Sw9DDqvw7l5XpD8CcyLX3YL2Gy2l3FHWGEiyDOg6mPw2wdv9wovQF5vMs50
 g9BVUWaaf6M28nebtT7MrqufBIHysT2F+QI52yWDQ8HDD9NETiwIJ5xjAjokRquSB/wz
 2fA/k1HDq+JMwGiEO60CZeptaaBnDAcK8D6ZT1RgpNhOUtHRoFvbgWpeL5hjz4nT5FaM
 F3EejLcmmtqMhhYXwzcl+P6CfOC4l7rlYKLpqx4bwlE6waApW7gOlgDGZ3oE+R70wCIX
 7Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V77nQ6717tiqStvGYOQBd2dQ85v6ib6ygSXWUJLT3tk=;
 b=q8S1pOiqjS4il/dbhZ1KRQOohJliodCzStJhbhIA1JakegfHp7hznOywZeu+IJXP7e
 t8zjheSvnf2D7RkRj2rC5v5guCTSTlPPBICP/OkM48VevMSnGjBBWQuTTjPdlpOXobI6
 N8d5tcjmg/wFZ3QBbbmzzES3l26K7zOglJie5oK+AanlXBtc2ZBSr1O0ucGTOB7AJSbm
 9rOL1jFKeYGtCINgiDXWPVLSZaTsvCBU8dNClcM82+bxPqlhr4j64t9grRW7oUm2fFVy
 GJo0SfoEKzFSM1lyr/lEafF9EN+aZ+cE86+J5WB2WfoPC3956P6LPthoUkfJrlyO0mnR
 OXJQ==
X-Gm-Message-State: APjAAAUIX4CK9DWtUjbWl10Hx6ZnJ08sEuNasfyhhXmhe7nPa9vmpNUN
 x0AqeXGtHtvH6sWMofeQ0RDyJcgL
X-Google-Smtp-Source: APXvYqzWGoXsK63cWuH33ZPaa+ZSgpsqBURtzecuhxjtbCwcXpYuDZcHeFA6UGxyo3DH+T11/TCtKw==
X-Received: by 2002:a50:fe14:: with SMTP id f20mr15536246edt.206.1568575435515; 
 Sun, 15 Sep 2019 12:23:55 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:55 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:35 +0200
Message-Id: <43893f0b3fa0631cbb9971fc2bc6924deddcc729.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52f
Subject: [Qemu-devel] [PATCH v3 19/24] audio: replace shift in
 audio_pcm_info with bytes_per_frame
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bit shifting trick worked because the number of bytes per frame was
always a power-of-two (since QEMU only supports mono, stereo and 8, 16
and 32 bit samples).  But if we want to add support for surround sound,
this no longer holds true.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c       | 11 +++---
 audio/audio.c           | 74 ++++++++++++++++++++---------------------
 audio/audio_int.h       |  3 +-
 audio/coreaudio.c       |  4 +--
 audio/dsound_template.h | 10 +++---
 audio/dsoundaudio.c     |  4 +--
 audio/noaudio.c         |  2 +-
 audio/ossaudio.c        | 14 ++++----
 audio/spiceaudio.c      |  3 +-
 audio/wavaudio.c        |  6 ++--
 10 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index cfe42284a6..eddf013a53 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -602,7 +602,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     size_t pos = 0;
-    size_t len_frames = len >> hw->info.shift;
+    size_t len_frames = len / hw->info.bytes_per_frame;
 
     while (len_frames) {
         char *src = advance(buf, pos);
@@ -648,7 +648,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
             }
         }
 
-        pos += written << hw->info.shift;
+        pos += written * hw->info.bytes_per_frame;
         if (written < len_frames) {
             break;
         }
@@ -802,7 +802,8 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
         void *dst = advance(buf, pos);
         snd_pcm_sframes_t nread;
 
-        nread = snd_pcm_readi(alsa->handle, dst, len >> hw->info.shift);
+        nread = snd_pcm_readi(
+            alsa->handle, dst, len / hw->info.bytes_per_frame);
 
         if (nread <= 0) {
             switch (nread) {
@@ -828,8 +829,8 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
             }
         }
 
-        pos += nread << hw->info.shift;
-        len -= nread << hw->info.shift;
+        pos += nread * hw->info.bytes_per_frame;
+        len -= nread * hw->info.bytes_per_frame;
     }
 
     return pos;
diff --git a/audio/audio.c b/audio/audio.c
index f1c145dfcd..c00f4deddd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -299,12 +299,13 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
 
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
 {
-    int bits = 8, sign = 0, shift = 0;
+    int bits = 8, sign = 0, mul;
 
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         sign = 1;
     case AUDIO_FORMAT_U8:
+        mul = 1;
         break;
 
     case AUDIO_FORMAT_S16:
@@ -312,7 +313,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits = 16;
-        shift = 1;
+        mul = 2;
         break;
 
     case AUDIO_FORMAT_S32:
@@ -320,7 +321,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits = 32;
-        shift = 2;
+        mul = 4;
         break;
 
     default:
@@ -331,9 +332,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
     info->bits = bits;
     info->sign = sign;
     info->nchannels = as->nchannels;
-    info->shift = (as->nchannels == 2) + shift;
-    info->align = (1 << info->shift) - 1;
-    info->bytes_per_second = info->freq << info->shift;
+    info->bytes_per_frame = as->nchannels * mul;
+    info->bytes_per_second = info->freq * info->bytes_per_frame;
     info->swap_endianness = (as->endianness != AUDIO_HOST_ENDIANNESS);
 }
 
@@ -344,26 +344,25 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
     }
 
     if (info->sign) {
-        memset (buf, 0x00, len << info->shift);
+        memset(buf, 0x00, len * info->bytes_per_frame);
     }
     else {
         switch (info->bits) {
         case 8:
-            memset (buf, 0x80, len << info->shift);
+            memset(buf, 0x80, len * info->bytes_per_frame);
             break;
 
         case 16:
             {
                 int i;
                 uint16_t *p = buf;
-                int shift = info->nchannels - 1;
                 short s = INT16_MAX;
 
                 if (info->swap_endianness) {
                     s = bswap16 (s);
                 }
 
-                for (i = 0; i < len << shift; i++) {
+                for (i = 0; i < len * info->nchannels; i++) {
                     p[i] = s;
                 }
             }
@@ -373,14 +372,13 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
             {
                 int i;
                 uint32_t *p = buf;
-                int shift = info->nchannels - 1;
                 int32_t s = INT32_MAX;
 
                 if (info->swap_endianness) {
                     s = bswap32 (s);
                 }
 
-                for (i = 0; i < len << shift; i++) {
+                for (i = 0; i < len * info->nchannels; i++) {
                     p[i] = s;
                 }
             }
@@ -558,7 +556,7 @@ static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 
     while (len) {
         st_sample *src = hw->mix_buf->samples + pos;
-        uint8_t *dst = advance(pcm_buf, clipped << hw->info.shift);
+        uint8_t *dst = advance(pcm_buf, clipped * hw->info.bytes_per_frame);
         size_t samples_till_end_of_buf = hw->mix_buf->size - pos;
         size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
 
@@ -607,7 +605,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
         return 0;
     }
 
-    samples = size >> sw->info.shift;
+    samples = size / sw->info.bytes_per_frame;
     if (!live) {
         return 0;
     }
@@ -642,7 +640,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 
     sw->clip (buf, sw->buf, ret);
     sw->total_hw_samples_acquired += total;
-    return ret << sw->info.shift;
+    return ret * sw->info.bytes_per_frame;
 }
 
 /*
@@ -715,7 +713,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     }
 
     wpos = (sw->hw->mix_buf->pos + live) % hwsamples;
-    samples = size >> sw->info.shift;
+    samples = size / sw->info.bytes_per_frame;
 
     dead = hwsamples - live;
     swlim = ((int64_t) dead << 32) / sw->ratio;
@@ -759,13 +757,13 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     dolog (
         "%s: write size %zu ret %zu total sw %zu\n",
         SW_NAME (sw),
-        size >> sw->info.shift,
+        size / sw->info.bytes_per_frame,
         ret,
         sw->total_hw_samples_mixed
         );
 #endif
 
-    return ret << sw->info.shift;
+    return ret * sw->info.bytes_per_frame;
 }
 
 #ifdef DEBUG_AUDIO
@@ -882,7 +880,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
 {
-    return sw->hw->mix_buf->size << sw->hw->info.shift;
+    return sw->hw->mix_buf->size * sw->hw->info.bytes_per_frame;
 }
 
 void AUD_set_active_out (SWVoiceOut *sw, int on)
@@ -998,10 +996,10 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     ldebug (
         "%s: get_avail live %d ret %" PRId64 "\n",
         SW_NAME (sw),
-        live, (((int64_t) live << 32) / sw->ratio) << sw->info.shift
+        live, (((int64_t) live << 32) / sw->ratio) * sw->info.bytes_per_frame
         );
 
-    return (((int64_t) live << 32) / sw->ratio) << sw->info.shift;
+    return (((int64_t) live << 32) / sw->ratio) * sw->info.bytes_per_frame;
 }
 
 static size_t audio_get_free(SWVoiceOut *sw)
@@ -1025,10 +1023,11 @@ static size_t audio_get_free(SWVoiceOut *sw)
 #ifdef DEBUG_OUT
     dolog ("%s: get_free live %d dead %d ret %" PRId64 "\n",
            SW_NAME (sw),
-           live, dead, (((int64_t) dead << 32) / sw->ratio) << sw->info.shift);
+           live, dead, (((int64_t) dead << 32) / sw->ratio) *
+           sw->info.bytes_per_frame);
 #endif
 
-    return (((int64_t) dead << 32) / sw->ratio) << sw->info.shift;
+    return (((int64_t) dead << 32) / sw->ratio) * sw->info.bytes_per_frame;
 }
 
 static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
@@ -1047,7 +1046,7 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
             while (n) {
                 size_t till_end_of_hw = hw->mix_buf->size - rpos2;
                 size_t to_write = MIN(till_end_of_hw, n);
-                size_t bytes = to_write << hw->info.shift;
+                size_t bytes = to_write * hw->info.bytes_per_frame;
                 size_t written;
 
                 sw->buf = hw->mix_buf->samples + rpos2;
@@ -1082,10 +1081,11 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
             return clipped + live;
         }
 
-        decr = MIN(size >> hw->info.shift, live);
+        decr = MIN(size / hw->info.bytes_per_frame, live);
         audio_pcm_hw_clip_out(hw, buf, decr);
-        proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
-            hw->info.shift;
+        proc = hw->pcm_ops->put_buffer_out(hw, buf,
+                                           decr * hw->info.bytes_per_frame) /
+            hw->info.bytes_per_frame;
 
         live -= proc;
         clipped += proc;
@@ -1234,16 +1234,16 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
 
     while (samples) {
         size_t proc;
-        size_t size = samples << hw->info.shift;
+        size_t size = samples * hw->info.bytes_per_frame;
         void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
 
-        assert((size & hw->info.align) == 0);
+        assert(size % hw->info.bytes_per_frame == 0);
         if (size == 0) {
             hw->pcm_ops->put_buffer_in(hw, buf, size);
             break;
         }
 
-        proc = MIN(size >> hw->info.shift,
+        proc = MIN(size / hw->info.bytes_per_frame,
                    conv_buf->size - conv_buf->pos);
 
         hw->conv(conv_buf->samples + conv_buf->pos, buf, proc);
@@ -1251,7 +1251,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
 
         samples -= proc;
         conv += proc;
-        hw->pcm_ops->put_buffer_in(hw, buf, proc << hw->info.shift);
+        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
     }
 
     return conv;
@@ -1325,7 +1325,7 @@ static void audio_run_capture (AudioState *s)
 
             for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
                 cb->ops.capture (cb->opaque, cap->buf,
-                                 to_capture << hw->info.shift);
+                                 to_capture * hw->info.bytes_per_frame);
             }
             rpos = (rpos + to_capture) % hw->mix_buf->size;
             live -= to_capture;
@@ -1378,7 +1378,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
     ssize_t start;
 
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->conv_buf->size << hw->info.shift;
+        size_t calc_size = hw->conv_buf->size * hw->info.bytes_per_frame;
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
         hw->pos_emul = hw->pending_emul = 0;
@@ -1414,7 +1414,7 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->mix_buf->size << hw->info.shift;
+        size_t calc_size = hw->mix_buf->size * hw->info.bytes_per_frame;
 
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
@@ -1833,7 +1833,7 @@ CaptureVoiceOut *AUD_add_capture(
 
         audio_pcm_init_info (&hw->info, as);
 
-        cap->buf = g_malloc0_n(hw->mix_buf->size, 1 << hw->info.shift);
+        cap->buf = g_malloc0_n(hw->mix_buf->size, hw->info.bytes_per_frame);
 
         hw->clip = mixeng_clip
             [hw->info.nchannels == 2]
@@ -2153,14 +2153,14 @@ size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - rate->start_ticks;
     bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
-    samples = (bytes - rate->bytes_sent) >> info->shift;
+    samples = (bytes - rate->bytes_sent) / info->bytes_per_frame;
     if (samples < 0 || samples > 65536) {
         AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)\n", samples);
         audio_rate_start(rate);
         samples = 0;
     }
 
-    ret = MIN(samples << info->shift, bytes_avail);
+    ret = MIN(samples * info->bytes_per_frame, bytes_avail);
     rate->bytes_sent += ret;
     return ret;
 }
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9176db249b..5ba2078346 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -43,8 +43,7 @@ struct audio_pcm_info {
     int sign;
     int freq;
     int nchannels;
-    int align;
-    int shift;
+    int bytes_per_frame;
     int bytes_per_second;
     int swap_endianness;
 };
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 1427c9f622..66f0f459cf 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -440,7 +440,7 @@ static OSStatus audioDeviceIOProc(
     }
 
     frameCount = core->audioDevicePropertyBufferFrameSize;
-    pending_frames = hw->pending_emul >> hw->info.shift;
+    pending_frames = hw->pending_emul / hw->info.bytes_per_frame;
 
     /* if there are not enough samples, set signal and return */
     if (pending_frames < frameCount) {
@@ -449,7 +449,7 @@ static OSStatus audioDeviceIOProc(
         return 0;
     }
 
-    len = frameCount << hw->info.shift;
+    len = frameCount * hw->info.bytes_per_frame;
     while (len) {
         size_t write_len;
         ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 9f10b688df..7a15f91ce5 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -98,8 +98,8 @@ static int glue (dsound_lock_, TYPE) (
         goto fail;
     }
 
-    if ((p1p && *p1p && (*blen1p & info->align)) ||
-        (p2p && *p2p && (*blen2p & info->align))) {
+    if ((p1p && *p1p && (*blen1p % info->bytes_per_frame)) ||
+        (p2p && *p2p && (*blen2p % info->bytes_per_frame))) {
         dolog("DirectSound returned misaligned buffer %ld %ld\n",
               *blen1p, *blen2p);
         glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p,
@@ -247,14 +247,14 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     obt_as.endianness = 0;
     audio_pcm_init_info (&hw->info, &obt_as);
 
-    if (bc.dwBufferBytes & hw->info.align) {
+    if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
         dolog (
             "GetCaps returned misaligned buffer size %ld, alignment %d\n",
-            bc.dwBufferBytes, hw->info.align + 1
+            bc.dwBufferBytes, hw->info.bytes_per_frame
             );
     }
     hw->size_emul = bc.dwBufferBytes;
-    hw->samples = bc.dwBufferBytes >> hw->info.shift;
+    hw->samples = bc.dwBufferBytes / hw->info.bytes_per_frame;
     ds->s = s;
 
 #ifdef DEBUG_DSOUND
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index d4a4757445..c265c0094b 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -320,8 +320,8 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
         return;
     }
 
-    len1 = blen1 >> hw->info.shift;
-    len2 = blen2 >> hw->info.shift;
+    len1 = blen1 / hw->info.bytes_per_frame;
+    len2 = blen2 / hw->info.bytes_per_frame;
 
 #ifdef DEBUG_DSOUND
     dolog ("clear %p,%ld,%ld %p,%ld,%ld\n",
diff --git a/audio/noaudio.c b/audio/noaudio.c
index ec8a287f36..ff99b253ff 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -91,7 +91,7 @@ static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
     NoVoiceIn *no = (NoVoiceIn *) hw;
     int64_t bytes = audio_rate_get_bytes(&hw->info, &no->rate, size);
 
-    audio_pcm_info_clear_buf(&hw->info, buf, bytes >> hw->info.shift);
+    audio_pcm_info_clear_buf(&hw->info, buf, bytes / hw->info.bytes_per_frame);
     return bytes;
 }
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0c4451e972..c43faeeea4 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -506,16 +506,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     oss->nfrags = obt.nfrags;
     oss->fragsize = obt.fragsize;
 
-    if (obt.nfrags * obt.fragsize & hw->info.align) {
+    if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
         dolog ("warning: Misaligned DAC buffer, size %d, alignment %d\n",
-               obt.nfrags * obt.fragsize, hw->info.align + 1);
+               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
 
-    hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
 
     oss->mmapped = 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        hw->size_emul = hw->samples << hw->info.shift;
+        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
         hw->buf_emul = mmap(
             NULL,
             hw->size_emul,
@@ -644,12 +644,12 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     oss->nfrags = obt.nfrags;
     oss->fragsize = obt.fragsize;
 
-    if (obt.nfrags * obt.fragsize & hw->info.align) {
+    if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
         dolog ("warning: Misaligned ADC buffer, size %d, alignment %d\n",
-               obt.nfrags * obt.fragsize, hw->info.align + 1);
+               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
 
-    hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
 
     oss->fd = fd;
     oss->dev = dev;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6ed7f7a79e..b6b5da4812 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -131,7 +131,8 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 
     if (out->frame) {
         *size = audio_rate_get_bytes(
-            &hw->info, &out->rate, (out->fsize - out->fpos) << hw->info.shift);
+            &hw->info, &out->rate,
+            (out->fsize - out->fpos) * hw->info.bytes_per_frame);
     } else {
         audio_rate_start(&out->rate);
     }
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 2cc8b137ba..b5128c8a17 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -43,14 +43,14 @@ static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
     int64_t bytes = audio_rate_get_bytes(&hw->info, &wav->rate, len);
-    assert(bytes >> hw->info.shift << hw->info.shift == bytes);
+    assert(bytes % hw->info.bytes_per_frame == 0);
 
     if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
         dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
               bytes, strerror(errno));
     }
 
-    wav->total_samples += bytes >> hw->info.shift;
+    wav->total_samples += bytes / hw->info.bytes_per_frame;
     return bytes;
 }
 
@@ -134,7 +134,7 @@ static void wav_fini_out (HWVoiceOut *hw)
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
     uint8_t rlen[4];
     uint8_t dlen[4];
-    uint32_t datalen = wav->total_samples << hw->info.shift;
+    uint32_t datalen = wav->total_samples * hw->info.bytes_per_frame;
     uint32_t rifflen = datalen + 36;
 
     if (!wav->f) {
-- 
2.23.0


