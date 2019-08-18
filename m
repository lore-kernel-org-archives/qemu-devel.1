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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78139C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4079321852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsuOOaXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUMB-0004Pf-1S
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGR-0006Rw-KB
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGQ-0005I5-G5
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGQ-0005HY-9w
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id f72so3532wmf.5
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MC5OBi2ZKOOmkFl5C2VVnsgxIzYWjfoInmdM2v3Cze8=;
 b=UsuOOaXmTczy80F8wbUoqzhQiUICFu75SELHegUHSzSKOkm3Uxx5oAj15CvCUuQ9xn
 8wXRs3XmcijEPnzlA7R+Ktk/TE7e/y4kfwqPbKXqNxKHueqM7zwRVeL/EQbvehXZ2lF9
 V8Jrzsh6jV8UtlXlJDl4ypnI8H/fRpBDbWZsBFetnEzij4RdnnayI+aie7aPsBEQQMT3
 kdMSUG/diphhFFwM361wVmAQzU4fxybN0bm0X2oK9m7ejG8bZ/jWXsyqbr4Tv+U5phuQ
 BP7M40x6XLjgjo17alSzc2isTc0zcUlAz71WX33Id7InXwmKi6u9ZxMFCsYsSSVPReyY
 RPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MC5OBi2ZKOOmkFl5C2VVnsgxIzYWjfoInmdM2v3Cze8=;
 b=LmqSshWS/LFtjjVA4Y4OxuEoWa7dyiV8GwwAqZ3OVVq0W2uykDThKksEJf0SjaocEh
 acYDsLe/VqphgzdPISdlUHofL3U+dPZdtTb0t9HhxJgo956Y0o1hmodTGNPXgken9W1d
 fsVdXS+bh563e921wYBxyTKLUsbiJDr27W799yInz54FFNBR33yLxY5QNfOcCVXaelBv
 W6lBGBQKKxbKKEWJ1In7JMeqARYARsWx4VSRh6KX8EXc769eqYz64OHAS5uIPycsftSs
 Vu45lWVbDwFM4pR9JBzAfqESqESw5w7F9hD0MsnExrU/hbI4+4LYrQBMiJ0ig29+MkTj
 fzPw==
X-Gm-Message-State: APjAAAXtXLcRtZwJznSD98mmtV/CsuYmb2gKnXCazWqKFnLmZGUybokP
 g0Is3/rAUzipgnfwQmTj8KLJy4ib
X-Google-Smtp-Source: APXvYqzn2YOp7nH//zWfPOO/oGy0czHT7HY+tAkV12V+YD/enBcYLtAZCsUaWsbCT00vL+FmvvEtPw==
X-Received: by 2002:a1c:a852:: with SMTP id r79mr16366961wme.36.1566169625207; 
 Sun, 18 Aug 2019 16:07:05 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:04 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:51 +0200
Message-Id: <9072b955acffda13976bca7b61f86d7f708c9269.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 06/14] audio: audiodev= parameters no longer
 optional when -audiodev present
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

This means you should probably stop using -soundhw (as it doesn't allow
you to specify any options) and add the device manually with -device.
The exception is pcspk, it's currently not possible to manually add it.
To use it with audiodev, use something like this:

    -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v1:
    
    * Split off paaudio changes to a different commit.

 audio/audio.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 8e9ccd0ac4..7267cab9d7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -101,6 +101,8 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
+static bool legacy_config = true;
+
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
 #error No its not
 #else
@@ -1392,7 +1394,7 @@ static AudiodevListEntry *audiodev_find(
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, const char *name)
 {
     static bool atexit_registered;
     size_t i;
@@ -1406,12 +1408,13 @@ static AudioState *audio_init(Audiodev *dev)
 
     if (dev) {
         /* -audiodev option */
+        legacy_config = false;
         drvname = AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
-        /*
-         * todo: check for -audiodev once we have normal audiodev selection
-         * support
-         */
+        if (!legacy_config) {
+            dolog("You must specify an audiodev= for the device %s\n", name);
+            exit(1);
+        }
         return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
@@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *head)
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
-        card->state = audio_init(NULL);
+        card->state = audio_init(NULL, name);
     }
 
     card->name = g_strdup (name);
@@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        /* todo: remove when we have normal audiodev selection support */
-        s = audio_init(NULL);
+        if (!legacy_config) {
+            dolog("You must specify audiodev when trying to capture\n");
+            return NULL;
+        }
+        s = audio_init(NULL, NULL);
     }
 
     if (audio_validate_settings (as)) {
@@ -1776,7 +1782,7 @@ void audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        audio_init(e->dev);
+        audio_init(e->dev, NULL);
     }
 }
 
-- 
2.22.0


