Received: from eggs.gnu.org ([209.51.188.92]:38735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzu-0006fd-VJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmPzu-0002BS-05
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:23:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 21:22:33 +0000
Message-Id: <20190123212234.32068-5-stefanha@redhat.com>
In-Reply-To: <20190123212234.32068-1-stefanha@redhat.com>
References: <20190123212234.32068-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] arm: Instantiate NRF51 special NVM's
 and NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, jusual@mail.ru, Laurent Vivier <lvivier@redhat.com>, jim@groklearning.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Instantiates UICR, FICR, FLASH and NVMC in nRF51 SOC.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/arm/nrf51_soc.h |  2 ++
 hw/arm/nrf51_soc.c         | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index e06f0304b4..c8c91cf9ff 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -15,6 +15,7 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/misc/nrf51_rng.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/nvram/nrf51_nvm.h"
 #include "hw/timer/nrf51_timer.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
@@ -32,6 +33,7 @@ typedef struct NRF51State {
=20
     NRF51UARTState uart;
     NRF51RNGState rng;
+    NRF51NVMState nvm;
     NRF51GPIOState gpio;
     NRF51TimerState timer[NRF51_NUM_TIMERS];
=20
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 1630c27594..b839daea8b 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -29,8 +29,10 @@
  * are supported in the future, add a sub-class of NRF51SoC for
  * the specific variants
  */
-#define NRF51822_FLASH_SIZE     (256 * NRF51_PAGE_SIZE)
-#define NRF51822_SRAM_SIZE      (16 * NRF51_PAGE_SIZE)
+#define NRF51822_FLASH_PAGES    256
+#define NRF51822_SRAM_PAGES     16
+#define NRF51822_FLASH_SIZE     (NRF51822_FLASH_PAGES * NRF51_PAGE_SIZE)
+#define NRF51822_SRAM_SIZE      (NRF51822_SRAM_PAGES * NRF51_PAGE_SIZE)
=20
 #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
=20
@@ -81,14 +83,6 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Er=
ror **errp)
=20
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memor=
y, -1);
=20
-    memory_region_init_rom(&s->flash, OBJECT(s), "nrf51.flash", s->flash=
_size,
-            &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->fla=
sh);
-
     memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &=
err);
     if (err) {
         error_propagate(errp, err);
@@ -121,6 +115,29 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
=20
+    /* UICR, FICR, NVMC, FLASH */
+    object_property_set_uint(OBJECT(&s->nvm), s->flash_size, "flash-size=
",
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->nvm), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 0);
+    memory_region_add_subregion_overlap(&s->container, NRF51_NVMC_BASE, =
mr, 0);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 1);
+    memory_region_add_subregion_overlap(&s->container, NRF51_FICR_BASE, =
mr, 0);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 2);
+    memory_region_add_subregion_overlap(&s->container, NRF51_UICR_BASE, =
mr, 0);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 3);
+    memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE,=
 mr, 0);
+
     /* GPIO */
     object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
     if (err) {
@@ -158,8 +175,6 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
=20
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
-    create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
-                                NRF51_FICR_SIZE);
     create_unimplemented_device("nrf51_soc.private",
                                 NRF51_PRIVATE_BASE, NRF51_PRIVATE_SIZE);
 }
@@ -186,6 +201,8 @@ static void nrf51_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
                            TYPE_NRF51_RNG);
=20
+    sysbus_init_child_obj(obj, "nvm", &s->nvm, sizeof(s->nvm), TYPE_NRF5=
1_NVM);
+
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_NRF51_GPIO);
=20
--=20
2.20.1
