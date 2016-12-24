Received: from eggs.gnu.org ([2001:4830:134:3::10]:55515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWD-0006pW-Ah
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWC-0005ns-DQ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:13 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:09 -0800
Message-Id: <20161224040042.12654-33-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 32/65] target-ppc: Use clz and ctz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/helper.h     |  4 ----
 target/ppc/int_helper.c | 20 --------------------
 target/ppc/translate.c  | 20 ++++++++++++++++----
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index da00f0a..1ed1d2c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -38,16 +38,12 @@ DEF_HELPER_4(divde, i64, env, i64, i64, i32)
 DEF_HELPER_4(divweu, tl, env, tl, tl, i32)
 DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
 
-DEF_HELPER_FLAGS_1(cntlzw, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(cnttzw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_3(sraw, tl, env, tl, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
-DEF_HELPER_FLAGS_1(cntlzd, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(cnttzd, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(popcntd, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 2d57c9a..e1bb695 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -141,16 +141,6 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 #endif
 
 
-target_ulong helper_cntlzw(target_ulong t)
-{
-    return clz32(t);
-}
-
-target_ulong helper_cnttzw(target_ulong t)
-{
-    return ctz32(t);
-}
-
 #if defined(TARGET_PPC64)
 /* if x = 0xab, returns 0xababababababababa */
 #define pattern(x) (((x) & 0xff) * (~(target_ulong)0 / 0xff))
@@ -174,16 +164,6 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 #undef haszero
 #undef hasvalue
 
-target_ulong helper_cntlzd(target_ulong t)
-{
-    return clz64(t);
-}
-
-target_ulong helper_cnttzd(target_ulong t)
-{
-    return ctz64(t);
-}
-
 /* Return invalid random number.
  *
  * FIXME: Add rng backend or other mechanism to get cryptographically suitable
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 435c6f0..1224f56 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1641,7 +1641,13 @@ static void gen_andis_(DisasContext *ctx)
 /* cntlzw */
 static void gen_cntlzw(DisasContext *ctx)
 {
-    gen_helper_cntlzw(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(t, cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_clzi_i32(t, t, 32);
+    tcg_gen_extu_i32_tl(cpu_gpr[rA(ctx->opcode)], t);
+    tcg_temp_free_i32(t);
+
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
@@ -1649,7 +1655,13 @@ static void gen_cntlzw(DisasContext *ctx)
 /* cnttzw */
 static void gen_cnttzw(DisasContext *ctx)
 {
-    gen_helper_cnttzw(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_trunc_tl_i32(t, cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_ctzi_i32(t, t, 32);
+    tcg_gen_extu_i32_tl(cpu_gpr[rA(ctx->opcode)], t);
+    tcg_temp_free_i32(t);
+
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
     }
@@ -1891,7 +1903,7 @@ GEN_LOGICAL1(extsw, tcg_gen_ext32s_tl, 0x1E, PPC_64B);
 /* cntlzd */
 static void gen_cntlzd(DisasContext *ctx)
 {
-    gen_helper_cntlzd(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_clzi_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], 64);
     if (unlikely(Rc(ctx->opcode) != 0))
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
 }
@@ -1899,7 +1911,7 @@ static void gen_cntlzd(DisasContext *ctx)
 /* cnttzd */
 static void gen_cnttzd(DisasContext *ctx)
 {
-    gen_helper_cnttzd(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_ctzi_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)], 64);
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
     }
-- 
2.9.3
