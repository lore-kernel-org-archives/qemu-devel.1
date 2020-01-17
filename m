Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA322072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2CEbQ1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA322072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSeN-0000Lu-NI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbo-000694-DR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbm-0006x4-DE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbm-0006wG-5i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id g17so22888091wro.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8L/sHDFwo4i09g6Pvt2MPaZEFrZG+pe79PZn44UrRAE=;
 b=y2CEbQ1rl5Sv3/aMvh2+VY8sLv7Soy7FKGra8YpxDq3IuBqzdK6fbWL53CPq5F8NqW
 eAjyRLhqjrRv+j6eI3lHxqRtqi3FADqO6o52FZVVfbBbrFj7TulvJ+fZo0JYFuPpmWge
 PWhQ9voO72s1BO/31cMV8d7Hyte5NEmodU4di69Q/Na+6SCuxUfz0YvNo33FRK9trFiQ
 gsaevGWYFbcrvECDLpamOujkW5q3cxQXGnwG5xxHIUckRN15StBAbrg0TMU0jgFpVJVC
 WMsVhge0CpR7gSa0YfVaB6MaixqmhRh4paKoufAXKrb9emePH7UvCIjCTfEkHa139LhN
 Ycyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8L/sHDFwo4i09g6Pvt2MPaZEFrZG+pe79PZn44UrRAE=;
 b=P+IOQks9CuygD0tbpN2NAIJ5jSsox6eyp4z79bTIo06Z30ps5GNpR1gZJ9ypXtUDAF
 gA0v8CpB90IYWWviDZcl1lHtthSlLyidp0DN6Aqkvkh8QkTTeHPYcAN0AF2GWJTocdz3
 iYhII1B/KrDAUtgECDeIoumlvGQZ6y8Kh9ao4j4qIRkeneZjtmteAMaiJin7dIbOWQRU
 3ddpFVoQh+BTI9gWrYwOXOj4RTy+x/o2au7bKbQMA8A/GfEU/Qd3YN/we3U2rRJo0Upu
 DoUnIVuKcIyU6uyx/aeHm6r15/lSuxZ+tySGYF2ErOdPtp+K5dNuf4XNhaXdXrTzE1Iw
 7H+w==
X-Gm-Message-State: APjAAAX13QKjhSJj0R2mqMwPuuG7zIphJyRa/sKkjO771q0W+/MYXmYV
 HZWcEqBod4lTPpMngyQSGZfpQ7diBu7NFA==
X-Google-Smtp-Source: APXvYqyTgsnF2e3sfjXT1E0YtaI/+jAXTiFoMjsE3ekIMeyg8xa372pCsVFInE+d8bA/w3b29ezOaA==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr3361026wru.122.1579271300485; 
 Fri, 17 Jan 2020 06:28:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] hw/misc: Add the STM32F4xx Sysconfig device
Date: Fri, 17 Jan 2020 14:28:02 +0000
Message-Id: <20200117142816.15110-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Message-id: 49b01423a09cef2ca832ff73a84a996568f1a8fc.1576658572.git.alistair@alistair23.me
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs              |   1 +
 include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 171 +++++++++++++++++++++++++++++
 default-configs/arm-softmmu.mak    |   1 +
 hw/arm/Kconfig                     |   9 ++
 hw/misc/Kconfig                    |   3 +
 hw/misc/trace-events               |   6 +
 7 files changed, 252 insertions(+)
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h
 create mode 100644 hw/misc/stm32f4xx_syscfg.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781a..ea8025e0bb1 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
 common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
