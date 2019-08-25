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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74AEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D8820578
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWhdW2KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D8820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xZ1-0002t4-El
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXD-000173-9Q
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXB-0004ls-WF
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:39 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:41077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXB-0004le-QE
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:37 -0400
Received: by mail-qk1-x744.google.com with SMTP id g17so12419561qkk.8
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PqX725hKCd4GeXhxOFH/ioUfY3G+VFIRBEoc8xqQdTs=;
 b=bWhdW2KHZwxxmcOF2ZqPqFMzqzJBWvfXuzpB65vIahvU4T9qnwAeyOI7FqtQwCcXYs
 zO1KNuhyMCYgjDiVsnMoQKjt1hoxdTVAFePeezGLi97i1Dnv4y2lELSdZ4e/JD5rN37I
 fdRH2O2BeXiIdps8iltSsWWF+nd/p8iGntKPbgCL+8nFPIpPzK68IW/QuLPuZ6JghVGT
 xMNMZIxd2WaDmcr4ROY02mzCTYhw2eZIE/oPcafOPRVpmka9Pi1wSO+F4YjGPGd4mEVb
 gkYsE/5wdTt4vWcPs8fQBJqMZT63RVypreGbxjq5qqNDskaCthKp2F5eSU2SdT2hfY/3
 CbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PqX725hKCd4GeXhxOFH/ioUfY3G+VFIRBEoc8xqQdTs=;
 b=uWtzDh4UTohraFqT42i6zFd34oEoZUGMwRPYoXUKTVu6r4oULrkzITMkhYWIBom/sx
 +Iw9Iiqs7fKEB94twjN87RQptEpvOhTmGtzscluaqew7m9A5cByTgIJtDxhS4TkiLQ/i
 IhmbPvBJwMYGiy6BlPABPg4zH+4XwljOuJAykGXTLG6dmZg0RLm5VJCA1bKBqbDH+Mc4
 U9bsYTfRTRImRYl87FaZbNqdgcyumaH86vOu7qVu+gQ4ChhsMWBrZrsGHDW8pMS+d9LE
 gDA5jVC9NBtnZw6PZQ5bnaFfXnbAYfk7hvXTzrpn5daUPdikOhnWGNGNYEk5dI6kGl8n
 bk7Q==
X-Gm-Message-State: APjAAAXbtkxiftkhUkYy9WQHaSHn3FMwShIWDpjs7bsbzOGJBeSQJ0yx
 oYowRlhLeAZBWnvJo4AUDk6JCM8zBuw=
X-Google-Smtp-Source: APXvYqz/v5ybJQH+ColdfuqBbsbec9ZIoI2ARZnBJNWE4wOxFxMALn9R0lslgVT9ANA/Y6rC/0HL5g==
X-Received: by 2002:a05:620a:15e5:: with SMTP id
 p5mr13545974qkm.409.1566758797231; 
 Sun, 25 Aug 2019 11:46:37 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:36 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:07 +0200
Message-Id: <723371f5ccd5a2a58fc1fa9a375d6c508bebcc19.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH 05/25] noaudio: port to the new audio backend
 api
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
 audio/noaudio.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

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
 
-    if (dead) {
-        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        int64_t ticks = now - no->old_ticks;
-        int64_t bytes =
-            muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t ticks = now - no->old_ticks;
+    int64_t bytes =
+        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
-        no->old_ticks = now;
-        bytes = MIN (bytes, SIZE_MAX);
-        samples = bytes >> hw->info.shift;
-        samples = MIN (samples, dead);
-    }
-    return samples;
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
2.22.0


