Received: from eggs.gnu.org ([2001:4830:134:3::10]:50141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcsw-0007qi-7b
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcsr-0007rk-Ah
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:8331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cfcsr-0007rK-1I
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:21 -0500
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Mon, 20 Feb 2017 09:28:06 +0800
Message-Id: <1487554087-15347-4-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
References: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [Resend RFC PATCH 3/4] Intel iommu: Add Intel IOMMU
 fault event callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, yi.l.liu@intel.com

This patch is to deal with fault event reported from IOMMU driver.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/intel_iommu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9b1ba1b..79507d2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2286,6 +2286,30 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
     }
 }
 
+static void vtd_iommu_notify_fault_event(MemoryRegion *iommu,
+                                         IOMMUFaultInfo *info)
+{
+    VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    bool is_fpd_set = false;
+    uint8_t bus_num = pci_bus_num(vtd_as->bus);
+    uint8_t devfn = vtd_as->devfn;
+    VTDContextEntry ce;
+
+    /* Replace source id with device's vbdf */
+    info->sid = vtd_make_source_id(bus_num, devfn);
+
+    if (!vtd_dev_to_context_entry(s, bus_num, devfn, &ce)) {
+        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        if (is_fpd_set) {
+            trace_vtd_fault_disabled();
+        } else {
+            vtd_report_dmar_fault(s, info->sid, info->addr,
+                                  info->fault_reason, info->is_write);
+        }
+    }
+}
+
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
     .version_id = 1,
@@ -2816,6 +2840,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     s->iommu_ops.translate = vtd_iommu_translate;
     s->iommu_ops.notify_flag_changed = vtd_iommu_notify_flag_changed;
+    s->iommu_ops.notify_fault_event = vtd_iommu_notify_fault_event;
     s->iommu_ops.replay = vtd_iommu_replay;
     s->root = 0;
     s->root_extended = false;
-- 
1.8.3.1
