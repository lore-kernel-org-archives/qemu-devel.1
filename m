Received: from eggs.gnu.org ([209.51.188.92]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9e-0005tB-Jh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9d-0003UC-IB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:42 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  3 May 2019 15:53:16 +1000
Message-Id: <20190503055316.6441-14-sjitindarsingh@gmail.com>
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 13/13] target/ppc: Enable
 SPAPR_CAP_NESTED_KVM_HV under tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

It is now possible to use nested kvm-hv under tcg, thus allow for it to
be enabled.

Note that nested kvm-hv requires that rc updates to ptes be done by
software, otherwise the page tables get out of sync. So disable hardware
rc updates when nested kvm-hv is enabled.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c      | 22 ++++++++++++++++++----
 target/ppc/cpu.h         |  1 +
 target/ppc/mmu-radix64.c |  4 ++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3278c09b0f..7fe07d83dd 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -389,10 +389,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
         return;
     }
 
-    if (tcg_enabled()) {
-        error_setg(errp,
-                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
-    } else if (kvm_enabled()) {
+    if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
 "KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
@@ -400,6 +397,22 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                 error_setg(errp,
 "Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
         }
+    } /* else { nothing required for tcg } */
+}
+
+static void cap_nested_kvm_hv_cpu_apply(SpaprMachineState *spapr,
+                                        PowerPCCPU *cpu,
+                                        uint8_t val, Error **errp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    if (tcg_enabled() && val) {
+        if (env->spr[SPR_PVR] != 0x004E1202) {
+            error_setg(errp, "Nested KVM-HV only supported on POWER9 DD2.2, "
+                             "try cap-nested-hv=off or -cpu power9_v2.2");
+            return;
+        }
+        env->disable_hw_rc_updates = true;
     }
 }
 
@@ -544,6 +557,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .set = spapr_cap_set_bool,
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
+        .cpu_apply = cap_nested_kvm_hv_cpu_apply,
     },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 426015c9cd..6502e0de82 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1237,6 +1237,7 @@ struct CPUPPCState {
     target_ulong hv_ptr, regs_ptr;
     struct hv_guest_state l2_hv, l1_saved_hv;
     struct pt_regs l2_regs, l1_saved_regs;
+    bool disable_hw_rc_updates;
 };
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 2a8147fc38..cc06967dbe 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -31,9 +31,9 @@
 static inline bool ppc_radix64_hw_rc_updates(CPUPPCState *env)
 {
 #ifdef CONFIG_ATOMIC64
-    return true;
+    return !env->disable_hw_rc_updates;
 #else
-    return !qemu_tcg_mttcg_enabled();
+    return !qemu_tcg_mttcg_enabled() && !env->disable_hw_rc_updates;
 #endif
 }
 
-- 
2.13.6
