Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D72CC33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E1020678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyahkz/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E1020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itY29-0000pz-Bc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itXww-00029H-CU
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itXwv-0007nV-0C
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:22:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itXwu-0007mY-Ob
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:22:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so14927797wma.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b7fnyn7VZswX8TxYX4J1qJUh5P887/OHSr88SWkveho=;
 b=Vyahkz/P+3DzNLR+9XZIz/K7GjySh5cxlt3SxqUgX63Esnkysg5HXM1R4vJjtl3X1P
 dEz0e4jLjZPBohr5lkCA+l+kT1cNc/BO5Rn6d3sgpls0tDydbNUS9lKDvP/SKHE6jmXV
 Flv2cZCFbWZVJKzPEAXzy+Ui03uzqbIjLXVRm3tQbVL0HAkPW62HnnWxvP8rFU6utsw2
 RpkmVGLHIattBthjB5JK/0RJ0irU9MfKQuiPjz2m80f3tApK+duRo+oxnFMtSWXfVxW7
 dOVQaGVWTz8o/O/70uwrOfEW2z8MlgPalwOX58mYJNR2ZpasRpQrSsNuikJTS3MSQE85
 Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b7fnyn7VZswX8TxYX4J1qJUh5P887/OHSr88SWkveho=;
 b=sD21jdIcPGxF+5SQuqI+7KnVg+VDPH7MUwYBtusx1wEXUYvUxYzANZHHGpJa1osPQU
 w1Z0f9BX2CGDXnNc/6E49r66kFCDrNehKwAYWc9TNMyqpOJkwf/bgSUZ+OizN9C8yzYP
 HzfVbWCnKixhNfj3o2ZefJ3y8PxfbYxTRgIrCqZKVZFDdoTcW2wVyEby2KcKBLKpLK8g
 a+NScwr7vZ2gcWGTgElybsL1JRzb8WLowyu+ZQXV4bnxcik0X7j7bN6FECl/mWXKqx9P
 MOVNQx70NnlGMOywKmYx1PrlHvzynnUx8FlxKKRuG53CM0KSFLntLCAy52E3isiAqmti
 a9kA==
X-Gm-Message-State: APjAAAVySg7anTfahmDKumjOribdkMIhq9G01A0w0oiiFOOCbp8hIMj4
 O3L9An8pP3gFZDubPgvKSohEjkQevQkmng==
X-Google-Smtp-Source: APXvYqyZHPTmn3IAiL1n2h8pE13XoEqUHTNZ9VmuS4wRCjVJHcYO2QHbsMwV5Oa8BP8yOERlnpK78w==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr19435952wma.66.1579530158689; 
 Mon, 20 Jan 2020 06:22:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l18sm22873016wme.30.2020.01.20.06.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:22:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/core/or-irq: Fix incorrect assert forbidding num-lines ==
 MAX_OR_LINES
Date: Mon, 20 Jan 2020 14:22:35 +0000
Message-Id: <20200120142235.10432-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The num-lines property of the TYPE_OR_GATE device sets the number
of input lines it has. An assert() in or_irq_realize() restricts
this to the maximum supported by the implementation. However we
got the condition in the assert wrong: it should be using <=,
because num-lines == MAX_OR_LINES is permitted, and means that
all entries from 0 to MAX_OR_LINES-1 in the s->levels[] array
are used.

We didn't notice this previously because no user has so far
needed that many input lines.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/or-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 18d63831cd3..2be18333811 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -58,7 +58,7 @@ static void or_irq_realize(DeviceState *dev, Error **errp)
 {
     qemu_or_irq *s = OR_IRQ(dev);
 
-    assert(s->num_lines < MAX_OR_LINES);
+    assert(s->num_lines <= MAX_OR_LINES);
 
     qdev_init_gpio_in(dev, or_irq_handler, s->num_lines);
 }
-- 
2.20.1


