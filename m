Received: from eggs.gnu.org ([2001:4830:134:3::10]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWges-00053y-UC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgep-0000my-6l
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:59 -0500
Received: from greensocs.com ([193.104.36.180]:33071)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgeo-0000mj-Pd
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:55 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:34 +0100
Message-Id: <1485424060-12217-5-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 04/10] qemu-clk: introduce an init array to
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This introduces a clock init array to ease the clock tree construction.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 include/qemu/qemu-clock.h | 23 +++++++++++++++++++++++
 qemu-clock.c              | 17 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
index 6d30299..45f8766 100644
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
index 8c12368..300e38f 100644
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
+    qemu_clk *cur = NULL;
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
 void qemu_clk_refresh(qemu_clk clk)
 {
     qemu_clk_update_rate(clk, clk->in_rate);
-- 
1.8.3.1
