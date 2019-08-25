Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C08C206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucbi+Blo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C08C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xiW-0006A0-E0
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXQ-0001OW-Qt
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXP-0004tW-E1
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:52 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:34190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXP-0004tD-8p
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:51 -0400
Received: by mail-qt1-x841.google.com with SMTP id q4so15966406qtp.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HtHe/HNhRPSy1Ga4CbXXC+UxPAf3Na3b3iJ+6d/FVbw=;
 b=ucbi+BlohpKISbpFnNAypJZMRVYihGElviDCruzSpt/aceYchOiPH9Mf5xTwWQRup3
 RQt5+kkAtZag+A/rT/3uF7Ds0remyKj3VveUypQoKxDlZ8JizfymM/NuL0v9Ro4hN8bv
 BU+HPjNHsAZCvW3IlqrqzXKOkD/GPUqcCSicZAGddP9apUQKIhnwh/uIqgwtUmAUIKOr
 L/zAeLFwRT5BbUQ8RDeuas15LV6nHU/VARQ3nxX0SymIL70+ALTBzjn7JZmY17q02/ya
 OHSm83JVM5OaB86FHFi89k4psFVg1zwYQQHUclmtvIqFPSK1dukk6eu6+C1GDQMXUcTa
 RQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HtHe/HNhRPSy1Ga4CbXXC+UxPAf3Na3b3iJ+6d/FVbw=;
 b=WlVyTCRXX+EvyMwecoMtOpaOJNlUSDZJZZ40wUd5iUm1+gDDGEqFoHZI+Xak2Groxt
 NhvvedCnoNE5m2e5yJlsw8fpBjE0p/gY9CkTyxD6K+uW3geEUpZudJgAglmCHTIN9gIn
 88rN7gGh1crQ1mLsOGIPFahe3ikqaP2ppfVry98sp9Uj5SaRvdDL1QYxuFWdAlZZEcey
 YyuZjMzM17dL/Gu51dvBu00wcSfSpvRS1hLG/8v46jZnmjMV8bPbIL+swn+isn2QJFOT
 hybxqNMsungU66J8cgAMHyuVWe3xG3rkLu2pOoDCLJt6CngK74fu0IWAxoTr6lsoNbf0
 KqJQ==
X-Gm-Message-State: APjAAAXUpEfrbD1JG87NFK4XCLREWBM5qqdYpf1AVkQb80g+0wp2Ctb6
 T5Jc0JL5vY57b92hTCTmkWHdXAU7ZMw=
X-Google-Smtp-Source: APXvYqxzIKf/fEyY2pGHosd3b2bg3uWIVuoE2oFdWzqQaa8aBMypYkU1WcvJMy6lfMfJGL4u9DxvUQ==
X-Received: by 2002:ac8:60c3:: with SMTP id i3mr6228230qtm.212.1566758810437; 
 Sun, 25 Aug 2019 11:46:50 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:49 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:19 +0200
Message-Id: <73aec2d3f3be0ba319af4fb503e3550a952cc019.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH 17/25] audio: make mixeng optional
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

Implementation of the previously added mixeng option.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_template.h | 46 ++++++++++++++++-----------
 audio/audio.c          | 70 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 8d36ab91f8..487e2a865f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -78,26 +78,32 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 
 static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    size_t samples;
