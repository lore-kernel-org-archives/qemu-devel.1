Received: from eggs.gnu.org ([2001:4830:134:3::10]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UB-0007Wv-61
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U9-0004bX-Cv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8U7-0004PP-Bj
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U4-0006aC-Q1
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:24 +0100
Message-Id: <20180824093343.11346-34-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/52] hw/ssi/pl022: Allow use as
 embedded-struct device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create a new include file for the pl022's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

While we're adding the new file to MAINTAINERS, add
also the .c file, which was missing an entry.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180820141116.9118-16-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
