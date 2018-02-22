Received: from eggs.gnu.org ([2001:4830:134:3::10]:49334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfZ-0004eh-7A
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfW-0005xW-Dg
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:37 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35089 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1eovfV-0005Pz-VX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:34 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 22 Feb 2018 19:31:39 +0100
Message-Id: <1519324303-5674-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/6] target/mips: reimplement SC instruction
 emulation and use cmpxchg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

From: Leon Alrae <lean.alrae@imgtec.com>

Completely rewrite conditional stores handling. Use cmpxchg.

This eliminates need for separate implementations of SC instruction
emulation for user and system emulation.

Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/main.c       |  58 ------------------------
 target/mips/cpu.h       |   4 --
 target/mips/helper.c    |   6 +--
 target/mips/helper.h    |   2 -
 target/mips/op_helper.c |  25 -----------
 target/mips/translate.c | 114 ++++++++++++++++--------------------------------
 6 files changed, 39 insertions(+), 170 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index fd79006..cef076f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -2160,55 +2160,6 @@ static const uint8_t mips_syscall_args[] = {
 #  undef MIPS_SYS
 # endif /* O32 */
 
-static int do_store_exclusive(CPUMIPSState *env)
-{
-    target_ulong addr;
-    target_ulong page_addr;
-    target_ulong val;
-    int flags;
-    int segv = 0;
-    int reg;
-    int d;
-
-    addr = env->lladdr;
-    page_addr = addr & TARGET_PAGE_MASK;
-    start_exclusive();
-    mmap_lock();
-    flags = page_get_flags(page_addr);
-    if ((flags & PAGE_READ) == 0) {
-        segv = 1;
-    } else {
-        reg = env->llreg & 0x1f;
-        d = (env->llreg & 0x20) != 0;
-        if (d) {
-            segv = get_user_s64(val, addr);
-        } else {
-            segv = get_user_s32(val, addr);
-        }
-        if (!segv) {
-            if (val != env->llval) {
-                env->active_tc.gpr[reg] = 0;
-            } else {
-                if (d) {
-                    segv = put_user_u64(env->llnewval, addr);
-                } else {
-                    segv = put_user_u32(env->llnewval, addr);
-                }
-                if (!segv) {
-                    env->active_tc.gpr[reg] = 1;
-                }
-            }
-        }
-    }
-    env->lladdr = -1;
-    if (!segv) {
-        env->active_tc.PC += 4;
-    }
-    mmap_unlock();
-    end_exclusive();
-    return segv;
-}
-
 /* Break codes */
 enum {
     BRK_OVERFLOW = 6,
@@ -2358,15 +2309,6 @@ done_syscall:
                   }
             }
             break;
