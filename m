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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C894BC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738F72082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rurvh/ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738F72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvTQ-0001hK-Nw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyR-0004N3-9Y
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyJ-0003da-Nh
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyH-0003Xq-Kc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so17477413wru.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wvXnq6hkLj8pTvXIvDl26WS4hTQGdiZjYzfOuS8kH/E=;
 b=Rurvh/aiNDo3RnKIlTyRDuthCnC376SXrRJz8tHA5ixcjIGYqGHfSxdchZTU5/JBEQ
 Rhjh0xPs64+OyUVW7pSPaXCa0H4d5zkYQF8Q+epRGaqPI2rCy6w62pSlMzE8IQK30qRX
 7UVp65WPmKeB3cXLOTT6cWGNTtKqIRji8Zve2wglbhjzobXHO95PCQbr2+ihtzrSBmY7
 92/dLQ5HsYR9hrkKGPOmrlodreWFQJOqmY9/F4Xl1sEQc9dfC+VSEtr9G5YUaqEaIJCF
 b21It+DUET4bTkSBy4qsTrsxGwIrd74Alcn91F59prRz1hVxD5uQE6LcxJ3AkKaksDQt
 4XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wvXnq6hkLj8pTvXIvDl26WS4hTQGdiZjYzfOuS8kH/E=;
 b=FK+0ChHPpsoX9Gej53OfKfnpPM4BlzpMzA1Y7X35ZidphUrMlNeEkaeuoRwpAsN3IN
 cDFktP9UJm5Y61Bv/F2CGn3A9lOUsR0dJNqRIHzckTgG+7DRB5SN3OwhOikcFvcAlLNY
 RzxtLF4hYcHU6iw4/RtMI/TVeTUFTvvJuCzOm4FvAsDNoZu/+0N2gD82w0pahpUayGlX
 DW5c7MpqWo6Y7oaJI3hhHt3H3GS5Cn+kLYMGi3jvHwD0a/RpDE8IHGrB8ENKW1nXSVRc
 V0Wa395roC+AROghCWCXzqGh4nS7M8UGd4BVmwRSLo4D3iYlbMGRGoMLaE/OfUnb4bGa
 F0FA==
X-Gm-Message-State: APjAAAWrGpT/hChca33+N1R/ISQWH4gbQowhZ8FCDwxH6IbH9m6ga9aT
 XaPhDG7ycynEIVLOhtSvWDMN0PxniMM=
X-Google-Smtp-Source: APXvYqzmyKhFuPFwNTUPVTuAA735Br1biKOjuEv+CwgsBFOypYUUEay9oNUHrovfRvipo3mdA/EZ4g==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr26503772wrq.308.1562697361609; 
 Tue, 09 Jul 2019 11:36:01 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.36.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:36:01 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:51 +0200
Message-Id: <226b14a2fa0c8b905066df39d71822fa3c7374a1.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 11/11] audio: use size_t where makes sense
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h           |   4 +-
 audio/audio_int.h       |  26 +++----
 audio/audio_template.h  |  14 ++--
 audio/mixeng.h          |   9 +--
 audio/rate_template.h   |   2 +-
 include/sysemu/replay.h |   4 +-
 audio/alsaaudio.c       |  26 +++----
 audio/audio.c           | 156 ++++++++++++++++++++--------------------
 audio/coreaudio.c       |  10 +--
 audio/dsoundaudio.c     |  11 +--
 audio/noaudio.c         |  16 ++---
 audio/ossaudio.c        |  45 ++++++------
 audio/paaudio.c         |  44 ++++++------
 audio/sdlaudio.c        |  20 +++---
 audio/spiceaudio.c      |  12 ++--
 audio/wavaudio.c        |   8 +--
 replay/replay-audio.c   |  16 ++---
 replay/replay.c         |   2 +-
 18 files changed, 212 insertions(+), 213 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 4a95758516..2db27bba7b 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -112,7 +112,7 @@ SWVoiceOut *AUD_open_out (
     );
 
 void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
-int  AUD_write (SWVoiceOut *sw, void *pcm_buf, int size);
+size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
 int  AUD_is_active_out (SWVoiceOut *sw);
@@ -133,7 +133,7 @@ SWVoiceIn *AUD_open_in (
     );
 
 void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
