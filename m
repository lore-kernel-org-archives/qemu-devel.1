Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ei-0004jH-BI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eb-0006eT-Jq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eX-0006U9-6t
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id p21so187329wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:09 +0100
Message-Id: <20190429170030.11323-22-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/42] target/arm: Set FPCCR.S when executing
 M-profile floating point insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M-profile FPCCR.S bit indicates the security status of
the floating point context. In the pseudocode ExecuteFPCheck()
function it is unconditionally set to match the current
security state whenever a floating point instruction is
executed.

Implement this by adding a new TB flag which tracks whether
FPCCR.S is different from the current security state, so
that we only need to emit the code to update it in the
less-common case when it is not already set correctly.

Note that we will add the handling for the other work done
by ExecuteFPCheck() in later commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-19-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  2 ++
 target/arm/translate.h |  1 +
 target/arm/helper.c    |  5 +++++
 target/arm/translate.c | 20 ++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 99ccb4824d4..a2cf9aae3a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3153,6 +3153,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+/* For M profile only, set if FPCCR.S does not match current security state */
+FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 984617786d6..93abff645ad 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -40,6 +40,7 @@ typedef struct DisasContext {
     bool v7m_handler_mode;
     bool v8m_secure; /* true if v8M and we're in Secure mode */
     bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
+    bool v8m_fpccr_s_wrong; /* true if v8M FPCCR.S != v8m_secure */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9be5fe581df..8290f56c658 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13417,6 +13417,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ffaa4f1e095..f0332ac19ec 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3421,6 +3421,25 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         }
     }
 
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /* Handle M-profile lazy FP state mechanics */
+
+        /* Update ownership of FP context: set FPCCR.S to match current state */
+        if (s->v8m_fpccr_s_wrong) {
+            TCGv_i32 tmp;
+
+            tmp = load_cpu_field(v7m.fpccr[M_REG_S]);
+            if (s->v8m_secure) {
+                tcg_gen_ori_i32(tmp, tmp, R_V7M_FPCCR_S_MASK);
+            } else {
+                tcg_gen_andi_i32(tmp, tmp, ~R_V7M_FPCCR_S_MASK);
+            }
+            store_cpu_field(tmp, v7m.fpccr[M_REG_S]);
+            /* Don't need to do this for any further FP insns in this TB */
+            s->v8m_fpccr_s_wrong = false;
+        }
+    }
+
     if (extract32(insn, 28, 4) == 0xf) {
         /*
          * Encodings with T=1 (Thumb) or unconditional (ARM):
@@ -13341,6 +13360,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         regime_is_secure(env, dc->mmu_idx);
     dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
+    dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.20.1
