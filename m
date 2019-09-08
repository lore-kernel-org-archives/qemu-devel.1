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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC5C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144D3218AE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqvtA6iA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D3218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74yO-0007VX-AA
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e0-0005Zr-PR
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dy-0005rr-8A
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:48 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dx-0005rV-Vh
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:46 -0400
Received: by mail-qt1-x841.google.com with SMTP id c9so13807681qth.9
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fZZmG/om4WHQ+j7s7VCUUnpzxyUjYuwDxbfPmLSS48w=;
 b=FqvtA6iAv8Fv++a8j5jgqQdjy5MHvpXnKMm28nD6ITKruDTpdX3J/ugzP5a01RXPI3
 8dDsCod1KO2G446lsB1JM335DvI8R25Vadn1cbZrPyEm3kSysne+Knz6A1NUlq1h+coz
 /e5EkSbSYM3QdI5xCkxo1m5jgOGDUp3aD7vFX5KH9TYDJBgEStwOJq0+TowM1Cbmb5O0
 1EZbq2cN4/sriCCF5uCs5cT0kTCYmVW5NeL4e/fscGTfMLzhkHWHm+Gwr7dGbD3AW2xU
 rcuYye8R8TT/0TdboPv7TtqrhKzMUr8kQnN1B/YwxQOoBRM3X5QYuf1e8W6ENgnkl+xI
 tlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fZZmG/om4WHQ+j7s7VCUUnpzxyUjYuwDxbfPmLSS48w=;
 b=JqZ3OvKdpN8IlgABcYB08QH7wz8nHZ1sDN90zwsiX2QBS7yK++bKX595+wvyb2wFYt
 xv80CfSpITwsGe/TlClxLMgHWh0uuRA+UXlta4ergjoOhik/IWENrRz1/f38L7BzR2lD
 kl+3WPCd16g09POOxQLv4FBFGxlVaARcW/uXhzyb4OxpxmG7Y67tZtfRKOvo/X4hZpR+
 9Gh6lrczvIovUnqmnnYiOgZmsblCrMgxIz33nTJCkmNUJ9cHUnReXY0KrHHi4G42ELze
 JLln944HWLcl0bUqMogvSgKEYXhM4XZ1ZeSuLZMBs8MrpAdAiLgyYCDl4pXfFhq7Px+D
 b9BA==
X-Gm-Message-State: APjAAAVzpilTvx1VHJEWiT8joSfTj7GRqcckKyuWNoqcrB05Jx1V2U1/
 GqSk4fkrWzjStl0VGH3wBcLo9wIM
X-Google-Smtp-Source: APXvYqy03vGNkodjc0j6zmygCQYQIyqdMti6/N8RkYtu+3HixkpNlSq2P5lgGLPv3MFYk1E5mgHX7Q==
X-Received: by 2002:ac8:36b7:: with SMTP id a52mr17021228qtc.181.1567977765330; 
 Sun, 08 Sep 2019 14:22:45 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:45 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:16 +0200
Message-Id: <b1948f04f3dff0b9fb9b3e0e6a8b0f38b876cdff.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 16/24] audio: make mixeng optional
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
index 6569ffceb9..b7d14d0ef7 100644
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
@@ -1085,6 +1099,26 @@ static void audio_run_out (AudioState *s)
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
@@ -1222,6 +1256,17 @@ static void audio_run_in (AudioState *s)
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
@@ -1746,6 +1791,11 @@ CaptureVoiceOut *AUD_add_capture(
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
@@ -1900,9 +1950,13 @@ void audio_create_pdos(Audiodev *dev)
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
@@ -1910,6 +1964,10 @@ static void audio_validate_per_direction_opts(
                    "You can't use frequency, channels or format with fixed-settings=off");
         return;
     }
+    if (!pdo->mixing_engine && pdo->fixed_settings) {
+        error_setg(errp, "You can't use fixed-settings without mixeng");
+        return;
+    }
 
     if (!pdo->has_frequency) {
         pdo->has_frequency = true;
@@ -1921,7 +1979,7 @@ static void audio_validate_per_direction_opts(
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