-int  AUD_read (SWVoiceIn *sw, void *pcm_buf, int size);
+size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in (SWVoiceIn *sw, int on);
 int  AUD_is_active_in (SWVoiceIn *sw);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 003b7ab8cc..a674c5374a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -61,12 +61,12 @@ typedef struct HWVoiceOut {
 
     f_sample *clip;
 
-    int rpos;
+    size_t rpos;
     uint64_t ts_helper;
 
     struct st_sample *mix_buf;
 
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
     int ctl_caps;
@@ -82,13 +82,13 @@ typedef struct HWVoiceIn {
 
     t_sample *conv;
 
-    int wpos;
-    int total_samples_captured;
+    size_t wpos;
+    size_t total_samples_captured;
     uint64_t ts_helper;
 
     struct st_sample *conv_buf;
 
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
     int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
@@ -103,7 +103,7 @@ struct SWVoiceOut {
     int64_t ratio;
     struct st_sample *buf;
     void *rate;
-    int total_hw_samples_mixed;
+    size_t total_hw_samples_mixed;
     int active;
     int empty;
     HWVoiceOut *hw;
@@ -120,7 +120,7 @@ struct SWVoiceIn {
     struct audio_pcm_info info;
     int64_t ratio;
     void *rate;
-    int total_hw_samples_acquired;
+    size_t total_hw_samples_acquired;
     struct st_sample *buf;
     f_sample *clip;
     HWVoiceIn *hw;
@@ -149,12 +149,12 @@ struct audio_driver {
 struct audio_pcm_ops {
     int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_out)(HWVoiceOut *hw);
-    int  (*run_out) (HWVoiceOut *hw, int live);
+    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
 
     int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_in) (HWVoiceIn *hw);
-    int  (*run_in)  (HWVoiceIn *hw);
+    size_t (*run_in)(HWVoiceIn *hw);
     int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
 
@@ -208,10 +208,10 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
 
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending);
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending);
 
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
@@ -224,7 +224,7 @@ void audio_run(AudioState *s, const char *msg);
 
 #define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
 
-static inline int audio_ring_dist (int dst, int src, int len)
+static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >= src) ? (dst - src) : (len - src + dst);
 }
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 54f07338e7..2562bf5f00 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -75,16 +75,16 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
     HWBUF = NULL;
 }
 
-static int glue (audio_pcm_hw_alloc_resources_, TYPE) (HW *hw)
+static bool glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
     HWBUF = audio_calloc(__func__, hw->samples, sizeof(struct st_sample));
     if (!HWBUF) {
-        dolog ("Could not allocate " NAME " buffer (%d samples)\n",
-               hw->samples);
-        return -1;
+        dolog("Could not allocate " NAME " buffer (%zu samples)\n",
+              hw->samples);
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -265,7 +265,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
     }
 
     if (audio_bug(__func__, hw->samples <= 0)) {
-        dolog ("hw->samples=%d\n", hw->samples);
+        dolog("hw->samples=%zd\n", hw->samples);
         goto err1;
     }
 
@@ -279,7 +279,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
 
-    if (glue (audio_pcm_hw_alloc_resources_, TYPE) (hw)) {
+    if (!glue(audio_pcm_hw_alloc_resources_, TYPE)(hw)) {
         goto err1;
     }
 
diff --git a/audio/mixeng.h b/audio/mixeng.h
index b53a5ef99a..18e62c7c49 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -33,6 +33,7 @@ struct st_sample { mixeng_real l; mixeng_real r; };
 struct mixeng_volume { int mute; int64_t r; int64_t l; };
 struct st_sample { int64_t l; int64_t r; };
 #endif
+typedef struct st_sample st_sample;
 
 typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
@@ -41,10 +42,10 @@ extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
 void *st_rate_start (int inrate, int outrate);
-void st_rate_flow (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-                   int *isamp, int *osamp);
-void st_rate_flow_mix (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-                       int *isamp, int *osamp);
+void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
+                  size_t *isamp, size_t *osamp);
+void st_rate_flow_mix(void *opaque, st_sample *ibuf, st_sample *obuf,
+                      size_t *isamp, size_t *osamp);
 void st_rate_stop (void *opaque);
 void mixeng_clear (struct st_sample *buf, int len);
 void mixeng_volume (struct st_sample *buf, int len, struct mixeng_volume *vol);
