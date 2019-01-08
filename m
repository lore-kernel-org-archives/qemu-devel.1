Received: from eggs.gnu.org ([209.51.188.92]:52730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv7-0000Cf-AA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv5-0004n8-Ct
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:25 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzv5-0004k2-79
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:23 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so2595122pfd.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:15 +1000
Message-Id: <20190108223129.5570-18-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 17/31] target/arm: Introduce
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 15 +++++++++++++++
 target/arm/helper.c    |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 89f3b122a4..248fdf7a3c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -927,4 +927,19 @@ void arm_cpu_update_vfiq(ARMCPU *cpu);
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
index ba6733c4f1..4af8abd18f 100644
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
