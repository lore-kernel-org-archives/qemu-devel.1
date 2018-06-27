Received: from eggs.gnu.org ([2001:4830:134:3::10]:52109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y2-0007hx-Du
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4xz-0005o6-78
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:18 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:45 +0200
Message-Id: <20180627073351.856-3-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/8] arm: NRF51 Add unimplemented device for MMIO
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
 hw/arm/nrf51_soc.c         | 18 +++++++++++++-----
 include/hw/arm/nrf51_soc.h |  4 +++-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 1f7c159edf..175a009e65 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -48,7 +48,6 @@ struct {
         {.ram_size =3D 32, .flash_size =3D 256 },
 };
=20
-
 static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
 {
     qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n", __func__, =
addr, size);
@@ -125,6 +124,12 @@ static void nrf51_soc_init(Object *obj)
     qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m3"));
=20
+    object_initialize(&s->mmio, sizeof(s->mmio), TYPE_UNIMPLEMENTED_DEVI=
CE);
+    object_property_add_child(obj, "iomem", OBJECT(&s->mmio), &error_abo=
rt);
+    qdev_set_parent_bus(DEVICE(&s->mmio), sysbus_get_default());
+    qdev_prop_set_string(DEVICE(&s->mmio), "name", "nrf51.iomem");
+    qdev_prop_set_uint64(DEVICE(&s->mmio), "size", IOMEM_SIZE);
+
     object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
     object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abor=
t);
     qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
@@ -135,6 +140,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
 {
     NRF51State *s =3D NRF51_SOC(dev_soc);
     Error *err =3D NULL;
+    MemoryRegion *mr =3D NULL;
=20
     if (!(s->part_variant > NRF51_VARIANT_INVALID
             && s->part_variant < NRF51_VARIANT_MAX)) {
@@ -142,6 +148,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
         return;
     }
=20
+    /** SRAM **/
     memory_region_init_ram(&s->sram, NULL, "nrf51_soc.sram",
             NRF51VariantAttributes[s->part_variant].ram_size * PAGE_SIZE=
, &err);
     if (err) {
@@ -150,6 +157,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
     memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
=20
+    /** FLASH **/
     memory_region_init_ram(&s->flash, NULL, "nrf51_soc.flash",
             NRF51VariantAttributes[s->part_variant].flash_size * PAGE_SI=
ZE,
             &err);
@@ -159,6 +167,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
     memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
=20
+    /** MCU **/
     qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 60);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(&s->container),
                                          "memory", &err);
@@ -175,10 +184,9 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
     }
=20
     /* IO space */
-    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
-
-    /* FICR */
-    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
+    object_property_set_bool(OBJECT(&s->mmio), true, "realized", &error_=
fatal);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mmio), 0);
+    memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, mr, -=
1500);
=20
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
     qdev_init_nofail(DEVICE(&s->uart));
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index c9af9659e9..86bc304b57 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -13,8 +13,10 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/unimp.h"
 #include "hw/char/nrf51_uart.h"
=20
+
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
     OBJECT_CHECK(NRF51State, (obj), TYPE_NRF51_SOC)
@@ -27,12 +29,12 @@ typedef struct NRF51State {
     /* TODO: Change to armv6m when cortex-m0 core is available */
     ARMv7MState armv7m;
=20
+    UnimplementedDeviceState mmio;
     Nrf51UART uart;
=20
     MemoryRegion container;
     MemoryRegion sram;
     MemoryRegion flash;
-    MemoryRegion iomem;
     MemoryRegion clock;
     MemoryRegion nvmc;
     MemoryRegion rng;
--=20
2.17.1
