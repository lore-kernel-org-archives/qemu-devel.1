Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BDC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780AE21852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ/ghnp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780AE21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUJT-0000kU-1R
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGP-0006OB-6s
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGN-0005Fd-9q
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGN-0005E6-2E
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:03 -0400
Received: by mail-wr1-x430.google.com with SMTP id q12so6728889wrj.12
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ur1rUFP6FjDWlw/RJwJeYnHP5EBXcgT1FzEaNJ4ozGU=;
 b=UQ/ghnp8Ck+/Zu8TmtEfBv9vHJFlNG1gdJ1K5NxbmuEb6OtKC4TEqe93mQSLi5lKcU
 vt6r5hqKR5cY15EqxmUpJ7Jtw0hsceleTzAwG2MGKRfrA3ayum7BJYBpoWMqeQLaKDZD
 LXIWRj9WVUmwO58h2z/0zZhgtxlAGlrkv8RHBfpESvDzp9j//ymKWCvmjRKCzCoxCdPN
 MiO9tCTGjo3wlbhwkGdXSeiJ46vAb3fony2LZTVMzEqb11v9hPDixBeLjEW1VgfGSGXh
 axGchY/bkeCyp//7ZfydJPyJW4Y+tSB8ZS8+OoeB/BIAm4WqTCNHi+VX0fn4MaQmsAnw
 PEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ur1rUFP6FjDWlw/RJwJeYnHP5EBXcgT1FzEaNJ4ozGU=;
 b=h73W7JiGQnfq2MReB824R5Oy4+2exRUu6iRxrozpD+lSKg0OrQBLBzqH/xYZ+zbrgR
 fBiatoa21/rIS0oHRZCjTbifmBL0uVmhOSohyDHDwEHxrFAv7oT07Ie5VK2rVTQkUfK8
 vHDgiQ5uFfud7EguTvvJWZF6U3xoBDS5hwcPXo2V0LPcc/vCUwfpYTqNfzZBrmym5FIq
 v+1xrx30GsNRL4kd/GjA4PC83odKhvbj2zT5GIX4Cu+6NANEjiAzFNsUp6aJ1Y1sKFUN
 RmIXzewzd9VWwmovEBrnVh2g06uSFV87nyNYmJlsacpioip/kcd9dCAoJctDtX5mZJIT
 /4yA==
X-Gm-Message-State: APjAAAUvFZzCE8CV45sJBBPfvSuogKNdHRupnRUKVok1NqqkGIysoPzB
 zlEGCAp3Jy7cgZQg0Uz/m4jJaCZ/
X-Google-Smtp-Source: APXvYqyro3SUhVG2mD270hVGd+6W4GHCxRRFhUM7WOMEf1DxWU3hzOOl728UBnAD2m/wNvyhbYLobA==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr23377828wra.273.1566169621197; 
 Sun, 18 Aug 2019 16:07:01 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:00 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:46 +0200
Message-Id: <b5e241f24e795267b145bcde7c6a72dd5e6037ea.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PATCH v4 01/14] audio: reduce glob_audio_state usage
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove glob_audio_state from functions, where possible without breaking
the API.  This means that most static functions in audio.c now take an
AudioState pointer instead of implicitly using glob_audio_state.  Also
included a pointer in SWVoice*, HWVoice* structs, so that functions
dealing them can know the audio state without having to pass it around
separately.

This is required in order to support multiple simultaneous audio
backends (added in a later commit).

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h      |  8 ++++++
 audio/audio_template.h | 46 ++++++++++++++++----------------
 audio/audio.c          | 59 +++++++++++++++++++-----------------------
 3 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3f14842709..8164696b2c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -49,9 +49,11 @@ struct audio_pcm_info {
     int swap_endianness;
 };
 
