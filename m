Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED3C0650E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D14216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkgm2x9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D14216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8aR-0004TL-M3
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4W9-000342-Og
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4W0-0002xe-Np
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:15 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4W0-0002sM-EH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:11:12 -0400
Received: by mail-wr1-f48.google.com with SMTP id x17so15435921wrl.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=woHhYY92L1yVEaV0N+VO3jRl6CsEGrwlmOo1GH6Xz6Y=;
 b=kkgm2x9Ow0TvGYJ3izolYt1XjvB4yciYNNDmJcdu7GqkdLQsg0L7Zg3OXtlUU9juOm
 jZ+SjcF3bzvO5rZzwFGC5FGg7P/zUKRANqorEy2e+m5g55r02CTWB+fBg4m9MsTowXDX
 9QbG74gmi6Kw2Dlnqt9exxy4/sPLlYvY8CUmMSAA9xskiMcRD3tnvqwpJNFfyvasiLom
 omXW+WNrRgmgJmlStRFKN9SchLFzN4SgDw+FE5m8YUya0EI2oWCj0FVYpiqyYZr/P55+
 DwGkUqjlSZ6rmZ172Ie5JAZywEs3hleba/pXyaABep6kWpvVgDq2pfEQnZ0SfVNMSq30
 Fu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=woHhYY92L1yVEaV0N+VO3jRl6CsEGrwlmOo1GH6Xz6Y=;
 b=tYwPI+6/PSLNFQUshkOp5Mm+Gq9TiJLJGKx9Ei3GWzzo2aH85ZlkQy47DnNXNq/3O3
 /qU9IV09i8AVWkiU9OKVEbxn1vPOd3XzOyg2bexISmm4QgN1yz9Wn0NbwH4tCtBhM28C
 3iqSt3i+i2IX2LtbjxVSqBjUfed23QXkTwR/LYy2VZbqpYIdrH0tFiA+syyRwpPl8q+3
 HZZAwxNNGDR8R9MTcO1PXHPBAS667MCNJuj6cmF1nlbFWkFHyDSxTf8yuZAD1escS+E2
 ADGk7ouderuIwh6Jes6gAKavFbmPI64oWLSX9aquT1ARIHYSM+fDIoOkbS2dzHQJqlqH
 /uTA==
X-Gm-Message-State: APjAAAX9LCCBcUGJaHlfHYc2HfWPbZyNJL4++TgriV8zxkR502nrNAE/
 1GB+2NCz320v96J3RQCE5ujkKLz4i1r/xQ==
X-Google-Smtp-Source: APXvYqymEIq/pGxSpBCl/Hf4Th/d6t9XtT4NP+zU40VyzAN7tXqew7B2W6GfP6WgVefUvw9xuoil/g==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr6164162wrq.221.1561999195154; 
 Mon, 01 Jul 2019 09:39:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:07 +0100
Message-Id: <20190701163943.22313-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.48
Subject: [Qemu-devel] [PULL 10/46] aspeed: add a per SoC mapping for the
 memory space
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
should use a slightly different address space and have a different set
of controllers.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |   4 +-
 hw/arm/aspeed.c             |   8 +--
 hw/arm/aspeed_soc.c         | 117 ++++++++++++++++++++++--------------
 3 files changed, 78 insertions(+), 51 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 963abecb724..88b901d5dfa 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -49,14 +49,13 @@ typedef struct AspeedSoCInfo {
     const char *name;
     const char *cpu_type;
     uint32_t silicon_rev;
-    hwaddr sdram_base;
     uint64_t sram_size;
     int spis_num;
-    const hwaddr *spi_bases;
     const char *fmc_typename;
     const char **spi_typename;
     int wdts_num;
     const int *irqmap;
+    const hwaddr *memmap;
 } AspeedSoCInfo;
 
 typedef struct AspeedSoCClass {
@@ -102,6 +101,7 @@ enum {
     ASPEED_I2C,
     ASPEED_ETH1,
     ASPEED_ETH2,
+    ASPEED_SDRAM,
 };
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d2ad2da24b5..c692ca1dba9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -191,8 +191,8 @@ static void aspeed_board_init(MachineState *machine,
                                         &error_abort);
 
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
-    memory_region_add_subregion(get_system_memory(), sc->info->sdram_base,
-                                &bmc->ram);
+    memory_region_add_subregion(get_system_memory(),
+                                sc->info->memmap[ASPEED_SDRAM], &bmc->ram);
     object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc->ram),
                                    &error_abort);
 
