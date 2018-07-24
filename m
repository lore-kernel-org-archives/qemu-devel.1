Received: from eggs.gnu.org ([2001:4830:134:3::10]:46307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Ug-0003ly-QJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Ub-0002Aw-5I
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:53:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52910 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Ua-00029v-PW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:53:01 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:37 +0200
Message-Id: <1532453527-22911-26-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 25/55] target/mips: Implement emulation of
 nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Implement nanoMIPS LLWP and SCWP instruction pair.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c |  25 ++++++++---
 target/mips/cpu.h          |   2 +
 target/mips/helper.h       |   2 +
 target/mips/op_helper.c    |  35 +++++++++++++++
 target/mips/translate.c    | 109 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 5 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 084ad6a..1d3dc9e 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -397,10 +397,13 @@ static int do_store_exclusive(CPUMIPSState *env)
     target_ulong addr;
     target_ulong page_addr;
     target_ulong val;
+    uint32_t val_wp = 0;
+    uint32_t llnewval_wp = 0;
     int flags;
     int segv = 0;
     int reg;
     int d;
+    int wp;
 
     addr = env->lladdr;
     page_addr = addr & TARGET_PAGE_MASK;
@@ -412,19 +415,31 @@ static int do_store_exclusive(CPUMIPSState *env)
     } else {
         reg = env->llreg & 0x1f;
         d = (env->llreg & 0x20) != 0;
-        if (d) {
-            segv = get_user_s64(val, addr);
+        wp = (env->llreg & 0x40) != 0;
+        if (!wp) {
+            if (d) {
+                segv = get_user_s64(val, addr);
+            } else {
+                segv = get_user_s32(val, addr);
+            }
         } else {
             segv = get_user_s32(val, addr);
+            segv |= get_user_s32(val_wp, addr);
+            llnewval_wp = env->llnewval_wp;
         }
         if (!segv) {
-            if (val != env->llval) {
+            if (val != env->llval && val_wp == llnewval_wp) {
                 env->active_tc.gpr[reg] = 0;
             } else {
-                if (d) {
-                    segv = put_user_u64(env->llnewval, addr);
+                if (!wp) {
+                    if (d) {
+                        segv = put_user_u64(env->llnewval, addr);
+                    } else {
+                        segv = put_user_u32(env->llnewval, addr);
+                    }
                 } else {
                     segv = put_user_u32(env->llnewval, addr);
+                    segv |= put_user_u32(env->llnewval_wp, addr + 4);
                 }
                 if (!segv) {
                     env->active_tc.gpr[reg] = 1;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 009202c..2d341d7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -506,6 +506,8 @@ struct CPUMIPSState {
     uint64_t lladdr;
     target_ulong llval;
     target_ulong llnewval;
+    uint32_t llval_wp;
+    uint32_t llnewval_wp;
     target_ulong llreg;
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
diff --git a/target/mips/helper.h b/target/mips/helper.h
index b2a780a..deca307 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -14,6 +14,8 @@ DEF_HELPER_4(swr, void, env, tl, tl, int)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(ll, tl, env, tl, int)
 DEF_HELPER_4(sc, tl, env, tl, tl, int)
+DEF_HELPER_5(llwp, void, env, tl, i32, i32, i32)
+DEF_HELPER_4(scwp, tl, env, tl, i64, int)
 #ifdef TARGET_MIPS64
 DEF_HELPER_3(lld, tl, env, tl, int)
 DEF_HELPER_4(scd, tl, env, tl, tl, int)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b3eef9f..cb83b6d 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -380,6 +380,19 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
 #endif
 #undef HELPER_LD_ATOMIC
 
+void helper_llwp(CPUMIPSState *env, target_ulong addr, uint32_t reg1,
+                 uint32_t reg2, uint32_t mem_idx)
+{
+    if (addr & 0x7) {
+        env->CP0_BadVAddr = addr;
+        do_raise_exception(env, EXCP_AdEL, GETPC());
+    }
+    env->lladdr = do_translate_address(env, addr, 0, GETPC());
+    env->active_tc.gpr[reg1] = env->llval = do_lw(env, addr, mem_idx, GETPC());
+    env->active_tc.gpr[reg2] = env->llval_wp = do_lw(env, addr + 4, mem_idx,
+                                                     GETPC());
+}
+
 #define HELPER_ST_ATOMIC(name, ld_insn, st_insn, almask)                      \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
                            target_ulong arg2, int mem_idx)                    \
@@ -406,6 +419,28 @@ HELPER_ST_ATOMIC(sc, lw, sw, 0x3)
 HELPER_ST_ATOMIC(scd, ld, sd, 0x7)
 #endif
 #undef HELPER_ST_ATOMIC
+
+target_ulong helper_scwp(CPUMIPSState *env, target_ulong addr,
+                         uint64_t data, int mem_idx)
+{
+    uint32_t tmp;
+    uint32_t tmp2;
+
+    if (addr & 0x7) {
+        env->CP0_BadVAddr = addr;
+        do_raise_exception(env, EXCP_AdES, GETPC());
+    }
+    if (do_translate_address(env, addr, 1, GETPC()) == env->lladdr) {
+        tmp = do_lw(env, addr, mem_idx, GETPC());
+        tmp2 = do_lw(env, addr + 4, mem_idx, GETPC());
+        if (tmp == env->llval && tmp2 == env->llval_wp) {
+            do_sw(env, addr, (uint32_t) data, mem_idx, GETPC());
+            do_sw(env, addr + 4, (uint32_t) *(&data + 4), mem_idx, GETPC());
+            return 1;
+        }
+    }
+    return 0;
+}
 #endif
 
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1c86145..cf28c60 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1459,6 +1459,7 @@ typedef struct DisasContext {
     bool nan2008;
     bool abs2008;
     bool has_isa_mode;
+    bool xnp;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -2336,6 +2337,44 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
+static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
+                    uint32_t reg1, uint32_t reg2)
+{
+#ifdef CONFIG_USER_ONLY
+    TCGv taddr = tcg_temp_new();
+    TCGv tval = tcg_temp_new();
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+    tcg_gen_qemu_ld32s(tval, taddr, ctx->mem_idx);
+    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, lladdr));
+    tcg_gen_st_tl(tval, cpu_env, offsetof(CPUMIPSState, llval));
+    tcg_gen_ext32s_tl(tval, tval);
+    gen_store_gpr(tval, reg1);
+
+    gen_base_offset_addr(ctx, taddr, base, offset + 4);
+    tcg_gen_qemu_ld32s(tval, taddr, ctx->mem_idx);
+    tcg_gen_st_tl(tval, cpu_env, offsetof(CPUMIPSState, llval_wp));
+    tcg_gen_ext32s_tl(tval, tval);
+    gen_store_gpr(tval, reg2);
+
+    tcg_temp_free(taddr);
+    tcg_temp_free(tval);
+#else
+    TCGv taddr = tcg_temp_new();
+    TCGv_i32 helper_mem_idx = tcg_const_i32(ctx->mem_idx);
+    TCGv_i32 helper_reg1 = tcg_const_i32(reg1);
+    TCGv_i32 helper_reg2 = tcg_const_i32(reg2);
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+    gen_helper_llwp(cpu_env, taddr, helper_reg1, helper_reg2, helper_mem_idx);
+
+    tcg_temp_free(taddr);
+    tcg_temp_free_i32(helper_mem_idx);
+    tcg_temp_free_i32(helper_reg1);
+    tcg_temp_free_i32(helper_reg2);
+#endif
+}
+
 /* Store */
 static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
                     int base, int offset)
@@ -2432,6 +2471,63 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
     tcg_temp_free(t0);
 }
 
+static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
+                    uint32_t reg1, uint32_t reg2)
+{
+#ifdef CONFIG_USER_ONLY
+    TCGv taddr = tcg_temp_local_new();
+    TCGv t0 = tcg_temp_new();
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *l2 = gen_new_label();
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+    tcg_gen_andi_tl(t0, taddr, 0x7);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);
+    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
+    generate_exception(ctx, EXCP_AdES);
+    gen_set_label(l1);
+    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUMIPSState, lladdr));
+    tcg_gen_brcond_tl(TCG_COND_NE, taddr, t0, l2);
+    tcg_gen_movi_tl(t0, reg1 | 0x60);
+    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, llreg));
+    gen_load_gpr(t0, reg1);
+    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, llnewval));
+    gen_load_gpr(t0, reg2);
+    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, llnewval_wp));
+    generate_exception_end(ctx, EXCP_SC);
+    gen_set_label(l2);
+    tcg_gen_movi_tl(t0, 0);
+    gen_store_gpr(t0, reg1);
+    tcg_temp_free(t0);
+    tcg_temp_free(taddr);
+#else
+    TCGv taddr = tcg_temp_new();
+    TCGv_i64 tdata = tcg_temp_new_i64();
+    TCGv_i32 helper_mem_idx = tcg_const_i32(ctx->mem_idx);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv_i64 t1_64 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, reg2);
+    tcg_gen_ext_tl_i64(tdata, t0);
+    tcg_gen_shli_i64(tdata, tdata, 32);
+
+    gen_load_gpr(t0, reg1);
+    tcg_gen_ext_tl_i64(t1_64, t0);
+    tcg_gen_or_i64(tdata, tdata, t1_64);
+
+    gen_base_offset_addr(ctx, taddr, base, offset);
+    gen_helper_scwp(cpu_gpr[reg1], cpu_env, taddr, tdata, helper_mem_idx);
+
+    tcg_temp_free(taddr);
+    tcg_temp_free_i64(tdata);
+    tcg_temp_free_i32(helper_mem_idx);
+
+    tcg_temp_free(t0);
+    tcg_temp_free_i64(t1_64);
+#endif
+}
+
 /* Load and store */
 static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
                           TCGv t0)
@@ -19400,6 +19496,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         gen_ld(ctx, OPC_LL, rt, rs, s);
                         break;
                     case NM_LLWP:
+                        if (ctx->xnp) {
+                            generate_exception_end(ctx, EXCP_RI);
+                        } else {
+                            gen_llwp(ctx, rs, 0, rt,
+                                     extract32(ctx->opcode, 3, 5));
+                        }
                         break;
                     }
                     break;
@@ -19409,6 +19511,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         gen_st_cond(ctx, OPC_SC, rt, rs, s);
                         break;
                     case NM_SCWP:
+                        if (ctx->xnp) {
+                            generate_exception_end(ctx, EXCP_RI);
+                        } else {
+                            gen_scwp(ctx, rs, 0, rt,
+                                     extract32(ctx->opcode, 3, 5));
+                        }
                         break;
                     }
                     break;
@@ -24754,6 +24862,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) != 3;
+    ctx->xnp = (env->CP0_Config5 >> CP0C5_XNP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
-- 
2.7.4
