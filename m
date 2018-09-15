Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGe-0004Zy-0H
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGd-00044Z-1X
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGc-00043P-HJ
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id f6-v6so5532392plo.1
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:34 -0700
Message-Id: <20180915161738.25257-10-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] target/arm: Derive id_pfr1 from features
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
index 0151c278e8..4fb3e0a9ea 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -992,6 +992,31 @@ static uint32_t resolve_id_pfr0(CPUARMState *env)
     return ret;
 }
 
+static uint32_t resolve_id_pfr1(CPUARMState *env)
+{
+    uint32_t ret = 0;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        ret = deposit32(ret, 8, 4, 2);            /* MProgMod */
+    } else {
+        ret = deposit32(ret, 0, 4, 1);            /* ProgMod */
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        ret = deposit32(ret, 4, 4, 1);            /* Security */
+    }
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        ret = deposit32(ret, 12, 4, 1);           /* Virtualization */
+    }
+    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
+        ret = deposit32(ret, 16, 4, 1);           /* GenTimer */
+    }
+    /* Sec_frac -- no partial features implemented without EL3 */
+    /* Virt_frac -- no partial features implemented without EL2 */
+    /* GIC -- info not available yet; filled in by id_pfr1_read */
+
+    return ret;
+}
+
 static void resolve_id_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1024,6 +1049,10 @@ static void resolve_id_regs(ARMCPU *cpu)
     orig = cpu->id_pfr0;
     cpu->id_pfr0 = resolve_id_pfr0(env);
     g_assert_cmphex(cpu->id_pfr0, ==, orig);
+
+    orig = cpu->id_pfr1;
+    cpu->id_pfr1 = resolve_id_pfr1(env);
+    g_assert_cmphex(cpu->id_pfr1, ==, orig);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1
