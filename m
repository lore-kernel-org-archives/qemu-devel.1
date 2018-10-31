Received: from eggs.gnu.org ([2001:4830:134:3::10]:41506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeKe-0004nJ-EL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeKd-0000AP-8c
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:00 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 30 Oct 2018 20:25:16 -0400
Message-Id: <20181031002526.14262-3-contrib@steffen-goertz.de>
In-Reply-To: <20181031002526.14262-1-contrib@steffen-goertz.de>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/13] arm: Add header to host common
 definition for nRF51 SOC peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, "open list:NRF51" <qemu-arm@nongnu.org>

Adds a header that provides definitions that are used
across nRF51 peripherals

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c           | 33 ++++++++++-----------------
 include/hw/arm/nrf51.h       | 44 ++++++++++++++++++++++++++++++++++++
 include/hw/char/nrf51_uart.h |  1 -
 3 files changed, 56 insertions(+), 22 deletions(-)
 create mode 100644 include/hw/arm/nrf51.h

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index b89c1bdea0..55f8eaafcb 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -21,27 +21,16 @@
 #include "qemu/log.h"
 #include "cpu.h"
=20
+#include "hw/arm/nrf51.h"
 #include "hw/arm/nrf51_soc.h"
=20
-#define IOMEM_BASE      0x40000000
-#define IOMEM_SIZE      0x20000000
-
-#define FICR_BASE       0x10000000
-#define FICR_SIZE       0x000000fc
-
-#define FLASH_BASE      0x00000000
-#define SRAM_BASE       0x20000000
-
-#define PRIVATE_BASE    0xF0000000
-#define PRIVATE_SIZE    0x10000000
-
 /*
  * The size and base is for the NRF51822 part. If other parts
  * are supported in the future, add a sub-class of NRF51SoC for
  * the specific variants
  */
-#define NRF51822_FLASH_SIZE     (256 * 1024)
-#define NRF51822_SRAM_SIZE      (16 * 1024)
+#define NRF51822_FLASH_SIZE     (256 * NRF51_PAGE_SIZE)
+#define NRF51822_SRAM_SIZE      (16 * NRF51_PAGE_SIZE)
=20
 #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
=20
@@ -76,14 +65,14 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
         error_propagate(errp, err);
         return;
     }
-    memory_region_add_subregion(&s->container, FLASH_BASE, &s->flash);
+    memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->fla=
sh);
=20
     memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &=
err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
+    memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram=
);
=20
     /* UART */
     object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
@@ -92,15 +81,17 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
         return;
     }
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
-    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0)=
;
+    memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, =
mr, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu),
-                       BASE_TO_IRQ(UART_BASE)));
+                       BASE_TO_IRQ(NRF51_UART_BASE)));
=20
-    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
-    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
+    create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
+                                NRF51_IOMEM_SIZE);
+    create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
+                                NRF51_FICR_SIZE);
     create_unimplemented_device("nrf51_soc.private",
-                                PRIVATE_BASE, PRIVATE_SIZE);
+                                NRF51_PRIVATE_BASE, NRF51_PRIVATE_SIZE);
 }
=20
 static void nrf51_soc_init(Object *obj)
diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
new file mode 100644
index 0000000000..a89b6c23f0
--- /dev/null
+++ b/include/hw/arm/nrf51.h
@@ -0,0 +1,44 @@
+/*
+ * Nordic Semiconductor nRF51 Series SOC Common Defines
+ *
+ * This file hosts generic defines used in various nRF51 peripheral devi=
ces.
+ *
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef NRF51_H
+#define NRF51_H
+
+#define NRF51_FLASH_BASE      0x00000000
+#define NRF51_FICR_BASE       0x10000000
+#define NRF51_FICR_SIZE       0x00000100
+#define NRF51_UICR_BASE       0x10001000
+#define NRF51_SRAM_BASE       0x20000000
+
+#define NRF51_IOMEM_BASE      0x40000000
+#define NRF51_IOMEM_SIZE      0x20000000
+
+#define NRF51_UART_BASE       0x40002000
+#define NRF51_TIMER_BASE      0x40008000
+#define NRF51_RNG_BASE        0x4000D000
+#define NRF51_NVMC_BASE       0x4001E000
+#define NRF51_GPIO_BASE       0x50000000
+
+#define NRF51_PRIVATE_BASE    0xF0000000
+#define NRF51_PRIVATE_SIZE    0x10000000
+
+#define NRF51_PAGE_SIZE       1024
+
+/* Trigger */
+#define NRF51_TRIGGER_TASK 0x01
+
+/* Events */
+#define NRF51_EVENT_CLEAR  0x00
+
+#endif
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
index e3ecb7c81c..eb1c15b490 100644
--- a/include/hw/char/nrf51_uart.h
+++ b/include/hw/char/nrf51_uart.h
@@ -16,7 +16,6 @@
 #include "hw/registerfields.h"
=20
 #define UART_FIFO_LENGTH 6
-#define UART_BASE 0x40002000
 #define UART_SIZE 0x1000
=20
 #define TYPE_NRF51_UART "nrf51_soc.uart"
--=20
2.19.1
