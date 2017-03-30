Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUT-0000m6-1d
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUQ-0006Am-U0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:49 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 30 Mar 2017 23:47:04 +1100
Message-Id: <20170330124707.28142-3-aik@ozlabs.ru>
In-Reply-To: <20170330124707.28142-1-aik@ozlabs.ru>
References: <20170330124707.28142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 2/5] spapr-iommu: Subclass
 TYPE_IOMMU_MEMORY_REGION
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h | 22 ++++++++++++++++++++++
 hw/ppc/spapr_iommu.c   | 25 ++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6997ed7e98..5d5ce4dd2b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -573,11 +573,25 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *fdt, hwaddr addr);
 #define RTAS_EVENT_SCAN_RATE    1
 
 typedef struct sPAPRTCETable sPAPRTCETable;
+typedef struct sPAPRIOMMUMemoryRegionClass sPAPRIOMMUMemoryRegionClass;
 
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
 #define SPAPR_TCE_TABLE(obj) \
     OBJECT_CHECK(sPAPRTCETable, (obj), TYPE_SPAPR_TCE_TABLE)
 
+#define TYPE_SPAPR_IOMMU_MEMORY_REGION "qemu:spapr_iommu-memory-region"
+#define SPAPR_IOMMU_MEMORY_REGION(obj) \
+        OBJECT_CHECK(IOMMUMemoryRegion, (obj), \
+        TYPE_SPAPR_IOMMU_MEMORY_REGION)
+
+#define SPAPR_IOMMU_MEMORY_REGION_CLASS(k) \
+        OBJECT_CLASS_CHECK(sPAPRIOMMUMemoryRegionClass, (k), \
+        TYPE_SPAPR_IOMMU_MEMORY_REGION)
+
+#define SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRIOMMUMemoryRegionClass, (obj), \
+        TYPE_SPAPR_IOMMU_MEMORY_REGION)
+
 struct sPAPRTCETable {
     DeviceState parent;
     uint32_t liobn;
@@ -596,6 +610,14 @@ struct sPAPRTCETable {
     QLIST_ENTRY(sPAPRTCETable) list;
 };
 
+struct sPAPRIOMMUMemoryRegionClass {
+    /*< private >*/
+    ObjectClass parent_class;
+    /*< public >*/
+
+    int (*get_fd)(IOMMUMemoryRegion *iommu);
+};
+
 sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 
 struct sPAPREventLogEntry {
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5051110b9d..5b0eee1be4 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -171,6 +171,13 @@ static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
     }
 }
 
+static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu)
+{
+    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
+
+    return tcet->fd;
+}
+
 static int spapr_tce_table_post_load(void *opaque, int version_id)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
@@ -266,7 +273,7 @@ static int spapr_tce_table_realize(DeviceState *dev)
     memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
 
     snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
-    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
+    memory_region_init_iommu_type(TYPE_SPAPR_IOMMU_MEMORY_REGION,
                                   &tcet->iommu, tcetobj, &spapr_iommu_ops,
                                   tmp, 0);
 
@@ -634,9 +641,25 @@ static TypeInfo spapr_tce_table_info = {
     .class_init = spapr_tce_table_class_init,
 };
 
+static void spapr_iommu_memory_region_class_init(ObjectClass *k, void *data)
+{
+    sPAPRIOMMUMemoryRegionClass *smrc = SPAPR_IOMMU_MEMORY_REGION_CLASS(k);
+
+    smrc->get_fd = spapr_tce_get_fd;
+}
+
+static const TypeInfo spapr_iommu_memory_region_info = {
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .name = TYPE_SPAPR_IOMMU_MEMORY_REGION,
+    .instance_size = sizeof(IOMMUMemoryRegion),
+    .class_size = sizeof(sPAPRIOMMUMemoryRegionClass),
+    .class_init = spapr_iommu_memory_region_class_init,
+};
+
 static void register_types(void)
 {
     type_register_static(&spapr_tce_table_info);
+    type_register_static(&spapr_iommu_memory_region_info);
 }
 
 type_init(register_types);
-- 
2.11.0