diff --git a/audio/rate_template.h b/audio/rate_template.h
index 6e93588877..f94c940c61 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -28,7 +28,7 @@
  * Return number of samples processed.
  */
 void NAME (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-           int *isamp, int *osamp)
+           size_t *isamp, size_t *osamp)
 {
     struct rate *rate = opaque;
     struct st_sample *istart, *iend;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e423..5c0a91e44f 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -179,9 +179,9 @@ void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
 /* Audio */
 
 /*! Saves/restores number of played samples of audio out operation. */
-void replay_audio_out(int *played);
+void replay_audio_out(size_t *played);
 /*! Saves/restores recorded samples of audio in operation. */
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size);
 
 /* VM state operations */
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index e9e3a4819c..591344dccd 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -681,10 +681,10 @@ static void alsa_write_pending (ALSAVoiceOut *alsa)
     }
 }
 
-static int alsa_run_out (HWVoiceOut *hw, int live)
+static size_t alsa_run_out(HWVoiceOut *hw, size_t live)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
-    int decr;
+    size_t decr;
     snd_pcm_sframes_t avail;
 
     avail = alsa_get_avail (alsa->handle);
@@ -739,8 +739,8 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     alsa->pcm_buf = audio_calloc(__func__, obt.samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate DAC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -841,8 +841,8 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     alsa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -863,17 +863,17 @@ static void alsa_fini_in (HWVoiceIn *hw)
     alsa->pcm_buf = NULL;
 }
 
-static int alsa_run_in (HWVoiceIn *hw)
+static size_t alsa_run_in(HWVoiceIn *hw)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     int hwshift = hw->info.shift;
     int i;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
-    int decr;
+    size_t live = audio_pcm_hw_get_live_in (hw);
+    size_t dead = hw->samples - live;
+    size_t decr;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] = {
         { .add = hw->wpos, .len = 0 },
         { .add = 0,        .len = 0 }
@@ -913,7 +913,7 @@ static int alsa_run_in (HWVoiceIn *hw)
         }
     }
 
-    decr = MIN (dead, avail);
+    decr = MIN(dead, avail);
     if (!decr) {
         return 0;
     }
diff --git a/audio/audio.c b/audio/audio.c
index b79f56fe64..a497cb024e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -526,10 +526,10 @@ static int audio_attach_capture (HWVoiceOut *hw)
 /*
  * Hard voice (capture)
  */
-static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
+static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 {
     SWVoiceIn *sw;
-    int m = hw->total_samples_captured;
+    size_t m = hw->total_samples_captured;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active) {
@@ -539,28 +539,28 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-int audio_pcm_hw_get_live_in (HWVoiceIn *hw)
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
-    int live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+    size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
     return live;
 }
 
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending)
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending)
 {
-    int left = hw->samples - pending;
-    int len = MIN (left, live);
-    int clipped = 0;
+    size_t left = hw->samples - pending;
+    size_t len = MIN (left, live);
+    size_t clipped = 0;
 
     while (len) {
         struct st_sample *src = hw->mix_buf + hw->rpos;
         uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
-        int samples_till_end_of_buf = hw->samples - hw->rpos;
-        int samples_to_clip = MIN (len, samples_till_end_of_buf);
+        size_t samples_till_end_of_buf = hw->samples - hw->rpos;
+        size_t samples_to_clip = MIN (len, samples_till_end_of_buf);
 
         hw->clip (dst, src, samples_to_clip);
 
@@ -574,14 +574,14 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
 /*
  * Soft voice (capture)
  */
-static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
+static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *sw)
 {
     HWVoiceIn *hw = sw->hw;
-    int live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    int rpos;
+    ssize_t live = hw->total_samples_captured - sw->total_hw_samples_acquired;
+    ssize_t rpos;
 
     if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
 
@@ -594,17 +594,17 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     }
 }
 
-static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
+static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw = sw->hw;
-    int samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
+    size_t samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
     struct st_sample *src, *dst = sw->buf;
 
     rpos = audio_pcm_sw_get_rpos_in (sw) % hw->samples;
 
     live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live_in=%d hw->samples=%d\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live_in=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
 
