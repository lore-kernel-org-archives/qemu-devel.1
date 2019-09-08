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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D531C4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7972216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjIdf9Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7972216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74r2-00005I-Ov
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74du-0005T4-Ab
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dr-0005oU-I2
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:42 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:40367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dr-0005o0-6s
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:39 -0400
Received: by mail-qk1-x730.google.com with SMTP id y144so3036573qkb.7
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DUW7OK1573+eRJ/c4anJ7nOB3W09/QGNLs1FK1NrsmM=;
 b=LjIdf9FamuJs+vN2e0hWtNUXtSnv1Za7sEkY1JsCw/WUbd3D2hHgeBvr5aNANR8SA+
 wd6NUrS3Gl5t4umT9GDXirRcxYJRfDuA2J6fUnqgSrpDvr23F+amXFhUqV+nfejiy6mC
 6/rRMMEUmiEJgDlUYX4TmnkRLAFimqYaL8a4MnIOZVyjzr4WnIfdPltFAV2stxDCLdwk
 LGBLgBNaNejAL1QX8ZDRJJwnQDk8Y5Wx9ZoXB0Z6bTpXS1oYm3Xdxdi8p1lmPRhRNumQ
 bTsHQJW/H9QeY+6QsTUaEnKq7SrAdEWqAp3Zfe6Alop04d1Wrx08vAoZGk24kI8IhiJ6
 /dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DUW7OK1573+eRJ/c4anJ7nOB3W09/QGNLs1FK1NrsmM=;
 b=GFHjjgYDWmaapIWsMhNM0Iwf6sovLaUsjArvsAYfPKQEx5i9/5bGLAxYJhYv/Vbu9K
 j8Mu9XPT1rp/YegysuQYK4InOXyuatY9NZMQUe3GWe4C9Vsj/boTE4XBBTp+h7aJqjRH
 u2TwF/gIS0XkAt9MjSG1J00tSrxFB7INZhbksqB/XbdxNH9T5NKrjpR19K8yU9uRaFuX
 VK4xnFdzKiuxoae31jQ5v80Bdan8Dy4go2zmPjPxNaOg0P4h74M0u+fpN0NUJYad9KVJ
 ozgvcWOGkLGFn+1is7olYOZRw/QJ04jV6kz9gH3tZuXcUps2qgo2EoJeDG6p/v3ykzmO
 sJGA==
X-Gm-Message-State: APjAAAVv0DzqkoyRc9SJbXj/5gfOlY/6eFM63L9dzHnCXEXc5GYQfeHE
 sXzuJPHnMtVbgTK3ci6OVF/LQbM3
X-Google-Smtp-Source: APXvYqyldDMXW3W9DS7DbNgJBTMqrW+mjiVPSIsomuXEVDvUiqf7h3Z4tvHGdCRi+smHVZIxce2m1Q==
X-Received: by 2002:a05:620a:1ed:: with SMTP id
 x13mr20221514qkn.188.1567977758463; 
 Sun, 08 Sep 2019 14:22:38 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:38 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:10 +0200
Message-Id: <f13da4b48e7220b186037fdc75d6b13a9174519d.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
Subject: [Qemu-devel] [PATCH v2 10/24] wavaudio: port to the new audio
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
-
-        src = hw->mix_buf + rpos;
-        dst = advance (wav->pcm_buf, rpos << hw->info.shift);
-
-        hw->clip (dst, src, convert_samples);
-        if (fwrite (dst, convert_samples << hw->info.shift, 1, wav->f) != 1) {
-            dolog ("wav_run_out: fwrite of %d bytes failed\nReaons: %s\n",
-                   convert_samples << hw->info.shift, strerror (errno));
-        }
 
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
2.23.0


