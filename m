Received: from eggs.gnu.org ([2001:4830:134:3::10]:52916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyw-0006aj-JW
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJyu-0002gt-JV
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:42:54 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:19 -0500
Message-Id: <20181112214224.31560-10-contrib@steffen-goertz.de>
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 09/14] arm: Instantiate NRF51 general
 purpose I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, "open list:NRF51" <qemu-arm@nongnu.org>

Instantiates GPIO peripheral model

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
 include/hw/arm/nrf51_soc.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index e6956f9ef7..893627b7aa 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -116,6 +116,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 3);
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE,=
 mr, 0);
=20
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0);
+    memory_region_add_subregion_overlap(&s->container, NRF51_GPIO_BASE, =
mr, 0);
+
+    /* Pass all GPIOs to the SOC layer so they are available to the boar=
d */
+    qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
+
=20
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
@@ -145,6 +158,9 @@ static void nrf51_soc_init(Object *obj)
=20
     sysbus_init_child_obj(obj, "nvm", &s->nvm, sizeof(s->nvm), TYPE_NRF5=
1_NVM);
=20
+    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
+                          TYPE_NRF51_GPIO);
+
 }
=20
 static Property nrf51_soc_properties[] =3D {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index c3f4d5bcdc..d4a48ccf91 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -15,6 +15,7 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/misc/nrf51_rng.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/gpio/nrf51_gpio.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -30,6 +31,7 @@ typedef struct NRF51State {
     NRF51UARTState uart;
     NRF51RNGState rng;
     NRF51NVMState nvm;
+    NRF51GPIOState gpio;
=20
     MemoryRegion iomem;
     MemoryRegion sram;
--=20
2.19.1
