Received: from eggs.gnu.org ([209.51.188.92]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcC-0006iZ-4F
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRI-0006EL-HK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:40 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRG-0006DJ-QN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so16202603otl.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:13 -0800
Message-Id: <20190128223118.5255-8-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 07/12] target/arm: Reset btype for direct
 branches
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not reset byte for syscalls
---
 target/arm/translate-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bb64a47c0f..dbac09743c 100644
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
-- 
2.17.2
