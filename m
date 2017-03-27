Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csN7K-0000hc-LZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csN7H-0007yM-Jb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:22:58 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 27 Mar 2017 16:22:19 +1100
Message-Id: <20170327052219.33110-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] target-ppc/kvm: Enable in-kernel TCE
 acceleration for multi-tce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This enables in-kernel handling of H_PUT_TCE_INDIRECT and
H_STUFF_TCE hypercalls. The host kernel support is there since v4.6,
in particular d3695aa4f452
("KVM: PPC: Add support for multiple-TCE hcalls").

H_PUT_TCE is already accelerated and does not need any special enablement.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/kvm_ppc.h |  6 ++++++
 hw/ppc/spapr.c       |  4 +++-
 target/ppc/kvm.c     | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 4b2fd9a609..f48243d13f 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -39,6 +39,7 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
+int kvmppc_spapr_enable_inkernel_multitce(void);
 void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
                               uint64_t bus_offset, uint32_t nb_table,
                               int *pfd, bool need_vfio);
@@ -180,6 +181,11 @@ static inline bool kvmppc_spapr_use_multitce(void)
     return false;
 }
 
+static inline int kvmppc_spapr_enable_inkernel_multitce(void)
+{
+    return -1;
+}
+
 static inline void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
                                             uint64_t bus_offset,
                                             uint32_t nb_table,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0e1c29bcf8..8027716f73 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2360,10 +2360,12 @@ static void ppc_spapr_init(MachineState *machine)
 
     qemu_register_boot_set(spapr_boot_set, spapr);
 
-    /* to stop and start vmclock */
     if (kvm_enabled()) {
+        /* to stop and start vmclock */
         qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
                                          &spapr->tb);
+
+        kvmppc_spapr_enable_inkernel_multitce();
     }
 }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6dc39623e5..560ce655c7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2194,6 +2194,20 @@ bool kvmppc_spapr_use_multitce(void)
     return cap_spapr_multitce;
 }
 
+int kvmppc_spapr_enable_inkernel_multitce(void)
+{
+    int ret;
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
+                            H_PUT_TCE_INDIRECT, 1);
+    if (!ret) {
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_ENABLE_HCALL, 0,
+                                H_STUFF_TCE, 1);
+    }
+
+    return ret;
+}
+
 void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
                               uint64_t bus_offset, uint32_t nb_table,
                               int *pfd, bool need_vfio)
-- 
2.11.0
