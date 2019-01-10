Received: from eggs.gnu.org ([209.51.188.92]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHd-0004ZZ-Da
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHc-0007fD-Gb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:01 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHc-0007eT-9v
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:00 -0500
Received: by mail-pf1-x442.google.com with SMTP id 64so5217731pfr.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:18:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:31 +1100
Message-Id: <20190110121736.23448-7-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/11] target/arm: Reset btype for direct
 branches and syscalls
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

This is all of the non-exception cases of DISAS_NORETURN.

For the rest of the synchronous exceptions, the state of
SPSR_ELx.BTYPE is CONSTRAINED UNPREDICTABLE.  However, it
makes more sense to me to have syscalls reset BTYPE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 68eb27089a..f319fa000e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1362,6 +1362,7 @@ static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
     }
 
     /* B Branch / BL Branch with link */
+    reset_btype(s);
     gen_goto_tb(s, 0, addr);
 }
 
@@ -1386,6 +1387,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     tcg_cmp = read_cpu_reg(s, rt, sf);
     label_match = gen_new_label();
 
+    reset_btype(s);
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
 
@@ -1415,6 +1417,8 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
     tcg_cmp = tcg_temp_new_i64();
     tcg_gen_andi_i64(tcg_cmp, cpu_reg(s, rt), (1ULL << bit_pos));
     label_match = gen_new_label();
+
+    reset_btype(s);
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
     tcg_temp_free_i64(tcg_cmp);
@@ -1441,6 +1445,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
     addr = s->pc + sextract32(insn, 5, 19) * 4 - 4;
     cond = extract32(insn, 0, 4);
 
+    reset_btype(s);
     if (cond < 0x0e) {
         /* genuinely conditional branches */
         TCGLabel *label_match = gen_new_label();
@@ -1605,6 +1610,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
+        reset_btype(s);
         gen_goto_tb(s, 0, s->pc);
         return;
     default:
@@ -1885,6 +1891,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
         switch (op2_ll) {
         case 1:                                                     /* SVC */
             gen_ss_advance(s);
+            reset_btype(s);
             gen_exception_insn(s, 0, EXCP_SWI, syn_aa64_svc(imm16),
                                default_exception_el(s));
             break;
@@ -1899,6 +1906,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_a64_set_pc_im(s->pc - 4);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
+            reset_btype(s);
             gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
             break;
         case 3:                                                     /* SMC */
@@ -1911,6 +1919,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_ss_advance(s);
+            reset_btype(s);
             gen_exception_insn(s, 0, EXCP_SMC, syn_aa64_smc(imm16), 3);
             break;
         default:
-- 
2.17.2
