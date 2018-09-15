Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGZ-0004Vc-ED
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGY-0003xJ-Az
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGY-0003w9-3h
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id w14-v6so5512224plp.6
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:30 -0700
Message-Id: <20180915161738.25257-6-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/13] target/arm: Derive id_isar3 from features
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

??? The assertion does fire for the old cpus; they may be existing bugs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 379d6a08a4..2b199845fc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -855,6 +855,38 @@ static uint32_t resolve_id_isar2(CPUARMState *env, uint32_t orig)
     return ret;
 }
 
+static uint32_t resolve_id_isar3(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    if (arm_feature(env, ARM_FEATURE_V5)) {
+        ret = deposit32(ret, 0, 4, 1);            /* Saturate */
+    }
+    if (arm_feature(env, ARM_FEATURE_V6)) {
+        ret = deposit32(ret, 4, 4, 3);            /* SIMD */
+    }
+    ret = deposit32(ret, 8, 4, 1);                /* SVC -- no pre-armv4t */
+    /* SynchPrim */
+    if (arm_feature(env, ARM_FEATURE_V6K)) {
+        ret = deposit32(ret, 12, 4, 2);           /* ldrex, ldrexb, ldrexd */
+    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+        ret = deposit32(ret, 12, 4, 1);           /* ldrex only */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2)) {
+        ret = deposit32(ret, 16, 4, 1);           /* TabBranch */
+        ret = deposit32(ret, 20, 4, 1);           /* T32Copy */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2) ||
+        arm_feature(env, ARM_FEATURE_V6K)) {
+        ret = deposit32(ret, 24, 4, 1);           /* TrueNOP */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+        ret = deposit32(ret, 28, 4, 1);           /* T32EE */
+    }
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -871,6 +903,10 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_isar2;
     cpu->id_isar2 = resolve_id_isar2(env, orig);
     g_assert_cmphex(cpu->id_isar2, ==, orig);
+
+    orig = cpu->id_isar3;
+    cpu->id_isar3 = resolve_id_isar3(env);
+    g_assert_cmphex(cpu->id_isar3, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
