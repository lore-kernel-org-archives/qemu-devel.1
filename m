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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC0C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9847C20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7U/F/dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9847C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aP7-0007sV-9Y
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7q-0006FA-Hj
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7p-00022i-IZ
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:41882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7p-00022O-BZ
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id z9so31223670edq.8
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=m7U/F/dMZMQAUzd79fElEmIRt7mqeNxMvHIXfrOrMDvzuY7rHxMu+BqWtDuXvapNcQ
 7TPZ5NUbeYYuoATHkoVX0x7DeDAYpBsbaEfTJiEtceANTUJDbAfHtlWzcW5vgMzYMscX
 xoak4oDt7YWFdZPeLsVcHnHkLlXis5gcU8c0XHv9lfr8DOIqiCScPvVcplkWLcGWR1ZL
 ECt6Yh7HB7TVR/mx1Vetz57JVwA0b82Dga9omD2x8ODvCIh+J9OHhrvHxa6BxshpxaJa
 JL2FD6UMfvIxy6n45ETktCbVsCkc8kYDM3+7EWjNlqdPVq3Fk1eT0FPh+MNGpUuQkvcV
 Tg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=Ek76JV0u0liKyOZl8Qo0ZCFeLhHb3K9egLEli2fmLVq2nv6qBnRDQgztiZEZ9n4ZSi
 l8CEshjUoRc2XvMYXZ7lRVKyR886iatAZNrJdpT28ktJ4vxs0AFgVe1tcgw7gqD+OR/G
 pa5058RwgC/VBCZeLjhah7nMW21HGVGmE2SZd9+P9/b5900nMJfNWHcGl02KuWrhnBgP
 lQLW32O/Io0dFLGnC85N1O5W/v8iEHa9Lm7o9sBAgjc7z49HU87k+R3NdevemrUTFtcZ
 ezc/JKMgo353aTWN/boQHmzsWv1yc4KZl4rO3No6CThh6MO8VyYkZePIsdbS3Nh8su2E
 GEJQ==
X-Gm-Message-State: APjAAAXtf8/Gnwwz7/RwaVbmAU3p3WRcXDvq673BKZv2NPsT3w2jA/ho
 SaXnaw/vyju735qhhAakUyzASNmf
X-Google-Smtp-Source: APXvYqxCkI4zTkbV9wCo2OAUJmscygmgrSf+33wTnFnK7ywi6Jb6+EH5MJXe/5AjhbsV6reOlycqBw==
X-Received: by 2002:a17:906:5606:: with SMTP id
 f6mr48473247ejq.110.1568575436287; 
 Sun, 15 Sep 2019 12:23:56 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:55 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:36 +0200
Message-Id: <00998152d6e1c25b3194b9b71e27f14c4d26f396.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::529
Subject: [Qemu-devel] [PATCH v3 20/24] audio: basic support for multichannel
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
index c00f4deddd..7fc3aa9d16 100644
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


