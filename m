Received: from eggs.gnu.org ([209.51.188.92]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AU-0001uf-HE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000Zn-0H
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000Kr-Lr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id b11so4469656wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:55 +0000
Message-Id: <20190205170510.21984-8-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/22] target/arm: Reset btype for direct
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

From: Richard Henderson <richard.henderson@linaro.org>

This is all of the non-exception cases of DISAS_NORETURN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190128223118.5255-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7034fb3d129..5d0341a6953 100644
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
2.20.1
