Received: from eggs.gnu.org ([2001:4830:134:3::10]:35611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz43-0002pu-9c
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz41-0006Ys-D7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:19 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  5 Oct 2017 16:50:37 +1100
Message-Id: <20171005055037.7767-3-aik@ozlabs.ru>
In-Reply-To: <20171005055037.7767-1-aik@ozlabs.ru>
References: <20171005055037.7767-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 2/2] spapr/iommu: Enable in-kernel TCE
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

This implements a notification for a new IOMMU group attached to
sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.

This uses new kernel KVM_CAP_SPAPR_TCE_VFIO capability to enable
in-kernel acceleration of TCE update requests which will go via
the VFIO KVM device.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/kvm_ppc.h |  6 ++++++
 hw/ppc/spapr_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/kvm.c     |  7 ++++++-
 hw/ppc/trace-events  |  1 +
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index d6be38ecaf..2b985e1659 100644
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
index 5ccd785d5a..34baa881f0 100644
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
@@ -173,6 +174,34 @@ static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
     }
 }
 
+static void spapr_tce_add_vfio_group(IOMMUMemoryRegion *iommu_mr,
+                                     int vfio_kvm_fd, int groupfd)
+{
+    sPAPRTCETable *tcet = container_of(iommu_mr, sPAPRTCETable, iommu);
+    struct kvm_vfio_spapr_tce param = {
+        .tablefd = tcet->fd,
+        .groupfd = groupfd,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+
+    if (!kvmppc_has_cap_spapr_vfio()) {
+        return;
+    }
+
+    if (param.tablefd != -1) {
+        if (ioctl(vfio_kvm_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
+                         param.tablefd, param.groupfd, strerror(errno));
+            return;
+        }
+    }
+    trace_spapr_iommu_add_vfio_group(groupfd, param.tablefd);
+}
+
 static int spapr_tce_table_post_load(void *opaque, int version_id)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
@@ -284,6 +313,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
 
     tcet->need_vfio = need_vfio;
 
+    if (!need_vfio || (tcet->fd != -1 && kvmppc_has_cap_spapr_vfio())) {
+        return;
+    }
+
     oldtable = tcet->table;
 
     tcet->table = spapr_tce_alloc_table(tcet->liobn,
@@ -643,6 +676,7 @@ static void spapr_iommu_memory_region_class_init(ObjectClass *klass, void *data)
     imrc->translate = spapr_tce_translate_iommu;
     imrc->get_min_page_size = spapr_tce_get_min_page_size;
     imrc->notify_flag_changed = spapr_tce_notify_flag_changed;
+    imrc->add_vfio_group = spapr_tce_add_vfio_group;
 }
 
 static const TypeInfo spapr_iommu_memory_region_info = {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 171d3d8040..5438252bdc 100644
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
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4a6a6490fa..ab70d00582 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -36,6 +36,7 @@ spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win
 spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=0x%"PRIx64" addr=0x%"PRIx32", page size=0x%"PRIx64", requested=0x%"PRIx64", start addr=0x%"PRIx64", liobn=0x%"PRIx32
 spapr_iommu_ddw_remove(uint32_t liobn) "liobn=0x%"PRIx32
 spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=0x%"PRIx64" addr=0x%"PRIx32
+spapr_iommu_add_vfio_group(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
 
 # hw/ppc/spapr_drc.c
 spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%"PRIx32
-- 
2.11.0
