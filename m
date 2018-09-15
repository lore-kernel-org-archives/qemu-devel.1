Received: from eggs.gnu.org ([2001:4830:134:3::10]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGZ-0004Vb-E8
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGY-0003wt-5W
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGW-0003uV-8Q
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:49 -0400
Received: by mail-pg1-x530.google.com with SMTP id s15-v6so5749458pgv.8
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:29 -0700
Message-Id: <20180915161738.25257-5-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/13] target/arm: Derive id_isar2 from features
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
 target/arm/cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a477e722af..379d6a08a4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -821,6 +821,40 @@ static uint32_t resolve_id_isar1(CPUARMState *env)
     return ret;
 }
 
+static uint32_t resolve_id_isar2(CPUARMState *env, uint32_t orig)
+{
+    uint32_t ret = 0;
+
+    /* LoadStore */
+    ret = deposit32(ret, 0, 4,
+                    arm_feature(env, ARM_FEATURE_V8) ? 2 :
+                    arm_feature(env, ARM_FEATURE_V5) ? 1 : 0);
+    /*
+     * MemHint -- v7mp has pldw (4), v7 has pli (3), but values 1 & 2
+     * mean the same thing, and there does not seem to be a way to tell
+     * them apart for v5 & v6.
+     */
+    ret |= orig & MAKE_64BIT_MASK(4, 4);
+    /* MultiAccessInt -- micro-architectural detail.  */
+    ret |= orig & MAKE_64BIT_MASK(8, 4);
+    /* Mult -- note we don't support pre-armv4t.  */
+    ret = deposit32(ret, 12, 4, arm_feature(env, ARM_FEATURE_THUMB2) ? 2 : 1);
+    /* MultS -- note we don't support pre-armv4t.  */
+    ret = deposit32(ret, 16, 4,
+                    arm_feature(env, ARM_FEATURE_V6) ? 3 :
+                    arm_feature(env, ARM_FEATURE_V5) ? 2 : 1);
+    /* MultU -- note we don't support pre-armv4t.  */
+    ret = deposit32(ret, 20, 4, arm_feature(env, ARM_FEATURE_V6) ? 2 : 1);
+    /* PSR_AR */
+    ret = deposit32(ret, 24, 4, arm_feature(env, ARM_FEATURE_M) ? 0 : 1);
+    /* Reversal */
+    ret = deposit32(ret, 28, 4,
+                    arm_feature(env, ARM_FEATURE_THUMB2) ? 2 :
+                    arm_feature(env, ARM_FEATURE_V6) ? 1 : 0);
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -833,6 +867,10 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_isar1;
     cpu->id_isar1 = resolve_id_isar1(env);
     g_assert_cmphex(cpu->id_isar1, ==, orig);
+
+    orig = cpu->id_isar2;
+    cpu->id_isar2 = resolve_id_isar2(env, orig);
+    g_assert_cmphex(cpu->id_isar2, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
