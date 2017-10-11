Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.venries@gmail.com>) id 1e2H0S-0001bc-FY
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.venries@gmail.com>) id 1e2H0N-0005FW-Du
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:25:04 -0400
From: =?UTF-8?q?Thomas=20Venri=C3=A8s?= <thomas.venries@gmail.com>
Date: Wed, 11 Oct 2017 15:24:50 +0200
Message-Id: <1507728290-6062-1-git-send-email-thomas.venries@gmail.com>
In-Reply-To: <150771862388.288.7275764832812347655@b58463cdfd5f>
References: <150771862388.288.7275764832812347655@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] bcm2835_armtimer: add bcm2835 ARM timer
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

The ARM Timer is based on a ARM AP804, but it has
a number of differences with the standard SP804.
There is only one timer which runs in continuous
mode with an extra clock pre-divider register
and a 32-bit free running counter.

The extra stop-in-debug-mode control bit is not
implemented.

Signed-off-by: Thomas Venriès <thomas.venries@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  18 +++
 hw/timer/Makefile.objs               |   1 +
 hw/timer/bcm2835_armtimer.c          | 273 +++++++++++++++++++++++++++++++++++
 hw/timer/trace-events                |   4 +
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/timer/bcm2835_armtimer.h  |  35 +++++
 6 files changed, 333 insertions(+)
 create mode 100644 hw/timer/bcm2835_armtimer.c
 create mode 100644 include/hw/timer/bcm2835_armtimer.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 12e0dd1..73deb2e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -90,6 +90,11 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
     qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());

+    /* ARM Timer */
+    object_initialize(&s->armtimer, sizeof(s->armtimer), TYPE_BCM2835_ARMTIMER);
+    object_property_add_child(obj, "armtimer", OBJECT(&s->armtimer), NULL);
+    qdev_set_parent_bus(DEVICE(&s->armtimer), sysbus_get_default());
+
     /* Extended Mass Media Controller */
     object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
     object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
@@ -254,6 +259,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));

+    /* ARM Timer */
+    object_property_set_bool(OBJECT(&s->armtimer), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ARMCTRL_TIMER0_1_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->armtimer), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->armtimer), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
+                               INTERRUPT_ARM_TIMER));
+
     /* Extended Mass Media Controller */
     object_property_set_int(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
                             &err);
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8c19eac..268d485 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -29,6 +29,7 @@ obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
 obj-$(CONFIG_OMAP) += omap_gptimer.o
 obj-$(CONFIG_OMAP) += omap_synctimer.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
+obj-$(CONFIG_RASPI) += bcm2835_armtimer.o
 obj-$(CONFIG_SH4) += sh_timer.o
 obj-$(CONFIG_DIGIC) += digic-timer.o
 obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
