Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C5A20842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb6j+0pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSkU-0007Ta-Va
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbs-0006F3-72
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbp-000712-Hs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbp-0006zw-7z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so22923900wrh.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wk4UZq6JkpzyWGT/03MlAQBAyL+zpYMXw3r/aQv5G0c=;
 b=Eb6j+0pT+M1azp2z65vEkr+kVpe4/V75DsgryExrRIU2rtMIKJ1pBDY2gqfevWiHRU
 BBRBER5T73Cts7mtx6M6u+A+tjz0/NCGg0xnrNoFe+F98Ka/W7AGG5EUrIeZA9CtY4la
 Pb/roqDQaSSmPxeg0VTlSTurvP8Kq1BSlyMG2RLP0DrcY60CJoFDnsZO4SMQxkVqareY
 rCcQZE1R97YnIT7rozHMFEdpupPh07DmeNJ+hXCCVXtkjXsNnhCw+kg0dtvFr064h0yb
 bJMf3XahSCRfYQGGrljRQWc62Y3mwTxvMgF8ryaNa+QmM1Ucbery7UiNmzNlnVd+aLZ3
 Q9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wk4UZq6JkpzyWGT/03MlAQBAyL+zpYMXw3r/aQv5G0c=;
 b=l/kYjnl2BJeymmPLhOvfYba3I7M3XatGO8Ko8e8vfX4pnJueyrNFKNyjVcl31Zl5yY
 Vf0PS7EpLtoDgyXwfgrADTyWQzcIvK9ZowJw2f/kGzMaz6RHvxhD4vVyNBLVvC+KGYlf
 xL+ptl1lJYeznJbUWu2BNSGLWj4Y4X6/XjssHPVKSqUOaKewfp2e2/rr/zQoacfkRt0D
 Lm27l0z+HbAA3ImFjiZODUGNHMxH3c8hifh4pZr3Ax0+Yuhe7gXKXRBVKJyzSQIjKeJN
 WlLDWlg8HUNyhJtAx9jm/iXqgNpsl7j75tZyLMUu44MO+O5Yz8DxzJ2LLOdedQcu1Vxm
 XuSQ==
X-Gm-Message-State: APjAAAUnu4lE+Fy2HA2ziuK7Cn8ZgYNYcJQjHBSAE7Ud7YCxIVuH+CI8
 2lDEuLyb8MJY3+8pEzSK8jOyyma8UVktBQ==
X-Google-Smtp-Source: APXvYqx6a52XkAU7Hos4vZ4hxo2wdMdSyPQsrEAeXNo60lpDQoEogfJJvSN+DMbdVYtzXApwJHi7lg==
X-Received: by 2002:adf:f382:: with SMTP id m2mr3333702wro.163.1579271303589; 
 Fri, 17 Jan 2020 06:28:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] hw/arm: Add the STM32F4xx SoC
