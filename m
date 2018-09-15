Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGe-0004Zz-0G
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGa-000429-QC
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGZ-0003yR-Vo
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id s7-v6so5767063pgc.0
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:32 -0700
Message-Id: <20180915161738.25257-8-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/13] target/arm: Derive id_isar5 and id_isar6
 from features
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

Unlike the other id_sar registers, these contain post-v8.0 features
that are not included with any existing cpu models.  They would be
enabled by -cpu max when we enable them for system mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3c6ddd6532..c227044946 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -926,6 +926,49 @@ static uint32_t resolve_id_isar4(CPUARMState *env)
     return ret;
 }
 
+static uint32_t resolve_id_isar5(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    /* SEVL -- we always implement as NOP.  */
+    /* AES */
+    if (arm_feature(env, ARM_FEATURE_V8_PMULL)) {
+        ret = deposit32(ret, 4, 4, 2);
+    } else if (arm_feature(env, ARM_FEATURE_V8_AES)) {
+        ret = deposit32(ret, 4, 4, 1);
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SHA1)) {
+        ret = deposit32(ret, 8, 4, 1);            /* SHA1 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_SHA256)) {
+        ret = deposit32(ret, 12, 4, 1);           /* SHA2 */
+    }
+    if (arm_feature(env, ARM_FEATURE_CRC)) {
+        ret = deposit32(ret, 16, 4, 1);           /* CRC32 */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_RDM)) {
+        ret = deposit32(ret, 24, 4, 1);           /* RDM */
+    }
+    if (arm_feature(env, ARM_FEATURE_V8_FCMA)) {
+        ret = deposit32(ret, 28, 4, 1);           /* VCMA */
+    }
+
+    return ret;
+}
+
+static uint32_t resolve_id_isar6(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    /* JSCVT -- not implemented yet */
+    /* FHM -- not implemented yet */
+    if (arm_feature(env, ARM_FEATURE_V8_DOTPROD)) {
+        ret = deposit32(ret, 4, 4, 1);            /* DP */
+    }
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -951,6 +994,9 @@ static void resolve_id_regs(ARMCPU *cpu)
     cpu->id_isar4 = resolve_id_isar4(env);
     /* Willfully ignore the SWP_frac field.  */
     g_assert_cmphex(cpu->id_isar4 & 0x0fffffff, ==, orig & 0x0fffffff);
+
+    cpu->id_isar5 = resolve_id_isar5(env);
+    cpu->id_isar6 = resolve_id_isar6(env);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
