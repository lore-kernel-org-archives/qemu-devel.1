Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE7AC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580B2206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJlbfFnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580B2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxkE-00008X-CT
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaO-0005vn-Ik
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaN-000255-Rg
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id k12so2288658wmj.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGQyVlItBWg+QMCBMM+TrrsDfjaKkcl5GXGLKiX+zsQ=;
 b=UJlbfFnRKlo08E6WJSlA71vOjywdkQaq8JSMrcJFkLurvuD973FqV9NTTSz5Pfy1bB
 4Zm7yZudlNVXRl/QprENSqpS4x0AbPD60mBuwQSLRtiYKtpz9IX4hFYgCAWg80bSJL3l
 lzNiYrc4o8gRF5v3twMs+GAqVH7RMDpn/KC4MkA+A7ICzhQSJmks5eriF8Yz5JxDdnv3
 QYGsWO7FXLRRfC+OqwvUFuwAqVtGVV4ESHPEWeVVUEvM6Yaio+7ZJxXYDWDEy8+JOloj
 KjtkSLQ3PfFBvpOFEl2M3JSR8qOX9jKK9/7etYtXKadYfGI0wq4fkQYtRPfkVpeEpmQC
 rG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cGQyVlItBWg+QMCBMM+TrrsDfjaKkcl5GXGLKiX+zsQ=;
 b=FYWqCeV/Cnot+sWWxL9Mc6nCYewK+h7rvOnR5l9b1tjX7F9xm54TPd+yABTFg4wtfa
 //XuSIgWgMJ66JVZMEY1RTbKJh+oMFsVwv/06JxrPv6LXN4tEZpSmKKvYtBbTx5zJkgc
 n0CTsSiMYesOZDEXAjgY7tvnFE0lnWKVYuVOGYlkdWGG7ODQ7c1U4sC65wLWsXMz8hoZ
 3YpEIWEhOVM7MkoYO6FGdGYheIG3MNgk/09d96KHdZDq2oBd/pKoS7X4ESuSAslXnpbB
 AbobPcCXS7ssXlJlFVL42enivbzwbJ7ubduk/OXJmHUMUlxgE9PV79BFy+/UCSGw6Bhs
 1kGw==
X-Gm-Message-State: AGi0PubLO9riENjKbJoJ7IyhDoSzgw7M+qoHhQ/anxT8Qs/LoF/c2PN8
 BvUVM8NXDxMrjOE1eiugG2gLbILz
X-Google-Smtp-Source: APiQypLJ/z+3NkSEkmxOy4PTp0XwOVusVsKCgTEjSFF/yKI03zb6t0HWCfth41qc8Mm86GY4ej/2ow==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr3495155wmi.8.1588685170316;
 Tue, 05 May 2020 06:26:10 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] audio: Split advance() helper as in() and out()
Date: Tue,  5 May 2020 15:26:00 +0200
Message-Id: <20200505132603.8575-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the buffer is to be filled, rename as advance_in().
When the buffer is already filled, use advance_out().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio_int.h | 8 +++++++-
 audio/alsaaudio.c | 4 ++--
 audio/audio.c     | 2 +-
 audio/ossaudio.c  | 4 ++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index fb6947c435..62829de4e8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -255,12 +255,18 @@ static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
     return (dst >= src) ? (dst - src) : (len - src + dst);
 }
 
-static inline void *advance(void *p, int incr)
+static inline void *advance_in(void *p, int incr)
 {
     uint8_t *d = p;
     return d + incr;
 }
 
+static inline const void *advance_out(const void *p, int incr)
+{
+    const uint8_t *d = p;
+    return d + incr;
+}
+
 #define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
 
 #ifdef DEBUG
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index a8e62542f9..a32db8ff39 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -615,7 +615,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
     size_t len_frames = len / hw->info.bytes_per_frame;
 
     while (len_frames) {
-        char *src = advance(buf, pos);
+        const char *src = advance_out(buf, pos);
         snd_pcm_sframes_t written;
 
         written = snd_pcm_writei(alsa->handle, src, len_frames);
@@ -809,7 +809,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
     size_t pos = 0;
 
     while (len) {
-        void *dst = advance(buf, pos);
+        void *dst = advance_in(buf, pos);
         snd_pcm_sframes_t nread;
 
         nread = snd_pcm_readi(
diff --git a/audio/audio.c b/audio/audio.c
index 7a9e680355..c75455bbb5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -571,7 +571,7 @@ static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 
     while (len) {
         st_sample *src = hw->mix_buf->samples + pos;
-        uint8_t *dst = advance(pcm_buf, clipped * hw->info.bytes_per_frame);
+        uint8_t *dst = advance_in(pcm_buf, clipped * hw->info.bytes_per_frame);
         size_t samples_till_end_of_buf = hw->mix_buf->size - pos;
         size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index f88d076ec2..7778138df5 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -439,7 +439,7 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
     pos = 0;
     while (len) {
         ssize_t bytes_written;
-        void *pcm = advance(buf, pos);
+        const void *pcm = advance_out(buf, pos);
 
         bytes_written = write(oss->fd, pcm, len);
         if (bytes_written < 0) {
@@ -678,7 +678,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
     while (len) {
         ssize_t nread;
 
-        void *dst = advance(buf, pos);
+        void *dst = advance_in(buf, pos);
         nread = read(oss->fd, dst, len);
 
         if (nread == -1) {
-- 
2.21.3


