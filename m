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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CCC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309FE20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aODO4P+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309FE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aMq-0005Io-1X
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7n-0006BU-Sk
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7m-00021W-G1
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:55 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7m-000214-9N
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:54 -0400
Received: by mail-ed1-x544.google.com with SMTP id y91so31230497ede.9
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CkbcNK8c6K6YdTYC4vE0JkUjaFLBw/HOWigtjbt3gZ8=;
 b=aODO4P+1b+rcYyVJEY32x2/MJZ3G73tFck5IHGIb1mGguPoNqlXlHa7QhrqUC6eD+/
 tVWiO0zq6GuMnSViphl1iM/uQHarcRrr813pP5LZyqXzHHQbv1L7SY92fmnBfsACTuW7
 IvN7XbGu9RxGFb5xtOKolangNTAfTjnV4aYqrykJUTukrC51dx1GEuaVIFQponzBGH1j
 /wpUpCW+09H72OXoBgIYLxCJi7nxR9r54QmimpWWk5WSsLgr2DbGdOb+OQfvY2QT/D3t
 s7wkTURf4uvylcxeKd1aTd9B4sv2OFueA5gy7VUk8bgBY6ChxIaF8M6wBP9aTxYXRarp
 xcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CkbcNK8c6K6YdTYC4vE0JkUjaFLBw/HOWigtjbt3gZ8=;
 b=d+Ii7lw/rRo3QAXfBIeDUQgTUo2iCEVl0PFY4F+Hj4/06tYiOdOMCKLrzxcySlQE+A
 vvMgiqjIcejlDSlDsg4G3XybSB04GYGVzbwxqn66VwrEm2NyRjBMpQ38VXmrM5806Cp/
 2p0XLqlwxQ5/4wupZM7JO0lkEDdoYxKJklObCzhoGphuI5ViJBh8+RiWv3jUcZ82F99J
 aAymB27ViJwEDEZKq9mddBL8uaII9BoKvmkqhg3TMmfo/b4kuxneMiy0c/1P2UPcw/4G
 9yA95T46Lllql+auVWcwxkx8AT9bIy9Yadru1jR+uHwgAghqjH4yXDITC1HiT6P7TUE1
 begg==
X-Gm-Message-State: APjAAAUtOXK7W+jfnSnPdFuYk+h8hmOKWULSloDvSbWaQZMNsqiLLdQq
 JkABQJBKhMNCDqRx8kFmABJDzfmv
X-Google-Smtp-Source: APXvYqwQMhXHmADG4DEAkDi6hitPNBhvna/40MHfz5Sq+PCFYEy5rMU61DJ56wFO8Pqhk0QqVPDwsw==
X-Received: by 2002:aa7:d694:: with SMTP id d20mr50436005edr.226.1568575433168; 
 Sun, 15 Sep 2019 12:23:53 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:52 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:32 +0200
Message-Id: <0adb9ca41b5abad2e048e9e36137446e86d5905c.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: [Qemu-devel] [PATCH v3 16/24] audio: make mixeng optional
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

Implementation of the previously added mixing-engine option.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c          | 70 ++++++++++++++++++++++++++++++++++++++----
 audio/audio_template.h | 20 ++++++++----
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7128ee98dc..d616a4af98 100644
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
+    if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
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
+    if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
+        return audio_pcm_sw_read(sw, buf, size);
+    } else {
+        return hw->pcm_ops->read(hw, buf, size);
+    }
 }
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
@@ -1090,6 +1104,26 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
 
+    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
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
@@ -1227,6 +1261,17 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
 
+    if (!audio_get_pdo_in(s->dev)->mixing_engine) {
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
@@ -1751,6 +1796,11 @@ CaptureVoiceOut *AUD_add_capture(
         s = audio_init(NULL, NULL);
     }
 
+    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
+        dolog("Can't capture with mixeng disabled\n");
+        return NULL;
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
@@ -1905,9 +1955,13 @@ void audio_create_pdos(Audiodev *dev)
 static void audio_validate_per_direction_opts(
     AudiodevPerDirectionOptions *pdo, Error **errp)
 {
+    if (!pdo->has_mixing_engine) {
+        pdo->has_mixing_engine = true;
+        pdo->mixing_engine = true;
+    }
     if (!pdo->has_fixed_settings) {
         pdo->has_fixed_settings = true;
-        pdo->fixed_settings = true;
+        pdo->fixed_settings = pdo->mixing_engine;
     }
     if (!pdo->fixed_settings &&
         (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
@@ -1915,6 +1969,10 @@ static void audio_validate_per_direction_opts(
                    "You can't use frequency, channels or format with fixed-settings=off");
         return;
     }
+    if (!pdo->mixing_engine && pdo->fixed_settings) {
+        error_setg(errp, "You can't use fixed-settings without mixeng");
+        return;
+    }
 
     if (!pdo->has_frequency) {
         pdo->has_frequency = true;
@@ -1926,7 +1984,7 @@ static void audio_validate_per_direction_opts(
     }
     if (!pdo->has_voices) {
         pdo->has_voices = true;
-        pdo->voices = 1;
+        pdo->voices = pdo->mixing_engine ? 1 : INT_MAX;
     }
     if (!pdo->has_format) {
         pdo->has_format = true;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 235d1acbbe..b6c5466cff 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -78,13 +78,17 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 
 static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    size_t samples = hw->samples;
-    if (audio_bug(__func__, samples == 0)) {
-        dolog("Attempted to allocate empty buffer\n");
-    }
+    if (glue(audio_get_pdo_, TYPE)(hw->s->dev)->mixing_engine) {
+        size_t samples = hw->samples;
+        if (audio_bug(__func__, samples == 0)) {
+            dolog("Attempted to allocate empty buffer\n");
+        }
 
-    HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
-    HWBUF->size = samples;
+        HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
+        HWBUF->size = samples;
+    } else {
+        HWBUF = NULL;
+    }
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -103,6 +107,10 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
 {
     int samples;
 
+    if (!glue(audio_get_pdo_, TYPE)(sw->s->dev)->mixing_engine) {
+        return 0;
+    }
+
     samples = ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
 
     sw->buf = audio_calloc(__func__, samples, sizeof(struct st_sample));
-- 
2.23.0


