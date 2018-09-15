Received: from eggs.gnu.org ([2001:4830:134:3::10]:60241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGf-0004cC-WB
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGf-00047A-90
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:57 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:43776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGe-000457-30
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id j26-v6so5639105pfi.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:35 -0700
Message-Id: <20180915161738.25257-11-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/13] target/arm: Derive id_aa64isar0 from
 features
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4fb3e0a9ea..1c51b9f631 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1017,6 +1017,51 @@ static uint32_t resolve_id_pfr1(CPUARMState *env)
     return ret;
 }
 
+static uint64_t resolve_id_aa64isar0(CPUARMState *env)
+{
+    uint64_t ret = 0;
+
+    /* AES */
+    if (arm_feature(env, ARM_FEATURE_V8_PMULL)) {
+        ret = deposit64(ret, 4, 4, 2);
+    } else if (arm_feature(env, ARM_FEATURE_V8_AES)) {
+        ret = deposit64(ret, 4, 4, 1);
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SHA1)) {
+        ret = deposit64(ret, 8, 4, 1);            /* SHA1 */
+    }
+    /* SHA2 */
+    if (arm_feature(env, ARM_FEATURE_V8_SHA512)) {
+        ret = deposit64(ret, 12, 4, 2);
+    } else if (arm_feature(env, ARM_FEATURE_V8_SHA256)) {
+        ret = deposit64(ret, 12, 4, 1);
+    }
+    if (arm_feature(env, ARM_FEATURE_CRC)) {
+        ret = deposit64(ret, 16, 4, 1);           /* CRC32 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_ATOMICS)) {
+        ret = deposit64(ret, 20, 4, 2);           /* Atomic */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_RDM)) {
+        ret = deposit64(ret, 28, 4, 1);           /* RDM */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SHA3)) {
+        ret = deposit64(ret, 32, 4, 1);           /* SHA3 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SM3)) {
+        ret = deposit64(ret, 36, 4, 1);           /* SM3 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SM4)) {
+        ret = deposit64(ret, 40, 4, 1);           /* SM4 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_DOTPROD)) {
+        ret = deposit64(ret, 44, 4, 1);           /* DP */
+    }
+    /* FHM -- not implemented yet */
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1053,6 +1098,10 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_pfr1;
     cpu->id_pfr1 = resolve_id_pfr1(env);
     g_assert_cmphex(cpu->id_pfr1, ==, orig);
+
+    orig = cpu->id_aa64isar0;
+    cpu->id_aa64isar0 = resolve_id_aa64isar0(env);
+    g_assert_cmphex(cpu->id_aa64isar0, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
