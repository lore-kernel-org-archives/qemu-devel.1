Received: from eggs.gnu.org ([2001:4830:134:3::10]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOcd-0004wa-Rc
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOcZ-0002yd-E4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:19 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:50779
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eCOcZ-0002xX-4Y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:15 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed,  8 Nov 2017 12:32:42 +0100
Message-Id: <1510140763-18256-2-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
References: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/2] cadence_ttc: extract
 CadenceTTCState to a new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, edgar.iglesias@gmail.com, peter.maydell@linaro.org, frederic.konrad@adacore.com

We want to add this model to the xlnx-zynqmp board so let's make
CadenceTTCState available in an header file.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/timer/cadence_ttc.c         | 35 +-----------------------
 include/hw/timer/cadence_ttc.h | 61 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/timer/cadence_ttc.h

diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 03f5b9c..bb4a5ef 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -16,9 +16,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "qemu/timer.h"
+#include "hw/timer/cadence_ttc.h"
 
 #ifdef CADENCE_TTC_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -45,37 +43,6 @@
 #define CLOCK_CTRL_PS_EN    0x00000001
 #define CLOCK_CTRL_PS_V     0x0000001e
 
-typedef struct {
-    QEMUTimer *timer;
-    int freq;
-
-    uint32_t reg_clock;
-    uint32_t reg_count;
-    uint32_t reg_value;
-    uint16_t reg_interval;
-    uint16_t reg_match[3];
-    uint32_t reg_intr;
-    uint32_t reg_intr_en;
-    uint32_t reg_event_ctrl;
-    uint32_t reg_event;
-
-    uint64_t cpu_time;
-    unsigned int cpu_time_valid;
-
-    qemu_irq irq;
-} CadenceTimerState;
-
-#define TYPE_CADENCE_TTC "cadence_ttc"
-#define CADENCE_TTC(obj) \
-    OBJECT_CHECK(CadenceTTCState, (obj), TYPE_CADENCE_TTC)
-
-typedef struct CadenceTTCState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    CadenceTimerState timer[3];
-} CadenceTTCState;
-
 static void cadence_timer_update(CadenceTimerState *s)
 {
     qemu_set_irq(s->irq, !!(s->reg_intr & s->reg_intr_en));
diff --git a/include/hw/timer/cadence_ttc.h b/include/hw/timer/cadence_ttc.h
new file mode 100644
index 0000000..0c38789
--- /dev/null
+++ b/include/hw/timer/cadence_ttc.h
@@ -0,0 +1,61 @@
+/*
+ * Xilinx Zynq cadence TTC model
+ *
+ * Copyright (c) 2011 Xilinx Inc.
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.crosthwaite@petalogix.com)
+ * Copyright (c) 2012 PetaLogix Pty Ltd.
+ * Written By Haibing Ma
+ *            M. Habib
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef CADENCE_TTC_H
+#define CADENCE_TTC_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+
+struct CadenceTimerState {
+    QEMUTimer *timer;
+    int freq;
+
+    uint32_t reg_clock;
+    uint32_t reg_count;
+    uint32_t reg_value;
+    uint16_t reg_interval;
+    uint16_t reg_match[3];
+    uint32_t reg_intr;
+    uint32_t reg_intr_en;
+    uint32_t reg_event_ctrl;
+    uint32_t reg_event;
+
+    uint64_t cpu_time;
+    unsigned int cpu_time_valid;
+
+    qemu_irq irq;
+};
+
+typedef struct CadenceTimerState CadenceTimerState;
+
+struct CadenceTTCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    CadenceTimerState timer[3];
+};
+
+typedef struct CadenceTTCState CadenceTTCState;
+
+#define TYPE_CADENCE_TTC "cadence_ttc"
+#define CADENCE_TTC(obj) \
+    OBJECT_CHECK(CadenceTTCState, (obj), TYPE_CADENCE_TTC)
+
+#endif /* CADENCE_TTC_H */
-- 
1.8.3.1
