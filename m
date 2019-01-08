Received: from eggs.gnu.org ([209.51.188.92]:52464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuU-0007z1-8G
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuT-0004CS-AG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:46 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzuT-0004Bs-4Y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id e11so2558029plt.11
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:31:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:01 +1000
Message-Id: <20190108223129.5570-4-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/31] target/arm: Add PAuth active bit to
 tbflags
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

There are 5 bits of state that could be added, but to save
space within tbflags, add only a single enable bit.
Helpers will determine the rest of the state at runtime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
----
v2: Fix whitespace, comment grammar.
v3: Rebase on FIELD definition.
---
 target/arm/cpu.h           |  1 +
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 19 +++++++++++++++++++
 target/arm/translate-a64.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 843d5936ea..9ad7b2d11e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3014,6 +3014,7 @@ FIELD(TBFLAG_A64, TBI0, 0, 1)
 FIELD(TBFLAG_A64, TBI1, 1, 1)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
+FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1550aa8bc7..d8a8bb4e9c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -68,6 +68,8 @@ typedef struct DisasContext {
     bool is_ldex;
     /* True if a single-step exception will be taken to the current EL */
     bool ss_same_el;
+    /* True if v8.3-PAuth is active.  */
+    bool pauth_active;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* TCG op of the current insn_start.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f00c141ef9..f23555b1dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12983,6 +12983,25 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
             flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
         }
+
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            /*
+             * In order to save space in flags, we record only whether
+             * pauth is "inactive", meaning all insns are implemented as
+             * a nop, or "active" when some action must be performed.
+             * The decision of which action to take is left to a helper.
+             */
+            uint64_t sctlr;
+            if (current_el == 0) {
+                /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+                sctlr = env->cp15.sctlr_el[1];
+            } else {
+                sctlr = env->cp15.sctlr_el[current_el];
+            }
+            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
+            }
+        }
     } else {
         *pc = env->regs[15];
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b7b6ab6371..37a57af715 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13409,6 +13409,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
     dc->sve_excp_el = FIELD_EX32(tb_flags, TBFLAG_A64, SVEEXC_EL);
     dc->sve_len = (FIELD_EX32(tb_flags, TBFLAG_A64, ZCR_LEN) + 1) * 16;
+    dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.2
