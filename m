Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C4C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B292E206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="EEeWfJjs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NS9gHbMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B292E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67UD-0003uL-JT
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67Sk-0002Zw-94
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67Si-0003pS-Cy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67Si-0003pF-9F
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:12 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 01E9021E92;
 Fri,  6 Sep 2019 02:11:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=A6gz0ZUoFNZAQ
 lR8LrbXQMO9D2Q4JImqJgfM8Qt9LpI=; b=EEeWfJjsxpGavpWVUf/OAF3xZWwYp
 w9inRc+eLdV5M/Bf+7fNwwYOuShy7XV1VSJCV0KoSzjpYoOPp/dHjEmqwk+z1mng
 Y4e/ykat/tU66YZBYCKxOiQtSYWU1rMfMTr4HG1ap11J+UPbZIX0KgZAkaoWgHKH
 2Pu1PyfRclAc8KFoUigkkIG7crauzEd0yxYxUKWpu5IEjLH6eLKdL2viuESFkHLJ
 b1M+IR7nm1wgUtrqxwAb14N26NofsYsYjnx2KkPzTqVYvBIOxwbb5I9FUzoBkaBR
 cQ53P/VlazaffI449FWlrJzPSEGZHcOq4CojIE3qoQNfmYBD1SbP+tDAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=A6gz0ZUoFNZAQlR8LrbXQMO9D2Q4JImqJgfM8Qt9LpI=; b=NS9gHbMJ
 D8pZtIzbB2rLCMAyHshjpFIHMoV49T03XD2m6n808KfghTKrzISg7uqNWR/D+Np0
 StrBEeWK799r3RI6rHTD+8130tnFDojn0xwX87NrxNDfUi4KQwbIvfgLa7K82lDw
 /Y4G1w4JSQQSZocu4t+AbVmMW1xeHd0J5FAs8tZLInqy/rwj6sEroAT5D6HWa5+0
 wqbiSs/5qZeEW5JNEVA70BWx4iXWfOwjro73PFlP7dM4hdMOuJZnzCY92S3/6dBa
 JuQuuWy8nb/AymOp5vHH/m941lse1ZgiqmdzOxJ+vo8v3UB62Vi47uLs93k+XbT7
 NR05LmA+8nWgwQ==
X-ME-Sender: <xms:f_hxXZaaplESN3Dz7vOtKaonXq40AdxmSNQ6M4zADRSWueixNahNsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:f_hxXcMdbB0dnAS3FQK93tx6m72uvGCl6Cv2uDnF3aF5RkEOhHu_Rw>
 <xmx:f_hxXRccEBOlbkhhBH3mHlqlPfaW5xFaqjYLQZhLMjBuEUs_qXTn1Q>
 <xmx:f_hxXaG7SOS81ATkg69RT6MDK5bnPRQ8GJ_1h0Yy8nubjXh2F8_GGw>
 <xmx:f_hxXSUoPOhv-b4RRHc-PbKCGpgiTiThnSAOFPA4tK02O4KWdLpAiQ>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4FF10D6005D;
 Fri,  6 Sep 2019 02:11:11 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:11:10 -0700
Message-Id: <d0c3963c40fd93e2f53a1fd546df33ee02af92b2.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
References: <cover.1567750222.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 4/6] hw/misc: Add the STM32F4xx EXTI device
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
 hw/arm/Kconfig                   |   1 +
 hw/misc/Kconfig                  |   3 +
 hw/misc/Makefile.objs            |   1 +
 hw/misc/stm32f4xx_exti.c         | 187 +++++++++++++++++++++++++++++++
 hw/misc/trace-events             |   5 +
 include/hw/misc/stm32f4xx_exti.h |  60 ++++++++++
 6 files changed, 257 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 include/hw/misc/stm32f4xx_exti.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9019c9fa50..68a3b27685 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -311,6 +311,7 @@ config STM32F405_SOC
     bool
     select ARM_V7M
     select STM32F4XX_SYSCFG
+    select STM32F4XX_EXTI
 
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b9097ab2e0..fa56e5d375 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -85,6 +85,9 @@ config STM32F2XX_SYSCFG
 config STM32F4XX_SYSCFG
     bool
 
+config STM32F4XX_EXTI
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 51da9abf2a..fdceae0c51 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 obj-$(CONFIG_ZYNQ) += zynq-xadc.o
 obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
 obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
