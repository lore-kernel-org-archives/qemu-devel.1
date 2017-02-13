Received: from eggs.gnu.org ([2001:4830:134:3::10]:45435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8j-0004tp-Uw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8i-0001UQ-QS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:29 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8i-0001U0-Mj
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:28 -0500
Received: by mail-qk0-x241.google.com with SMTP id u25so16698500qki.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:26 +1100
Message-Id: <20170213212536.31871-15-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 14/24] target/openrisc: Use movcond where
 appropriate
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

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6c745d3..f91ab6a 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -214,12 +214,16 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     case 0x03:     /* l.bnf */
     case 0x04:     /* l.bf  */
         {
-            TCGLabel *lab = gen_new_label();
-            tcg_gen_movi_tl(jmp_pc, dc->pc+8);
-            tcg_gen_brcondi_tl(op0 == 0x03 ? TCG_COND_NE : TCG_COND_EQ,
-                               cpu_sr_f, 0, lab);
-            tcg_gen_movi_tl(jmp_pc, tmp_pc);
-            gen_set_label(lab);
+            TCGv t_next = tcg_const_tl(dc->pc + 8);
+            TCGv t_true = tcg_const_tl(tmp_pc);
+            TCGv t_zero = tcg_const_tl(0);
+
+            tcg_gen_movcond_tl(op0 == 0x03 ? TCG_COND_EQ : TCG_COND_NE,
+                               jmp_pc, cpu_sr_f, t_zero, t_true, t_next);
+
+            tcg_temp_free(t_next);
+            tcg_temp_free(t_true);
+            tcg_temp_free(t_zero);
         }
         break;
     case 0x11:     /* l.jr */
@@ -502,14 +506,10 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         case 0xe: /* l.cmov */
             LOG_DIS("l.cmov r%d, r%d, r%d\n", rd, ra, rb);
             {
-                TCGLabel *lab = gen_new_label();
-                TCGv res = tcg_temp_local_new();
-                tcg_gen_mov_tl(res, cpu_R[rb]);
-                tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_sr_f, 0, lab);
-                tcg_gen_mov_tl(res, cpu_R[ra]);
-                gen_set_label(lab);
-                tcg_gen_mov_tl(cpu_R[rd], res);
-                tcg_temp_free(res);
+                TCGv zero = tcg_const_tl(0);
+                tcg_gen_movcond_tl(TCG_COND_NE, cpu_R[rd], cpu_sr_f, zero,
+                                   cpu_R[ra], cpu_R[rb]);
+                tcg_temp_free(zero);
             }
             return;
 
-- 
2.9.3
