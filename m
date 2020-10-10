Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6478322284
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="HMGpABo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6478322284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRFO6-0002hd-Ft
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMx-0000wC-Ua; Sat, 10 Oct 2020 09:57:07 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRFMv-0004IL-Ov; Sat, 10 Oct 2020 09:57:07 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 73493C603C3;
 Sat, 10 Oct 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ytL1MgY7atcQnOFYVbyvTI9rupTIt9JujlNK/ak1Y4=;
 b=HMGpABo5vO/RgT/gxQSOLj/JIiXd+iiSudGYOuJt9l/lPdigScpn1G4SzzPOijf2WmllcZ
 vT+IUpvap7WcvuAc/MxSJVbG53Gj5I4m2Lk4zYVbi5GS/8htA5twYhzk7aXigzFISCr39s
 3/9rkoG6tW3QLrPIFxVAHVWqFZV7EVWFJzZ+B1XwGUv0czyJYhB8EEbNbLORfa/08itEAQ
 DAZSGG3vkLfZTd3A9EStKpVNE6oEmkG4vbxoAEQyoxEqfnjz3L/7+gFKOMXyVrCVB69bPO
 BJZSdXVisGN2OSDAtKuOlbb2RWs3dQbcSyTajGL05s9POKim/NkySD6LxVKw0w==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/15] hw/arm/raspi: fix CPRMAN base address
Date: Sat, 10 Oct 2020 15:57:48 +0200
Message-Id: <20201010135759.437903-5-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010135759.437903-1-luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602338223;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ytL1MgY7atcQnOFYVbyvTI9rupTIt9JujlNK/ak1Y4=;
 b=Xm1biEHWyaHyJQfPXv5f9QPVqwIy595+MHsM2vE5O65CdHNxX0ZRcTRBiT1iiV59GBDnGT
 w7eboM3nTfXvqnz43B4vCCXeSC6hYWMacILQOaHgBv+TjSQANwXs15V8rhgmO/akhXou5R
 4mxJ91o0e/wu0Z47I9oktqu71TkU+qHU0uUZihze8V1ClkE9BL/A8+EDrVs4EqZo8Oe+2t
 fvpyPiPSEFElAqlIAsd9Hm/OeZTVImYzh4u/xG1m/FEhwu9i8gzQe7BEyCfkBK5L5TJVZY
 yfTG2clEKbyKgW8fMFDILVPlz9JvUe/xPYFtSes22KgqkYwcL/C10qEZUzW+RA==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602338223; a=rsa-sha256; cv=none;
 b=W3Jwk6gL8rIjXjrujXwJDigLhmUGylV95EQtaStRJtL0RIfYJRpF9VDYS6SX1/MSxWRABo9VoC9jEqPylWe4nQVkEICK8bIpD0OBHfw6uEAEcM8umsj66pnfZae8FlXTpTFp+wW/wpfFXgwXvSO2bBk66EclA9RqXpscYQEScuMExjJCZ2UL28/TWhZfnQvP+kH5k0NjyiIZM8oqdb/7ijGolU2h9AawGWJt/xHrq8kP0op7F+Y1B4X0AWOhRJETUJb9IBDn6luvwulrIes8GZn14OZJ21n8pBtUdpoas+4r+wRsaA3jJDG+H/d7ato56tgRdgKLdhTQ9JUkXBKOmg==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPRMAN (clock controller) was mapped at the watchdog/power manager
address. It was also split into two unimplemented peripherals (CM and
A2W) but this is really the same one, as shown by this extract of the
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 include/hw/arm/bcm2835_peripherals.h | 2 +-
 include/hw/arm/raspi_platform.h      | 5 ++---
 hw/arm/bcm2835_peripherals.c         | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index c9ac941a82..6aa94184eb 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -45,12 +45,12 @@ struct BCM2835PeripheralState {
 
     BCM2835SystemTimerState systmr;
     BCM2835MphiState mphi;
     UnimplementedDeviceState txp;
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
index c7f50b260f..e0e6c8ce94 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -43,13 +43,12 @@
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
 #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (SP804) */
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
 #define UART0_OFFSET            0x201000 /* PL011 */
 #define MMCI0_OFFSET            0x202000 /* Legacy MMC */
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 15c5c72e46..10e9f501d2 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -343,12 +343,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_USB));
 
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
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


