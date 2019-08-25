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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69DC41514
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B5F206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLCfTsXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xcw-0007dz-6L
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXI-0001Dz-DA
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXH-0004ou-8I
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:44 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:40980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXH-0004ok-4P
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:43 -0400
Received: by mail-qk1-x735.google.com with SMTP id g17so12419649qkk.8
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XtrHwn1zkRNV4vQ2j9JUvtsTzwP05eHn8uPhQEwhvz0=;
 b=NLCfTsXvz6+QG65kfUzfHnGW80nPVsZnkDk8YUT6cpwlwi5uY6U75xohf3snS9B9IP
 QFw2MwO4ZBWzOw4Dke1hHRToVnMi9uzFp0E7UUKY7CsDHQ7heWibpo2e5aARyvcJ4HR6
 xxTlwtdZZVCaM1OvfiotdRXRh6GLybn3pL5eMDHqMY6/ZUu7IFeN8PmVc18XDnUgd3IX
 YRZDEhv9efubF4JGaNd4sg/b+69uXVD5t8+XKqpuGn1J3ZI48wN/o7HXepFeH94pkwBx
 seXaVfyVWWW6DrtQhmYGmsL3GT2hGKjkDNi4xcJ6mXGCiOzMjsLj6VQpf2NhqcpknxXm
 yKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XtrHwn1zkRNV4vQ2j9JUvtsTzwP05eHn8uPhQEwhvz0=;
 b=R6bcFdldgHwKTsi2E4+/FzO1BM43bNlJuzm0NypCLYHt6E/FryQSK9OsOzHCAT1j+g
 bf4Rip7rlxFgLfZG+XNhdluLzgCrXvUbeamQy6FerZATD/iTTq9Hp+uR5oCRsMNvCv1X
 5fUazP1cOdpwWbn+0+ICU9CNTBqaGqFXGXlhVwHRuVA+NK9/wNRjE9z9CARlH2F9Gsqg
 ZCxoWdrfsOLxaWTFDWYm8i+/zDusuFIBpJKMDK9eAs83+ajlpXi3JAgxKeWRbCeVr9cK
 VN3G5qmajel8Y1wvwAi9vkVe2wn0PSlavWtofxpPz8GX2KqZUYo/jPPGad5Dqn7iv3Dk
 GiiQ==
X-Gm-Message-State: APjAAAWqyEt1YEbd5GBcOPOIslYNm3D8LDHCUY6/2KWDSYTLyrtQnnaQ
 IJuZ37uz5l9X33BQqXvF112maC8YSP4=
X-Google-Smtp-Source: APXvYqxYfwkd5a5yrlZu+7LBwB47x06HO0uYsaFw39mEe5sATrDia1/TgqE+oMxJpmOG9q9lUS9cIg==
X-Received: by 2002:a37:af82:: with SMTP id
 y124mr13539364qke.311.1566758802518; 
 Sun, 25 Aug 2019 11:46:42 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:42 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:12 +0200
Message-Id: <4e9ba92e94b6cf07f607f88dbf8c03ac2ca9b27e.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::735
Subject: [Qemu-devel] [PATCH 10/25] wavaudio: port to the new audio backend
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
 audio/wavaudio.c | 54 ++++++++----------------------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index b6eeeb4e26..7816097db8 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -36,52 +36,28 @@ typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
     int64_t old_ticks;
-    void *pcm_buf;
     int total_samples;
 } WAVVoiceOut;
 
-static size_t wav_run_out(HWVoiceOut *hw, size_t live)
+static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    size_t rpos, decr, samples;
-    uint8_t *dst;
-    struct st_sample *src;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     int64_t ticks = now - wav->old_ticks;
     int64_t bytes =
         muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
-    if (bytes > INT_MAX) {
-        samples = INT_MAX >> hw->info.shift;
-    }
-    else {
-        samples = bytes >> hw->info.shift;
-    }
-
+    bytes = MIN(bytes, len);
+    bytes = bytes >> hw->info.shift << hw->info.shift;
     wav->old_ticks = now;
-    decr = MIN (live, samples);
-    samples = decr;
-    rpos = hw->rpos;
-    while (samples) {
-        int left_till_end_samples = hw->samples - rpos;
-        int convert_samples = MIN (samples, left_till_end_samples);
 
-        src = hw->mix_buf + rpos;
-        dst = advance (wav->pcm_buf, rpos << hw->info.shift);
-
-        hw->clip (dst, src, convert_samples);
-        if (fwrite (dst, convert_samples << hw->info.shift, 1, wav->f) != 1) {
-            dolog ("wav_run_out: fwrite of %d bytes failed\nReaons: %s\n",
-                   convert_samples << hw->info.shift, strerror (errno));
-        }
-
-        rpos = (rpos + convert_samples) % hw->samples;
-        samples -= convert_samples;
-        wav->total_samples += convert_samples;
+    if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
+        dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
+              bytes, strerror(errno));
     }
 
-    hw->rpos = rpos;
-    return decr;
+    wav->total_samples += bytes >> hw->info.shift;
+    return bytes;
 }
 
 /* VICE code: Store number as little endian. */
@@ -137,13 +113,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
 
     hw->samples = 1024;
-    wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!wav->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        return -1;
-    }
-
     le_store (hdr + 22, hw->info.nchannels, 2);
     le_store (hdr + 24, hw->info.freq, 4);
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
@@ -153,8 +122,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     if (!wav->f) {
         dolog ("Failed to open wave file `%s'\nReason: %s\n",
                wav_path, strerror(errno));
-        g_free (wav->pcm_buf);
-        wav->pcm_buf = NULL;
         return -1;
     }
 
@@ -208,9 +175,6 @@ static void wav_fini_out (HWVoiceOut *hw)
                wav->f, strerror (errno));
     }
     wav->f = NULL;
-
-    g_free (wav->pcm_buf);
-    wav->pcm_buf = NULL;
 }
 
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -234,7 +198,7 @@ static void wav_audio_fini (void *opaque)
 static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
-    .run_out  = wav_run_out,
+    .write    = wav_write_out,
     .ctl_out  = wav_ctl_out,
 };
 
-- 
2.22.0


