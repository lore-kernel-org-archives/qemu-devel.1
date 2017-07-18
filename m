Received: from eggs.gnu.org ([2001:4830:134:3::10]:47091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7Q-0003vx-Ai
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7M-0005H9-6G
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:48 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:62278)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7L-0005Gv-RL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:44 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:50 +0100
Message-ID: <bffd66518c6b95e089a4d11d72db76a7af21c040.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/14] target/mips: Prepare loads/stores for EVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

EVA load and store instructions access the user mode address map, so
they need to use mem_idx of MIPS_HFLAG_UM. Update the various utility
functions to allow mem_idx to be more easily overridden from the
decoding logic.

Specifically we add a mem_idx argument to the op_ld/st_* helpers used
for atomics, and a mem_idx local variable to gen_ld(), gen_st(), and
gen_st_cond().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/translate.c | 77 ++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c9afcfe3f537..428f71795a5c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2029,7 +2029,8 @@ FOP_CONDNS(s, FMT_S, 32, gen_store_fpr32(ctx, fp0, fd))
 /* load/store instructions. */
 #ifdef CONFIG_USER_ONLY
 #define OP_LD_ATOMIC(insn,fname)                                           \
-static inline void op_ld_##insn(TCGv ret, TCGv arg1, DisasContext *ctx)    \
+static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
+                                DisasContext *ctx)                         \
 {                                                                          \
     TCGv t0 = tcg_temp_new();                                              \
     tcg_gen_mov_tl(t0, arg1);                                              \
@@ -2040,9 +2041,10 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, DisasContext *ctx)    \
 }
 #else
 #define OP_LD_ATOMIC(insn,fname)                                           \
-static inline void op_ld_##insn(TCGv ret, TCGv arg1, DisasContext *ctx)    \
+static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
+                                DisasContext *ctx)                         \
 {                                                                          \
-    gen_helper_1e1i(insn, ret, arg1, ctx->mem_idx);                        \
+    gen_helper_1e1i(insn, ret, arg1, mem_idx);                             \
 }
 #endif
 OP_LD_ATOMIC(ll,ld32s);
@@ -2053,7 +2055,8 @@ OP_LD_ATOMIC(lld,ld64);
 
 #ifdef CONFIG_USER_ONLY
 #define OP_ST_ATOMIC(insn,fname,ldname,almask)                               \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, DisasContext *ctx) \
+static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_idx,   \
+                                DisasContext *ctx)                           \
 {                                                                            \
     TCGv t0 = tcg_temp_new();                                                \
     TCGLabel *l1 = gen_new_label();                                          \
@@ -2077,10 +2080,11 @@ static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, DisasContext *ctx)
 }
 #else
 #define OP_ST_ATOMIC(insn,fname,ldname,almask)                               \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, DisasContext *ctx) \
+static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_idx,   \
+                                DisasContext *ctx)                           \
 {                                                                            \
     TCGv t0 = tcg_temp_new();                                                \
-    gen_helper_1e2i(insn, t0, arg1, arg2, ctx->mem_idx);                     \
+    gen_helper_1e2i(insn, t0, arg1, arg2, mem_idx);                          \
     gen_store_gpr(t0, rt);                                                   \
     tcg_temp_free(t0);                                                       \
 }
@@ -2123,6 +2127,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int16_t offset)
 {
     TCGv t0, t1, t2;
+    int mem_idx = ctx->mem_idx;
 
     if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F)) {
         /* Loongson CPU uses a load to zero register for prefetch.
@@ -2137,32 +2142,32 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_LWU:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LD:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LLD:
     case R6_OPC_LLD:
-        op_ld_lld(t0, t0, ctx);
+        op_ld_lld(t0, t0, mem_idx, ctx);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LDL:
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
            fault with the unaligned address.  */
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 7);
 #ifndef TARGET_WORDS_BIGENDIAN
         tcg_gen_xori_tl(t1, t1, 7);
 #endif
         tcg_gen_shli_tl(t1, t1, 3);
         tcg_gen_andi_tl(t0, t0, ~7);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEQ);
         tcg_gen_shl_tl(t0, t0, t1);
         t2 = tcg_const_tl(-1);
         tcg_gen_shl_tl(t2, t2, t1);
