Received: from eggs.gnu.org ([2001:4830:134:3::10]:52108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y2-0007ht-DP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4xz-0005oJ-Gt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:18 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:44 +0200
Message-Id: <20180627073351.856-2-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 1/8] arm: NRF51/Microbit Memory container and SOC
 variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/microbit.c          |  8 ++--
 hw/arm/nrf51_soc.c         | 98 +++++++++++++++++++++++++++-----------
 include/hw/arm/nrf51_soc.h | 24 ++++++++--
 3 files changed, 95 insertions(+), 35 deletions(-)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index b61d0747fe..9deb1a36ca 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "hw/arm/arm.h"
=20
 #include "hw/arm/nrf51_soc.h"
=20
@@ -18,10 +19,11 @@ static void microbit_init(MachineState *machine)
     DeviceState *dev;
=20
     dev =3D qdev_create(NULL, TYPE_NRF51_SOC);
-    if (machine->kernel_filename) {
-        qdev_prop_set_string(dev, "kernel-filename", machine->kernel_fil=
ename);
-    }
+    qdev_prop_set_uint32(DEVICE(dev), "VARIANT", NRF51_VARIANT_AA);
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal=
);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+            0x00000000);
 }
=20
 static void microbit_machine_init(MachineClass *mc)
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index b9f309aa6b..1f7c159edf 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -22,23 +22,33 @@
 #include "crypto/random.h"
=20
 #include "hw/arm/nrf51_soc.h"
-#include "hw/char/nrf51_uart.h"
=20
 #define IOMEM_BASE      0x40000000
 #define IOMEM_SIZE      0x20000000
=20
 #define FLASH_BASE      0x00000000
-#define FLASH_SIZE      (256 * 1024)
=20
 #define FICR_BASE       0x10000000
 #define FICR_SIZE       0x100
=20
 #define SRAM_BASE       0x20000000
-#define SRAM_SIZE       (16 * 1024)
=20
 #define UART_BASE       0x40002000
 #define UART_SIZE       0x1000
=20
+#define PAGE_SIZE       0x0400
+
+
+struct {
+  hwaddr ram_size;
+  hwaddr flash_size;
+} NRF51VariantAttributes[] =3D {
+        {.ram_size =3D 16, .flash_size =3D 256 },
+        {.ram_size =3D 16, .flash_size =3D 128 },
+        {.ram_size =3D 32, .flash_size =3D 256 },
+};
+
+
 static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
 {
     qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n", __func__, =
addr, size);
@@ -101,62 +111,93 @@ static const MemoryRegionOps rng_ops =3D {
     .write =3D rng_write
 };
=20
+static void nrf51_soc_init(Object *obj)
+{
+    NRF51State *s =3D NRF51_SOC(obj);
+
+    memory_region_init(&s->container, obj, "microbit-container",
+            UINT64_MAX);
+
+    /* TODO: Change to armv6m when cortex-m0 core is available */
+    object_initialize(&s->armv7m, sizeof(s->armv7m), TYPE_ARMV7M);
+    object_property_add_child(obj, "armv7m", OBJECT(&s->armv7m), &error_=
abort);
+    qdev_set_parent_bus(DEVICE(&s->armv7m), sysbus_get_default());
+    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-m3"));
+
+    object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
+    object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abor=
t);
+    qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
+}
+
=20
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s =3D NRF51_SOC(dev_soc);
     Error *err =3D NULL;
