Received: from eggs.gnu.org ([2001:4830:134:3::10]:41626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3i-0003b2-42
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3g-0002Bl-Rc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:02 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3g-0002Bc-Jf
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:00 -0400
Received: by mail-pg0-x241.google.com with SMTP id v190so5447909pgv.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:58:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:17 -1000
Message-Id: <20170719045722.25492-10-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/14] target/ppc: optimize various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Done with the Coccinelle semantic patch
scripts/coccinelle/tcg_gen_extract.cocci.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20170718045540.16322-6-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c              | 21 +++++++--------------
 target/ppc/translate/vsx-impl.inc.c | 24 ++++++++----------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..de271af 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -873,8 +873,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             }
             tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ carry */
             tcg_temp_free(t1);
-            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
-            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
             if (is_isa300(ctx)) {
                 tcg_gen_mov_tl(cpu_ca32, cpu_ca);
             }
@@ -1404,8 +1403,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_temp_free(inv1);
             tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes w/ carry */
             tcg_temp_free(t1);
-            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
-            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
             if (is_isa300(ctx)) {
                 tcg_gen_mov_tl(cpu_ca32, cpu_ca);
             }
@@ -4336,8 +4334,7 @@ static void gen_mfsrin(DisasContext *ctx)
 
     CHK_SV;
     t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, cpu_gpr[rB(ctx->opcode)], 28);
-    tcg_gen_andi_tl(t0, t0, 0xF);
+    tcg_gen_extract_tl(t0, cpu_gpr[rB(ctx->opcode)], 28, 4);
     gen_helper_load_sr(cpu_gpr[rD(ctx->opcode)], cpu_env, t0);
     tcg_temp_free(t0);
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -4368,8 +4365,7 @@ static void gen_mtsrin(DisasContext *ctx)
     CHK_SV;
 
     t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, cpu_gpr[rB(ctx->opcode)], 28);
-    tcg_gen_andi_tl(t0, t0, 0xF);
+    tcg_gen_extract_tl(t0, cpu_gpr[rB(ctx->opcode)], 28, 4);
     gen_helper_store_sr(cpu_env, t0, cpu_gpr[rD(ctx->opcode)]);
     tcg_temp_free(t0);
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -4403,8 +4399,7 @@ static void gen_mfsrin_64b(DisasContext *ctx)
 
     CHK_SV;
     t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, cpu_gpr[rB(ctx->opcode)], 28);
-    tcg_gen_andi_tl(t0, t0, 0xF);
+    tcg_gen_extract_tl(t0, cpu_gpr[rB(ctx->opcode)], 28, 4);
     gen_helper_load_sr(cpu_gpr[rD(ctx->opcode)], cpu_env, t0);
     tcg_temp_free(t0);
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -4435,8 +4430,7 @@ static void gen_mtsrin_64b(DisasContext *ctx)
 
     CHK_SV;
     t0 = tcg_temp_new();
-    tcg_gen_shri_tl(t0, cpu_gpr[rB(ctx->opcode)], 28);
-    tcg_gen_andi_tl(t0, t0, 0xF);
+    tcg_gen_extract_tl(t0, cpu_gpr[rB(ctx->opcode)], 28, 4);
     gen_helper_store_sr(cpu_env, t0, cpu_gpr[rS(ctx->opcode)]);
     tcg_temp_free(t0);
 #endif /* defined(CONFIG_USER_ONLY) */
@@ -5414,8 +5408,7 @@ static void gen_mfsri(DisasContext *ctx)
     CHK_SV;
     t0 = tcg_temp_new();
     gen_addr_reg_index(ctx, t0);
-    tcg_gen_shri_tl(t0, t0, 28);
-    tcg_gen_andi_tl(t0, t0, 0xF);
+    tcg_gen_extract_tl(t0, t0, 28, 4);
     gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
     tcg_temp_free(t0);
     if (ra != 0 && ra != rd)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7f12908..85ed135 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1248,8 +1248,7 @@ static void gen_xsxexpdp(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_shri_i64(rt, cpu_vsrh(xB(ctx->opcode)), 52);
-    tcg_gen_andi_i64(rt, rt, 0x7FF);
+    tcg_gen_extract_i64(rt, cpu_vsrh(xB(ctx->opcode)), 52, 11);
 }
 
 static void gen_xsxexpqp(DisasContext *ctx)
@@ -1262,8 +1261,7 @@ static void gen_xsxexpqp(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_shri_i64(xth, xbh, 48);
-    tcg_gen_andi_i64(xth, xth, 0x7FFF);
+    tcg_gen_extract_i64(xth, xbh, 48, 15);
     tcg_gen_movi_i64(xtl, 0);
 }
 
@@ -1323,8 +1321,7 @@ static void gen_xsxsigdp(DisasContext *ctx)
     zr = tcg_const_i64(0);
     nan = tcg_const_i64(2047);
 
-    tcg_gen_shri_i64(exp, cpu_vsrh(xB(ctx->opcode)), 52);
-    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_extract_i64(exp, cpu_vsrh(xB(ctx->opcode)), 52, 11);
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
@@ -1352,8 +1349,7 @@ static void gen_xsxsigqp(DisasContext *ctx)
     zr = tcg_const_i64(0);
     nan = tcg_const_i64(32767);
 
-    tcg_gen_shri_i64(exp, cpu_vsrh(rB(ctx->opcode) + 32), 48);
-    tcg_gen_andi_i64(exp, exp, 0x7FFF);
+    tcg_gen_extract_i64(exp, cpu_vsrh(rB(ctx->opcode) + 32), 48, 15);
     tcg_gen_movi_i64(t0, 0x0001000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
@@ -1448,10 +1444,8 @@ static void gen_xvxexpdp(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    tcg_gen_shri_i64(xth, xbh, 52);
-    tcg_gen_andi_i64(xth, xth, 0x7FF);
-    tcg_gen_shri_i64(xtl, xbl, 52);
-    tcg_gen_andi_i64(xtl, xtl, 0x7FF);
+    tcg_gen_extract_i64(xth, xbh, 52, 11);
+    tcg_gen_extract_i64(xtl, xbl, 52, 11);
 }
 
 GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
@@ -1474,16 +1468,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
     zr = tcg_const_i64(0);
     nan = tcg_const_i64(2047);
 
-    tcg_gen_shri_i64(exp, xbh, 52);
-    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_extract_i64(exp, xbh, 52, 11);
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
     tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
     tcg_gen_or_i64(xth, xth, t0);
 
-    tcg_gen_shri_i64(exp, xbl, 52);
-    tcg_gen_andi_i64(exp, exp, 0x7FF);
+    tcg_gen_extract_i64(exp, xbl, 52, 11);
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-- 
2.9.4
