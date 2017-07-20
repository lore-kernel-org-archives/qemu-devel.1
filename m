Received: from eggs.gnu.org ([2001:4830:134:3::10]:46492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nH-0006Fd-19
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nE-00030q-9R
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:43 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 20 Jul 2017 17:22:31 +1000
Message-Id: <20170720072231.35054-4-aik@ozlabs.ru>
In-Reply-To: <20170720072231.35054-1-aik@ozlabs.ru>
References: <20170720072231.35054-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 3/3] spapr/iommu: Enable in-kernel TCE
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

This uses new kernel KVM_CAP_SPAPR_TCE_VFIO capability to enable
in-kernel acceleration of TCE update requests which will go via
the VFIO KVM device.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm_ppc.h | 6 ++++++
 hw/ppc/spapr_iommu.c | 4 ++++
 target/ppc/kvm.c     | 7 ++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6bc6fb3e2d..96936ec50f 100644
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
@@ -220,6 +221,11 @@ static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
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
index 82fca61a75..3b4c1f50f4 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -289,6 +289,10 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
 
     tcet->need_vfio = need_vfio;
 
+    if (!need_vfio || (tcet->fd != -1 && kvmppc_has_cap_spapr_vfio())) {
+        return;
+    }
+
     oldtable = tcet->table;
 
     tcet->table = spapr_tce_alloc_table(tcet->liobn,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 85713795de..413ce84509 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -134,7 +134,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
     cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
-    cap_spapr_vfio = false;
+    cap_spapr_vfio = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_VFIO);
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
     cap_hior = kvm_check_extension(s, KVM_CAP_PPC_HIOR);
     cap_epr = kvm_check_extension(s, KVM_CAP_PPC_EPR);
@@ -2428,6 +2428,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
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
