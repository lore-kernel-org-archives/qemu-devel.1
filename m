Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950FC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7FD21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHOSlsIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7FD21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB43W-0001ND-Cu
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uu-0002so-Ul
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ut-0000jg-0j
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3us-0000iS-MI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id m18so7313wmc.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=AHOSlsIfbajntxWCcG9fEUs344E6E1JUHXLXxLaIUc/mBfTNysPLGeivbZYYtDy+bY
 /L0dKFQRhmFNSQM8b2BdUM/WKBodRpxM9gcpxV846OXsV4gZwtVCqGpdTMu8sJv/7ya1
 zaqraQm6GGbJh7hyvdw8lOOjiDoFEVbPw7utdKg7N/Yg09jLktWFzQRV5cIrMU/b6NsS
 qmS/aDDx+f0tTZPKDa4ss+PI/XUso9zV/KdH1KNDiS6IGgvXLy7x1lqEFpML2XlteOWs
 wJtBFFux31aOfK45b2BkKxrFPm/Dvnz1jfKCC4R7VFgoGV4UkciWr4sKgHc7ka8bxA07
 VOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I/J8Dq/+F7R0/J6BZwd7lt84Aly4P3hEz64ceVDIF5c=;
 b=gun1KyzjuTXFmwNlJ6XcvUPn/W0JTB0ldJIZwup8/yjcs5jn7i1KQ5GVHxMcXw4u22
 8briC4b4GBLW/n+dQEp4mywcSZByWKh31xhxeu1uzEOodWzdcnKBiwvm28i4BTa1dgo8
 pHA09X9zjzucSdotO1KDpGvtClJ8zjqgyRuMqLT+60uMGaYYcZ0+nWv6wiSxMwDxuH9+
 9mp+H2cRqBd0cOraM36GXQiC0lv4NyUkaPtpmLDR9K7ppaYMLT6iM7rq0OMEboe95BGB
 SEJ/aPw+915TD+bHfT3o+9tkgkH+xRjdc3TeHpfocSxgPVMvMBD3qdKFxRh4AD6MBSHq
 r71w==
X-Gm-Message-State: APjAAAVz/9HWn28gKzG2wMAGvtMMuRmfV8tFkNXSOT3Q6JJT2B/mMReH
 ho9tZNAmuZ43SSp/Q36fWJQZxY9j
X-Google-Smtp-Source: APXvYqwhbqDcI0Hk9Oiw45ldyKVbrXPxNIeYszs4t2bnBqNA7h3bdZMxUViKkwspl4QYHIdgHcPDvg==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr62686wma.91.1568928280857;
 Thu, 19 Sep 2019 14:24:40 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:40 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/24] audio: basic support for multichannel audio
Date: Thu, 19 Sep 2019 23:24:28 +0200
Message-Id: <6af77a930dc3cce0b807154182ad621a64786307.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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


