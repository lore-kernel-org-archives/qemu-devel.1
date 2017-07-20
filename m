Received: from eggs.gnu.org ([2001:4830:134:3::10]:46740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nl-0006bu-DN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nh-0003OR-1U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:23:13 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 20 Jul 2017 17:22:30 +1000
Message-Id: <20170720072231.35054-3-aik@ozlabs.ru>
In-Reply-To: <20170720072231.35054-1-aik@ozlabs.ru>
References: <20170720072231.35054-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 2/3] vfio/spapr: Add a notifier for
 PPC64 HV/PR KVM about new group attached to LIOBN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

This implements a notification for a new IOMMU group attached to
sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.

This extends the TYPE_SPAPR_IOMMU_MEMORY_REGION class with a get_fd()
callback which returns KVM fd associated with LIOBN, the notifier uses it
to establish link between LIOBN and IOMMU group in the KVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The practical reason for adding get_fd() as a callback is avoiding static
linking to spapt_tce_get_fd(): hw/vfio/spapr.c compiles when
CONFIG_SOFTMMU=y to avoid multiple "ifdef PSERIES"'s in the rest
of VFIO code but hw/ppc/spapr_iommu.c (where spapt_tce_get_fd() besides)
compiles only when CONFIG_PSERIES=y.
---
 include/hw/ppc/spapr.h        | 15 +++++++++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 hw/ppc/spapr_iommu.c          | 10 ++++++++++
 hw/vfio/common.c              | 10 ++++++++++
 hw/vfio/spapr.c               | 39 +++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 6 files changed, 77 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2a303a705c..c1d37e6356 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -591,6 +591,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *fdt, hwaddr addr);
 #define RTAS_EVENT_SCAN_RATE    1
 
 typedef struct sPAPRTCETable sPAPRTCETable;
+typedef struct sPAPRIOMMUMemoryRegionClass sPAPRIOMMUMemoryRegionClass;
 
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
 #define SPAPR_TCE_TABLE(obj) \
@@ -599,6 +600,12 @@ typedef struct sPAPRTCETable sPAPRTCETable;
 #define TYPE_SPAPR_IOMMU_MEMORY_REGION "spapr-iommu-memory-region"
 #define SPAPR_IOMMU_MEMORY_REGION(obj) \
         OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMORY_REGION)
+#define SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRIOMMUMemoryRegionClass, obj, \
+                         TYPE_SPAPR_IOMMU_MEMORY_REGION)
+#define SPAPR_IOMMU_MEMORY_REGION_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRIOMMUMemoryRegionClass, klass, \
+                           TYPE_SPAPR_IOMMU_MEMORY_REGION)
 
 struct sPAPRTCETable {
     DeviceState parent;
@@ -618,6 +625,14 @@ struct sPAPRTCETable {
     QLIST_ENTRY(sPAPRTCETable) list;
 };
 
+struct sPAPRIOMMUMemoryRegionClass {
+    /* private */
+    IOMMUMemoryRegionClass parent_class;
+
+    /* public */
+    int (*get_fd)(IOMMUMemoryRegion *iommu_mr);
+};
+
 sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
 
 struct sPAPREventLogEntry {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9fee..d245d3cecc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -177,6 +177,8 @@ extern const MemoryListener vfio_prereg_listener;
 int vfio_spapr_create_window(VFIOContainer *container,
                              MemoryRegionSection *section,
                              hwaddr *pgsize);
+int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
+                          IOMMUMemoryRegion *iommumr);
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 307dc3021e..82fca61a75 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -171,6 +171,13 @@ static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
     }
 }
 
+static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu_mr)
+{
+    sPAPRTCETable *tcet = container_of(iommu_mr, sPAPRTCETable, iommu);
+
+    return tcet->fd;
+}
+
 static int spapr_tce_table_post_load(void *opaque, int version_id)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
@@ -631,16 +638,19 @@ static TypeInfo spapr_tce_table_info = {
 static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+    sPAPRIOMMUMemoryRegionClass *simrc = SPAPR_IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = spapr_tce_translate_iommu;
     imrc->get_min_page_size = spapr_tce_get_min_page_size;
     imrc->notify_flag_changed = spapr_tce_notify_flag_changed;
+    simrc->get_fd = spapr_tce_get_fd;
 }
 
 static const TypeInfo spapr_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_SPAPR_IOMMU_MEMORY_REGION,
     .class_init = spapr_iommu_memory_region_class_init,
+    .class_size = sizeof(sPAPRIOMMUMemoryRegionClass),
 };
 
 static void register_types(void)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..92f1f88ae8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -454,6 +454,16 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
+#ifdef CONFIG_KVM
+        if (kvm_enabled()) {
+            VFIOGroup *group;
+
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                vfio_spapr_notify_kvm(vfio_kvm_device_fd, group->fd,
+                                      IOMMU_MEMORY_REGION(section->mr));
+            }
+        }
+#endif
         vfio_host_win_add(container, section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1, pgsize);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 32fd6a9b54..2b9af75c03 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,8 +15,12 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
+#include "hw/ppc/spapr.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#ifdef CONFIG_KVM
+#include "linux/kvm.h"
+#endif
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
@@ -188,6 +192,41 @@ int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
+int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
+                          IOMMUMemoryRegion *iommu_mr)
+{
+#ifdef CONFIG_KVM
+    struct kvm_vfio_spapr_tce param = {
+        .groupfd = groupfd,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+    IOMMUMemoryRegion *spapr_iommu_mr = SPAPR_IOMMU_MEMORY_REGION(iommu_mr);
+    sPAPRIOMMUMemoryRegionClass *simrc =
+            SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(spapr_iommu_mr);
+
+    if (!simrc->get_fd) {
+        error_report("vfio: No get_fd defined for IOMMU MR");
+        return -EFAULT;
+    }
+
+    param.tablefd = simrc->get_fd(spapr_iommu_mr);
+
+    if (param.tablefd != -1) {
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
+                         param.tablefd, param.groupfd, strerror(errno));
+            return -errno;
+        }
+    }
+    trace_vfio_spapr_notify_kvm(groupfd, param.tablefd);
+#endif
+    return 0;
+}
+
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space)
 {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2561c6d31a..084a92f7c2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"P
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
+vfio_spapr_notify_kvm(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.11.0
