Received: from eggs.gnu.org ([2001:4830:134:3::10]:52132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y3-0007iq-Ei
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4y2-0005rX-Jk
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:19 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:47 +0200
Message-Id: <20180627073351.856-5-contrib@steffen-goertz.de>
In-Reply-To: <20180627073351.856-1-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 4/8] arm: NRF51 Calculate peripheral id from base
 address
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

The base address determines a peripherals id, which identifies its
interrupt line, see NRF51 reference manual section 10 peripheral
interface. This little gem calculates the peripheral id based
on its base address.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index bfcacdf447..e93699a4b0 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -23,8 +23,6 @@
=20
 #include "hw/arm/nrf51_soc.h"
=20
-#define IOMEM_BASE      0x40000000
-#define IOMEM_SIZE      0x20000000
=20
 #define FLASH_BASE      0x00000000
=20
@@ -33,12 +31,19 @@
=20
 #define SRAM_BASE       0x20000000
=20
+#define IOMEM_BASE      0x40000000
+#define IOMEM_SIZE      0x20000000
+
 #define UART_BASE       0x40002000
 #define UART_SIZE       0x1000
 #define UART_INT        2
=20
+#define RNG_BASE        0x4000D000
+
 #define PAGE_SIZE       1024
=20
+#define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
+
=20
 struct {
   hwaddr ram_size;
@@ -177,7 +182,6 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
         return;
     }
=20
-
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err)=
;
     if (err) {
         error_propagate(errp, err);
@@ -204,7 +208,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
     memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0)=
;
     qdev_connect_gpio_out_named(DEVICE(&s->uart), "irq", 0,
-            qdev_get_gpio_in(DEVICE(&s->armv7m), UART_INT));
+            qdev_get_gpio_in(DEVICE(&s->armv7m), BASE_TO_IRQ(UART_BASE))=
);
=20
     /* STUB Peripherals */
     memory_region_init_io(&s->clock, NULL, &clock_ops, NULL, "nrf51_soc.=
clock", 0x1000);
--=20
2.17.1
