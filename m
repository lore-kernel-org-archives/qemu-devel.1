Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F40C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E7B20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcdrDkSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E7B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3OO-0007kq-OS
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qV-0004ot-Cq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qT-0007x6-7g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:56006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qT-0007w2-04
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id a6so17834570wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Gbj/1vupet4wMXabBgwl0Oz2l4ch353ql/J//P2oXMo=;
 b=hcdrDkSHEXLli4QyRDgqi+ZVv20MRnI9VBs2aF710nv7lVdL3U3xj98o0qxAnq5KKu
 WsmHFBkfPxEQpkNwtVcMetsoObNdUuJV068hpLq8iM2snhk/NnGrNfMeIghsGgRhdYg+
 ZEEPeo6aLQCZVyRKMpuqgEvKyYKBQoKTxStwuPJU8U+ZzhNTtSb1wnap1SvzZ1h7Niz0
 UkMh0eX9Ec8YRgihXMDby0sYtI0lp6LCts3OVqvXWkEOrhdeEAoxrkYtxCCmLshhlOJ3
 zVEvqNAEKa3jsu1gOnQAQfhKUHXmSVVpoV537+9N4zH1uwKbxiT8LbhEIyYzxhOR9+k6
 FERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gbj/1vupet4wMXabBgwl0Oz2l4ch353ql/J//P2oXMo=;
 b=E26xmt7pTqHUQ+ETAJ6jNDkUlwhtr8EPRVJ4y8XdXQtNrH+JUlodhfmxcUo7/NRqp5
 9ghdeLen03ZfKEiSa0WiorkK+4uzMvsZvgNjmjkVhf21f5gZYOZD+nRpNUR3osg3Tjvd
 q1JOEpl9eHLAGkQDqiH7USu0qNvM/xAiGrdGiCk1HrRtln/BTJp3RXfvEA3O6hakka/g
 MFuEYImP8QENrF5Hjb+a5xLBRX9mks8TVXN1MytpmiK5e/JIfxwGuEN1sOlLqNw6xEQT
 ehprRqHl9JXQJI7HkcxYDmsdbWMVHocAFFJ3PQuEWlGiKpDB6Um1IqMKMbhquhWQ5FV9
 evQw==
X-Gm-Message-State: APjAAAVHBPjpNE3ZoZgOEM1c9+IXc02h5bjrKkEIewseotZqt7k/U7R1
 xbyNrE7JGVQqGewh2CogJHL33aB3PRM4AQ==
X-Google-Smtp-Source: APXvYqwM5XYRPOSO+B1sengcx4KK+/m49nNPw+GZXsq8T5P6ygHLLpwGxDRYkZOzbFff22XGV0dIjg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr16479939wmb.89.1571069115326; 
 Mon, 14 Oct 2019 09:05:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/68] hw/sd/aspeed_sdhci: New device
Date: Mon, 14 Oct 2019 17:03:37 +0100
Message-Id: <20191014160404.19553-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Eddie James <eajames@linux.ibm.com>

The Aspeed SOCs have two SD/MMC controllers. Add a device that
encapsulates both of these controllers and models the Aspeed-specific
registers and behavior.

