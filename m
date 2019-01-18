Received: from eggs.gnu.org ([209.51.188.92]:43077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbX-0002nB-8c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0007OQ-Dm
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Hc-11
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id t6so15369689wrr.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:36 +0000
Message-Id: <20190118145805.6852-21-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/49] target/arm: Introduce arm_mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The pattern

  ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));

is computing the full ARMMMUIdx, stripping off the ARM bits,
and then putting them back.

Avoid the extra two steps with the appropriate helper function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  9 ++++++++-
 target/arm/internals.h |  8 ++++++++
 target/arm/helper.c    | 27 ++++++++++++++++-----------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index eb83a71b67b..c1d511f274c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2749,7 +2749,14 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
 
-/* Determine the current mmu_idx to use for normal loads/stores */
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
 int cpu_mmu_index(CPUARMState *env, bool ifetch);
 
 /* Indexes used when registering address spaces with cpu_address_space_init */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0ed20c03cc8..89f3b122a49 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -919,4 +919,12 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_mmu_idx:
+ * @env: The cpu environment
+ *
+ * Return the full ARMMMUIdx for the current translation regime.
+ */
+ARMMMUIdx arm_mmu_idx(CPUARMState *env);
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 25a79929417..36d1832e322 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7117,7 +7117,7 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
             limit = env->v7m.msplim[M_REG_S];
         }
     } else {
-        mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+        mmu_idx = arm_mmu_idx(env);
         frame_sp_p = &env->regs[13];
         limit = v7m_sp_limit(env);
     }
@@ -7298,7 +7298,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
     uint32_t frameptr = env->regs[13];
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
     /* Align stack pointer if the guest wants that */
     if ((frameptr & 4) &&
@@ -11073,7 +11073,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     int prot;
     bool ret;
     ARMMMUFaultInfo fi = {};
-    ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
     *attrs = (MemTxAttrs) {};
 
@@ -12977,26 +12977,31 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
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
     uint32_t flags = 0;
-- 
2.20.1
