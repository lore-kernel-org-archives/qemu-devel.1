Received: from eggs.gnu.org ([209.51.188.92]:54012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alnyan@airmail.cc>) id 1gsEoW-0000xb-J0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alnyan@airmail.cc>) id 1gsEoU-0003zG-Us
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:40:04 -0500
Date: Sat, 9 Feb 2019 00:40:20 +0200
From: Mark <alnyan@airmail.cc>
Message-ID: <20190208224020.GA4670@nyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] hw/arm/bcm2835_peripheral: add bcm283x
 sp804-alike timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-arm@nongnu.org

>From cf7dd33136c143d17c623e1a7277c1bf870b0863 Mon Sep 17 00:00:00 2001
From: Mark <alnyan@airmail.cc>
Date: Fri, 8 Feb 2019 16:48:34 +0200
Subject: [PATCH] hw/arm/bcm2835_peripheral: add bcm283x sp804-alike timer

Signed-off-by: Mark <alnyan@airmail.cc>
---
 hw/arm/bcm2835_peripherals.c         |  15 ++
 hw/timer/Makefile.objs               |   2 +
 hw/timer/bcm283x_timer.c             | 283 +++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/timer/bcm283x_timer.h     |  37 ++++
 5 files changed, 339 insertions(+)
 create mode 100644 hw/timer/bcm283x_timer.c
 create mode 100644 include/hw/timer/bcm283x_timer.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6be7660e8c..0c832283db 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -117,6 +117,11 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
                                    OBJECT(&s->sdhost.sdbus), &error_abort);
