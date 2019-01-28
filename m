Received: from eggs.gnu.org ([209.51.188.92]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcC-0006rk-Ue
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRE-0006Cn-Ua
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:34 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRE-0006Ai-Js
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:32 -0500
Received: by mail-oi1-x244.google.com with SMTP id v6so14530861oif.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:09 -0800
Message-Id: <20190128223118.5255-4-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/12] target/arm: Add BT and BTYPE to
 tb->flags
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  2 ++
 target/arm/translate.h     |  4 ++++
 target/arm/helper.c        | 22 +++++++++++++++-------
 target/arm/translate-a64.c |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 76e2f8fd42..e18f823419 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3043,6 +3043,8 @@ FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
+FIELD(TBFLAG_A64, BT, 9, 1)
+FIELD(TBFLAG_A64, BTYPE, 10, 2)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index bb37d35741..3d5e8bacac 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -69,6 +69,10 @@ typedef struct DisasContext {
     bool ss_same_el;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
+    bool bt;
+    /* A copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.  */
+    uint8_t btype;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* TCG op of the current insn_start.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92666e5208..6efe88a157 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13607,6 +13607,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
     if (is_a64(env)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
+        uint64_t sctlr;
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
@@ -13651,6 +13652,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
         }
 
+        if (current_el == 0) {
+            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+            sctlr = env->cp15.sctlr_el[1];
+        } else {
+            sctlr = env->cp15.sctlr_el[current_el];
+        }
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             /*
              * In order to save space in flags, we record only whether
@@ -13658,17 +13665,18 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
              * a nop, or "active" when some action must be performed.
              * The decision of which action to take is left to a helper.
              */
-            uint64_t sctlr;
-            if (current_el == 0) {
-                /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-                sctlr = env->cp15.sctlr_el[1];
-            } else {
-                sctlr = env->cp15.sctlr_el[current_el];
-            }
             if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
                 flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
             }
         }
+
+        if (cpu_isar_feature(aa64_bti, cpu)) {
+            /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
+            if (sctlr & (current_el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
+            }
+            flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
+        }
     } else {
         *pc = env->regs[15];
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 611279e98e..9ce523e2ff 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13801,6 +13801,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->sve_excp_el = FIELD_EX32(tb_flags, TBFLAG_A64, SVEEXC_EL);
     dc->sve_len = (FIELD_EX32(tb_flags, TBFLAG_A64, ZCR_LEN) + 1) * 16;
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
+    dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
+    dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.2