-    if (!hw->pcm_ops) {
-        /*
-         * We should only end up here when using wavcapture hmp command (and not
-         * the wavcapture audio backend).
-         * It needs a lot of samples, otherwise you'll end up with "Could not
-         * mix X bytes into a capture buffer" warnings and a garbled capture.
-         */
-        samples = 4096 * 4;
-    } else if (hw->pcm_ops->glue(buffer_size_, TYPE)) {
-        samples = hw->pcm_ops->glue(buffer_size_, TYPE)(hw);
+    if (glue(audio_get_pdo_, TYPE)(hw->s->dev)->mixeng) {
+        size_t samples;
+        if (!hw->pcm_ops) {
+            /*
+             * We should only end up here when using wavcapture hmp command (and
+             * not the wavcapture audio backend).
+             * It needs a lot of samples, otherwise you'll end up with "Could
+             * not mix X bytes into a capture buffer" warnings and a garbled
+             * capture.
+             */
+            samples = 4096 * 4;
+        } else if (hw->pcm_ops->glue(buffer_size_, TYPE)) {
+            samples = hw->pcm_ops->glue(buffer_size_, TYPE)(hw);
+        } else {
+            samples = 1024; /* todo better default */
+        }
+
+        if (audio_bug(__func__, samples == 0)) {
+            dolog("Attempted to allocate empty buffer\n");
+        }
+
+        HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
+        HWBUF->size = samples;
     } else {
-        samples = 1024; /* todo better default */
+        HWBUF = NULL;
     }
-    if (audio_bug(__func__, samples == 0)) {
-        dolog("Attempted to allocate empty buffer\n");
-    }
-
-    HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
-    HWBUF->size = samples;
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -116,6 +122,10 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
 {
     int samples;
 
+    if (!glue(audio_get_pdo_, TYPE)(sw->s->dev)->mixeng) {
+        return 0;
+    }
+
     samples = ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
 
     sw->buf = audio_calloc(__func__, samples, sizeof(struct st_sample));
diff --git a/audio/audio.c b/audio/audio.c
index 84b78f604e..73ace0500e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -838,32 +838,46 @@ static void audio_timer (void *opaque)
  */
 size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
+    HWVoiceOut *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw = sw->hw;
 
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
 
-    return audio_pcm_sw_write(sw, buf, size);
+    if (audio_get_pdo_out(hw->s->dev)->mixeng) {
+        return audio_pcm_sw_write(sw, buf, size);
+    } else {
+        return hw->pcm_ops->write(hw, buf, size);
+    }
 }
 
 size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
+    HWVoiceIn *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw = sw->hw;
 
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
 
-    return audio_pcm_sw_read(sw, buf, size);
+    if (audio_get_pdo_in(hw->s->dev)->mixeng) {
+        return audio_pcm_sw_read(sw, buf, size);
+    } else {
+        return hw->pcm_ops->read(hw, buf, size);
+    }
 }
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
@@ -1085,6 +1099,26 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
 
+    if (!audio_get_pdo_out(s->dev)->mixeng) {
+        while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            sw = hw->sw_head.lh_first;
+
+            if (hw->pending_disable) {
+                hw->enabled = 0;
+                hw->pending_disable = 0;
+                if (hw->pcm_ops->enable_out) {
+                    hw->pcm_ops->enable_out(hw, false);
+                }
+            }
+
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
         size_t played, live, prev_rpos, free;
         int nb_live, cleanup_required;
@@ -1222,6 +1256,17 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
 
+    if (!audio_get_pdo_in(s->dev)->mixeng) {
+        while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            SWVoiceIn *sw = hw->sw_head.lh_first;
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         size_t captured = 0, min;
@@ -1746,6 +1791,11 @@ CaptureVoiceOut *AUD_add_capture(
         s = audio_init(NULL, NULL);
     }
 
+    if (!audio_get_pdo_out(s->dev)->mixeng) {
+        dolog("Can't capture with mixeng disabled\n");
+        return NULL;
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
@@ -1898,9 +1948,13 @@ void audio_create_pdos(Audiodev *dev)
 static void audio_validate_per_direction_opts(
     AudiodevPerDirectionOptions *pdo, Error **errp)
 {
+    if (!pdo->has_mixeng) {
+        pdo->has_mixeng = true;
+        pdo->mixeng = true;
+    }
     if (!pdo->has_fixed_settings) {
         pdo->has_fixed_settings = true;
-        pdo->fixed_settings = true;
+        pdo->fixed_settings = pdo->mixeng;
     }
     if (!pdo->fixed_settings &&
         (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
@@ -1908,6 +1962,10 @@ static void audio_validate_per_direction_opts(
                    "You can't use frequency, channels or format with fixed-settings=off");
         return;
     }
+    if (!pdo->mixeng && pdo->fixed_settings) {
+        error_setg(errp, "You can't use fixed-settings without mixeng");
+        return;
+    }
 
     if (!pdo->has_frequency) {
         pdo->has_frequency = true;
@@ -1919,7 +1977,7 @@ static void audio_validate_per_direction_opts(
     }
     if (!pdo->has_voices) {
         pdo->has_voices = true;
-        pdo->voices = 1;
+        pdo->voices = pdo->mixeng ? 1 : INT_MAX;
     }
     if (!pdo->has_format) {
         pdo->has_format = true;
-- 
2.22.0


