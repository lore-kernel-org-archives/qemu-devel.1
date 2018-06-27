Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y6-0007mE-Jo
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y5-0005tS-0Z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:22 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:49 +0200
Message-Id: <20180627073351.856-7-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 6/8] arm: Add UICR/FICR handling to NRF51 SOC
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

This patch maps preallocated user/factory information
configuration registers to the NRF51 SOC.
See NRF51 reference manual section 7 and 8.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c         | 174 ++++++++++++++++++++++++++++++-------
 include/hw/arm/nrf51_soc.h |   5 +-
 2 files changed, 145 insertions(+), 34 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index e93699a4b0..82e4c2d833 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -19,7 +19,6 @@
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "crypto/random.h"
=20
 #include "hw/arm/nrf51_soc.h"
=20
@@ -29,6 +28,9 @@
 #define FICR_BASE       0x10000000
 #define FICR_SIZE       0x100
=20
+#define UICR_BASE       0x10001000
+#define UICR_SIZE       0x100
+
 #define SRAM_BASE       0x20000000
=20
 #define IOMEM_BASE      0x40000000
@@ -54,9 +56,118 @@ struct {
         {.ram_size =3D 32, .flash_size =3D 256 },
 };
=20
+/*
+FICR Registers Assignments
+CODEPAGESIZE      0x010      [4,
+CODESIZE          0x014       5,
+CLENR0            0x028       10,
+PPFC              0x02C       11,
+NUMRAMBLOCK       0x034       13,
+SIZERAMBLOCKS     0x038       14,
+SIZERAMBLOCK[0]   0x038       14,
+SIZERAMBLOCK[1]   0x03C       15,
+SIZERAMBLOCK[2]   0x040       16,
+SIZERAMBLOCK[3]   0x044       17,
+CONFIGID          0x05C       23,
+DEVICEID[0]       0x060       24,
+DEVICEID[1]       0x064       25,
+ER[0]             0x080       32,
+ER[1]             0x084       33,
+ER[2]             0x088       34,
+ER[3]             0x08C       35,
+IR[0]             0x090       36,
+IR[1]             0x094       37,
+IR[2]             0x098       38,
+IR[3]             0x09C       39,
+DEVICEADDRTYPE    0x0A0       40,
+DEVICEADDR[0]     0x0A4       41,
+DEVICEADDR[1]     0x0A8       42,
+OVERRIDEEN        0x0AC       43,
+NRF_1MBIT[0]      0x0B0       44,
+NRF_1MBIT[1]      0x0B4       45,
+NRF_1MBIT[2]      0x0B8       46,
+NRF_1MBIT[3]      0x0BC       47,
+NRF_1MBIT[4]      0x0C0       48,
+BLE_1MBIT[0]      0x0EC       59,
+BLE_1MBIT[1]      0x0F0       60,
+BLE_1MBIT[2]      0x0F4       61,
+BLE_1MBIT[3]      0x0F8       62,
+BLE_1MBIT[4]      0x0FC       63]
+*/
+
+static const uint32_t ficr_content[64] =3D { 0xFFFFFFFF, 0xFFFFFFFF, 0xF=
FFFFFFF,
+        0xFFFFFFFF, 0x00000400, 0x00000100, 0xFFFFFFFF, 0xFFFFFFFF, 0x00=
000002,
+        0x00002000, 0x00002000, 0x00002000, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000003, 0x12345678, 0x9A=
BCDEF1,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, };
+
+static uint64_t ficr_read(void *opaque, hwaddr offset, unsigned int size=
)
+{
+    qemu_log_mask(LOG_TRACE, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+            __func__, offset, size);
+
+    if (offset > (ARRAY_SIZE(ficr_content) - size)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n", __func__, of=
fset);
+        return 0;
+    }
+
+    return ficr_content[offset >> 2];
+}
+
+static const MemoryRegionOps ficr_ops =3D {
+    .read =3D ficr_read,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+    .impl.unaligned =3D false,
+};
+
+static const uint32_t uicr_content[64] =3D { 0xFFFFFFFF, 0xFFFFFFFF, 0xF=
FFFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFF=
FFFFFF,
+        0xFFFFFFFF, };
+
+static uint64_t uicr_read(void *opaque, hwaddr offset, unsigned int size=
)
+{
+    qemu_log_mask(LOG_TRACE, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+            __func__, offset, size);
+
+    if (offset > (ARRAY_SIZE(uicr_content) - size)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n", __func__, of=
fset);
+        return 0;
+    }
+
+    return uicr_content[offset >> 2];
+}
+
+static const MemoryRegionOps uicr_ops =3D {
+    .read =3D uicr_read,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
+    .impl.unaligned =3D false,
+};
+
+
 static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n", __func__, =
