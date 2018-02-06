Received: from eggs.gnu.org ([2001:4830:134:3::10]:44727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j9-0005lF-TI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iz-0008Gs-DW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iz-0008Fi-3n
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:13 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEWC6093783
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:12 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf63hfj3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:10 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:08 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:10 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-50-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 49/54] target/ppc/kvm: Add
 cap_ppc_safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add three new kvm capabilities used to represent the level of host support
for three corresponding workarounds.

Host support for each of the capabilities is queried through the
new ioctl KVM_PPC_GET_CPU_CHAR which returns four uint64 quantities. The
first two, character and behaviour, represent the available
characteristics of the cpu and the behaviour of the cpu respectively.
The second two, c_mask and b_mask, represent the mask of known bits for
the character and beheviour dwords respectively.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
[dwg: Correct some compile errors due to name change in final kernel
 patch version]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

(cherry picked from commit 8acc2ae5e91681ceda3ff4cf946ebf163f6012e9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/hw/ppc/spapr.h | 12 +++++++++++
 target/ppc/kvm.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h   | 18 ++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c9737e6a54..2fda48fa54 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -295,6 +295,18 @@ struct sPAPRMachineState {
 #define H_DABRX_KERNEL     (1ULL<<(63-62))
 #define H_DABRX_USER       (1ULL<<(63-63))
 
+/* Values for KVM_PPC_GET_CPU_CHAR & H_GET_CPU_CHARACTERISTICS */
+#define H_CPU_CHAR_SPEC_BAR_ORI31               PPC_BIT(0)
+#define H_CPU_CHAR_BCCTRL_SERIALISED            PPC_BIT(1)
+#define H_CPU_CHAR_L1D_FLUSH_ORI30              PPC_BIT(2)
+#define H_CPU_CHAR_L1D_FLUSH_TRIG2              PPC_BIT(3)
+#define H_CPU_CHAR_L1D_THREAD_PRIV              PPC_BIT(4)
+#define H_CPU_CHAR_HON_BRANCH_HINTS             PPC_BIT(5)
+#define H_CPU_CHAR_THR_RECONF_TRIG              PPC_BIT(6)
+#define H_CPU_BEHAV_FAVOUR_SECURITY             PPC_BIT(0)
+#define H_CPU_BEHAV_L1D_FLUSH_PR                PPC_BIT(1)
+#define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR           PPC_BIT(2)
+
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT     4096
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 81d9bd56c7..368508b679 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -92,6 +92,9 @@ static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
 static int cap_resize_hpt;
 static int cap_ppc_pvr_compat;
+static int cap_ppc_safe_cache;
+static int cap_ppc_safe_bounds_check;
+static int cap_ppc_safe_indirect_branch;
 
 static uint32_t debug_inst_opcode;
 
@@ -124,6 +127,7 @@ static bool kvmppc_is_pr(KVMState *ks)
 }
 
 static int kvm_ppc_register_host_cpu_type(MachineState *ms);
+static void kvmppc_get_cpu_characteristics(KVMState *s);
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
@@ -150,6 +154,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
+    kvmppc_get_cpu_characteristics(s);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2459,6 +2464,59 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+static void kvmppc_get_cpu_characteristics(KVMState *s)
+{
+    struct kvm_ppc_cpu_char c;
+    int ret;
+
+    /* Assume broken */
+    cap_ppc_safe_cache = 0;
+    cap_ppc_safe_bounds_check = 0;
+    cap_ppc_safe_indirect_branch = 0;
+
+    ret = kvm_vm_check_extension(s, KVM_CAP_PPC_GET_CPU_CHAR);
+    if (!ret) {
+        return;
+    }
+    ret = kvm_vm_ioctl(s, KVM_PPC_GET_CPU_CHAR, &c);
+    if (ret < 0) {
+        return;
+    }
+    /* Parse and set cap_ppc_safe_cache */
+    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
+        cap_ppc_safe_cache = 2;
+    } else if ((c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
+               (c.character & c.character_mask
+                & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
+        cap_ppc_safe_cache = 1;
+    }
+    /* Parse and set cap_ppc_safe_bounds_check */
+    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
+        cap_ppc_safe_bounds_check = 2;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
+        cap_ppc_safe_bounds_check = 1;
+    }
+    /* Parse and set cap_ppc_safe_indirect_branch */
+    if (c.character & H_CPU_CHAR_BCCTRL_SERIALISED) {
+        cap_ppc_safe_indirect_branch = 2;
+    }
+}
+
+int kvmppc_get_cap_safe_cache(void)
+{
+    return cap_ppc_safe_cache;
+}
+
+int kvmppc_get_cap_safe_bounds_check(void)
+{
+    return cap_ppc_safe_bounds_check;
+}
+
+int kvmppc_get_cap_safe_indirect_branch(void)
+{
+    return cap_ppc_safe_indirect_branch;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index ecb55493cc..39830baa77 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -59,6 +59,9 @@ bool kvmppc_has_cap_fixup_hcalls(void);
 bool kvmppc_has_cap_htm(void);
 bool kvmppc_has_cap_mmu_radix(void);
 bool kvmppc_has_cap_mmu_hash_v3(void);
+int kvmppc_get_cap_safe_cache(void);
+int kvmppc_get_cap_safe_bounds_check(void);
+int kvmppc_get_cap_safe_indirect_branch(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -290,6 +293,21 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
     return false;
 }
 
+static inline int kvmppc_get_cap_safe_cache(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_get_cap_safe_bounds_check(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_get_cap_safe_indirect_branch(void)
+{
+    return 0;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.11.0
