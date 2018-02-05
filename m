Received: from eggs.gnu.org ([2001:4830:134:3::10]:35425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilx6-0001F1-9t
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilx3-0003u3-74
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilx2-0003tQ-Uf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B7E81E03
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:57:12 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:57:04 -0700
Message-ID: <20180205185704.14391.10906.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 03/11] spapr/iommu: Enable in-kernel TCE
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

In order to enable TCE operations support in KVM, we have to inform
the KVM about VFIO groups being attached to specific LIOBNs;
the necessary bits are implemented already by IOMMU MR and VFIO.

This defines get_attr() for the SPAPR TCE IOMMU MR which makes VFIO
call the KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE ioctl and establish
LIOBN-to-IOMMU link.

This changes spapr_tce_set_need_vfio() to avoid TCE table reallocation
if the kernel supports the TCE acceleration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/ppc/spapr_iommu.c |   19 +++++++++++++++++++
 target/ppc/kvm.c     |    7 ++++++-
 target/ppc/kvm_ppc.h |    6 ++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5ccd785d5a06..f45538c6f298 100644
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
index 84284d5957c5..9842b3bb124e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -137,7 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
-    cap_spapr_vfio = false;
+    cap_spapr_vfio = kvm_vm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
     cap_hior = kvm_check_extension(s, KVM_CAP_PPC_HIOR);
     cap_epr = kvm_check_extension(s, KVM_CAP_PPC_EPR);
@@ -2514,6 +2514,11 @@ int kvmppc_get_cap_safe_indirect_branch(void)
     return cap_ppc_safe_indirect_branch;
 }
 
+bool kvmppc_has_cap_spapr_vfio(void)
+{
+    return cap_spapr_vfio;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 39830baa77b9..4d2789eef6ef 100644
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
@@ -232,6 +233,11 @@ static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
     return true;
 }
 
+static inline bool kvmppc_has_cap_spapr_vfio(void)
+{
+    return false;
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static inline bool kvmppc_has_cap_epr(void)