@@ -618,9 +618,9 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 
     while (swlim) {
         src = hw->conv_buf + rpos;
-        isamp = hw->wpos - rpos;
-        /* XXX: <= ? */
-        if (isamp <= 0) {
+        if (hw->wpos > rpos) {
+            isamp = hw->wpos - rpos;
+        } else {
             isamp = hw->samples - rpos;
         }
 
@@ -629,11 +629,6 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
         }
         osamp = swlim;
 
-        if (audio_bug(__func__, osamp < 0)) {
-            dolog ("osamp=%d\n", osamp);
-            return 0;
-        }
-
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -= osamp;
         rpos = (rpos + isamp) % hw->samples;
@@ -654,10 +649,10 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 /*
  * Hard voice (playback)
  */
-static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
+static size_t audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
 {
     SWVoiceOut *sw;
-    int m = INT_MAX;
+    size_t m = SIZE_MAX;
     int nb_live = 0;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
@@ -671,9 +666,9 @@ static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
     return m;
 }
 
-static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
+static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 {
-    int smin;
+    size_t smin;
     int nb_live1;
 
     smin = audio_pcm_hw_find_min_out (hw, &nb_live1);
@@ -682,10 +677,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     }
 
     if (nb_live1) {
-        int live = smin;
+        size_t live = smin;
 
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
             return 0;
         }
         return live;
@@ -696,10 +691,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 /*
  * Soft voice (playback)
  */
-static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
+static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
 {
-    int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
-    int ret = 0, pos = 0, total = 0;
+    size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
+    size_t ret = 0, pos = 0, total = 0;
 
     if (!sw) {
         return size;
@@ -708,8 +703,8 @@ static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
     hwsamples = sw->hw->samples;
 
     live = sw->total_hw_samples_mixed;
-    if (audio_bug(__func__, live < 0 || live > hwsamples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hwsamples);
+    if (audio_bug(__func__, live > hwsamples)) {
+        dolog("live=%zu hw->samples=%zu\n", live, hwsamples);
         return 0;
     }
 
@@ -763,7 +758,7 @@ static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
 
 #ifdef DEBUG_OUT
     dolog (
-        "%s: write size %d ret %d total sw %d\n",
+        "%s: write size %zu ret %zu total sw %zu\n",
         SW_NAME (sw),
         size >> sw->info.shift,
         ret,
@@ -842,7 +837,7 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-int AUD_write (SWVoiceOut *sw, void *buf, int size)
+size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -857,7 +852,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
     return audio_pcm_sw_write(sw, buf, size);
 }
 
-int AUD_read (SWVoiceIn *sw, void *buf, int size)
+size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -966,17 +961,17 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
     }
 }
 
-static int audio_get_avail (SWVoiceIn *sw)
+static size_t audio_get_avail (SWVoiceIn *sw)
 {
-    int live;
+    size_t live;
 
     if (!sw) {
         return 0;
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
         return 0;
     }
 
@@ -989,9 +984,9 @@ static int audio_get_avail (SWVoiceIn *sw)
     return (((int64_t) live << 32) / sw->ratio) << sw->info.shift;
 }
 
-static int audio_get_free (SWVoiceOut *sw)
+static size_t audio_get_free(SWVoiceOut *sw)
 {
-    int live, dead;
+    size_t live, dead;
 
     if (!sw) {
         return 0;
@@ -999,8 +994,8 @@ static int audio_get_free (SWVoiceOut *sw)
 
     live = sw->total_hw_samples_mixed;
 
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
         return 0;
     }
 
@@ -1015,9 +1010,10 @@ static int audio_get_free (SWVoiceOut *sw)
     return (((int64_t) dead << 32) / sw->ratio) << sw->info.shift;
 }
 
-static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
+static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
+                                        size_t samples)
 {
-    int n;
+    size_t n;
 
     if (hw->enabled) {
         SWVoiceCap *sc;
@@ -1028,17 +1024,17 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
 
             n = samples;
             while (n) {
-                int till_end_of_hw = hw->samples - rpos2;
-                int to_write = MIN (till_end_of_hw, n);
-                int bytes = to_write << hw->info.shift;
-                int written;
+                size_t till_end_of_hw = hw->samples - rpos2;
+                size_t to_write = MIN(till_end_of_hw, n);
+                size_t bytes = to_write << hw->info.shift;
+                size_t written;
 
                 sw->buf = hw->mix_buf + rpos2;
                 written = audio_pcm_sw_write (sw, NULL, bytes);
                 if (written - bytes) {
-                    dolog ("Could not mix %d bytes into a capture "
-                           "buffer, mixed %d\n",
-                           bytes, written);
+                    dolog("Could not mix %zu bytes into a capture "
+                          "buffer, mixed %zu\n",
+                          bytes, written);
                     break;
                 }
                 n -= to_write;
@@ -1047,9 +1043,9 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
         }
     }
 
-    n = MIN (samples, hw->samples - rpos);
-    mixeng_clear (hw->mix_buf + rpos, n);
-    mixeng_clear (hw->mix_buf, samples - n);
+    n = MIN(samples, hw->samples - rpos);
+    mixeng_clear(hw->mix_buf + rpos, n);
+    mixeng_clear(hw->mix_buf, samples - n);
 }
 
 static void audio_run_out (AudioState *s)
@@ -1058,16 +1054,16 @@ static void audio_run_out (AudioState *s)
     SWVoiceOut *sw;
 
     while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
-        int played;
-        int live, free, nb_live, cleanup_required, prev_rpos;
+        size_t played, live, prev_rpos, free;
+        int nb_live, cleanup_required;
 
         live = audio_pcm_hw_get_live_out (hw, &nb_live);
         if (!nb_live) {
             live = 0;
         }
 
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog ("live=%zu hw->samples=%zu\n", live, hw->samples);
             continue;
         }
 
