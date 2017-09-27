Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0001b0-R9
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70R-0004At-AC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:11 +1000
Message-Id: <20170927074316.4454-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/26] spapr: fix the value of SDR1 in
 kvmppc_put_books_sregs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When running with KVM PR, if a new HPT is allocated we need to inform
KVM about the HPT address and size. This is currently done by hacking
the value of SDR1 and pushing it to KVM in several places.

Also, migration breaks the guest since it is very unlikely the HPT has
the same address in source and destination, but we push the incoming
value of SDR1 to KVM anyway.

This patch introduces a new virtual hypervisor hook so that the spapr
code can provide the correct value of SDR1 to be pushed to KVM each
time kvmppc_put_books_sregs() is called.

It allows to get rid of all the hacking in the spapr/kvmppc code and
it fixes migration of nested KVM PR.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 14 ++++++++++++++
 hw/ppc/spapr_cpu_core.c | 16 +---------------
 hw/ppc/spapr_hcall.c    | 45 +++++++++++++++++++++++++++++++++------------
 target/ppc/cpu.h        |  1 +
 target/ppc/kvm.c        | 32 +++++++-------------------------
 target/ppc/kvm_ppc.h    |  6 ------
 6 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ce3ec87ac..ff87f155d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1240,6 +1240,19 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor *vhyp)
     return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
 }
 
+static target_ulong spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vhyp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    assert(kvm_enabled());
+
+    if (!spapr->htab) {
+        return 0;
+    }
+
+    return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 18);
+}
+
 static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhyp,
                                                 hwaddr ptex, int n)
 {
@@ -3604,6 +3617,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->unmap_hptes = spapr_unmap_hptes;
     vhc->store_hpte = spapr_store_hpte;
     vhc->get_patbe = spapr_get_patbe;
+    vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c08ee7571a..3e20b1d886 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -18,6 +18,7 @@
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
+#include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
 
 void spapr_cpu_parse_features(sPAPRMachineState *spapr)
@@ -73,7 +74,6 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 
 static void spapr_cpu_reset(void *opaque)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     PowerPCCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -86,20 +86,6 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted = 1;
 
     env->spr[SPR_HIOR] = 0;
-
-    /*
-     * This is a hack for the benefit of KVM PR - it abuses the SDR1
-     * slot in kvm_sregs to communicate the userspace address of the
-     * HPT
-     */
-    if (kvm_enabled()) {
-        env->spr[SPR_SDR1] = (target_ulong)(uintptr_t)spapr->htab
-            | (spapr->htab_shift - 18);
-        if (kvmppc_put_books_sregs(cpu) < 0) {
-            error_report("Unable to update SDR1 in KVM");
-            exit(1);
-        }
-    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 57bb411394..8d72bb7c1c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -686,6 +686,37 @@ static int rehash_hpt(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
+{
+    int ret;
+
+    cpu_synchronize_state(cs);
+
+    ret = kvmppc_put_books_sregs(POWERPC_CPU(cs));
+    if (ret < 0) {
+        error_report("failed to push sregs to KVM: %s", strerror(-ret));
+        exit(1);
+    }
+}
+
+static void push_sregs_to_kvm_pr(sPAPRMachineState *spapr)
+{
+    CPUState *cs;
+
+    /*
+     * This is a hack for the benefit of KVM PR - it abuses the SDR1
+     * slot in kvm_sregs to communicate the userspace address of the
+     * HPT
+     */
+    if (!kvm_enabled() || !spapr->htab) {
+        return;
+    }
+
+    CPU_FOREACH(cs) {
+        run_on_cpu(cs, do_push_sregs_to_kvm_pr, RUN_ON_CPU_NULL);
+    }
+}
+
 static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
                                         sPAPRMachineState *spapr,
                                         target_ulong opcode,
@@ -733,12 +764,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
         spapr->htab = pending->hpt;
         spapr->htab_shift = pending->shift;
 
-        if (kvm_enabled()) {
-            /* For KVM PR, update the HPT pointer */
-            target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                | (spapr->htab_shift - 18);
-            kvmppc_update_sdr1(sdr1);
-        }
+        push_sregs_to_kvm_pr(spapr);
 
         pending->hpt = NULL; /* so it's not free()d */
     }
@@ -1564,12 +1590,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            if (kvm_enabled()) {
-                /* For KVM PR, update the HPT pointer */
-                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                    | (spapr->htab_shift - 18);
-                kvmppc_update_sdr1(sdr1);
-            }
+            push_sregs_to_kvm_pr(spapr);
         }
     }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9d3ffa89b..64aef17f6f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1243,6 +1243,7 @@ struct PPCVirtualHypervisorClass {
     void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                        uint64_t pte0, uint64_t pte1);
     uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
+    target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5b281b2f1b..171d3d8040 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -941,7 +941,13 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
 
     sregs.pvr = env->spr[SPR_PVR];
 
-    sregs.u.s.sdr1 = env->spr[SPR_SDR1];
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        sregs.u.s.sdr1 = vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
+    } else {
+        sregs.u.s.sdr1 = env->spr[SPR_SDR1];
+    }
 
     /* Sync SLB */
 #ifdef TARGET_PPC64
@@ -2798,30 +2804,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift)
     return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
 }
 
-static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
-{
-    target_ulong sdr1 = arg.target_ptr;
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
-
-    /* This is just for the benefit of PR KVM */
-    cpu_synchronize_state(cs);
-    env->spr[SPR_SDR1] = sdr1;
-    if (kvmppc_put_books_sregs(cpu) < 0) {
-        error_report("Unable to update SDR1 in KVM");
-        exit(1);
-    }
-}
-
-void kvmppc_update_sdr1(target_ulong sdr1)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1));
-    }
-}
-
 /*
  * This is a helper function to detect a post migration scenario
  * in which a guest, running as KVM-HV, freezes in cpu_post_load because
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 349f892631..d6be38ecaf 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -67,7 +67,6 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
-void kvmppc_update_sdr1(target_ulong sdr1);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
@@ -325,11 +324,6 @@ static inline int kvmppc_resize_hpt_commit(PowerPCCPU *cpu,
     return -ENOSYS;
 }
 
-static inline void kvmppc_update_sdr1(target_ulong sdr1)
-{
-    abort();
-}
-
 #endif
 
 #ifndef CONFIG_KVM
-- 
2.13.5
