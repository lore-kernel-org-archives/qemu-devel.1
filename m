Received: from eggs.gnu.org ([2001:4830:134:3::10]:50199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7Z-0006EK-5e
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7W-000076-QO
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:17 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  2 Jan 2018 16:28:03 +1100
Message-Id: <20180102052805.20498-2-aik@ozlabs.ru>
In-Reply-To: <20180102052805.20498-1-aik@ozlabs.ru>
References: <20180102052805.20498-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 1/3] memory/iommu: Add get_attr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This adds get_attr() to IOMMUMemoryRegionClass, like
iommu_ops::domain_get_attr in the Linux kernel.

This defines the first attribute - IOMMU_ATTR_SPAPR_TCE_FD - which
will be used between the pSeries machine and VFIO-PCI.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h | 22 ++++++++++++++++++++++
 memory.c              | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index a4cabdf..e1e0a8e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -190,6 +190,10 @@ struct MemoryRegionOps {
     const MemoryRegionMmio old_mmio;
 };
 
+enum IOMMUMemoryRegionAttr {
+    IOMMU_ATTR_SPAPR_TCE_FD
+};
+
 typedef struct IOMMUMemoryRegionClass {
     /* private */
     struct DeviceClass parent_class;
@@ -210,6 +214,10 @@ typedef struct IOMMUMemoryRegionClass {
                                 IOMMUNotifierFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
+
+    /* Get IOMMU misc attributes */
+    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+                    void *data);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -924,6 +932,20 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n);
 
 /**
+ * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
+ * defined on the IOMMU.
+ *
+ * Returns 0 if succeded, error code otherwise.
+ *
+ * @iommu_mr: the memory region
+ * @attr: the requested attribute
+ * @data: a pointer to the requested attribute data
+ */
+int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
+                                 enum IOMMUMemoryRegionAttr attr,
+                                 void *data);
+
+/**
  * memory_region_name: get a memory region's name
  *
  * Returns the string that was used to initialize the memory region.
diff --git a/memory.c b/memory.c
index 4b41fb8..39ab25a 100644
--- a/memory.c
+++ b/memory.c
@@ -1920,6 +1920,19 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
     }
 }
 
+int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
+                                 enum IOMMUMemoryRegionAttr attr,
+                                 void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (!imrc->get_attr) {
+        return -EINVAL;
+    }
+
+    return imrc->get_attr(iommu_mr, attr, data);
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask = 1 << client;
-- 
2.11.0