@@ -2177,14 +2182,14 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
            fault with the unaligned address.  */
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 7);
 #ifdef TARGET_WORDS_BIGENDIAN
         tcg_gen_xori_tl(t1, t1, 7);
 #endif
         tcg_gen_shli_tl(t1, t1, 3);
         tcg_gen_andi_tl(t0, t0, ~7);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEQ);
         tcg_gen_shr_tl(t0, t0, t1);
         tcg_gen_xori_tl(t1, t1, 63);
         t2 = tcg_const_tl(0xfffffffffffffffeull);
@@ -2200,7 +2205,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_const_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_temp_free(t1);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEQ);
         gen_store_gpr(t0, rt);
         break;
 #endif
@@ -2208,44 +2213,44 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_const_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_temp_free(t1);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LW:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LH:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LHU:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LB:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_SB);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LBU:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_UB);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LWL:
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
            fault with the unaligned address.  */
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 3);
 #ifndef TARGET_WORDS_BIGENDIAN
         tcg_gen_xori_tl(t1, t1, 3);
 #endif
         tcg_gen_shli_tl(t1, t1, 3);
         tcg_gen_andi_tl(t0, t0, ~3);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUL);
         tcg_gen_shl_tl(t0, t0, t1);
         t2 = tcg_const_tl(-1);
         tcg_gen_shl_tl(t2, t2, t1);
@@ -2261,14 +2266,14 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_temp_new();
         /* Do a byte access to possibly trigger a page
            fault with the unaligned address.  */
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 3);
 #ifdef TARGET_WORDS_BIGENDIAN
         tcg_gen_xori_tl(t1, t1, 3);
 #endif
         tcg_gen_shli_tl(t1, t1, 3);
         tcg_gen_andi_tl(t0, t0, ~3);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUL);
         tcg_gen_shr_tl(t0, t0, t1);
         tcg_gen_xori_tl(t1, t1, 31);
         t2 = tcg_const_tl(0xfffffffeull);
@@ -2283,7 +2288,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         break;
     case OPC_LL:
     case R6_OPC_LL:
-        op_ld_ll(t0, t0, ctx);
+        op_ld_ll(t0, t0, mem_idx, ctx);
         gen_store_gpr(t0, rt);
         break;
     }
@@ -2296,38 +2301,39 @@ static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
+    int mem_idx = ctx->mem_idx;
 
     gen_base_offset_addr(ctx, t0, base, offset);
     gen_load_gpr(t1, rt);
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_SD:
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SDL:
-        gen_helper_0e2i(sdl, t1, t0, ctx->mem_idx);
+        gen_helper_0e2i(sdl, t1, t0, mem_idx);
         break;
     case OPC_SDR:
-        gen_helper_0e2i(sdr, t1, t0, ctx->mem_idx);
+        gen_helper_0e2i(sdr, t1, t0, mem_idx);
         break;
 #endif
     case OPC_SW:
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUL |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SH:
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SB:
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_8);
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_8);
         break;
     case OPC_SWL:
-        gen_helper_0e2i(swl, t1, t0, ctx->mem_idx);
+        gen_helper_0e2i(swl, t1, t0, mem_idx);
         break;
     case OPC_SWR:
-        gen_helper_0e2i(swr, t1, t0, ctx->mem_idx);
+        gen_helper_0e2i(swr, t1, t0, mem_idx);
         break;
     }
     tcg_temp_free(t0);
@@ -2340,6 +2346,7 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
                          int base, int16_t offset)
 {
     TCGv t0, t1;
+    int mem_idx = ctx->mem_idx;
 
 #ifdef CONFIG_USER_ONLY
     t0 = tcg_temp_local_new();
@@ -2354,12 +2361,12 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
 #if defined(TARGET_MIPS64)
     case OPC_SCD:
     case R6_OPC_SCD:
-        op_st_scd(t1, t0, rt, ctx);
+        op_st_scd(t1, t0, rt, mem_idx, ctx);
         break;
 #endif
     case OPC_SC:
     case R6_OPC_SC:
-        op_st_sc(t1, t0, rt, ctx);
+        op_st_sc(t1, t0, rt, mem_idx, ctx);
         break;
     }
     tcg_temp_free(t1);
-- 
git-series 0.8.10
