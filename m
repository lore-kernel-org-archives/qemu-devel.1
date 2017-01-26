Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWget-00054E-6v
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWger-0000qN-V8
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:59 -0500
Received: from greensocs.com ([193.104.36.180]:33108)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWger-0000oc-Hm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:57 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:36 +0100
Message-Id: <1485424060-12217-7-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 06/10] docs: add qemu-clock documentation
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

This adds the qemu-clock documentation.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V1 -> V2:
  * Fixed in accordance with the changes in the previous patches.
---
 docs/clock.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 docs/clock.txt

diff --git a/docs/clock.txt b/docs/clock.txt
new file mode 100644
index 0000000..aa23910
--- /dev/null
+++ b/docs/clock.txt
@@ -0,0 +1,108 @@
+
+What is a QEMU_CLOCK
+====================
+
+A QEMU_CLOCK is a QOM Object developed for the purpose of modeling a clock tree
+with QEMU.
+
+It only simulates the clock by keeping a copy of the current frequency and
+doesn't model the signal itself such as pin toggle or duty cycle.
+
+It allows to model the impact of badly configured PLL, clock source selection
+or disabled clock on the models.
+
+Binding the clock together to create a tree
+===========================================
+
+In order to create a clock tree with QEMU_CLOCK two or more clock must be bound
+together. Let's say there are two clocks clk_a and clk_b:
+Using qemu_clk_bind(clk_a, clk_b) will bind clk_a and clk_b.
+
+Binding two qemu-clk together creates a unidirectional link which means that
+changing the rate of clk_a will propagate to clk_b and not the opposite.
+The binding process automatically refreshes clk_b rate.
+
+Clock can be bound and unbound during execution for modeling eg: a clock
+selector.
+
+A clock can drive more than one other clock. eg with this code:
+qemu_clk_bind(clk_a, clk_b);
+qemu_clk_bind(clk_a, clk_c);
+
+A clock rate change one clk_a will propagate to clk_b and clk_c.
+
+Implementing a callback on a rate change
+========================================
+
+The function prototype is the following:
+typedef uint64_t QEMUClkRateUpdateCallback(void *opaque, uint64_t rate);
+
+It's main goal is to modify the rate before it's passed to the next clocks in
+the tree.
+
+eg: for a 4x PLL the function will be:
+uint64_t qemu_clk_rate_change_cb(void *opaque, uint64_t rate)
+{
+    return 4 * rate;
+}
+
+To set the callback for the clock:
+void qemu_clk_set_callback(qemu_clk clk, QEMUClkRateUpdateCallback *cb,
+                           void *opaque);
+can be called.
+
+The rate update process
+=======================
+
+The rate update happen in this way:
+When a model wants to update a clock frequency (eg: based on a register change
+or something similar) it will call qemu_clk_update_rate(..) on the clock:
+  * The callback associated to the clock is called with the new rate.
+  * qemu_clk_update_rate(..) is then called on all bound clocks with the value
+    returned by the callback.
+
+NOTE: When no callback is attached, the clock qemu_clk_update_rate(..) is called
+with the unmodified rate.
+
+Adding a QEMU_CLOCK to a DeviceState
+====================================
+
+Adding a qemu-clk to a DeviceState is required to be able to get the clock
+outside the model through qemu_clk_device_get_clock(..).
+
+It is also required to be able to print the clock and its rate with info qtree.
+For example:
+
+  type System
+  dev: xlnx.zynqmp_crf, id ""
+    gpio-out "sysbus-irq" 1
+    gpio-out "RST_A9" 4
+    qemu-clk "dbg_trace" 0
+    qemu-clk "vpll_to_lpd" 625000000
+    qemu-clk "dp_stc_ref" 0
+    qemu-clk "dpll_to_lpd" 12500000
+    qemu-clk "acpu_clk" 0
+    qemu-clk "pcie_ref" 0
+    qemu-clk "topsw_main" 0
+    qemu-clk "topsw_lsbus" 0
+    qemu-clk "dp_audio_ref" 0
+    qemu-clk "sata_ref" 0
+    qemu-clk "dp_video_ref" 71428568
+    qemu-clk "vpll_clk" 2500000000
+    qemu-clk "apll_to_lpd" 12500000
+    qemu-clk "dpll_clk" 50000000
+    qemu-clk "gpu_ref" 0
+    qemu-clk "aux_refclk" 0
+    qemu-clk "video_clk" 27000000
+    qemu-clk "gdma_ref" 0
+    qemu-clk "gt_crx_ref_clk" 0
+    qemu-clk "dbg_fdp" 0
+    qemu-clk "apll_clk" 50000000
+    qemu-clk "pss_alt_ref_clk" 0
+    qemu-clk "ddr" 0
+    qemu-clk "pss_ref_clk" 50000000
+    qemu-clk "dpdma_ref" 0
+    qemu-clk "dbg_tstmp" 0
+    mmio 00000000fd1a0000/000000000000010c
+
+This way a DeviceState can have multiple clock input or output.
-- 
1.8.3.1
