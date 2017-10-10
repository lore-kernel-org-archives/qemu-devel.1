Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.venries@gmail.com>) id 1e1tpU-0006LO-7R
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.venries@gmail.com>) id 1e1tpN-0004vU-O1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:40:12 -0400
From: =?UTF-8?q?Thomas=20Venri=C3=A8s?= <thomas.venries@gmail.com>
Date: Tue, 10 Oct 2017 14:39:57 +0200
Message-Id: <1507639197-31753-1-git-send-email-thomas.venries@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] bcm2835_systimer: add bcm2835 system timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

The BCM2835 System Timer is a memory-mapped
peripheral available on the BCM2835 used in the
Raspberry Pi. It features a 64-bit free-running
counter that runs at 1 MHz and four separate
"output compare registers" that can be used to schedule
interrupts.

Signed-off-by: Thomas Venriès <thomas.venries@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  21 ++++
 hw/timer/Makefile.objs               |   1 +
 hw/timer/bcm2835_systimer.c          | 187 +++++++++++++++++++++++++++++++++++
 hw/timer/trace-events                |   3 +
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/timer/bcm2835_systimer.h  |  35 +++++++
 6 files changed, 249 insertions(+)
 create mode 100644 hw/timer/bcm2835_systimer.c
 create mode 100644 include/hw/timer/bcm2835_systimer.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 12e0dd1..d6c02d0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -90,6 +90,11 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
     qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
 
+    /* System Timer */
+    object_initialize(&s->systimer, sizeof(s->systimer), TYPE_BCM2835_SYSTIMER);
+    object_property_add_child(obj, "systimer", OBJECT(&s->systimer), NULL);
+    qdev_set_parent_bus(DEVICE(&s->systimer), sysbus_get_default());
+
     /* Extended Mass Media Controller */
     object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
     object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
@@ -254,6 +259,22 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
 
+    /* System Timer */
+    object_property_set_bool(OBJECT(&s->systimer), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systimer), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systimer), 0,
+            qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                INTERRUPT_TIMER1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systimer), 1,
+            qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                INTERRUPT_TIMER3));
+
     /* Extended Mass Media Controller */
     object_property_set_int(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
                             &err);
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8c19eac..b5bbffc 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -29,6 +29,7 @@ obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
 obj-$(CONFIG_OMAP) += omap_gptimer.o
 obj-$(CONFIG_OMAP) += omap_synctimer.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
+obj-$(CONFIG_RASPI) += bcm2835_systimer.o
 obj-$(CONFIG_SH4) += sh_timer.o
 obj-$(CONFIG_DIGIC) += digic-timer.o
 obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
