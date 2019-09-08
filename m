Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387FC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC030216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCd53YU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC030216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74nX-0005Yx-PE
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dx-0005Wd-N8
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dt-0005pS-OL
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:45 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dt-0005p9-F8
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:41 -0400
Received: by mail-qt1-x844.google.com with SMTP id g4so13845061qtq.7
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/dAz/XEv5WmwxWfs44IE0W0b9FWSb5Gktj++/KM+y5Y=;
 b=iCd53YU+VeAJQX88gV0BCrMKcCzgxpHhHl2l6Wv0SvB+yQG71d212yPxQ6MsKOxbb8
 AXvq12TzEin3+uAFIgkvK/9Ym33JtTZRzi10EEfRJ7OO2BLDktYVpHXcxFC7dbSPJHkt
 fjHYu3xtMVB8k2diTEui7ssrXyFdnnOJJ/j8tGgv7uaxzfLUOEZF/USYOth7EZ1HGrvR
 irdRQDf6u+OiKC7Mm1bx/67BBSjdA0w5QN6Q2ag9ZB9S6/by36d7buWvS6zzr/Yx/wOi
 ocZmRIIWOr1dBjluFrmM2ilkpQhBGtu1h3RNI5oiLNvMlfmtBkbxKG2Su1LyWgEt3VY9
 TgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/dAz/XEv5WmwxWfs44IE0W0b9FWSb5Gktj++/KM+y5Y=;
 b=hgNhDquvNSrPNy2+NOLJt/f6CRVV1dR/xxw5M8+uaRYjKXBtAqg3bZTp3/15e3C5/8
 7wS3hlhj3OjZrdXDZTWP1BWtaBCPXdh976BPi+5H9wMNhJZoiZYZU50wdJBVs3sz99Xz
 bDPnIwTG0CXqUqDxBZvzUE35xRVdoqYLrVNZNZwdrfuIs1oQMZHeewWfVfgfs0b/kDNL
 dArv/ZSEVReUE8UVFsqtIWcfh8thNryj9mb44IeTToo7x0vPfIwpo+cqZRgG3Rj6ICRS
 zh3b/bPv7/rDWSXE/caolH7IeRsc8oEwoBilbV2/WtQEj6VeWo+b0NPKoIIMtms+NvVl
 +7Xw==
X-Gm-Message-State: APjAAAWcWVH8G6uEov5Nic45/5CbpaYQB3NkeoQiE4gYGA4sAYPXw8tv
 I+Mo/VKN9ztU/DSzjBYT+d9fEdR0
X-Google-Smtp-Source: APXvYqzaTNuyJUI07R2K1yavmSLmoPN2xrTm+H8nepthL8fXbElX2WVgznt1tOrHGvFQ0sH3VvQXuw==
X-Received: by 2002:ac8:ec2:: with SMTP id w2mr19952064qti.119.1567977760447; 
 Sun, 08 Sep 2019 14:22:40 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:40 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:12 +0200
Message-Id: <cef14ac32dd3c7f3f051c4a976c86850374279aa.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v2 12/24] audio: unify input and output mixeng
 buffer management
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

Usage notes: hw->samples became hw->{mix,conv}_buf->size, except before
initialization (audio_pcm_hw_alloc_resources_*), hw->samples gives the
initial size of the STSampleBuffer.  The next commit tries to fix this
inconsistency.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c          | 120 +++++++++++++++++++++--------------------
 audio/audio_int.h      |  12 +++--
 audio/audio_template.h |  19 +++----
 audio/ossaudio.c       |   3 +-
 4 files changed, 79 insertions(+), 75 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index c945f23724..0c3909087d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -544,8 +544,8 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
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
@@ -554,17 +554,17 @@ static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 {
     size_t clipped = 0;
-    size_t pos = hw->rpos;
+    size_t pos = hw->mix_buf->pos;
 
     while (len) {
-        st_sample *src = hw->mix_buf + pos;
+        st_sample *src = hw->mix_buf->samples + pos;
         uint8_t *dst = advance(pcm_buf, clipped << hw->info.shift);
-        size_t samples_till_end_of_buf = hw->samples - pos;
+        size_t samples_till_end_of_buf = hw->mix_buf->size - pos;
         size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
 
         hw->clip(dst, src, samples_to_clip);
 
-        pos = (pos + samples_to_clip) % hw->samples;
+        pos = (pos + samples_to_clip) % hw->mix_buf->size;
         len -= samples_to_clip;
         clipped += samples_to_clip;
     }
@@ -579,17 +579,17 @@ static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *sw)
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
 
@@ -599,11 +599,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
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
 
@@ -616,11 +616,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
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
@@ -630,7 +630,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -= osamp;
-        rpos = (rpos + isamp) % hw->samples;
+        rpos = (rpos + isamp) % hw->conv_buf->size;
         dst += osamp;
         ret += osamp;
         total += isamp;
@@ -678,8 +678,8 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     if (nb_live1) {
         size_t live = smin;
 
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog("live=%zu hw->mix_buf->size=%zu\n", live, hw->mix_buf->size);
             return 0;
         }
         return live;
