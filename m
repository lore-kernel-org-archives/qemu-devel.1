Received: from eggs.gnu.org ([209.51.188.92]:40410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpN-0000MM-Lh
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghWpM-0007cM-6J
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:40:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Jan 2019 09:40:19 +0000
Message-Id: <20190110094020.18354-2-stefanha@redhat.com>
In-Reply-To: <20190110094020.18354-1-stefanha@redhat.com>
References: <20190110094020.18354-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, Thomas Huth <thuth@redhat.com>, contrib@steffen-goertz.de, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Recent microbit firmwares panic if the TWI magnetometer/accelerometer
devices are not detected during startup.  We don't implement TWI (I2C)
so let's stub out these devices just to let the firmware boot.

Signed-off by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/i2c/Makefile.objs          |   1 +
 include/hw/arm/nrf51.h        |   2 +
 include/hw/arm/nrf51_soc.h    |   1 +
 include/hw/i2c/microbit_i2c.h |  42 +++++++++++
 hw/arm/microbit.c             |  15 ++++
 hw/i2c/microbit_i2c.c         | 127 ++++++++++++++++++++++++++++++++++
 6 files changed, 188 insertions(+)
 create mode 100644 include/hw/i2c/microbit_i2c.h
 create mode 100644 hw/i2c/microbit_i2c.c

diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 37cacde978..82e747e1cd 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -7,5 +7,6 @@ common-obj-$(CONFIG_BITBANG_I2C) +=3D bitbang_i2c.o
 common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
+common-obj-$(CONFIG_NRF51_SOC) +=3D microbit_i2c.o
 obj-$(CONFIG_OMAP) +=3D omap_i2c.o
 obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
index 175bb6c301..1008fee6c9 100644
--- a/include/hw/arm/nrf51.h
+++ b/include/hw/arm/nrf51.h
@@ -25,6 +25,8 @@
 #define NRF51_IOMEM_SIZE      0x20000000
=20
 #define NRF51_UART_BASE       0x40002000
+#define NRF51_TWI_BASE        0x40003000
+#define NRF51_TWI_SIZE        0x00001000
 #define NRF51_TIMER_BASE      0x40008000
 #define NRF51_TIMER_SIZE      0x00001000
 #define NRF51_RNG_BASE        0x4000D000
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index e06f0304b4..fbdefc07e4 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -39,6 +39,7 @@ typedef struct NRF51State {
     MemoryRegion sram;
     MemoryRegion flash;
     MemoryRegion clock;
+    MemoryRegion twi;
=20
     uint32_t sram_size;
     uint32_t flash_size;
diff --git a/include/hw/i2c/microbit_i2c.h b/include/hw/i2c/microbit_i2c.=
h
new file mode 100644
index 0000000000..aad636127e
--- /dev/null
+++ b/include/hw/i2c/microbit_i2c.h
@@ -0,0 +1,42 @@
+/*
+ * Microbit stub for Nordic Semiconductor nRF51 SoC Two-Wire Interface
+ * http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.1.pdf
+ *
+ * Copyright 2019 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef MICROBIT_I2C_H
+#define MICROBIT_I2C_H
+
+#include "hw/sysbus.h"
+#include "hw/arm/nrf51.h"
+
+#define NRF51_TWI_TASK_STARTRX 0x000
+#define NRF51_TWI_TASK_STARTTX 0x008
+#define NRF51_TWI_TASK_STOP 0x014
+#define NRF51_TWI_EVENT_STOPPED 0x104
+#define NRF51_TWI_EVENT_RXDREADY 0x108
+#define NRF51_TWI_EVENT_TXDSENT 0x11c
+#define NRF51_TWI_REG_ENABLE 0x500
+#define NRF51_TWI_REG_RXD 0x518
+#define NRF51_TWI_REG_TXD 0x51c
+#define NRF51_TWI_REG_ADDRESS 0x588
+
+#define TYPE_MICROBIT_I2C "microbit.i2c"
+#define MICROBIT_I2C(obj) \
+    OBJECT_CHECK(MicrobitI2CState, (obj), TYPE_MICROBIT_I2C)
+
+#define MICROBIT_I2C_NREGS (NRF51_TWI_SIZE / sizeof(uint32_t))
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t regs[MICROBIT_I2C_NREGS];
+    uint32_t read_idx;
+} MicrobitI2CState;
+
+#endif /* MICROBIT_I2C_H */
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index a734e7f650..84d1b8dd2b 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -16,11 +16,13 @@
 #include "exec/address-spaces.h"
=20
 #include "hw/arm/nrf51_soc.h"
+#include "hw/i2c/microbit_i2c.h"
=20
 typedef struct {
     MachineState parent;
=20
     NRF51State nrf51;
+    MicrobitI2CState i2c;
 } MicrobitMachineState;
=20
 #define TYPE_MICROBIT_MACHINE MACHINE_TYPE_NAME("microbit")
@@ -32,7 +34,9 @@ static void microbit_init(MachineState *machine)
 {
     MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
     MemoryRegion *system_memory =3D get_system_memory();
+    MemoryRegion *mr;
     Object *soc =3D OBJECT(&s->nrf51);
+    Object *i2c =3D OBJECT(&s->i2c);
=20
     sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51=
),
                           TYPE_NRF51_SOC);
@@ -41,6 +45,17 @@ static void microbit_init(MachineState *machine)
                              &error_fatal);
     object_property_set_bool(soc, true, "realized", &error_fatal);
