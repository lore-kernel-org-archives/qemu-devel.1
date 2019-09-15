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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBAC4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3199821479
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzv5jNjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9a8U-0006rx-BV
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7e-0005yu-89
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7d-0001xr-3A
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:46 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7c-0001xe-T7
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id f2so24889554edw.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aJOgLJbUU33d0sFNF8d3VZOVm5JVuSp9jkJ/aPDzPik=;
 b=Yzv5jNjcLcJ8Vt2OLBoEbcOBm6N6e3A6fmcp+eGZ5p3Cq4m3M52Y0aTo+TDI0nXIrd
 fFlmIaiZ/Rio8gu99Fk1zyliIpuDX1Nn8NcgXSGkvk2gQhVj5IPolhAOceg8j922A5IR
 PA88L+a7Z39LajYfWKSsFGMgYmj8qpmB6NvrZtOfRQJOFV8gSbXswg6IfrchrR4jz4pK
 U8CqY+1/CzM1xU74KYFJNH4vc1qiANKOt8ndlmXTt5n7fa53ll5cf8jBZtvzG7yYK4Ei
 hkwcOEl+x5S0gw5agoks6ckf+r/mHotliQqAxvOZMemKlUtoKw9UoRu9UMf5h0puMLAg
 DmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aJOgLJbUU33d0sFNF8d3VZOVm5JVuSp9jkJ/aPDzPik=;
 b=Y7Dzhg4t0RDceMWNScEi71pPAKaZMuA9My+ytBQRrMNhdKg5/R6ohgvvWn0lU2S28F
 nm54AvklkoBh7Qfn/e47488t02n+aGp+ckS56/T6u3C0xAf3QGByDGMmdZX4fc42z1ul
 Vrw8sdQW5b9q0MzSq0PB2tfXXRWHLYIYyHwLenDWp2Bmq5+a+XDWTx0H0el0BVlu7N2l
 RL7aieN4215t9zbZp8/8I5bWkMaL5aR2LAZpc08u4rWKrmWvf6jUjI9FcKhMsW83QgZd
 Iofb70nLHo1kfxAkYf/T1bRwYlJkj1q/WLFQRFipzNAzCmQofP69FnhpuN1T0jx70o8V
 tnYQ==
X-Gm-Message-State: APjAAAUJrI0R7Gydk/r9ByveZj9cnyeL9Cmkz2i9vL0Kf9tUSE24fqGY
 iSkIeZuXyDbANxcjCSkVE+g8KeV3
X-Google-Smtp-Source: APXvYqz9Khx1uU7OuIacnmMKC0KnIARyLiTag+o2EStpbmqs1KhyRJ+vzjBt9NyYOsEN8irUeHplkg==
X-Received: by 2002:a17:906:c742:: with SMTP id
 fk2mr17169378ejb.44.1568575423774; 
 Sun, 15 Sep 2019 12:23:43 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:43 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:21 +0200
Message-Id: <066dc6dd54f4382d80de4376306f585b7fb47805.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: [Qemu-devel] [PATCH v3 05/24] noaudio: port to the new audio
 backend api
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/noaudio.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index 0fb2629cf2..b054fd225b 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -41,10 +41,9 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
 
-static size_t no_run_out(HWVoiceOut *hw, size_t live)
+static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -52,13 +51,9 @@ static size_t no_run_out(HWVoiceOut *hw, size_t live)
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - no->old_ticks;
     bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-    bytes = MIN(bytes, SIZE_MAX);
-    samples = bytes >> hw->info.shift;
 
     no->old_ticks = now;
-    decr = MIN (live, samples);
-    hw->rpos = (hw->rpos + decr) % hw->samples;
-    return decr;
+    return MIN(len, bytes);
 }
 
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
@@ -92,25 +87,21 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
 
-static size_t no_run_in(HWVoiceIn *hw)
+static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
+    size_t to_clear;
     NoVoiceIn *no = (NoVoiceIn *) hw;
-    size_t live = audio_pcm_hw_get_live_in(hw);
-    size_t dead = hw->samples - live;
-    size_t samples = 0;
-
-    if (dead) {
-        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        int64_t ticks = now - no->old_ticks;
-        int64_t bytes =
-            muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-
-        no->old_ticks = now;
-        bytes = MIN (bytes, SIZE_MAX);
-        samples = bytes >> hw->info.shift;
-        samples = MIN (samples, dead);
-    }
-    return samples;
+
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t ticks = now - no->old_ticks;
+    int64_t bytes =
+        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
+
+    no->old_ticks = now;
+    to_clear = MIN(bytes, size);
+
+    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift);
+    return to_clear;
 }
 
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -133,12 +124,12 @@ static void no_audio_fini (void *opaque)
 static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
-    .run_out  = no_run_out,
+    .write    = no_write,
     .ctl_out  = no_ctl_out,
 
     .init_in  = no_init_in,
     .fini_in  = no_fini_in,
-    .run_in   = no_run_in,
+    .read     = no_read,
     .ctl_in   = no_ctl_in
 };
 
-- 
2.23.0


