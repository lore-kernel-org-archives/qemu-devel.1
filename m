Received: from eggs.gnu.org ([209.51.188.92]:47398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alnyan@airmail.cc>) id 1guftb-0006K5-O8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alnyan@airmail.cc>) id 1guftS-00048U-9p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:59:18 -0500
Date: Fri, 15 Feb 2019 17:59:20 +0200
From: Mark <alnyan@airmail.cc>
Message-ID: <20190215155919.GA10823@nyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [v4 PATCH] hw/arm/bcm2835_peripherals: add bcm283x arm
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "open list:Raspberry Pi" <qemu-arm@nongnu.org>

Signed-off-by: Mark <alnyan@airmail.cc>
---
 hw/arm/bcm2835_peripherals.c         |  17 ++
 hw/timer/Makefile.objs               |   2 +
 hw/timer/bcm283x_timer.c             | 271 +++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/timer/bcm283x_timer.h     |  50 +++++
 5 files changed, 342 insertions(+)
 create mode 100644 hw/timer/bcm283x_timer.c
 create mode 100644 include/hw/timer/bcm283x_timer.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6be7660e8c..e6d4d35496 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -117,6 +117,10 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
                                    OBJECT(&s->sdhost.sdbus), &error_abort);
+
+    /* SP804-alike ARM Timer */
+    sysbus_init_child_obj(obj, "bcm283x_timer", OBJECT(&s->bcm283x_timer),
+            sizeof(s->bcm283x_timer), TYPE_BCM283xTimer);
 }

 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -334,6 +338,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    /* SP804-alike ARM Timer */
+    object_property_set_bool(OBJECT(&s->bcm283x_timer), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ARMCTRL_TIMER0_1_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->bcm283x_timer), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->bcm283x_timer), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
+                               INTERRUPT_ARM_TIMER));
 }

 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f8..09a3706701 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -47,3 +47,5 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
