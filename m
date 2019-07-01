Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41165C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C06206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezgFOIiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C06206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4Jw-0002Kb-88
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3MK-0007XT-7M
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3MG-000535-Cn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:06 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3MG-0004xA-1V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:57:04 -0400
Received: by mail-wr1-f52.google.com with SMTP id p11so4087544wro.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=50Y0/N9FaT3fyCQ4ei1ieOLigwzHJFfKxUOH5AH37Qc=;
 b=ezgFOIiWaFsiUjakxR9OQHxbQNOMixXYVZeEodLQJN5vpKqxAB8kFLM/vhEu47wliy
 sd/2c0X0Emo/JV5VP9T2PmZ7YQuf3UnHVHm/+5BtSkrD+K1P1XSPEW5J8CouPchsoY9I
 16AXu8zYA/sdYkZy63aGRi3ew2j/HknjjjljmSgKR1GJSHbEfTI8cJsHaUpU8EtjGP5Y
 AbWZg/oLBxoyJ3lsAbZz3H6Gw4OMTj29RBmmGbBvaAxJK152xQVAVF4OamauZVj6Xgll
 1wWTsCrpZf0NZgSvHyDa8VY1sKDfOdp9eWoxhPeMvWUstpMhIsFZPoa1eptkuCoioRUb
 /01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=50Y0/N9FaT3fyCQ4ei1ieOLigwzHJFfKxUOH5AH37Qc=;
 b=aUAYg0G7lOHdZNxEObSMwcCgcnh/3KT3h6/XvLRKbgF3bjnUf5miV9WpsZa1/MBBMg
 ZuVgyo2gaF4g+sWckDJLIxbQPjICewDSt3Uk9suf580+oMU774dojeSH+7eM5gGb/rx1
 PaZteTxsCA4yiPSJX+Y9H0Rs6SN+DG1HubmigjwOeS9yoM9Qmdf42nJSUSt1LewC2Tdk
 dbiBNDIQbUwlEkGEgCkxBhMAwpxUcR638YV+SINIvibqBDgXbnfEo6EklnbQ7LjQPQVC
 L65dlDRIBETgusO8EIA6lPMAHMPNXVWsUbJuJc0IULd2JKpbrmCN3TLEydSn0HROvsXM
 Trkw==
X-Gm-Message-State: APjAAAXkoata509dBd3aJQj5enlEpI1t0N1oAHwSzu0iGTqxfy//sbzj
 zLLRR5GVml53zf74nkjis3gMNGk2aIaTGQ==
X-Google-Smtp-Source: APXvYqw9xqSnzzF7WTUSd/okUTna5coC6wYiAfv4/BFwwjDMIflrb5K7K5wQMm1eunYgF+uFOd9OCQ==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr18897260wrs.14.1561999194144; 
 Mon, 01 Jul 2019 09:39:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:06 +0100
Message-Id: <20190701163943.22313-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.52
Subject: [Qemu-devel] [PULL 09/46] aspeed: add a per SoC mapping for the
 interrupt space
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

From: Cédric Le Goater <clg@kaod.org>

