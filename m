Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B4CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642DA206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="gcqGrq0R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpMZdlmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642DA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67Ww-0006SK-2j
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67Sj-0002YW-3l
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67Se-0003o7-OQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46821)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67Se-0003o1-Kc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:08 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 6AFE120C69;
 Fri,  6 Sep 2019 02:11:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=cOgnpOfvQPsN6
 W9VVXd3/B3A86abk0Qphe91beA5Ufs=; b=gcqGrq0RAi9LBYv9Ci73f+lzRGG8n
 iMpSfqTeX87/SHC6I8gH3M7tEgj8OBieSmsx1bFC9gyxCyyzFCAEycIwZKNtMN8x
 uuP6E+9iG+DvG96j4kjcK3CmhLg2Ihe48XWcC4x6qTlbUiQ3DSTNPCP3WFIkn+ir
 TZ3boOyASNpD9ZYpOJQbIAEZStfqU1VmbZpXGnHiN54P5oyU74MkiCOSOjMF89lA
 lZh2rqZEeli9Ixz6g44rTpZoxi0Ps1LAoN1NZCU657VYNTPbI6vV5JFkGpOUcEl/
 OQiktVfchk/jWRRNM8UiyAX77QCLVs/h45PBOrb2xJPcLxXP9ux7Z/gJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=cOgnpOfvQPsN6W9VVXd3/B3A86abk0Qphe91beA5Ufs=; b=BpMZdlmr
 cXj2pggsbgLBVIX/krwSxv98ST9Kxw0eobe59zXK5wKu+BcUMnDWpaJd7mV5eznT
 HXHl8o8CuxD1AlJ/6Ggvm+OYy9FckyH2dF90j7IG4ebBkNT/xLT4sY1anDKv8042
 PHQPHY8hG53a6/cqul5qPZ1UGx56WIYCARJaZgaYLk5DWARW6lJWLm0d9bciemU6
 6hXUbncIxFOQ1ZY7dqFo6FH1RIF+vYsmAwLaJdSK6R+dugtKHtlyGG25ceE4EBBK
 KSpfKaddZVquqvUWd7HBhtV2Oik/E4qY/MPF0gLgTLvnDWCb8HSQJ1kp1bc7jMoc
 0/51g6jGQuvw/Q==
X-ME-Sender: <xms:fPhxXZ98x71Rqvv0OZ83zfUG0L5GkNblQBtabkdO161IyVweJWbTpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fPhxXeygK7TLdJoyoUr-LpRFJpUAdcQfkDW3WF7T2RVTKUrjGVXD6A>
 <xmx:fPhxXZ9hPyFzJDeMI3MGhoCVZo9NoN9YnI-_9xH0YZL7du_fy3U4wQ>
 <xmx:fPhxXbKwH00aXZadmtPc6IeoXB1uad2PfGkCLydbtsuJT-7kFZUC0A>
 <xmx:fPhxXdTL0zJstufkcbW4lEFdcJk8veYH9rks85xEele1h9xHd9nAVQ>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id BBC87D6005D;
 Fri,  6 Sep 2019 02:11:07 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:11:07 -0700
Message-Id: <e38e3fdfbffda65236f2a1c9545ad3c296d802cf.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
References: <cover.1567750222.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 3/6] hw/misc: Add the STM32F4xx Sysconfig
 device
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 default-configs/arm-softmmu.mak    |   1 +
 hw/arm/Kconfig                     |   9 ++
 hw/misc/Kconfig                    |   3 +
 hw/misc/Makefile.objs              |   1 +
 hw/misc/stm32f4xx_syscfg.c         | 168 +++++++++++++++++++++++++++++
 hw/misc/trace-events               |   6 ++
 include/hw/misc/stm32f4xx_syscfg.h |  61 +++++++++++
 7 files changed, 249 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1f2e0e7fde..645e6201bb 100644
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
index 76a2a6bcbf..9019c9fa50 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -97,6 +97,10 @@ config NETDUINO2
     bool
     select STM32F205_SOC
 
+config NETDUINOPLUS2
+    bool
+    select STM32F405_SOC
+
 config NSERIES
     bool
     select OMAP
@@ -303,6 +307,11 @@ config STM32F205_SOC
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
index 51754bb47c..b9097ab2e0 100644
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
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index e4aad707fb..51da9abf2a 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -57,6 +57,7 @@ obj-$(CONFIG_SLAVIO) += slavio_misc.o
 obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 obj-$(CONFIG_ZYNQ) += zynq-xadc.o
 obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
+obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
new file mode 100644
index 0000000000..b34fb34885
--- /dev/null
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -0,0 +1,168 @@
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
+       qemu_set_irq(s->gpio_out[irq], level);
+       trace_stm32f4xx_pulse_exti(irq);
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
+        VMSTATE_UINT32_ARRAY(syscfg_exticr, STM32F4xxSyscfgState, SYSCFG_NUM_EXTICR),
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
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c1ea1aa437..3643949515 100644
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
diff --git a/include/hw/misc/stm32f4xx_syscfg.h b/include/hw/misc/stm32f4xx_syscfg.h
new file mode 100644
index 0000000000..c62c6629e5
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
-- 
2.22.0


