Received: from eggs.gnu.org ([209.51.188.92]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrl-0000fk-2z
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrj-0008UX-1K
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:44 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 27 Feb 2019 15:30:07 +1100
Message-Id: <20190227043008.12059-3-sjitindarsingh@gmail.com>
In-Reply-To: <20190227043008.12059-1-sjitindarsingh@gmail.com>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [QEMU-PPC] [PATCH v2 3/4] target/ppc: Implement large
 decrementer support for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, clg@kaod.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Implement support to allow KVM guests to take advantage of the large
decrementer introduced on POWER9 cpus.

To determine if the host can support the requested large decrementer
size, we check it matches that specified in the ibm,dec-bits device-tree
property. We also need to enable it in KVM by setting the LPCR_LD bit in
the LPCR. Note that to do this we need to try and set the bit, then read
it back to check the host allowed us to set it, if so we can use it but
if we were unable to set it the host cannot support it and we must not
use the large decrementer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_caps.c  | 17 +++++++++++++++--
 target/ppc/kvm.c     | 39 +++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h | 12 ++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 32f68cbd9e..1e76685199 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -406,8 +406,16 @@ static void cap_large_decr_apply(sPAPRMachineState *spapr,
                 "Large decrementer only supported on POWER9, try -cpu POWER9");
             return;
         }
-    } else {
-        error_setg(errp, "No large decrementer support, try cap-large-decr=off");
+    } else if (kvm_enabled()) {
+        int kvm_nr_bits = kvmppc_get_cap_large_decr();
+
+        if (!kvm_nr_bits) {
+            error_setg(errp, "No large decrementer support, try cap-large-decr=off");
+        } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
+            error_setg(errp,
+"KVM large decrementer size (%d) differs to model (%d), try -cap-large-decr=off",
+                kvm_nr_bits, pcc->lrg_decr_bits);
+        }
     }
 }
 
@@ -418,6 +426,11 @@ static void cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
     CPUPPCState *env = &cpu->env;
     target_ulong lpcr = env->spr[SPR_LPCR];
 
+    if (kvm_enabled()) {
+        if (kvmppc_enable_cap_large_decr(cpu, val))
+            error_setg(errp, "No large decrementer support, try cap-large-decr=off");
+    }
+
     if (val)
         lpcr |= LPCR_LD;
     else
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d01852fe31..3f650c8fc4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -91,6 +91,7 @@ static int cap_ppc_safe_cache;
 static int cap_ppc_safe_bounds_check;
 static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_nested_kvm_hv;
+static int cap_large_decr;
 
 static uint32_t debug_inst_opcode;
 
@@ -124,6 +125,7 @@ static bool kvmppc_is_pr(KVMState *ks)
 
 static int kvm_ppc_register_host_cpu_type(MachineState *ms);
 static void kvmppc_get_cpu_characteristics(KVMState *s);
+static int kvmppc_get_dec_bits(void);
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
@@ -151,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
+    cap_large_decr = kvmppc_get_dec_bits();
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -1927,6 +1930,15 @@ uint64_t kvmppc_get_clockfreq(void)
     return kvmppc_read_int_cpu_dt("clock-frequency");
 }
 
+static int kvmppc_get_dec_bits(void)
+{
+    int nr_bits = kvmppc_read_int_cpu_dt("ibm,dec-bits");
+
+    if (nr_bits > 0)
+        return nr_bits;
+    return 0;
+}
+
 static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pvinfo)
  {
      PowerPCCPU *cpu = ppc_env_get_cpu(env);
@@ -2442,6 +2454,33 @@ bool kvmppc_has_cap_spapr_vfio(void)
     return cap_spapr_vfio;
 }
 
+int kvmppc_get_cap_large_decr(void)
+{
+    return cap_large_decr;
+}
+
+int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t lpcr;
+
+    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    /* Do we need to modify the LPCR? */
+    if (!!(lpcr & LPCR_LD) != !!enable) {
+        if (enable)
+            lpcr |= LPCR_LD;
+        else
+            lpcr &= ~LPCR_LD;
+        kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+        kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+
+        if (!!(lpcr & LPCR_LD) != !!enable)
+            return -1;
+    }
+
+    return 0;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index bdfaa4e70a..a79835bd14 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,6 +64,8 @@ int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
 bool kvmppc_has_cap_nested_kvm_hv(void);
 int kvmppc_set_cap_nested_kvm_hv(int enable);
+int kvmppc_get_cap_large_decr(void);
+int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -332,6 +334,16 @@ static inline int kvmppc_set_cap_nested_kvm_hv(int enable)
     return -1;
 }
 
+static inline int kvmppc_get_cap_large_decr(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
+{
+    return -1;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.13.6
