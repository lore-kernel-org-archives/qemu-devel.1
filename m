Received: from eggs.gnu.org ([2001:4830:134:3::10]:42131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuF-0003eW-9E
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuE-0007Oq-4j
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:09 +0100
Message-Id: <20180820141116.9118-16-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 15/22] hw/ssi/pl022: Allow use as
 embedded-struct device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Create a new include file for the pl022's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

While we're adding the new file to MAINTAINERS, add
also the .c file, which was missing an entry.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/pl022.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 hw/ssi/pl022.c         | 26 +--------------------
 MAINTAINERS            |  2 ++
 3 files changed, 54 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/ssi/pl022.h

diff --git a/include/hw/ssi/pl022.h b/include/hw/ssi/pl022.h
new file mode 100644
index 00000000000..a080519366d
--- /dev/null
+++ b/include/hw/ssi/pl022.h
@@ -0,0 +1,51 @@
+/*
+ * ARM PrimeCell PL022 Synchronous Serial Port
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+/* This is a model of the Arm PrimeCell PL022 synchronous serial port.
+ * The PL022 TRM is:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.ddi0194h/DDI0194H_ssp_pl022_trm.pdf
+ *
+ * QEMU interface:
+ * + sysbus IRQ: SSPINTR combined interrupt line
+ * + sysbus MMIO region 0: MemoryRegion for the device's registers
+ */
+
+#ifndef HW_SSI_PL022_H
+#define HW_SSI_PL022_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_PL022 "pl022"
+#define PL022(obj) OBJECT_CHECK(PL022State, (obj), TYPE_PL022)
+
+typedef struct PL022State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t cr0;
+    uint32_t cr1;
+    uint32_t bitmask;
+    uint32_t sr;
+    uint32_t cpsr;
+    uint32_t is;
+    uint32_t im;
+    /* The FIFO head points to the next empty entry.  */
+    int tx_fifo_head;
+    int rx_fifo_head;
+    int tx_fifo_len;
+    int rx_fifo_len;
+    uint16_t tx_fifo[8];
+    uint16_t rx_fifo[8];
+    qemu_irq irq;
+    SSIBus *ssi;
+} PL022State;
+
+#endif
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index c1368018ee3..379d3093987 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/ssi/pl022.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"
 
@@ -41,31 +42,6 @@ do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__);} while (0)
 #define PL022_INT_RX  0x04
 #define PL022_INT_TX  0x08
 
-#define TYPE_PL022 "pl022"
-#define PL022(obj) OBJECT_CHECK(PL022State, (obj), TYPE_PL022)
-
-typedef struct PL022State {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint32_t cr0;
-    uint32_t cr1;
-    uint32_t bitmask;
-    uint32_t sr;
-    uint32_t cpsr;
-    uint32_t is;
-    uint32_t im;
-    /* The FIFO head points to the next empty entry.  */
-    int tx_fifo_head;
-    int rx_fifo_head;
-    int tx_fifo_len;
-    int rx_fifo_len;
-    uint16_t tx_fifo[8];
-    uint16_t rx_fifo[8];
-    qemu_irq irq;
-    SSIBus *ssi;
-} PL022State;
-
 static const unsigned char pl022_id[8] =
   { 0x22, 0x10, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 
diff --git a/MAINTAINERS b/MAINTAINERS
index b2f8b562dc5..1e81ad8d4b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -451,6 +451,8 @@ F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: hw/intc/pl190.c
 F: hw/sd/pl181.c
+F: hw/ssi/pl022.c
+F: include/hw/ssi/pl022.h
 F: hw/timer/pl031.c
 F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
-- 
2.18.0
