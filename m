Received: from eggs.gnu.org ([2001:4830:134:3::10]:50477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF87-0006dl-MA
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF84-0000Ph-J5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:51 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  2 Jan 2018 16:28:05 +1100
Message-Id: <20180102052805.20498-4-aik@ozlabs.ru>
In-Reply-To: <20180102052805.20498-1-aik@ozlabs.ru>
References: <20180102052805.20498-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 3/3] spapr/iommu: Enable in-kernel TCE
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
the KVM about VFIO groups being attached to specific LIOBNs;
the necessary bits are implemented already by IOMMU MR and VFIO.

This defines get_attr() for the SPAPR TCE IOMMU MR which makes VFIO
call the KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE ioctl and establish
LIOBN-to-IOMMU link.

This changes spapr_tce_set_need_vfio() to avoid TCE table reallocation
if the kernel supports the TCE acceleration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/kvm_ppc.h |  6 ++++++
 hw/ppc/spapr_iommu.c | 19 +++++++++++++++++++
 target/ppc/kvm.c     |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index ecb5549..c55bb67 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -46,6 +46,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
+bool kvmppc_has_cap_spapr_vfio(void);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
@@ -229,6 +230,11 @@ static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
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
index 5ccd785..f45538c 100644
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
+    if (attr == IOMMU_ATTR_SPAPR_TCE_FD && kvmppc_has_cap_spapr_vfio()) {
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
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 518dd06..6faeb25 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -133,7 +133,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
-    cap_spapr_vfio = false;
+    cap_spapr_vfio = kvm_vm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
     cap_hior = kvm_check_extension(s, KVM_CAP_PPC_HIOR);
     cap_epr = kvm_check_extension(s, KVM_CAP_PPC_EPR);
@@ -2456,6 +2456,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
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
-- 
2.11.0
