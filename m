Received: from eggs.gnu.org ([2001:4830:134:3::10]:37212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUM-00040H-Pt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUL-0005eW-PY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUL-0005cL-HH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUK-0003Di-KL
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:07 +0100
Message-Id: <20180820103212.2810-21-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/25] hw/dma/pl080: Allow use as
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

Create a new include file for the pl081's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/dma/pl080.h | 62 ++++++++++++++++++++++++++++++++++++++++++
 hw/dma/pl080.c         | 34 ++---------------------
 MAINTAINERS            |  1 +
 3 files changed, 65 insertions(+), 32 deletions(-)
 create mode 100644 include/hw/dma/pl080.h

diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
new file mode 100644
index 00000000000..7deb46c8578
--- /dev/null
+++ b/include/hw/dma/pl080.h
@@ -0,0 +1,62 @@
+/*
+ * ARM PrimeCell PL080/PL081 DMA controller
+ *
+ * Copyright (c) 2006 CodeSourcery.
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Paul Brook, Peter Maydell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+/* This is a model of the Arm PrimeCell PL080/PL081 DMA controller:
+ * The PL080 TRM is:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.ddi0196g/DDI0196.pdf
+ * and the PL081 TRM is:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.ddi0218e/DDI0218.pdf
+ *
+ * QEMU interface:
+ * + sysbus IRQ: DMACINTR combined interrupt line
+ * + sysbus MMIO region 0: MemoryRegion for the device's registers
+ */
+
+#ifndef HW_DMA_PL080_H
+#define HW_DMA_PL080_H
+
+#include "hw/sysbus.h"
+
+#define PL080_MAX_CHANNELS 8
+
+typedef struct {
+    uint32_t src;
+    uint32_t dest;
+    uint32_t lli;
+    uint32_t ctrl;
+    uint32_t conf;
+} pl080_channel;
+
+#define TYPE_PL080 "pl080"
+#define TYPE_PL081 "pl081"
+#define PL080(obj) OBJECT_CHECK(PL080State, (obj), TYPE_PL080)
+
+typedef struct PL080State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint8_t tc_int;
+    uint8_t tc_mask;
+    uint8_t err_int;
+    uint8_t err_mask;
+    uint32_t conf;
+    uint32_t sync;
+    uint32_t req_single;
+    uint32_t req_burst;
+    pl080_channel chan[PL080_MAX_CHANNELS];
+    int nchannels;
+    /* Flag to avoid recursive DMA invocations.  */
+    int running;
+    qemu_irq irq;
+} PL080State;
+
+#endif
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 7724c93b8f2..0f79c2d8a6c 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -11,8 +11,8 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "hw/dma/pl080.h"
 
-#define PL080_MAX_CHANNELS 8
 #define PL080_CONF_E    0x1
 #define PL080_CONF_M1   0x2
 #define PL080_CONF_M2   0x4
@@ -30,36 +30,6 @@
 #define PL080_CCTRL_D   0x02000000
 #define PL080_CCTRL_S   0x01000000
 
-typedef struct {
-    uint32_t src;
-    uint32_t dest;
-    uint32_t lli;
-    uint32_t ctrl;
-    uint32_t conf;
-} pl080_channel;
-
-#define TYPE_PL080 "pl080"
-#define PL080(obj) OBJECT_CHECK(PL080State, (obj), TYPE_PL080)
-
-typedef struct PL080State {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint8_t tc_int;
-    uint8_t tc_mask;
-    uint8_t err_int;
-    uint8_t err_mask;
-    uint32_t conf;
-    uint32_t sync;
-    uint32_t req_single;
-    uint32_t req_burst;
-    pl080_channel chan[PL080_MAX_CHANNELS];
-    int nchannels;
-    /* Flag to avoid recursive DMA invocations.  */
-    int running;
-    qemu_irq irq;
-} PL080State;
-
 static const VMStateDescription vmstate_pl080_channel = {
     .name = "pl080_channel",
     .version_id = 1,
@@ -408,7 +378,7 @@ static const TypeInfo pl080_info = {
 };
 
 static const TypeInfo pl081_info = {
-    .name          = "pl081",
+    .name          = TYPE_PL081,
     .parent        = TYPE_PL080,
     .instance_init = pl081_init,
 };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6698a7e0f81..6902a568f44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,6 +445,7 @@ F: hw/char/pl011.c
 F: include/hw/char/pl011.h
 F: hw/display/pl110*
 F: hw/dma/pl080.c
+F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
-- 
2.18.0
