Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0352AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C707920718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywwETYnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C707920718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugfl-0000hV-H7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRl-0000Ux-KW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRj-0003xr-Vr
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:05 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRj-0003vc-PL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so3586228wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=o4xSgx2m35zUuP+7sJH7VCULByapC4KhuLB9uUeF7Ow=;
 b=ywwETYnzr/RN6Ud+RLG8i4NbvraIIeDSjbmLN82lnjEGCyiF0ouZRfZfIel84lE/1q
 L1csCvZ1QbZYdcZ7EIk6GHY0eAFwbgLyvxXK9hcec94tcTCForEHIOpU3ZcCb6Dhk4tz
 q/JklHRObWqFCIDGA+fUckMPhiBUg2/xxY6Vf2omO7ZBhJQvDr2pufkZ4FV1pPajfMZj
 FMXDWaNDiULAuqtKmYHoOyMhtV8cBrXE6kaxJOksXuTtuHzQ5E80K+mJDy80Hqk5+5Zq
 jzMBVW2p5NGe1JpCRB4OXnR7u5SvFRJYnwZGPu+stIvHvymP1pQEHqISJtwqhhwghMs5
 QW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o4xSgx2m35zUuP+7sJH7VCULByapC4KhuLB9uUeF7Ow=;
 b=uL98+DLAwhmh0dsmagS+OJl3ftVDp622rVkCK4Gd8Lm1+fqlEwQrQ31bD9N1c2K2qA
 FSWNvTc8y7a4Myr4ms7zg81arkRjw6uGu0N1H2VwMjITmyYuCEeT99OgMqLsMtsBB+qj
 L3HSJyP9P5/62kPO2rQvDIwlef1GoOtvTYzSaod86O4xKe6hOH604bAiQrA4mBBYl2Ju
 E/gOcCisj4KT5Qgn5wlysnSZGp+xF239Bdc+YWqypyNXMUjMuDLCHvXex0o04E+6Zh1+
 5NXuPHwq8dzhLpRYX1BGGlYWmyOsrEoJBD/LsCHQECD/2RRp2FpnwD84GJ4Njk+H8Zid
 OJBA==
X-Gm-Message-State: APjAAAXBtcnFbo9VIXev5RkOH4XbMIjdPRkj7WKr45riQIoIHp2M/tMD
 9tT6hCJreENmR7CqXIF8FkxIF2KxXIUFNg==
X-Google-Smtp-Source: APXvYqy9pOmxSNxVk36Bh76kznSZXaDbRyt0tJzhOPt+BfKnZYEwiMsLYC7y2TWOYlqk18MeZbrU9w==
X-Received: by 2002:adf:b648:: with SMTP id i8mr18076969wre.91.1579793461680; 
 Thu, 23 Jan 2020 07:31:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.31.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:31:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] hw/char/exynos4210_uart: Implement post_load function
Date: Thu, 23 Jan 2020 15:30:38 +0000
Message-Id: <20200123153041.4248-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Guenter Roeck <linux@roeck-us.net>

After restoring a VM, serial parameters need to be updated to reflect
restored register values. Implement a post_load function to handle this
situation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200123052540.6132-6-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index b3199df865e..6ffbaddfff1 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -522,10 +522,20 @@ static void exynos4210_uart_reset(DeviceState *dev)
     trace_exynos_uart_rxsize(s->channel, s->rx.size);
 }
 
+static int exynos4210_uart_post_load(void *opaque, int version_id)
+{
+    Exynos4210UartState *s = (Exynos4210UartState *)opaque;
+
+    exynos4210_uart_update_parameters(s);
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_exynos4210_uart_fifo = {
     .name = "exynos4210.uart.fifo",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = exynos4210_uart_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(sp, Exynos4210UartFIFO),
         VMSTATE_UINT32(rp, Exynos4210UartFIFO),
-- 
2.20.1


