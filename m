Received: from eggs.gnu.org ([2001:4830:134:3::10]:49775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEZ-0005Ly-K5
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEW-0003z2-RN
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:03 +1000
Message-Id: <20180618035324.19907-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/28] mac_newworld: add gpios to macio devices
 with PMU enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

PMU-enabled New World Macs expose their GPIOs via a separate memory region
within the macio device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/macio/Makefile.objs     |   1 +
 hw/misc/macio/gpio.c            | 218 ++++++++++++++++++++++++++++++++
 hw/misc/macio/macio.c           |  13 ++
 hw/misc/macio/trace-events      |   7 +
 hw/ppc/mac.h                    |   2 +
 include/hw/misc/macio/gpio.h    |  47 +++++++
 include/hw/misc/macio/macio.h   |   3 +
 8 files changed, 292 insertions(+)
 create mode 100644 hw/misc/macio/gpio.c
 create mode 100644 include/hw/misc/macio/gpio.h

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 4d7be45ac5..38197e39eb 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -31,6 +31,7 @@ CONFIG_I2C=y
 CONFIG_MAC=y
 CONFIG_ESCC=y
 CONFIG_MACIO=y
+CONFIG_MACIO_GPIO=y
 CONFIG_SUNGEM=y
 CONFIG_MOS6522=y
 CONFIG_CUDA=y
diff --git a/hw/misc/macio/Makefile.objs b/hw/misc/macio/Makefile.objs
index ef7ac249ec..fb9dbf91b5 100644
--- a/hw/misc/macio/Makefile.objs
+++ b/hw/misc/macio/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-y += macio.o
 common-obj-$(CONFIG_CUDA) += cuda.o
 common-obj-$(CONFIG_MAC_DBDMA) += mac_dbdma.o
