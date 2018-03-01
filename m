Received: from eggs.gnu.org ([2001:4830:134:3::10]:52749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLls-0004Fa-Kq
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLlr-0007wd-Id
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:7314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLlr-0007fT-6R
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:07 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:31:59 +0800
Message-Id: <1519900322-30263-10-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 09/12] intel_iommu: record assigned devices
 in a list
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

This patch records assigned devices in a list within Intel vIOMMU
emulator. The recorded info can be used to filter out affect assigned
devices when Qemu captured guest's cache invalidate request.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         | 31 ++++++++++++++++++++++++++-----
 include/hw/i386/intel_iommu.h | 11 ++++++++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2fd0a6d..978f47a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2685,7 +2685,10 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
-VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,
+                                 PCIBus *bus,
+                                 int devfn,
+                                 bool allocate)
 {
     uintptr_t key = (uintptr_t)bus;
     VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
@@ -2704,7 +2707,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 
     vtd_dev_as = vtd_bus->dev_as[devfn];
 
-    if (!vtd_dev_as) {
+    if (!vtd_dev_as && allocate) {
         snprintf(name, sizeof(name), "intel_iommu_devfn_%d", devfn);
         vtd_bus->dev_as[devfn] = vtd_dev_as = g_malloc0(sizeof(VTDAddressSpace));
 
@@ -3001,7 +3004,7 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
-    vtd_as = vtd_find_add_as(s, bus, devfn);
+    vtd_as = vtd_find_add_as(s, bus, devfn, true);
     return &vtd_as->as;
 }
 
@@ -3012,16 +3015,34 @@ static int vtd_device_notify(PCIBus *bus,
 {
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
+    IntelIOMMUAssignedDeviceNode *node = NULL;
+    IntelIOMMUAssignedDeviceNode *next_node = NULL;
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
-    vtd_as = vtd_find_add_as(s, bus, devfn);
+    vtd_as = vtd_find_add_as(s, bus, devfn, false);
 
     if (vtd_as == NULL) {
         return -1;
     }
 
-    /* TODO: record assigned device in IOMMU Emulator */
+    if (type == PCI_NTY_DEV_ADD) {
+        node = g_malloc0(sizeof(*node));
+        node->vtd_as = vtd_as;
+        QLIST_INSERT_HEAD(&s->assigned_device_list, node, next);
+        return 0;
+    }
+
+    QLIST_FOREACH_SAFE(node, &s->assigned_device_list, next, next_node) {
+        if (node->vtd_as == vtd_as) {
+            if (type == PCI_NTY_DEV_DEL) {
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            break;
+        }
+    }
+
     return 0;
 }
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1df6fa9..0b6dc32 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -68,6 +68,7 @@ typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
 typedef struct IntelIOMMUMRNotifierNode IntelIOMMUMRNotifierNode;
+typedef struct IntelIOMMUAssignedDeviceNode IntelIOMMUAssignedDeviceNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -258,6 +259,11 @@ struct IntelIOMMUMRNotifierNode {
     QLIST_ENTRY(IntelIOMMUMRNotifierNode) next;
 };
 
+struct IntelIOMMUAssignedDeviceNode {
+    VTDAddressSpace *vtd_as;
+    QLIST_ENTRY(IntelIOMMUAssignedDeviceNode) next;
+};
+
 /* The iommu (DMAR) device state struct */
 struct IntelIOMMUState {
     X86IOMMUState x86_iommu;
@@ -296,6 +302,8 @@ struct IntelIOMMUState {
     VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
     /* list of registered notifiers */
     QLIST_HEAD(, IntelIOMMUMRNotifierNode) notifiers_list;
+    /* list of assigned devices */
+    QLIST_HEAD(, IntelIOMMUAssignedDeviceNode) assigned_device_list;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
@@ -310,6 +318,7 @@ struct IntelIOMMUState {
 /* Find the VTD Address space associated with the given bus pointer,
  * create a new one if none exists
  */
-VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn);
+VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
+                                 int devfn, bool allocate);
 
 #endif
-- 
1.9.1
