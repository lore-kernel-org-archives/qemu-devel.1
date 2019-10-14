Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46CC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993052067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8+kxIBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993052067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Ys-0003qP-7q
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2r1-0005ha-4k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qz-0008KE-Np
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qz-0008Jp-Ev
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so20334709wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yMFC1AVz4MTJb9Gld3BvgFGtjrRY1f2tWSZwDZoRnAE=;
 b=x8+kxIBNxK0Eaj4zQI4+85lDSeJVeH3/5I6QaCTKXqgu0RY0OVoyvT0ZmTexGvlZq2
 jOD2qjCHhzCpp7zCDpjMLejEldS7pdXKOkrG2ykmu5VJ6yfwVqhDxNB+ZbsNkVWd9eOa
 sbm1kL/1Jd2CAhYl3lCIFG48eupANJU52YCo3oFYlLE0oZ2KMMwNTqUBsiyG0dc6sJSa
 vwWqCDdoAvDUYhHtnedNzNLjvjGbFv5MfaW1YyOLdqtM/343GxdlA0QvUDaXg6xhZbdT
 n/PRK4AHF0xLgo2IwDUjMpY0fYASKGyz/tOiHnwzR+MlLeHIDJymT6RPgEycM89X3qxD
 eMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yMFC1AVz4MTJb9Gld3BvgFGtjrRY1f2tWSZwDZoRnAE=;
 b=bw0j6gG7mOtb13njNiorwzL2blXX3TSJ9NxMRtwAy8r1Dqh4YMYfURpaheNPlcflAa
 yeUQTCR9Uoqqlv19UZQndyzz3Agm5v3hDjk7YDkXBdc2l3DjS3TuIqtHT3a9HA01UEqR
 d8xJTSI16F8qdxSwC2gTjgEIO6EkdrK8ehx5ymqBFeXK24o7Y5pkD3zhj9VhiXzXjHp0
 XexhSy/mvG8yHK7QHU8NTDmHbvG5oruIJLaVmFDMN02v5DxJExSggLHRk4uMPRPn43pC
 CRvKv30GRAJrwq+frE5UUdqCCmRk86RvKV3cBuXI2MSm3ArYMZW7GDZ52NJkAiRuJDbA
 rViQ==
X-Gm-Message-State: APjAAAU9+4fnEMTF4qqfAeUtsYReoEEOuTKZfya/qVGJ3tn53x+/3HjL
 0d5wAkFfIv7h5dreEOFmo0AvrVb5kGXkfA==
X-Google-Smtp-Source: APXvYqzzha50TJ6p2zdp67RNyRCTZFixJHWa/fFwPqUgYZIAb3fYfFfy+amwBIyRCBuXNfSqWoLabA==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr22585106wrv.8.1571069148212; 
 Mon, 14 Oct 2019 09:05:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/68] hw/arm/bcm2835: Rename some definitions
Date: Mon, 14 Oct 2019 17:04:02 +0100
Message-Id: <20191014160404.19553-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The UART1 is part of the AUX peripheral,
the PCM_CLOCK (yet unimplemented) is part of the CPRMAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190926173428.10713-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspi_platform.h | 16 +++++++---------
 hw/arm/bcm2835_peripherals.c    |  7 ++++---
 hw/arm/bcm2836.c                |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 10083d33df1..66969fac5d2 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -25,8 +25,7 @@
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
-#define MCORE_OFFSET            0x0000   /* Fake frame buffer device
-                                          * (the multicore sync block) */
+#define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define IC0_OFFSET              0x2000
 #define ST_OFFSET               0x3000   /* System Timer */
 #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
@@ -37,9 +36,8 @@
 #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
 #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
                                                       * Doorbells & Mailboxes */
-#define PM_OFFSET               0x100000 /* Power Management, Reset controller
-                                          * and Watchdog registers */
-#define PCM_CLOCK_OFFSET        0x101098
+#define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
+#define CM_OFFSET               0x101000 /* Clock Management */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
@@ -47,11 +45,11 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
-#define UART1_OFFSET            0x215000
-#define EMMC_OFFSET             0x300000
+#define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
+#define EMMC1_OFFSET            0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
-#define USB_OFFSET              0x980000 /* DTC_OTG USB controller */
+#define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
 /* GPU interrupts */
@@ -112,7 +110,7 @@
 #define INTERRUPT_SPI                  54
 #define INTERRUPT_I2SPCM               55
 #define INTERRUPT_SDIO                 56
-#define INTERRUPT_UART                 57
+#define INTERRUPT_UART0                57
 #define INTERRUPT_SLIMBUS              58
 #define INTERRUPT_VEC                  59
 #define INTERRUPT_CPG                  60
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8984e2e91f8..1bd2ff41d52 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -165,7 +165,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart0), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart0), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_UART));
+                               INTERRUPT_UART0));
+
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
@@ -175,7 +176,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, UART1_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, AUX_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->aux), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->aux), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
@@ -268,7 +269,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, EMMC_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 493a913f892..723aef6bf51 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-                                BCM2836_PERI_BASE + MCORE_OFFSET,
+                                BCM2836_PERI_BASE + MSYNC_OFFSET,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.20.1


