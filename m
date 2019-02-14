Received: from eggs.gnu.org ([209.51.188.92]:50008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeU-00038O-4U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGTx-0006Rr-Ux
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:14 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGTx-0006RS-Oo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:13 -0500
Received: by mail-wm1-x342.google.com with SMTP id q21so5966731wmc.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:56 +0000
Message-Id: <20190214125107.22178-4-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/14] hw/timer/pl031: Allow use as an
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
Cc: patches@linaro.org

Create a new include file for the pl031's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/pl031.h | 44 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/pl031.c         | 25 +----------------------
 MAINTAINERS              |  1 +
 3 files changed, 46 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/timer/pl031.h

diff --git a/include/hw/timer/pl031.h b/include/hw/timer/pl031.h
new file mode 100644
index 00000000000..99416d8ba52
--- /dev/null
+++ b/include/hw/timer/pl031.h
@@ -0,0 +1,44 @@
+/*
+ * ARM AMBA PrimeCell PL031 RTC
+ *
+ * Copyright (c) 2007 CodeSourcery
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef HW_TIMER_PL031
+#define HW_TIMER_PL031
+
+#include "hw/sysbus.h"
+
+#define TYPE_PL031 "pl031"
+#define PL031(obj) OBJECT_CHECK(PL031State, (obj), TYPE_PL031)
+
+typedef struct PL031State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    qemu_irq irq;
+
+    /*
+     * Needed to preserve the tick_count across migration, even if the
+     * absolute value of the rtc_clock is different on the source and
+     * destination.
+     */
+    uint32_t tick_offset_vmstate;
+    uint32_t tick_offset;
+
+    uint32_t mr;
+    uint32_t lr;
+    uint32_t cr;
+    uint32_t im;
+    uint32_t is;
+} PL031State;
+
+#endif
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index d3aacce80da..f774dcd5223 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/timer/pl031.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
@@ -36,30 +37,6 @@ do { printf("pl031: " fmt , ## __VA_ARGS__); } while (0)
 #define RTC_MIS     0x18    /* Masked interrupt status register */
 #define RTC_ICR     0x1c    /* Interrupt clear register */
 
-#define TYPE_PL031 "pl031"
-#define PL031(obj) OBJECT_CHECK(PL031State, (obj), TYPE_PL031)
-
-typedef struct PL031State {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    QEMUTimer *timer;
-    qemu_irq irq;
-
-    /* Needed to preserve the tick_count across migration, even if the
-     * absolute value of the rtc_clock is different on the source and
-     * destination.
-     */
-    uint32_t tick_offset_vmstate;
-    uint32_t tick_offset;
-
-    uint32_t mr;
-    uint32_t lr;
-    uint32_t cr;
-    uint32_t im;
-    uint32_t is;
-} PL031State;
-
 static const unsigned char pl031_id[] = {
     0x31, 0x10, 0x14, 0x00,         /* Device ID        */
     0x0d, 0xf0, 0x05, 0xb1          /* Cell ID      */
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581b..85d4b4c9f7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -493,6 +493,7 @@ F: hw/sd/pl181.c
 F: hw/ssi/pl022.c
 F: include/hw/ssi/pl022.h
 F: hw/timer/pl031.c
+F: include/hw/timer/pl031.h
 F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
-- 
2.20.1