@@ -201,7 +201,7 @@ static void aspeed_board_init(MachineState *machine,
     memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
                           "max_ram", max_ram_size  - ram_size);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->sdram_base + ram_size,
+                                sc->info->memmap[ASPEED_SDRAM] + ram_size,
                                 &bmc->max_ram);
 
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
@@ -229,7 +229,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.initrd_filename = machine->initrd_filename;
     aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
     aspeed_board_binfo.ram_size = ram_size;
-    aspeed_board_binfo.loader_start = sc->info->sdram_base;
+    aspeed_board_binfo.loader_start = sc->info->memmap[ASPEED_SDRAM];
 
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index de75bf04027..1cc98b9f404 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -22,21 +22,58 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
 
-#define ASPEED_SOC_UART_5_BASE      0x00184000
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
-#define ASPEED_SOC_IOMEM_BASE       0x1E600000
-#define ASPEED_SOC_FMC_BASE         0x1E620000
-#define ASPEED_SOC_SPI_BASE         0x1E630000
-#define ASPEED_SOC_SPI2_BASE        0x1E631000
-#define ASPEED_SOC_VIC_BASE         0x1E6C0000
-#define ASPEED_SOC_SDMC_BASE        0x1E6E0000
-#define ASPEED_SOC_SCU_BASE         0x1E6E2000
-#define ASPEED_SOC_SRAM_BASE        0x1E720000
-#define ASPEED_SOC_TIMER_BASE       0x1E782000
-#define ASPEED_SOC_WDT_BASE         0x1E785000
-#define ASPEED_SOC_I2C_BASE         0x1E78A000
-#define ASPEED_SOC_ETH1_BASE        0x1E660000
-#define ASPEED_SOC_ETH2_BASE        0x1E680000
+
+static const hwaddr aspeed_soc_ast2400_memmap[] = {
+    [ASPEED_IOMEM]  = 0x1E600000,
+    [ASPEED_FMC]    = 0x1E620000,
+    [ASPEED_SPI1]   = 0x1E630000,
+    [ASPEED_VIC]    = 0x1E6C0000,
+    [ASPEED_SDMC]   = 0x1E6E0000,
+    [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_ADC]    = 0x1E6E9000,
+    [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_GPIO]   = 0x1E780000,
+    [ASPEED_RTC]    = 0x1E781000,
+    [ASPEED_TIMER1] = 0x1E782000,
+    [ASPEED_WDT]    = 0x1E785000,
+    [ASPEED_PWM]    = 0x1E786000,
+    [ASPEED_LPC]    = 0x1E789000,
+    [ASPEED_IBT]    = 0x1E789140,
+    [ASPEED_I2C]    = 0x1E78A000,
+    [ASPEED_ETH1]   = 0x1E660000,
+    [ASPEED_ETH2]   = 0x1E680000,
+    [ASPEED_UART1]  = 0x1E783000,
+    [ASPEED_UART5]  = 0x1E784000,
+    [ASPEED_VUART]  = 0x1E787000,
+    [ASPEED_SDRAM]  = 0x40000000,
+};
+
+static const hwaddr aspeed_soc_ast2500_memmap[] = {
+    [ASPEED_IOMEM]  = 0x1E600000,
+    [ASPEED_FMC]    = 0x1E620000,
+    [ASPEED_SPI1]   = 0x1E630000,
+    [ASPEED_SPI2]   = 0x1E631000,
+    [ASPEED_VIC]    = 0x1E6C0000,
+    [ASPEED_SDMC]   = 0x1E6E0000,
+    [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_ADC]    = 0x1E6E9000,
+    [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_GPIO]   = 0x1E780000,
+    [ASPEED_RTC]    = 0x1E781000,
+    [ASPEED_TIMER1] = 0x1E782000,
+    [ASPEED_WDT]    = 0x1E785000,
+    [ASPEED_PWM]    = 0x1E786000,
+    [ASPEED_LPC]    = 0x1E789000,
+    [ASPEED_IBT]    = 0x1E789140,
+    [ASPEED_I2C]    = 0x1E78A000,
+    [ASPEED_ETH1]   = 0x1E660000,
+    [ASPEED_ETH2]   = 0x1E680000,
+    [ASPEED_UART1]  = 0x1E783000,
+    [ASPEED_UART5]  = 0x1E784000,
+    [ASPEED_VUART]  = 0x1E787000,
+    [ASPEED_SDRAM]  = 0x80000000,
+};
 
 static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_UART1]  = 9,