+common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
diff --git a/include/hw/misc/stm32f4xx_syscfg.h b/include/hw/misc/stm32f4xx_syscfg.h
new file mode 100644
index 00000000000..c62c6629e54
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_syscfg.h
@@ -0,0 +1,61 @@
+/*
+ * STM32F4xx SYSCFG
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
+#ifndef HW_STM_SYSCFG_H
+#define HW_STM_SYSCFG_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define SYSCFG_MEMRMP  0x00
+#define SYSCFG_PMC     0x04
+#define SYSCFG_EXTICR1 0x08
+#define SYSCFG_EXTICR2 0x0C
+#define SYSCFG_EXTICR3 0x10
+#define SYSCFG_EXTICR4 0x14
+#define SYSCFG_CMPCR   0x20
+
+#define TYPE_STM32F4XX_SYSCFG "stm32f4xx-syscfg"
+#define STM32F4XX_SYSCFG(obj) \
+    OBJECT_CHECK(STM32F4xxSyscfgState, (obj), TYPE_STM32F4XX_SYSCFG)
+
+#define SYSCFG_NUM_EXTICR 4
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t syscfg_memrmp;
+    uint32_t syscfg_pmc;
+    uint32_t syscfg_exticr[SYSCFG_NUM_EXTICR];
+    uint32_t syscfg_cmpcr;
+
+    qemu_irq irq;
+    qemu_irq gpio_out[16];
+} STM32F4xxSyscfgState;
+
+#endif
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
new file mode 100644
index 00000000000..dbcdca59f8e
--- /dev/null
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -0,0 +1,171 @@
+/*
+ * STM32F4xx SYSCFG
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
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32f4xx_syscfg.h"
+
+static void stm32f4xx_syscfg_reset(DeviceState *dev)
+{
+    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(dev);
+
+    s->syscfg_memrmp = 0x00000000;
+    s->syscfg_pmc = 0x00000000;
+    s->syscfg_exticr[0] = 0x00000000;
+    s->syscfg_exticr[1] = 0x00000000;
+    s->syscfg_exticr[2] = 0x00000000;
+    s->syscfg_exticr[3] = 0x00000000;
+    s->syscfg_cmpcr = 0x00000000;
+}
+
+static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxSyscfgState *s = opaque;
+    int icrreg = irq / 4;
+    int startbit = (irq & 3) * 4;
+    uint8_t config = config = irq / 16;
+
+    trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
+
+    g_assert(icrreg < SYSCFG_NUM_EXTICR);
+
+    if (extract32(s->syscfg_exticr[icrreg], startbit, 4) == config) {
+        qemu_set_irq(s->gpio_out[irq], level);
+        trace_stm32f4xx_pulse_exti(irq);
+   }
+}
+
+static uint64_t stm32f4xx_syscfg_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxSyscfgState *s = opaque;
+
+    trace_stm32f4xx_syscfg_read(addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        return s->syscfg_memrmp;
+    case SYSCFG_PMC:
+        return s->syscfg_pmc;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        return s->syscfg_exticr[addr / 4 - SYSCFG_EXTICR1 / 4];
+    case SYSCFG_CMPCR:
+        return s->syscfg_cmpcr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        return 0;
+    }
+}
+
+static void stm32f4xx_syscfg_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxSyscfgState *s = opaque;
+    uint32_t value = val64;
+
+    trace_stm32f4xx_syscfg_write(value, addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the memory mapping isn't supported " \
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_PMC:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the memory mapping isn't supported " \
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        s->syscfg_exticr[addr / 4 - SYSCFG_EXTICR1 / 4] = (value & 0xFFFF);
+        return;
+    case SYSCFG_CMPCR:
+        s->syscfg_cmpcr = value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_syscfg_ops = {
+    .read = stm32f4xx_syscfg_read,
+    .write = stm32f4xx_syscfg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_syscfg_init(Object *obj)
+{
+    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_syscfg_ops, s,
+                          TYPE_STM32F4XX_SYSCFG, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq, 16 * 9);
+    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_syscfg = {
+    .name = TYPE_STM32F4XX_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(syscfg_memrmp, STM32F4xxSyscfgState),
+        VMSTATE_UINT32(syscfg_pmc, STM32F4xxSyscfgState),
+        VMSTATE_UINT32_ARRAY(syscfg_exticr, STM32F4xxSyscfgState,
+                             SYSCFG_NUM_EXTICR),
+        VMSTATE_UINT32(syscfg_cmpcr, STM32F4xxSyscfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = stm32f4xx_syscfg_reset;
+    dc->vmsd = &vmstate_stm32f4xx_syscfg;
+}
+
+static const TypeInfo stm32f4xx_syscfg_info = {
+    .name          = TYPE_STM32F4XX_SYSCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4xxSyscfgState),
+    .instance_init = stm32f4xx_syscfg_init,
+    .class_init    = stm32f4xx_syscfg_class_init,
+};
+
+static void stm32f4xx_syscfg_register_types(void)
+{
+    type_register_static(&stm32f4xx_syscfg_info);
+}
+
+type_init(stm32f4xx_syscfg_register_types)
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1f2e0e7fdeb..645e6201bb5 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -30,6 +30,7 @@ CONFIG_Z2=y
 CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
+CONFIG_NETDUINOPLUS2=y
 CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_DIGIC=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c6e77825803..4660d147156 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -101,6 +101,10 @@ config NETDUINO2
     bool
     select STM32F205_SOC
 
+config NETDUINOPLUS2
+    bool
+    select STM32F405_SOC
+
 config NSERIES
     bool
     select OMAP
@@ -307,6 +311,11 @@ config STM32F205_SOC
     select STM32F2XX_ADC
     select STM32F2XX_SPI
 
+config STM32F405_SOC
+    bool
+    select ARM_V7M
+    select STM32F4XX_SYSCFG
+
 config XLNX_ZYNQMP_ARM
     bool
     select AHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2164646553a..72609650b7a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -82,6 +82,9 @@ config IMX
 config STM32F2XX_SYSCFG
     bool
 
+config STM32F4XX_SYSCFG
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 2e0c8208349..44b4f72f57f 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -84,6 +84,12 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# stm32f4xx_syscfg
+stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
+stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
+stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
-- 
2.20.1