=20
+    /* Overlap the TWI stub device into the SoC.  This is a microbit-spe=
cific
+     * hack until we implement the nRF51 TWI controller properly and the
+     * magnetometer/accelerometer devices.
+     */
+    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
+                          sizeof(s->i2c), TYPE_MICROBIT_I2C);
+    object_property_set_bool(i2c, true, "realized", &error_fatal);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
+    memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_B=
ASE,
+                                        mr, -1);
+
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        NRF51_SOC(soc)->flash_size);
 }
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
new file mode 100644
index 0000000000..793f1b0f8b
--- /dev/null
+++ b/hw/i2c/microbit_i2c.c
@@ -0,0 +1,127 @@
+/*
+ * Microbit stub for Nordic Semiconductor nRF51 SoC Two-Wire Interface
+ * http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.1.pdf
+ *
+ * This is a microbit-specific stub for the TWI controller on the nRF51 =
SoC.
+ * We don't emulate I2C devices but the firmware probes the
+ * accelerometer/magnetometer on startup and panics if they are not foun=
d.
+ * Therefore we stub out the probing.
+ *
+ * In the future this file could evolve into a full nRF51 TWI controller
+ * device.
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ * Copyright 2019 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/i2c/microbit_i2c.h"
+
+static const uint32_t twi_read_sequence[] =3D {0x5A, 0x5A, 0x40};
+
+static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned in=
t size)
+{
+    MicrobitI2CState *s =3D opaque;
+    uint64_t data =3D 0x00;
+
+    switch (addr) {
+    case NRF51_TWI_EVENT_STOPPED:
+        data =3D 0x01;
+        break;
+    case NRF51_TWI_EVENT_RXDREADY:
+        data =3D 0x01;
+        break;
+    case NRF51_TWI_EVENT_TXDSENT:
+        data =3D 0x01;
+        break;
+    case NRF51_TWI_REG_RXD:
+        data =3D twi_read_sequence[s->read_idx];
+        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
+            s->read_idx++;
+        }
+        break;
+    default:
+        data =3D s->regs[addr / sizeof(s->regs[0])];
+        break;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u] =3D %" PRIx32 =
"\n",
+                  __func__, addr, size, (uint32_t)data);
+
+
+    return data;
+}
+
+static void microbit_i2c_write(void *opaque, hwaddr addr, uint64_t data,
+                               unsigned int size)
+{
+    MicrobitI2CState *s =3D opaque;
+
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
+                  __func__, addr, data, size);
+    s->regs[addr / sizeof(s->regs[0])] =3D data;
+}
+
+static const MemoryRegionOps microbit_i2c_ops =3D {
+    .read =3D microbit_i2c_read,
+    .write =3D microbit_i2c_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+};
+
+static const VMStateDescription microbit_i2c_vmstate =3D {
+    .name =3D TYPE_MICROBIT_I2C,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, MicrobitI2CState, MICROBIT_I2C_NREGS)=
,
+        VMSTATE_UINT32(read_idx, MicrobitI2CState),
+    },
+};
+
+static void microbit_i2c_reset(DeviceState *dev)
+{
+    MicrobitI2CState *s =3D MICROBIT_I2C(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->read_idx =3D 0;
+}
+
+static void microbit_i2c_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    MicrobitI2CState *s =3D MICROBIT_I2C(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &microbit_i2c_ops, s,
+                          "microbit.twi", NRF51_TWI_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void microbit_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &microbit_i2c_vmstate;
+    dc->reset =3D microbit_i2c_reset;
+    dc->realize =3D microbit_i2c_realize;
+    dc->desc =3D "Microbit I2C controller";
+}
+
+static const TypeInfo microbit_i2c_info =3D {
+    .name =3D TYPE_MICROBIT_I2C,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(MicrobitI2CState),
+    .class_init =3D microbit_i2c_class_init,
+};
+
+static void microbit_i2c_register_types(void)
+{
+    type_register_static(&microbit_i2c_info);
+}
+
+type_init(microbit_i2c_register_types)
--=20
2.20.1
