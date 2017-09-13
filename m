Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds56d-0000KI-Fs
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds56Z-0004Qp-G9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:41:19 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:57807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ds56Z-0004PD-6y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:41:15 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id ACC95A9602
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 12:41:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 13 Sep 2017 12:41:07 +0200
Message-ID: <150529882490.818.398056435765712294.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: fix the value of SDR1 in
 kvmppc_put_books_sregs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>

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
---

Unfortunately, this doesn't fix migration when using KVM PR on baremetal.
I get tons of instruction emulation errors in the console when the guest
resumes execution at the destination:

[  833.585957] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[  833.586818] kvmppc_exit_pr_progint: emulation at 60000000600e5bfc failed
 (00000000)
[  833.674684] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[  833.675370] kvmppc_exit_pr_progint: emulation at 60000000600e5bfc failed
 (00000000)
[  833.676297] Couldn't emulate instruction 0x00000000 (op 0 xop 0)

I still don't know what's happening here but I guess this is an issue in
KVM.

 hw/ppc/spapr.c          |   13 +++++++++++++
 hw/ppc/spapr_cpu_core.c |   15 ---------------
 hw/ppc/spapr_hcall.c    |   14 --------------
 target/ppc/cpu.h        |    2 ++
 target/ppc/kvm.c        |   30 +++++-------------------------
 target/ppc/kvm_ppc.h    |    6 ------
 6 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f680f28a15ea..7e7ae585a1b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1239,6 +1239,18 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor *vhyp)
     return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
 }
 
+static void spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vhyp,
+                                        target_ulong *hpt)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    assert(kvm_enabled());
+
+    if (spapr->htab) {
+        *hpt = (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 18);
+    }
+}
+
 static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhyp,
                                                 hwaddr ptex, int n)
 {
@@ -3603,6 +3615,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->unmap_hptes = spapr_unmap_hptes;
     vhc->store_hpte = spapr_store_hpte;
     vhc->get_patbe = spapr_get_patbe;
+    vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c08ee7571a50..c20b5c64b045 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -73,7 +73,6 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 
 static void spapr_cpu_reset(void *opaque)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     PowerPCCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -86,20 +85,6 @@ static void spapr_cpu_reset(void *opaque)
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
index 57bb411394ed..840abff0e371 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -732,14 +732,6 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
         qemu_vfree(spapr->htab);
         spapr->htab = pending->hpt;
         spapr->htab_shift = pending->shift;
-
-        if (kvm_enabled()) {
-            /* For KVM PR, update the HPT pointer */
-            target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                | (spapr->htab_shift - 18);
-            kvmppc_update_sdr1(sdr1);
-        }
-
         pending->hpt = NULL; /* so it's not free()d */
     }
 
@@ -1564,12 +1556,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            if (kvm_enabled()) {
-                /* For KVM PR, update the HPT pointer */
-                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                    | (spapr->htab_shift - 18);
-                kvmppc_update_sdr1(sdr1);
-            }
         }
     }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9d3ffa89bcb..12e0b6e74876 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1243,6 +1243,8 @@ struct PPCVirtualHypervisorClass {
     void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                        uint64_t pte0, uint64_t pte1);
     uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
+    void (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp,
+                                  target_ulong *hpt);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6442dfcb95b3..8edc05fc6a83 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -941,7 +941,11 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
 
     sregs.pvr = env->spr[SPR_PVR];
 
-    sregs.u.s.sdr1 = env->spr[SPR_SDR1];
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->encode_hpt_for_kvm_pr(cpu->vhyp, &sregs.u.s.sdr1);
+    }
 
     /* Sync SLB */
 #ifdef TARGET_PPC64
@@ -2806,30 +2810,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift)
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
index f780e6ec7b72..21571edd7910 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -68,7 +68,6 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
-void kvmppc_update_sdr1(target_ulong sdr1);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
@@ -331,11 +330,6 @@ static inline int kvmppc_resize_hpt_commit(PowerPCCPU *cpu,
     return -ENOSYS;
 }
 
-static inline void kvmppc_update_sdr1(target_ulong sdr1)
-{
-    abort();
-}
-
 #endif
 
 #ifndef CONFIG_KVM
