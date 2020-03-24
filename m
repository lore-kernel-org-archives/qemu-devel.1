Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F6C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3622073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9Z+3Gon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3622073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjxM-0002UG-Ed
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwH-0000t3-As
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwG-00027C-9F
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGjwG-00026D-2l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id b12so3270819wmj.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GqrPP4sW4bKrCjaavS5T9m3kc5HNFO7tik0hAhfsKeY=;
 b=Z9Z+3Gonj2GW1vFcxpVaAkbvqTN8qTAyzdqj0A+WeDx3Cz/EkWfhir19uda75BcmKH
 i8qxvWSPw0WAnR4sdYINwpViCCYcMEVm6ufVG3XjQ/T+Si0I4YGnbl8in5f+KLeghend
 xgz7h9qjyP+nwgpvMuPwTBa+/GEkYXR3xUgOsrgFPrOig00OsTdInNmZ4sGz0BXNAvLa
 ebhUTvVA6VTzNggKhSoNZFZfysVOw6er1c2IEjiN72c02kTiZOhuh/MmT5s92sRAku1P
 5i34mRzt/7NevNelTYSoVCWXQIHX1w0Qdy+dDA5LFg3XJOFxxxF28JjS1bKBRCSgHLnG
 /moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GqrPP4sW4bKrCjaavS5T9m3kc5HNFO7tik0hAhfsKeY=;
 b=I/3OZ8QJooImajdFTI81h7WRaBJxEXFrpq8iXt+zXJKnpSMM2ihCyn0MsDMHO7W07/
 zAKF5tSDwzo//2Qko/+h4h+odMmhsZ0zqSQXD1KtqXPb1WAqA8lmkDJYD0XxSq5TCl7f
 9Ym7kDQTajGYv4FRx9u1Mc91kj+7JjpceTYoi5Qlvet24Toh9klZUPezO8KiC7xWSedy
 tvDCj+Q443cY35wFluAcO4vFWTuSQtSGQOCRrLJFxUn4JiiEOwoQ1wkkxV/ZHMwgD0/H
 NjkymTBtuGKXAizMcvd42exX3gjToTWb9OtoIZERzJVZyIvfZpvOaFULjeFoDsMYsLLX
 paBQ==
X-Gm-Message-State: ANhLgQ0P0RjSMMqQKwdbpybgzsJB7f+M+t9zYTxmO2B/vinNH/t4E40A
 /Ia/5DbJltVl0ETpWDMZZFB0gQ==
X-Google-Smtp-Source: ADFU+vu3upNEY5EEgc61bVnXHwhqj89G/3fIiqEzSyYXgS4YgZU1M70Nu4gIrUBjHS5KTC3AMcpD4Q==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr5780321wmc.30.1585057791092; 
 Tue, 24 Mar 2020 06:49:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k3sm4332067wmf.16.2020.03.24.06.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 06:49:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return
 path
Date: Tue, 24 Mar 2020 13:49:46 +0000
Message-Id: <20200324134947.15384-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324134947.15384-1-peter.maydell@linaro.org>
References: <20200324134947.15384-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In xlnx_zynqmp_realize() if the attempt to realize the SD
controller object fails then the error-return path will leak
the 'bus_name' string. Fix this by deferring the allocation
until after the realize has succeeded.

Fixes: Coverity CID 1421911
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 49f1c8d0de2..a13dbeeacec 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -520,7 +520,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
-        char *bus_name = g_strdup_printf("sd-bus%d", i);
+        char *bus_name;
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->sdhci[i]);
         Object *sdhci = OBJECT(&s->sdhci[i]);
 
@@ -541,6 +541,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
 
         /* Alias controller SD bus to the SoC itself */
+        bus_name = g_strdup_printf("sd-bus%d", i);
         object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
                                   &error_abort);
         g_free(bus_name);
-- 
2.20.1