This will simplify the definition of new SoCs, like the AST2600 which
should use a different CPU and a different IRQ number layout.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h | 36 +++++++++++++++++++++++
 hw/arm/aspeed_soc.c         | 57 +++++++++++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 836b2ba8bf1..963abecb724 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -56,6 +56,7 @@ typedef struct AspeedSoCInfo {
     const char *fmc_typename;
     const char **spi_typename;
     int wdts_num;
+    const int *irqmap;
 } AspeedSoCInfo;
 
 typedef struct AspeedSoCClass {
@@ -68,4 +69,39 @@ typedef struct AspeedSoCClass {
 #define ASPEED_SOC_GET_CLASS(obj)                               \
     OBJECT_GET_CLASS(AspeedSoCClass, (obj), TYPE_ASPEED_SOC)
 
+enum {
+    ASPEED_IOMEM,
+    ASPEED_UART1,
+    ASPEED_UART2,
+    ASPEED_UART3,
+    ASPEED_UART4,
+    ASPEED_UART5,
+    ASPEED_VUART,
+    ASPEED_FMC,
+    ASPEED_SPI1,
+    ASPEED_SPI2,
+    ASPEED_VIC,
+    ASPEED_SDMC,
+    ASPEED_SCU,
+    ASPEED_ADC,
+    ASPEED_SRAM,
+    ASPEED_GPIO,
+    ASPEED_RTC,
+    ASPEED_TIMER1,
+    ASPEED_TIMER2,
+    ASPEED_TIMER3,
+    ASPEED_TIMER4,
+    ASPEED_TIMER5,
+    ASPEED_TIMER6,
+    ASPEED_TIMER7,
+    ASPEED_TIMER8,
+    ASPEED_WDT,
+    ASPEED_PWM,
+    ASPEED_LPC,
+    ASPEED_IBT,
+    ASPEED_I2C,
+    ASPEED_ETH1,
+    ASPEED_ETH2,
+};
+
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a2ea8c74844..de75bf04027 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -38,12 +38,42 @@
 #define ASPEED_SOC_ETH1_BASE        0x1E660000
 #define ASPEED_SOC_ETH2_BASE        0x1E680000
 
-static const int uart_irqs[] = { 9, 32, 33, 34, 10 };
-static const int timer_irqs[] = { 16, 17, 18, 35, 36, 37, 38, 39, };
+static const int aspeed_soc_ast2400_irqmap[] = {
+    [ASPEED_UART1]  = 9,
+    [ASPEED_UART2]  = 32,
+    [ASPEED_UART3]  = 33,
+    [ASPEED_UART4]  = 34,
+    [ASPEED_UART5]  = 10,
+    [ASPEED_VUART]  = 8,
+    [ASPEED_FMC]    = 19,
+    [ASPEED_SDMC]   = 0,
+    [ASPEED_SCU]    = 21,
+    [ASPEED_ADC]    = 31,
+    [ASPEED_GPIO]   = 20,
+    [ASPEED_RTC]    = 22,
+    [ASPEED_TIMER1] = 16,
+    [ASPEED_TIMER2] = 17,
+    [ASPEED_TIMER3] = 18,
+    [ASPEED_TIMER4] = 35,
+    [ASPEED_TIMER5] = 36,
+    [ASPEED_TIMER6] = 37,
+    [ASPEED_TIMER7] = 38,
+    [ASPEED_TIMER8] = 39,
+    [ASPEED_WDT]    = 27,
+    [ASPEED_PWM]    = 28,
+    [ASPEED_LPC]    = 8,
+    [ASPEED_IBT]    = 8, /* LPC */
+    [ASPEED_I2C]    = 12,
+    [ASPEED_ETH1]   = 2,
+    [ASPEED_ETH2]   = 3,
+};
 
 #define AST2400_SDRAM_BASE       0x40000000
 #define AST2500_SDRAM_BASE       0x80000000
 
+/* AST2500 uses the same IRQs as the AST2400 */
+#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
+
 static const hwaddr aspeed_soc_ast2400_spi_bases[] = { ASPEED_SOC_SPI_BASE };
 static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
 
@@ -64,6 +94,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
+        .irqmap       = aspeed_soc_ast2400_irqmap,
     }, {
         .name         = "ast2400-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
@@ -75,6 +106,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
+        .irqmap       = aspeed_soc_ast2400_irqmap,
     }, {
         .name         = "ast2400",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
@@ -86,6 +118,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
+        .irqmap       = aspeed_soc_ast2400_irqmap,
     }, {
         .name         = "ast2500-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
@@ -97,9 +130,17 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .fmc_typename = "aspeed.smc.ast2500-fmc",
         .spi_typename = aspeed_soc_ast2500_typenames,
         .wdts_num     = 3,
+        .irqmap       = aspeed_soc_ast2500_irqmap,
     },
 };
 
+static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
+}
+
 static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
@@ -216,14 +257,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_BASE);
-    for (i = 0; i < ARRAY_SIZE(timer_irqs); i++) {
-        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs[i]);
+    for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
+        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
-        qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
+        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
         serial_mm_init(get_system_memory(),
                        ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
@@ -237,7 +278,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
+                       aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
@@ -249,7 +290,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
+                       aspeed_soc_get_irq(s, ASPEED_FMC));
 
     /* SPI */
     for (i = 0; i < sc->info->spis_num; i++) {
@@ -297,7 +338,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
+                       aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
-- 
2.20.1


