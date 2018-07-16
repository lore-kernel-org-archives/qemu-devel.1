Received: from eggs.gnu.org ([2001:4830:134:3::10]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1ff12o-0002EB-If
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1ff12l-0001Et-Bi
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:47:54 -0400
Received: from steffen-goertz.de ([88.198.119.201]:56918)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1ff12l-0001EY-1m
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:47:51 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 16 Jul 2018 12:47:43 +0200
Message-Id: <20180716104744.11105-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 1/2] arm: Add nRF51 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 Changes in v2:
   - Only call QEMU GPIO update handlers if value changes
   - Code style changes
   - Removed unused includes

 hw/gpio/Makefile.objs        |   1 +
 hw/gpio/nrf51_gpio.c         | 320 +++++++++++++++++++++++++++++++++++
 include/hw/gpio/nrf51_gpio.h |  57 +++++++
 3 files changed, 378 insertions(+)
 create mode 100644 hw/gpio/nrf51_gpio.c
 create mode 100644 include/hw/gpio/nrf51_gpio.h

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
index 0000000000..033d013882
--- /dev/null
+++ b/hw/gpio/nrf51_gpio.c
@@ -0,0 +1,320 @@
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
+#ifndef DEBUG_NRF51_GPIO
+#define DEBUG_NRF51_GPIO 0
+#endif
+
+#define DPRINTF(fmt, args...) \
+    do { \
+        if (DEBUG_NRF51_GPIO) { \
+            fprintf(stderr, "[%s]%s: " fmt , TYPE_NRF51_GPIO, \
+                                             __func__, ##args); \
+        } \
+    } while (0)
+
+static uint64_t gpio_read(void *opaque, hwaddr offset, unsigned int size=
)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+    uint64_t r =3D 0;
+    size_t idx;
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT ... NRF51_GPIO_REG_OUTCLR:
+        DPRINTF("read out\n");
+        r =3D s->out;
+        break;
+    case NRF51_GPIO_REG_IN:
+        DPRINTF("read in\n");
+        r =3D s->in;
+        break;
+    case NRF51_GPIO_REG_DIR ... NRF51_GPIO_REG_DIRCLR:
+        DPRINTF("read dir\n");
+        r =3D s->dir;
+        break;
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx =3D (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        DPRINTF("read config %d\n", (uint32_t)idx);
+        r =3D s->cnf[idx];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    return r;
+}
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
+    bool old_connected =3D extract32(s->old_out_connected, i, 1);
+    bool old_level =3D extract32(s->old_out, i, 1);
+
+    if ((old_connected !=3D connected) || (old_level !=3D level)) {
+        if (connected) {
+            DPRINTF("qemu output to %s\n", level ? "HIGH" : "LOW");
+            qemu_set_irq(s->output[i], level);
+        } else {
+            DPRINTF("qemu output to %s\n", "DISCONNECTED");
+            qemu_set_irq(s->output[i], -1);
+        }
+    }
+
+    s->old_out =3D deposit32(s->old_out, i, 1, level);
+    s->old_out_connected =3D deposit32(s->old_out_connected, i, 1, conne=
cted);
+}
+
+static void gpio_update_state(Nrf51GPIOState *s)
+{
+    uint32_t pull;
+    bool connected_out, dir, connected_in, out, input;
+
+    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
+        DPRINTF("=3D=3D=3D calc update for state %zu =3D=3D=3D\n", i);
+
+        pull =3D extract32(s->cnf[i], 2, 2);
+        dir =3D extract32(s->cnf[i], 0, 1);
+        connected_in =3D extract32(s->in_mask, i, 1);
+        out =3D extract32(s->out, i, 1);
+        input =3D !extract32(s->cnf[i], 1, 1);
+        connected_out =3D is_connected(s->cnf[i], out) && dir;
+
+        DPRINTF("[CON_OUT, OUT, CON_IN, INPUT] =3D [%s, %s, %s, %s]\n",
+            connected_out ? "true" : "false",
+            out ? "HIGH" : "LOW",
+            connected_in ? "true" : "false",
+            input ? "HIGH" : "LOW"
+        );
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
+                DPRINTF("pulled-down\n");
+                s->in =3D deposit32(s->in, i, 1, 0);
+            } else if (pull =3D=3D GPIO_PULLUP) {
+                DPRINTF("pulled-up\n");
+                s->in =3D deposit32(s->in, i, 1, 1);
+            }
+        }
+
+        /** Self stimulation through internal output driver **/
+        if (connected_out && !connected_in && input) {
+            DPRINTF("self stimulated %s\n", out ? "HIGH" : "LOW");
+            s->in =3D deposit32(s->in, i, 1, out);
+        }
+    }
+
+}
+
+static void gpio_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+    size_t idx;
+
+    switch (offset) {
+    case NRF51_GPIO_REG_OUT:
+        DPRINTF("write out=3D0x%" PRIx32 "\n", (uint32_t)value);
+        s->out =3D value;
+        gpio_update_state(s);
+        break;
+    case NRF51_GPIO_REG_OUTSET:
+        DPRINTF("set out=3D0x%" PRIx32 "\n", (uint32_t)value);
+        s->out |=3D value;
+        gpio_update_state(s);
+        break;
+    case NRF51_GPIO_REG_OUTCLR:
+        DPRINTF("clr out=3D0x%" PRIx32 "\n", (uint32_t)value);
+        s->out &=3D ~value;
+        gpio_update_state(s);
+        break;
+    case NRF51_GPIO_REG_DIR:
+        DPRINTF("write dir=3D0x%" PRIx32 "\n", (uint32_t)value);
+        s->dir =3D value;
+        /* direction is exposed in both the DIR register and the DIR bit
+         * of each PINs CNF configuration register. */
+        for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
+            s->cnf[i] =3D (s->cnf[i] & ~(1UL)) | ((value >> i) & 0x01);
+        }
+        gpio_update_state(s);
+        break;
+    case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
+        idx =3D (offset - NRF51_GPIO_REG_CNF_START) / 4;
+        DPRINTF("write cnf[%zu]=3D0x%" PRIx32 "\n", idx, (uint32_t)value=
);
+        s->cnf[idx] =3D value;
+        /* direction is exposed in both the DIR register and the DIR bit
+         * of each PINs CNF configuration register. */
+        s->dir =3D (s->dir & ~(1UL << idx)) | ((value & 0x01) << idx);
+        gpio_update_state(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+}
+
+static const MemoryRegionOps gpio_ops =3D {
+    .read =3D  gpio_read,
+    .write =3D gpio_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+};
+
+static void nrf51_gpio_set(void *opaque, int line, int value)
+{
+    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
+
+    assert(line >=3D 0 && line < NRF51_GPIO_PINS);
+
+    DPRINTF("line %d to [MASK,VALUE] =3D [%s, %s]\n", line,
+            (value >=3D 0) ? "TRUE" : "FALSE", (value > 0) ? "HIGH" : "L=
OW");
+
+    s->in_mask =3D deposit32(s->in_mask, line, 1, value >=3D 0);
+    s->in =3D deposit32(s->in, line, 1, value > 0);
+
+    gpio_update_state(s);
+}
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
+static Property nrf51_gpio_properties[] =3D {
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nrf51_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D nrf51_gpio_properties;
+    dc->vmsd =3D &vmstate_nrf51_gpio;
+    dc->reset =3D nrf51_gpio_reset;
+    dc->desc =3D "NRF51 GPIO";
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