+obj-$(CONFIG_STM32F4XX_EXTI) += stm32f4xx_exti.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
new file mode 100644
index 0000000000..04ac82ae26
--- /dev/null
+++ b/hw/misc/stm32f4xx_exti.c
@@ -0,0 +1,187 @@
+/*
+ * STM32F4XX EXTI
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
+#include "hw/misc/stm32f4xx_exti.h"
+
+static void stm32f4xx_exti_reset(DeviceState *dev)
+{
+    STM32F4xxExtiState *s = STM32F4XX_EXTI(dev);
+
+    s->exti_imr = 0x00000000;
+    s->exti_emr = 0x00000000;
+    s->exti_rtsr = 0x00000000;
+    s->exti_ftsr = 0x00000000;
+    s->exti_swier = 0x00000000;
+    s->exti_pr = 0x00000000;
+}
+
+static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxExtiState *s = opaque;
+
+    if (!((1 << irq) & s->exti_imr)) {
+        /* Interrupt is masked */
+        return;
+    }
+
+    trace_stm32f4xx_exti_set_irq(irq, level);
+
+    if (((1 << irq) & s->exti_rtsr) && level) {
+        /* Rising Edge */
+        qemu_irq_pulse(s->irq[irq]);
+        s->exti_pr |= 1 << irq;
+    }
+
+    if (((1 << irq) & s->exti_ftsr) && !level) {
+        /* Falling Edge */
+        qemu_irq_pulse(s->irq[irq]);
+        s->exti_pr |= 1 << irq;
+    }
+}
+
+static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxExtiState *s = opaque;
+
+    trace_stm32f4xx_exti_read(addr);
+
+    switch (addr) {
+    case EXTI_IMR:
+        return s->exti_imr;
+    case EXTI_EMR:
+        return s->exti_emr;
+    case EXTI_RTSR:
+        return s->exti_rtsr;
+    case EXTI_FTSR:
+        return s->exti_ftsr;
+    case EXTI_SWIER:
+        return s->exti_swier;
+    case EXTI_PR:
+        return s->exti_pr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_read: Bad offset %x\n", (int)addr);
+        return 0;
+    }
+    return 0;
+}
+
+static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxExtiState *s = opaque;
+    uint32_t value = (uint32_t) val64;
+
+    trace_stm32f4xx_exti_write(addr, value);
+
+    switch (addr) {
+    case EXTI_IMR:
+        s->exti_imr = value;
+        return;
+    case EXTI_EMR:
+        s->exti_emr = value;
+        return;
+    case EXTI_RTSR:
+        s->exti_rtsr = value;
+        return;
+    case EXTI_FTSR:
+        s->exti_ftsr = value;
+        return;
+    case EXTI_SWIER:
+        s->exti_swier = value;
+        return;
+    case EXTI_PR:
+        /* This bit is cleared by writing a 1 to it */
+        s->exti_pr &= ~value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_write: Bad offset %x\n", (int)addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_exti_ops = {
+    .read = stm32f4xx_exti_read,
+    .write = stm32f4xx_exti_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_exti_init(Object *obj)
+{
+    STM32F4xxExtiState *s = STM32F4XX_EXTI(obj);
+    int i;
+
+    for (i = 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
+                          TYPE_STM32F4XX_EXTI, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
+                      NUM_GPIO_EVENT_IN_LINES);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_exti = {
+    .name = TYPE_STM32F4XX_EXTI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(exti_imr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_emr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_rtsr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_ftsr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_swier, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_pr, STM32F4xxExtiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = stm32f4xx_exti_reset;
+    dc->vmsd = &vmstate_stm32f4xx_exti;
+}
+
+static const TypeInfo stm32f4xx_exti_info = {
+    .name          = TYPE_STM32F4XX_EXTI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4xxExtiState),
+    .instance_init = stm32f4xx_exti_init,
+    .class_init    = stm32f4xx_exti_class_init,
+};
+
+static void stm32f4xx_exti_register_types(void)
+{
+    type_register_static(&stm32f4xx_exti_info);
+}
+
+type_init(stm32f4xx_exti_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 3643949515..b7b9582e66 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,11 @@ stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
 stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
+# stm32f4xx_exti
+stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
+stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx_exti.h
new file mode 100644
index 0000000000..707036a41b
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_exti.h
@@ -0,0 +1,60 @@
+/*
+ * STM32F4XX EXTI
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
+#ifndef HW_STM_EXTI_H
+#define HW_STM_EXTI_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define EXTI_IMR   0x00
+#define EXTI_EMR   0x04
+#define EXTI_RTSR  0x08
+#define EXTI_FTSR  0x0C
+#define EXTI_SWIER 0x10
+#define EXTI_PR    0x14
+
+#define TYPE_STM32F4XX_EXTI "stm32f4xx-exti"
+#define STM32F4XX_EXTI(obj) \
+    OBJECT_CHECK(STM32F4xxExtiState, (obj), TYPE_STM32F4XX_EXTI)
+
+#define NUM_GPIO_EVENT_IN_LINES 16
+#define NUM_INTERRUPT_OUT_LINES 16
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t exti_imr;
+    uint32_t exti_emr;
+    uint32_t exti_rtsr;
+    uint32_t exti_ftsr;
+    uint32_t exti_swier;
+    uint32_t exti_pr;
+
+    qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
+} STM32F4xxExtiState;
+
+#endif
-- 
2.22.0


