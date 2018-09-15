Received: from eggs.gnu.org ([2001:4830:134:3::10]:60128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGY-0004Ue-5M
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGW-0003vP-73
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:50 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:43018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGU-0003rs-6u
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id v66-v6so5742937pgb.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:27 -0700
Message-Id: <20180915161738.25257-3-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/13] target/arm: Derive id_isar0 from features
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

??? Test with -machine none -cpu foo.
??? The assertion does fire for quite a lot of cpus,
??? but quite a few of them appear to be existing bugs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3bc7a16327..44483e3dea 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -756,6 +756,50 @@ static void arm_cpu_finalizefn(Object *obj)
     }
 }
 
+static uint32_t resolve_id_isar0(CPUARMState *env, uint32_t orig)
+{
+    uint32_t ret = 0;
+
+    if (arm_feature(env, ARM_FEATURE_SWP)) {
+        ret = deposit32(ret, 0, 4, 1);            /* Swap */
+    }
+    if (arm_feature(env, ARM_FEATURE_V5)) {
+        ret = deposit32(ret , 4, 4, 1);           /* BitCount */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2)) {
+        ret = deposit32(ret, 8, 4, 1);            /* BitField */
+        ret = deposit32(ret, 12, 4, 1);           /* CmpBranch */
+    }
+
+    /*
+     * Coproc -- generically, v5te has mcrr (3), v6 has mcrr2 (4),
+     * and v8 requires none (0).  There does not appear to be a way
+     * to guess the value though, as some v6 and v7 cores also use none.
+     */
+    ret |= orig & MAKE_64BIT_MASK(16, 4);
+
+    if (arm_feature(env, ARM_FEATURE_V5)) {
+        ret = deposit32(ret, 20, 4, 1);           /* Debug */
+    }
+    /* Divide */
+    if (arm_feature(env, ARM_FEATURE_ARM_DIV)) {
+        ret = deposit32(ret, 24, 4, 2);
+    } else if (arm_feature(env, ARM_FEATURE_THUMB_DIV)) {
+        ret = deposit32(ret, 24, 4, 1);
+    }
+
+    return ret;
+}
+
+static void resolve_id_regs(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    uint64_t orig;
+
+    cpu->id_isar0 = resolve_id_isar0(env, orig = cpu->id_isar0);
+    g_assert_cmphex(cpu->id_isar0, ==, orig);
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1003,6 +1047,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, ARM_FEATURE_VBAR);
     }
 
+    resolve_id_regs(cpu);
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
 
-- 
2.17.1