-        case EXCP_SC:
-            if (do_store_exclusive(env)) {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->active_tc.PC;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
         case EXCP_DSPDIS:
             info.si_signo = TARGET_SIGILL;
             info.si_errno = 0;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 57ca861..3fa85b0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -486,8 +486,6 @@ struct CPUMIPSState {
     /* XXX: Maybe make LLAddr per-TC? */
     target_ulong lladdr; /* LL virtual address compared against SC */
     target_ulong llval;
-    target_ulong llnewval;
-    target_ulong llreg;
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
     target_ulong CP0_WatchLo[8];
@@ -727,8 +725,6 @@ enum {
 
     EXCP_LAST = EXCP_TLBRI,
 };
-/* Dummy exception for conditional stores.  */
-#define EXCP_SC 0x100
 
 /*
  * This is an internally generated WAKE request line.
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 8cf91ce..5002eb2 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1084,10 +1084,8 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
 {
     CPUState *cs = CPU(mips_env_get_cpu(env));
 
-    if (exception < EXCP_SC) {
-        qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
-                      __func__, exception, error_code);
-    }
+    qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
+                  __func__, exception, error_code);
     cs->exception_index = exception;
     env->error_code = error_code;
 
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5f49234..04c36e9 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -13,10 +13,8 @@ DEF_HELPER_4(swr, void, env, tl, tl, int)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(ll, tl, env, tl, int)
-DEF_HELPER_4(sc, tl, env, tl, tl, int)
 #ifdef TARGET_MIPS64
 DEF_HELPER_3(lld, tl, env, tl, int)
-DEF_HELPER_4(scd, tl, env, tl, tl, int)
 #endif
 #endif
 
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index cc5cd4e..44a9b06 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -284,31 +284,6 @@ HELPER_LD_ATOMIC(ll, lw, 0x3)
 HELPER_LD_ATOMIC(lld, ld, 0x7)
 #endif
 #undef HELPER_LD_ATOMIC
-
-#define HELPER_ST_ATOMIC(name, ld_insn, st_insn, almask)                      \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
-                           target_ulong arg2, int mem_idx)                    \
-{                                                                             \
-    target_long tmp;                                                          \
-                                                                              \
-    if (arg2 & almask) {                                                      \
-        env->CP0_BadVAddr = arg2;                                             \
-        do_raise_exception(env, EXCP_AdES, GETPC());                          \
-    }                                                                         \
-    if (arg2 == env->lladdr) {                                                \
-        tmp = do_##ld_insn(env, arg2, mem_idx, GETPC());                      \
-        if (tmp == env->llval) {                                              \
-            do_##st_insn(env, arg2, arg1, mem_idx, GETPC());                  \
-            return 1;                                                         \
-        }                                                                     \
-    }                                                                         \
-    return 0;                                                                 \
-}
-HELPER_ST_ATOMIC(sc, lw, sw, 0x3)
-#ifdef TARGET_MIPS64
-HELPER_ST_ATOMIC(scd, ld, sd, 0x7)
-#endif
-#undef HELPER_ST_ATOMIC
 #endif
 
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/target/mips/translate.c b/target/mips/translate.c
index c9104a7..f851d41 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1383,6 +1383,7 @@ static TCGv_i32 hflags;
 static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
+static TCGv cpu_lladdr, cpu_llval;
 
 #include "exec/gen-icount.h"
 
@@ -2073,48 +2074,6 @@ OP_LD_ATOMIC(lld,ld64);
 #endif
 #undef OP_LD_ATOMIC
 
-#ifdef CONFIG_USER_ONLY
-#define OP_ST_ATOMIC(insn,fname,ldname,almask)                               \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_idx,   \
-                                DisasContext *ctx)                           \
-{                                                                            \
-    TCGv t0 = tcg_temp_new();                                                \
-    TCGLabel *l1 = gen_new_label();                                          \
-    TCGLabel *l2 = gen_new_label();                                          \
-                                                                             \
-    tcg_gen_andi_tl(t0, arg2, almask);                                       \
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);                              \
-    tcg_gen_st_tl(arg2, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));          \
-    generate_exception(ctx, EXCP_AdES);                                      \
-    gen_set_label(l1);                                                       \
-    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUMIPSState, lladdr));                  \
-    tcg_gen_brcond_tl(TCG_COND_NE, arg2, t0, l2);                            \
-    tcg_gen_movi_tl(t0, rt | ((almask << 3) & 0x20));                        \
-    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, llreg));                   \
-    tcg_gen_st_tl(arg1, cpu_env, offsetof(CPUMIPSState, llnewval));              \
-    generate_exception_end(ctx, EXCP_SC);                                    \
-    gen_set_label(l2);                                                       \
-    tcg_gen_movi_tl(t0, 0);                                                  \
-    gen_store_gpr(t0, rt);                                                   \
-    tcg_temp_free(t0);                                                       \
-}
-#else
-#define OP_ST_ATOMIC(insn,fname,ldname,almask)                               \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_idx,   \
-                                DisasContext *ctx)                           \
-{                                                                            \
-    TCGv t0 = tcg_temp_new();                                                \
-    gen_helper_1e2i(insn, t0, arg1, arg2, mem_idx);                          \
-    gen_store_gpr(t0, rt);                                                   \
-    tcg_temp_free(t0);                                                       \
-}
-#endif
-OP_ST_ATOMIC(sc,st32,ld32s,0x3);
-#if defined(TARGET_MIPS64)
-OP_ST_ATOMIC(scd,st64,ld64,0x7);
-#endif
-#undef OP_ST_ATOMIC
-
 static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
                                   int base, int16_t offset)
 {
@@ -2401,37 +2360,34 @@ static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
 
 
 /* Store conditional */
-static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
-                         int base, int16_t offset)
+static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
+                        TCGMemOp tcg_mo)
 {
-    TCGv t0, t1;
-    int mem_idx = ctx->mem_idx;
+    TCGv addr, t0, val;
+    TCGLabel *l1 = gen_new_label();
+    TCGLabel *done = gen_new_label();
+
+     t0 = tcg_temp_new();
+    addr = tcg_temp_new();
+    /* compare the address against that of the preceeding LL */
+    gen_base_offset_addr(ctx, addr, base, offset);
+    tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
+    tcg_temp_free(addr);
+    tcg_gen_movi_tl(t0, 0);
+    gen_store_gpr(t0, rt);
+    tcg_gen_br(done);
 
-#ifdef CONFIG_USER_ONLY
-    t0 = tcg_temp_local_new();
-    t1 = tcg_temp_local_new();
-#else
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-#endif
-    gen_base_offset_addr(ctx, t0, base, offset);
-    gen_load_gpr(t1, rt);
-    switch (opc) {
-#if defined(TARGET_MIPS64)
-    case OPC_SCD:
-    case R6_OPC_SCD:
-        op_st_scd(t1, t0, rt, mem_idx, ctx);
-        break;
-#endif
-    case OPC_SCE:
-        mem_idx = MIPS_HFLAG_UM;
-        /* fall through */
-    case OPC_SC:
-    case R6_OPC_SC:
-        op_st_sc(t1, t0, rt, mem_idx, ctx);
-        break;
-    }
-    tcg_temp_free(t1);
+    gen_set_label(l1);
+    /* generate cmpxchg */
+    val = tcg_temp_new();
+    gen_load_gpr(val, rt);
+    tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval, val,
+                              ctx->mem_idx, tcg_mo);
+    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_llval);
+    gen_store_gpr(t0, rt);
+    tcg_temp_free(val);
+
+    gen_set_label(done);
     tcg_temp_free(t0);
 }
 