+
+    /* SP804-alike ARM Timer */
+    object_initialize(&s->bcm283xsp804, sizeof(s->bcm283xsp804), TYPE_BCM283xSP804);
+    object_property_add_child(obj, "bcm283xsp804", OBJECT(&s->bcm283xsp804), NULL);
+    qdev_set_parent_bus(DEVICE(&s->bcm283xsp804), sysbus_get_default());
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -334,6 +339,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    /* SP804-alike ARM Timer */
+    object_property_set_bool(OBJECT(&s->bcm283xsp804), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ARMCTRL_TIMER0_1_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->bcm283xsp804), 0));
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
index 0000000000..e7509b37e9
--- /dev/null
+++ b/hw/timer/bcm283x_timer.c
@@ -0,0 +1,283 @@
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "qemu-common.h"
+#include "hw/qdev.h"
+#include "hw/ptimer.h"
+#include "hw/timer/bcm283x_timer.h"
+#include "qemu/main-loop.h"
+#include "qemu/log.h"
+
+/* TODO: implement free-running timer as per BCM283x peripheral specification */
+
+#define TIMER_CTRL_32BIT    (1 << 1)
+#define TIMER_CTRL_DIV1     (0 << 2)
+#define TIMER_CTRL_DIV16    (1 << 2)
+#define TIMER_CTRL_DIV256   (2 << 2)
+#define TIMER_CTRL_IE       (1 << 5)
+#define TIMER_CTRL_ENABLE   (1 << 7)
+
+struct bcm283x_timer_state {
+    ptimer_state *timer;
+    uint32_t control;
+    uint32_t limit;
+    int freq;
+    int int_level;
+    qemu_irq irq;
+    int prev_div;       // Not implemented
+    int free_run_cnt;   // Not implemented
+};
+
+static void bcm283x_timer_update(bcm283x_timer_state *s)
+{
+    if (s->int_level && (s->control & TIMER_CTRL_IE)) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint32_t bcm283x_timer_read(void *opaque, hwaddr offset)
+{
+    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
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
+        /* The register is write-only, but returns reverse "ARMT" string bytes */
+        return 0x544D5241;
+    case 4: /* RAW IRQ register */
+        return s->int_level;
+    case 5: /* Masked IRQ register */
+        if ((s->control & TIMER_CTRL_IE) == 0)
+            return 0;
+        return s->int_level;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset %x\n", __func__, (int) offset);
+        return 0;
+    }
+}
+
+static void bcm283x_timer_recalibrate(bcm283x_timer_state *s, int reload)
+{
+    uint32_t limit;
+
+    /* Consider timer periodic */
+    limit = s->limit;
+
+    ptimer_set_limit(s->timer, limit, reload);
+}
+
+static void bcm283x_timer_write(void *opaque, hwaddr offset, uint32_t value)
+{
+    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
+    int freq;
+
+    switch (offset >> 2) {
+        case 0: /* Load register */
+            s->limit = value;
+            bcm283x_timer_recalibrate(s, 1);
+            break;
+        case 1: /* Value register */
+            /* Read only */
+            break;
+        case 2: /* Control register */
+            if (s->control & TIMER_CTRL_ENABLE) {
+                ptimer_stop(s->timer);
+            }
+
+            s->control = value;
+            freq = s->freq;
+
+            /* Set pre-scaler */
+            switch ((value >> 2) & 3) {
+            case 1: freq >>= 4; break; /* 16 */
+            case 2: freq >>= 8; break; /* 256 */
+            }
+
+            bcm283x_timer_recalibrate(s, s->control & TIMER_CTRL_ENABLE);
+            ptimer_set_freq(s->timer, freq);
+            if (s->control & TIMER_CTRL_ENABLE) {
+                ptimer_run(s->timer, 0);
+            }
+            break;
+        case 3: /* IRQ clear/ACK register */
+            s->int_level = 0;
+            break;
+        case 6: /* Reload register */
+            s->limit = value;
+            bcm283x_timer_recalibrate(s, 0);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Bad offset %x\n", __func__, (int) offset);
+            break;
+    }
+
+    bcm283x_timer_update(s);
+}
+
+static void bcm283x_timer_tick(void *opaque)
+{
+    bcm283x_timer_state *s = (bcm283x_timer_state *) opaque;
+    s->int_level = 1;
+    bcm283x_timer_update(s);
+}
+
+static const VMStateDescription vmstate_bcm283x_timer = {
+    .name = "bcm283x_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, bcm283x_timer_state),
+        VMSTATE_UINT32(limit, bcm283x_timer_state),
+        VMSTATE_INT32(int_level, bcm283x_timer_state),
+        VMSTATE_PTIMER(timer, bcm283x_timer_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bcm283x_timer_state *bcm283x_timer_init(uint32_t freq)
+{
+    bcm283x_timer_state *s;
+    QEMUBH *bh;
+
+    s = (bcm283x_timer_state *) g_malloc0(sizeof(bcm283x_timer_state));
+    s->freq = freq;
+    s->control = TIMER_CTRL_IE;
+
+    bh = qemu_bh_new(bcm283x_timer_tick, s);
+    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    vmstate_register(NULL, -1, &vmstate_bcm283x_timer, s);
+
+    return s;
+}
+
+/* BCM283x's implementation of SP804 ARM timer */
+
+/* XXX: BCM's datasheet does not seem to provide these values and they may differ */
+static const uint8_t bcm283xsp803_ids[] = {
+    /* Timer ID */
+    0x04, 0x18, 0x14, 0x00,
+    /* PrimeCell ID */
+    0x0D, 0xF0, 0x05, 0xB1
+};
+
+static void bcm283xsp804_set_irq(void *opaque, int irq, int level)
+{
+    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
+
+    s->level = level;
+    qemu_set_irq(s->irq, s->level);
+}
+
+static uint64_t bcm283xsp804_read(void *opaque, hwaddr offset, unsigned size)
+{
+    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
+
+    if (offset < 0x20) {
+        return bcm283x_timer_read(s->timer, offset);
+    }
+    /* No second timer (0x20 < offset < 0x40) */
+
+    if (offset >= 0xFE0 && offset <= 0xFFC) {
+        return bcm283xsp803_ids[(offset - 0xFE0) >> 2];
+    }
+
+    switch (offset) {
+    /* Unimplemented: integration test control registers */
+    case 0xF00:
+    case 0xF04:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: integration test registers unimplemented\n", __func__);
+        return 0;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Bad offset %x\n", __func__, (int) offset);
+    return 0;
+}
+
+static void bcm283xsp803_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
+{
+    BCM283xSP804State *s = (BCM283xSP804State *) opaque;
+
+    if (offset < 0x20) {
+        bcm283x_timer_write(s->timer, offset, value);
+    }
+    /* No second timer (0x20 < offset < 0x40) */
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Bad offset %x\n", __func__, (int) offset);
+}
+
+static const MemoryRegionOps bcm283xsp804_ops = {
+    .read = bcm283xsp804_read,
+    .write = bcm283xsp803_write,
+    .endianness = DEVICE_NATIVE_ENDIAN
+};
+
+static const VMStateDescription vmstate_bcm283xsp804 = {
+    .name = "bcm283xsp804",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(level, BCM283xSP804State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm283xsp804_init(Object *obj)
+{
+    BCM283xSP804State *s = BCM283xSP804(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    sysbus_init_irq(sbd, &s->irq);
+    memory_region_init_io(&s->iomem, obj, &bcm283xsp804_ops, s, "bcm283xsp804", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void bcm283xsp804_realize(DeviceState *dev, Error **errp)
+{
+    BCM283xSP804State *s = BCM283xSP804(dev);
+
+    s->timer = bcm283x_timer_init(s->freq0);
+    s->timer->irq = qemu_allocate_irq(bcm283xsp804_set_irq, s, 0);
+}
+
+static Property bcm283xsp804_properties[] = {
+    DEFINE_PROP_UINT32("freq0", BCM283xSP804State, freq0, 1000000),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void bcm283xsp804_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->realize = bcm283xsp804_realize;
+    k->props = bcm283xsp804_properties;
+    k->vmsd = &vmstate_bcm283xsp804;
+}
+
+static const TypeInfo bcm283xsp804_info = {
+    .name           = TYPE_BCM283xSP804,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(BCM283xSP804State),
+    .instance_init  = bcm283xsp804_init,
+    .class_init     = bcm283xsp804_class_init
+};
+
+static void bcm283x_timer_register_types(void)
+{
+    type_register_static(&bcm283xsp804_info);
+}
+
+type_init(bcm283x_timer_register_types)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index f5b193f670..d13aad43cb 100644
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
+    BCM283xSP804State bcm283xsp804;
 } BCM2835PeripheralState;
 
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/timer/bcm283x_timer.h b/include/hw/timer/bcm283x_timer.h
new file mode 100644
index 0000000000..0755db11af
--- /dev/null
+++ b/include/hw/timer/bcm283x_timer.h
@@ -0,0 +1,37 @@
+/*
+ * Broadcom BCM283x ARM timer variant based on ARM SP804
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
+
+#define TYPE_BCM283xSP804 "bcm283xsp804"
+#define BCM283xSP804(obj) OBJECT_CHECK(BCM283xSP804State, (obj), TYPE_BCM283xSP804)
+
+typedef struct bcm283x_timer_state bcm283x_timer_state;
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    bcm283x_timer_state *timer;
+    uint32_t freq0;
+    int level;
+    qemu_irq irq;
+} BCM283xSP804State;
+
+#endif
-- 
2.20.1
