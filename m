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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43917C4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE8C218AE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJGtId1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE8C218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i751W-00014D-9D
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e3-0005cK-Ak
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e2-0005vH-7y
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:51 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:44769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74e1-0005v0-Va
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:50 -0400
Received: by mail-qt1-x841.google.com with SMTP id u40so13809653qth.11
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CtjKKyn1WE+uGIJpF5emUL6aD8nQttfLcRsN/KEPtcI=;
 b=pJGtId1NkDb0qe0VwYjNaydQ3M4uiSm+V0F40+XACKaR+Gi8HDz0T5kDqJuwRASOdn
 4+XCSb+HdmThFeZ5TXWr10tPBeYC5/u0c4Jl83bBvz8vg+fOQNWN8JJ1p/K4Tw1SyQfR
 b/bNUIdAI6SkRNX6iKJ4IkE4I76ztliZx40jkDamOnEZXLQ5CHzGy3/i05VKiJmiXvs3
 /K1+eWXGLX72YwOq4fmOCjsGrve95H0TORfscK4GJFG/fHGeeBB2DphappgtronzgKB1
 VYkkYgeungAnG92XxDmh5gUw7nVWxhYywWWDrTghfi6zTfb+fZud2YuzB7rKB6x0EHLr
 7ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CtjKKyn1WE+uGIJpF5emUL6aD8nQttfLcRsN/KEPtcI=;
 b=Es9RJzrpExldKd639S81JPxh5lgsZ/ay5NgSJ89/HGOR5F6LCBzCkKIQheZCMfFIqv
 SsF5I1UoYoSH/CjyGTmXE9gKuvxY6boIANMOYv1oBeFXUih6bKGy3NtKujB2KSkNbr6O
 /HYLscrlHa/CrSYK96sEh3ASCO2oEGxRBmHpv1J6gCKg5P9DlNr+qYYcAzd9RTkEmfD5
 codGXHfWPnepD3Xv+hxa1LF4bi9slY8VB/6nqWYABf8zUp9Pc5DjasyTdWp/PA1AX4/c
 ugPvmGEuNAW/GV6Nlp5NNENROyTE4om3i3AzczaPhvTylYrI10l9RuEoJQUgrWZz/jyC
 /7Bg==
X-Gm-Message-State: APjAAAWfIJQX1ECopnTYGwXmtHRzTRx1oR6KfwqngenUn9DZTLW6Gwwa
 tuwKyd+5cNiWNXvM35YuvR+m5ZcP
X-Google-Smtp-Source: APXvYqw/eKdN3mWh9ITnjmE6SbjG/p+5madrT1PnHi7eaXRU/P4YXgwSwJDZXtLSxDktAAFf9kDF5w==
X-Received: by 2002:ac8:1102:: with SMTP id c2mr20936817qtj.340.1567977769504; 
 Sun, 08 Sep 2019 14:22:49 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:49 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:20 +0200
Message-Id: <fbc093cea392d1b05489030f817a74fe68a046b0.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 20/24] audio: basic support for multichannel
 audio
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

Which currently only means removing some checks.  Old code won't require
more than two channels, but new code will need it.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 7 -------
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index eddf013a53..f37ce1ce85 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -493,13 +493,6 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (nchannels != 1 && nchannels != 2) {
-        alsa_logerr2 (err, typ,
-                      "Can not handle obtained number of channels %d\n",
-                      nchannels);
-        goto err;
-    }
-
     if (apdo->buffer_length) {
         int dir = 0;
         unsigned int btime = apdo->buffer_length;
diff --git a/audio/audio.c b/audio/audio.c
index 7821365a85..6a5979f262 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -242,7 +242,7 @@ static int audio_validate_settings (struct audsettings *as)
 {
     int invalid;
 
-    invalid = as->nchannels != 1 && as->nchannels != 2;
+    invalid = as->nchannels < 1;
     invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
-- 
2.23.0