+typedef struct AudioState AudioState;
 typedef struct SWVoiceCap SWVoiceCap;
 
 typedef struct HWVoiceOut {
+    AudioState *s;
     int enabled;
     int poll_mode;
     int pending_disable;
@@ -73,6 +75,7 @@ typedef struct HWVoiceOut {
 } HWVoiceOut;
 
 typedef struct HWVoiceIn {
+    AudioState *s;
     int enabled;
     int poll_mode;
     struct audio_pcm_info info;
@@ -94,6 +97,7 @@ typedef struct HWVoiceIn {
 
 struct SWVoiceOut {
     QEMUSoundCard *card;
+    AudioState *s;
     struct audio_pcm_info info;
     t_sample *conv;
     int64_t ratio;
@@ -111,6 +115,7 @@ struct SWVoiceOut {
 
 struct SWVoiceIn {
     QEMUSoundCard *card;
+    AudioState *s;
     int active;
     struct audio_pcm_info info;
     int64_t ratio;
@@ -188,6 +193,9 @@ typedef struct AudioState {
     int nb_hw_voices_in;
     int vm_running;
     int64_t period_ticks;
+
+    bool timer_running;
+    uint64_t timer_last;
 } AudioState;
 
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1232bb54db..c721fed75d 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -36,9 +36,9 @@
 #define HWBUF hw->conv_buf
 #endif
 
-static void glue (audio_init_nb_voices_, TYPE) (struct audio_driver *drv)
+static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
+                                              struct audio_driver *drv)
 {
-    AudioState *s = &glob_audio_state;
     int max_voices = glue (drv->max_voices_, TYPE);
     int voice_size = glue (drv->voice_size_, TYPE);
 
@@ -183,8 +183,8 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
 
 static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
 {
-    AudioState *s = &glob_audio_state;
     HW *hw = *hwp;
+    AudioState *s = hw->s;
 
     if (!hw->sw_head.lh_first) {
 #ifdef DAC
@@ -199,15 +199,14 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
     }
 }
 
-static HW *glue (audio_pcm_hw_find_any_, TYPE) (HW *hw)
+static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
 {
-    AudioState *s = &glob_audio_state;
     return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
 }
 
-static HW *glue (audio_pcm_hw_find_any_enabled_, TYPE) (HW *hw)
+static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW *hw)
 {
-    while ((hw = glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
+    while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (hw->enabled) {
             return hw;
         }
@@ -215,12 +214,10 @@ static HW *glue (audio_pcm_hw_find_any_enabled_, TYPE) (HW *hw)
     return NULL;
 }
 
-static HW *glue (audio_pcm_hw_find_specific_, TYPE) (
-    HW *hw,
-    struct audsettings *as
-    )
+static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw,
+                                                   struct audsettings *as)
 {
-    while ((hw = glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
+    while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (audio_pcm_info_eq (&hw->info, as)) {
             return hw;
         }
@@ -228,10 +225,10 @@ static HW *glue (audio_pcm_hw_find_specific_, TYPE) (
     return NULL;
 }
 
-static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
+                                             struct audsettings *as)
 {
     HW *hw;
-    AudioState *s = &glob_audio_state;
     struct audio_driver *drv = s->drv;
 
     if (!glue (s->nb_hw_voices_, TYPE)) {
@@ -255,6 +252,7 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
         return NULL;
     }
 
+    hw->s = s;
     hw->pcm_ops = drv->pcm_ops;
     hw->ctl_caps = drv->ctl_caps;
 
@@ -328,33 +326,33 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
     abort();
 }
 
-static HW *glue (audio_pcm_hw_add_, TYPE) (struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettings *as)
 {
     HW *hw;
-    AudioState *s = &glob_audio_state;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
     if (pdo->fixed_settings) {
-        hw = glue (audio_pcm_hw_add_new_, TYPE) (as);
+        hw = glue(audio_pcm_hw_add_new_, TYPE)(s, as);
         if (hw) {
             return hw;
         }
     }
 
-    hw = glue (audio_pcm_hw_find_specific_, TYPE) (NULL, as);
+    hw = glue(audio_pcm_hw_find_specific_, TYPE)(s, NULL, as);
     if (hw) {
         return hw;
     }
 
-    hw = glue (audio_pcm_hw_add_new_, TYPE) (as);
+    hw = glue(audio_pcm_hw_add_new_, TYPE)(s, as);
     if (hw) {
         return hw;
     }
 
-    return glue (audio_pcm_hw_find_any_, TYPE) (NULL);
+    return glue(audio_pcm_hw_find_any_, TYPE)(s, NULL);
 }
 
-static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
+static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
+    AudioState *s,
     const char *sw_name,
     struct audsettings *as
     )
@@ -362,7 +360,6 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
     SW *sw;
     HW *hw;
     struct audsettings hw_as;
-    AudioState *s = &glob_audio_state;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
     if (pdo->fixed_settings) {
@@ -378,8 +375,9 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
                sw_name ? sw_name : "unknown", sizeof (*sw));
         goto err1;
     }
+    sw->s = s;
 
-    hw = glue (audio_pcm_hw_add_, TYPE) (&hw_as);
+    hw = glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
     if (!hw) {
         goto err2;
     }
@@ -476,7 +474,7 @@ SW *glue (AUD_open_, TYPE) (
         }
     }
     else {
-        sw = glue (audio_pcm_create_voice_pair_, TYPE) (name, as);
+        sw = glue(audio_pcm_create_voice_pair_, TYPE)(s, name, as);
         if (!sw) {
             dolog ("Failed to create voice `%s'\n", name);
             return NULL;
diff --git a/audio/audio.c b/audio/audio.c
index c8b88d892d..4f27e33245 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -399,12 +399,10 @@ static void noop_conv (struct st_sample *dst, const void *src, int samples)
     (void) samples;
 }
 
-static CaptureVoiceOut *audio_pcm_capture_find_specific (
-    struct audsettings *as
-    )
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s,
+                                                        struct audsettings *as)
 {
     CaptureVoiceOut *cap;
-    AudioState *s = &glob_audio_state;
 
     for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
         if (audio_pcm_info_eq (&cap->hw.info, as)) {
@@ -481,7 +479,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
 
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioState *s = &glob_audio_state;
+    AudioState *s = hw->s;
     CaptureVoiceOut *cap;
 
     audio_detach_capture (hw);
@@ -789,19 +787,15 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 /*
  * Timer
  */
-
-static bool audio_timer_running;
-static uint64_t audio_timer_last;
-
-static int audio_is_timer_needed (void)
+static int audio_is_timer_needed(AudioState *s)
 {
     HWVoiceIn *hwi = NULL;
     HWVoiceOut *hwo = NULL;
 
-    while ((hwo = audio_pcm_hw_find_any_enabled_out (hwo))) {
+    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
         if (!hwo->poll_mode) return 1;
     }
-    while ((hwi = audio_pcm_hw_find_any_enabled_in (hwi))) {
+    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
         if (!hwi->poll_mode) return 1;
     }
     return 0;
@@ -809,18 +803,18 @@ static int audio_is_timer_needed (void)
 
 static void audio_reset_timer (AudioState *s)
 {
-    if (audio_is_timer_needed ()) {
+    if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
-        if (!audio_timer_running) {
-            audio_timer_running = true;
-            audio_timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (!s->timer_running) {
+            s->timer_running = true;
+            s->timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
             trace_audio_timer_start(s->period_ticks / SCALE_MS);
         }
     } else {
         timer_del(s->ts);
-        if (audio_timer_running) {
-            audio_timer_running = false;
+        if (s->timer_running) {
+            s->timer_running = false;
             trace_audio_timer_stop();
         }
     }
@@ -832,11 +826,11 @@ static void audio_timer (void *opaque)
     AudioState *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    diff = now - audio_timer_last;
+    diff = now - s->timer_last;
     if (diff > s->period_ticks * 3 / 2) {
         trace_audio_timer_delayed(diff / SCALE_MS);
     }
-    audio_timer_last = now;
+    s->timer_last = now;
 
     audio_run("timer");
     audio_reset_timer(s);
@@ -890,7 +884,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioState *s = &glob_audio_state;
+        AudioState *s = sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
 
@@ -937,7 +931,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioState *s = &glob_audio_state;
+        AudioState *s = sw->s;
         SWVoiceIn *temp_sw;
 
         if (on) {
@@ -1060,7 +1054,7 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
 
-    while ((hw = audio_pcm_hw_find_any_enabled_out (hw))) {
+    while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
         int played;
         int live, free, nb_live, cleanup_required, prev_rpos;
 
@@ -1165,7 +1159,7 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
 
-    while ((hw = audio_pcm_hw_find_any_enabled_in (hw))) {
+    while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         int captured = 0, min;
 
@@ -1271,8 +1265,8 @@ static int audio_driver_init(AudioState *s, struct audio_driver *drv,
     s->drv_opaque = drv->init(dev);
 
     if (s->drv_opaque) {
-        audio_init_nb_voices_out (drv);
-        audio_init_nb_voices_in (drv);
+        audio_init_nb_voices_out(s, drv);
+        audio_init_nb_voices_in(s, drv);
         s->drv = drv;
         return 0;
     }
@@ -1293,11 +1287,11 @@ static void audio_vm_change_state_handler (void *opaque, int running,
     int op = running ? VOICE_ENABLE : VOICE_DISABLE;
 
     s->vm_running = running;
-    while ((hwo = audio_pcm_hw_find_any_enabled_out (hwo))) {
+    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
         hwo->pcm_ops->ctl_out(hwo, op);
     }
 
-    while ((hwi = audio_pcm_hw_find_any_enabled_in (hwi))) {
+    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
         hwi->pcm_ops->ctl_in(hwi, op);
     }
     audio_reset_timer (s);
@@ -1317,7 +1311,7 @@ void audio_cleanup(void)
     HWVoiceIn *hwi, *hwin;
 
     is_cleaning_up = true;
-    QLIST_FOREACH_SAFE(hwo, &glob_audio_state.hw_head_out, entries, hwon) {
+    QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
 
         if (hwo->enabled) {
@@ -1336,7 +1330,7 @@ void audio_cleanup(void)
         QLIST_REMOVE(hwo, entries);
     }
 
-    QLIST_FOREACH_SAFE(hwi, &glob_audio_state.hw_head_in, entries, hwin) {
+    QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
         if (hwi->enabled) {
             hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
         }
@@ -1532,7 +1526,7 @@ CaptureVoiceOut *AUD_add_capture (
     cb->ops = *ops;
     cb->opaque = cb_opaque;
 
-    cap = audio_pcm_capture_find_specific (as);
+    cap = audio_pcm_capture_find_specific(s, as);
     if (cap) {
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
         return cap;
@@ -1544,6 +1538,7 @@ CaptureVoiceOut *AUD_add_capture (
         cap = g_malloc0(sizeof(*cap));
 
         hw = &cap->hw;
+        hw->s = s;
         QLIST_INIT (&hw->sw_head);
         QLIST_INIT (&cap->cb_head);
 
@@ -1564,7 +1559,7 @@ CaptureVoiceOut *AUD_add_capture (
         QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
 
-        QLIST_FOREACH(hw, &glob_audio_state.hw_head_out, entries) {
+        QLIST_FOREACH(hw, &s->hw_head_out, entries) {
             audio_attach_capture (hw);
         }
         return cap;
-- 
2.22.0


