Received: from eggs.gnu.org ([209.51.188.92]:35827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AQ-0001ri-PQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AJ-0000Us-Pz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AC-0000Jf-Se
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id s12so4472323wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:51 +0000
Message-Id: <20190205170510.21984-4-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/22] target/arm: Add BT and BTYPE to tb->flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190128223118.5255-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  2 ++
 target/arm/translate.h     |  4 ++++
 target/arm/helper.c        | 22 +++++++++++++++-------
 target/arm/translate-a64.c |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 58f99985c24..1ff7197efd5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3052,6 +3052,8 @@ FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
+FIELD(TBFLAG_A64, BT, 9, 1)
+FIELD(TBFLAG_A64, BTYPE, 10, 2)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index bb37d35741c..3d5e8bacacb 100644
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
index d070879894c..45ba678a7df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13735,6 +13735,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
     if (is_a64(env)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
+        uint64_t sctlr;
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
@@ -13779,6 +13780,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
@@ -13786,17 +13793,18 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
index 0b94d9455b7..a92fd433783 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13840,6 +13840,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->sve_excp_el = FIELD_EX32(tb_flags, TBFLAG_A64, SVEEXC_EL);
     dc->sve_len = (FIELD_EX32(tb_flags, TBFLAG_A64, ZCR_LEN) + 1) * 16;
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
+    dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
+    dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.20.1
