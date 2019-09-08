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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BBFC4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF073216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea18fNz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF073216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74gN-0007Hw-Lj
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dr-0005P4-5J
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dp-0005n5-8S
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:38 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dm-0005lH-PK
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:35 -0400
Received: by mail-qk1-x742.google.com with SMTP id d26so11180354qkk.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aJOgLJbUU33d0sFNF8d3VZOVm5JVuSp9jkJ/aPDzPik=;
 b=ea18fNz3UYHkebWJICxI2+ze3wCE8uJYvthAea1XAYnB/tygYxZMl9Xcytj2j9+plK
 c1djaaVLZ4GwLPwB0OL+5DtSS5I4/eBTlJDd0uWYHi7P83/fUKyRC1gJmGaF79oZ69MB
 Qud3A29RyH1iDo+fKifK8GmkHR3CVjyRf4HkKbsQgJfV/fYCYTZye+/Au1S2kzrMSbQy
 lZwpGu7JdPYIyrTr2uivnLbwG906tNL9e2nmqYgufpSoE05o32UOQvf44ADcxc8dCsTl
 8NB0omSKQ/SSQLCugwsoXvxa4za+nFmwQd+OEl4TK2VgUp1jbo8AujIpfgzvawIaeo2t
 Fs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aJOgLJbUU33d0sFNF8d3VZOVm5JVuSp9jkJ/aPDzPik=;
 b=fMtgmImQzf9mN5eWH3n2lBL0xCT+DNFdKVtYLzQMnO9jstach0XUhwaNp/GuMHhLeW
 270eaytbuz0NIbjx4F5waIQMgTVpvR3nI9gZpDuNIXknT3ItUiCKgn5xlaVRDuGRFkdN
 psrmBnacijjpcbvtSfmY1rNFGlJJAE5TWAtiuC49ZUejyKazJwTVz0zo39scs79dJrAi
 wevb1SGKEBaC87J0w6rbZNZ6Qb34wY0P+xANCEkUPc4zWd27gmIRuZf/nKnX8qkWdl0v
 8PIehlEaJnhmG2MtotJDOO2bZOHR3qpKQgYm5jNI3E+o5mfXXTYufkNHUApZ2YoMtOQd
 d0Fg==
X-Gm-Message-State: APjAAAUk6RtCXP0xCd/Ugh9/QOFVt59ujCKSk7mVjdVaJHZfye29MnDo
 5u6U3JU+qpeIIHKvANhArNEgKu5q
X-Google-Smtp-Source: APXvYqx4Kc7OTnHXRmN8Cb8sDgYUVnMcnfJb/dryJKzw6cWHRtaD4x5ysKNlBBk8MqhWTUIOV40Wcw==
X-Received: by 2002:a05:620a:118c:: with SMTP id
 b12mr19666237qkk.336.1567977753262; 
 Sun, 08 Sep 2019 14:22:33 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:33 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:05 +0200
Message-Id: <5f8b1296074b596be487c6fbd04699650a5b094f.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v2 05/24] noaudio: port to the new audio
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


