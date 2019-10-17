Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7711920854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gP9ZxiW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Xi-0001BC-C3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5uP-0003XE-B9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5uM-00042I-34
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5uJ-00041l-8q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so2615124wme.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FQ/H1UToQ0yQenkMqC8Bhi/SSkQ/gTM/lhOzcdKaVnQ=;
 b=gP9ZxiW4J+8v67ocp0R9PcMzYhhr0ftaInx8VwZvo0sUtcaQbM9jPJEibW3E7KZ05a
 QH8eb3bgZvR+chh9ZAW5Tdldewq3PLKtFEiVB9IWptAufzc0JuVHKY8St4TUTDe/kETM
 T+APKcGUtjryN1Mlte1rWVhy/V7Vlvh48TEcRBzid36t+N/hGQVfjNl6o+J/jatChzzs
 CJlJbbNJ06BCH8oKD5pwYya0H385xM6Fnwj1e0xGBNh4nZrz63xp32pTudPym9mWLen0
 6IbrbRDIRJzjdh7f4gOW+VL5HdJbIgIPMyNwdI7DqDcYTSasJC7C7aUqWv6NJHADWeT5
 qGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FQ/H1UToQ0yQenkMqC8Bhi/SSkQ/gTM/lhOzcdKaVnQ=;
 b=RxSfSgxj3V8mCiqK3+vdr/zGXtFVxbLMA47m0a+C6sP7ySFDDyo7SZspcwT+ykkCTv
 AEHO0Fa8OofgADBGaV7+WP9UWWxoEAgOeV4eJ8absI9IQwbpnHA3N0Xe2ngmSUcJEbEd
 VBmELUKN+rIMh4mUcpZZMpRUTL0L3iBEeCssJWKdMN+hpNC5w/zAv5TbnxEZU8Mm73sd
 fKrClDZR+YzHjPnJLUMcMOtDko9rbCqieaafeeEi8r6iX9AWNUCIhIzJRONlgys+djoB
 PCVYn2eYj+YSN3FjPYiJ2hkb+M67FgwI4hZG4zHp4SwG09aaBDjvlRuAEF9IwVPvgtIv
 8VKA==
X-Gm-Message-State: APjAAAXjmnylEL/pByiaNWybInHTWyDSL/SsNCKZxSZE9ED2vZsaO1Va
 iDNPdhLziVuemAUcHa3s2cjYWQ==
X-Google-Smtp-Source: APXvYqwZynsI9zSBcXvgUMTXPPYUkBu78ukeIjHloEJVDm3wtLknrCCwa90YAUTfyAojm0kSzGtJaQ==
X-Received: by 2002:a7b:cc01:: with SMTP id f1mr3117397wmh.113.1571319213561; 
 Thu, 17 Oct 2019 06:33:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o22sm2530991wra.96.2019.10.17.06.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:33:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/arm_mptimer.c: Undo accidental rename of
 arm_mptimer_init()
Date: Thu, 17 Oct 2019 14:33:31 +0100
Message-Id: <20191017133331.5901-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit b01422622b we did an automated rename of the ptimer_init()
function to ptimer_init_with_bh().  Unfortunately this caught the
unrelated arm_mptimer_init() function.  Undo that accidental
renaming.

Fixes: b01422622b7c7293196fdaf1dbb4f495af44ecf9
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_mptimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index fdf97d1800f..2bf11f788c3 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -237,7 +237,7 @@ static void arm_mptimer_reset(DeviceState *dev)
     }
 }
 
-static void arm_mptimer_init_with_bh(Object *obj)
+static void arm_mptimer_init(Object *obj)
 {
     ARMMPTimerState *s = ARM_MPTIMER(obj);
 
@@ -319,7 +319,7 @@ static const TypeInfo arm_mptimer_info = {
     .name          = TYPE_ARM_MPTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMMPTimerState),
-    .instance_init = arm_mptimer_init_with_bh,
+    .instance_init = arm_mptimer_init,
     .class_init    = arm_mptimer_class_init,
 };
 
-- 
2.20.1


