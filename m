Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FABC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257F420757
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1NUGJ5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOQA-0005z7-5Z
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPg-0001Xb-7X
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPY-0004YJ-J1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id w23so1062020wmi.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DMqbuPmRq3vH2EmFgZ5T1FKzpRPeInfoK01Sg/mJVv8=;
 b=c1NUGJ5RViPIfHrq8RxSRFPd0lxpR8kKpUZT/gKV4ZQw92irVdkU4YdYOQlv9T/TYQ
 MKwioCLwCyZN2aBjhpefnZAJvQCN28fCL9sqyopBRhsGza3NeGPT5Gg5Hi2vlmQPfWv4
 OyQXUH676D0nox3Ma7LV46fW/rsSDsoduEqv8hlDGDikSxsDQZ8q7BrkzMB8K2FV/FEf
 HPzlGIxTQa7BnTYbNIAGyH6V/5yRgqFThNNVHva6JjDDbf37gMdN3DRkmMkNkK7a8Gfr
 1cN2DxO1F5lk/PgRkeSuNtPEZLdFzULlN4aeHU/gOnSGE064M/YO4kijnOQHZht6tbY8
 p8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DMqbuPmRq3vH2EmFgZ5T1FKzpRPeInfoK01Sg/mJVv8=;
 b=dGL+kiBBp/AHzIXOdu+zZjDiLliUWmRM6qoDbCaVMWxbE1JiN8Dp+CyY1hnH2G3JwL
 ZdIBvF1ijplQYsnQ/DZTAvMWSv7COGcy483m/fGbhljNZIjEIYhY0bR1aUY/RkedEVhj
 3Fxufe9IoFLU5sUHBqs/EOoACQSq5Qp7H7k8qYOIa8BD120a+csQoQAMTldlekcdMtl2
 MsUtDmAHehKwKqt5A3uxX4ieWIJjWsH/lOHglofiQQ2MohyKkhOgR6kfoNY1xUkIm46V
 9hm/GHif10M/GS7WDr4jqQEVNoN/czFRqM2vgGk46sd6EmENupnH8pI55qzOYOY9pKQf
 4gxA==
X-Gm-Message-State: AOAM530cRQZf5/9nS72MjusN50Va6Jv/mO7jgrHlj8jc7FZ32f6UuMRo
 wGiyvRXQqnHPee/PPSqUFslWxgixLr6nOQ==
X-Google-Smtp-Source: ABdhPJyhtbaPmWGyW2rP+9CZeYaF6RoFgBhb1M8NiwWAQQSR5bQsoSpcTATDHedXtKKYzSqc1MeUkg==
X-Received: by 2002:a05:600c:cb:: with SMTP id
 u11mr2202056wmm.112.1603799104991; 
 Tue, 27 Oct 2020 04:45:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/48] hw/gpio: Add GPIO model for Nuvoton NPCM7xx
Date: Tue, 27 Oct 2020 11:44:09 +0000
Message-Id: <20201027114438.17662-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

The NPCM7xx chips have multiple GPIO controllers that are mostly
identical except for some minor differences like the reset values of
some registers. Each controller controls up to 32 pins.

Each individual pin is modeled as a pair of unnamed GPIOs -- one for
emitting the actual pin state, and one for driving the pin externally.
Like the nRF51 GPIO controller, a gpio level may be negative, which
means the pin is not driven, or floating.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst     |   2 +-
 include/hw/arm/npcm7xx.h        |   2 +
 include/hw/gpio/npcm7xx_gpio.h  |  55 +++++
 hw/arm/npcm7xx.c                |  80 ++++++
 hw/gpio/npcm7xx_gpio.c          | 424 ++++++++++++++++++++++++++++++++
 tests/qtest/npcm7xx_gpio-test.c | 385 +++++++++++++++++++++++++++++
 hw/gpio/meson.build             |   1 +
 hw/gpio/trace-events            |   7 +
 tests/qtest/meson.build         |   3 +-
 9 files changed, 957 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/gpio/npcm7xx_gpio.h
 create mode 100644 hw/gpio/npcm7xx_gpio.c
 create mode 100644 tests/qtest/npcm7xx_gpio-test.c

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 99fc61c740c..b00d405d52e 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -40,11 +40,11 @@ Supported devices
  * Flash Interface Unit (FIU; no protection features)
  * Random Number Generator (RNG)
  * USB host (USBH)
+ * GPIO controller
 
 Missing devices
 ---------------
 
- * GPIO controller
  * LPC/eSPI host-to-BMC interface, including
 
    * Keyboard and mouse controller interface (KBCI)
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index aeee1beaaa4..5469247e389 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -18,6 +18,7 @@
 
 #include "hw/boards.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