diff --git a/hw/timer/bcm2835_armtimer.c b/hw/timer/bcm2835_armtimer.c
new file mode 100644
index 0000000..39ff213
--- /dev/null
+++ b/hw/timer/bcm2835_armtimer.c
@@ -0,0 +1,273 @@
+/*
+ * BCM2835 ARM Timer
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
+#include "qemu/main-loop.h"
+#include "hw/ptimer.h"
+#include "hw/timer/bcm2835_armtimer.h"
+#include "trace.h"
+
+#define ARM_TIMER_REG_SIZE      0x24
+
+/* Register offsets */
+#define ARM_TIMER_LOAD          0x00
+#define ARM_TIMER_VALUE         0x04
+#define ARM_TIMER_CTRL          0x08
+#define ARM_TIMER_INTCLR        0x0C
+#define ARM_TIMER_RAW_IRQ       0x10
+#define ARM_TIMER_MASK_IRQ      0x14
+#define ARM_TIMER_RELOAD        0x18
+#define ARM_TIMER_PREDIVIDER    0x1C
+#define ARM_TIMER_COUNTER       0x20
+
+/* Control register masks */
+#define CTRL_CNT_PRESCALE       (0xFF << 16)
+#define CTRL_CNT_ENABLE         (1 << 9)
+#define CTRL_TIMER_ENABLE       (1 << 7)
+#define CTRL_INT_ENABLE         (1 << 5)
+#define CTRL_TIMER_PRESCALE     (3 << 2)
+#define CTRL_TIMER_SIZE_32BIT   (1 << 1)
+
+#define CTRL_TIMER_WRAP_MODE    0
+
+/* Register reset values */
+#define CTRL_CNT_PRESCALE_RESET     (0x3E << 16)
+#define ARM_TIMER_CTRL_RESET        (CTRL_CNT_PRESCALE_RESET | CTRL_INT_ENABLE)
+#define ARM_TIMER_IE_READ_VALUE     0x544D5241  /* ASCII "ARMT" */
+/*
+   The system clock refers to a 250 MHz frequency by default.
+   This frequency can be changed by setting `core_freq` the `config.txt` file.
+   APB clock runs at half the speed of the system clock also called ARM clock.
+
+   The ARM timer's predivider register is 10 bits wide and can be written
+   or read from. This register has been added as the SP804 expects a 1MHz clock
+   which they do not have. Instead the predivider takes the APB clock
+   and divides it down according to:
+
+       timer_clock = apb_clock / (prediv + 1)
+
+   The need is a 1MHz timer clock frequency and BCM2835 ARM Peripherals
+   documentation mentions the predivider reset value is 0x7D (or 125), so
+   the APB clock refers to a 126MHz frequency.
+
+   Also the additional free-running counter runs from the APB clock and has
+   its own clock predivider controlled by buts 16-23 of the timer control reg:
+
+       frc_clock = apb_clock / (prediv + 1)
+
+   The predivider reset value is 0x3E (or 62), knowing APB clock frequency,
+   the FRN clock refers to a 2MHz frequency by default.
+*/
+#define ARM_APB_FREQ                126000000UL /* Hz */
+#define ARM_TIMER_PREDIVIDER_RESET  125         /* MHz */
+
+static const uint16_t ctrl_prescale[] = { 1, 16, 256, 1 };
+
+static void bcm2835_armtimer_recalibrate(BCM2835ARMTimerState *s, int reload)
+{
+    uint32_t limit;
+
+    /* ARM Dual-Timer Module SP804, section 3.2.1:
+       If the Load Register is set to 0 then an interrupt is generated
+       immediately. */
+    if (reload == 2) {
+        limit = s->reload;
+    } else {
+        limit = (s->ctrl & CTRL_TIMER_SIZE_32BIT) ? 0xFFFFFFFF : 0XFFFF;
+    }
+
+    ptimer_set_limit(s->timer, limit, reload);
+}
+
+static void bcm2835_armtimer_cb(void *opaque)
+{
+    BCM2835ARMTimerState *s = (BCM2835ARMTimerState *)opaque;
+
+    s->raw_irq = 1;
+
+    if (s->ctrl & CTRL_TIMER_ENABLE) {
+        qemu_irq_raise(s->irq);
+        trace_bcm2835_armtimer_interrupt();
+    }
+}
+
+static uint64_t bcm2835_armtimer_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    BCM2835ARMTimerState *s = (BCM2835ARMTimerState *)opaque;
+
+    switch (offset) {
+    case ARM_TIMER_LOAD:
+    case ARM_TIMER_RELOAD:
+        return s->reload;
+    case ARM_TIMER_VALUE:
+        return ptimer_get_count(s->timer);
+    case ARM_TIMER_CTRL:
+        return s->ctrl;
+    case ARM_TIMER_INTCLR:
+        return ARM_TIMER_IE_READ_VALUE;
+    case ARM_TIMER_RAW_IRQ:
+        return s->raw_irq;
+    case ARM_TIMER_MASK_IRQ:
+        return s->raw_irq && (s->ctrl & CTRL_INT_ENABLE);
+    case ARM_TIMER_PREDIVIDER:
+        return s->prediv;
+    case ARM_TIMER_COUNTER:
+        return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / s->prescaler;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "bcm2835_armtimer_read: Bad offset - [%x]\n",
+                      (int)offset);
+        return 0;
+    }
+}
+
+static void bcm2835_armtimer_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    BCM2835ARMTimerState *s = (BCM2835ARMTimerState *)opaque;
+    uint32_t div;
+
+    switch (offset) {
+    case ARM_TIMER_LOAD:
+        bcm2835_armtimer_recalibrate(s, 2);
+        break;
+    case ARM_TIMER_CTRL:
+        if (s->ctrl & CTRL_TIMER_ENABLE) {
+            ptimer_stop(s->timer);
+        }
+
+        s->ctrl = value;
+
+        s->prescaler = (ARM_APB_FREQ /
+                            (((s->ctrl & CTRL_CNT_PRESCALE) >> 16) + 1));
+
+        bcm2835_armtimer_recalibrate(s, s->ctrl & CTRL_TIMER_ENABLE);
+
+        div = ctrl_prescale[((s->ctrl & CTRL_TIMER_PRESCALE) >> 2)]
+                    * s->prediv;
+        ptimer_set_freq(s->timer, ARM_APB_FREQ / div);
+
+        if (s->ctrl & CTRL_TIMER_ENABLE) {
+            ptimer_run(s->timer, CTRL_TIMER_WRAP_MODE);
+        }
+        break;
+    case ARM_TIMER_INTCLR:
+        qemu_irq_lower(s->irq);
+        s->raw_irq = 0;
+        trace_bcm2835_armtimer_ack();
+        break;
+    case ARM_TIMER_RELOAD:
+        /* In Free-running mode the timer counter wraps around to 32 or 16-bit
+           limit (respectively 0xFFFFFFFF or 0xFFFFF) regardless the Reload
+           and Load Register values, except that when the Load Register is
+           written to directly, the current count immediately resets to the 32
+           or 16-bits limit according to the Control Register bit [1]. */
+        s->reload = value;
+        break;
+    case ARM_TIMER_PREDIVIDER:
+        s->prediv = value + 1;
+        if (s->ctrl & CTRL_TIMER_ENABLE) {
+            ptimer_stop(s->timer);
+            div = ctrl_prescale[((s->ctrl & CTRL_TIMER_PRESCALE) >> 2)]
+                        * s->prediv;
+            ptimer_set_freq(s->timer, ARM_APB_FREQ / div);
+            ptimer_run(s->timer, CTRL_TIMER_WRAP_MODE);
+        }
+        break;
+
+    case ARM_TIMER_VALUE:
+    case ARM_TIMER_RAW_IRQ:
+    case ARM_TIMER_MASK_IRQ:
+    case ARM_TIMER_COUNTER:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "bcm2835_armtimer_write: Bad offset - [%x]\n",
+                      (int)offset);
+    }
+}
+
+static const MemoryRegionOps bcm2835_armtimer_ops = {
+    .read = bcm2835_armtimer_read,
+    .write = bcm2835_armtimer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_bcm2835_armtimer = {
+    .name = TYPE_BCM2835_ARMTIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, BCM2835ARMTimerState),
+        VMSTATE_UINT32(reload, BCM2835ARMTimerState),
+        VMSTATE_UINT32(raw_irq, BCM2835ARMTimerState),
+        VMSTATE_UINT32(msk_irq, BCM2835ARMTimerState),
+        VMSTATE_UINT32(prediv, BCM2835ARMTimerState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_armtimer_init(Object *obj)
+{
+    BCM2835ARMTimerState *s = BCM2835_ARMTIMER(obj);
+    QEMUBH *bh = qemu_bh_new(bcm2835_armtimer_cb, s);
+
+    s->reload = s->raw_irq = s->msk_irq = 0;
+    s->prediv = ARM_TIMER_PREDIVIDER_RESET;
+
+    /* ARM Dual-Timer Module SP804, section 2.2.6:
+       Timer Control Register Initialization :
+           - the timer counter is disabled, Bit[7]=0
+           - 16-bit counter mode is selected, Bit[1]=0
+           - prescalers are set to divide by 1, Bit[2:3]=0x0
+           - interrupts are cleared but enabled, Bit[5]=1
+           - the Load Register is set to zero
+           - the counter Value is set to 0xFFFFFFFF (useless)
+      BCM2835 ARM Peripherals, section 14.2:
+           - free-running mode is always selected, Bit[6]=0 and Bit[0]=0
+             because periodic and one-shot modes are not supported. */
+    s->ctrl = ARM_TIMER_CTRL_RESET;
+
+    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_armtimer_ops, s,
+                          TYPE_BCM2835_ARMTIMER, ARM_TIMER_REG_SIZE);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static void bcm2835_armtimer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "BCM2835 ARM Timer";
+    dc->vmsd = &vmstate_bcm2835_armtimer;
+}
+
+static TypeInfo bcm2835_armtimer_info = {
+    .name          = TYPE_BCM2835_ARMTIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835ARMTimerState),
+    .class_init    = bcm2835_armtimer_class_init,
+    .instance_init = bcm2835_armtimer_init,
+};
+
+static void bcm2835_armtimer_register_types(void)
+{
+    type_register_static(&bcm2835_armtimer_info);
+}
+
+type_init(bcm2835_armtimer_register_types)
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 640722b..d81dd38 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -60,3 +60,7 @@ systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr
 cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
