Received: from eggs.gnu.org ([209.51.188.92]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0002lB-SP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007Mg-K6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007Ht-B2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wr1-x42a.google.com with SMTP id c14so15473041wrr.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:37 +0000
Message-Id: <20190118145805.6852-22-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/49] target/arm: Introduce arm_stage1_mmu_idx
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

While we could expose stage_1_mmu_idx, the combination is
probably going to be more useful.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 15 +++++++++++++++
 target/arm/helper.c    |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 89f3b122a49..248fdf7a3c0 100644
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
index 36d1832e322..35bbc7f1091 100644
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
2.20.1
