Received: from eggs.gnu.org ([209.51.188.92]:57023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNs-0006IA-5a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNr-0001z9-J3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:52 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1zNr-0001yX-BX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:51 -0500
Received: by mail-pf1-x443.google.com with SMTP id j5so12296868pfa.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:12:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 12:12:44 -0800
Message-Id: <20190307201244.8971-3-richard.henderson@linaro.org>
In-Reply-To: <20190307201244.8971-1-richard.henderson@linaro.org>
References: <20190307201244.8971-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Don't add system-registers.xml
 for user-only
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

The system registers aren't that interesting for debugging
user binaries.  Avoid adding them in this case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2607d39ad1..ca5632d26f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -221,6 +221,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -243,6 +244,7 @@ static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
 {
     return 0;
 }
+#endif
 
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
@@ -6694,9 +6696,11 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  19, "arm-vfp.xml", 0);
     }
+#ifndef CONFIG_USER_ONLY
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
                              arm_gen_dynamic_xml(cs),
                              "system-registers.xml", 0);
+#endif
 }
 
 /* Sort alphabetically by type name, except for "any". */
-- 
2.17.2
