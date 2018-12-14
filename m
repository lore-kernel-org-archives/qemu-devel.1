Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxk-0004Vr-JQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxj-0005SE-4c
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:36 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxi-0005R4-2T
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:34 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so4293711otk.9
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:59 -0600
Message-Id: <20181214052410.11863-17-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 16/27] target/arm: Introduce
 arm_stage1_mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

While we could expose stage_1_mmu_idx, the combination is
probably going to be more useful.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 15 +++++++++++++++
 target/arm/helper.c    |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4a52fe58b6..1d0d0392c9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -920,4 +920,19 @@ void arm_cpu_update_vfiq(ARMCPU *cpu);
  */
 ARMMMUIdx arm_mmu_idx(CPUARMState *env);
 
+/**
+ * arm_stage1_mmu_idx:
+ * @env: The cpu environment
+ *
+ * Return the ARMMMUIdx for the stage1 traversal for the current regime.
+ */
+#ifdef CONFIG_USER_ONLY
+static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
+{
+    return ARMMMUIdx_S1NSE0;
+}
+#else
+ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
+#endif
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50c1db16dd..b1c0ff923f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12998,6 +12998,13 @@ int cpu_mmu_index(CPUARMState *env, bool ifetch)
     return arm_to_core_mmu_idx(arm_mmu_idx(env));
 }
 
+#ifndef CONFIG_USER_ONLY
+ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
+{
+    return stage_1_mmu_idx(arm_mmu_idx(env));
+}
+#endif
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-- 
2.17.2
