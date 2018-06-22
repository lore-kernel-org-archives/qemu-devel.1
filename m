Received: from eggs.gnu.org ([2001:4830:134:3::10]:58687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAO-0007Wf-1W
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gersner@gmail.com>) id 1fWKAM-0005a1-6T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:23:48 -0400
From: Shimi Gersner <gersner@gmail.com>
Date: Fri, 22 Jun 2018 11:22:33 +0000
Message-Id: <20180622112237.2131-1-gersner@gmail.com>
Subject: [Qemu-devel] [PATCH 1/5] nvme: PCI/e configuration from
 specification
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

PCI/e configuration currently does not meets specifications.

Patch includes various configuration changes to support specifications
- BAR2 to return zero when read and CMD.IOSE is not set.
- Expose NVME configuration through IO space (Optional).
- PCI Power Management v1.2.
- PCIe Function Level Reset.
- Disable QEMUs default use of PCIe Link Status (DLLLA).
- PCIe missing AOC compliance flag.
- Mask PCIe End-to-End TLP as RO (Unspecified by specification).

Change-Id: I9057f56266db16b013fa194730c998d4779cede3
Signed-off-by: Shimi Gersner <gersner@gmail.com>
---
 hw/block/nvme.c           | 59 +++++++++++++++++++++++++++++++++++++--
 include/hw/pci/pci_regs.h |  1 +
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d5bf95b79b..9d5414c80f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/block/block.h"
 #include "hw/hw.h"
 #include "hw/pci/msix.h"
@@ -39,6 +40,9 @@
 #include "trace.h"
 #include "nvme.h"
 
+#define PCI_EXP_LNKCAP_AOC 0x00400000 /* ASPM Optionality Compliance (AOC) */
+#define PCI_EXP_DEVCAP2_CTDS 0x10 /* Completion Timeout Disable Supported (CTDS) */
+
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -1195,14 +1199,31 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+static uint32_t nvme_pci_read_config(PCIDevice *pci_dev, uint32_t addr, int len)
+{
+    uint32_t val; /* Value to be returned */
+
+    val = pci_default_read_config(pci_dev, addr, len);
+    if (ranges_overlap(addr, len, PCI_BASE_ADDRESS_2, 4) && (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_IO))) {
+        /* When CMD.IOSE is not set */
+        val = 0 ;
+    }
+
+    return val;
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
+    static const uint16_t nvme_pm_offset = 0x80;
+    static const uint16_t nvme_pcie_offset = nvme_pm_offset + PCI_PM_SIZEOF;
+
     NvmeCtrl *n = NVME(pci_dev);
     NvmeIdCtrl *id = &n->id_ctrl;
 
     int i;
     int64_t bs_size;
     uint8_t *pci_conf;
+    uint8_t *pci_wmask;
 
     if (!n->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -1226,14 +1247,43 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     pci_conf = pci_dev->config;
+    pci_wmask = pci_dev->wmask;
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_dev->config, 0x2);
     pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+
+    // Configure the PMC capability
+    (void)pci_add_capability(pci_dev, PCI_CAP_ID_PM, nvme_pm_offset, PCI_PM_SIZEOF, errp);
+    if (NULL != *errp) {
+        return;
+    }
+
+    //  - PCI Power Management v1.2, No PME support, No Soft Reset, Make state writeable
+    pci_set_word(pci_conf + nvme_pm_offset + PCI_PM_PMC, PCI_PM_CAP_VER_1_2);
+    pci_set_word(pci_conf + nvme_pm_offset + PCI_PM_CTRL, PCI_PM_CTRL_NO_SOFT_RESET);
+    pci_set_word(pci_wmask + nvme_pm_offset + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
+
+    // Disable QEMU default QEMU_PCIE_LNKSTA_DLLLA to disabled active flag in the Link Status Register of PCIE
+    pci_dev->cap_present &= ~(QEMU_PCIE_LNKSTA_DLLLA);
+
+    // PCIE Capability
+    pcie_endpoint_cap_init(&n->parent_obj, nvme_pcie_offset);
+
+    // PCIE Function Level Reset (FLRC) as required by 1.2 spec
+    pcie_cap_flr_init(&n->parent_obj);
+
+    // PCIE Configured with L0s by default by QEMU, configure missing AOC flag required by compliance
+    pci_long_test_and_set_mask(pci_conf + pci_dev->exp.exp_cap + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_AOC);
+
+    // Compliance requires Completion Timeout Disable Supported (CTDS).
+    pci_long_test_and_set_mask(pci_conf + pci_dev->exp.exp_cap + PCI_EXP_DEVCAP2, PCI_EXP_DEVCAP2_CTDS);
+
+    // Make the End-End TLP Prefix readonly as NVME spec doesnt acknowledge this field
+    pci_word_test_and_clear_mask(pci_wmask + pci_dev->exp.exp_cap + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
 
     n->num_namespaces = 1;
     n->num_queues = 64;
-    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
+    n->reg_size = pow2ceil(0x2000 + 2 * (n->num_queues + 1) * 4);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
     n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
@@ -1245,6 +1295,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(&n->parent_obj, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
+
+    // Expose the NVME memory through Address Space IO (Optional by spec)
+    pci_register_bar(&n->parent_obj, 2, PCI_BASE_ADDRESS_SPACE_IO, &n->iomem);
+
     msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
@@ -1355,6 +1409,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = nvme_realize;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
diff --git a/include/hw/pci/pci_regs.h b/include/hw/pci/pci_regs.h
index 7a83142578..54dc918f54 100644
--- a/include/hw/pci/pci_regs.h
+++ b/include/hw/pci/pci_regs.h
@@ -1,3 +1,4 @@
 #include "standard-headers/linux/pci_regs.h"
 
 #define  PCI_PM_CAP_VER_1_1     0x0002  /* PCI PM spec ver. 1.1 */
+#define  PCI_PM_CAP_VER_1_2     0x0003  /* PCI PM spec ver. 1.2 */
-- 
2.17.1