+
+# hw/timer/bcm2535_armtimer.c
+bcm2835_armtimer_interrupt(void) "irq"
+bcm2835_armtimer_ack(void) "ack"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 122b286..236433b 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -20,6 +20,7 @@
 #include "hw/intc/bcm2835_ic.h"
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
+#include "hw/timer/bcm2835_armtimer.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
@@ -43,6 +44,7 @@ typedef struct BCM2835PeripheralState {
     BCM2835FBState fb;
     BCM2835DMAState dma;
     BCM2835ICState ic;
+    BCM2835ARMTimerState armtimer;
     BCM2835PropertyState property;
     BCM2835RngState rng;
     BCM2835MboxState mboxes;
diff --git a/include/hw/timer/bcm2835_armtimer.h b/include/hw/timer/bcm2835_armtimer.h
new file mode 100644
index 0000000..cb69f75
--- /dev/null
+++ b/include/hw/timer/bcm2835_armtimer.h
@@ -0,0 +1,35 @@
+/*
+ * BCM2835 ARM Timer
+ *
+ * Copyright (C) 2017 Thomas Venriès <thomas.venries@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2835_ARMTIMER_H
+#define BCM2835_ARMTIMER_H
+
+#include "hw/ptimer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_ARMTIMER "bcm2835-armtimer"
+#define BCM2835_ARMTIMER(obj) \
+        OBJECT_CHECK(BCM2835ARMTimerState, (obj), TYPE_BCM2835_ARMTIMER)
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    ptimer_state *timer;
+    qemu_irq irq;
+
+    uint32_t ctrl;
+    uint32_t raw_irq;
+    uint32_t msk_irq;
+    uint32_t reload;
+    uint32_t prediv;
+    uint32_t prescaler;
+} BCM2835ARMTimerState;
+
+#endif
--
2.7.4
