Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUK-0003wl-L5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUI-0005bg-SE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUI-0005PL-Eg
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUH-0003C1-5z
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:05 +0100
Message-Id: <20180820103212.2810-19-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/25] hw/watchdog/cmsdk_apb_watchdog: Implement
 CMSDK APB watchdog module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Arm Cortex-M System Design Kit includes a simple watchdog module
based on a 32-bit down-counter. Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile.objs                            |   1 +
 hw/watchdog/Makefile.objs                |   1 +
 include/hw/watchdog/cmsdk-apb-watchdog.h |  59 ++++
 hw/watchdog/cmsdk-apb-watchdog.c         | 326 +++++++++++++++++++++++
 MAINTAINERS                              |   2 +
 default-configs/arm-softmmu.mak          |   1 +
 hw/watchdog/trace-events                 |   6 +
 7 files changed, 396 insertions(+)
 create mode 100644 include/hw/watchdog/cmsdk-apb-watchdog.h
 create mode 100644 hw/watchdog/cmsdk-apb-watchdog.c
 create mode 100644 hw/watchdog/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 7a9828da282..ce9c79235e6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -240,6 +240,7 @@ trace-events-subdirs += hw/tpm
 trace-events-subdirs += hw/usb
 trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/virtio
+trace-events-subdirs += hw/watchdog
 trace-events-subdirs += hw/xen
 trace-events-subdirs += io
 trace-events-subdirs += linux-user
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 9589bed63a3..3f536d1cad8 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y += watchdog.o
+common-obj-$(CONFIG_CMSDK_APB_WATCHDOG) += cmsdk-apb-watchdog.o
 common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
