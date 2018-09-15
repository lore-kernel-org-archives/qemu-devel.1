Received: from eggs.gnu.org ([2001:4830:134:3::10]:60265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGh-0004dP-5K
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGg-00048P-Dd
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:44611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGg-00047b-6t
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id r1-v6so5742637pgp.11
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:37 -0700
Message-Id: <20180915161738.25257-13-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/13] target/arm: Derive id_aa64pfr0 from
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
 target/arm/cpu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a9724f3bb1..2ec71104c9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1080,6 +1080,31 @@ static uint64_t resolve_id_aa64isar1(CPUARMState *env)
     return ret;
 }
 
+static uint64_t resolve_id_aa64pfr0(CPUARMState *env)
+{
+    uint64_t ret = 0;
+
+    ret = deposit64(ret, 0, 4, 2);                /* EL0 */
+    ret = deposit64(ret, 4, 4, 2);                /* EL1 */
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        ret = deposit64(ret, 8, 4, 2);            /* EL2 */
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        ret = deposit64(ret, 12, 4, 2);           /* EL3 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_FP16)) {
+        ret = deposit64(ret, 16, 4, 1);           /* FP */
+        ret = deposit64(ret, 20, 4, 1);           /* AdvSIMD */
+    }
+    /* GIC -- info not available yet; filled in by id_aa64pfr0_read */
+    /* RAS -- not implemented yet */
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        ret = deposit64(ret, 32, 4, 1);           /* SVE */
+    }
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1122,6 +1147,10 @@ static void resolve_id_regs(ARMCPU *cpu)
     g_assert_cmphex(cpu->id_aa64isar0, ==, orig);
 
     cpu->id_aa64isar1 = resolve_id_aa64isar1(env);
+
+    orig = cpu->id_aa64pfr0;
+    cpu->id_aa64pfr0 = resolve_id_aa64pfr0(env);
+    g_assert_cmphex(cpu->id_aa64pfr0, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
