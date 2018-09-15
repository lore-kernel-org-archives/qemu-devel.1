Received: from eggs.gnu.org ([2001:4830:134:3::10]:60281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGi-0004eU-9R
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGh-0004AO-Kv
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:18:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGh-000495-F4
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id k21-v6so5647300pff.11
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:38 -0700
Message-Id: <20180915161738.25257-14-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/13] target/arm: Remove assertions from
 resolve_id_regs
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

This is a prerequisite to removing the now-redundant
initializations from within the individual cpus.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2ec71104c9..79103926a4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1108,49 +1108,22 @@ static uint64_t resolve_id_aa64pfr0(CPUARMState *env)
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
-    uint64_t orig;
 
-    orig = cpu->id_isar0;
-    cpu->id_isar0 = resolve_id_isar0(env, orig);
-    g_assert_cmphex(cpu->id_isar0, ==, orig);
-
-    orig = cpu->id_isar1;
+    cpu->id_isar0 = resolve_id_isar0(env, cpu->id_isar0);
     cpu->id_isar1 = resolve_id_isar1(env);
-    g_assert_cmphex(cpu->id_isar1, ==, orig);
-
-    orig = cpu->id_isar2;
-    cpu->id_isar2 = resolve_id_isar2(env, orig);
-    g_assert_cmphex(cpu->id_isar2, ==, orig);
-
-    orig = cpu->id_isar3;
+    cpu->id_isar2 = resolve_id_isar2(env, cpu->id_isar2);
     cpu->id_isar3 = resolve_id_isar3(env);
-    g_assert_cmphex(cpu->id_isar3, ==, orig);
-
-    orig = cpu->id_isar4;
     cpu->id_isar4 = resolve_id_isar4(env);
-    /* Willfully ignore the SWP_frac field.  */
-    g_assert_cmphex(cpu->id_isar4 & 0x0fffffff, ==, orig & 0x0fffffff);
-
     cpu->id_isar5 = resolve_id_isar5(env);
     cpu->id_isar6 = resolve_id_isar6(env);
-
-    orig = cpu->id_pfr0;
     cpu->id_pfr0 = resolve_id_pfr0(env);
-    g_assert_cmphex(cpu->id_pfr0, ==, orig);
-
-    orig = cpu->id_pfr1;
     cpu->id_pfr1 = resolve_id_pfr1(env);
-    g_assert_cmphex(cpu->id_pfr1, ==, orig);
 
-    orig = cpu->id_aa64isar0;
-    cpu->id_aa64isar0 = resolve_id_aa64isar0(env);
-    g_assert_cmphex(cpu->id_aa64isar0, ==, orig);
-
-    cpu->id_aa64isar1 = resolve_id_aa64isar1(env);
-
-    orig = cpu->id_aa64pfr0;
-    cpu->id_aa64pfr0 = resolve_id_aa64pfr0(env);
-    g_assert_cmphex(cpu->id_aa64pfr0, ==, orig);
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        cpu->id_aa64isar0 = resolve_id_aa64isar0(env);
+        cpu->id_aa64isar1 = resolve_id_aa64isar1(env);
+        cpu->id_aa64pfr0 = resolve_id_aa64pfr0(env);
+    }
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
