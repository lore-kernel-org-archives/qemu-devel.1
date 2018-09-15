Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGZ-0004VY-Ce
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGY-0003wi-1m
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGW-0003tW-57
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:48 -0400
Received: by mail-pl1-x641.google.com with SMTP id b12-v6so5519591plr.8
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:28 -0700
Message-Id: <20180915161738.25257-4-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/13] target/arm: Derive id_isar1 from features
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

??? The assertion does fire for quite a lot of cpus,
??? but quite a few of them appear to be existing bugs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 44483e3dea..a477e722af 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -791,13 +791,48 @@ static uint32_t resolve_id_isar0(CPUARMState *env, uint32_t orig)
     return ret;
 }
 
+static uint32_t resolve_id_isar1(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    if (arm_feature(env, ARM_FEATURE_V6)) {
+        ret = deposit32(ret, 0, 4, 1);            /* Endian */
+        if (!arm_feature(env, ARM_FEATURE_M)) {
+            ret = deposit32(ret, 4, 4, 1);        /* Except */
+            ret = deposit32(ret, 8, 4, 1);        /* Except_AR */
+        }
+        /* Extend */
+        ret = deposit32(ret, 12, 4,
+                             arm_feature(env, ARM_FEATURE_THUMB_DSP) ? 2 : 1);
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2)) {
+        ret = deposit32(ret, 16, 4, 1);           /* IfThen */
+        ret = deposit32(ret, 20, 4, 1);           /* Immediate */
+    }
+    /* Interwork -- note we don't support pre-armv4t.  */
+    ret = deposit32(ret, 24, 4,
+                         arm_feature(env, ARM_FEATURE_V7)
+                         && !arm_feature(env, ARM_FEATURE_M) ? 3 :
+                         arm_feature(env, ARM_FEATURE_V5) ? 2 : 1);
+    if (arm_feature(env, ARM_FEATURE_JAZELLE)) {
+        ret = deposit32(ret, 28, 4, 1);           /* Jazelle */
+    }
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     uint64_t orig;
 
-    cpu->id_isar0 = resolve_id_isar0(env, orig = cpu->id_isar0);
+    orig = cpu->id_isar0;
+    cpu->id_isar0 = resolve_id_isar0(env, orig);
     g_assert_cmphex(cpu->id_isar0, ==, orig);
+
+    orig = cpu->id_isar1;
+    cpu->id_isar1 = resolve_id_isar1(env);
+    g_assert_cmphex(cpu->id_isar1, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
