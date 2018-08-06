Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKO-00025M-9G
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-0003Fb-9J
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:28 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33168)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKI-0003F7-QN
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:23 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:11 +0200
Message-Id: <20180806100114.21410-5-contrib@steffen-goertz.de>
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] hw/gpio/nrf51_gpio: Add nRF51 GPIO
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This adds a model of the nRF51 GPIO peripheral.

Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

The nRF51 series microcontrollers support up to 32 GPIO pins in various c=
onfigurations.
The pins can be used as input pins with pull-ups or pull-down.
Furthermore, three different output driver modes per level are
available (disconnected, standard, high-current).

The GPIO-Peripheral has a mechanism for detecting level changes which is
not featured in this model.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 Makefile.objs                |   1 +
 hw/gpio/Makefile.objs        |   1 +
 hw/gpio/nrf51_gpio.c         | 305 +++++++++++++++++++++++++++++++++++
 hw/gpio/trace-events         |   7 +
 include/hw/gpio/nrf51_gpio.h |  57 +++++++
 5 files changed, 371 insertions(+)
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 hw/gpio/trace-events
 create mode 100644 include/hw/gpio/nrf51_gpio.h

diff --git a/Makefile.objs b/Makefile.objs
index 7a9828da28..506ae4eae0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -241,6 +241,7 @@ trace-events-subdirs +=3D hw/usb
 trace-events-subdirs +=3D hw/vfio
 trace-events-subdirs +=3D hw/virtio
 trace-events-subdirs +=3D hw/xen
+trace-events-subdirs +=3D hw/gpio
 trace-events-subdirs +=3D io
 trace-events-subdirs +=3D linux-user
 trace-events-subdirs +=3D migration
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index fa0a72e6d0..e5da0cb54f 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-$(CONFIG_GPIO_KEY) +=3D gpio_key.o
 obj-$(CONFIG_OMAP) +=3D omap_gpio.o
 obj-$(CONFIG_IMX) +=3D imx_gpio.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
+obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
new file mode 100644
index 0000000000..c644239f10
--- /dev/null
+++ b/hw/gpio/nrf51_gpio.c
@@ -0,0 +1,305 @@
+/*
+ * nRF51 System-on-Chip general purpose input/output register definition
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
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
+#define GPIO_PULLDOWN 1
+#define GPIO_PULLUP 3
+
+/**
+ * Check if the output driver is connected to the direction switch
+ * given the current configuration and logic level.
+ * It is not differentiated between standard and "high"(-power) drive mo=
des.
+ */
+static bool is_connected(uint32_t config, uint32_t level)
+{
+    bool state;
+    uint32_t drive_config =3D extract32(config, 8, 3);
+
+    switch (drive_config) {
+    case 0 ... 3:
+        state =3D true;
+        break;
+    case 4 ... 5:
+        state =3D level !=3D 0;
+        break;
+    case 6 ... 7:
+        state =3D level =3D=3D 0;
+        break;
+    }
+
+    return state;
+}
+
+static void update_output_irq(Nrf51GPIOState *s, size_t i,
+                              bool connected, bool level)
+{
+    int64_t irq_level =3D connected ? level : -1;
+    bool old_connected =3D extract32(s->old_out_connected, i, 1);
+    bool old_level =3D extract32(s->old_out, i, 1);
+
+    if ((old_connected !=3D connected) || (old_level !=3D level)) {
+        qemu_set_irq(s->output[i], irq_level);
+        trace_nrf51_gpio_update_output_irq(i, irq_level);
+    }
+
+    s->old_out =3D deposit32(s->old_out, i, 1, level);
+    s->old_out_connected =3D deposit32(s->old_out_connected, i, 1, conne=
cted);
+}
+
+static void update_state(Nrf51GPIOState *s)
+{
+    uint32_t pull;
+    bool connected_out, dir, connected_in, out, input;
+
+    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
+        pull =3D extract32(s->cnf[i], 2, 2);
+        dir =3D extract32(s->cnf[i], 0, 1);
+        connected_in =3D extract32(s->in_mask, i, 1);
+        out =3D extract32(s->out, i, 1);
+        input =3D !extract32(s->cnf[i], 1, 1);
+        connected_out =3D is_connected(s->cnf[i], out) && dir;
+
+        update_output_irq(s, i, connected_out, out);
+
+        /** Pin both driven externally and internally */
+        if (connected_out && connected_in) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited=
\n", i);
+        }
+
+        /**
+         * Input buffer disconnected from internal/external drives, so
+         * pull-up/pull-down becomes relevant
+         */
+        if (!input || (input && !connected_in && !connected_out)) {
+            if (pull =3D=3D GPIO_PULLDOWN) {
+                s->in =3D deposit32(s->in, i, 1, 0);
+            } else if (pull =3D=3D GPIO_PULLUP) {
+                s->in =3D deposit32(s->in, i, 1, 1);
+            }
+        }
+
+        /** Self stimulation through internal output driver **/
+        if (connected_out && !connected_in && input) {
+            s->in =3D deposit32(s->in, i, 1, out);
+        }
+    }
+
+}
+
+/**
+ * Direction is exposed in both the DIR register and the DIR bit
+ * of each PINs CNF configuration register. Reflect bits for pins in DIR
+ * to individual pin configuration registers.
+ */
+static void reflect_dir_bit_in_cnf(Nrf51GPIOState *s)
+{
+    uint32_t value =3D s->dir;
+    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
+        s->cnf[i] =3D (s->cnf[i] & ~(1UL)) | ((value >> i) & 0x01);
+    }
+}
+
+static uint64_t nrf51_gpio_read(void *opaque, hwaddr offset, unsigned in=
t size)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+    uint64_t r =3D 0;
+    size_t idx;
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT ... NRF51_GPIO_REG_OUTCLR:
+        r =3D s->out;
+        break;
+
+    case NRF51_GPIO_REG_IN:
+        r =3D s->in;
+        break;
+
+    case NRF51_GPIO_REG_DIR ... NRF51_GPIO_REG_DIRCLR:
+        r =3D s->dir;
+        break;
+
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx =3D (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        r =3D s->cnf[idx];
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
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+    size_t idx;
+
+    trace_nrf51_gpio_write(offset, value);
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT:
+        s->out =3D value;
+        break;
+
+    case NRF51_GPIO_REG_OUTSET:
+        s->out |=3D value;
+        break;
+
+    case NRF51_GPIO_REG_OUTCLR:
+        s->out &=3D ~value;
+        break;
+
+    case NRF51_GPIO_REG_DIR:
+        s->dir =3D value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_DIRSET:
+        s->dir |=3D value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_DIRCLR:
+        s->dir &=3D ~value;
+        reflect_dir_bit_in_cnf(s);
+        break;
+
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx =3D (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        s->cnf[idx] =3D value;
+        /* direction is exposed in both the DIR register and the DIR bit
+         * of each PINs CNF configuration register. */
+        s->dir =3D (s->dir & ~(1UL << idx)) | ((value & 0x01) << idx);
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
+static const MemoryRegionOps gpio_ops =3D {
+    .read =3D  nrf51_gpio_read,
+    .write =3D nrf51_gpio_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+};
+
+static void nrf51_gpio_set(void *opaque, int line, int value)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+
+    trace_nrf51_gpio_set(line, value);
+
+    assert(line >=3D 0 && line < NRF51_GPIO_PINS);
+
+    s->in_mask =3D deposit32(s->in_mask, line, 1, value >=3D 0);
+    s->in =3D deposit32(s->in, line, 1, value > 0);
+
+    update_state(s);
+}
+
+static void nrf51_gpio_reset(DeviceState *dev)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(dev);
+    size_t i;
+
+    s->out =3D 0;
+    s->old_out =3D 0;
+    s->old_out_connected =3D 0;
+    s->in =3D 0;
+    s->in_mask =3D 0;
+    s->dir =3D 0;
+
+    for (i =3D 0; i < NRF51_GPIO_PINS; i++) {
+        s->cnf[i] =3D 0x00000002;
+    }
+}
+
+static const VMStateDescription vmstate_nrf51_gpio =3D {
+    .name =3D TYPE_NRF51_GPIO,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .minimum_version_id_old =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(out, Nrf51GPIOState),
+        VMSTATE_UINT32(in, Nrf51GPIOState),
+        VMSTATE_UINT32(in_mask, Nrf51GPIOState),
+        VMSTATE_UINT32(dir, Nrf51GPIOState),
+        VMSTATE_UINT32_ARRAY(cnf, Nrf51GPIOState, NRF51_GPIO_PINS),
+        VMSTATE_UINT32(old_out, Nrf51GPIOState),
+        VMSTATE_UINT32(old_out_connected, Nrf51GPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void nrf51_gpio_init(Object *obj)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(obj);
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
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_nrf51_gpio;
+    dc->reset =3D nrf51_gpio_reset;
+    dc->desc =3D "nRF51 GPIO";
+}
+
+static const TypeInfo nrf51_gpio_info =3D {
+    .name =3D TYPE_NRF51_GPIO,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(Nrf51GPIOState),
+    .instance_init =3D nrf51_gpio_init,
+    .class_init =3D nrf51_gpio_class_init
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
index 0000000000..11486b09b9
--- /dev/null
+++ b/hw/gpio/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/gpio/nrf51_gpio.c
+nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value=
 0x%" PRIx64
+nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " =
value 0x%" PRIx64
+nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value 0x%"=
 PRIi64
+nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi6=
4 " value 0x%" PRIi64
\ No newline at end of file
diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
new file mode 100644
index 0000000000..c5b8501521
--- /dev/null
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -0,0 +1,57 @@
+/*
+ * nRF51 System-on-Chip general purpose input/output register definition
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: GPIO registers
+ * + Unnamed GPIO inputs 0-31: Set tri-state input level for GPIO pin.
+ *   Level -1: Externally Disconnected/Floating; Pull-up/down will be re=
garded
+ *   Level 0: Input externally driven LOW
+ *   Level 1: Input externally driven HIGH
+ * + Unnamed GPIO outputs 0-31:
+ *   Level -1: Disconnected/Floating
+ *   Level 0: Driven LOW
+ *   Level 1: Driven HIGH
+ *
+ * Accuracy of the peripheral model:
+ * + The nRF51 GPIO output driver supports two modes, standard and high-=
current
+ *   mode. These different drive modes are not modeled and handled the s=
ame.
+ * + Pin SENSEing is not modeled/implemented.
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
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
+#define NRF51_GPIO(obj) OBJECT_CHECK(Nrf51GPIOState, (obj), TYPE_NRF51_G=
PIO)
+
+#define NRF51_GPIO_PINS 32
+
+typedef struct Nrf51GPIOState {
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
+} Nrf51GPIOState;
+
+
+#endif
--=20
2.18.0
