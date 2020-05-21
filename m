Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5520748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rU3Xwk64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbry7-0004b5-AW
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34NTGXgsKCqEITLJOOFNPFOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlf-0005x4-Sh
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:11 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:36217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34NTGXgsKCqEITLJOOFNPFOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--hskinnemoen.bounces.google.com>)
 id 1jbqle-0001kS-2r
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:11 -0400
Received: by mail-yb1-xb49.google.com with SMTP id h129so6455654ybc.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XRIYe/mnvxswjw7bar5LdABn/ZVfCrH4BWehN/YF4Sc=;
 b=rU3Xwk64I7b4U3EhyQ0Ibh97OTlJgdUgWVoqciXV8JqdkhzPo4adCCUkAdon8k7li1
 PaNkSjDuEVmuBSJcvrUYRAouuQf3jdvQzaKgmEOmbHfT7ItH4v5Pk4so11MCaWl7kHwx
 BRt4PKe8LLAUKyo6KxewpnjIUQczRJmLarCWaprxJCy3fw79jX0zLiMQzn+1UKM1Dok+
 OuyqTIzICelLY4+UGk2yH/QpR1/JiyYe/QPZPQbC2Qu6IFxjoSwH+3+45mqf5vXuTgXH
 jaL3rQxJ3Tv7oi6UQnhINu8YHrsPERsRxHYKWQCs+/rw0TN8kK6cLqW0lZe/RdbieCGH
 GF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XRIYe/mnvxswjw7bar5LdABn/ZVfCrH4BWehN/YF4Sc=;
 b=ICEI3wgzK5mLS3egyR1Hn1i1eb2kQF7e/ORNJgodYCGkc92TaGMgBVlGDIEInk0IhB
 364Y6Tm8U0FjbhAbX/+2//xCY2jqVrg3ccm2VNy9mSHlKJLKXIPSSHVyC0kkDPta8IcF
 M+ZlI0bztGoijRtprcMda6uVSnIgriy+k3l9IsEa/pZLkX7bA1CO0FFhvxjkvIr9KI02
 PacQ8lxYSMDtFPJam3PhJKKOUgOqxz4wA3LGuDvow9/i0+jHnVJ6aLkhWtpcmCePEvBn
 4q1Hrh9eZ6WrYtGYSkmzw++WgaSBBibNEOMCcG5xBtbAa4hxf/BNPeYzBAo/IuHxeMC7
 820w==
X-Gm-Message-State: AOAM532XTz4N9uiuXn9Jgbwcq+zdOk/kG/I+DH+/wRqB3woy2O6k6d1T
 /3KkLXTu4yQRed+VTfBqcmmWDGb0xvWrNx3xUg==
X-Google-Smtp-Source: ABdhPJzaN0XSt15xWHFKQZOmtU1mhQ31WayAYPSusYJrMVM3hH6dJy5W4toHvjFSkswmJLrsPGLebUzkyliWRlyDwg==
X-Received: by 2002:a25:c5c7:: with SMTP id
 v190mr16752888ybe.421.1590088928651; 
 Thu, 21 May 2020 12:22:08 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:32 -0700
In-Reply-To: <20200521192133.127559-1-hskinnemoen@google.com>
Message-Id: <20200521192133.127559-6-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 5/6] hw/arm: Add NPCM730 and NPCM750 SoC models
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=34NTGXgsKCqEITLJOOFNPFOHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:53 -0400
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

The Nuvoton NPCM7xx SoC family are used to implement Baseboard
Management Controllers in servers. While the family includes four SoCs,
this patch implements limited support for two of them: NPCM730 (targeted
for Data Center applications) and NPCM750 (targeted for Enterprise
applications).

This patch includes little more than the bare minimum needed to boot a
Linux kernel built with NPCM7xx support in direct-kernel mode:

  - Two Cortex-A9 CPU cores with built-in periperhals.
  - Global Configuration Registers.
  - Clock Management.
  - 3 Timer Modules with 5 timers each.
  - 4 serial ports.

The chips themselves have a lot more features, some of which will be
added to the model at a later stage.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 MAINTAINERS              |   2 +
 hw/arm/Makefile.objs     |   1 +
 hw/arm/npcm7xx.c         | 328 +++++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h |  79 ++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 hw/arm/npcm7xx.c
 create mode 100644 include/hw/arm/npcm7xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c9a59a2c10..9c526af784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -720,8 +720,10 @@ M: Havard Skinnemoen <hskinnemoen@google.com>
 M: Tyrone Ting <kfting@nuvoton.com>
 L: qemu-arm@nongnu.org
 S: Supported
+F: hw/arm/npcm7xx*
 F: hw/misc/npcm7xx*
 F: hw/timer/npcm7xx*
