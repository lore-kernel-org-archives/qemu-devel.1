Received: from eggs.gnu.org ([2001:4830:134:3::10]:41144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dM-0007cV-5h
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7dK-0002dz-9R
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:44 +1000
Message-Id: <20180503062145.17899-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 7/8] spapr: Move PAPR mode cpu setup fully to
 spapr code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

cpu_ppc_set_papr() does several things:
    1) it sets up the virtual hypervisor interface
    2) it prevents the cpu from ever entering hypervisor mode
    3) it tells KVM that we're emulating a cpu in PAPR mode
and 4) it configures the LPCR and AMOR (hypervisor privileged registers)
       so that TCG will behave correctly for PAPR guests, without
       attempting to emulate the cpu in hypervisor mode

(1) & (2) make sense for any virtual hypervisor (if another one ever
exists).

(3) belongs more properly in the machine type specific to a PAPR guest, so
move it to spapr_cpu_init().  While we're at it, remove an ugly test on
kvm_enabled() by making kvmppc_set_papr() a safe no-op on non-KVM.

(4) also belongs more properly in the machine type specific code.  (4) is
done by mangling the default values of the SPRs, so that they will be set
correctly at reset time.  Manipulating usually-static parameters of the cpu
model like this is kind of ugly, especially since the values used really
have more to do with the platform than the cpu.

The spapr code already has places for PAPR specific initializations of
register state in spapr_cpu_reset(), so move this handling there.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c     | 36 ++++++++++++++++++++++++++++---
 target/ppc/cpu.h            |  2 +-
 target/ppc/kvm.c            |  4 ++++
 target/ppc/translate_init.c | 42 +------------------------------------
 4 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a98c7b04c6..a52ddade5e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong lpcr;
 
     cpu_reset(cs);
 
@@ -43,13 +44,42 @@ static void spapr_cpu_reset(void *opaque)
 
     env->spr[SPR_HIOR] = 0;
 
+    lpcr = env->spr[SPR_LPCR];
+
+    /* Set emulated LPCR to not send interrupts to hypervisor. Note that
+     * under KVM, the actual HW LPCR will be set differently by KVM itself,
+     * the settings below ensure proper operations with TCG in absence of
+     * a real hypervisor.
+     *
+     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
+     * real mode accesses, which thankfully defaults to 0 and isn't
+     * accessible in guest mode.
+     */
+    lpcr &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
+    lpcr |= LPCR_LPES0 | LPCR_LPES1;
+
+    /* Set RMLS to the max (ie, 16G) */
+    lpcr &= ~LPCR_RMLS;
+    lpcr |= 1ull << LPCR_RMLS_SHIFT;
+
+    /* Only enable Power-saving mode Exit Cause exceptions on the boot
+     * CPU. The RTAS command start-cpu will enable them on secondaries.
+     */
+    if (cs == first_cpu) {
+        lpcr |= pcc->lpcr_pm;
+    }
+
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This can cause issues when rebooting the guest if a secondary
      * is awaken */
     if (cs != first_cpu) {
-        env->spr[SPR_LPCR] &= ~pcc->lpcr_pm;
+        lpcr &= ~pcc->lpcr_pm;
     }
 
+    ppc_store_lpcr(cpu, lpcr);
+
+    /* Set a full AMOR so guest can use the AMR as it sees fit */
+    env->spr[SPR_AMOR] = 0xffffffffffffffffull;
 }
 
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
@@ -74,8 +104,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
-    /* Enable PAPR mode in TCG or KVM */
-    cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
+    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
+    kvmppc_set_papr(cpu);
 
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2f619f39d3..7ccd2f460e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1332,7 +1332,7 @@ void store_booke_tcr (CPUPPCState *env, target_ulong val);
 void store_booke_tsr (CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all (CPUPPCState *env);
 void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
-void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
+void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 #endif
 #endif
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6de59c5b21..28311a98e0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2090,6 +2090,10 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     int ret;
 
+    if (!kvm_enabled()) {
+        return;
+    }
+
     ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_PAPR, 0);
     if (ret) {
         error_report("This vCPU type or KVM version does not support PAPR");
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index d92a84c622..118631efbe 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8882,13 +8882,9 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
+void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
-    ppc_spr_t *lpcr = &env->spr_cb[SPR_LPCR];
-    ppc_spr_t *amor = &env->spr_cb[SPR_AMOR];
-    CPUState *cs = CPU(cpu);
 
     cpu->vhyp = vhyp;
 
@@ -8897,42 +8893,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
      * hypervisor mode itself
      */
     env->msr_mask &= ~MSR_HVB;
-
-    /* Set emulated LPCR to not send interrupts to hypervisor. Note that
-     * under KVM, the actual HW LPCR will be set differently by KVM itself,
-     * the settings below ensure proper operations with TCG in absence of
-     * a real hypervisor.
-     *
-     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
-     * real mode accesses, which thankfully defaults to 0 and isn't
-     * accessible in guest mode.
-     */
-    lpcr->default_value &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
-    lpcr->default_value |= LPCR_LPES0 | LPCR_LPES1;
-
-    /* Set RMLS to the max (ie, 16G) */
-    lpcr->default_value &= ~LPCR_RMLS;
-    lpcr->default_value |= 1ull << LPCR_RMLS_SHIFT;
-
-    /* Only enable Power-saving mode Exit Cause exceptions on the boot
-     * CPU. The RTAS command start-cpu will enable them on secondaries.
-     */
-    if (cs == first_cpu) {
-        lpcr->default_value |= pcc->lpcr_pm;
-    }
-
-    /* We should be followed by a CPU reset but update the active value
-     * just in case...
-     */
-    ppc_store_lpcr(cpu, lpcr->default_value);
-
-    /* Set a full AMOR so guest can use the AMR as it sees fit */
-    env->spr[SPR_AMOR] = amor->default_value = 0xffffffffffffffffull;
-
-    /* Tell KVM that we're in PAPR mode */
-    if (kvm_enabled()) {
-        kvmppc_set_papr(cpu);
-    }
 }
 
 #endif /* !defined(CONFIG_USER_ONLY) */
-- 
2.17.0