@@ -1102,13 +1098,13 @@ static void audio_run_out (AudioState *s)
         played = hw->pcm_ops->run_out (hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
-            dolog ("hw->rpos=%d hw->samples=%d played=%d\n",
-                   hw->rpos, hw->samples, played);
+            dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
+                  hw->rpos, hw->samples, played);
             hw->rpos = 0;
         }
 
 #ifdef DEBUG_OUT
-        dolog ("played=%d\n", played);
+        dolog("played=%zu\n", played);
 #endif
 
         if (played) {
@@ -1123,8 +1119,8 @@ static void audio_run_out (AudioState *s)
             }
 
             if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
-                dolog ("played=%d sw->total_hw_samples_mixed=%d\n",
-                       played, sw->total_hw_samples_mixed);
+                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
+                      played, sw->total_hw_samples_mixed);
                 played = sw->total_hw_samples_mixed;
             }
 
@@ -1164,7 +1160,7 @@ static void audio_run_in (AudioState *s)
 
     while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
-        int captured = 0, min;
+        size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
             captured = hw->pcm_ops->run_in(hw);
@@ -1179,7 +1175,7 @@ static void audio_run_in (AudioState *s)
             sw->total_hw_samples_acquired -= min;
 
             if (sw->active) {
-                int avail;
+                size_t avail;
 
                 avail = audio_get_avail (sw);
                 if (avail > 0) {
@@ -1195,15 +1191,15 @@ static void audio_run_capture (AudioState *s)
     CaptureVoiceOut *cap;
 
     for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
-        int live, rpos, captured;
+        size_t live, rpos, captured;
         HWVoiceOut *hw = &cap->hw;
         SWVoiceOut *sw;
 
         captured = live = audio_pcm_hw_get_live_out (hw, NULL);
         rpos = hw->rpos;
         while (live) {
-            int left = hw->samples - rpos;
-            int to_capture = MIN (live, left);
+            size_t left = hw->samples - rpos;
+            size_t to_capture = MIN(live, left);
             struct st_sample *src;
             struct capture_callback *cb;
 
@@ -1226,8 +1222,8 @@ static void audio_run_capture (AudioState *s)
             }
 
             if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
-                dolog ("captured=%d sw->total_hw_samples_mixed=%d\n",
-                       captured, sw->total_hw_samples_mixed);
+                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
+                      captured, sw->total_hw_samples_mixed);
                 captured = sw->total_hw_samples_mixed;
             }
 
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 091fe84a34..d1be58b40a 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,9 +43,9 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
-    int live;
-    int decr;
-    int rpos;
+    size_t live;
+    size_t decr;
+    size_t rpos;
 } coreaudioVoiceOut;
 
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6
@@ -397,9 +397,9 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-static int coreaudio_run_out (HWVoiceOut *hw, int live)
+static size_t coreaudio_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
 
     if (coreaudio_lock (core, "coreaudio_run_out")) {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 11594c3095..67aa1d0ad5 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,19 +454,20 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_run_out (HWVoiceOut *hw, int live)
+static size_t dsound_run_out(HWVoiceOut *hw, size_t live)
 {
     int err;
     HRESULT hr;
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
-    int len, hwshift;
+    size_t len;
+    int hwshift;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
     DWORD wpos, ppos, old_pos;
     LPVOID p1, p2;
-    int bufsize;
+    size_t bufsize;
     dsound *s = ds->s;
     AudiodevDsoundOptions *dso = &s->dev->u.dsound;
 
@@ -640,13 +641,13 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_run_in (HWVoiceIn *hw)
+static size_t dsound_run_in(HWVoiceIn *hw)
 {
     int err;
     HRESULT hr;
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
-    int live, len, dead;
+    size_t live, len, dead;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index cbb02d9e49..0fb2629cf2 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -41,10 +41,10 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
 
-static int no_run_out (HWVoiceOut *hw, int live)
+static size_t no_run_out(HWVoiceOut *hw, size_t live)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    int decr, samples;
+    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -52,7 +52,7 @@ static int no_run_out (HWVoiceOut *hw, int live)
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - no->old_ticks;
     bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-    bytes = MIN(bytes, INT_MAX);
+    bytes = MIN(bytes, SIZE_MAX);
     samples = bytes >> hw->info.shift;
 
     no->old_ticks = now;
@@ -92,12 +92,12 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
 
-static int no_run_in (HWVoiceIn *hw)
+static size_t no_run_in(HWVoiceIn *hw)
 {
     NoVoiceIn *no = (NoVoiceIn *) hw;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
-    int samples = 0;
+    size_t live = audio_pcm_hw_get_live_in(hw);
+    size_t dead = hw->samples - live;
+    size_t samples = 0;
 
     if (dead) {
         int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -106,7 +106,7 @@ static int no_run_in (HWVoiceIn *hw)
             muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
         no->old_ticks = now;
-        bytes = MIN (bytes, INT_MAX);
+        bytes = MIN (bytes, SIZE_MAX);
         samples = bytes >> hw->info.shift;
         samples = MIN (samples, dead);
     }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index b99edbec17..1696933688 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -411,13 +411,14 @@ static void oss_write_pending (OSSVoiceOut *oss)
     }
 }
 
-static int oss_run_out (HWVoiceOut *hw, int live)
+static size_t oss_run_out(HWVoiceOut *hw, size_t live)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
-    int err, decr;
+    int err;
+    size_t decr;
     struct audio_buf_info abinfo;
     struct count_info cntinfo;
-    int bufsize;
+    size_t bufsize;
 
     bufsize = hw->samples << hw->info.shift;
 
@@ -476,8 +477,8 @@ static void oss_fini_out (HWVoiceOut *hw)
         if (oss->mmapped) {
             err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
             if (err) {
-                oss_logerr (errno, "Failed to unmap buffer %p, size %d\n",
-                            oss->pcm_buf, hw->samples << hw->info.shift);
+                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+                           oss->pcm_buf, hw->samples << hw->info.shift);
             }
         }
         else {
@@ -543,8 +544,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
             0
             );
         if (oss->pcm_buf == MAP_FAILED) {
-            oss_logerr (errno, "Failed to map %d bytes of DAC\n",
-                        hw->samples << hw->info.shift);
+            oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
+                       hw->samples << hw->info.shift);
         }
         else {
             int err;
@@ -568,8 +569,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
             if (!oss->mmapped) {
                 err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
                 if (err) {
-                    oss_logerr (errno, "Failed to unmap buffer %p size %d\n",
-                                oss->pcm_buf, hw->samples << hw->info.shift);
+                    oss_logerr(errno, "Failed to unmap buffer %p size %zu\n",
+                               oss->pcm_buf, hw->samples << hw->info.shift);
                 }
             }
         }
