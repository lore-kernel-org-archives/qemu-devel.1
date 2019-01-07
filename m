Received: from eggs.gnu.org ([209.51.188.92]:46718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpN-0005fQ-4P
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpK-00038x-33
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpG-0002KK-6N
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id q18so1048717wrx.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:08 +0000
Message-Id: <20190107163117.16269-29-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/37] hw/gpio/nrf51_gpio: Add nRF51 GPIO
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

This adds a model of the nRF51 GPIO peripheral.

Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

The nRF51 series microcontrollers support up to 32 GPIO pins in various configurations.
The pins can be used as input pins with pull-ups or pull-down.
Furthermore, three different output driver modes per level are
available (disconnected, standard, high-current).

The GPIO-Peripheral has a mechanism for detecting level changes which is
not featured in this model.

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-6-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile.objs                |   1 +
 hw/gpio/Makefile.objs        |   1 +
 include/hw/gpio/nrf51_gpio.h |  69 ++++++++
 hw/gpio/nrf51_gpio.c         | 300 +++++++++++++++++++++++++++++++++++
 hw/gpio/trace-events         |   7 +
 5 files changed, 378 insertions(+)
 create mode 100644 include/hw/gpio/nrf51_gpio.h
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/gpio/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index bc5b8a8442f..456115992a4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -184,6 +184,7 @@ trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/watchdog
 trace-events-subdirs += hw/xen
+trace-events-subdirs += hw/gpio
 trace-events-subdirs += io
 trace-events-subdirs += linux-user
 trace-events-subdirs += migration
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index fa0a72e6d0c..e5da0cb54fe 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
 obj-$(CONFIG_OMAP) += omap_gpio.o
 obj-$(CONFIG_IMX) += imx_gpio.o
 obj-$(CONFIG_RASPI) += bcm2835_gpio.o
+obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
new file mode 100644
index 00000000000..337ee534bbc
--- /dev/null
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -0,0 +1,69 @@
+/*
+ * nRF51 System-on-Chip general purpose input/output register definition
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: GPIO registers
+ * + Unnamed GPIO inputs 0-31: Set tri-state input level for GPIO pin.
+ *   Level -1: Externally Disconnected/Floating; Pull-up/down will be regarded
+ *   Level 0: Input externally driven LOW
+ *   Level 1: Input externally driven HIGH
+ * + Unnamed GPIO outputs 0-31:
+ *   Level -1: Disconnected/Floating
+ *   Level 0: Driven LOW
+ *   Level 1: Driven HIGH
+ *
+ * Accuracy of the peripheral model:
+ * + The nRF51 GPIO output driver supports two modes, standard and high-current
+ *   mode. These different drive modes are not modeled and handled the same.
+ * + Pin SENSEing is not modeled/implemented.
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+#ifndef NRF51_GPIO_H
+#define NRF51_GPIO_H
+
+#include "hw/sysbus.h"
+#define TYPE_NRF51_GPIO "nrf51_soc.gpio"
+#define NRF51_GPIO(obj) OBJECT_CHECK(NRF51GPIOState, (obj), TYPE_NRF51_GPIO)
+
+#define NRF51_GPIO_PINS 32
+
+#define NRF51_GPIO_SIZE 0x1000
+
+#define NRF51_GPIO_REG_OUT          0x504
+#define NRF51_GPIO_REG_OUTSET       0x508
+#define NRF51_GPIO_REG_OUTCLR       0x50C
+#define NRF51_GPIO_REG_IN           0x510
+#define NRF51_GPIO_REG_DIR          0x514
+#define NRF51_GPIO_REG_DIRSET       0x518
+#define NRF51_GPIO_REG_DIRCLR       0x51C
+#define NRF51_GPIO_REG_CNF_START    0x700
+#define NRF51_GPIO_REG_CNF_END      0x77F
+
+#define NRF51_GPIO_PULLDOWN 1
+#define NRF51_GPIO_PULLUP 3
+
+typedef struct NRF51GPIOState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    uint32_t out;
+    uint32_t in;
+    uint32_t in_mask;
+    uint32_t dir;
+    uint32_t cnf[NRF51_GPIO_PINS];
+
+    uint32_t old_out;
+    uint32_t old_out_connected;
+
+    qemu_irq output[NRF51_GPIO_PINS];
+} NRF51GPIOState;
+
+
+#endif
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
new file mode 100644
index 00000000000..86e047d649f
--- /dev/null
+++ b/hw/gpio/nrf51_gpio.c
@@ -0,0 +1,300 @@
+/*
+ * nRF51 System-on-Chip general purpose input/output register definition
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.pdf
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/gpio/nrf51_gpio.h"
+#include "trace.h"
+
+/*
+ * Check if the output driver is connected to the direction switch
+ * given the current configuration and logic level.
+ * It is not differentiated between standard and "high"(-power) drive modes.
+ */
+static bool is_connected(uint32_t config, uint32_t level)
+{
+    bool state;
+    uint32_t drive_config = extract32(config, 8, 3);
+
+    switch (drive_config) {
+    case 0 ... 3:
+        state = true;
+        break;
+    case 4 ... 5:
+        state = level != 0;
+        break;
+    case 6 ... 7:
+        state = level == 0;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return state;
+}
+
+static void update_output_irq(NRF51GPIOState *s, size_t i,
+                              bool connected, bool level)
+{
+    int64_t irq_level = connected ? level : -1;
+    bool old_connected = extract32(s->old_out_connected, i, 1);
+    bool old_level = extract32(s->old_out, i, 1);
+
+    if ((old_connected != connected) || (old_level != level)) {
+        qemu_set_irq(s->output[i], irq_level);
+        trace_nrf51_gpio_update_output_irq(i, irq_level);
+    }
+
+    s->old_out = deposit32(s->old_out, i, 1, level);
+    s->old_out_connected = deposit32(s->old_out_connected, i, 1, connected);
+}
+
+static void update_state(NRF51GPIOState *s)
+{
+    uint32_t pull;
+    size_t i;
+    bool connected_out, dir, connected_in, out, input;
+
+    for (i = 0; i < NRF51_GPIO_PINS; i++) {
+        pull = extract32(s->cnf[i], 2, 2);
+        dir = extract32(s->cnf[i], 0, 1);
+        connected_in = extract32(s->in_mask, i, 1);
+        out = extract32(s->out, i, 1);
+        input = !extract32(s->cnf[i], 1, 1);
+        connected_out = is_connected(s->cnf[i], out) && dir;
+
+        update_output_irq(s, i, connected_out, out);
+
+        /* Pin both driven externally and internally */
+        if (connected_out && connected_in) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited\n", i);
+        }
+
+        /*
+         * Input buffer disconnected from internal/external drives, so
+         * pull-up/pull-down becomes relevant
+         */
+        if (!input || (input && !connected_in && !connected_out)) {
+            if (pull == NRF51_GPIO_PULLDOWN) {
+                s->in = deposit32(s->in, i, 1, 0);
+            } else if (pull == NRF51_GPIO_PULLUP) {
+                s->in = deposit32(s->in, i, 1, 1);
+            }
+        }
+
+        /* Self stimulation through internal output driver */
+        if (connected_out && !connected_in && input) {
+            s->in = deposit32(s->in, i, 1, out);
+        }
+    }
+
+}
+
+/*
+ * Direction is exposed in both the DIR register and the DIR bit
+ * of each PINs CNF configuration register. Reflect bits for pins in DIR
+ * to individual pin configuration registers.
+ */
+static void reflect_dir_bit_in_cnf(NRF51GPIOState *s)
+{
+    size_t i;
+
+    uint32_t value = s->dir;
+
+    for (i = 0; i < NRF51_GPIO_PINS; i++) {
+        s->cnf[i] = (s->cnf[i] & ~(1UL)) | ((value >> i) & 0x01);
+    }
+}
+
+static uint64_t nrf51_gpio_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    NRF51GPIOState *s = NRF51_GPIO(opaque);
+    uint64_t r = 0;
+    size_t idx;
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT ... NRF51_GPIO_REG_OUTCLR:
+        r = s->out;
+        break;
+
+    case NRF51_GPIO_REG_IN:
+        r = s->in;
+        break;
+
+    case NRF51_GPIO_REG_DIR ... NRF51_GPIO_REG_DIRCLR:
+        r = s->dir;
+        break;
+
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx = (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        r = s->cnf[idx];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    trace_nrf51_gpio_read(offset, r);
+
+    return r;
+}
+
+static void nrf51_gpio_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    NRF51GPIOState *s = NRF51_GPIO(opaque);
+    size_t idx;
+
+    trace_nrf51_gpio_write(offset, value);
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT:
+        s->out = value;
+        break;
+
+    case NRF51_GPIO_REG_OUTSET:
+        s->out |= value;
+        break;
+
+    case NRF51_GPIO_REG_OUTCLR:
+        s->out &= ~value;
+        break;
+
+    case NRF51_GPIO_REG_DIR:
+        s->dir = value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_DIRSET:
+        s->dir |= value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_DIRCLR:
+        s->dir &= ~value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx = (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        s->cnf[idx] = value;
+        /*
+         * direction is exposed in both the DIR register and the DIR bit
+         * of each PINs CNF configuration register.
+         */
+        s->dir = (s->dir & ~(1UL << idx)) | ((value & 0x01) << idx);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    update_state(s);
+}
+
+static const MemoryRegionOps gpio_ops = {
+    .read =  nrf51_gpio_read,
+    .write = nrf51_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static void nrf51_gpio_set(void *opaque, int line, int value)
+{
+    NRF51GPIOState *s = NRF51_GPIO(opaque);
+
+    trace_nrf51_gpio_set(line, value);
+
+    assert(line >= 0 && line < NRF51_GPIO_PINS);
+
+    s->in_mask = deposit32(s->in_mask, line, 1, value >= 0);
+    if (value >= 0) {
+        s->in = deposit32(s->in, line, 1, value != 0);
+    }
+
+    update_state(s);
+}
+
+static void nrf51_gpio_reset(DeviceState *dev)
+{
+    NRF51GPIOState *s = NRF51_GPIO(dev);
+    size_t i;
+
+    s->out = 0;
+    s->old_out = 0;
+    s->old_out_connected = 0;
+    s->in = 0;
+    s->in_mask = 0;
+    s->dir = 0;
+
+    for (i = 0; i < NRF51_GPIO_PINS; i++) {
+        s->cnf[i] = 0x00000002;
+    }
+}
+
+static const VMStateDescription vmstate_nrf51_gpio = {
+    .name = TYPE_NRF51_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(out, NRF51GPIOState),
+        VMSTATE_UINT32(in, NRF51GPIOState),
+        VMSTATE_UINT32(in_mask, NRF51GPIOState),
+        VMSTATE_UINT32(dir, NRF51GPIOState),
+        VMSTATE_UINT32_ARRAY(cnf, NRF51GPIOState, NRF51_GPIO_PINS),
+        VMSTATE_UINT32(old_out, NRF51GPIOState),
+        VMSTATE_UINT32(old_out_connected, NRF51GPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void nrf51_gpio_init(Object *obj)
+{
+    NRF51GPIOState *s = NRF51_GPIO(obj);
+
+    memory_region_init_io(&s->mmio, obj, &gpio_ops, s,
+            TYPE_NRF51_GPIO, NRF51_GPIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(s), nrf51_gpio_set, NRF51_GPIO_PINS);
+    qdev_init_gpio_out(DEVICE(s), s->output, NRF51_GPIO_PINS);
+}
+
+static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_nrf51_gpio;
+    dc->reset = nrf51_gpio_reset;
+    dc->desc = "nRF51 GPIO";
+}
+
+static const TypeInfo nrf51_gpio_info = {
+    .name = TYPE_NRF51_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NRF51GPIOState),
+    .instance_init = nrf51_gpio_init,
+    .class_init = nrf51_gpio_class_init
+};
+
+static void nrf51_gpio_register_types(void)
+{
+    type_register_static(&nrf51_gpio_info);
+}
+
+type_init(nrf51_gpio_register_types)
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
new file mode 100644
index 00000000000..cb41a897569
--- /dev/null
+++ b/hw/gpio/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/gpio/nrf51_gpio.c
+nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
+nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
+nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
\ No newline at end of file
-- 
2.19.2
