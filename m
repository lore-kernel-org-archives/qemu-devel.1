Received: from eggs.gnu.org ([209.51.188.92]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDQ-0006vl-R9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDL-0003Z7-8p
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:44 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1uDL-0003YS-3M
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:39 -0500
Received: by mail-pg1-x543.google.com with SMTP id q206so11422091pgq.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:41:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 06:41:25 -0800
Message-Id: <20190307144126.31847-9-richard.henderson@linaro.org>
In-Reply-To: <20190307144126.31847-1-richard.henderson@linaro.org>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] target/arm: Use extract2 for EXTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is, after all, how we implement extract2 in tcg/aarc64.

Cc: qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1959046343..54fe94c436 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4114,25 +4114,27 @@ static void disas_extract(DisasContext *s, uint32_t insn)
             } else {
                 tcg_gen_ext32u_i64(tcg_rd, cpu_reg(s, rm));
             }
-        } else if (rm == rn) { /* ROR */
-            tcg_rm = cpu_reg(s, rm);
-            if (sf) {
-                tcg_gen_rotri_i64(tcg_rd, tcg_rm, imm);
-            } else {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tcg_rm);
-                tcg_gen_rotri_i32(tmp, tmp, imm);
-                tcg_gen_extu_i32_i64(tcg_rd, tmp);
-                tcg_temp_free_i32(tmp);
-            }
         } else {
-            tcg_rm = read_cpu_reg(s, rm, sf);
-            tcg_rn = read_cpu_reg(s, rn, sf);
-            tcg_gen_shri_i64(tcg_rm, tcg_rm, imm);
-            tcg_gen_shli_i64(tcg_rn, tcg_rn, bitsize - imm);
-            tcg_gen_or_i64(tcg_rd, tcg_rm, tcg_rn);
-            if (!sf) {
-                tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+            tcg_rm = cpu_reg(s, rm);
+            tcg_rn = cpu_reg(s, rn);
+
+            if (sf) {
+                /* Specialization to ROR happens in EXTRACT2.  */
+                tcg_gen_extract2_i64(tcg_rd, tcg_rm, tcg_rn, imm);
+            } else {
+                TCGv_i32 t0 = tcg_temp_new_i32();
+
+                tcg_gen_extrl_i64_i32(t0, tcg_rm);
+                if (rm == rn) {
+                    tcg_gen_rotri_i32(t0, t0, imm);
+                } else {
+                    TCGv_i32 t1 = tcg_temp_new_i32();
+                    tcg_gen_extrl_i64_i32(t1, tcg_rn);
+                    tcg_gen_extract2_i32(t0, t0, t1, imm);
+                    tcg_temp_free_i32(t1);
+                }
+                tcg_gen_extu_i32_i64(tcg_rd, t0);
+                tcg_temp_free_i32(t0);
             }
         }
     }
-- 
2.17.2