+common-obj-$(CONFIG_MACIO_GPIO) += gpio.o
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
new file mode 100644
index 0000000000..5630afdf18
--- /dev/null
+++ b/hw/misc/macio/gpio.c
@@ -0,0 +1,218 @@
+/*
+ * PowerMac NewWorld MacIO GPIO emulation
+ *
+ * Copyright (c) 2016 Benjamin Herrenschmidt
+ * Copyright (c) 2018 Mark Cave-Ayland
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
+#include "hw/hw.h"
+#include "hw/ppc/mac.h"
+#include "hw/misc/macio/macio.h"
+#include "hw/misc/macio/gpio.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+
+void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
+{
+    uint8_t new_reg;
+
+    trace_macio_set_gpio(gpio, state);
+
+    if (s->gpio_regs[gpio] & 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "GPIO: Setting GPIO %d while it's an output\n", gpio);
+    }
+
+    new_reg = s->gpio_regs[gpio] & ~2;
+    if (state) {
+        new_reg |= 2;
+    }
+
+    if (new_reg == s->gpio_regs[gpio]) {
+        return;
+    }
+
+    s->gpio_regs[gpio] = new_reg;
+
+    /* This is will work until we fix the binding between MacIO and
+     * the MPIC properly so we can route all GPIOs and avoid going
+     * via the top level platform code.
+     *
+     * Note that we probably need to get access to the MPIC config to
+     * decode polarity since qemu always use "raise" regardless.
+     *
+     * For now, we hard wire known GPIOs
+     */
+
+    switch (gpio) {
+    case 1:
+        /* Level low */
+        if (!state) {
+            trace_macio_gpio_irq_assert(gpio);
+            qemu_irq_raise(s->gpio_extirqs[gpio]);
+        } else {
+            trace_macio_gpio_irq_deassert(gpio);
+            qemu_irq_lower(s->gpio_extirqs[gpio]);
+        }
+        break;
+
+    case 9:
+        /* Edge, triggered by NMI below */
+        if (state) {
+            trace_macio_gpio_irq_assert(gpio);
+            qemu_irq_raise(s->gpio_extirqs[gpio]);
+        } else {
+            trace_macio_gpio_irq_deassert(gpio);
+            qemu_irq_lower(s->gpio_extirqs[gpio]);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "GPIO: setting unimplemented GPIO %d", gpio);
+    }
+}
+
+static void macio_gpio_write(void *opaque, hwaddr addr, uint64_t value,
+                             unsigned size)
+{
+    MacIOGPIOState *s = opaque;
+    uint8_t ibit;
+
+    trace_macio_gpio_write(addr, value);
+
+    /* Levels regs are read-only */
+    if (addr < 8) {
+        return;
+    }
+
+    addr -= 8;
+    if (addr < 36) {
+        value &= ~2;
+
+        if (value & 4) {
+            ibit = (value & 1) << 1;
+        } else {
+            ibit = s->gpio_regs[addr] & 2;
+        }
+
+        s->gpio_regs[addr] = value | ibit;
+    }
+}
+
+static uint64_t macio_gpio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MacIOGPIOState *s = opaque;
+    uint64_t val = 0;
+
+    /* Levels regs */
+    if (addr < 8) {
+        val = s->gpio_levels[addr];
+    } else {
+        addr -= 8;
+
+        if (addr < 36) {
+            val = s->gpio_regs[addr];
+        }
+    }
+
+    trace_macio_gpio_write(addr, val);
+    return val;
+}
+
+static const MemoryRegionOps macio_gpio_ops = {
+    .read = macio_gpio_read,
+    .write = macio_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void macio_gpio_realize(DeviceState *dev, Error **errp)
+{
+    MacIOGPIOState *s = MACIO_GPIO(dev);
+
+    s->gpio_extirqs[1] = qdev_get_gpio_in(DEVICE(s->pic),
+                                          NEWWORLD_EXTING_GPIO1);
+    s->gpio_extirqs[9] = qdev_get_gpio_in(DEVICE(s->pic),
+                                          NEWWORLD_EXTING_GPIO9);
+}
+
+static void macio_gpio_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    MacIOGPIOState *s = MACIO_GPIO(obj);
+
+    object_property_add_link(obj, "pic", TYPE_OPENPIC,
+                             (Object **) &s->pic,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
+    memory_region_init_io(&s->gpiomem, OBJECT(s), &macio_gpio_ops, obj,
+                          "gpio", 0x30);
+    sysbus_init_mmio(sbd, &s->gpiomem);
+}
+
+static const VMStateDescription vmstate_macio_gpio = {
+    .name = "macio_gpio",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(gpio_levels, MacIOGPIOState, 8),
+        VMSTATE_UINT8_ARRAY(gpio_regs, MacIOGPIOState, 36),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void macio_gpio_reset(DeviceState *dev)
+{
+    MacIOGPIOState *s = MACIO_GPIO(dev);
+
+    /* GPIO 1 is up by default */
+    macio_set_gpio(s, 1, true);
+}
+
+static void macio_gpio_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = macio_gpio_realize;
+    dc->reset = macio_gpio_reset;
+    dc->vmsd = &vmstate_macio_gpio;
+}
+
+static const TypeInfo macio_gpio_init_info = {
+    .name          = TYPE_MACIO_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MacIOGPIOState),
+    .instance_init = macio_gpio_init,
+    .class_init    = macio_gpio_class_init,
+};
+
+static void macio_gpio_register_types(void)
+{
+    type_register_static(&macio_gpio_init_info);
+}
+
+type_init(macio_gpio_register_types)
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index dddf743bcb..8dfcbc3d9b 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -332,6 +332,16 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     memory_region_init_io(timer_memory, OBJECT(s), &timer_ops, NULL, "timer",
                           0x1000);
     memory_region_add_subregion(&s->bar, 0x15000, timer_memory);
