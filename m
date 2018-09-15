Received: from eggs.gnu.org ([2001:4830:134:3::10]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGZ-0004Vm-Ml
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGY-0003xY-KM
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:43668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGY-0003wb-Dy
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id f66-v6so5523177plb.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:31 -0700
Message-Id: <20180915161738.25257-7-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] target/arm: Derive id_isar4 from features
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
??? Willfully provide a value for SWP_frac that matches our implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2b199845fc..3c6ddd6532 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -887,6 +887,45 @@ static uint32_t resolve_id_isar3(CPUARMState *env)
     return ret;
 }
 
+static uint32_t resolve_id_isar4(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    /* Unpriv -- note we don't support pre-armv4t.  */
+    ret = deposit32(ret, 0, 4, arm_feature(env, ARM_FEATURE_THUMB2) ? 2 : 1);
+    /* WithShifts */
+    if (!arm_feature(env, ARM_FEATURE_M)) {
+        ret = deposit32(ret, 4, 4, 4);
+    } else if (arm_feature(env, ARM_FEATURE_V8)) {
+        ret = deposit32(ret, 4, 4, 3);
+    }
+    ret = deposit32(ret, 8, 4, 1);                /* Writeback */
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        /* Note that EL3 indicates Security Extensions.  */
+        /* ??? In translate.c we check V6K instead.  */
+        ret = deposit32(ret, 12, 4, 1);           /* SMC */
+    }
+    if (arm_feature(env, ARM_FEATURE_V7)) {
+        ret = deposit32(ret, 16, 4, 1);           /* Barrier */
+    }
+    if (!arm_feature(env, ARM_FEATURE_V6K) &&
+        arm_feature(env, ARM_FEATURE_V6)) {
+        ret = deposit32(ret, 20, 4, 3);           /* SyncPrim_frac */
+    }
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        ret = deposit32(ret, 24, 4, 1);           /* PSR_M */
+    }
+    /*
+     * SWP_frac -- Value 1 indicates that SWP and SWPB only work in a
+     * uniprocessor context.  Looking at ARM_FEATURE_SWP, we will have
+     * already set ID_ISAR0.Swap to 1, which means that SWP_frac must
+     * be ignored.  While leaving this field 0 may not match certain
+     * real cpus, it is correct with respect to our implementation.
+     */
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -907,6 +946,11 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_isar3;
     cpu->id_isar3 = resolve_id_isar3(env);
     g_assert_cmphex(cpu->id_isar3, ==, orig);
+
+    orig = cpu->id_isar4;
+    cpu->id_isar4 = resolve_id_isar4(env);
+    /* Willfully ignore the SWP_frac field.  */
+    g_assert_cmphex(cpu->id_isar4 & 0x0fffffff, ==, orig & 0x0fffffff);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