diff --git a/hw/timer/bcm2835_systimer.c b/hw/timer/bcm2835_systimer.c
new file mode 100644
index 0000000..449cb51
--- /dev/null
+++ b/hw/timer/bcm2835_systimer.c
@@ -0,0 +1,187 @@
+/*
+ * BCM2835 System Timer
+ *
+ * Copyright (C) 2017 Thomas Venriès <thomas.venries@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/timer.h"
+#include "trace.h"
+#include "hw/timer/bcm2835_systimer.h"
+
+#define ST_SIZE             0x20
+
+#define ST_CONTROL_STATUS   0x00
+#define ST_COUNTER_LO       0x04
+#define ST_COUNTER_HI       0x08
+#define ST_COMPARE0         0x0C
+#define ST_COMPARE1         0x10
+#define ST_COMPARE2         0x14
+#define ST_COMPARE3         0x18
+
+#define TIMER_M0        (1 << 0)
+#define TIMER_M1        (1 << 1)
+#define TIMER_M2        (1 << 2)
+#define TIMER_M3        (1 << 3)
+#define TIMER_MATCH(n)  (1 << n)
+
+static void bcm2835_systimer_interrupt(void *opaque, unsigned timer)
+{
+    BCM2835SysTimerState *s = (BCM2835SysTimerState *)opaque;
+
+    s->ctrl |= TIMER_MATCH(timer);
+    qemu_irq_raise((timer == 1) ? s->irq[0] : s->irq[1]);
+
+    trace_bcm2835_systimer_interrupt(timer);
+}
+
+static void bcm2835_systimer1_cb(void *opaque)
+{
+    bcm2835_systimer_interrupt(opaque, 1);
+}
+
+static void bcm2835_systimer3_cb(void *opaque)
+{
+    bcm2835_systimer_interrupt(opaque, 3);
+}
+
+static uint64_t bcm2835_systimer_read(void *opaque, hwaddr offset,
+                                   unsigned size)
+{
+    BCM2835SysTimerState *s = (BCM2835SysTimerState *)opaque;
+
+    switch (offset) {
+    case ST_CONTROL_STATUS:
+        return s->ctrl;
+    case ST_COUNTER_LO:
+        return (uint64_t)qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) & 0xffffffff;
+    case ST_COUNTER_HI:
+        return (uint64_t)qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) >> 32;
+    case ST_COMPARE0:
+        return s->cmp0;
+    case ST_COMPARE1:
+        return s->cmp1;
+    case ST_COMPARE2:
+        return s->cmp2;
+    case ST_COMPARE3:
+        return s->cmp3;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "bcm2835_systimer_read: Bad offset - [%x]\n",
+                      (int)offset);
+        return 0;
+    }
+}
+
+static void bcm2835_systimer_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    BCM2835SysTimerState *s = (BCM2835SysTimerState *)opaque;
+
+    switch (offset) {
+    case ST_CONTROL_STATUS:
+        if ((s->ctrl & TIMER_M1) && (value & TIMER_M1)) {
+            qemu_irq_lower(s->irq[0]);
+            s->ctrl &= ~TIMER_M1;
+        }
+        if ((s->ctrl & TIMER_M3) && (value & TIMER_M3)) {
+            qemu_irq_lower(s->irq[1]);
+            s->ctrl &= ~TIMER_M3;
+        }
+        break;
+    case ST_COMPARE0:
+        s->cmp0 = value;
+        break;
+    case ST_COMPARE1:
+        timer_mod(s->timers[0], value);
+        s->cmp1 = value;
+        break;
+    case ST_COMPARE2:
+        s->cmp2 = value;
+        break;
+    case ST_COMPARE3:
+        timer_mod(s->timers[1], value);
+        s->cmp3 = value;
+        break;
+
+    case ST_COUNTER_LO:
+    case ST_COUNTER_HI:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "bcm2835_systimer_write: Read-only offset %x\n",
+                      (int)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "bcm2835_systimer_write: Bad offset %x\n",
+                      (int)offset);
+    }
+}
+
+static const MemoryRegionOps bcm2835_systimer_ops = {
+    .read = bcm2835_systimer_read,
+    .write = bcm2835_systimer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_bcm2835_systimer = {
+    .name = TYPE_BCM2835_SYSTIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, BCM2835SysTimerState),
+        VMSTATE_UINT32(cmp0, BCM2835SysTimerState),
+        VMSTATE_UINT32(cmp1, BCM2835SysTimerState),
+        VMSTATE_UINT32(cmp2, BCM2835SysTimerState),
+        VMSTATE_UINT32(cmp3, BCM2835SysTimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_systimer_init(Object *obj)
+{
+    BCM2835SysTimerState *s = BCM2835_SYSTIMER(obj);
+
+    s->ctrl = 0;
+    s->cmp0 = s->cmp1 = s->cmp2 = s->cmp3 = 0;
+
+    s->timers[0] = timer_new_us(QEMU_CLOCK_VIRTUAL, bcm2835_systimer1_cb, s);
+    s->timers[1] = timer_new_us(QEMU_CLOCK_VIRTUAL, bcm2835_systimer3_cb, s);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_systimer_ops, s,
+                          TYPE_BCM2835_SYSTIMER, ST_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[1]);
+}
+
+static void bcm2835_systimer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "BCM2835 System Timer";
+    dc->vmsd = &vmstate_bcm2835_systimer;
+}
+
+static TypeInfo bcm2835_systimer_info = {
+    .name          = TYPE_BCM2835_SYSTIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835SysTimerState),
+    .class_init    = bcm2835_systimer_class_init,
+    .instance_init = bcm2835_systimer_init,
+};
+
+static void bcm2835_systimer_register_types(void)
+{
+    type_register_static(&bcm2835_systimer_info);
+}
+
+type_init(bcm2835_systimer_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 640722b..13c89b4 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -60,3 +60,6 @@ systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr
 cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
+
+# hw/timer/bcm2535_systimer.c
+bcm2835_systimer_interrupt(unsigned timer) "timer %u"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 122b286..70a369a 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -20,6 +20,7 @@
 #include "hw/intc/bcm2835_ic.h"
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
+#include "hw/timer/bcm2835_systimer.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
@@ -46,6 +47,7 @@ typedef struct BCM2835PeripheralState {
     BCM2835PropertyState property;
     BCM2835RngState rng;
     BCM2835MboxState mboxes;
+    BCM2835SysTimerState systimer;
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
diff --git a/include/hw/timer/bcm2835_systimer.h b/include/hw/timer/bcm2835_systimer.h
new file mode 100644
index 0000000..4086f23
--- /dev/null
+++ b/include/hw/timer/bcm2835_systimer.h
@@ -0,0 +1,35 @@
+/*
+ * BCM2835 System Timer
+ *
+ * Copyright (C) 2017 Thomas Venriès <thomas.venries@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2835_SYSTIMER_H
+#define BCM2835_SYSTIMER_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_SYSTIMER "bcm2835-systimer"
+#define BCM2835_SYSTIMER(obj) \
+        OBJECT_CHECK(BCM2835SysTimerState, (obj), TYPE_BCM2835_SYSTIMER)
+
+#define AVAILABLE_TIMERS    2
+
+typedef struct {
+    SysBusDevice bus;
+    MemoryRegion iomem;
+
+    QEMUTimer *timers[AVAILABLE_TIMERS];
+    qemu_irq irq[AVAILABLE_TIMERS];
+
+    uint32_t ctrl;
+    uint32_t cmp0;
+    uint32_t cmp1;
+    uint32_t cmp2;
+    uint32_t cmp3;
+} BCM2835SysTimerState;
+
+#endif
-- 
2.7.4
