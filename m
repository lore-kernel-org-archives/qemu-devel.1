Received: from eggs.gnu.org ([209.51.188.92]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzYjq-0001oT-RZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzYiD-0005D7-Uy
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:19:51 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  1 Mar 2019 14:19:12 +1100
Message-Id: <20190301031912.28809-2-sjitindarsingh@gmail.com>
In-Reply-To: <20190301031912.28809-1-sjitindarsingh@gmail.com>
References: <20190301031912.28809-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 2/2] target/ppc/spapr: Add
 SPAPR_CAP_CCF_ASSIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, mpe@ellerman.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Introduce a new spapr_cap SPAPR_CAP_CCF_ASSIST to be used to indicate
the requirement for a hw-assisted version of the count cache flush
workaround.

The count cache flush workaround is a software workaround which can be
used to flush the count cache on context switch. Some revisions of
hardware may have a hardware accelerated flush, in which case the
software flush can be shortened. This cap is used to set the
availability of such hardware acceleration for the count cache flush
routine.

The availability of such hardware acceleration is indicated by the
H_CPU_CHAR_BCCTR_FLUSH_ASSIST flag being set in the characteristics
returned from the KVM_PPC_GET_CPU_CHAR ioctl.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 25 +++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   |  3 +++
 include/hw/ppc/spapr.h |  5 ++++-
 target/ppc/kvm.c       | 14 ++++++++++++++
 target/ppc/kvm_ppc.h   |  6 ++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1df324379f..708e18dcdf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2086,6 +2086,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_nested_kvm_hv,
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
+        &vmstate_spapr_cap_ccf_assist,
         NULL
     }
 };
@@ -4319,6 +4320,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 74a48a423a..f03f2f64e7 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -436,6 +436,21 @@ static void cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
     ppc_store_lpcr(cpu, lpcr);
 }
 
+static void cap_ccf_assist_apply(sPAPRMachineState *spapr, uint8_t val,
+                                 Error **errp)
+{
+    uint8_t kvm_val = kvmppc_get_cap_count_cache_flush_assist();
+
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp,
+"Requested count cache flush assist capability level not supported by tcg, try cap-ccf-assist=off");
+    } else if (kvm_enabled() && (val > kvm_val)) {
+        error_setg(errp,
+"Requested count cache flush assist capability level not supported by kvm, try cap-ccf-assist=off");
+    }
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -525,6 +540,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .apply = cap_large_decr_apply,
         .cpu_apply = cap_large_decr_cpu_apply,
     },
+    [SPAPR_CAP_CCF_ASSIST] = {
+        .name = "ccf-assist",
+        .description = "Count Cache Flush Assist via HW Instruction",
+        .index = SPAPR_CAP_CCF_ASSIST,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_ccf_assist_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -659,6 +683,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
+SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 
 void spapr_caps_init(sPAPRMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4aa8036fc0..8bfdddc964 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1693,6 +1693,7 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     uint8_t safe_cache = spapr_get_cap(spapr, SPAPR_CAP_CFPC);
     uint8_t safe_bounds_check = spapr_get_cap(spapr, SPAPR_CAP_SBBC);
     uint8_t safe_indirect_branch = spapr_get_cap(spapr, SPAPR_CAP_IBS);
+    uint8_t count_cache_flush_assist = spapr_get_cap(spapr, SPAPR_CAP_CCF_ASSIST);
 
     switch (safe_cache) {
     case SPAPR_CAP_WORKAROUND:
@@ -1733,6 +1734,8 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
         break;
     case SPAPR_CAP_WORKAROUND:
         behaviour |= H_CPU_BEHAV_FLUSH_COUNT_CACHE;
+        if (count_cache_flush_assist)
+            characteristics |= H_CPU_CHAR_BCCTR_FLUSH_ASSIST;
         break;
     default: /* broken */
         assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 80d33ea284..493a44700d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -76,8 +76,10 @@ typedef enum {
 #define SPAPR_CAP_NESTED_KVM_HV         0x07
 /* Large Decrementer */
 #define SPAPR_CAP_LARGE_DECREMENTER     0x08
+/* Count Cache Flush Assist HW Instruction */
+#define SPAPR_CAP_CCF_ASSIST            0x09
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
 
 /*
  * Capability Values
@@ -853,6 +855,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
+extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7a7a5adee3..e0f0de0ce0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -90,6 +90,7 @@ static int cap_ppc_pvr_compat;
 static int cap_ppc_safe_cache;
 static int cap_ppc_safe_bounds_check;
 static int cap_ppc_safe_indirect_branch;
+static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
 
@@ -2406,6 +2407,13 @@ static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
     return 0;
 }
 
+static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_char c)
+{
+    if (c.character & c.character_mask & H_CPU_CHAR_BCCTR_FLUSH_ASSIST)
+        return 1;
+    return 0;
+}
+
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
     struct kvm_ppc_cpu_char c;
@@ -2428,6 +2436,7 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
     cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
     cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
     cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);
+    cap_ppc_count_cache_flush_assist = parse_cap_ppc_count_cache_flush_assist(c);
 }
 
 int kvmppc_get_cap_safe_cache(void)
@@ -2445,6 +2454,11 @@ int kvmppc_get_cap_safe_indirect_branch(void)
     return cap_ppc_safe_indirect_branch;
 }
 
+int kvmppc_get_cap_count_cache_flush_assist(void)
+{
+    return cap_ppc_count_cache_flush_assist;
+}
+
 bool kvmppc_has_cap_nested_kvm_hv(void)
 {
     return !!cap_ppc_nested_kvm_hv;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a79835bd14..2937b36cae 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -62,6 +62,7 @@ bool kvmppc_has_cap_mmu_hash_v3(void);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
+int kvmppc_get_cap_count_cache_flush_assist(void);
 bool kvmppc_has_cap_nested_kvm_hv(void);
 int kvmppc_set_cap_nested_kvm_hv(int enable);
 int kvmppc_get_cap_large_decr(void);
@@ -324,6 +325,11 @@ static inline int kvmppc_get_cap_safe_indirect_branch(void)
     return 0;
 }
 
+static inline int kvmppc_get_cap_count_cache_flush_assist(void)
+{
+    return 0;
+}
+
 static inline bool kvmppc_has_cap_nested_kvm_hv(void)
 {
     return false;
-- 
2.13.6
