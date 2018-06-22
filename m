Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAN-0007WM-Nc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAM-0005Zo-3A
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:47 -0400
From: Shimi Gersner <gersner@gmail.com>
Date: Fri, 22 Jun 2018 11:22:35 +0000
Message-Id: <20180622112237.2131-3-gersner@gmail.com>
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
References: <20180622112237.2131-1-gersner@gmail.com>
Subject: [Qemu-devel] [PATCH 3/5] nvme: Proper state handling on
 enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, David Sariel <davidsa@openu.ac.il>, Shimi Gersner <gersner@gmail.com>

When device transitions from CC.EN=1 to CC.EN=0 (Controller Reset) it should
properly reset its state, currently device only partially clears its state.

Following actions were added to controller reset phase
- Clear CC and CSTS completely
- Clear and deassert irqs
- On shutdown, leave state as is and only notify on shutdown completion.

Change-Id: Ia0bc29775b12586c3aab2ca217603051062c3efe
Signed-off-by: Shimi Gersner <gersner@gmail.com>
---
 hw/block/nvme.c      | 67 ++++++++++++++++++++++++++------------------
 include/block/nvme.h |  5 ++++
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 24a51d33ea..206d8428fd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -805,7 +805,7 @@ static void nvme_process_sq(void *opaque)
     }
 }
 
-static void nvme_clear_ctrl(NvmeCtrl *n)
+static void nvme_clear_ctrl(NvmeCtrl *n, bool reset)
 {
     int i;
 
@@ -820,8 +820,18 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
     }
 
+    if (reset) {
+        // Reset clears all except for AWA, ASW, ACQ
+        n->bar.cc = 0;
+        n->bar.csts = 0;
+    }
+
+    // Update the IRQ status
+    n->bar.intmc = n->bar.intms = 0;
+    n->irq_status = 0;
+    nvme_irq_check(n);
+
     blk_flush(n->conf.blk);
-    n->bar.cc = 0;
 }
 
 static int nvme_start_ctrl(NvmeCtrl *n)
@@ -963,16 +973,14 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         nvme_irq_check(n);
         break;
     case 0x14:  /* CC */
-        trace_nvme_mmio_cfg(data & 0xffffffff);
-        /* Windows first sends data, then sends enable bit */
-        if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
-            !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
-        {
-            n->bar.cc = data;
-        }
+        trace_nvme_mmio_cfg(data & NVME_CC_WR_MASK);
+
+        uint32_t previous_cc = n->bar.cc;
+
+        // CC is all writeable
+        n->bar.cc = data & NVME_CC_WR_MASK;
 
-        if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
-            n->bar.cc = data;
+        if (NVME_CC_EN(data) && !NVME_CC_EN(previous_cc)) {
             if (unlikely(nvme_start_ctrl(n))) {
                 trace_nvme_err_startfail();
                 n->bar.csts = NVME_CSTS_FAILED;
@@ -980,21 +988,24 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
                 trace_nvme_mmio_start_success();
                 n->bar.csts = NVME_CSTS_READY;
             }
-        } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+
+        } else if (!NVME_CC_EN(data) && NVME_CC_EN(previous_cc)) {
             trace_nvme_mmio_stopped();
-            nvme_clear_ctrl(n);
-            n->bar.csts &= ~NVME_CSTS_READY;
+            nvme_clear_ctrl(n, true);
+
         }
-        if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
+
+        if (NVME_CC_SHN(data) && !(NVME_CC_SHN(previous_cc))) {
             trace_nvme_mmio_shutdown_set();
-            nvme_clear_ctrl(n);
-            n->bar.cc = data;
+            nvme_clear_ctrl(n, false);
             n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
-        } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
+
+        } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(previous_cc)) {
             trace_nvme_mmio_shutdown_cleared();
             n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
-            n->bar.cc = data;
+
         }
+
         break;
     case 0x1C:  /* CSTS */
         if (data & (1 << 4)) {
@@ -1016,23 +1027,23 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         }
         break;
     case 0x24:  /* AQA */
-        n->bar.aqa = data & 0xffffffff;
-        trace_nvme_mmio_aqattr(data & 0xffffffff);
+        n->bar.aqa = data & NVME_AQA_WR_MASK;
+        trace_nvme_mmio_aqattr(n->bar.aqa);
         break;
     case 0x28:  /* ASQ */
-        n->bar.asq = data;
-        trace_nvme_mmio_asqaddr(data);
+        n->bar.asq = data & NVME_ASQ_WR_MASK;
+        trace_nvme_mmio_asqaddr(n->bar.asq);
         break;
     case 0x2c:  /* ASQ hi */
-        n->bar.asq |= data << 32;
+        n->bar.asq |= (data << 32) & NVME_ASQ_WR_MASK;
         trace_nvme_mmio_asqaddr_hi(data, n->bar.asq);
         break;
     case 0x30:  /* ACQ */
-        trace_nvme_mmio_acqaddr(data);
-        n->bar.acq = data;
+        n->bar.acq = data & NVME_ACQ_WR_MASK;
+        trace_nvme_mmio_acqaddr(n->bar.acq);
         break;
     case 0x34:  /* ACQ hi */
-        n->bar.acq |= data << 32;
+        n->bar.acq |= (data << 32) & NVME_ACQ_WR_MASK;
         trace_nvme_mmio_acqaddr_hi(data, n->bar.acq);
         break;
     case 0x38:  /* CMBLOC */
@@ -1390,7 +1401,7 @@ static void nvme_exit(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
 
-    nvme_clear_ctrl(n);
+    nvme_clear_ctrl(n, true);
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 849a6f3fa3..4da6740543 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -90,6 +90,11 @@ enum NvmeCcMask {
     CC_IOCQES_MASK  = 0xf,
 };
 
+#define NVME_CC_WR_MASK    (0x00fffff1)
+#define NVME_AQA_WR_MASK   (0x0fff0fff)
+#define NVME_ASQ_WR_MASK   (0xfffffffffffff000)
+#define NVME_ACQ_WR_MASK   (0xfffffffffffff000)
+
 #define NVME_CC_EN(cc)     ((cc >> CC_EN_SHIFT)     & CC_EN_MASK)
 #define NVME_CC_CSS(cc)    ((cc >> CC_CSS_SHIFT)    & CC_CSS_MASK)
 #define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
-- 
2.17.1