@@ -68,17 +105,9 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_ETH2]   = 3,
 };
 
-#define AST2400_SDRAM_BASE       0x40000000
-#define AST2500_SDRAM_BASE       0x80000000
-
-/* AST2500 uses the same IRQs as the AST2400 */
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
 
-static const hwaddr aspeed_soc_ast2400_spi_bases[] = { ASPEED_SOC_SPI_BASE };
 static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
-
-static const hwaddr aspeed_soc_ast2500_spi_bases[] = { ASPEED_SOC_SPI_BASE,
-                                                       ASPEED_SOC_SPI2_BASE};
 static const char *aspeed_soc_ast2500_typenames[] = {
     "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
 
@@ -87,50 +116,46 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .name         = "ast2400-a0",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  = AST2400_A0_SILICON_REV,
-        .sdram_base   = AST2400_SDRAM_BASE,
         .sram_size    = 0x8000,
         .spis_num     = 1,
-        .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
+        .memmap       = aspeed_soc_ast2400_memmap,
     }, {
         .name         = "ast2400-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  = AST2400_A1_SILICON_REV,
-        .sdram_base   = AST2400_SDRAM_BASE,
         .sram_size    = 0x8000,
         .spis_num     = 1,
-        .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
+        .memmap       = aspeed_soc_ast2400_memmap,
     }, {
         .name         = "ast2400",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  = AST2400_A0_SILICON_REV,
-        .sdram_base   = AST2400_SDRAM_BASE,
         .sram_size    = 0x8000,
         .spis_num     = 1,
-        .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
+        .memmap       = aspeed_soc_ast2400_memmap,
     }, {
         .name         = "ast2500-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
         .silicon_rev  = AST2500_A1_SILICON_REV,
-        .sdram_base   = AST2500_SDRAM_BASE,
         .sram_size    = 0x9000,
         .spis_num     = 2,
-        .spi_bases    = aspeed_soc_ast2500_spi_bases,
         .fmc_typename = "aspeed.smc.ast2500-fmc",
         .spi_typename = aspeed_soc_ast2500_typenames,
         .wdts_num     = 3,
         .irqmap       = aspeed_soc_ast2500_irqmap,
+        .memmap       = aspeed_soc_ast2500_memmap,
     },
 };
 
@@ -210,8 +235,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL, *local_err = NULL;
 
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io",
-                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_SIZE);
+    create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED_IOMEM],
+                                ASPEED_SOC_IOMEM_SIZE);
 
     /* CPU */
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
@@ -227,8 +252,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BASE,
-                                &s->sram);
+    memory_region_add_subregion(get_system_memory(),
+                                sc->info->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
     object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
@@ -236,7 +261,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_SCU]);
 
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
@@ -244,7 +269,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, ASPEED_SOC_VIC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
@@ -256,7 +281,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
+                    sc->info->memmap[ASPEED_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
@@ -265,8 +291,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
         qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(),
-                       ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
+        serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 
@@ -276,7 +301,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->info->memmap[ASPEED_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
@@ -286,7 +311,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, ASPEED_SOC_FMC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->info->memmap[ASPEED_FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
@@ -302,7 +327,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, sc->info->spi_bases[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                        sc->info->memmap[ASPEED_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -313,7 +339,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->info->memmap[ASPEED_SDMC]);
 
     /* Watch dog */
     for (i = 0; i < sc->info->wdts_num; i++) {
@@ -323,7 +349,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        ASPEED_SOC_WDT_BASE + i * 0x20);
+                        sc->info->memmap[ASPEED_WDT] + i * 0x20);
     }
 
     /* Net */
@@ -336,7 +362,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0,
+                    sc->info->memmap[ASPEED_ETH1]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
-- 
2.20.1


