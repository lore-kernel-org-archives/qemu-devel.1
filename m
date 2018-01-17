Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqNP-00079l-RV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqNO-0003yq-Rf
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:47 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqNO-0003yT-MA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:46 -0500
Received: by mail-pf0-x241.google.com with SMTP id y26so4226397pfi.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:15:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:14:33 -0800
Message-Id: <20180117161435.28981-19-richard.henderson@linaro.org>
In-Reply-To: <20180117161435.28981-1-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v10.5 18/20] target/arm: Use vector
 infrastructure for aa64 orr/bic immediate
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e8fc4bc27e..3b113f6b7c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6135,7 +6135,6 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     bool is_neg = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
     uint64_t imm = 0;
-    int i;
 
     if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
         unallocated_encoding(s);
@@ -6221,28 +6220,25 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
         tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
                             vec_full_reg_size(s), imm);
     } else {
+        /* ORR or BIC, with BIC negation to AND handled above.  */
+        static const GVecGen2s ops[2] = {
+            { .fni8 = tcg_gen_or_i64,
+              .fniv = tcg_gen_or_vec,
+              .opc = INDEX_op_or_vec,
+              .vece = MO_64,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64 },
+            { .fni8 = tcg_gen_and_i64,
+              .fniv = tcg_gen_and_vec,
+              .opc = INDEX_op_and_vec,
+              .vece = MO_64,
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64 }
+        };
         TCGv_i64 tcg_imm = tcg_const_i64(imm);
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
-        }
 
+        tcg_gen_gvec_2s(vec_full_reg_offset(s, rd),
+                        vec_full_reg_offset(s, rd),
+                        is_q ? 16 : 8, vec_full_reg_size(s),
+                        tcg_imm, &ops[is_neg]);
         tcg_temp_free_i64(tcg_imm);
     }
 }
-- 
2.14.3
