Received: from eggs.gnu.org ([2001:4830:134:3::10]:59220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVE-0008Bv-7h
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVD-0007mx-Aa
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:00 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVD-0007md-5M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:59 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so3373723otj.2
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:20 -0600
Message-Id: <20181207103631.28193-16-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/26] target/arm: Introduce arm_mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

The pattern

  ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));

is computing the full ARMMMUIdx, stripping off the ARM bits,
and then putting them back.

Avoid the extra two steps with the appropriate helper function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18f2378b87..6bac5c18d0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2740,6 +2740,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
 
 /* Determine the current mmu_idx to use for normal loads/stores */
+ARMMMUIdx arm_mmu_idx(CPUARMState *env);
 int cpu_mmu_index(CPUARMState *env, bool ifetch);
 
 /* Indexes used when registering address spaces with cpu_address_space_init */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index eaa9e60e7b..be8daefc46 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7127,7 +7127,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
             limit = env->v7m.msplim[M_REG_S];
         }
     } else {
-        mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+        mmu_idx = arm_mmu_idx(env);
         frame_sp_p = &env->regs[13];
         limit = v7m_sp_limit(env);
     }
@@ -7308,7 +7308,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
     uint32_t frameptr = env->regs[13];
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
     /* Align stack pointer if the guest wants that */
     if ((frameptr & 4) &&
@@ -11083,7 +11083,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     int prot;
     bool ret;
     ARMMMUFaultInfo fi = {};
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
     *attrs = (MemTxAttrs) {};
 
@@ -12987,26 +12987,31 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
     return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
 }
 
-int cpu_mmu_index(CPUARMState *env, bool ifetch)
+ARMMMUIdx arm_mmu_idx(CPUARMState *env)
 {
-    int el = arm_current_el(env);
+    int el;
 
     if (arm_feature(env, ARM_FEATURE_M)) {
-        ARMMMUIdx mmu_idx = arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
-
-        return arm_to_core_mmu_idx(mmu_idx);
+        return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    el = arm_current_el(env);
     if (el < 2 && arm_is_secure_below_el3(env)) {
-        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0 + el);
+        return ARMMMUIdx_S1SE0 + el;
+    } else {
+        return ARMMMUIdx_S12NSE0 + el;
     }
-    return el;
+}
+
+int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    return arm_to_core_mmu_idx(arm_mmu_idx(env));
 }
 
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
     uint32_t flags;
-- 
2.17.2
