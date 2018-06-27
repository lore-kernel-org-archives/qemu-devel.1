Received: from eggs.gnu.org ([2001:4830:134:3::10]:52211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y6-0007mH-Jp
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y5-0005tf-M3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:22 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:51 +0200
Message-Id: <20180627073351.856-9-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 8/8] arm: Instantiate NVMC in NRF51.
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
 hw/arm/nrf51_soc.c         | 50 +++++++++++++++++++++++---------------
 include/hw/arm/nrf51_soc.h |  3 ++-
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 82e4c2d833..9ff622b792 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -40,6 +40,9 @@
 #define UART_SIZE       0x1000
 #define UART_INT        2
=20
+#define NVMC_BASE       0x4001E000
+#define NVMC_SIZE       0x1000
+
 #define RNG_BASE        0x4000D000
=20
 #define PAGE_SIZE       1024
@@ -182,23 +185,6 @@ static const MemoryRegionOps clock_ops =3D {
     .write =3D clock_write
 };
=20
-static uint64_t nvmc_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    qemu_log_mask(LOG_TRACE, "%s: 0x%" HWADDR_PRIx " [%u]\n", __func__, =
addr, size);
-    return 1;
-}
-
-static void nvmc_write(void *opaque, hwaddr addr, uint64_t data, unsigne=
d int size)
-{
-    qemu_log_mask(LOG_TRACE, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n", __func__, addr, data, size);
-}
-
-
-static const MemoryRegionOps nvmc_ops =3D {
-    .read =3D nvmc_read,
-    .write =3D nvmc_write
-};
-
 static void nrf51_soc_init(Object *obj)
 {
     NRF51State *s =3D NRF51_SOC(obj);
@@ -223,6 +209,10 @@ static void nrf51_soc_init(Object *obj)
     object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abor=
t);
     qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
=20
+    object_initialize(&s->nvmc, sizeof(s->nvmc), TYPE_NRF51_NVMC);
+    object_property_add_child(obj, "nvmc", OBJECT(&s->nvmc), &error_abor=
t);
+    qdev_set_parent_bus(DEVICE(&s->nvmc), sysbus_get_default());
+
     object_initialize(&s->rng, sizeof(s->rng), TYPE_NRF51_RNG);
     object_property_add_child(obj, "rng", OBJECT(&s->rng), &error_abort)=
;
     qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
@@ -309,6 +299,29 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
     qdev_connect_gpio_out_named(DEVICE(&s->uart), "irq", 0,
             qdev_get_gpio_in(DEVICE(&s->armv7m), BASE_TO_IRQ(UART_BASE))=
);
=20
+    /* NVMC */
+    object_property_set_link(OBJECT(&s->nvmc), OBJECT(&s->container),
+                                         "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_uint(OBJECT(&s->nvmc),
+            NRF51VariantAttributes[s->part_variant].flash_size, "code_si=
ze",
+            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->nvmc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvmc), 0);
+    memory_region_add_subregion_overlap(&s->container, NVMC_BASE, mr, 0)=
;
+
     /* RNG */
     object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
     if (err) {
@@ -324,9 +337,6 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     /* STUB Peripherals */
     memory_region_init_io(&s->clock, NULL, &clock_ops, NULL, "nrf51_soc.=
clock", 0x1000);
     memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, &s->c=
lock, -1);
-
-    memory_region_init_io(&s->nvmc, NULL, &nvmc_ops, NULL, "nrf51_soc.nv=
mc", 0x1000);
-    memory_region_add_subregion_overlap(&s->container, 0x4001E000, &s->n=
vmc, -1);
 }
=20
 static Property nrf51_soc_properties[] =3D {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 35dd71c3db..70d9f5863c 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -15,6 +15,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/nrf51_uart.h"
+#include "hw/nvram/nrf51_nvmc.h"
 #include "hw/misc/nrf51_rng.h"
=20
=20
@@ -32,6 +33,7 @@ typedef struct NRF51State {
=20
     UnimplementedDeviceState mmio;
     Nrf51UART uart;
+    Nrf51NVMCState nvmc;
     Nrf51RNGState rng;
=20
     MemoryRegion container;
@@ -40,7 +42,6 @@ typedef struct NRF51State {
     MemoryRegion ficr;
     MemoryRegion uicr;
     MemoryRegion clock;
-    MemoryRegion nvmc;
=20
     /* Properties */
     int32_t part_variant;
--=20
2.17.1