@@ -14889,13 +14845,13 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
-            gen_st_cond(ctx, OPC_SC, rt, rs, offset);
+            gen_st_cond(ctx, rt, rs, offset, MO_TESL);
             break;
 #if defined(TARGET_MIPS64)
         case SCD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            gen_st_cond(ctx, OPC_SCD, rt, rs, offset);
+            gen_st_cond(ctx, rt, rs, offset, MO_TEQ);
             break;
 #endif
         case LD_EVA:
@@ -17695,7 +17651,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case R6_OPC_SC:
-        gen_st_cond(ctx, op1, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TESL);
         break;
     case R6_OPC_LL:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -17719,7 +17675,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
         break;
 #if defined(TARGET_MIPS64)
     case R6_OPC_SCD:
-        gen_st_cond(ctx, op1, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TEQ);
         break;
     case R6_OPC_LLD:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -19844,7 +19800,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SC:
         check_insn(ctx, ISA_MIPS2);
          check_insn_opc_removed(ctx, ISA_MIPS32R6);
-         gen_st_cond(ctx, op, rt, rs, imm);
+         gen_st_cond(ctx, rt, rs, imm, MO_TESL);
          break;
     case OPC_CACHE:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
@@ -20130,7 +20086,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
-        gen_st_cond(ctx, op, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TEQ);
         break;
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC, OPC_DADDI */
         if (ctx->insn_flags & ISA_MIPS32R6) {
@@ -20497,6 +20453,10 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+    cpu_lladdr = tcg_global_mem_new(cpu_env, offsetof(CPUMIPSState, lladdr),
+                                    "lladdr");
+    cpu_llval = tcg_global_mem_new(cpu_env, offsetof(CPUMIPSState, llval),
+                                   "llval");
 }
 
 #include "translate_init.c"
-- 
2.7.4