+F: include/hw/arm/npcm7xx*
 F: include/hw/misc/npcm7xx*
 F: include/hw/timer/npcm7xx*
 
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 534a6a119e..13d163a599 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -41,6 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
+obj-$(CONFIG_NPCM7XX) += npcm7xx.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
new file mode 100644
index 0000000000..3d88615634
--- /dev/null
+++ b/hw/arm/npcm7xx.c
@@ -0,0 +1,328 @@
+/*
+ * Nuvoton NPCM7xx SoC family.
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
+#include "exec/address-spaces.h"
+#include "hw/arm/npcm7xx.h"
+#include "hw/char/serial.h"
+#include "hw/loader.h"
+#include "hw/misc/unimp.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "sysemu/sysemu.h"
+
+/* The first half of the address space is reserved for DDR4 DRAM. */
+#define NPCM7XX_DRAM_BA         (0x00000000)
+#define NPCM7XX_DRAM_SZ         (2 * GiB)
+
+/*
+ * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
+ * that aren't handled by any device.
+ */
+#define NPCM7XX_MMIO_BA         (0x80000000)
+#define NPCM7XX_MMIO_SZ         (0x7FFD0000)
+
+/* Core system modules. */
+#define NPCM7XX_L2C_BA          (0xF03FC000)
+#define NPCM7XX_CPUP_BA         (0xF03FE000)
+#define NPCM7XX_GCR_BA          (0xF0800000)
+#define NPCM7XX_CLK_BA          (0xF0801000)
+
+/* Memory blocks at the end of the address space */
+#define NPCM7XX_RAM2_BA         (0xFFFD0000)
+#define NPCM7XX_RAM2_SZ         (128 * KiB)
+#define NPCM7XX_ROM_BA          (0xFFFF0000)
+#define NPCM7XX_ROM_SZ          (64 * KiB)
+
+/*
+ * Interrupt lines going into the GIC. This does not include internal Cortex-A9
+ * interrupts.
+ */
+enum NPCM7xxInterrupt {
+    NPCM7XX_UART0_IRQ           = 2,
+    NPCM7XX_UART1_IRQ,
+    NPCM7XX_UART2_IRQ,
+    NPCM7XX_UART3_IRQ,
+    NPCM7XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
+    NPCM7XX_TIMER1_IRQ,
+    NPCM7XX_TIMER2_IRQ,
+    NPCM7XX_TIMER3_IRQ,
+    NPCM7XX_TIMER4_IRQ,
+    NPCM7XX_TIMER5_IRQ,                 /* Timer Module 1 */
+    NPCM7XX_TIMER6_IRQ,
+    NPCM7XX_TIMER7_IRQ,
+    NPCM7XX_TIMER8_IRQ,
+    NPCM7XX_TIMER9_IRQ,
+    NPCM7XX_TIMER10_IRQ,                /* Timer Module 2 */
+    NPCM7XX_TIMER11_IRQ,
+    NPCM7XX_TIMER12_IRQ,
+    NPCM7XX_TIMER13_IRQ,
+    NPCM7XX_TIMER14_IRQ,
+};
+
+/* Register base address for each Timer Module */
+static const hwaddr npcm7xx_tim_addr[] = {
+    0xF0008000,
+    0xF0009000,
+    0xF000A000,
+};
+
+/* Register base address for each 16550 UART */
+static const hwaddr npcm7xx_uart_addr[] = {
+    0xF0001000,
+    0xF0002000,
+    0xF0003000,
+    0xF0004000,
+};
+
+void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_info *info)
+{
+    /*
+     * The default smpboot stub halts the secondary CPU with a 'wfi'
+     * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux kernel
+     * does not send an IPI to wake it up, so the second CPU fails to boot. So
+     * we need to provide our own smpboot stub that can not use 'wfi', it has
+     * to spin the secondary CPU until the first CPU writes to the SCRPAD reg.
+     */
+    uint32_t smpboot[] = {
+        0xe59f2018,     /* ldr r2, bootreg_addr */
+        0xe3a00000,     /* mov r0, #0 */
+        0xe5820000,     /* str r0, [r2] */
+        0xe320f002,     /* wfe */
+        0xe5921000,     /* ldr r1, [r2] */
+        0xe1110001,     /* tst r1, r1 */
+        0x0afffffb,     /* beq <wfe> */
+        0xe12fff11,     /* bx r1 */
+        NPCM7XX_SMP_BOOTREG_ADDR,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(smpboot); i++) {
+        smpboot[i] = tswap32(smpboot[i]);
+    }
+
+    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
+                       NPCM7XX_SMP_LOADER_START);
+}
+
+static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
+{
+    return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
+}
+
+static void npcm7xx_init(Object *obj)
+{
+    NPCM7xxState *s = NPCM7XX(obj);
+    int i;
+
+    for (i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
+        s->cpu[i] = ARM_CPU(
+            object_new_with_props(ARM_CPU_TYPE_NAME("cortex-a9"),
+                                  obj, "cpu[*]", &error_abort, NULL));
+    }
+
+    sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore,
+                          sizeof(s->a9mpcore), TYPE_A9MPCORE_PRIV);
+    sysbus_init_child_obj(obj, "gcr", OBJECT(&s->gcr), sizeof(s->gcr),
+                          TYPE_NPCM7XX_GCR);
+    sysbus_init_child_obj(obj, "clk", OBJECT(&s->clk), sizeof(s->clk),
+                          TYPE_NPCM7XX_CLK);
+
+    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
+        sysbus_init_child_obj(obj, "tim[*]", OBJECT(&s->tim[i]),
+                              sizeof(s->tim[i]), TYPE_NPCM7XX_TIMER);
+    }
+}
+
+static void npcm7xx_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxState *s = NPCM7XX(dev);
+    NPCM7xxClass *sc = NPCM7XX_GET_CLASS(s);
+    Error *err = NULL;
+    int i;
+
+    /* I/O space -- unimplemented unless overridden below. */
+    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX_MMIO_SZ);
+
+    /* CPUs */
+    if (s->num_cpus > NPCM7XX_MAX_NUM_CPUS) {
+        warn_report("%s: invalid number of CPUs %d, using maximum %d",
+                    object_get_typename(OBJECT(s)), s->num_cpus,
+                    NPCM7XX_MAX_NUM_CPUS);
+        s->num_cpus = NPCM7XX_MAX_NUM_CPUS;
+    }
+
+    for (i = 0; i < s->num_cpus; i++) {
+        object_property_set_int(OBJECT(s->cpu[i]),
+                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
+                                "mp-affinity", &error_abort);
+        object_property_set_int(OBJECT(s->cpu[i]), NPCM7XX_GIC_CPU_IF_ADDR,
+                                "reset-cbar", &error_abort);
+        object_property_set_bool(OBJECT(s->cpu[i]), true,
+                                 "reset-hivecs", &error_abort);
+
+        /* TODO: Not sure why this is needed. */
+        if (object_property_find(OBJECT(s->cpu[i]), "has_el3", NULL)) {
+            object_property_set_bool(OBJECT(s->cpu[i]), false, "has_el3",
+                                     &error_abort);
+        }
+
+        object_property_set_bool(OBJECT(s->cpu[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    /* A9MPCORE peripherals */
+    object_property_set_int(OBJECT(&s->a9mpcore), s->num_cpus, "num-cpu",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->a9mpcore), 160, "num-irq", &error_abort);
+    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized",
+                             &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, NPCM7XX_CPUP_BA);
+
+    for (i = 0; i < s->num_cpus; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
+                           qdev_get_gpio_in(DEVICE(s->cpu[i]), ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + s->num_cpus,
+                           qdev_get_gpio_in(DEVICE(s->cpu[i]), ARM_CPU_FIQ));
+    }
+
+    /* L2 cache controller */
+    sysbus_create_simple("l2x0", NPCM7XX_L2C_BA, NULL);
+
+    /* System Global Control Registers (GCR) */
+    object_property_set_int(OBJECT(&s->gcr), sc->disabled_modules,
+                            "disabled-modules", &err);
+    object_property_set_bool(OBJECT(&s->gcr), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM7XX_GCR_BA);
+
+    /* Clock Control Registers (CLK) */
+    object_property_set_bool(OBJECT(&s->clk), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
+
+    /* Timer Modules (TIM) */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
+    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
+        Object *t = OBJECT(&s->tim[i]);
+        int first_irq;
+        int j;
+
+        object_property_set_bool(t, true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(t), 0, npcm7xx_tim_addr[i]);
+
+        first_irq = NPCM7XX_TIMER0_IRQ + i * NPCM7XX_TIMERS_PER_CTRL;
+        for (j = 0; j < NPCM7XX_TIMERS_PER_CTRL; j++) {
+            qemu_irq irq = npcm7xx_irq(s, first_irq + j);
+            sysbus_connect_irq(SYS_BUS_DEVICE(t), j, irq);
+        }
+    }
+
+    /* UART0..3 (16550 compatible) */
+    for (i = 0; i < ARRAY_SIZE(npcm7xx_uart_addr); i++) {
+        serial_mm_init(get_system_memory(), npcm7xx_uart_addr[i], 2,
+                       npcm7xx_irq(s, NPCM7XX_UART0_IRQ + i), 115200,
+                       serial_hd(i), DEVICE_LITTLE_ENDIAN);
+    }
+
+    /* RAM2 (SRAM) */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
+                           NPCM7XX_RAM2_SZ, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), NPCM7XX_RAM2_BA, &s->sram);
+
+    /* Internal ROM */
+    memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM7XX_ROM_SZ, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &s->irom);
+
+    /* External DDR4 SDRAM */
+    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, s->dram);
+}
+
+static Property npcm7xx_properties[] = {
+    DEFINE_PROP_INT32("num-cpus", NPCM7xxState, num_cpus, -1),
+    DEFINE_PROP_LINK("dram", NPCM7xxState, dram, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = npcm7xx_realize;
+    dc->user_creatable = false;
+    device_class_set_props(dc, npcm7xx_properties);
+}
+
+static void npcm730_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
+
+    /* NPCM730 is optimized for data center use, so no graphics, etc. */
+    nc->disabled_modules = 0x00300395;
+}
+
+static void npcm750_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
+
+    /* NPCM750 has everything */
+    nc->disabled_modules = 0x00000000;
+}
+
+static const TypeInfo npcm7xx_soc_types[] = {
+    {
+        .name           = TYPE_NPCM7XX,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(NPCM7xxState),
+        .instance_init  = npcm7xx_init,
+        .class_size     = sizeof(NPCM7xxClass),
+        .class_init     = npcm7xx_class_init,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_NPCM730,
+        .parent         = TYPE_NPCM7XX,
+        .class_init     = npcm730_class_init,
+    }, {
+        .name           = TYPE_NPCM750,
+        .parent         = TYPE_NPCM7XX,
+        .class_init     = npcm750_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm7xx_soc_types);
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
new file mode 100644
index 0000000000..0a8798dd24
--- /dev/null
+++ b/include/hw/arm/npcm7xx.h
@@ -0,0 +1,79 @@
+/*
+ * Nuvoton NPCM7xx SoC family.
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
+#ifndef NPCM7XX_H
+#define NPCM7XX_H
+
+#include "hw/boards.h"
+#include "hw/cpu/a9mpcore.h"
+#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/timer/npcm7xx_timer.h"
+#include "target/arm/cpu.h"
+
+#define NPCM7XX_MAX_NUM_CPUS    (2)
+
+/* Magic addresses for setting up direct kernel booting and SMP boot stubs. */
+#define NPCM7XX_LOADER_START            (0x00000000)  /* Start of SDRAM */
+#define NPCM7XX_SMP_LOADER_START        (0xFFFF0000)  /* Boot ROM */
+#define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
+#define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9 */
+
+typedef struct NPCM7xxState {
+    DeviceState         parent;
+
+    ARMCPU              *cpu[NPCM7XX_MAX_NUM_CPUS];
+    A9MPPrivState       a9mpcore;
+    int32_t             num_cpus;
+
+    MemoryRegion        sram;
+    MemoryRegion        irom;
+    MemoryRegion        *dram;
+
+    NPCM7xxGCRState     gcr;
+    NPCM7xxCLKState     clk;
+    NPCM7xxTimerCtrlState tim[3];
+} NPCM7xxState;
+
+#define TYPE_NPCM7XX    "npcm7xx"
+#define NPCM7XX(obj)    OBJECT_CHECK(NPCM7xxState, (obj), TYPE_NPCM7XX)
+
+#define TYPE_NPCM730    "npcm730"
+#define TYPE_NPCM750    "npcm750"
+
+typedef struct NPCM7xxClass {
+    DeviceClass         parent;
+
+    /* Bitmask of modules that are permanently disabled on this chip. */
+    uint32_t            disabled_modules;
+} NPCM7xxClass;
+
+#define NPCM7XX_CLASS(klass)                                            \
+    OBJECT_CLASS_CHECK(NPCM7xxClass, (klass), TYPE_NPCM7XX)
+#define NPCM7XX_GET_CLASS(obj)                                          \
+    OBJECT_GET_CLASS(NPCM7xxClass, (obj), TYPE_NPCM7XX)
+
+/**
+ * npcm7xx_write_secondary_boot - Write stub for booting secondary CPU.
+ * @cpu: The CPU to be booted.
+ * @info: Boot info structure for the board.
+ *
+ * This will write a short code stub to the internal ROM that will keep the
+ * secondary CPU spinning until the primary CPU writes an address to the SCRPAD
+ * register in the GCR, after which the secondary CPU will jump there.
+ */
+extern void npcm7xx_write_secondary_boot(ARMCPU *cpu,
+                                         const struct arm_boot_info *info);
+
+#endif /* NPCM7XX_H */
-- 
2.27.0.rc0.183.gde8f92d652-goog


