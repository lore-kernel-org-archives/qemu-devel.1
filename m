Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWger-00053J-Ci
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgeq-0000nz-DH
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:57 -0500
Received: from greensocs.com ([193.104.36.180]:33087)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgeq-0000nj-1s
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:56 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:35 +0100
Message-Id: <1485424060-12217-6-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 05/10] qdev-monitor: print the device's
 clock with info qtree
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

This prints the clock attached to a DeviceState when using "info qtree" monitor
command.

For example:

bus: main-system-bus
  type System
  dev: xlnx.zynqmp_crf, id ""
    gpio-out "sysbus-irq" 1
    gpio-out "RST_A9" 4
    qemu-clk "dbg_trace" 0.0
    qemu-clk "vpll_to_lpd" 12500000.0
    qemu-clk "dp_stc_ref" 0.0
    qemu-clk "dpll_to_lpd" 12500000.0
    qemu-clk "acpu_clk" 0.0
    qemu-clk "pcie_ref" 0.0
    qemu-clk "topsw_main" 0.0
    qemu-clk "topsw_lsbus" 0.0
    qemu-clk "dp_audio_ref" 0.0
    qemu-clk "sata_ref" 0.0
    qemu-clk "dp_video_ref" 1428571.4
    qemu-clk "vpll_clk" 50000000.0
    qemu-clk "apll_to_lpd" 12500000.0
    qemu-clk "dpll_clk" 50000000.0
    qemu-clk "gpu_ref" 0.0
    qemu-clk "aux_refclk" 0.0
    qemu-clk "video_clk" 27000000.0
    qemu-clk "gdma_ref" 0.0
    qemu-clk "gt_crx_ref_clk" 0.0
    qemu-clk "dbg_fdp" 0.0
    qemu-clk "apll_clk" 50000000.0
    qemu-clk "pss_alt_ref_clk" 0.0
    qemu-clk "ddr" 0.0
    qemu-clk "pss_ref_clk" 50000000.0
    qemu-clk "dpdma_ref" 0.0
    qemu-clk "dbg_tstmp" 0.0
    mmio 00000000fd1a0000/000000000000010c

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 include/qemu/qemu-clock.h |  9 +++++++++
 qdev-monitor.c            |  2 ++
 qemu-clock.c              | 28 ++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
index 45f8766..ccc381c 100644
--- a/include/qemu/qemu-clock.h
+++ b/include/qemu/qemu-clock.h
@@ -149,4 +149,13 @@ void qemu_clk_set_callback(qemu_clk clk,
                            QEMUClkRateUpdateCallback *cb,
                            void *opaque);
 
+/**
+ * qemu_clk_print:
+ * @dev: the device for which the clock need to be printed.
+ *
+ * Print the clock information for a given device.
+ *
+ */
+void qemu_clk_print(Monitor *mon, DeviceState *dev, int indent);
+
 #endif /* QEMU_CLOCK_H */
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c73410c..8f6bbdf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
+#include "qemu/qemu-clock.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -689,6 +690,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
                         ngl->num_out);
         }
     }
+    qemu_clk_print(mon, dev, indent);
     class = object_get_class(OBJECT(dev));
     do {
         qdev_print_props(mon, dev, DEVICE_CLASS(class)->props, indent);
diff --git a/qemu-clock.c b/qemu-clock.c
index 300e38f..b34021c 100644
--- a/qemu-clock.c
+++ b/qemu-clock.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/qdev-core.h"
+#include "monitor/monitor.h"
 
 #ifndef DEBUG_QEMU_CLOCK
 #define DEBUG_QEMU_CLOCK 0
@@ -132,6 +133,33 @@ qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name)
     return QEMU_CLOCK(clk);
 }
 
+struct print_opaque {
+    Monitor *mon;
+    int indent;
+};
+
+static int qemu_clk_print_rec(Object *obj, void *opaque)
+{
+    qemu_clk clk = (qemu_clk)(object_dynamic_cast(obj, TYPE_CLOCK));
+    struct print_opaque *po = opaque;
+
+    if (clk) {
+        monitor_printf(po->mon, "%*s" "qemu-clk \"%s\" %" PRIu64 "\n",
+                       po->indent, " ", clk->name, clk->out_rate);
+    }
+
+    return 0;
+}
+
+void qemu_clk_print(Monitor *mon, DeviceState *dev, int indent)
+{
+    struct print_opaque po;
+
+    po.indent = indent;
+    po.mon = mon;
+    object_child_foreach(OBJECT(dev), qemu_clk_print_rec, &po);
+}
+
 static const TypeInfo qemu_clk_info = {
     .name          = TYPE_CLOCK,
     .parent        = TYPE_OBJECT,
-- 
1.8.3.1
