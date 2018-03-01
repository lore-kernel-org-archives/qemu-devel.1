Received: from eggs.gnu.org ([2001:4830:134:3::10]:52771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLlu-0004HY-Jg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLlt-0007zC-MP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:7314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLls-0007fT-W1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:09 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:32:00 +0800
Message-Id: <1519900322-30263-11-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 10/12] intel_iommu: bind guest pasid table
 to host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

For assigned SVA capable devices, needs to bind guest pasid table
to host. Intel vIOMMU emulator captures device selective context
cache flush, and propagate the guest pasid table pointer to host,
in host iommu driver configs the guest pasid table pointer in its
translation structure.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 978f47a..d92a66d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,10 @@
 #include "kvm_i386.h"
 #include "trace.h"
 
+static bool vtd_device_is_assigned(IntelIOMMUState *s,
+                                   PCIBus *bus,
+                                   uint16_t devfn);
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -1255,6 +1259,20 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+static uint64_t vtd_get_pasid_table_from_context(VTDContextEntry *ce)
+{
+    uint64_t pasidt_addr = ce->hi;
+    /* TODO: TBD */
+    return pasidt_addr;
+}
+
+static uint32_t vtd_get_pasidt_size_from_context(VTDContextEntry *ce)
+{
+    uint32_t pasidt_size = ce->hi;
+    /* TODO: TBD */
+    return pasidt_size;
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -1291,6 +1309,11 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
     if (vtd_bus) {
         devfn = VTD_SID_TO_DEVFN(source_id);
         for (devfn_it = 0; devfn_it < PCI_DEVFN_MAX; ++devfn_it) {
+            VTDContextEntry ce;
+            int ret = 0;
+            uint64_t pasidt_addr;
+            uint32_t size;
+
             vtd_as = vtd_bus->dev_as[devfn_it];
             if (vtd_as && ((devfn_it & mask) == (devfn & mask))) {
                 trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
@@ -1311,6 +1334,26 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                  * happened.
                  */
                 memory_region_iommu_replay_all(&vtd_as->iommu);
+
+                /*
+                 * If device is SVA capable assigned device, needs
+                 * to bind guest pasid table to host
+                 *
+                 */
+                if (!vtd_device_is_assigned(s, vtd_as->bus, devfn_it)) {
+                    continue;
+                }
+
+                ret = vtd_dev_to_context_entry(s, bus_n,
+                                               vtd_as->devfn, &ce);
+                if (ret) {
+                    continue;
+                }
+
+                pasidt_addr = vtd_get_pasid_table_from_context(&ce);
+                size = vtd_get_pasidt_size_from_context(&ce);
+                pci_device_sva_bind_pasid_table(vtd_as->bus, devfn_it,
+                                                pasidt_addr, size);
             }
         }
     }
@@ -3046,6 +3089,32 @@ static int vtd_device_notify(PCIBus *bus,
     return 0;
 }
 
+static bool vtd_device_is_assigned(IntelIOMMUState *s,
+                                   PCIBus *bus,
+                                   uint16_t devfn)
+{
+    VTDAddressSpace *vtd_as;
+    IntelIOMMUAssignedDeviceNode *node = NULL;
+    IntelIOMMUAssignedDeviceNode *next_node = NULL;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, false);
+
+    if (vtd_as == NULL) {
+        /*
+         * If vtd_as is NULL, return false for safe
+         */
+        return false;
+    }
+
+    QLIST_FOREACH_SAFE(node, &s->assigned_device_list, next, next_node) {
+        if (node->vtd_as == vtd_as) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
-- 
1.9.1
