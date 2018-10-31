Received: from eggs.gnu.org ([2001:4830:134:3::10]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeKe-0004n6-8v
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeKc-00009t-C7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:00 -0400
Received: from steffen-goertz.de ([88.198.119.201]:60396)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeKc-00009P-0I
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:25:58 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 30 Oct 2018 20:25:17 -0400
Message-Id: <20181031002526.14262-4-contrib@steffen-goertz.de>
In-Reply-To: <20181031002526.14262-1-contrib@steffen-goertz.de>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/13] hw/misc/nrf51_rng: Add NRF51 random
 number generator peripheral
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

Add a model of the NRF51 random number generator peripheral.
This is a simple random generator that continuously generates
new random values after startup.

Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/misc/Makefile.objs       |   1 +
 hw/misc/nrf51_rng.c         | 262 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/nrf51_rng.h |  83 ++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 include/hw/misc/nrf51_rng.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 680350b3c3..04f3bfa516 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -74,3 +74,4 @@ obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
 obj-$(CONFIG_AUX) +=3D auxbus.o
 obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
+obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
new file mode 100644
index 0000000000..d188f044f4
--- /dev/null
+++ b/hw/misc/nrf51_rng.c
@@ -0,0 +1,262 @@
+/*
+ * nRF51 Random Number Generator
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
1.pdf
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/arm/nrf51.h"
+#include "hw/misc/nrf51_rng.h"
+#include "crypto/random.h"
+
+static void update_irq(NRF51RNGState *s)
+{
+    bool irq =3D s->interrupt_enabled && s->event_valrdy;
+    qemu_set_irq(s->irq, irq);
+}
+
+static uint64_t rng_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    NRF51RNGState *s =3D NRF51_RNG(opaque);
+    uint64_t r =3D 0;
+
+    switch (offset) {
+    case NRF51_RNG_EVENT_VALRDY:
+        r =3D s->event_valrdy;
+        break;
+    case NRF51_RNG_REG_SHORTS:
+        r =3D s->shortcut_stop_on_valrdy;
+        break;
+    case NRF51_RNG_REG_INTEN:
+    case NRF51_RNG_REG_INTENSET:
+    case NRF51_RNG_REG_INTENCLR:
+        r =3D s->interrupt_enabled;
+        break;
+    case NRF51_RNG_REG_CONFIG:
+        r =3D s->filter_enabled;
+        break;
+    case NRF51_RNG_REG_VALUE:
+        r =3D s->value;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    return r;
+}
+
+static int64_t calc_next_timeout(NRF51RNGState *s)
+{
+    int64_t timeout =3D qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    if (s->filter_enabled) {
+        timeout +=3D s->period_filtered_us;
+    } else {
+        timeout +=3D s->period_unfiltered_us;
+    }
+
+    return timeout;
+}
+
+
+static void rng_update_timer(NRF51RNGState *s)
+{
+    if (s->active) {
+        timer_mod(&s->timer, calc_next_timeout(s));
+    } else {
+        timer_del(&s->timer);
+    }
+}
+
+
+static void rng_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    NRF51RNGState *s =3D NRF51_RNG(opaque);
+
+    switch (offset) {
+    case NRF51_RNG_TASK_START:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->active =3D 1;
+            rng_update_timer(s);
+        }
+        break;
+    case NRF51_RNG_TASK_STOP:
+        if (value =3D=3D NRF51_TRIGGER_TASK) {
+            s->active =3D 0;
+            rng_update_timer(s);
+        }
+        break;
+    case NRF51_RNG_EVENT_VALRDY:
+        if (value =3D=3D NRF51_EVENT_CLEAR) {
+            s->event_valrdy =3D 0;
+        }
+        break;
+    case NRF51_RNG_REG_SHORTS:
+        s->shortcut_stop_on_valrdy =3D
+                (value & BIT_MASK(NRF51_RNG_REG_SHORTS_VALRDY_STOP)) ? 1=
 : 0;
+        break;
+    case NRF51_RNG_REG_INTEN:
+        s->interrupt_enabled =3D
+                (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) ? 1 : 0;
+        break;
+    case NRF51_RNG_REG_INTENSET:
+        if (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) {
+            s->interrupt_enabled =3D 1;
+        }
+        break;
+    case NRF51_RNG_REG_INTENCLR:
+        if (value & BIT_MASK(NRF51_RNG_REG_INTEN_VALRDY)) {
+            s->interrupt_enabled =3D 0;
+        }
+        break;
+    case NRF51_RNG_REG_CONFIG:
+        s->filter_enabled =3D
+                      (value & BIT_MASK(NRF51_RNG_REG_CONFIG_DECEN)) ? 1=
 : 0;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    update_irq(s);
+}
+
+static const MemoryRegionOps rng_ops =3D {
+    .read =3D  rng_read,
+    .write =3D rng_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4
+};
+
+static void nrf51_rng_timer_expire(void *opaque)
+{
+    NRF51RNGState *s =3D NRF51_RNG(opaque);
+
+    qcrypto_random_bytes(&s->value, 1, &error_abort);
+
+    s->event_valrdy =3D 1;
+    qemu_set_irq(s->eep_valrdy, 1);
+
+    if (s->shortcut_stop_on_valrdy) {
+        s->active =3D 0;
+    }
+
+    rng_update_timer(s);
+    update_irq(s);
+}
+
+static void nrf51_rng_tep_start(void *opaque, int n, int level)
+{
+    NRF51RNGState *s =3D NRF51_RNG(opaque);
+
+    if (level) {
+        s->active =3D 1;
+        rng_update_timer(s);
+    }
+}
+
+static void nrf51_rng_tep_stop(void *opaque, int n, int level)
+{
+    NRF51RNGState *s =3D NRF51_RNG(opaque);
+
+    if (level) {
+        s->active =3D 0;
+        rng_update_timer(s);
+    }
+}
+
+
+static void nrf51_rng_init(Object *obj)
+{
+    NRF51RNGState *s =3D NRF51_RNG(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->mmio, obj, &rng_ops, s,
+            TYPE_NRF51_RNG, NRF51_RNG_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+    timer_init_us(&s->timer, QEMU_CLOCK_VIRTUAL, nrf51_rng_timer_expire,=
 s);
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    /* Tasks */
+    qdev_init_gpio_in_named(DEVICE(s), nrf51_rng_tep_start, "tep_start",=
 1);
