Received: from eggs.gnu.org ([2001:4830:134:3::10]:58921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied5-0006oH-Uo
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-00047u-SD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:35 -0500
Received: from greensocs.com ([193.104.36.180]:38360)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-000472-GR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:32 -0500
From: fred.konrad@greensocs.com
Date: Tue, 28 Feb 2017 11:02:57 +0100
Message-Id: <1488276185-31168-3-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 02/10] qemu-clk: allow to add a clock to a
 device
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

This allows to add a clock to a DeviceState.
Contrary to gpios, the clock pins are not contained in the DeviceState but
with the child property so they can appears in the qom-tree.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V2 -> V3:
  * s/qemu_clk/QEMUClock/g
V1 -> V2:
  * Rename the function use 'add' instead of 'attach'
---
 include/qemu/qemu-clock.h | 24 +++++++++++++++++++++++-
 qemu-clock.c              | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
index 446a490..ffe743d 100644
--- a/include/qemu/qemu-clock.h
+++ b/include/qemu/qemu-clock.h
@@ -33,8 +33,30 @@
 typedef struct QEMUClock {
     /*< private >*/
     Object parent_obj;
+    char *name;            /* name of this clock in the device. */
 } QEMUClock;
 
-#endif /* QEMU_CLOCK_H */
+/**
+ * qemu_clk_device_add_clock:
+ * @dev: the device on which the clock needs to be added.
+ * @clk: the clock which needs to be added.
+ * @name: the name of the clock can't be NULL.
+ *
+ * Add @clk to device @dev as a clock named @name.
+ *
+ */
+void qemu_clk_device_add_clock(DeviceState *dev, QEMUClock *clk,
+                               const char *name);
 
+/**
+ * qemu_clk_device_get_clock:
+ * @dev: the device which contains the clock.
+ * @name: the name of the clock.
+ *
+ * Get the clock named @name contained in the device @dev, or NULL if not found.
+ *
+ * Returns the clock named @name contained in @dev.
+ */
+QEMUClock *qemu_clk_device_get_clock(DeviceState *dev, const char *name);
 
+#endif /* QEMU_CLOCK_H */
diff --git a/qemu-clock.c b/qemu-clock.c
index 3bef144..6eeecf3 100644
--- a/qemu-clock.c
+++ b/qemu-clock.c
@@ -25,6 +25,7 @@
 #include "qemu/qemu-clock.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 
 #ifndef DEBUG_QEMU_CLOCK
 #define DEBUG_QEMU_CLOCK 0
@@ -36,6 +37,28 @@
     }                                                                        \
 } while (0);
 
+void qemu_clk_device_add_clock(DeviceState *dev, QEMUClock *clk,
+                               const char *name)
+{
+    assert(name);
+    assert(!clk->name);
+    object_property_add_child(OBJECT(dev), name, OBJECT(clk), &error_abort);
+    clk->name = g_strdup(name);
+}
+
+QEMUClock *qemu_clk_device_get_clock(DeviceState *dev, const char *name)
+{
+    gchar *path = NULL;
+    Object *clk;
+    bool ambiguous;
+
+    path = g_strdup_printf("%s/%s", object_get_canonical_path(OBJECT(dev)),
+                           name);
+    clk = object_resolve_path(path, &ambiguous);
+    g_free(path);
+    return QEMU_CLOCK(clk);
+}
+
 static const TypeInfo qemu_clk_info = {
     .name          = TYPE_CLOCK,
     .parent        = TYPE_OBJECT,
-- 
1.8.3.1
