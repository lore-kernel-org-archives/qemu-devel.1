Received: from eggs.gnu.org ([2001:4830:134:3::10]:58920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied5-0006oG-Uk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied3-000489-GN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:35 -0500
Received: from greensocs.com ([193.104.36.180]:38399)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied3-00047r-3c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:33 -0500
From: fred.konrad@greensocs.com
Date: Tue, 28 Feb 2017 11:02:59 +0100
Message-Id: <1488276185-31168-5-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 04/10] qemu-clk: introduce an init array to
 help the device construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This introduces a clock init array to ease the clock tree construction.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V2 -> V3:
  * s/QEMUClock/qemu_clk/g
---
 include/qemu/qemu-clock.h | 23 +++++++++++++++++++++++
 qemu-clock.c              | 17 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
index f80de56..1c57df4 100644
--- a/include/qemu/qemu-clock.h
+++ b/include/qemu/qemu-clock.h
@@ -49,6 +49,29 @@ struct ClkList {
     QLIST_ENTRY(ClkList) node;
 };
 
+typedef struct ClockInitElement {
+    const char *name;      /* Name to give to the clock. */
+    size_t offset;         /* Offset of the qemu_clk field in the object. */
+    QEMUClkRateUpdateCallback *cb;
+} ClockInitElement;
+
+#define DEVICE_CLOCK(_state, _field, _cb) {                                  \
+    .name = #_field,                                                         \
+    .offset = offsetof(_state, _field),                                      \
+    .cb = _cb                                                                \
+}
+
+#define DEVICE_CLOCK_END() {                                                 \
+    .name = NULL                                                             \
+}
+
+/**
+ * qemu_clk_init_device:
+ * @obj: the Object which need to be initialized.
+ * @array: the array of ClockInitElement to be used.
+ */
+void qemu_clk_init_device(Object *obj, ClockInitElement *array);
+
 /**
  * qemu_clk_device_add_clock:
  * @dev: the device on which the clock needs to be added.
diff --git a/qemu-clock.c b/qemu-clock.c
index 24719e2..8f342f6 100644
--- a/qemu-clock.c
+++ b/qemu-clock.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "hw/qdev-core.h"
 
 #ifndef DEBUG_QEMU_CLOCK
 #define DEBUG_QEMU_CLOCK 0
@@ -37,6 +38,22 @@
     }                                                                        \
 } while (0);
 
+void qemu_clk_init_device(Object *obj, ClockInitElement *array)
+{
+    QEMUClock **cur = NULL;
+
+    while (array->name != NULL) {
+        DPRINTF("init clock named %s\n", array->name);
+        cur = (((void *)obj) + array->offset);
+        *cur = QEMU_CLOCK(object_new(TYPE_CLOCK));
+        qemu_clk_device_add_clock(DEVICE(obj), *cur, array->name);
+        if (array->cb) {
+            qemu_clk_set_callback(*cur, array->cb, obj);
+        }
+        array++;
+    }
+}
+
 void qemu_clk_refresh(QEMUClock *clk)
 {
     qemu_clk_update_rate(clk, clk->ref_rate);
-- 
1.8.3.1
