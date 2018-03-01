Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnc-0005si-64
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnW-0000FY-Gj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:7359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLnW-00006Y-4K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:50 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:33:34 +0800
Message-Id: <1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 11/12] intel_iommu: add framework for PASID
 AddressSpace management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch introduces a framework to manage PASID tagged AddressSpace
in Intel vIOMMU emulator. PASID tagged AddressSpace is an address sapce
which is an abstract of guest process address space in Qemu. The
management framework is as below:

         s->pasid_as_list
              /|\ \
             / | \ \
     pasid_as_node  ...
        /|\ \
       / | \ \
  device ...

There is a list to store all the PASID tagged AddressSpace, and each
PASID tagged AddressSpace has a device list behind it. This is due to
the fact that a PASID tagged AddressSpace can have multiple devices
binded.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         |  1 +
 include/hw/i386/intel_iommu.h | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d92a66d..b8e8dbb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3174,6 +3174,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->notifiers_list);
+    QLIST_INIT(&s->pasid_as_list);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 0b6dc32..c45dbfe 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -61,6 +61,7 @@ typedef struct VTDContextEntry VTDContextEntry;
 typedef struct VTDContextCacheEntry VTDContextCacheEntry;
 typedef struct IntelIOMMUState IntelIOMMUState;
 typedef struct VTDAddressSpace VTDAddressSpace;
+typedef struct VTDPASIDAddressSpace VTDPASIDAddressSpace;
 typedef struct VTDIOTLBEntry VTDIOTLBEntry;
 typedef struct VTDBus VTDBus;
 typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
@@ -69,6 +70,8 @@ typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
 typedef struct IntelIOMMUMRNotifierNode IntelIOMMUMRNotifierNode;
 typedef struct IntelIOMMUAssignedDeviceNode IntelIOMMUAssignedDeviceNode;
+typedef struct IntelPASIDNode IntelPASIDNode;
+typedef struct VTDDeviceNode VTDDeviceNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -84,6 +87,20 @@ struct VTDContextCacheEntry {
     struct VTDContextEntry context_entry;
 };
 
+struct VTDDeviceNode {
+    PCIBus *bus;
+    uint8_t devfn;
+    QLIST_ENTRY(VTDDeviceNode) next;
+};
+
+struct VTDPASIDAddressSpace {
+    AddressSpace as;
+    IOMMUSVAContext sva_ctx;
+    IntelIOMMUState *iommu_state;
+    /* list of devices binded to a pasid tagged address space */
+    QLIST_HEAD(, VTDDeviceNode) device_list;
+};
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -264,6 +281,11 @@ struct IntelIOMMUAssignedDeviceNode {
     QLIST_ENTRY(IntelIOMMUAssignedDeviceNode) next;
 };
 
+struct IntelPASIDNode {
+    VTDPASIDAddressSpace *pasid_as;
+    QLIST_ENTRY(IntelPASIDNode) next;
+};
+
 /* The iommu (DMAR) device state struct */
 struct IntelIOMMUState {
     X86IOMMUState x86_iommu;
@@ -304,6 +326,8 @@ struct IntelIOMMUState {
     QLIST_HEAD(, IntelIOMMUMRNotifierNode) notifiers_list;
     /* list of assigned devices */
     QLIST_HEAD(, IntelIOMMUAssignedDeviceNode) assigned_device_list;
+    /* list of pasid tagged address space */
+    QLIST_HEAD(, IntelPASIDNode) pasid_as_list;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
-- 
1.9.1