+    qdev_init_gpio_in_named(DEVICE(s), nrf51_rng_tep_stop, "tep_stop", 1=
);
+
+    /* Events */
+    qdev_init_gpio_out_named(DEVICE(s), &s->eep_valrdy, "eep_valrdy", 1)=
;
+}
+
+static void nrf51_rng_reset(DeviceState *dev)
+{
+    NRF51RNGState *s =3D NRF51_RNG(dev);
+
+    s->value =3D 0;
+    s->active =3D 0;
+    s->event_valrdy =3D 0;
+    s->shortcut_stop_on_valrdy =3D 0;
+    s->interrupt_enabled =3D 0;
+    s->filter_enabled =3D 0;
+
+    rng_update_timer(s);
+}
+
+
+static Property nrf51_rng_properties[] =3D {
+    DEFINE_PROP_UINT16("period_unfiltered_us", NRF51RNGState,
+            period_unfiltered_us, 167),
+    DEFINE_PROP_UINT16("period_filtered_us", NRF51RNGState,
+            period_filtered_us, 660),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_rng =3D {
+    .name =3D "nrf51_soc.rng",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(active, NRF51RNGState),
+        VMSTATE_UINT32(event_valrdy, NRF51RNGState),
+        VMSTATE_UINT32(shortcut_stop_on_valrdy, NRF51RNGState),
+        VMSTATE_UINT32(interrupt_enabled, NRF51RNGState),
+        VMSTATE_UINT32(filter_enabled, NRF51RNGState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void nrf51_rng_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D nrf51_rng_properties;
+    dc->vmsd =3D &vmstate_rng;
+    dc->reset =3D nrf51_rng_reset;
+}
+
+static const TypeInfo nrf51_rng_info =3D {
+    .name =3D TYPE_NRF51_RNG,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(NRF51RNGState),
+    .instance_init =3D nrf51_rng_init,
+    .class_init =3D nrf51_rng_class_init
+};
+
+static void nrf51_rng_register_types(void)
+{
+    type_register_static(&nrf51_rng_info);
+}
+
+type_init(nrf51_rng_register_types)
diff --git a/include/hw/misc/nrf51_rng.h b/include/hw/misc/nrf51_rng.h
new file mode 100644
index 0000000000..3d6bf79997
--- /dev/null
+++ b/include/hw/misc/nrf51_rng.h
@@ -0,0 +1,83 @@
+/*
+ * nRF51 Random Number Generator
+ *
+ * QEMU interface:
+ * + Property "period_unfiltered_us": Time between two biased values in
+ *   microseconds.
+ * + Property "period_filtered_us": Time between two unbiased values in
+ *   microseconds.
+ * + sysbus MMIO regions 0: Memory Region with tasks, events and registe=
rs
+ *   to be mapped to the peripherals instance address by the SOC.
+ * + Named GPIO output "irq": Interrupt line of the peripheral. Must be
+ *   connected to the associated peripheral interrupt line of the NVIC.
+ * + Named GPIO output "eep_valrdy": Event set when new random value is =
ready
+ *   to be read.
+ * + Named GPIO input "tep_start": Task that triggers start of continuou=
s
+ *   generation of random values.
+ * + Named GPIO input "tep_stop": Task that ends continuous generation o=
f
+ *   random values.
+ *
+ * Accuracy of the peripheral model:
+ * + Stochastic properties of different configurations of the random sou=
rce
+ *   are not modeled.
+ * + Generation of unfiltered and filtered random values take at least t=
he
+ *   average generation time stated in the production specification;
+ *   non-deterministic generation times are not modeled.
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+#ifndef NRF51_RNG_H
+#define NRF51_RNG_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#define TYPE_NRF51_RNG "nrf51_soc.rng"
+#define NRF51_RNG(obj) OBJECT_CHECK(NRF51RNGState, (obj), TYPE_NRF51_RNG=
)
+
+#define NRF51_RNG_SIZE         0x1000
+
+#define NRF51_RNG_TASK_START   0x000
+#define NRF51_RNG_TASK_STOP    0x004
+#define NRF51_RNG_EVENT_VALRDY 0x100
+#define NRF51_RNG_REG_SHORTS   0x200
+#define NRF51_RNG_REG_SHORTS_VALRDY_STOP 0
+#define NRF51_RNG_REG_INTEN    0x300
+#define NRF51_RNG_REG_INTEN_VALRDY 0
+#define NRF51_RNG_REG_INTENSET 0x304
+#define NRF51_RNG_REG_INTENCLR 0x308
+#define NRF51_RNG_REG_CONFIG   0x504
+#define NRF51_RNG_REG_CONFIG_DECEN 0
+#define NRF51_RNG_REG_VALUE    0x508
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    /* Event End Points */
+    qemu_irq eep_valrdy;
+
+    QEMUTimer timer;
+
+    /* Time between generation of successive unfiltered values in us */
+    uint16_t period_unfiltered_us;
+    /* Time between generation of successive filtered values in us */
+    uint16_t period_filtered_us;
+
+    uint8_t value;
+
+    uint32_t active;
+    uint32_t event_valrdy;
+    uint32_t shortcut_stop_on_valrdy;
+    uint32_t interrupt_enabled;
+    uint32_t filter_enabled;
+
+} NRF51RNGState;
+
+
+#endif /* NRF51_RNG_H_ */
--=20
2.19.1