Date: Fri, 17 Jan 2020 14:28:04 +0000
Message-Id: <20200117142816.15110-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Alistair Francis <alistair@alistair23.me>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1d145c4c13e5fa140caf131232a6f524c88fcd72.1576658572.git.alistair@alistair23.me
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs           |   1 +
 include/hw/arm/stm32f405_soc.h |  73 ++++++++
 hw/arm/stm32f405_soc.c         | 302 +++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   8 +
 4 files changed, 384 insertions(+)
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 hw/arm/stm32f405_soc.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fe749f65fd7..d9d54da7cff 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -36,6 +36,7 @@ obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
+obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
new file mode 100644
index 00000000000..1fe97f8c3a3
--- /dev/null
+++ b/include/hw/arm/stm32f405_soc.h
@@ -0,0 +1,73 @@
+/*
+ * STM32F405 SoC
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_ARM_STM32F405_SOC_H
+#define HW_ARM_STM32F405_SOC_H
+
+#include "hw/misc/stm32f4xx_syscfg.h"
+#include "hw/timer/stm32f2xx_timer.h"
+#include "hw/char/stm32f2xx_usart.h"
+#include "hw/adc/stm32f2xx_adc.h"
+#include "hw/misc/stm32f4xx_exti.h"
+#include "hw/or-irq.h"
+#include "hw/ssi/stm32f2xx_spi.h"
+#include "hw/arm/armv7m.h"
+
+#define TYPE_STM32F405_SOC "stm32f405-soc"
+#define STM32F405_SOC(obj) \
+    OBJECT_CHECK(STM32F405State, (obj), TYPE_STM32F405_SOC)
+
+#define STM_NUM_USARTS 7
+#define STM_NUM_TIMERS 4
+#define STM_NUM_ADCS 6
+#define STM_NUM_SPIS 6
+
+#define FLASH_BASE_ADDRESS 0x08000000
+#define FLASH_SIZE (1024 * 1024)
+#define SRAM_BASE_ADDRESS 0x20000000
+#define SRAM_SIZE (192 * 1024)
+
+typedef struct STM32F405State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    char *cpu_type;
+
+    ARMv7MState armv7m;
+
+    STM32F4xxSyscfgState syscfg;
+    STM32F4xxExtiState exti;
+    STM32F2XXUsartState usart[STM_NUM_USARTS];
+    STM32F2XXTimerState timer[STM_NUM_TIMERS];
+    qemu_or_irq adc_irqs;
+    STM32F2XXADCState adc[STM_NUM_ADCS];
+    STM32F2XXSPIState spi[STM_NUM_SPIS];
+
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+} STM32F405State;
+
+#endif
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
new file mode 100644
index 00000000000..f22516fdf79
--- /dev/null
+++ b/hw/arm/stm32f405_soc.c
@@ -0,0 +1,302 @@
+/*
+ * STM32F405 SoC
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/misc/unimp.h"
+
+#define SYSCFG_ADD                     0x40013800
+static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
+                                       0x40004C00, 0x40005000, 0x40011400,
+                                       0x40007800, 0x40007C00 };
+/* At the moment only Timer 2 to 5 are modelled */
+static const uint32_t timer_addr[] = { 0x40000000, 0x40000400,
+                                       0x40000800, 0x40000C00 };
+#define ADC_ADDR                       0x40012000
+static const uint32_t spi_addr[] =   { 0x40013000, 0x40003800, 0x40003C00,
+                                       0x40013400, 0x40015000, 0x40015400 };
+#define EXTI_ADDR                      0x40013C00
+
+#define SYSCFG_IRQ               71
+static const int usart_irq[] = { 37, 38, 39, 52, 53, 71, 82, 83 };
+static const int timer_irq[] = { 28, 29, 30, 50 };
+#define ADC_IRQ 18
+static const int spi_irq[] =   { 35, 36, 51, 0, 0, 0 };
+static const int exti_irq[] =  { 6, 7, 8, 9, 10, 23, 23, 23, 23, 23, 40,
+                                 40, 40, 40, 40, 40} ;
+
+
+static void stm32f405_soc_initfn(Object *obj)
+{
+    STM32F405State *s = STM32F405_SOC(obj);
+    int i;
+
+    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
+                          TYPE_ARMV7M);
+
+    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
+                          TYPE_STM32F4XX_SYSCFG);
+
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
+                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
+    }
+
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
+                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
+    }
+
+    for (i = 0; i < STM_NUM_ADCS; i++) {
+        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
+                              TYPE_STM32F2XX_ADC);
+    }
+
+    for (i = 0; i < STM_NUM_SPIS; i++) {
+        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
+                              TYPE_STM32F2XX_SPI);
+    }
+
+    sysbus_init_child_obj(obj, "exti", &s->exti, sizeof(s->exti),
+                          TYPE_STM32F4XX_EXTI);
+}
+
+static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32F405State *s = STM32F405_SOC(dev_soc);
+    MemoryRegion *system_memory = get_system_memory();
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    Error *err = NULL;
+    int i;
+
+    memory_region_init_ram(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
+                           &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias",
+                             &s->flash, 0, FLASH_SIZE);
+
+    memory_region_set_readonly(&s->flash, true);
+    memory_region_set_readonly(&s->flash_alias, true);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    memory_region_init_ram(&s->sram, NULL, "STM32F405.sram", SRAM_SIZE,
+                           &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
+                                     "memory", &error_abort);
+    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* System configuration controller */
+    dev = DEVICE(&s->syscfg);
+    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, SYSCFG_ADD);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, SYSCFG_IRQ));
+
+    /* Attach UART (uses USART registers) and USART controllers */
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        dev = DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, usart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
+    }
+
+    /* Timer 2 to 5 */
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        dev = DEVICE(&(s->timer[i]));
+        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, timer_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
+    }
+
+    /* ADC device, the IRQs are ORed together */
+    object_initialize_child(OBJECT(s), "adc-orirq", &s->adc_irqs,
+                            sizeof(s->adc_irqs), TYPE_OR_IRQ,
+                            &err, NULL);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
+                            "num-lines", &err);
+    object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
+                          qdev_get_gpio_in(armv7m, ADC_IRQ));
+
+    dev = DEVICE(&(s->adc[i]));
+    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, ADC_ADDR);
+    sysbus_connect_irq(busdev, 0,
+                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
+
+    /* SPI devices */
+    for (i = 0; i < STM_NUM_SPIS; i++) {
+        dev = DEVICE(&(s->spi[i]));
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, spi_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
+    }
+
+    /* EXTI device */
+    dev = DEVICE(&s->exti);
+    object_property_set_bool(OBJECT(&s->exti), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+    for (i = 0; i < 16; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+    for (i = 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
+    }
+
+    create_unimplemented_device("timer[7]",    0x40001400, 0x400);
+    create_unimplemented_device("timer[12]",   0x40001800, 0x400);
+    create_unimplemented_device("timer[6]",    0x40001000, 0x400);
+    create_unimplemented_device("timer[13]",   0x40001C00, 0x400);
+    create_unimplemented_device("timer[14]",   0x40002000, 0x400);
+    create_unimplemented_device("RTC and BKP", 0x40002800, 0x400);
+    create_unimplemented_device("WWDG",        0x40002C00, 0x400);
+    create_unimplemented_device("IWDG",        0x40003000, 0x400);
+    create_unimplemented_device("I2S2ext",     0x40003000, 0x400);
+    create_unimplemented_device("I2S3ext",     0x40004000, 0x400);
+    create_unimplemented_device("I2C1",        0x40005400, 0x400);
+    create_unimplemented_device("I2C2",        0x40005800, 0x400);
+    create_unimplemented_device("I2C3",        0x40005C00, 0x400);
+    create_unimplemented_device("CAN1",        0x40006400, 0x400);
+    create_unimplemented_device("CAN2",        0x40006800, 0x400);
+    create_unimplemented_device("PWR",         0x40007000, 0x400);
+    create_unimplemented_device("DAC",         0x40007400, 0x400);
+    create_unimplemented_device("timer[1]",    0x40010000, 0x400);
+    create_unimplemented_device("timer[8]",    0x40010400, 0x400);
+    create_unimplemented_device("SDIO",        0x40012C00, 0x400);
+    create_unimplemented_device("timer[9]",    0x40014000, 0x400);
+    create_unimplemented_device("timer[10]",   0x40014400, 0x400);
+    create_unimplemented_device("timer[11]",   0x40014800, 0x400);
+    create_unimplemented_device("GPIOA",       0x40020000, 0x400);
+    create_unimplemented_device("GPIOB",       0x40020400, 0x400);
+    create_unimplemented_device("GPIOC",       0x40020800, 0x400);
+    create_unimplemented_device("GPIOD",       0x40020C00, 0x400);
+    create_unimplemented_device("GPIOE",       0x40021000, 0x400);
+    create_unimplemented_device("GPIOF",       0x40021400, 0x400);
+    create_unimplemented_device("GPIOG",       0x40021800, 0x400);
+    create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
+    create_unimplemented_device("GPIOI",       0x40022000, 0x400);
+    create_unimplemented_device("CRC",         0x40023000, 0x400);
+    create_unimplemented_device("RCC",         0x40023800, 0x400);
+    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
+    create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
+    create_unimplemented_device("DMA1",        0x40026000, 0x400);
+    create_unimplemented_device("DMA2",        0x40026400, 0x400);
+    create_unimplemented_device("Ethernet",    0x40028000, 0x1400);
+    create_unimplemented_device("USB OTG HS",  0x40040000, 0x30000);
+    create_unimplemented_device("USB OTG FS",  0x50000000, 0x31000);
+    create_unimplemented_device("DCMI",        0x50050000, 0x400);
+    create_unimplemented_device("RNG",         0x50060800, 0x400);
+}
+
+static Property stm32f405_soc_properties[] = {
+    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32f405_soc_realize;
+    dc->props = stm32f405_soc_properties;
+    /* No vmstate or reset required: device has no internal state */
+}
+
+static const TypeInfo stm32f405_soc_info = {
+    .name          = TYPE_STM32F405_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F405State),
+    .instance_init = stm32f405_soc_initfn,
+    .class_init    = stm32f405_soc_class_init,
+};
+
+static void stm32f405_soc_types(void)
+{
+    type_register_static(&stm32f405_soc_info);
+}
+
+type_init(stm32f405_soc_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b425d030d8..cae53f5c146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -816,6 +816,14 @@ F: hw/adc/*
 F: hw/ssi/stm32f2xx_spi.c
 F: include/hw/*/stm32*.h
 
+STM32F405
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/stm32f405_soc.c
+F: hw/misc/stm32f4xx_syscfg.c
+F: hw/misc/stm32f4xx_exti.c
+
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


