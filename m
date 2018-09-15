Received: from eggs.gnu.org ([2001:4830:134:3::10]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGd-0004Zv-W4
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGc-00043R-1c
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:43669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGb-00040p-4p
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id f66-v6so5523197plb.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:33 -0700
Message-Id: <20180915161738.25257-9-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/13] target/arm: Derive id_pfr0 from features
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

??? The assertion does fire for old cpus; they may be existing bugs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c227044946..0151c278e8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -969,6 +969,29 @@ static uint32_t resolve_id_isar6(CPUARMState *env)
     return ret;
 }
 
+static uint32_t resolve_id_pfr0(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    if (!arm_feature(env, ARM_FEATURE_M)) {
+        ret = deposit32(ret, 0, 4, 1);            /* State0 -- A32 */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2)) {
+        ret = deposit32(ret, 4, 4, 3);            /* State1 -- T32 */
+    } else if (arm_feature(env, ARM_FEATURE_V5)) {
+        ret = deposit32(ret, 4, 4, 1);            /* State1 -- bl/blx only */
+    }
+    if (arm_feature(env, ARM_FEATURE_JAZELLE)) {
+        ret = deposit32(ret, 8, 4, 1);            /* State2 -- Jazelle */
+    }
+    if (arm_feature(env, ARM_FEATURE_THUMB2EE)) {
+        ret = deposit32(ret, 12, 4, 1);           /* State3 -- T32EE */
+    }
+    /* RAS -- not implemented yet */
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -997,6 +1020,10 @@ static void resolve_id_regs(ARMCPU *cpu)
 
     cpu->id_isar5 = resolve_id_isar5(env);
     cpu->id_isar6 = resolve_id_isar6(env);
+
+    orig = cpu->id_pfr0;
+    cpu->id_pfr0 = resolve_id_pfr0(env);
+    g_assert_cmphex(cpu->id_pfr0, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
