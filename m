Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oe-0007tY-0I
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oc-0002E6-AH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Oc-0002Ci-01
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OX-0003Vs-Jw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:45:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:49 +0100
Message-Id: <1500295494-8991-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/18] hw/char/cmsdk-apb-timer: Implement CMSDK
 APB timer device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Implement a model of the simple timer device found in the CMSDK.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1500029487-14822-5-git-send-email-peter.maydell@linaro.org
---
 hw/timer/Makefile.objs             |   1 +
 include/hw/timer/cmsdk-apb-timer.h |  59 +++++++++
 hw/timer/cmsdk-apb-timer.c         | 253 +++++++++++++++++++++++++++++++++++++
 default-configs/arm-softmmu.mak    |   1 +
 hw/timer/trace-events              |   5 +
 5 files changed, 319 insertions(+)
 create mode 100644 include/hw/timer/cmsdk-apb-timer.h
 create mode 100644 hw/timer/cmsdk-apb-timer.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index dd6f27e..15cce1c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
 
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
+common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
new file mode 100644
index 0000000..f21686d
--- /dev/null
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -0,0 +1,59 @@
+/*
+ * ARM CMSDK APB timer emulation
+ *
+ * Copyright (c) 2017 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#ifndef CMSDK_APB_TIMER_H
+#define CMSDK_APB_TIMER_H
+
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+
+#define TYPE_CMSDK_APB_TIMER "cmsdk-apb-timer"
+#define CMSDK_APB_TIMER(obj) OBJECT_CHECK(CMSDKAPBTIMER, (obj), \
+                                         TYPE_CMSDK_APB_TIMER)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq timerint;
+    uint32_t pclk_frq;
+    struct ptimer_state *timer;
+
+    uint32_t ctrl;
+    uint32_t value;
+    uint32_t reload;
+    uint32_t intstatus;
+} CMSDKAPBTIMER;
+
+/**
+ * cmsdk_apb_timer_create - convenience function to create TYPE_CMSDK_APB_TIMER
+ * @addr: location in system memory to map registers
+ * @pclk_frq: frequency in Hz of the PCLK clock (used for calculating baud rate)
+ */
+static inline DeviceState *cmsdk_apb_timer_create(hwaddr addr,
+                                                 qemu_irq timerint,
+                                                 uint32_t pclk_frq)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, TYPE_CMSDK_APB_TIMER);
+    s = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_uint32(dev, "pclk-frq", pclk_frq);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(s, 0, addr);
+    sysbus_connect_irq(s, 0, timerint);
+    return dev;
+}
+
+#endif
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
new file mode 100644
index 0000000..9878746
--- /dev/null
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -0,0 +1,253 @@
+/*
+ * ARM CMSDK APB timer emulation
+ *
+ * Copyright (c) 2017 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* This is a model of the "APB timer" which is part of the Cortex-M
+ * System Design Kit (CMSDK) and documented in the Cortex-M System
+ * Design Kit Technical Reference Manual (ARM DDI0479C):
+ * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ *
+ * The hardware has an EXTIN input wire, which can be configured
+ * by the guest to act either as a 'timer enable' (timer does not run
+ * when EXTIN is low), or as a 'timer clock' (timer runs at frequency
+ * of EXTIN clock, not PCLK frequency). We don't model this.
+ *
+ * The documentation is not very clear about the exact behaviour;
+ * we choose to implement that the interrupt is triggered when
+ * the counter goes from 1 to 0, that the counter then holds at 0
+ * for one clock cycle before reloading from the RELOAD register,
+ * and that if the RELOAD register is 0 this does not cause an
+ * interrupt (as there is no further 1->0 transition).
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/timer/cmsdk-apb-timer.h"
+
+REG32(CTRL, 0)
+    FIELD(CTRL, EN, 0, 1)
+    FIELD(CTRL, SELEXTEN, 1, 1)
+    FIELD(CTRL, SELEXTCLK, 2, 1)
+    FIELD(CTRL, IRQEN, 3, 1)
+REG32(VALUE, 4)
+REG32(RELOAD, 8)
+REG32(INTSTATUS, 0xc)
+    FIELD(INTSTATUS, IRQ, 0, 1)
+REG32(PID4, 0xFD0)
+REG32(PID5, 0xFD4)
+REG32(PID6, 0xFD8)
+REG32(PID7, 0xFDC)
+REG32(PID0, 0xFE0)
+REG32(PID1, 0xFE4)
+REG32(PID2, 0xFE8)
+REG32(PID3, 0xFEC)
+REG32(CID0, 0xFF0)
+REG32(CID1, 0xFF4)
+REG32(CID2, 0xFF8)
+REG32(CID3, 0xFFC)
+
+/* PID/CID values */
+static const int timer_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x22, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
+static void cmsdk_apb_timer_update(CMSDKAPBTIMER *s)
+{
+    qemu_set_irq(s->timerint, !!(s->intstatus & R_INTSTATUS_IRQ_MASK));
+}
+
+static uint64_t cmsdk_apb_timer_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_CTRL:
+        r = s->ctrl;
+        break;
+    case A_VALUE:
+        r = ptimer_get_count(s->timer);
+        break;
+    case A_RELOAD:
+        r = ptimer_get_limit(s->timer);
+        break;
+    case A_INTSTATUS:
+        r = s->intstatus;
+        break;
+    case A_PID4 ... A_CID3:
+        r = timer_id[(offset - A_PID4) / 4];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB timer read: bad offset %x\n", (int) offset);
+        r = 0;
+        break;
+    }
+    trace_cmsdk_apb_timer_read(offset, r, size);
+    return r;
+}
+
+static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
+                                  unsigned size)
+{
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(opaque);
+
+    trace_cmsdk_apb_timer_write(offset, value, size);
+
+    switch (offset) {
+    case A_CTRL:
+        if (value & 6) {
+            /* Bits [1] and [2] enable using EXTIN as either clock or
+             * an enable line. We don't model this.
+             */
+            qemu_log_mask(LOG_UNIMP,
+                          "CMSDK APB timer: EXTIN input not supported\n");
+        }
+        s->ctrl = value & 0xf;
+        if (s->ctrl & R_CTRL_EN_MASK) {
+            ptimer_run(s->timer, 0);
+        } else {
+            ptimer_stop(s->timer);
+        }
+        break;
+    case A_RELOAD:
+        /* Writing to reload also sets the current timer value */
+        ptimer_set_limit(s->timer, value, 1);
+        break;
+    case A_VALUE:
+        ptimer_set_count(s->timer, value);
+        break;
+    case A_INTSTATUS:
+        /* Just one bit, which is W1C. */
+        value &= 1;
+        s->intstatus &= ~value;
+        cmsdk_apb_timer_update(s);
+        break;
+    case A_PID4 ... A_CID3:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB timer write: write to RO offset 0x%x\n",
+                      (int)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB timer write: bad offset 0x%x\n", (int) offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps cmsdk_apb_timer_ops = {
+    .read = cmsdk_apb_timer_read,
+    .write = cmsdk_apb_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void cmsdk_apb_timer_tick(void *opaque)
+{
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(opaque);
+
+    if (s->ctrl & R_CTRL_IRQEN_MASK) {
+        s->intstatus |= R_INTSTATUS_IRQ_MASK;
+        cmsdk_apb_timer_update(s);
+    }
+}
+
+static void cmsdk_apb_timer_reset(DeviceState *dev)
+{
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(dev);
+
+    trace_cmsdk_apb_timer_reset();
+    s->ctrl = 0;
+    s->intstatus = 0;
+    ptimer_stop(s->timer);
+    /* Set the limit and the count */
+    ptimer_set_limit(s->timer, 0, 1);
+}
+
+static void cmsdk_apb_timer_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cmsdk_apb_timer_ops,
+                          s, "cmsdk-apb-timer", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->timerint);
+}
+
+static void cmsdk_apb_timer_realize(DeviceState *dev, Error **errp)
+{
+    CMSDKAPBTIMER *s = CMSDK_APB_TIMER(dev);
+    QEMUBH *bh;
+
+    if (s->pclk_frq == 0) {
+        error_setg(errp, "CMSDK APB timer: pclk-frq property must be set");
+        return;
+    }
+
+    bh = qemu_bh_new(cmsdk_apb_timer_tick, s);
+    s->timer = ptimer_init(bh,
+                           PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_set_freq(s->timer, s->pclk_frq);
+}
+
+static const VMStateDescription cmsdk_apb_timer_vmstate = {
+    .name = "cmsdk-apb-timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PTIMER(timer, CMSDKAPBTIMER),
+        VMSTATE_UINT32(ctrl, CMSDKAPBTIMER),
+        VMSTATE_UINT32(value, CMSDKAPBTIMER),
+        VMSTATE_UINT32(reload, CMSDKAPBTIMER),
+        VMSTATE_UINT32(intstatus, CMSDKAPBTIMER),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property cmsdk_apb_timer_properties[] = {
+    DEFINE_PROP_UINT32("pclk-frq", CMSDKAPBTIMER, pclk_frq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cmsdk_apb_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = cmsdk_apb_timer_realize;
+    dc->vmsd = &cmsdk_apb_timer_vmstate;
+    dc->reset = cmsdk_apb_timer_reset;
+    dc->props = cmsdk_apb_timer_properties;
+}
+
+static const TypeInfo cmsdk_apb_timer_info = {
+    .name = TYPE_CMSDK_APB_TIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CMSDKAPBTIMER),
+    .instance_init = cmsdk_apb_timer_init,
+    .class_init = cmsdk_apb_timer_class_init,
+};
+
+static void cmsdk_apb_timer_register_types(void)
+{
+    type_register_static(&cmsdk_apb_timer_info);
+}
+
+type_init(cmsdk_apb_timer_register_types);
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index d128e9d..c75f52c 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -96,6 +96,7 @@ CONFIG_STM32F2XX_ADC=y
 CONFIG_STM32F2XX_SPI=y
 CONFIG_STM32F205_SOC=y
 
+CONFIG_CMSDK_APB_TIMER=y
 CONFIG_CMSDK_APB_UART=y
 
 CONFIG_VERSATILE_PCI=y
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index d17cfe6..fd8196b 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -55,3 +55,8 @@ systick_reload(void) "systick reload"
 systick_timer_tick(void) "systick reload"
 systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
+# hw/char/cmsdk_apb_timer.c
+cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
-- 
2.7.4
