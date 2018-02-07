Received: from eggs.gnu.org ([2001:4830:134:3::10]:37589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdP-0007VK-G6
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdO-00058Z-O7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:11 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdO-00058F-HY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:10 -0500
Received: by mail-pl0-x243.google.com with SMTP id 13-v6so984724plb.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:38 -0800
Message-Id: <20180207225540.31698-19-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/20] target/arm: Use vector infrastructure for
 aa64 orr/bic immediate
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 91f0ab7f12..0830c3f1c8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6180,7 +6180,6 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     bool is_neg = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
     uint64_t imm = 0;
-    int i;
 
     if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
         unallocated_encoding(s);
@@ -6266,29 +6265,12 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
         tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
                             vec_full_reg_size(s), imm);
     } else {
-        TCGv_i64 tcg_imm = tcg_const_i64(imm);
-        TCGv_i64 tcg_rd = new_tmp_a64(s);
-
-        for (i = 0; i < 2; i++) {
-            int foffs = vec_reg_offset(s, rd, i, MO_64);
-
-            if (i == 1 && !is_q) {
-                /* non-quad ops clear high half of vector */
-                tcg_gen_movi_i64(tcg_rd, 0);
-            } else {
-                tcg_gen_ld_i64(tcg_rd, cpu_env, foffs);
-                if (is_neg) {
-                    /* AND (BIC) */
-                    tcg_gen_and_i64(tcg_rd, tcg_rd, tcg_imm);
-                } else {
-                    /* ORR */
-                    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_imm);
-                }
-            }
-            tcg_gen_st_i64(tcg_rd, cpu_env, foffs);
+        /* ORR or BIC, with BIC negation to AND handled above.  */
+        if (is_neg) {
+            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_andi, MO_64);
+        } else {
+            gen_gvec_fn2i(s, is_q, rd, rd, imm, tcg_gen_gvec_ori, MO_64);
         }
-
-        tcg_temp_free_i64(tcg_imm);
     }
 }
 
-- 
2.14.3
