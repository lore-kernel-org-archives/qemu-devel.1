Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFbf-0007HS-Cx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFQW-0003Ka-9f
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFQW-0003KB-3a
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id a62so1094777wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:07:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:06:59 +0000
Message-Id: <20190206050701.11847-4-richard.henderson@linaro.org>
In-Reply-To: <20190206050701.11847-1-richard.henderson@linaro.org>
References: <20190206050701.11847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/5] target/arm: Use vector minmax expanders
 for aarch32
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
