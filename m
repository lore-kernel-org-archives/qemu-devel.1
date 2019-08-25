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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9617C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767BA206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgcRdddg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767BA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xmS-0002MX-CN
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXV-0001Q5-9v
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXU-0004w5-71
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:57 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:33088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXU-0004ve-2D
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:56 -0400
Received: by mail-qk1-x733.google.com with SMTP id w18so12481028qki.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+olaGUmCEjHabl5zPvWo+LBZ+w54gUP7+HUOcErgF3U=;
 b=jgcRdddgd6rcpO6JSXO5U/Y44HYcqDBKAVV1ZAKe3x+pSJVjEByfTxrBUoe6pMPFWP
 eP87Zds4XvMYUIwTgM9opHwLFDjlGB/pV4BAzB7Sr+rCd7xiXlaACVplSNfEjwE4vd9y
 UK+d2cS1E3Mjtshy/QgiueJJc5dfu3G2h+6LSSaBNlx3E5axuZva8BcM/SnnYZiX6iT9
 u2sReWKGoY1UsdHSonekdzAL+DddX2L7Z6+EcsOraf6WpcMqioO2nr2WVHP1c+VXSByJ
 dDKbe1D9hXfLf9mMxXxgDKd9IjiBMY390j4I9lUQLIEvXoyg6ENFlDEilMAXn3i2fM4P
 PF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+olaGUmCEjHabl5zPvWo+LBZ+w54gUP7+HUOcErgF3U=;
 b=QgXASUF1NBM9u91xF2PToaeBBdtRepdHSXztq9L3OvYYOjT7clIpwT3diLX0Gjxo82
 OFUVr0jcuSYGm3nmu9hiC6HNxubcdQoh8paWBG8c8i6R4RhhS4qkMudNTMXDH7bUJxod
 cWi+0SnkFqAk7pT+AZbGL3eXPMBqs29UFFOgI7OCgmTZqEQ/8kA7GuVS27qBUCI/t60L
 VuCWiwqu83IhGlEzk33w1coVGnCwyyJJjqZDvQAUsIJF7JzIBd/wy3epdFmx8NvBBA4u
 grWSK8zV0SV6vT5KJF+hxzHeaSu5x0mF2L3be1uqUOmkvbzkqn4zG090uOdGbJ2Tyok8
 Vbfg==
X-Gm-Message-State: APjAAAWSEJ7+WixOu92If4ekL9q4F/m/6bp79BSreyOtHr977DW8spk6
 j+WnPVPBPC0QAe0hsNLXkeKmnKiEPN0=
X-Google-Smtp-Source: APXvYqyrYkRCq+VXgsJ42HnyqLaWh/xh1JySOSk3afy/84eEVbpxPLRrvCbCHeeim4kbGrKCijqXOQ==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr13351150qkg.80.1566758814692; 
 Sun, 25 Aug 2019 11:46:54 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:54 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:23 +0200
Message-Id: <48ae407f0d7000ee0864223dfaa3c40cebe8fe20.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::733
Subject: [Qemu-devel] [PATCH 21/25] audio: basic support for multichannel
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
index b3b21e07a2..b201cfc736 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -495,13 +495,6 @@ static int alsa_open(bool in, struct alsa_params_req *req,
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
index f46bd5dc3d..2fc5b0ff38 100644
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
2.22.0