addr, size);
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+            __func__, addr, size);
     return 1;
 }
=20
@@ -88,34 +199,6 @@ static const MemoryRegionOps nvmc_ops =3D {
     .write =3D nvmc_write
 };
=20
-static uint64_t rng_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    uint64_t r =3D 0;
-
-    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n", __func__, =
addr, size);
-
-    switch (addr) {
-    case 0x508:
-        qcrypto_random_bytes((uint8_t *)&r, 1, NULL);
-        break;
-    default:
-        r =3D 1;
-        break;
-    }
-    return r;
-}
-
-static void rng_write(void *opaque, hwaddr addr, uint64_t data, unsigned=
 int size)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n", __func__, addr, data, size);
-}
-
-
-static const MemoryRegionOps rng_ops =3D {
-    .read =3D rng_read,
-    .write =3D rng_write
-};
-
 static void nrf51_soc_init(Object *obj)
 {
     NRF51State *s =3D NRF51_SOC(obj);
@@ -139,6 +222,10 @@ static void nrf51_soc_init(Object *obj)
     object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
     object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abor=
t);
     qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
+
+    object_initialize(&s->rng, sizeof(s->rng), TYPE_NRF51_RNG);
+    object_property_add_child(obj, "rng", OBJECT(&s->rng), &error_abort)=
;
+    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
 }
=20
=20
@@ -197,6 +284,18 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mmio), 0);
     memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, mr, -=
1500);
=20
+    /* FICR */
+    memory_region_init_io(&s->ficr, NULL, &ficr_ops, NULL, "nrf51_soc.fi=
cr",
+            FICR_SIZE);
+    memory_region_set_readonly(&s->ficr, true);
+    memory_region_add_subregion_overlap(&s->container, FICR_BASE, &s->fi=
cr, 0);
+
+    /* UICR */
+    memory_region_init_io(&s->uicr, NULL, &uicr_ops, NULL, "nrf51_soc.ui=
cr",
+            UICR_SIZE);
+    memory_region_set_readonly(&s->uicr, true);
+    memory_region_add_subregion_overlap(&s->container, UICR_BASE, &s->ui=
cr, 0);
+
     /* UART */
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
     object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
@@ -210,15 +309,24 @@ static void nrf51_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     qdev_connect_gpio_out_named(DEVICE(&s->uart), "irq", 0,
             qdev_get_gpio_in(DEVICE(&s->armv7m), BASE_TO_IRQ(UART_BASE))=
);
=20
+    /* RNG */
+    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
+    memory_region_add_subregion_overlap(&s->container, RNG_BASE, mr, 0);
+    qdev_connect_gpio_out_named(DEVICE(&s->rng), "irq", 0,
+            qdev_get_gpio_in(DEVICE(&s->armv7m), BASE_TO_IRQ(RNG_BASE)))=
;
+
     /* STUB Peripherals */
     memory_region_init_io(&s->clock, NULL, &clock_ops, NULL, "nrf51_soc.=
clock", 0x1000);
     memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, &s->c=
lock, -1);
=20
     memory_region_init_io(&s->nvmc, NULL, &nvmc_ops, NULL, "nrf51_soc.nv=
mc", 0x1000);
     memory_region_add_subregion_overlap(&s->container, 0x4001E000, &s->n=
vmc, -1);
-
-    memory_region_init_io(&s->rng, NULL, &rng_ops, NULL, "nrf51_soc.rng"=
, 0x1000);
-    memory_region_add_subregion_overlap(&s->container, 0x4000D000, &s->r=
ng, -1);
 }
=20
 static Property nrf51_soc_properties[] =3D {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 86bc304b57..35dd71c3db 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -15,6 +15,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/nrf51_uart.h"
+#include "hw/misc/nrf51_rng.h"
=20
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
@@ -31,13 +32,15 @@ typedef struct NRF51State {
=20
     UnimplementedDeviceState mmio;
     Nrf51UART uart;
+    Nrf51RNGState rng;
=20
     MemoryRegion container;
     MemoryRegion sram;
     MemoryRegion flash;
+    MemoryRegion ficr;
+    MemoryRegion uicr;
     MemoryRegion clock;
     MemoryRegion nvmc;
-    MemoryRegion rng;
=20
     /* Properties */
     int32_t part_variant;
--=20
2.17.1