@@ -581,7 +582,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
                                     1 << hw->info.shift);
         if (!oss->pcm_buf) {
             dolog (
-                "Could not allocate DAC buffer (%d samples, each %d bytes)\n",
+                "Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
                 hw->samples,
                 1 << hw->info.shift
                 );
@@ -693,8 +694,8 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
     oss->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!oss->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         oss_anal_close (&fd);
         return -1;
     }
@@ -714,17 +715,17 @@ static void oss_fini_in (HWVoiceIn *hw)
     oss->pcm_buf = NULL;
 }
 
-static int oss_run_in (HWVoiceIn *hw)
+static size_t oss_run_in(HWVoiceIn *hw)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     int hwshift = hw->info.shift;
     int i;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
+    size_t live = audio_pcm_hw_get_live_in (hw);
+    size_t dead = hw->samples - live;
     size_t read_samples = 0;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] = {
         { .add = hw->wpos, .len = 0 },
         { .add = 0,        .len = 0 }
@@ -751,9 +752,9 @@ static int oss_run_in (HWVoiceIn *hw)
 
             if (nread > 0) {
                 if (nread & hw->info.align) {
-                    dolog ("warning: Misaligned read %zd (requested %d), "
-                           "alignment %d\n", nread, bufs[i].add << hwshift,
-                           hw->info.align + 1);
+                    dolog("warning: Misaligned read %zd (requested %zu), "
+                          "alignment %d\n", nread, bufs[i].add << hwshift,
+                          hw->info.align + 1);
                 }
                 read_samples += nread >> hwshift;
                 hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshift);
@@ -766,9 +767,9 @@ static int oss_run_in (HWVoiceIn *hw)
                     case EAGAIN:
                         break;
                     default:
-                        oss_logerr (
+                        oss_logerr(
                             errno,
-                            "Failed to read %d bytes of audio (to %p)\n",
+                            "Failed to read %zu bytes of audio (to %p)\n",
                             bufs[i].len, p
                             );
                         break;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 12471154ed..dfe89d9ee5 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -30,30 +30,30 @@ typedef struct {
 
 typedef struct {
     HWVoiceOut hw;
-    int done;
-    int live;
-    int decr;
-    int rpos;
+    size_t done;
+    size_t live;
+    size_t decr;
+    size_t rpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
-    int done;
-    int dead;
-    int incr;
-    int wpos;
+    size_t done;
+    size_t dead;
+    size_t incr;
+    size_t wpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     const void *read_data;
     size_t read_index, read_length;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceIn;
 
 static void qpa_conn_fini(PAConnection *c);
@@ -219,7 +219,7 @@ static void *qpa_thread_out (void *arg)
     }
 
     for (;;) {
-        int decr, to_mix, rpos;
+        size_t decr, to_mix, rpos;
 
         for (;;) {
             if (pa->done) {
@@ -244,7 +244,7 @@ static void *qpa_thread_out (void *arg)
 
         while (to_mix) {
             int error;
-            int chunk = MIN (to_mix, hw->samples - rpos);
+            size_t chunk = MIN (to_mix, hw->samples - rpos);
             struct st_sample *src = hw->mix_buf + rpos;
 
             hw->clip (pa->pcm_buf, src, chunk);
@@ -273,9 +273,9 @@ static void *qpa_thread_out (void *arg)
     return NULL;
 }
 
-static int qpa_run_out (HWVoiceOut *hw, int live)
+static size_t qpa_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
 
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -306,7 +306,7 @@ static void *qpa_thread_in (void *arg)
     }
 
     for (;;) {
-        int incr, to_grab, wpos;
+        size_t incr, to_grab, wpos;
 
         for (;;) {
             if (pa->done) {
@@ -331,7 +331,7 @@ static void *qpa_thread_in (void *arg)
 
         while (to_grab) {
             int error;
-            int chunk = MIN (to_grab, hw->samples - wpos);
+            size_t chunk = MIN (to_grab, hw->samples - wpos);
             void *buf = advance (pa->pcm_buf, wpos);
 
             if (qpa_simple_read (pa, buf,
@@ -359,9 +359,9 @@ static void *qpa_thread_in (void *arg)
     return NULL;
 }
 
-static int qpa_run_in (HWVoiceIn *hw)
+static size_t qpa_run_in(HWVoiceIn *hw)
 {
-    int live, incr, dead;
+    size_t live, incr, dead;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
 
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -582,8 +582,8 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->rpos = hw->rpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
 
@@ -650,8 +650,8 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->wpos = hw->wpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index c7fd487e0e..14b11f0335 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -41,8 +41,8 @@
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    int live;
-    int decr;
+    size_t live;
+    size_t decr;
 } SDLVoiceOut;
 
 static struct SDLAudioState {
@@ -184,22 +184,22 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     SDLVoiceOut *sdl = opaque;
     SDLAudioState *s = &glob_sdl;
     HWVoiceOut *hw = &sdl->hw;
-    int samples = len >> hw->info.shift;
-    int to_mix, decr;
+    size_t samples = len >> hw->info.shift;
+    size_t to_mix, decr;
 
     if (s->exit || !sdl->live) {
         return;
     }
 
-    /* dolog ("in callback samples=%d live=%d\n", samples, sdl->live); */
+    /* dolog ("in callback samples=%zu live=%zu\n", samples, sdl->live); */
 
     to_mix = MIN(samples, sdl->live);
     decr = to_mix;
     while (to_mix) {
-        int chunk = MIN(to_mix, hw->samples - hw->rpos);
+        size_t chunk = MIN(to_mix, hw->samples - hw->rpos);
         struct st_sample *src = hw->mix_buf + hw->rpos;
 
-        /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
+        /* dolog ("in callback to_mix %zu, chunk %zu\n", to_mix, chunk); */
         hw->clip(buf, src, chunk);
         hw->rpos = (hw->rpos + chunk) % hw->samples;
         to_mix -= chunk;
@@ -209,7 +209,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     sdl->live -= decr;
     sdl->decr += decr;
 
-    /* dolog ("done len=%d\n", len); */
+    /* dolog ("done len=%zu\n", len); */
 
     /* SDL2 does not clear the remaining buffer for us, so do it on our own */
     if (samples) {
@@ -217,9 +217,9 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     }
 }
 
-static int sdl_run_out (HWVoiceOut *hw, int live)
+static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
 
     SDL_LockAudio();
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6e7f13cffa..d9db1a39e6 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -153,11 +153,11 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
 
-static int line_out_run (HWVoiceOut *hw, int live)
+static size_t line_out_run (HWVoiceOut *hw, size_t live)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
-    int rpos, decr;
-    int samples;
+    size_t rpos, decr;
+    size_t samples;
 
     if (!live) {
         return 0;
@@ -276,12 +276,12 @@ static void line_in_fini (HWVoiceIn *hw)
     spice_server_remove_interface (&in->sin.base);
 }
 
-static int line_in_run (HWVoiceIn *hw)
+static size_t line_in_run(HWVoiceIn *hw)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    int num_samples;
+    size_t num_samples;
     int ready;
-    int len[2];
+    size_t len[2];
     uint64_t delta_samp;
     const uint32_t *samples;
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 17ab921cef..b6eeeb4e26 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -40,10 +40,10 @@ typedef struct WAVVoiceOut {
     int total_samples;
 } WAVVoiceOut;
 
-static int wav_run_out (HWVoiceOut *hw, int live)
+static size_t wav_run_out(HWVoiceOut *hw, size_t live)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    int rpos, decr, samples;
+    size_t rpos, decr, samples;
     uint8_t *dst;
     struct st_sample *src;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -139,8 +139,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     hw->samples = 1024;
     wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!wav->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         return -1;
     }
 
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index b113836de4..efe1628727 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -16,18 +16,18 @@
 #include "sysemu/sysemu.h"
 #include "audio/audio.h"
 
-void replay_audio_out(int *played)
+void replay_audio_out(size_t *played)
 {
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_OUT);
-        replay_put_dword(*played);
+        replay_put_qword(*played);
     } else if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_OUT)) {
-            *played = replay_get_dword();
+            *played = replay_get_qword();
             replay_finish_event();
         } else {
             error_report("Missing audio out event in the replay log");
@@ -36,7 +36,7 @@ void replay_audio_out(int *played)
     }
 }
 
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
 {
     int pos;
     uint64_t left, right;
@@ -44,8 +44,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_IN);
-        replay_put_dword(*recorded);
-        replay_put_dword(*wpos);
+        replay_put_qword(*recorded);
+        replay_put_qword(*wpos);
         for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
              ; pos = (pos + 1) % size) {
             audio_sample_to_uint64(samples, pos, &left, &right);
@@ -56,8 +56,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_IN)) {
-            *recorded = replay_get_dword();
-            *wpos = replay_get_dword();
+            *recorded = replay_get_qword();
+            *wpos = replay_get_qword();
             for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
                  ; pos = (pos + 1) % size) {
                 left = replay_get_qword();
diff --git a/replay/replay.c b/replay/replay.c
index 8b172b2d1b..a1135a9943 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02007
+#define REPLAY_VERSION              0xe02008
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
-- 
2.22.0


