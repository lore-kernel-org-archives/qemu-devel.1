Received: from eggs.gnu.org ([2001:4830:134:3::10]:52155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y4-0007jk-6k
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y2-0005rj-M4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:20 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:46 +0200
Message-Id: <20180627073351.856-4-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 3/8] arm: NRF51 create UART in-place,
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c           | 30 ++++++++++++++++++++++--------
 hw/char/nrf51_uart.c         | 10 ++++++----
 include/hw/char/nrf51_uart.h | 26 ++++++++------------------
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 175a009e65..bfcacdf447 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -35,8 +35,9 @@
=20
 #define UART_BASE       0x40002000
 #define UART_SIZE       0x1000
+#define UART_INT        2
=20
-#define PAGE_SIZE       0x0400
+#define PAGE_SIZE       1024
=20
=20
 struct {
@@ -148,7 +149,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
         return;
     }
=20
-    /** SRAM **/
+    /* SRAM */
     memory_region_init_ram(&s->sram, NULL, "nrf51_soc.sram",
             NRF51VariantAttributes[s->part_variant].ram_size * PAGE_SIZE=
, &err);
     if (err) {
@@ -157,7 +158,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
     memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
=20
-    /** FLASH **/
+    /* FLASH */
     memory_region_init_ram(&s->flash, NULL, "nrf51_soc.flash",
             NRF51VariantAttributes[s->part_variant].flash_size * PAGE_SI=
ZE,
             &err);
@@ -167,7 +168,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
     memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
=20
-    /** MCU **/
+    /* MCU */
     qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 60);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(&s->container),
                                          "memory", &err);
@@ -184,15 +185,28 @@ static void nrf51_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     }
=20
     /* IO space */
-    object_property_set_bool(OBJECT(&s->mmio), true, "realized", &error_=
fatal);
+    object_property_set_bool(OBJECT(&s->mmio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mmio), 0);
     memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, mr, -=
1500);
=20
+    /* UART */
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    qdev_init_nofail(DEVICE(&s->uart));
-/*    sysbus_mmio_map(s, 0, UART_BASE);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(s->nvic, 2)); */
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
+    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0)=
;
+    qdev_connect_gpio_out_named(DEVICE(&s->uart), "irq", 0,
+            qdev_get_gpio_in(DEVICE(&s->armv7m), UART_INT));
=20
+    /* STUB Peripherals */
     memory_region_init_io(&s->clock, NULL, &clock_ops, NULL, "nrf51_soc.=
clock", 0x1000);
     memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, &s->c=
lock, -1);
=20
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 2da97aa0c4..9c9f4a9c3f 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -13,6 +13,8 @@
 #include "hw/registerfields.h"
 #include "hw/char/nrf51_uart.h"
=20
+#define NRF51_UART_SIZE       0x1000
+
 REG32(STARTRX, 0x000)
 REG32(STOPRX, 0x004)
 REG32(STARTTX, 0x008)
@@ -196,10 +198,10 @@ static void nrf51_uart_init(Object *obj)
     Nrf51UART *s =3D NRF51_UART(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
=20
-    memory_region_init_io(&s->mmio, obj, &uart_ops, s,
-                          "nrf51_soc.uart", 0x1000);
-    sysbus_init_mmio(sbd, &s->mmio);
-    sysbus_init_irq(sbd, &s->irq);
+    memory_region_init_io(&s->iomem, obj, &uart_ops, s,
+            "nrf51_soc.uart", NRF51_UART_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "irq", 1);
 }
=20
 static Property nrf51_uart_properties[] =3D {
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
index 758203f1c3..e0769b90fb 100644
--- a/include/hw/char/nrf51_uart.h
+++ b/include/hw/char/nrf51_uart.h
@@ -6,6 +6,13 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0: Memory Region with tasks, events and registe=
rs
+ *   to be mapped to the peripherals instance address by the SOC.
+ * + Named GPIO output "irq": Interrupt line of the peripheral. Must be
+ *   connected to the respective peripheral interrupt line of the NVIC.
+ *
  */
=20
 #ifndef NRF51_UART_H
@@ -21,8 +28,8 @@
=20
 typedef struct Nrf51UART {
     SysBusDevice parent_obj;
+    MemoryRegion iomem;
=20
-    MemoryRegion mmio;
     CharBackend chr;
     qemu_irq irq;
     guint watch_tag;
@@ -34,21 +41,4 @@ typedef struct Nrf51UART {
     uint32_t reg[0x1000];
 } Nrf51UART;
=20
-static inline DeviceState *nrf51_uart_create(hwaddr addr,
-                                             qemu_irq irq,
-                                             Chardev *chr)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev =3D qdev_create(NULL, "nrf51_soc.uart");
-    s =3D SYS_BUS_DEVICE(dev);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(s, 0, addr);
-    sysbus_connect_irq(s, 0, irq);
-
-    return dev;
-}
-
 #endif
--=20
2.17.1