new file mode 100644
index 00000000000..ab8b5987a19
--- /dev/null
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -0,0 +1,59 @@
+/*
+ * ARM CMSDK APB watchdog emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the "APB watchdog" which is part of the Cortex-M
+ * System Design Kit (CMSDK) and documented in the Cortex-M System
+ * Design Kit Technical Reference Manual (ARM DDI0479C):
+ * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ *
+ * QEMU interface:
+ *  + QOM property "wdogclk-frq": frequency at which the watchdog is clocked
+ *  + sysbus MMIO region 0: the register bank
+ *  + sysbus IRQ 0: watchdog interrupt
+ *
+ * In real hardware the watchdog's reset output is just a GPIO line
+ * which can then be masked by the board or treated as a simple interrupt.
+ * (For instance the IoTKit does this with the non-secure watchdog, so that
+ * secure code can control whether non-secure code can perform a system
+ * reset via its watchdog.) In QEMU, we just wire up the watchdog reset
+ * to watchdog_perform_action(), at least for the moment.
+ */
+
+#ifndef CMSDK_APB_WATCHDOG_H
+#define CMSDK_APB_WATCHDOG_H
+
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+
+#define TYPE_CMSDK_APB_WATCHDOG "cmsdk-apb-watchdog"
+#define CMSDK_APB_WATCHDOG(obj) OBJECT_CHECK(CMSDKAPBWatchdog, (obj), \
+                                              TYPE_CMSDK_APB_WATCHDOG)
+
+typedef struct CMSDKAPBWatchdog {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq wdogint;
+    uint32_t wdogclk_frq;
+    struct ptimer_state *timer;
+
+    uint32_t control;
+    uint32_t intstatus;
+    uint32_t lock;
+    uint32_t itcr;
+    uint32_t itop;
+    uint32_t resetstatus;
+} CMSDKAPBWatchdog;
+
+#endif
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
new file mode 100644
index 00000000000..eb79a73fa6c
--- /dev/null
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -0,0 +1,326 @@
+/*
+ * ARM CMSDK APB watchdog emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the "APB watchdog" which is part of the Cortex-M
+ * System Design Kit (CMSDK) and documented in the Cortex-M System
+ * Design Kit Technical Reference Manual (ARM DDI0479C):
+ * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/watchdog.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
+
+REG32(WDOGLOAD, 0x0)
+REG32(WDOGVALUE, 0x4)
+REG32(WDOGCONTROL, 0x8)
+    FIELD(WDOGCONTROL, INTEN, 0, 1)
+    FIELD(WDOGCONTROL, RESEN, 1, 1)
+#define R_WDOGCONTROL_VALID_MASK (R_WDOGCONTROL_INTEN_MASK | \
+                                  R_WDOGCONTROL_RESEN_MASK)
+REG32(WDOGINTCLR, 0xc)
+REG32(WDOGRIS, 0x10)
+    FIELD(WDOGRIS, INT, 0, 1)
+REG32(WDOGMIS, 0x14)
+REG32(WDOGLOCK, 0xc00)
+#define WDOG_UNLOCK_VALUE 0x1ACCE551
+REG32(WDOGITCR, 0xf00)
+    FIELD(WDOGITCR, ENABLE, 0, 1)
+#define R_WDOGITCR_VALID_MASK R_WDOGITCR_ENABLE_MASK
+REG32(WDOGITOP, 0xf04)
+    FIELD(WDOGITOP, WDOGRES, 0, 1)
+    FIELD(WDOGITOP, WDOGINT, 1, 1)
+#define R_WDOGITOP_VALID_MASK (R_WDOGITOP_WDOGRES_MASK | \
+                               R_WDOGITOP_WDOGINT_MASK)
+REG32(PID4, 0xfd0)
+REG32(PID5, 0xfd4)
+REG32(PID6, 0xfd8)
+REG32(PID7, 0xfdc)
+REG32(PID0, 0xfe0)
+REG32(PID1, 0xfe4)
+REG32(PID2, 0xfe8)
+REG32(PID3, 0xfec)
+REG32(CID0, 0xff0)
+REG32(CID1, 0xff4)
+REG32(CID2, 0xff8)
+REG32(CID3, 0xffc)
+
+/* PID/CID values */
+static const int watchdog_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x24, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
+static bool cmsdk_apb_watchdog_intstatus(CMSDKAPBWatchdog *s)
+{
+    /* Return masked interrupt status */
+    return s->intstatus && (s->control & R_WDOGCONTROL_INTEN_MASK);
+}
+
+static bool cmsdk_apb_watchdog_resetstatus(CMSDKAPBWatchdog *s)
+{
+    /* Return masked reset status */
+    return s->resetstatus && (s->control & R_WDOGCONTROL_RESEN_MASK);
+}
+
+static void cmsdk_apb_watchdog_update(CMSDKAPBWatchdog *s)
+{
+    bool wdogint;
+    bool wdogres;
+
+    if (s->itcr) {
+        wdogint = s->itop & R_WDOGITOP_WDOGINT_MASK;
+        wdogres = s->itop & R_WDOGITOP_WDOGRES_MASK;
+    } else {
+        wdogint = cmsdk_apb_watchdog_intstatus(s);
+        wdogres = cmsdk_apb_watchdog_resetstatus(s);
+    }
+
+    qemu_set_irq(s->wdogint, wdogint);
+    if (wdogres) {
+        watchdog_perform_action();
+    }
+}
+
+static uint64_t cmsdk_apb_watchdog_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_WDOGLOAD:
+        r = ptimer_get_limit(s->timer);
+        break;
+    case A_WDOGVALUE:
+        r = ptimer_get_count(s->timer);
+        break;
+    case A_WDOGCONTROL:
+        r = s->control;
+        break;
+    case A_WDOGRIS:
+        r = s->intstatus;
+        break;
+    case A_WDOGMIS:
+        r = cmsdk_apb_watchdog_intstatus(s);
+        break;
+    case A_WDOGLOCK:
+        r = s->lock;
+        break;
+    case A_WDOGITCR:
+        r = s->itcr;
+        break;
+    case A_PID4 ... A_CID3:
+        r = watchdog_id[(offset - A_PID4) / 4];
+        break;
+    case A_WDOGINTCLR:
+    case A_WDOGITOP:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB watchdog read: read of WO offset %x\n",
+                      (int)offset);
+        r = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB watchdog read: bad offset %x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    trace_cmsdk_apb_watchdog_read(offset, r, size);
+    return r;
+}
+
+static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(opaque);
+
+    trace_cmsdk_apb_watchdog_write(offset, value, size);
+
+    if (s->lock && offset != A_WDOGLOCK) {
+        /* Write access is disabled via WDOGLOCK */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB watchdog write: write to locked watchdog\n");
+        return;
+    }
+
+    switch (offset) {
+    case A_WDOGLOAD:
+        /*
+         * Reset the load value and the current count, and make sure
+         * we're counting.
+         */
+        ptimer_set_limit(s->timer, value, 1);
+        ptimer_run(s->timer, 0);
+        break;
+    case A_WDOGCONTROL:
+        s->control = value & R_WDOGCONTROL_VALID_MASK;
+        cmsdk_apb_watchdog_update(s);
+        break;
+    case A_WDOGINTCLR:
+        s->intstatus = 0;
+        ptimer_set_count(s->timer, ptimer_get_limit(s->timer));
+        cmsdk_apb_watchdog_update(s);
+        break;
+    case A_WDOGLOCK:
+        s->lock = (value != WDOG_UNLOCK_VALUE);
+        break;
+    case A_WDOGITCR:
+        s->itcr = value & R_WDOGITCR_VALID_MASK;
+        cmsdk_apb_watchdog_update(s);
+        break;
+    case A_WDOGITOP:
+        s->itop = value & R_WDOGITOP_VALID_MASK;
+        cmsdk_apb_watchdog_update(s);
+        break;
+    case A_WDOGVALUE:
+    case A_WDOGRIS:
+    case A_WDOGMIS:
+    case A_PID4 ... A_CID3:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB watchdog write: write to RO offset 0x%x\n",
+                      (int)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CMSDK APB watchdog write: bad offset 0x%x\n",
+                      (int)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps cmsdk_apb_watchdog_ops = {
+    .read = cmsdk_apb_watchdog_read,
+    .write = cmsdk_apb_watchdog_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void cmsdk_apb_watchdog_tick(void *opaque)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(opaque);
+
+    if (!s->intstatus) {
+        /* Count expired for the first time: raise interrupt */
+        s->intstatus = R_WDOGRIS_INT_MASK;
+    } else {
+        /* Count expired for the second time: raise reset and stop clock */
+        s->resetstatus = 1;
+        ptimer_stop(s->timer);
+    }
+    cmsdk_apb_watchdog_update(s);
+}
+
+static void cmsdk_apb_watchdog_reset(DeviceState *dev)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(dev);
+
+    trace_cmsdk_apb_watchdog_reset();
+    s->control = 0;
+    s->intstatus = 0;
+    s->lock = 0;
+    s->itcr = 0;
+    s->itop = 0;
+    s->resetstatus = 0;
+    /* Set the limit and the count */
+    ptimer_set_limit(s->timer, 0xffffffff, 1);
+    ptimer_run(s->timer, 0);
+}
+
+static void cmsdk_apb_watchdog_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cmsdk_apb_watchdog_ops,
+                          s, "cmsdk-apb-watchdog", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->wdogint);
+}
+
+static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(dev);
+    QEMUBH *bh;
+
+    if (s->wdogclk_frq == 0) {
+        error_setg(errp,
+                   "CMSDK APB watchdog: wdogclk-frq property must be set");
+        return;
+    }
+
+    bh = qemu_bh_new(cmsdk_apb_watchdog_tick, s);
+    s->timer = ptimer_init(bh,
+                           PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                           PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_set_freq(s->timer, s->wdogclk_frq);
+}
+
+static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
+    .name = "cmsdk-apb-watchdog",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PTIMER(timer, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(control, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(intstatus, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(lock, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(itcr, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(itop, CMSDKAPBWatchdog),
+        VMSTATE_UINT32(resetstatus, CMSDKAPBWatchdog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property cmsdk_apb_watchdog_properties[] = {
+    DEFINE_PROP_UINT32("wdogclk-frq", CMSDKAPBWatchdog, wdogclk_frq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cmsdk_apb_watchdog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = cmsdk_apb_watchdog_realize;
+    dc->vmsd = &cmsdk_apb_watchdog_vmstate;
+    dc->reset = cmsdk_apb_watchdog_reset;
+    dc->props = cmsdk_apb_watchdog_properties;
+}
+
+static const TypeInfo cmsdk_apb_watchdog_info = {
+    .name = TYPE_CMSDK_APB_WATCHDOG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CMSDKAPBWatchdog),
+    .instance_init = cmsdk_apb_watchdog_init,
+    .class_init = cmsdk_apb_watchdog_class_init,
+};
+
+static void cmsdk_apb_watchdog_register_types(void)
+{
+    type_register_static(&cmsdk_apb_watchdog_info);
+}
+
+type_init(cmsdk_apb_watchdog_register_types);
diff --git a/MAINTAINERS b/MAINTAINERS
index 70651f7da0f..6698a7e0f81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -456,6 +456,8 @@ F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
 F: hw/char/cmsdk-apb-uart.c
 F: include/hw/char/cmsdk-apb-uart.h
+F: hw/watchdog/cmsdk-apb-watchdog.c
+F: include/hw/watchdog/cmsdk-apb-watchdog.h
 F: hw/misc/tz-ppc.c
 F: include/hw/misc/tz-ppc.h
 F: hw/misc/tz-mpc.c
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 311584fd74e..a92bc34fb24 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -104,6 +104,7 @@ CONFIG_STM32F205_SOC=y
 
 CONFIG_CMSDK_APB_TIMER=y
 CONFIG_CMSDK_APB_UART=y
+CONFIG_CMSDK_APB_WATCHDOG=y
 
 CONFIG_MPS2_FPGAIO=y
 CONFIG_MPS2_SCC=y
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
new file mode 100644
index 00000000000..fee95847df0
--- /dev/null
+++ b/hw/watchdog/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/char/cmsdk_apb_watchdog.c
+cmsdk_apb_watchdog_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB watchdog read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_watchdog_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB watchdog write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_watchdog_reset(void) "CMSDK APB watchdog: reset"
-- 
2.18.0