Tested by reading from mmcblk0 in Linux:
qemu-system-arm -machine romulus-bmc -nographic \
 -drive file=flash-romulus,format=raw,if=mtd \
 -device sd-card,drive=sd0 -drive file=_tmp/kernel,format=raw,if=sd,id=sd0

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-3-clg@kaod.org
[clg: - changed the controller MMIO window size to 0x1000
      - moved the MMIO mapping of the SDHCI slots at the SoC level
      - merged code to add SD drives on the SD buses at the machine level ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/Makefile.objs          |   1 +
 include/hw/arm/aspeed_soc.h  |   3 +
 include/hw/sd/aspeed_sdhci.h |  34 ++++++
 hw/arm/aspeed.c              |  15 ++-
 hw/arm/aspeed_soc.c          |  23 ++++
 hw/sd/aspeed_sdhci.c         | 198 +++++++++++++++++++++++++++++++++++
 6 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/sd/aspeed_sdhci.h
 create mode 100644 hw/sd/aspeed_sdhci.c

diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 06657279d18..a884c238dfb 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 obj-$(CONFIG_OMAP) += omap_mmc.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
 obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
+obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ab5052b12cb..ba5bbb53e1a 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -24,6 +24,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/sd/aspeed_sdhci.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -50,6 +51,7 @@ typedef struct AspeedSoCState {
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
+    AspeedSDHCIState sdhci;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -93,6 +95,7 @@ enum {
     ASPEED_SCU,
     ASPEED_ADC,
     ASPEED_SRAM,
+    ASPEED_SDHCI,
     ASPEED_GPIO,
     ASPEED_RTC,
     ASPEED_TIMER1,
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
new file mode 100644
index 00000000000..dfdab437902
--- /dev/null
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -0,0 +1,34 @@
+/*
+ * Aspeed SD Host Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_SDHCI_H
+#define ASPEED_SDHCI_H
+
+#include "hw/sd/sdhci.h"
+
+#define TYPE_ASPEED_SDHCI "aspeed.sdhci"
+#define ASPEED_SDHCI(obj) OBJECT_CHECK(AspeedSDHCIState, (obj), \
+                                       TYPE_ASPEED_SDHCI)
+
+#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
+#define ASPEED_SDHCI_NUM_SLOTS    2
+#define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32_t))
+#define ASPEED_SDHCI_REG_SIZE     0x100
+
+typedef struct AspeedSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
+} AspeedSDHCIState;
+
+#endif /* ASPEED_SDHCI_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index aa72be309da..30e28048426 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -170,6 +170,7 @@ static void aspeed_board_init(MachineState *machine,
     AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
     ram_addr_t max_ram_size;
+    int i;
 
     bmc = g_new0(AspeedBoardState, 1);
 
@@ -252,6 +253,19 @@ static void aspeed_board_init(MachineState *machine,
         cfg->i2c_init(bmc);
     }
 
+    for (i = 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
+        SDHCIState *sdhci = &bmc->soc.sdhci.slots[i];
+        DriveInfo *dinfo = drive_get_next(IF_SD);
+        BlockBackend *blk;
+        DeviceState *card;
+
+        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+        card = qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                           TYPE_SD_CARD);
+        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
@@ -373,7 +387,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = board->desc;
     mc->init = aspeed_machine_init;
     mc->max_cpus = ASPEED_CPUS_NUM;
-    mc->no_sdcard = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index cf1d0cf921b..c3821a56273 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -36,6 +36,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
     [ASPEED_RTC]    = 0x1E781000,
     [ASPEED_TIMER1] = 0x1E782000,
@@ -63,6 +64,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
     [ASPEED_RTC]    = 0x1E781000,
     [ASPEED_TIMER1] = 0x1E782000,
@@ -108,6 +110,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
     [ASPEED_XDMA]   = 6,
+    [ASPEED_SDHCI]  = 26,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -230,6 +233,15 @@ static void aspeed_soc_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
                           typename);
+
+    sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
+                          TYPE_ASPEED_SDHCI);
+
+    /* Init sd card slot class here so that they're under the correct parent */
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
+                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
+    }
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -419,6 +431,17 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
+
+    /* SDHCI */
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
+                    sc->info->memmap[ASPEED_SDHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
+                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
new file mode 100644
index 00000000000..cff3eb7dd21
--- /dev/null
+++ b/hw/sd/aspeed_sdhci.c
@@ -0,0 +1,198 @@
+/*
+ * Aspeed SD Host Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/sd/aspeed_sdhci.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+
+#define ASPEED_SDHCI_INFO            0x00
+#define  ASPEED_SDHCI_INFO_RESET     0x00030000
+#define ASPEED_SDHCI_DEBOUNCE        0x04
+#define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
+#define ASPEED_SDHCI_BUS             0x08
+#define ASPEED_SDHCI_SDIO_140        0x10
+#define ASPEED_SDHCI_SDIO_148        0x18
+#define ASPEED_SDHCI_SDIO_240        0x20
+#define ASPEED_SDHCI_SDIO_248        0x28
+#define ASPEED_SDHCI_WP_POL          0xec
+#define ASPEED_SDHCI_CARD_DET        0xf0
+#define ASPEED_SDHCI_IRQ_STAT        0xfc
+
+#define TO_REG(addr) ((addr) / sizeof(uint32_t))
+
+static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    AspeedSDHCIState *sdhci = opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        val = (uint32_t)sdhci->slots[0].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        val = (uint32_t)sdhci->slots[0].maxcurr;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        val = (uint32_t)sdhci->slots[1].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        val = (uint32_t)sdhci->slots[1].maxcurr;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            val = sdhci->regs[TO_REG(addr)];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+
+    return (uint64_t)val;
+}
+
+static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned int size)
+{
+    AspeedSDHCIState *sdhci = opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            sdhci->regs[TO_REG(addr)] = (uint32_t)val;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+}
+
+static const MemoryRegionOps aspeed_sdhci_ops = {
+    .read = aspeed_sdhci_read,
+    .write = aspeed_sdhci_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
+{
+    AspeedSDHCIState *sdhci = opaque;
+
+    if (level) {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |= BIT(n);
+
+        qemu_irq_raise(sdhci->irq);
+    } else {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &= ~BIT(n);
+
+        qemu_irq_lower(sdhci->irq);
+    }
+}
+
+static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    Error *err = NULL;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
+
+    /* Create input irqs for the slots */
+    qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
+                                        sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
+
+    sysbus_init_irq(sbd, &sdhci->irq);
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
+                          sdhci, TYPE_ASPEED_SDHCI, 0x1000);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+
+    for (int i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
+        SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
+
+        object_property_set_int(sdhci_slot, 2, "sd-spec-version", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_uint(sdhci_slot, ASPEED_SDHCI_CAPABILITIES,
+                                 "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(sdhci_slot, true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), i));
+        memory_region_add_subregion(&sdhci->iomem, (i + 1) * 0x100,
+                                    &sdhci->slots[i].iomem);
+    }
+}
+
+static void aspeed_sdhci_reset(DeviceState *dev)
+{
+    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
+
+    memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
+    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
+    sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
+}
+
+static const VMStateDescription vmstate_aspeed_sdhci = {
+    .name = TYPE_ASPEED_SDHCI,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(classp);
+
+    dc->realize = aspeed_sdhci_realize;
+    dc->reset = aspeed_sdhci_reset;
+    dc->vmsd = &vmstate_aspeed_sdhci;
+}
+
+static TypeInfo aspeed_sdhci_info = {
+    .name          = TYPE_ASPEED_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedSDHCIState),
+    .class_init    = aspeed_sdhci_class_init,
+};
+
+static void aspeed_sdhci_register_types(void)
+{
+    type_register_static(&aspeed_sdhci_info);
+}
+
+type_init(aspeed_sdhci_register_types)
-- 
2.20.1