@@ -79,6 +80,7 @@ typedef struct NPCM7xxState {
     NPCM7xxOTPState     fuse_array;
     NPCM7xxMCState      mc;
     NPCM7xxRNGState     rng;
+    NPCM7xxGPIOState    gpio[8];
     EHCISysBusState     ehci;
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
diff --git a/include/hw/gpio/npcm7xx_gpio.h b/include/hw/gpio/npcm7xx_gpio.h
new file mode 100644
index 00000000000..b1d771bd776
--- /dev/null
+++ b/include/hw/gpio/npcm7xx_gpio.h
@@ -0,0 +1,55 @@
+/*
+ * Nuvoton NPCM7xx General Purpose Input / Output (GPIO)
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM7XX_GPIO_H
+#define NPCM7XX_GPIO_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/* Number of pins managed by each controller. */
+#define NPCM7XX_GPIO_NR_PINS (32)
+
+/*
+ * Number of registers in our device state structure. Don't change this without
+ * incrementing the version_id in the vmstate.
+ */
+#define NPCM7XX_GPIO_NR_REGS (0x80 / sizeof(uint32_t))
+
+typedef struct NPCM7xxGPIOState {
+    SysBusDevice parent;
+
+    /* Properties to be defined by the SoC */
+    uint32_t reset_pu;
+    uint32_t reset_pd;
+    uint32_t reset_osrc;
+    uint32_t reset_odsc;
+
+    MemoryRegion mmio;
+
+    qemu_irq irq;
+    qemu_irq output[NPCM7XX_GPIO_NR_PINS];
+
+    uint32_t pin_level;
+    uint32_t ext_level;
+    uint32_t ext_driven;
+
+    uint32_t regs[NPCM7XX_GPIO_NR_REGS];
+} NPCM7xxGPIOState;
+
+#define TYPE_NPCM7XX_GPIO "npcm7xx-gpio"
+#define NPCM7XX_GPIO(obj) \
+    OBJECT_CHECK(NPCM7xxGPIOState, (obj), TYPE_NPCM7XX_GPIO)
+
+#endif /* NPCM7XX_GPIO_H */
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c1d122576b7..47e2b6fc400 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -96,6 +96,14 @@ enum NPCM7xxInterrupt {
     NPCM7XX_WDG2_IRQ,                   /* Timer Module 2 Watchdog */
     NPCM7XX_EHCI_IRQ            = 61,
     NPCM7XX_OHCI_IRQ            = 62,
+    NPCM7XX_GPIO0_IRQ           = 116,
+    NPCM7XX_GPIO1_IRQ,
+    NPCM7XX_GPIO2_IRQ,
+    NPCM7XX_GPIO3_IRQ,
+    NPCM7XX_GPIO4_IRQ,
+    NPCM7XX_GPIO5_IRQ,
+    NPCM7XX_GPIO6_IRQ,
+    NPCM7XX_GPIO7_IRQ,
 };
 
 /* Total number of GIC interrupts, including internal Cortex-A9 interrupts. */
@@ -130,6 +138,55 @@ static const hwaddr npcm7xx_fiu3_flash_addr[] = {
     0xb8000000, /* CS3 */
 };
 
+static const struct {
+    hwaddr regs_addr;
+    uint32_t unconnected_pins;
+    uint32_t reset_pu;
+    uint32_t reset_pd;
+    uint32_t reset_osrc;
+    uint32_t reset_odsc;
+} npcm7xx_gpio[] = {
+    {
+        .regs_addr = 0xf0010000,
+        .reset_pu = 0xff03ffff,
+        .reset_pd = 0x00fc0000,
+    }, {
+        .regs_addr = 0xf0011000,
+        .unconnected_pins = 0x0000001e,
+        .reset_pu = 0xfefffe07,
+        .reset_pd = 0x010001e0,
+    }, {
+        .regs_addr = 0xf0012000,
+        .reset_pu = 0x780fffff,
+        .reset_pd = 0x07f00000,
+        .reset_odsc = 0x00700000,
+    }, {
+        .regs_addr = 0xf0013000,
+        .reset_pu = 0x00fc0000,
+        .reset_pd = 0xff000000,
+    }, {
+        .regs_addr = 0xf0014000,
+        .reset_pu = 0xffffffff,
+    }, {
+        .regs_addr = 0xf0015000,
+        .reset_pu = 0xbf83f801,
+        .reset_pd = 0x007c0000,
+        .reset_osrc = 0x000000f1,
+        .reset_odsc = 0x3f9f80f1,
+    }, {
+        .regs_addr = 0xf0016000,
+        .reset_pu = 0xfc00f801,
+        .reset_pd = 0x000007fe,
+        .reset_odsc = 0x00000800,
+    }, {
+        .regs_addr = 0xf0017000,
+        .unconnected_pins = 0xffffff00,
+        .reset_pu = 0x0000007f,
+        .reset_osrc = 0x0000007f,
+        .reset_odsc = 0x0000007f,
+    },
+};
+
 static const struct {
     const char *name;
     hwaddr regs_addr;
@@ -269,6 +326,10 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
     }
 
+    for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_NPCM7XX_GPIO);
+    }
+
     object_initialize_child(obj, "ehci", &s->ehci, TYPE_NPCM7XX_EHCI);
     object_initialize_child(obj, "ohci", &s->ohci, TYPE_SYSBUS_OHCI);
 
@@ -389,6 +450,25 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->rng), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rng), 0, NPCM7XX_RNG_BA);
 
