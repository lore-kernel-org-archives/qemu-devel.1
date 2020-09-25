Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18126C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9BC21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Di5T9gsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9BC21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLksr-0000JQ-Mx
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLknK-00017P-3a; Fri, 25 Sep 2020 06:17:38 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kLkn8-0007QM-CO; Fri, 25 Sep 2020 06:17:37 -0400
Received: from sekoia-pc.bar.greensocs.com (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 16C69C60F1B;
 Fri, 25 Sep 2020 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tKa1P2RI8QqeDivN4AwKZq089IN8gBMXYs/CxNR70A=;
 b=Di5T9gsYyNKiIQa1A2BerU2u5MUBsMgWmxBBGdSIo+0W7JCnxq+Nl+UlmyVghd/xiA4ze7
 h7CwGbgYBW9KfeqfRKRPhiSmMMVO9LLXynqEOj0eBwLJ8GUC04C0I6oWdELgGPfutjKoQi
 jVElSY82BxiBBfYdLwZp0DHNCq/E/SqaprgVVRZmmnwDt6HDUXVoGpnY/FPJX8RuywHzgC
 4y/PcwJXb8Pagkv1JbCQkgwpOT9ZCMHAJp1pxPRuDXF82MMF/o0xd1M0WZ6gyCpVc246uF
 SDwUuDraUWeOJ1M73XIswaJ+OUSsDhI+J03neuXa2ei3z3Dp6jXS3LVdbC2fXQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/14] hw/arm/raspi: fix cprman base address
Date: Fri, 25 Sep 2020 12:17:20 +0200
Message-Id: <20200925101731.2159827-4-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601029040;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tKa1P2RI8QqeDivN4AwKZq089IN8gBMXYs/CxNR70A=;
 b=b+YFla3H32U0KcBLxS1Kwb+jVwYfCEfZYn04ZWOGWCoVYteklzMcrDn5RQvifuIg+Q1DN/
 75qI1zKGtmwDxV8+l5mctaBoD/3kpQeWsJMcCtTOe66ula2Gy3s7rW3AJkDW+y3aWQCO0T
 FUalF+xAymcG0YHvBZL52u62njA/eyB9Ex1y2rwhCSSgYK9Kcqi+ZHPFQ8VJvkpVvsecDj
 w/lDeb7hqHK3Re6qhLUABXctV8BDD8DhRiDAZAMxf448FxPWfNRa/Wqt+FvPdG3VBtdmZs
 NJhzBdJYnsl3hUQ3HmArCHxJBUvmmJPt6q5WCrJfNNuvuSCX+0DyhumkOGAtNg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601029040; a=rsa-sha256; cv=none;
 b=immFFgtyNuj6HTtbPGPzuSGZORnYh1JrJd/+MGtz0nkRwZIvdTmpn+Pvt1QZPKOYQC/5Abag4aqHlfOZdT20PDuMOlwBpyy4uI0pVYUFvOhKryDnuI+McjWHlA2KtLvjGTLrpBH1qmcRe3yl1YCOkPiaRk7X1Z1VFevU/IkiYAV2nf++5NRn3megf7OnbYm0Uvom+jgL9q9dOdR4rIfcTbjXZK/1xGWemYubItsbiJlSCFbI32l0wZNvZMvgbI0+A4r50LUDjeUFoiOuRFKqiKP4elImEut/x0aVrLtijrQQD5QZw8VVwXe94WbTmJlCuS3kW1ERP1GXUH3JG5oVmw==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 06:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cprman (clock controller) was mapped at the watchdog/power manager
address. It was also split into two unimplemented peripherals (cm and
a2w) but this is really the same one, as shown by this extract of the
Raspberry Pi 3 Linux device tree:

    watchdog@7e100000 {
            compatible = "brcm,bcm2835-pm\0brcm,bcm2835-pm-wdt";
            [...]
            reg = <0x7e100000 0x114 0x7e00a000 0x24>;
            [...]
    };

    [...]
    cprman@7e101000 {
            compatible = "brcm,bcm2835-cprman";
            [...]
            reg = <0x7e101000 0x2000>;
            [...]
    };

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/arm/bcm2835_peripherals.h | 2 +-
 include/hw/arm/raspi_platform.h      | 5 ++---
 hw/arm/bcm2835_peripherals.c         | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 13d7c4c553..199088425a 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -44,12 +44,12 @@ struct BCM2835PeripheralState {
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
     BCM2835MphiState mphi;
     UnimplementedDeviceState armtmr;
+    UnimplementedDeviceState powermgt;
     UnimplementedDeviceState cprman;
-    UnimplementedDeviceState a2w;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
     BCM2835DMAState dma;
     BCM2835ICState ic;
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 61b04a1bd4..51a477cdc2 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -34,13 +34,12 @@
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
 #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
 #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
                                                       * Doorbells & Mailboxes */
-#define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
-#define CM_OFFSET               0x101000 /* Clock Management */
-#define A2W_OFFSET              0x102000 /* Reset controller */
+#define PM_OFFSET               0x100000 /* Power Management */
+#define CPRMAN_OFFSET           0x101000 /* Clock Management */
 #define AVS_OFFSET              0x103000 /* Audio Video Standard */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
 #define MMCI0_OFFSET            0x202000
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a9d7f53f6e..f0802c91e0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -342,12 +342,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dwc2), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_USB));
 
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
-    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
-    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
+    create_unimp(s, &s->powermgt, "bcm2835-powermgt", PM_OFFSET, 0x114);
+    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x2000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
     create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
-- 
2.28.0