=20
-    /* IO space */
-    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
-
-    /* FICR */
-    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
+    if (!(s->part_variant > NRF51_VARIANT_INVALID
+            && s->part_variant < NRF51_VARIANT_MAX)) {
+        error_setg(errp, "VARIANT not set or invalid");
+        return;
+    }
=20
-    MemoryRegion *system_memory =3D get_system_memory();
-    MemoryRegion *sram =3D g_new(MemoryRegion, 1);
-    MemoryRegion *flash =3D g_new(MemoryRegion, 1);
+    memory_region_init_ram(&s->sram, NULL, "nrf51_soc.sram",
+            NRF51VariantAttributes[s->part_variant].ram_size * PAGE_SIZE=
, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
=20
-    memory_region_init_ram_nomigrate(flash, NULL, "nrf51.flash", FLASH_S=
IZE,
+    memory_region_init_ram(&s->flash, NULL, "nrf51_soc.flash",
+            NRF51VariantAttributes[s->part_variant].flash_size * PAGE_SI=
ZE,
             &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
+    memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
=20
-    vmstate_register_ram_global(flash);
-    memory_region_set_readonly(flash, true);
+    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 60);
+    object_property_set_link(OBJECT(&s->armv7m), OBJECT(&s->container),
+                                         "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
=20
-    memory_region_add_subregion(system_memory, FLASH_BASE, flash);
=20
-    memory_region_init_ram_nomigrate(sram, NULL, "nrf51.sram", SRAM_SIZE=
,
-            &err);
+    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err)=
;
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    vmstate_register_ram_global(sram);
-    memory_region_add_subregion(system_memory, SRAM_BASE, sram);
=20
-    /* TODO: implement a cortex m0 and update this */
-    s->nvic =3D armv7m_init(get_system_memory(), FLASH_SIZE, 96,
-               s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
+    /* IO space */
+    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
+
+    /* FICR */
+    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
=20
-    s->uart =3D nrf51_uart_create(UART_BASE, qdev_get_gpio_in(s->nvic, 2=
),
-                                serial_hd(0));
+    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
+    qdev_init_nofail(DEVICE(&s->uart));
+/*    sysbus_mmio_map(s, 0, UART_BASE);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(s->nvic, 2)); */
=20
     memory_region_init_io(&s->clock, NULL, &clock_ops, NULL, "nrf51_soc.=
clock", 0x1000);
-    memory_region_add_subregion_overlap(get_system_memory(), IOMEM_BASE,=
 &s->clock, -1);
+    memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, &s->c=
lock, -1);
=20
     memory_region_init_io(&s->nvmc, NULL, &nvmc_ops, NULL, "nrf51_soc.nv=
mc", 0x1000);
-    memory_region_add_subregion_overlap(get_system_memory(), 0x4001E000,=
 &s->nvmc, -1);
+    memory_region_add_subregion_overlap(&s->container, 0x4001E000, &s->n=
vmc, -1);
=20
     memory_region_init_io(&s->rng, NULL, &rng_ops, NULL, "nrf51_soc.rng"=
, 0x1000);
-    memory_region_add_subregion_overlap(get_system_memory(), 0x4000D000,=
 &s->rng, -1);
+    memory_region_add_subregion_overlap(&s->container, 0x4000D000, &s->r=
ng, -1);
 }
=20
 static Property nrf51_soc_properties[] =3D {
-    DEFINE_PROP_STRING("kernel-filename", NRF51State, kernel_filename),
+    DEFINE_PROP_INT32("VARIANT", NRF51State, part_variant,
+            NRF51_VARIANT_INVALID),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -172,6 +213,7 @@ static const TypeInfo nrf51_soc_info =3D {
     .name          =3D TYPE_NRF51_SOC,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(NRF51State),
+    .instance_init =3D nrf51_soc_init,
     .class_init    =3D nrf51_soc_class_init,
 };
=20
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index f81cbbe3ce..c9af9659e9 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -12,6 +12,8 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/arm/armv7m.h"
+#include "hw/char/nrf51_uart.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -22,16 +24,30 @@ typedef struct NRF51State {
     SysBusDevice parent_obj;
=20
     /*< public >*/
-    char *kernel_filename;
-    DeviceState *nvic;
-    DeviceState *uart;
+    /* TODO: Change to armv6m when cortex-m0 core is available */
+    ARMv7MState armv7m;
=20
-    MemoryRegion iomem;
+    Nrf51UART uart;
=20
+    MemoryRegion container;
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion iomem;
     MemoryRegion clock;
     MemoryRegion nvmc;
     MemoryRegion rng;
+
+    /* Properties */
+    int32_t part_variant;
 } NRF51State;
=20
+typedef enum {
+    NRF51_VARIANT_INVALID =3D -1,
+    NRF51_VARIANT_AA =3D 0,
+    NRF51_VARIANT_AB =3D 1,
+    NRF51_VARIANT_AC =3D 2,
+    NRF51_VARIANT_MAX =3D 3
+} NRF51Variants;
+
 #endif
=20
--=20
2.17.1