@@ -699,11 +699,11 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
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
 
@@ -714,7 +714,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
         return 0;
     }
 
-    wpos = (sw->hw->rpos + live) % hwsamples;
+    wpos = (sw->hw->mix_buf->pos + live) % hwsamples;
     samples = size >> sw->info.shift;
 
     dead = hwsamples - live;
@@ -740,7 +740,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
         st_rate_flow_mix (
             sw->rate,
             sw->buf + pos,
-            sw->hw->mix_buf + wpos,
+            sw->hw->mix_buf->samples + wpos,
             &isamp,
             &osamp
             );
@@ -868,7 +868,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
 {
-    return sw->hw->samples << sw->hw->info.shift;
+    return sw->hw->mix_buf->size << sw->hw->info.shift;
 }
 
 void AUD_set_active_out (SWVoiceOut *sw, int on)
@@ -969,8 +969,9 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live > sw->hw->samples)) {
-        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->conv_buf->size)) {
+        dolog("live=%zu sw->hw->conv_buf->size=%zu\n", live,
+              sw->hw->conv_buf->size);
         return 0;
     }
 
@@ -993,12 +994,13 @@ static size_t audio_get_free(SWVoiceOut *sw)
 
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
@@ -1023,12 +1025,12 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
 
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
@@ -1037,14 +1039,14 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
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
@@ -1062,7 +1064,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
 
         live -= proc;
         clipped += proc;
-        hw->rpos = (hw->rpos + proc) % hw->samples;
+        hw->mix_buf->pos = (hw->mix_buf->pos + proc) % hw->mix_buf->size;
 
         if (proc == 0 || proc < decr) {
             break;
@@ -1086,8 +1088,8 @@ static void audio_run_out (AudioState *s)
             live = 0;
         }
 
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog ("live=%zu hw->samples=%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog("live=%zu hw->mix_buf->size=%zu\n", live, hw->mix_buf->size);
             continue;
         }
 
@@ -1118,13 +1120,13 @@ static void audio_run_out (AudioState *s)
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
@@ -1181,6 +1183,7 @@ static void audio_run_out (AudioState *s)
 static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
 {
     size_t conv = 0;
+    STSampleBuffer *conv_buf = hw->conv_buf;
 
     while (samples) {
         size_t proc;
@@ -1194,10 +1197,10 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
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
@@ -1217,9 +1220,10 @@ static void audio_run_in (AudioState *s)
 
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
@@ -1250,14 +1254,14 @@ static void audio_run_capture (AudioState *s)
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
 
@@ -1265,10 +1269,10 @@ static void audio_run_capture (AudioState *s)
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
@@ -1316,7 +1320,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
     ssize_t start;
 
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->samples << hw->info.shift;
+        size_t calc_size = hw->conv_buf->size << hw->info.shift;
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
         hw->pos_emul = hw->pending_emul = 0;
@@ -1352,7 +1356,7 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size = hw->samples << hw->info.shift;
+        size_t calc_size = hw->mix_buf->size << hw->info.shift;
 
         hw->buf_emul = g_malloc(calc_size);
         hw->size_emul = calc_size;
@@ -1759,11 +1763,11 @@ CaptureVoiceOut *AUD_add_capture(
 
         /* XXX find a more elegant way */
         hw->samples = 4096 * 4;
-        hw->mix_buf = g_new0(struct st_sample, hw->samples);
+        audio_pcm_hw_alloc_resources_out(hw);
 
         audio_pcm_init_info (&hw->info, as);
 
-        cap->buf = g_malloc0_n(hw->samples, 1 << hw->info.shift);
+        cap->buf = g_malloc0_n(hw->mix_buf->size, 1 << hw->info.shift);
 
         hw->clip = mixeng_clip
             [hw->info.nchannels == 2]
diff --git a/audio/audio_int.h b/audio/audio_int.h
index c76d7c39e8..20021df9e8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -52,6 +52,11 @@ struct audio_pcm_info {
 typedef struct AudioState AudioState;
 typedef struct SWVoiceCap SWVoiceCap;
 
+typedef struct STSampleBuffer {
+    size_t pos, size;
+    st_sample samples[];
+} STSampleBuffer;
+
 typedef struct HWVoiceOut {
     AudioState *s;
     int enabled;
@@ -60,11 +65,9 @@ typedef struct HWVoiceOut {
     struct audio_pcm_info info;
 
     f_sample *clip;
-
-    size_t rpos;
     uint64_t ts_helper;
 
-    struct st_sample *mix_buf;
+    STSampleBuffer *mix_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
@@ -84,11 +87,10 @@ typedef struct HWVoiceIn {
 
     t_sample *conv;
 
-    size_t wpos;
     size_t total_samples_captured;
     uint64_t ts_helper;
 
-    struct st_sample *conv_buf;
+    STSampleBuffer *conv_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index ff4a173f18..87c6d2d271 100644
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
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 2782512706..76c082d5e2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -585,7 +585,8 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
 
-            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
+            audio_pcm_info_clear_buf(
+                &hw->info, hw->buf_emul, hw->mix_buf->size);
             trig = PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
-- 
2.23.0