+    /* GPIO modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_gpio) != ARRAY_SIZE(s->gpio));
+    for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
+        Object *obj = OBJECT(&s->gpio[i]);
+
+        object_property_set_uint(obj, "reset-pullup",
+                                 npcm7xx_gpio[i].reset_pu, &error_abort);
+        object_property_set_uint(obj, "reset-pulldown",
+                                 npcm7xx_gpio[i].reset_pd, &error_abort);
+        object_property_set_uint(obj, "reset-osrc",
+                                 npcm7xx_gpio[i].reset_osrc, &error_abort);
+        object_property_set_uint(obj, "reset-odsc",
+                                 npcm7xx_gpio[i].reset_odsc, &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm7xx_gpio[i].regs_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+                           npcm7xx_irq(s, NPCM7XX_GPIO0_IRQ + i));
+    }
+
     /* USB Host */
     object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,
                              &error_abort);
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
new file mode 100644
index 00000000000..3376901ab13
--- /dev/null
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -0,0 +1,424 @@
+/*
+ * Nuvoton NPCM7xx General Purpose Input / Output (GPIO)
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/gpio/npcm7xx_gpio.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+/* 32-bit register indices. */
+enum NPCM7xxGPIORegister {
+    NPCM7XX_GPIO_TLOCK1,
+    NPCM7XX_GPIO_DIN,
+    NPCM7XX_GPIO_POL,
+    NPCM7XX_GPIO_DOUT,
+    NPCM7XX_GPIO_OE,
+    NPCM7XX_GPIO_OTYP,
+    NPCM7XX_GPIO_MP,
+    NPCM7XX_GPIO_PU,
+    NPCM7XX_GPIO_PD,
+    NPCM7XX_GPIO_DBNC,
+    NPCM7XX_GPIO_EVTYP,
+    NPCM7XX_GPIO_EVBE,
+    NPCM7XX_GPIO_OBL0,
+    NPCM7XX_GPIO_OBL1,
+    NPCM7XX_GPIO_OBL2,
+    NPCM7XX_GPIO_OBL3,
+    NPCM7XX_GPIO_EVEN,
+    NPCM7XX_GPIO_EVENS,
+    NPCM7XX_GPIO_EVENC,
+    NPCM7XX_GPIO_EVST,
+    NPCM7XX_GPIO_SPLCK,
+    NPCM7XX_GPIO_MPLCK,
+    NPCM7XX_GPIO_IEM,
+    NPCM7XX_GPIO_OSRC,
+    NPCM7XX_GPIO_ODSC,
+    NPCM7XX_GPIO_DOS = 0x68 / sizeof(uint32_t),
+    NPCM7XX_GPIO_DOC,
+    NPCM7XX_GPIO_OES,
+    NPCM7XX_GPIO_OEC,
+    NPCM7XX_GPIO_TLOCK2 = 0x7c / sizeof(uint32_t),
+    NPCM7XX_GPIO_REGS_END,
+};
+
+#define NPCM7XX_GPIO_REGS_SIZE (4 * KiB)
+
+#define NPCM7XX_GPIO_LOCK_MAGIC1 (0xc0defa73)
+#define NPCM7XX_GPIO_LOCK_MAGIC2 (0xc0de1248)
+
+static void npcm7xx_gpio_update_events(NPCM7xxGPIOState *s, uint32_t din_diff)
+{
+    uint32_t din_new = s->regs[NPCM7XX_GPIO_DIN];
+
+    /* Trigger on high level */
+    s->regs[NPCM7XX_GPIO_EVST] |= din_new & ~s->regs[NPCM7XX_GPIO_EVTYP];
+    /* Trigger on both edges */
+    s->regs[NPCM7XX_GPIO_EVST] |= (din_diff & s->regs[NPCM7XX_GPIO_EVTYP]
+                                   & s->regs[NPCM7XX_GPIO_EVBE]);
+    /* Trigger on rising edge */
+    s->regs[NPCM7XX_GPIO_EVST] |= (din_diff & din_new
+                                   & s->regs[NPCM7XX_GPIO_EVTYP]);
+
+    trace_npcm7xx_gpio_update_events(DEVICE(s)->canonical_path,
+                                     s->regs[NPCM7XX_GPIO_EVST],
+                                     s->regs[NPCM7XX_GPIO_EVEN]);
+    qemu_set_irq(s->irq, !!(s->regs[NPCM7XX_GPIO_EVST]
+                            & s->regs[NPCM7XX_GPIO_EVEN]));
+}
+
+static void npcm7xx_gpio_update_pins(NPCM7xxGPIOState *s, uint32_t diff)
+{
+    uint32_t drive_en;
+    uint32_t drive_lvl;
+    uint32_t not_driven;
+    uint32_t undefined;
+    uint32_t pin_diff;
+    uint32_t din_old;
+
+    /* Calculate level of each pin driven by GPIO controller. */
+    drive_lvl = s->regs[NPCM7XX_GPIO_DOUT] ^ s->regs[NPCM7XX_GPIO_POL];
+    /* If OTYP=1, only drive low (open drain) */
+    drive_en = s->regs[NPCM7XX_GPIO_OE] & ~(s->regs[NPCM7XX_GPIO_OTYP]
+                                            & drive_lvl);
+    /*
+     * If a pin is driven to opposite levels by the GPIO controller and the
+     * external driver, the result is undefined.
+     */
+    undefined = drive_en & s->ext_driven & (drive_lvl ^ s->ext_level);
+    if (undefined) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: pins have multiple drivers: 0x%" PRIx32 "\n",
+                      DEVICE(s)->canonical_path, undefined);
+    }
+
+    not_driven = ~(drive_en | s->ext_driven);
+    pin_diff = s->pin_level;
+
+    /* Set pins to externally driven level. */
+    s->pin_level = s->ext_level & s->ext_driven;
+    /* Set internally driven pins, ignoring any conflicts. */
+    s->pin_level |= drive_lvl & drive_en;
+    /* Pull up undriven pins with internal pull-up enabled. */
+    s->pin_level |= not_driven & s->regs[NPCM7XX_GPIO_PU];
+    /* Pins not driven, pulled up or pulled down are undefined */
+    undefined |= not_driven & ~(s->regs[NPCM7XX_GPIO_PU]
+                                | s->regs[NPCM7XX_GPIO_PD]);
+
+    /* If any pins changed state, update the outgoing GPIOs. */
+    pin_diff ^= s->pin_level;
+    pin_diff |= undefined & diff;
+    if (pin_diff) {
+        int i;
+
+        for (i = 0; i < NPCM7XX_GPIO_NR_PINS; i++) {
+            uint32_t mask = BIT(i);
+            if (pin_diff & mask) {
+                int level = (undefined & mask) ? -1 : !!(s->pin_level & mask);
+                trace_npcm7xx_gpio_set_output(DEVICE(s)->canonical_path,
+                                              i, level);
+                qemu_set_irq(s->output[i], level);
+            }
+        }
+    }
+
+    /* Calculate new value of DIN after masking and polarity setting. */
+    din_old = s->regs[NPCM7XX_GPIO_DIN];
+    s->regs[NPCM7XX_GPIO_DIN] = ((s->pin_level & s->regs[NPCM7XX_GPIO_IEM])
+                                 ^ s->regs[NPCM7XX_GPIO_POL]);
+
+    /* See if any new events triggered because of all this. */
+    npcm7xx_gpio_update_events(s, din_old ^ s->regs[NPCM7XX_GPIO_DIN]);
+}
+
+static bool npcm7xx_gpio_is_locked(NPCM7xxGPIOState *s)
+{
+    return s->regs[NPCM7XX_GPIO_TLOCK1] == 1;
+}
+
+static uint64_t npcm7xx_gpio_regs_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    hwaddr reg = addr / sizeof(uint32_t);
+    NPCM7xxGPIOState *s = opaque;
+    uint64_t value = 0;
+
+    switch (reg) {
+    case NPCM7XX_GPIO_TLOCK1 ... NPCM7XX_GPIO_EVEN:
+    case NPCM7XX_GPIO_EVST ... NPCM7XX_GPIO_ODSC:
+        value = s->regs[reg];
+        break;
+
+    case NPCM7XX_GPIO_EVENS ... NPCM7XX_GPIO_EVENC:
+    case NPCM7XX_GPIO_DOS ... NPCM7XX_GPIO_TLOCK2:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from write-only register 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+    }
+
+    trace_npcm7xx_gpio_read(DEVICE(s)->canonical_path, addr, value);
+
+    return value;
+}
+
+static void npcm7xx_gpio_regs_write(void *opaque, hwaddr addr, uint64_t v,
+                                    unsigned int size)
+{
+    hwaddr reg = addr / sizeof(uint32_t);
+    NPCM7xxGPIOState *s = opaque;
+    uint32_t value = v;
+    uint32_t diff;
+
+    trace_npcm7xx_gpio_write(DEVICE(s)->canonical_path, addr, v);
+
+    if (npcm7xx_gpio_is_locked(s)) {
+        switch (reg) {
+        case NPCM7XX_GPIO_TLOCK1:
+            if (s->regs[NPCM7XX_GPIO_TLOCK2] == NPCM7XX_GPIO_LOCK_MAGIC2 &&
+                value == NPCM7XX_GPIO_LOCK_MAGIC1) {
+                s->regs[NPCM7XX_GPIO_TLOCK1] = 0;
+                s->regs[NPCM7XX_GPIO_TLOCK2] = 0;
+            }
+            break;
+
+        case NPCM7XX_GPIO_TLOCK2:
+            s->regs[reg] = value;
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to locked register @ 0x%" HWADDR_PRIx "\n",
+                          DEVICE(s)->canonical_path, addr);
+            break;
+        }
+
+        return;
+    }
+
+    diff = s->regs[reg] ^ value;
+
+    switch (reg) {
+    case NPCM7XX_GPIO_TLOCK1:
+    case NPCM7XX_GPIO_TLOCK2:
+        s->regs[NPCM7XX_GPIO_TLOCK1] = 1;
+        s->regs[NPCM7XX_GPIO_TLOCK2] = 0;
+        break;
+
+    case NPCM7XX_GPIO_DIN:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only register @ 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+
+    case NPCM7XX_GPIO_POL:
+    case NPCM7XX_GPIO_DOUT:
+    case NPCM7XX_GPIO_OE:
+    case NPCM7XX_GPIO_OTYP:
+    case NPCM7XX_GPIO_PU:
+    case NPCM7XX_GPIO_PD:
+    case NPCM7XX_GPIO_IEM:
+        s->regs[reg] = value;
+        npcm7xx_gpio_update_pins(s, diff);
+        break;
+
+    case NPCM7XX_GPIO_DOS:
+        s->regs[NPCM7XX_GPIO_DOUT] |= value;
+        npcm7xx_gpio_update_pins(s, value);
+        break;
+    case NPCM7XX_GPIO_DOC:
+        s->regs[NPCM7XX_GPIO_DOUT] &= ~value;
+        npcm7xx_gpio_update_pins(s, value);
+        break;
+    case NPCM7XX_GPIO_OES:
+        s->regs[NPCM7XX_GPIO_OE] |= value;
+        npcm7xx_gpio_update_pins(s, value);
+        break;
+    case NPCM7XX_GPIO_OEC:
+        s->regs[NPCM7XX_GPIO_OE] &= ~value;
+        npcm7xx_gpio_update_pins(s, value);
+        break;
+
+    case NPCM7XX_GPIO_EVTYP:
+    case NPCM7XX_GPIO_EVBE:
+    case NPCM7XX_GPIO_EVEN:
+        s->regs[reg] = value;
+        npcm7xx_gpio_update_events(s, 0);
+        break;
+
+    case NPCM7XX_GPIO_EVENS:
+        s->regs[NPCM7XX_GPIO_EVEN] |= value;
+        npcm7xx_gpio_update_events(s, 0);
+        break;
+    case NPCM7XX_GPIO_EVENC:
+        s->regs[NPCM7XX_GPIO_EVEN] &= ~value;
+        npcm7xx_gpio_update_events(s, 0);
+        break;
+
+    case NPCM7XX_GPIO_EVST:
+        s->regs[reg] &= ~value;
+        npcm7xx_gpio_update_events(s, 0);
+        break;
+
+    case NPCM7XX_GPIO_MP:
+    case NPCM7XX_GPIO_DBNC:
+    case NPCM7XX_GPIO_OSRC:
+    case NPCM7XX_GPIO_ODSC:
+        /* Nothing to do; just store the value. */
+        s->regs[reg] = value;
+        break;
+
+    case NPCM7XX_GPIO_OBL0:
+    case NPCM7XX_GPIO_OBL1:
+    case NPCM7XX_GPIO_OBL2:
+    case NPCM7XX_GPIO_OBL3:
+        s->regs[reg] = value;
+        qemu_log_mask(LOG_UNIMP, "%s: Blinking is not implemented\n",
+                      __func__);
+        break;
+
+    case NPCM7XX_GPIO_SPLCK:
+    case NPCM7XX_GPIO_MPLCK:
+        qemu_log_mask(LOG_UNIMP, "%s: Per-pin lock is not implemented\n",
+                      __func__);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                      DEVICE(s)->canonical_path, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps npcm7xx_gpio_regs_ops = {
+    .read = npcm7xx_gpio_regs_read,
+    .write = npcm7xx_gpio_regs_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm7xx_gpio_set_input(void *opaque, int line, int level)
+{
+    NPCM7xxGPIOState *s = opaque;
+
+    trace_npcm7xx_gpio_set_input(DEVICE(s)->canonical_path, line, level);
+
+    g_assert(line >= 0 && line < NPCM7XX_GPIO_NR_PINS);
+
+    s->ext_driven = deposit32(s->ext_driven, line, 1, level >= 0);
+    s->ext_level = deposit32(s->ext_level, line, 1, level > 0);
+
+    npcm7xx_gpio_update_pins(s, BIT(line));
+}
+
+static void npcm7xx_gpio_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxGPIOState *s = NPCM7XX_GPIO(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[NPCM7XX_GPIO_PU] = s->reset_pu;
+    s->regs[NPCM7XX_GPIO_PD] = s->reset_pd;
+    s->regs[NPCM7XX_GPIO_OSRC] = s->reset_osrc;
+    s->regs[NPCM7XX_GPIO_ODSC] = s->reset_odsc;
+}
+
+static void npcm7xx_gpio_hold_reset(Object *obj)
+{
+    NPCM7xxGPIOState *s = NPCM7XX_GPIO(obj);
+
+    npcm7xx_gpio_update_pins(s, -1);
+}
+
+static void npcm7xx_gpio_init(Object *obj)
+{
+    NPCM7xxGPIOState *s = NPCM7XX_GPIO(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &npcm7xx_gpio_regs_ops, s,
+                          "regs", NPCM7XX_GPIO_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    qdev_init_gpio_in(dev, npcm7xx_gpio_set_input, NPCM7XX_GPIO_NR_PINS);
+    qdev_init_gpio_out(dev, s->output, NPCM7XX_GPIO_NR_PINS);
+}
+
+static const VMStateDescription vmstate_npcm7xx_gpio = {
+    .name = "npcm7xx-gpio",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(pin_level, NPCM7xxGPIOState),
+        VMSTATE_UINT32(ext_level, NPCM7xxGPIOState),
+        VMSTATE_UINT32(ext_driven, NPCM7xxGPIOState),
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGPIOState, NPCM7XX_GPIO_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static Property npcm7xx_gpio_properties[] = {
+    /* Bit n set => pin n has pullup enabled by default. */
+    DEFINE_PROP_UINT32("reset-pullup", NPCM7xxGPIOState, reset_pu, 0),
+    /* Bit n set => pin n has pulldown enabled by default. */
+    DEFINE_PROP_UINT32("reset-pulldown", NPCM7xxGPIOState, reset_pd, 0),
+    /* Bit n set => pin n has high slew rate by default. */
+    DEFINE_PROP_UINT32("reset-osrc", NPCM7xxGPIOState, reset_osrc, 0),
+    /* Bit n set => pin n has high drive strength by default. */
+    DEFINE_PROP_UINT32("reset-odsc", NPCM7xxGPIOState, reset_odsc, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_gpio_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *reset = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM7XX_GPIO_REGS_END > NPCM7XX_GPIO_NR_REGS);
+
+    dc->desc = "NPCM7xx GPIO Controller";
+    dc->vmsd = &vmstate_npcm7xx_gpio;
+    reset->phases.enter = npcm7xx_gpio_enter_reset;
+    reset->phases.hold = npcm7xx_gpio_hold_reset;
+    device_class_set_props(dc, npcm7xx_gpio_properties);
+}
+
+static const TypeInfo npcm7xx_gpio_types[] = {
+    {
+        .name = TYPE_NPCM7XX_GPIO,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxGPIOState),
+        .class_init = npcm7xx_gpio_class_init,
+        .instance_init = npcm7xx_gpio_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_gpio_types);
diff --git a/tests/qtest/npcm7xx_gpio-test.c b/tests/qtest/npcm7xx_gpio-test.c
new file mode 100644
index 00000000000..1004cef8121
--- /dev/null
+++ b/tests/qtest/npcm7xx_gpio-test.c
@@ -0,0 +1,385 @@
+/*
+ * QTest testcase for the Nuvoton NPCM7xx GPIO modules.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define NR_GPIO_DEVICES (8)
+#define GPIO(x)         (0xf0010000 + (x) * 0x1000)
+#define GPIO_IRQ(x)     (116 + (x))
+
+/* GPIO registers */
+#define GP_N_TLOCK1     0x00
+#define GP_N_DIN        0x04 /* Data IN */
+#define GP_N_POL        0x08 /* Polarity */
+#define GP_N_DOUT       0x0c /* Data OUT */
+#define GP_N_OE         0x10 /* Output Enable */
+#define GP_N_OTYP       0x14
+#define GP_N_MP         0x18
+#define GP_N_PU         0x1c /* Pull-up */
+#define GP_N_PD         0x20 /* Pull-down */
+#define GP_N_DBNC       0x24 /* Debounce */
+#define GP_N_EVTYP      0x28 /* Event Type */
+#define GP_N_EVBE       0x2c /* Event Both Edge */
+#define GP_N_OBL0       0x30
+#define GP_N_OBL1       0x34
+#define GP_N_OBL2       0x38
+#define GP_N_OBL3       0x3c
+#define GP_N_EVEN       0x40 /* Event Enable */
+#define GP_N_EVENS      0x44 /* Event Set (enable) */
+#define GP_N_EVENC      0x48 /* Event Clear (disable) */
+#define GP_N_EVST       0x4c /* Event Status */
+#define GP_N_SPLCK      0x50
+#define GP_N_MPLCK      0x54
+#define GP_N_IEM        0x58 /* Input Enable */
+#define GP_N_OSRC       0x5c
+#define GP_N_ODSC       0x60
+#define GP_N_DOS        0x68 /* Data OUT Set */
+#define GP_N_DOC        0x6c /* Data OUT Clear */
+#define GP_N_OES        0x70 /* Output Enable Set */
+#define GP_N_OEC        0x74 /* Output Enable Clear */
+#define GP_N_TLOCK2     0x7c
+
+static void gpio_unlock(int n)
+{
+    if (readl(GPIO(n) + GP_N_TLOCK1) != 0) {
+        writel(GPIO(n) + GP_N_TLOCK2, 0xc0de1248);
+        writel(GPIO(n) + GP_N_TLOCK1, 0xc0defa73);
+    }
+}
+
+/* Restore the GPIO controller to a sensible default state. */
+static void gpio_reset(int n)
+{
+    gpio_unlock(0);
+
+    writel(GPIO(n) + GP_N_EVEN, 0x00000000);
+    writel(GPIO(n) + GP_N_EVST, 0xffffffff);
+    writel(GPIO(n) + GP_N_POL, 0x00000000);
+    writel(GPIO(n) + GP_N_DOUT, 0x00000000);
+    writel(GPIO(n) + GP_N_OE, 0x00000000);
+    writel(GPIO(n) + GP_N_OTYP, 0x00000000);
+    writel(GPIO(n) + GP_N_PU, 0xffffffff);
+    writel(GPIO(n) + GP_N_PD, 0x00000000);
+    writel(GPIO(n) + GP_N_IEM, 0xffffffff);
+}
+
+static void test_dout_to_din(void)
+{
+    gpio_reset(0);
+
+    /* When output is enabled, DOUT should be reflected on DIN. */
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    /* PU and PD shouldn't have any impact on DIN. */
+    writel(GPIO(0) + GP_N_PU, 0xffff0000);
+    writel(GPIO(0) + GP_N_PD, 0x0000ffff);
+    writel(GPIO(0) + GP_N_DOUT, 0x12345678);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DOUT), ==, 0x12345678);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x12345678);
+}
+
+static void test_pullup_pulldown(void)
+{
+    gpio_reset(0);
+
+    /*
+     * When output is disabled, and PD is the inverse of PU, PU should be
+     * reflected on DIN. If PD is not the inverse of PU, the state of DIN is
+     * undefined, so we don't test that.
+     */
+    writel(GPIO(0) + GP_N_OE, 0x00000000);
+    /* DOUT shouldn't have any impact on DIN. */
+    writel(GPIO(0) + GP_N_DOUT, 0xffff0000);
+    writel(GPIO(0) + GP_N_PU, 0x23456789);
+    writel(GPIO(0) + GP_N_PD, ~0x23456789U);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_PU), ==, 0x23456789);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_PD), ==, ~0x23456789U);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x23456789);
+}
+
+static void test_output_enable(void)
+{
+    gpio_reset(0);
+
+    /*
+     * With all pins weakly pulled down, and DOUT all-ones, OE should be
+     * reflected on DIN.
+     */
+    writel(GPIO(0) + GP_N_DOUT, 0xffffffff);
+    writel(GPIO(0) + GP_N_PU, 0x00000000);
+    writel(GPIO(0) + GP_N_PD, 0xffffffff);
+    writel(GPIO(0) + GP_N_OE, 0x3456789a);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_OE), ==, 0x3456789a);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x3456789a);
+
+    writel(GPIO(0) + GP_N_OEC, 0x00030002);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_OE), ==, 0x34547898);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x34547898);
+
+    writel(GPIO(0) + GP_N_OES, 0x0000f001);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_OE), ==, 0x3454f899);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x3454f899);
+}
+
+static void test_open_drain(void)
+{
+    gpio_reset(0);
+
+    /*
+     * Upper half of DOUT drives a 1 only if the corresponding bit in OTYP is
+     * not set. If OTYP is set, DIN is determined by PU/PD. Lower half of
+     * DOUT always drives a 0 regardless of OTYP; PU/PD have no effect.  When
+     * OE is 0, output is determined by PU/PD; OTYP has no effect.
+     */
+    writel(GPIO(0) + GP_N_OTYP, 0x456789ab);
+    writel(GPIO(0) + GP_N_OE, 0xf0f0f0f0);
+    writel(GPIO(0) + GP_N_DOUT, 0xffff0000);
+    writel(GPIO(0) + GP_N_PU, 0xff00ff00);
+    writel(GPIO(0) + GP_N_PD, 0x00ff00ff);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_OTYP), ==, 0x456789ab);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0xff900f00);
+}
+
+static void test_polarity(void)
+{
+    gpio_reset(0);
+
+    /*
+     * In push-pull mode, DIN should reflect DOUT because the signal is
+     * inverted in both directions.
+     */
+    writel(GPIO(0) + GP_N_OTYP, 0x00000000);
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_DOUT, 0x56789abc);
+    writel(GPIO(0) + GP_N_POL, 0x6789abcd);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_POL), ==, 0x6789abcd);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0x56789abc);
+
+    /*
+     * When turning off the drivers, DIN should reflect the inverse of the
+     * pulled-up lines.
+     */
+    writel(GPIO(0) + GP_N_OE, 0x00000000);
+    writel(GPIO(0) + GP_N_POL, 0xffffffff);
+    writel(GPIO(0) + GP_N_PU, 0x789abcde);
+    writel(GPIO(0) + GP_N_PD, ~0x789abcdeU);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, ~0x789abcdeU);
+
+    /*
+     * In open-drain mode, DOUT=1 will appear to drive the pin high (since DIN
+     * is inverted), while DOUT=0 will leave the pin floating.
+     */
+    writel(GPIO(0) + GP_N_OTYP, 0xffffffff);
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_PU, 0xffff0000);
+    writel(GPIO(0) + GP_N_PD, 0x0000ffff);
+    writel(GPIO(0) + GP_N_DOUT, 0xff00ff00);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0xff00ffff);
+}
+
+static void test_input_mask(void)
+{
+    gpio_reset(0);
+
+    /* IEM=0 forces the input to zero before polarity inversion. */
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_DOUT, 0xff00ff00);
+    writel(GPIO(0) + GP_N_POL, 0xffff0000);
+    writel(GPIO(0) + GP_N_IEM, 0x87654321);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DIN), ==, 0xff9a4300);
+}
+
+static void test_temp_lock(void)
+{
+    gpio_reset(0);
+
+    writel(GPIO(0) + GP_N_DOUT, 0x98765432);
+
+    /* Make sure we're unlocked initially. */
+    g_assert_cmphex(readl(GPIO(0) + GP_N_TLOCK1), ==, 0);
+    /* Writing any value to TLOCK1 will lock. */
+    writel(GPIO(0) + GP_N_TLOCK1, 0);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_TLOCK1), ==, 1);
+    writel(GPIO(0) + GP_N_DOUT, 0xa9876543);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DOUT), ==, 0x98765432);
+    /* Now, try to unlock. */
+    gpio_unlock(0);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_TLOCK1), ==, 0);
+    writel(GPIO(0) + GP_N_DOUT, 0xa9876543);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DOUT), ==, 0xa9876543);
+
+    /* Try it again, but write TLOCK2 to lock. */
+    writel(GPIO(0) + GP_N_TLOCK2, 0);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_TLOCK1), ==, 1);
+    writel(GPIO(0) + GP_N_DOUT, 0x98765432);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DOUT), ==, 0xa9876543);
+    /* Now, try to unlock. */
+    gpio_unlock(0);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_TLOCK1), ==, 0);
+    writel(GPIO(0) + GP_N_DOUT, 0x98765432);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_DOUT), ==, 0x98765432);
+}
+
+static void test_events_level(void)
+{
+    gpio_reset(0);
+
+    writel(GPIO(0) + GP_N_EVTYP, 0x00000000);
+    writel(GPIO(0) + GP_N_DOUT, 0xba987654);
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_EVST, 0xffffffff);
+
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0xba987654);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_DOUT, 0x00000000);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0xba987654);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0x00007654);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0xba980000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0xba980000);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+}
+
+static void test_events_rising_edge(void)
+{
+    gpio_reset(0);
+
+    writel(GPIO(0) + GP_N_EVTYP, 0xffffffff);
+    writel(GPIO(0) + GP_N_EVBE, 0x00000000);
+    writel(GPIO(0) + GP_N_DOUT, 0xffff0000);
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_EVST, 0xffffffff);
+
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_DOUT, 0xff00ff00);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x0000ff00);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_DOUT, 0x00ff0000);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00ffff00);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0x0000f000);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00ff0f00);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0x00ff0f00);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+}
+
+static void test_events_both_edges(void)
+{
+    gpio_reset(0);
+
+    writel(GPIO(0) + GP_N_EVTYP, 0xffffffff);
+    writel(GPIO(0) + GP_N_EVBE, 0xffffffff);
+    writel(GPIO(0) + GP_N_DOUT, 0xffff0000);
+    writel(GPIO(0) + GP_N_OE, 0xffffffff);
+    writel(GPIO(0) + GP_N_EVST, 0xffffffff);
+
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_DOUT, 0xff00ff00);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00ffff00);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_DOUT, 0xef00ff08);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x10ffff08);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0x0000f000);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x10ff0f08);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+    writel(GPIO(0) + GP_N_EVST, 0x10ff0f08);
+    g_assert_cmphex(readl(GPIO(0) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(0)));
+}
+
+static void test_gpion_irq(gconstpointer test_data)
+{
+    intptr_t n = (intptr_t)test_data;
+
+    gpio_reset(n);
+
+    writel(GPIO(n) + GP_N_EVTYP, 0x00000000);
+    writel(GPIO(n) + GP_N_DOUT, 0x00000000);
+    writel(GPIO(n) + GP_N_OE, 0xffffffff);
+    writel(GPIO(n) + GP_N_EVST, 0xffffffff);
+    writel(GPIO(n) + GP_N_EVEN, 0x00000000);
+
+    /* Trigger an event; interrupts are masked. */
+    g_assert_cmphex(readl(GPIO(n) + GP_N_EVST), ==, 0x00000000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+    writel(GPIO(n) + GP_N_DOS, 0x00008000);
+    g_assert_cmphex(readl(GPIO(n) + GP_N_EVST), ==, 0x00008000);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+
+    /* Unmask all event interrupts; verify that the interrupt fired. */
+    writel(GPIO(n) + GP_N_EVEN, 0xffffffff);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+
+    /* Clear the current bit, set a new bit, irq stays asserted. */
+    writel(GPIO(n) + GP_N_DOC, 0x00008000);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+    writel(GPIO(n) + GP_N_DOS, 0x00000200);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+    writel(GPIO(n) + GP_N_EVST, 0x00008000);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+
+    /* Mask/unmask the event that's currently active. */
+    writel(GPIO(n) + GP_N_EVENC, 0x00000200);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+    writel(GPIO(n) + GP_N_EVENS, 0x00000200);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+
+    /* Clear the input and the status bit, irq is deasserted. */
+    writel(GPIO(n) + GP_N_DOC, 0x00000200);
+    g_assert_true(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+    writel(GPIO(n) + GP_N_EVST, 0x00000200);
+    g_assert_false(qtest_get_irq(global_qtest, GPIO_IRQ(n)));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("/npcm7xx_gpio/dout_to_din", test_dout_to_din);
+    qtest_add_func("/npcm7xx_gpio/pullup_pulldown", test_pullup_pulldown);
+    qtest_add_func("/npcm7xx_gpio/output_enable", test_output_enable);
+    qtest_add_func("/npcm7xx_gpio/open_drain", test_open_drain);
+    qtest_add_func("/npcm7xx_gpio/polarity", test_polarity);
+    qtest_add_func("/npcm7xx_gpio/input_mask", test_input_mask);
+    qtest_add_func("/npcm7xx_gpio/temp_lock", test_temp_lock);
+    qtest_add_func("/npcm7xx_gpio/events/level", test_events_level);
+    qtest_add_func("/npcm7xx_gpio/events/rising_edge", test_events_rising_edge);
+    qtest_add_func("/npcm7xx_gpio/events/both_edges", test_events_both_edges);
+
+    for (i = 0; i < NR_GPIO_DEVICES; i++) {
+        g_autofree char *test_name =
+            g_strdup_printf("/npcm7xx_gpio/gpio[%d]/irq", i);
+        qtest_add_data_func(test_name, (void *)(intptr_t)i, test_gpion_irq);
+    }
+
+    qtest_start("-machine npcm750-evb");
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/a9mpcore/gic");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 86cae9a0f3f..5c0a7d7b95a 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -6,6 +6,7 @@ softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
 
 softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 6e3f0487455..46ab9323bd0 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -1,5 +1,12 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# npcm7xx_gpio.c
+npcm7xx_gpio_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+npcm7xx_gpio_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
+npcm7xx_gpio_set_input(const char *id, int32_t line, int32_t level) "%s line: %" PRIi32 " level: %" PRIi32
+npcm7xx_gpio_set_output(const char *id, int32_t line, int32_t level) "%s line: %" PRIi32 " level: %" PRIi32
+npcm7xx_gpio_update_events(const char *id, uint32_t evst, uint32_t even) "%s evst: 0x%08" PRIx32 " even: 0x%08" PRIx32
+
 # nrf51_gpio.c
 nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
 nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43e71a3d5ba..c19f1c85034 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -134,7 +134,8 @@ qtests_sparc64 = \
   ['prom-env-test', 'boot-serial-test']
 
 qtests_npcm7xx = \
-  ['npcm7xx_rng-test',
+  ['npcm7xx_gpio-test',
+   'npcm7xx_rng-test',
    'npcm7xx_timer-test',
    'npcm7xx_watchdog_timer-test']
 qtests_arm = \
-- 
2.20.1


