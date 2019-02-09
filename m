Received: from eggs.gnu.org ([209.51.188.92]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTn-0006iZ-6t
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTm-0000TO-CC
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:59 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTm-0000Sw-5z
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:38:58 -0500
Received: by mail-pf1-x444.google.com with SMTP id u6so2564386pfh.11
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:38:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:38 -0800
Message-Id: <20190209033847.9014-4-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/12] target/arm: Use vector minmax
 expanders for aarch32
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
 target/arm/translate.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9d2dba7ed2..df1cd3fa3e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6368,6 +6368,25 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
                              rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
             return 0;
+
+        case NEON_3R_VMAX:
+            if (u) {
+                tcg_gen_gvec_umax(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_smax(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
+        case NEON_3R_VMIN:
+            if (u) {
+                tcg_gen_gvec_umin(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_smin(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
         }
 
         if (size == 3) {
@@ -6533,12 +6552,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VMAX:
-            GEN_NEON_INTEGER_OP(max);
-            break;
-        case NEON_3R_VMIN:
-            GEN_NEON_INTEGER_OP(min);
-            break;
         case NEON_3R_VABD:
             GEN_NEON_INTEGER_OP(abd);
             break;
-- 
2.17.2
