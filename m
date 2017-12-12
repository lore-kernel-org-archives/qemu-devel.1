Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcy5-0005oA-MZ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcy1-0007F7-Ke
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:19:01 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 12 Dec 2017 16:18:53 +1100
Message-Id: <20171212051853.24583-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] RFC: spapr/iommu: Enable in-kernel TCE
 acceleration via VFIO KVM device
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

In order to enable TCE operations support in KVM, we have to inform
the KVM about VFIO groups being attached to specific LIOBNs. The KVM
already knows about VFIO groups, the only bit missing is which
in-kernel TCE table (the one with user visible TCEs) should update
the attached broups. There is an KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE
attribute of the VFIO KVM device which receives a groupfd/tablefd couple.

This adds get_attr()/set_attr() to IOMMUMemoryRegionClass, like
iommu_ops::domain_get_attr/domain_set_attr in the Linux kernel.

This implements get_attr() for sPAPR IOMMU to return a TCE table fd
as an IOMMU_ATTR_KVM_FD attribute. This also reads now
the KVM_CAP_SPAPR_TCE_VFIO capability to prevent the TCE table from
reallocating to the userspace if the KVM can accelerate TCE operations.

This finally notifies the VFIO KVM device about new group being attached
to a LIOBN.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Assuming it is accepted, does it make sense to split
include/exec/memory.h out and get merged separately?

---
 include/exec/memory.h | 10 ++++++++++
 target/ppc/kvm_ppc.h  |  6 ++++++
 hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
 hw/vfio/common.c      | 24 ++++++++++++++++++++++++
 target/ppc/kvm.c      |  7 ++++++-
 hw/vfio/trace-events  |  1 +
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042..6395c6f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -190,6 +190,10 @@ struct MemoryRegionOps {
     const MemoryRegionMmio old_mmio;
 };
 
+enum IOMMUMemoryRegionAttr {
+    IOMMU_ATTR_KVM_FD
+};
+
 typedef struct IOMMUMemoryRegionClass {
     /* private */
     struct DeviceClass parent_class;
@@ -210,6 +214,12 @@ typedef struct IOMMUMemoryRegionClass {
                                 IOMMUNotifierFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
+
+    /* Get/set IOMMU misc attributes */
+    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+                    void *data);
+    int (*set_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+                    void *data);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index d6be38e..2b985e1 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -48,6 +48,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
+bool kvmppc_has_cap_spapr_vfio(void);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
@@ -231,6 +232,11 @@ static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
     return true;
 }
 
+static inline bool kvmppc_has_cap_spapr_vfio(void)
+{
+    return false;
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static inline bool kvmppc_has_cap_epr(void)
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5ccd785..ce8a769 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
@@ -160,6 +161,19 @@ static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
     return 1ULL << tcet->page_shift;
 }
 
+static int spapr_tce_get_attr(IOMMUMemoryRegion *iommu,
+                              enum IOMMUMemoryRegionAttr attr, void *data)
+{
+    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
+
+    if (attr == IOMMU_ATTR_KVM_FD && kvmppc_has_cap_spapr_vfio()) {
+        *(int *) data = tcet->fd;
+        return 0;
+    }
+
+    return -EINVAL;
+}
+
 static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                           IOMMUNotifierFlag old,
                                           IOMMUNotifierFlag new)
@@ -284,6 +298,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
 
     tcet->need_vfio = need_vfio;
 
+    if (!need_vfio || (tcet->fd != -1 && kvmppc_has_cap_spapr_vfio())) {
+        return;
+    }
+
     oldtable = tcet->table;
 
     tcet->table = spapr_tce_alloc_table(tcet->liobn,
@@ -643,6 +661,7 @@ static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
     imrc->translate = spapr_tce_translate_iommu;
     imrc->get_min_page_size = spapr_tce_get_min_page_size;
     imrc->notify_flag_changed = spapr_tce_notify_flag_changed;
+    imrc->get_attr = spapr_tce_get_attr;
 }
 
 static const TypeInfo spapr_iommu_memory_region_info = {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cd81cc9..ed7717d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -480,6 +480,30 @@ static void vfio_listener_region_add(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+#ifdef CONFIG_KVM
+        struct kvm_vfio_spapr_tce param;
+        IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+        VFIOGroup *group;
+        struct kvm_device_attr attr = {
+            .group = KVM_DEV_VFIO_GROUP,
+            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+            .addr = (uint64_t)(unsigned long)&param,
+        };
+
+        if (kvm_enabled() && imrc->get_attr &&
+            !imrc->get_attr(iommu_mr, IOMMU_ATTR_KVM_FD, &param.tablefd)) {
+
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                param.groupfd = group->fd;
+                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                    error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
+                                 param.tablefd, param.groupfd, strerror(errno));
+                    return;
+                }
+                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+            }
+        }
+#endif
 
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9d57deb..da7590a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -136,7 +136,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
-    cap_spapr_vfio = false;
+    cap_spapr_vfio = kvm_vm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
     cap_hior = kvm_check_extension(s, KVM_CAP_PPC_HIOR);
     cap_epr = kvm_check_extension(s, KVM_CAP_PPC_EPR);
@@ -2474,6 +2474,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+bool kvmppc_has_cap_spapr_vfio(void)
+{
+    return cap_spapr_vfio;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fae096c..3d34fe8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
+vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.11.0
