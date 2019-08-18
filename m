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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D551C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1032146E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/hEBuFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1032146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUPV-0000FI-L7
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGU-0006Xl-Tq
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGT-0005K0-Nd
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGT-0005Ja-Hu
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id i63so16840wmg.4
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dS+kQo1c55Y/59/HzMqpFWI2NLCxKN5RjySdBkuDcJI=;
 b=H/hEBuFr9fIE8yMMnGaCl71lqlD4OX7fAVFmQcauR+7MEG8TxUUNOseahuQ1YO+UAJ
 OdZmqJULAJR3e0UjcEVj8IJ+uycjwtAj66Wy+ZhD+5Ricb4352R85V7cPUHcMc7M44+M
 80Keli+tLAHDMmlG0sLBkuyy3qGAGqRD1yfhA7Iulc556pLnKE8HQH1KaGn8NXRiU2r8
 AMnwleH/6bPQ7gBbvvli0rzoxegLiE3x6mrDst8FP+2jSlXxbYzhPl4DvlqsmrzVlxL/
 yp1fgGpv9abUvq9Xn6nIB1HYHNa2Xh6hoD6Bpn0WI1EQVtrXq4RZ1e1KUeKURohib9he
 SKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dS+kQo1c55Y/59/HzMqpFWI2NLCxKN5RjySdBkuDcJI=;
 b=o4Lj3XrhK4zI+us/5XprH57lgsrKW3N56hm+uhiUNg2Dx6RAKYOMFPf7BIWq3FDAYx
 aSfZkqtsPGqLft5rY5AJP8w604sBpGCrhFNK7eMmVeK5J+qFMK2+93bKle2cgsWgmwLC
 aXRivAzXnHMdtjaMe6UKRLTTZr/v1eDM7i2dOMGYRxvzVAZKazIyD+jMnsow1TrWkTy0
 k2MJ7I2kQisRlfKwVnM0/T9wfV47ZgI6W8jsz6y7/bKVzVIVciXl2ujixVyRyVkEPR+N
 3IG05Z1ewGlKdqT5X3yR8Ozq/Gv7PsCeMTwiWIrcJ8xrtEI4YSB38k8Ak5qYbvmvZ065
 qL4g==
X-Gm-Message-State: APjAAAV/5yj96X2xxjJjL5FMBPZ5xENsFmA8TO24Il+5XYapaaV73qOe
 NHzX616A2Mv4s745KBU/2QY+dXi96lw=
X-Google-Smtp-Source: APXvYqwPKgWQ8wU6T+M9Wy4C3GwxANfIpTjy2gX8Wh4rIMNExKIviDqWLirRo+6FdX0ZhY6pHkA4Gw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr5044447wmj.58.1566169628470;
 Sun, 18 Aug 2019 16:07:08 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:08 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:55 +0200
Message-Id: <10221fcea2028fa18d95cf531526ffe3b1d9b21a.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 10/14] audio: do not run each backend in
 audio_run
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

audio_run is called manually by alsa and oss backends when polling.
In this case only the requesting backend should be run, not all of them.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h |  2 +-
 audio/alsaaudio.c |  7 +++++--
 audio/audio.c     | 14 +++++---------
 audio/ossaudio.c  | 12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9f01f6ad00..7e00c1332e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -221,7 +221,7 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
-void audio_run (const char *msg);
+void audio_run(AudioState *s, const char *msg);
 
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 6b9e0f06af..3daa7c8f8f 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -39,6 +39,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
+    AudioState *s;
 };
 
 typedef struct ALSAVoiceOut {
@@ -199,11 +200,11 @@ static void alsa_poll_handler (void *opaque)
         break;
 
     case SND_PCM_STATE_PREPARED:
-        audio_run ("alsa run (prepared)");
+        audio_run(hlp->s, "alsa run (prepared)");
         break;
 
     case SND_PCM_STATE_RUNNING:
-        audio_run ("alsa run (running)");
+        audio_run(hlp->s, "alsa run (running)");
         break;
 
     default:
@@ -749,6 +750,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
+    alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
     return 0;
@@ -850,6 +852,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         return -1;
     }
 
+    alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
     return 0;
diff --git a/audio/audio.c b/audio/audio.c
index 100c3ea177..cb6a9d8ac5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -835,7 +835,7 @@ static void audio_timer (void *opaque)
     }
     s->timer_last = now;
 
-    audio_run("timer");
+    audio_run(s, "timer");
     audio_reset_timer(s);
 }
 
@@ -1237,15 +1237,11 @@ static void audio_run_capture (AudioState *s)
     }
 }
 
-void audio_run (const char *msg)
+void audio_run(AudioState *s, const char *msg)
 {
-    AudioState *s;
-
-    QTAILQ_FOREACH(s, &audio_states, list) {
-        audio_run_out(s);
-        audio_run_in(s);
-        audio_run_capture(s);
-    }
+    audio_run_out(s);
+    audio_run_in(s);
+    audio_run_capture(s);
 
 #ifdef DEBUG_POLL
     {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 29139ef1f5..456fba7480 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -110,28 +110,28 @@ static void oss_anal_close (int *fdp)
 
 static void oss_helper_poll_out (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_out");
+    AudioState *s = opaque;
+    audio_run(s, "oss_poll_out");
 }
 
 static void oss_helper_poll_in (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_in");
+    AudioState *s = opaque;
+    audio_run(s, "oss_poll_in");
 }
 
 static void oss_poll_out (HWVoiceOut *hw)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
 
-    qemu_set_fd_handler (oss->fd, NULL, oss_helper_poll_out, NULL);
+    qemu_set_fd_handler(oss->fd, NULL, oss_helper_poll_out, hw->s);
 }
 
 static void oss_poll_in (HWVoiceIn *hw)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
 
-    qemu_set_fd_handler (oss->fd, oss_helper_poll_in, NULL, NULL);
+    qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
 
 static int oss_write (SWVoiceOut *sw, void *buf, int len)
-- 
2.22.0


