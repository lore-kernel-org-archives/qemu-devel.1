Received: from eggs.gnu.org ([2001:4830:134:3::10]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtcD-0003DW-So
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtc8-0005hF-UD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:25:09 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drtc8-0005gW-Nz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:25:04 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C4F9BAA9F7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 00:25:03 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 13 Sep 2017 00:25:01 +0200
Message-ID: <150525510133.11068.18348168748736729990.stgit@bahia.lan>
In-Reply-To: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
References: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/2] spapr: preserve SDR1 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When running with KVM PR, a pseries machine needs to allocate an HPT
in userspace and pass its address and size too KVM. This is done at
machine reset time by hijacking SDR1.

It is very likely that the destination QEMU will allocate the HPT at
a different address, ie, the SDR1 value we get from the migration
stream is wrong and the guest ends up badly broken.

Let's fix this by preserving the pre-load value of SDR1. Since this is
a spapr specific hack, this is achieved by extending the PPC virtual
hypervisor interface.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c       |   30 ++++++++++++++++++++++++++++++
 target/ppc/cpu.h     |    5 +++++
 target/ppc/machine.c |   18 ++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97f8afdbd7fe..aa280c9d767f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1200,6 +1200,34 @@ static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
     return spapr->patb_entry;
 }
 
+static void spapr_cpu_pre_load(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    /* This is a hack for KVM PR: SDR1 contains the address and size of the HPT
+     * allocated by QEMU. We must preserve it.
+     */
+    if (kvm_enabled() && spapr->htab) {
+        CPUPPCState *env = &cpu->env;
+
+        cpu->sdr1_kvm_pr = env->spr[SPR_SDR1];
+    }
+}
+
+static void spapr_cpu_post_load(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    /* This is a hack for KVM PR: SDR1 contains the address and size of the HPT
+     * allocated by QEMU. We must preserve it.
+     */
+    if (kvm_enabled() && spapr->htab) {
+        CPUPPCState *env = &cpu->env;
+
+        env->spr[SPR_SDR1] = cpu->sdr1_kvm_pr;
+    }
+}
+
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
 #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
@@ -3624,6 +3652,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->unmap_hptes = spapr_unmap_hptes;
     vhc->store_hpte = spapr_store_hpte;
     vhc->get_patbe = spapr_get_patbe;
+    vhc->cpu_pre_load = spapr_cpu_pre_load;
+    vhc->cpu_post_load = spapr_cpu_post_load;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9d3ffa89bcb..22ea2538d923 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1212,6 +1212,9 @@ struct PowerPCCPU {
     uint64_t mig_insns_flags2;
     uint32_t mig_nb_BATs;
     bool pre_2_10_migration;
+
+    /* KVM PR hack to preserve SDR1 (HPT) */
+    target_ulong sdr1_kvm_pr;
 };
 
 static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
@@ -1243,6 +1246,8 @@ struct PPCVirtualHypervisorClass {
     void (*store_hpte)(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                        uint64_t pte0, uint64_t pte1);
     uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
+    void (*cpu_pre_load)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    void (*cpu_post_load)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e36b7100cb66..c4d32c886367 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -218,6 +218,19 @@ static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
     return pcc->pvr_match(pcc, pvr);
 }
 
+static int cpu_pre_load(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_pre_load(cpu->vhyp, cpu);
+    }
+
+    return 0;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     PowerPCCPU *cpu = opaque;
@@ -294,6 +307,10 @@ static int cpu_post_load(void *opaque, int version_id)
 
     if (!cpu->vhyp) {
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
+    } else {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_post_load(cpu->vhyp, cpu);
     }
 
     /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring */
@@ -650,6 +667,7 @@ const VMStateDescription vmstate_ppc_cpu = {
     .minimum_version_id_old = 4,
     .load_state_old = cpu_load_old,
     .pre_save = cpu_pre_save,
+    .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UNUSED(sizeof(target_ulong)), /* was _EQUAL(env.spr[SPR_PVR]) */
