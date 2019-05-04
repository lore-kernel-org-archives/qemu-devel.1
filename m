Received: from eggs.gnu.org ([209.51.188.92]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncB-0008AS-Up
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncA-0004fT-NT
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:39 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:35225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMncA-0004eD-HR
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:38 -0400
Received: by mail-pg1-x535.google.com with SMTP id h1so3773918pgs.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:58 -0700
Message-Id: <20190504055300.18426-30-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 29/31] target/tricore: Use tcg_gen_abs_tl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20190423102145.14812-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8f6416144e..06c4485e55 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2415,11 +2415,7 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 
 static inline void gen_abs(TCGv ret, TCGv r1)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv t0 = tcg_const_i32(0);
-
-    tcg_gen_neg_tl(temp, r1);
-    tcg_gen_movcond_tl(TCG_COND_GE, ret, r1, t0, r1, temp);
+    tcg_gen_abs_tl(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, r1, 0x80000000);
     tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
@@ -2430,9 +2426,6 @@ static inline void gen_abs(TCGv ret, TCGv r1)
     tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV bit */
     tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
-
-    tcg_temp_free(temp);
-    tcg_temp_free(t0);
 }
 
 static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
@@ -6617,13 +6610,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
@@ -6655,13 +6643,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
-- 
2.17.1