+
+common-obj-$(CONFIG_RASPI) += bcm283x_timer.o
diff --git a/hw/timer/bcm283x_timer.c b/hw/timer/bcm283x_timer.c
new file mode 100644
index 0000000000..0f696ae61f
--- /dev/null
+++ b/hw/timer/bcm283x_timer.c
@@ -0,0 +1,271 @@
+/*
+ * Broadcom BCM283x ARM timer variant based on ARM SP804
+ * Copyright (c) 2019, Mark <alnyan@airmail.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/timer/bcm283x_timer.h"
+#include "qemu/main-loop.h"
+#include "qemu/log.h"
+
+#define TIMER_CTRL_32BIT            (1 << 1)
+#define TIMER_CTRL_DIV1             (0 << 2)
+#define TIMER_CTRL_DIV16            (1 << 2)
+#define TIMER_CTRL_DIV256           (2 << 2)
+#define TIMER_CTRL_IE               (1 << 5)
+#define TIMER_CTRL_ENABLE           (1 << 7)
+#define TIMER_CTRL_ENABLE_FREECNTR  (1 << 9)
+
+/* BCM283x's implementation of SP804 ARM timer */
+
+static void bcm283x_timer_set_irq(void *opaque, int irq, int level)
+{
+    BCM283xTimerState *s = BCM283xTimer(opaque);
+
+    s->int_level = level;
+    qemu_set_irq(s->irq, s->int_level);
+}
+
+static void bcm283x_timer_update(BCM283xTimerState *s)
+{
+    if (s->int_level && (s->control & TIMER_CTRL_IE)) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void bcm283x_timer_tick(void *opaque)
+{
+    BCM283xTimerState *s = BCM283xTimer(opaque);
+    s->int_level = 1;
+    bcm283x_timer_update(s);
+}
+
+static void bcm283x_free_timer_tick(void *opaque)
+{
+    /* Do nothing */
+}
+
+static uint64_t bcm283x_timer_read(void *opaque, hwaddr offset, unsigned size)
+{
+    BCM283xTimerState *s = BCM283xTimer(opaque);
+
+    switch (offset >> 2) {
+    case 0: /* Load register */
+    case 6: /* Reload register */
+        return s->limit;
+    case 1: /* Value register */
+        return ptimer_get_count(s->timer);
+    case 2: /* Control register */
+        return s->control;
+    case 3: /* IRQ clear/ACK register */
+        /*
+         * The register is write-only,
+         * but returns reverse "ARMT" string bytes
+         */
+        return 0x544D5241;
+    case 4: /* RAW IRQ register */
+        return s->int_level;
+    case 5: /* Masked IRQ register */
+        if ((s->control & TIMER_CTRL_IE) == 0) {
+            return 0;
+        }
+        return s->int_level;
+    case 8: /* Free-running counter */
+        return ptimer_get_count(s->free_timer);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset %x\n", __func__, (int) offset);
+        return 0;
+    }
+}
+
+static void bcm283x_timer_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    BCM283xTimerState *s = BCM283xTimer(opaque);
+    uint32_t freq, freecntr_freq;
+
+    switch (offset >> 2) {
+    case 0: /* Load register */
+        s->limit = value;
+        ptimer_set_limit(s->timer, s->limit, 1);
+        break;
+    case 1: /* Value register */
+        /* Read only */
+        break;
+    case 2: /* Control register */
+        if (s->control & TIMER_CTRL_ENABLE) {
+            ptimer_stop(s->timer);
+        }
+
+        s->control = value;
+
+        /* Configure SP804 */
+        freq = BCM283x_SYSTEM_CLOCK_FREQ / (s->prediv + 1);
+        /* Set pre-scaler */
+        switch ((value >> 2) & 3) {
+        case 1: /* 16 */
+            freq >>= 4;
+            break;
+        case 2: /* 256 */
+            freq >>= 8;
+            break;
+        }
+        ptimer_set_limit(s->timer, s->limit, s->control & TIMER_CTRL_ENABLE);
+        ptimer_set_freq(s->timer, freq);
+
+        /* Configure free-running counter */
+        freecntr_freq = BCM283x_SYSTEM_CLOCK_FREQ /
+            (1 + ((value >> 16) & 0xFF));
+        if (s->control & TIMER_CTRL_32BIT) {
+            ptimer_set_limit(s->free_timer, 0xFFFFFFFF,
+                    s->control & TIMER_CTRL_ENABLE_FREECNTR);
+        } else {
+            ptimer_set_limit(s->free_timer, 0xFFFF,
+                    s->control & TIMER_CTRL_ENABLE_FREECNTR);
+        }
+        ptimer_set_freq(s->free_timer, freecntr_freq);
+
+        if (s->control & TIMER_CTRL_ENABLE) {
+            ptimer_run(s->timer, 0);
+        } else {
+            ptimer_stop(s->free_timer);
+        }
+
+        if (s->control & TIMER_CTRL_ENABLE_FREECNTR) {
+            ptimer_run(s->free_timer, 0);
+        } else {
+            ptimer_stop(s->free_timer);
+        }
+        break;
+    case 3: /* IRQ clear/ACK register */
+        s->int_level = 0;
+        break;
+    case 6: /* Reload register */
+        s->limit = value;
+        ptimer_set_limit(s->timer, s->limit, 0);
+        break;
+    case 7: /* Pre-divider register */
+        s->prediv = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset %x\n", __func__, (int) offset);
+        break;
+    }
+
+    bcm283x_timer_update(s);
+}
+
+static const MemoryRegionOps bcm283x_timer_ops = {
+    .read = bcm283x_timer_read,
+    .write = bcm283x_timer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN
+};
+
+static const VMStateDescription vmstate_bcm283x_timer = {
+    .name = "bcm283x_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, BCM283xTimerState),
+        VMSTATE_UINT32(limit, BCM283xTimerState),
+        VMSTATE_UINT32(int_level, BCM283xTimerState),
+        VMSTATE_PTIMER(timer, BCM283xTimerState),
+        VMSTATE_PTIMER(free_timer, BCM283xTimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm283x_timer_init(Object *obj)
+{
+    BCM283xTimerState *s = BCM283xTimer(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm283x_timer_ops, s,
+            TYPE_BCM283xTimer, 0x100);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void bcm283x_timer_reset(DeviceState *dev)
+{
+    BCM283xTimerState *s = BCM283xTimer(dev);
+
+    s->limit = 0;
+    s->int_level = 0;
+    s->control = TIMER_CTRL_IE | (0x0E << 16);
+    s->prediv = 0x7D;
+
+    /*
+     * Stop the timers.
+     * No need to update freqs/limits as this will automatically be done once
+     * the system writes control register.
+     */
+    ptimer_stop(s->timer);
+    ptimer_stop(s->free_timer);
+}
+
+static void bcm283x_timer_realize(DeviceState *dev, Error **errp)
+{
+    BCM283xTimerState *s = BCM283xTimer(dev);
+    QEMUBH *bh;
+
+    s->limit = 0;
+    s->int_level = 0;
+    s->control = TIMER_CTRL_IE | (0x0E << 16);
+    s->prediv = 0x7D;
+
+    /* Create a regular SP804 timer */
+    bh = qemu_bh_new(bcm283x_timer_tick, s);
+    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->irq = qemu_allocate_irq(bcm283x_timer_set_irq, s, 0);
+
+    /* Create a free-running timer */
+    bh = qemu_bh_new(bcm283x_free_timer_tick, s);
+    s->free_timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+
+    vmstate_register(NULL, -1, &vmstate_bcm283x_timer, s);
+}
+
+static void bcm283x_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->realize = bcm283x_timer_realize;
+    k->vmsd = &vmstate_bcm283x_timer;
+    k->reset = bcm283x_timer_reset;
+}
+
+static const TypeInfo bcm283x_timer_info = {
+    .name           = TYPE_BCM283xTimer,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(BCM283xTimerState),
+    .instance_init  = bcm283x_timer_init,
+    .class_init     = bcm283x_timer_class_init
+};
+
+static void bcm283x_timer_register_types(void)
+{
+    type_register_static(&bcm283x_timer_info);
+}
+
+type_init(bcm283x_timer_register_types)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index f5b193f670..bbe01d1500 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -23,6 +23,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/timer/bcm283x_timer.h"

 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 #define BCM2835_PERIPHERALS(obj) \
@@ -48,6 +49,7 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    BCM283xTimerState bcm283x_timer;
 } BCM2835PeripheralState;

 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/timer/bcm283x_timer.h b/include/hw/timer/bcm283x_timer.h
new file mode 100644
index 0000000000..99d0ae0f61
--- /dev/null
+++ b/include/hw/timer/bcm283x_timer.h
@@ -0,0 +1,50 @@
+/*
+ * Broadcom BCM283x ARM timer variant based on ARM SP804
+ * Copyright (c) 2019, Mark <alnyan@airmail.cc>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HW_TIMER_BCM2835_TIMER_H
+#define HW_TIMER_BCM2835_TIMER_H
+
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+
+/*
+ * The datasheet stated 252MHz is the system clock value after reset,
+ *  but it may be changed either by device going to sleep mode or
+ *  by kernel configuration
+ */
+#define BCM283x_SYSTEM_CLOCK_FREQ       252000000
+
+#define TYPE_BCM283xTimer "bcm283x_timer"
+#define BCM283xTimer(obj) \
+    OBJECT_CHECK(BCM283xTimerState, (obj), TYPE_BCM283xTimer)
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    qemu_irq irq;
+
+    uint32_t control;
+    uint32_t limit;
+    uint32_t int_level;
+    uint32_t prediv;
+
+    ptimer_state *timer;
+    ptimer_state *free_timer;
+} BCM283xTimerState;
+
+#endif
--
2.20.1
