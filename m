Received: from eggs.gnu.org ([2001:4830:134:3::10]:54658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dfXpm-0003Sv-Af
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dfXpj-0002us-5t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dfXpi-0002uQ-Ru
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:44:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v79KhfMY001671
	for <qemu-devel@nongnu.org>; Wed, 9 Aug 2017 16:44:01 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c8792frsa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 16:44:01 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 9 Aug 2017 16:44:00 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  9 Aug 2017 17:43:46 -0300
Message-Id: <20170809204346.5220-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: 'PVR != host PVR' in KVM_SET_SREGS
 workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru

Commit d5fc133eed ("ppc: Rework CPU compatibility testing
across migration") changed the way cpu_post_load behaves with
the PVR setting, causing an unexpected bug in KVM-HV migrations
between hosts that are compatible (POWER8 and POWER8E, for example).
Even with pvr_match() returning true, the guest freezes right after
cpu_post_load. The reason is that the guest kernel can't handle a
different PVR value other that the running host in KVM_SET_SREGS.

In [1] it was discussed the possibility of a new KVM capability
that would indicate that the guest kernel can handle a different
PVR in KVM_SET_SREGS. Even if such feature is implemented, there is
still the problem with older kernels that will not have this capability
and will fail to migrate.

This patch implements a workaround for that scenario. If running
with KVM, check if the guest kernel does not have the capability
(named here as 'cap_ppc_pvr_compat'). If it doesn't, calls
kvmppc_is_pr() to see if the guest is running in KVM-HV. If all this
happens, set env->spr[SPR_PVR] to the same value as the current
host PVR. This ensures that we allow migrations with 'close enough'
PVRs to still work in KVM-HV but also makes the code ready for
this new KVM capability when it is done.

A new function called 'kvmppc_pvr_workaround_required' was created
to encapsulate the conditions said above and to avoid calling too
many kvm.c internals inside cpu_post_load.

[1] https://lists.gnu.org/archive/html/qemu-ppc/2017-06/msg00503.html

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 target/ppc/kvm.c     | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h |  1 +
 target/ppc/machine.c | 22 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8571379..fb3ee43 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -90,6 +90,7 @@ static int cap_htm;             /* Hardware transactional memory support */
 static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
 static int cap_resize_hpt;
+static int cap_ppc_pvr_compat;
 
 static uint32_t debug_inst_opcode;
 
@@ -147,6 +148,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
+    /*
+     * Note: setting it to false because there is not such capability
+     * in KVM at this moment.
+     *
+     * TODO: call kvm_vm_check_extension() with the right capability
+     * after the kernel starts implementing it.*/
+    cap_ppc_pvr_compat = false;
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
@@ -2785,3 +2793,29 @@ void kvmppc_update_sdr1(target_ulong sdr1)
         run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1));
     }
 }
+
+/*
+ * This is a helper function to detect a post migration scenario
+ * in which a guest, running as KVM-HV, freezes in cpu_post_load because
+ * the guest kernel can't handle a PVR value other than the actual host
+ * PVR in KVM_SET_SREGS, even if pvr_match() returns true.
+ *
+ * If we don't have cap_ppc_pvr_compat and we're not running in PR
+ * (so, we're HV), return true. The workaround itself is done in
+ * cpu_post_load.
+ *
+ * The order here is important: we'll only check for KVM PR as a
+ * fallback if the guest kernel can't handle the situation itself.
+ * We need to avoid as much as possible querying the running KVM type
+ * in QEMU level.
+ */
+bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (cap_ppc_pvr_compat) {
+        return false;
+    }
+
+    return !kvmppc_is_pr(cs->kvm_state);
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 6bc6fb3..381afe6 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -67,6 +67,7 @@ void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
 void kvmppc_update_sdr1(target_ulong sdr1);
+bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index f578156..e545885 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -9,6 +9,7 @@
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
 #include "qapi/error.h"
+#include "kvm_ppc.h"
 
 static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
 {
@@ -250,6 +251,27 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
+    /*
+     * If we're running with KVM HV, there is a chance that the guest
+     * is running with KVM HV and its kernel does not have the
+     * capability of dealing with a different PVR other than this
+     * exact host PVR in KVM_SET_SREGS. If that happens, the
+     * guest freezes after migration.
+     *
+     * The function kvmppc_pvr_workaround_required does this verification
+     * by first checking if the kernel has the cap, returning true immediately
+     * if that is the case. Otherwise, it checks if we're running in KVM PR.
+     * If the guest kernel does not have the cap and we're not running KVM-PR
+     * (so, it is running KVM-HV), we need to ensure that KVM_SET_SREGS will
+     * receive the PVR it expects as a workaround.
+     *
+     */
+#if defined(CONFIG_KVM)
+    if (kvmppc_pvr_workaround_required(cpu)) {
+        env->spr[SPR_PVR] = env->spr_cb[SPR_PVR].default_value;
+    }
+#endif
+
     env->lr = env->spr[SPR_LR];
     env->ctr = env->spr[SPR_CTR];
     cpu_write_xer(env, env->spr[SPR_XER]);
-- 
2.9.4