+
+    if (ns->has_pmu) {
+        /* GPIOs */
+        sysbus_dev = SYS_BUS_DEVICE(&ns->gpio);
+        object_property_set_link(OBJECT(&ns->gpio), OBJECT(pic_dev), "pic",
+                                 &error_abort);
+        memory_region_add_subregion(&s->bar, 0x50,
+                                    sysbus_mmio_get_region(sysbus_dev, 0));
+        object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+    }
 }
 
 static void macio_newworld_init(Object *obj)
@@ -345,6 +355,9 @@ static void macio_newworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
+    object_initialize(&ns->gpio, sizeof(ns->gpio), TYPE_MACIO_GPIO);
+    qdev_set_parent_bus(DEVICE(&ns->gpio), sysbus_get_default());
+
     for (i = 0; i < 2; i++) {
         macio_init_ide(s, &ns->ide[i], sizeof(ns->ide[i]), i);
     }
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
index d499d78c99..71c47520eb 100644
--- a/hw/misc/macio/trace-events
+++ b/hw/misc/macio/trace-events
@@ -13,3 +13,10 @@ cuda_packet_send_data(int i, const uint8_t data) "[%d] 0x%02x"
 # hw/misc/macio/macio.c
 macio_timer_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx64 " len %d val 0x%"PRIx64
 macio_timer_read(uint64_t addr, unsigned len, uint32_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx32
+
+# hw/misc/macio/gpio.c
+macio_set_gpio(int gpio, bool state) "setting GPIO %d to %d"
+macio_gpio_irq_assert(int gpio) "asserting GPIO %d"
+macio_gpio_irq_deassert(int gpio) "deasserting GPIO %d"
+macio_gpio_write(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
+macio_gpio_read(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 4c08f52b87..b3b7f9d8ae 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -65,6 +65,8 @@
 #define NEWWORLD_IDE0_DMA_IRQ  0x2
 #define NEWWORLD_IDE1_IRQ      0xe
 #define NEWWORLD_IDE1_DMA_IRQ  0x3
+#define NEWWORLD_EXTING_GPIO1  0x2f
+#define NEWWORLD_EXTING_GPIO9  0x37
 
 /* Core99 machine */
 #define TYPE_CORE99_MACHINE MACHINE_TYPE_NAME("mac99")
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
new file mode 100644
index 0000000000..2838ae5fde
--- /dev/null
+++ b/include/hw/misc/macio/gpio.h
@@ -0,0 +1,47 @@
+/*
+ * PowerMac NewWorld MacIO GPIO emulation
+ *
+ * Copyright (c) 2016 Benjamin Herrenschmidt
+ * Copyright (c) 2018 Mark Cave-Ayland
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
+#ifndef MACIO_GPIO_H
+#define MACIO_GPIO_H
+
+#define TYPE_MACIO_GPIO "macio-gpio"
+#define MACIO_GPIO(obj) OBJECT_CHECK(MacIOGPIOState, (obj), TYPE_MACIO_GPIO)
+
+typedef struct MacIOGPIOState {
+    /*< private >*/
+    SysBusDevice parent;
+    /*< public >*/
+
+    OpenPICState *pic;
+
+    MemoryRegion gpiomem;
+    qemu_irq gpio_extirqs[10];
+    uint8_t gpio_levels[8];
+    uint8_t gpio_regs[36]; /* XXX Check count */
+} MacIOGPIOState;
+
+void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state);
+
+#endif
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 9529073ba8..d43883a893 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -26,8 +26,10 @@
 #ifndef MACIO_H
 #define MACIO_H
 
+#include "hw/char/escc.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
+#include "hw/misc/macio/gpio.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
 
@@ -74,6 +76,7 @@ typedef struct NewWorldMacIOState {
     bool has_adb;
     OpenPICState *pic;
     MACIOIDEState ide[2];
+    MacIOGPIOState gpio;
 } NewWorldMacIOState;
 
 #endif /* MACIO_H */
-- 
2.17.1
