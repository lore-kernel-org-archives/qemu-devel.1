Received: from eggs.gnu.org ([209.51.188.92]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL73-0004b5-Jb
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL71-0004H3-De
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52215 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL6x-0003xi-91
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:49 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:11 +0100
Message-Id: <1550166444-22882-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/15] target/mips: reimplement SC instruction
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Leon Alrae <leon.alrae@imgtec.com>

Completely rewrite conditional stores handling. Use cmpxchg.

This eliminates need for separate implementations of SC instruction
emulation for user and system emulation.

Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/cpu_loop.c |  73 ---------------------------
 target/mips/cpu.h          |   4 --
 target/mips/helper.c       |   6 +--
 target/mips/helper.h       |   2 -
 target/mips/op_helper.c    |  27 ----------
 target/mips/translate.c    | 123 ++++++++++++++++-----------------------=
------
 6 files changed, 44 insertions(+), 191 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index d0f62ec..61dc90d 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -392,70 +392,6 @@ static const uint8_t mips_syscall_args[] =3D {
 #  undef MIPS_SYS
 # endif /* O32 */
=20
-static int do_store_exclusive(CPUMIPSState *env)
-{
-    target_ulong addr;
-    target_ulong page_addr;
-    target_ulong val;
-    uint32_t val_wp =3D 0;
-    uint32_t llnewval_wp =3D 0;
-    int flags;
-    int segv =3D 0;
-    int reg;
-    int d;
-    int wp;
-
-    addr =3D env->lladdr;
-    page_addr =3D addr & TARGET_PAGE_MASK;
-    start_exclusive();
-    mmap_lock();
-    flags =3D page_get_flags(page_addr);
-    if ((flags & PAGE_READ) =3D=3D 0) {
-        segv =3D 1;
-    } else {
-        reg =3D env->llreg & 0x1f;
-        d =3D (env->llreg & 0x20) !=3D 0;
-        wp =3D (env->llreg & 0x40) !=3D 0;
-        if (!wp) {
-            if (d) {
-                segv =3D get_user_s64(val, addr);
-            } else {
-                segv =3D get_user_s32(val, addr);
-            }
-        } else {
-            segv =3D get_user_s32(val, addr);
-            segv |=3D get_user_s32(val_wp, addr);
-            llnewval_wp =3D env->llnewval_wp;
-        }
-        if (!segv) {
-            if (val !=3D env->llval && val_wp =3D=3D llnewval_wp) {
-                env->active_tc.gpr[reg] =3D 0;
-            } else {
-                if (!wp) {
-                    if (d) {
-                        segv =3D put_user_u64(env->llnewval, addr);
-                    } else {
-                        segv =3D put_user_u32(env->llnewval, addr);
-                    }
-                } else {
-                    segv =3D put_user_u32(env->llnewval, addr);
-                    segv |=3D put_user_u32(env->llnewval_wp, addr + 4);
-                }
-                if (!segv) {
-                    env->active_tc.gpr[reg] =3D 1;
-                }
-            }
-        }
-    }
-    env->lladdr =3D -1;
-    if (!segv) {
-        env->active_tc.PC +=3D 4;
-    }
-    mmap_unlock();
-    end_exclusive();
-    return segv;
-}
-
 /* Break codes */
 enum {
     BRK_OVERFLOW =3D 6,
@@ -597,15 +533,6 @@ done_syscall:
             info.si_code =3D TARGET_TRAP_BRKPT;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
-        case EXCP_SC:
-            if (do_store_exclusive(env)) {
-                info.si_signo =3D TARGET_SIGSEGV;
-                info.si_errno =3D 0;
-                info.si_code =3D TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr =3D env->active_tc.PC;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
         case EXCP_DSPDIS:
             info.si_signo =3D TARGET_SIGILL;
             info.si_errno =3D 0;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f10e016..eccee37 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -876,10 +876,8 @@ struct CPUMIPSState {
  */
     target_ulong lladdr; /* LL virtual address compared against SC */
     target_ulong llval;
-    target_ulong llnewval;
     uint64_t llval_wp;
     uint32_t llnewval_wp;
-    target_ulong llreg;
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
 /*
@@ -1156,8 +1154,6 @@ enum {
=20
     EXCP_LAST =3D EXCP_TLBRI,
 };
-/* Dummy exception for conditional stores.  */
-#define EXCP_SC 0x100
=20
 /*
  * This is an internally generated WAKE request line.
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 8988452..944f094 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1463,10 +1463,8 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSS=
tate *env,
 {
     CPUState *cs =3D CPU(mips_env_get_cpu(env));
=20
-    if (exception < EXCP_SC) {
-        qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
-                      __func__, exception, error_code);
-    }
+    qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
+                  __func__, exception, error_code);
     cs->exception_index =3D exception;
     env->error_code =3D error_code;
=20
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 8872c46..a6d687e 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -13,10 +13,8 @@ DEF_HELPER_4(swr, void, env, tl, tl, int)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(ll, tl, env, tl, int)
-DEF_HELPER_4(sc, tl, env, tl, tl, int)
 #ifdef TARGET_MIPS64
 DEF_HELPER_3(lld, tl, env, tl, int)
-DEF_HELPER_4(scd, tl, env, tl, tl, int)
 #endif
 #endif
=20
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 44f2626..943a7ea 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -380,33 +380,6 @@ HELPER_LD_ATOMIC(ll, lw, 0x3)
 HELPER_LD_ATOMIC(lld, ld, 0x7)
 #endif
 #undef HELPER_LD_ATOMIC
-
-#define HELPER_ST_ATOMIC(name, ld_insn, st_insn, almask)                =
      \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,        =
      \
-                           target_ulong arg2, int mem_idx)              =
      \
-{                                                                       =
      \
-    target_long tmp;                                                    =
      \
-                                                                        =
      \
-    if (arg2 & almask) {                                                =
      \
-        if (!(env->hflags & MIPS_HFLAG_DM)) {                           =
      \
-            env->CP0_BadVAddr =3D arg2;                                 =
        \
-        }                                                               =
      \
-        do_raise_exception(env, EXCP_AdES, GETPC());                    =
      \
-    }                                                                   =
      \
-    if (arg2 =3D=3D env->lladdr) {                                      =
          \
-        tmp =3D do_##ld_insn(env, arg2, mem_idx, GETPC());              =
        \
-        if (tmp =3D=3D env->llval) {                                    =
          \
-            do_##st_insn(env, arg2, arg1, mem_idx, GETPC());            =
      \
-            return 1;                                                   =
      \
-        }                                                               =
      \
-    }                                                                   =
      \
-    return 0;                                                           =
      \
-}
-HELPER_ST_ATOMIC(sc, lw, sw, 0x3)
-#ifdef TARGET_MIPS64
-HELPER_ST_ATOMIC(scd, ld, sd, 0x7)
-#endif
-#undef HELPER_ST_ATOMIC
 #endif
=20
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 307d4ea..3b17020 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2450,6 +2450,7 @@ enum {
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
 static TCGv cpu_dspctrl, btarget, bcond;
+static TCGv cpu_lladdr, cpu_llval;
 static TCGv_i32 hflags;
 static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
@@ -3326,48 +3327,6 @@ OP_LD_ATOMIC(lld,ld64);
 #endif
 #undef OP_LD_ATOMIC
=20
-#ifdef CONFIG_USER_ONLY
-#define OP_ST_ATOMIC(insn,fname,ldname,almask)                          =
     \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_id=
x,   \
-                                DisasContext *ctx)                      =
     \
-{                                                                       =
     \
-    TCGv t0 =3D tcg_temp_new();                                         =
       \
-    TCGLabel *l1 =3D gen_new_label();                                   =
       \
-    TCGLabel *l2 =3D gen_new_label();                                   =
       \
-                                                                        =
     \
-    tcg_gen_andi_tl(t0, arg2, almask);                                  =
     \
-    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, l1);                         =
     \
-    tcg_gen_st_tl(arg2, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr)); =
         \
-    generate_exception(ctx, EXCP_AdES);                                 =
     \
-    gen_set_label(l1);                                                  =
     \
-    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUMIPSState, lladdr));         =
         \
-    tcg_gen_brcond_tl(TCG_COND_NE, arg2, t0, l2);                       =
     \
-    tcg_gen_movi_tl(t0, rt | ((almask << 3) & 0x20));                   =
     \
-    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUMIPSState, llreg));          =
         \
-    tcg_gen_st_tl(arg1, cpu_env, offsetof(CPUMIPSState, llnewval));     =
         \
-    generate_exception_end(ctx, EXCP_SC);                               =
     \
-    gen_set_label(l2);                                                  =
     \
-    tcg_gen_movi_tl(t0, 0);                                             =
     \
-    gen_store_gpr(t0, rt);                                              =
     \
-    tcg_temp_free(t0);                                                  =
     \
-}
-#else
-#define OP_ST_ATOMIC(insn,fname,ldname,almask)                          =
     \
-static inline void op_st_##insn(TCGv arg1, TCGv arg2, int rt, int mem_id=
x,   \
-                                DisasContext *ctx)                      =
     \
-{                                                                       =
     \
-    TCGv t0 =3D tcg_temp_new();                                         =
       \
-    gen_helper_1e2i(insn, t0, arg1, arg2, mem_idx);                     =
     \
-    gen_store_gpr(t0, rt);                                              =
     \
-    tcg_temp_free(t0);                                                  =
     \
-}
-#endif
-OP_ST_ATOMIC(sc,st32,ld32s,0x3);
-#if defined(TARGET_MIPS64)
-OP_ST_ATOMIC(scd,st64,ld64,0x7);
-#endif
-#undef OP_ST_ATOMIC
-
 static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
                                   int base, int offset)
 {
@@ -3679,40 +3638,38 @@ static void gen_st (DisasContext *ctx, uint32_t o=
pc, int rt,
=20
=20
 /* Store conditional */
-static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
-                         int base, int16_t offset)
+static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
+                        TCGMemOp tcg_mo, bool eva)
 {
-    TCGv t0, t1;
-    int mem_idx =3D ctx->mem_idx;
+    TCGv addr, t0, val;
+    TCGLabel *l1 =3D gen_new_label();
+    TCGLabel *done =3D gen_new_label();
=20
-#ifdef CONFIG_USER_ONLY
-    t0 =3D tcg_temp_local_new();
-    t1 =3D tcg_temp_local_new();
-#else
     t0 =3D tcg_temp_new();
-    t1 =3D tcg_temp_new();
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
-        mem_idx =3D MIPS_HFLAG_UM;
-        /* fall through */
-    case OPC_SC:
-    case R6_OPC_SC:
-        op_st_sc(t1, t0, rt, mem_idx, ctx);
-        break;
-    }
-    tcg_temp_free(t1);
+    addr =3D tcg_temp_new();
+    /* compare the address against that of the preceeding LL */
+    gen_base_offset_addr(ctx, addr, base, offset);
+    tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
+    tcg_temp_free(addr);
+    tcg_gen_movi_tl(t0, 0);
+    gen_store_gpr(t0, rt);
+    tcg_gen_br(done);
+
+    gen_set_label(l1);
+    /* generate cmpxchg */
+    val =3D tcg_temp_new();
+    gen_load_gpr(val, rt);
+    tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval, val,
+                              eva ? MIPS_HFLAG_UM : ctx->mem_idx, tcg_mo=
);
+    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_llval);
+    gen_store_gpr(t0, rt);
+    tcg_temp_free(val);
+
+    gen_set_label(done);
     tcg_temp_free(t0);
 }
=20
+
 static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
                     uint32_t reg1, uint32_t reg2, bool eva)
 {
@@ -16864,13 +16821,13 @@ static void decode_micromips32_opc(CPUMIPSState=
 *env, DisasContext *ctx)
             gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
-            gen_st_cond(ctx, OPC_SC, rt, rs, offset);
+            gen_st_cond(ctx, rt, rs, offset, MO_TESL, false);
             break;
 #if defined(TARGET_MIPS64)
         case SCD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            gen_st_cond(ctx, OPC_SCD, rt, rs, offset);
+            gen_st_cond(ctx, rt, rs, offset, MO_TEQ, false);
             break;
 #endif
         case LD_EVA:
@@ -16951,7 +16908,7 @@ static void decode_micromips32_opc(CPUMIPSState *=
env, DisasContext *ctx)
                 mips32_op =3D OPC_SHE;
                 goto do_st_lr;
             case SCE:
-                gen_st_cond(ctx, OPC_SCE, rt, rs, offset);
+                gen_st_cond(ctx, rt, rs, offset, MO_TESL, true);
                 break;
             case SWE:
                 mips32_op =3D OPC_SWE;
@@ -21558,7 +21515,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
                 case NM_P_SC:
                     switch (ctx->opcode & 0x03) {
                     case NM_SC:
-                        gen_st_cond(ctx, OPC_SC, rt, rs, s);
+                        gen_st_cond(ctx, rt, rs, s, MO_TESL, false);
                         break;
                     case NM_SCWP:
                         check_xnp(ctx);
@@ -21661,7 +21618,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
                         check_xnp(ctx);
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
-                        gen_st_cond(ctx, OPC_SCE, rt, rs, s);
+                        gen_st_cond(ctx, rt, rs, s, MO_TESL, true);
                         break;
                     case NM_SCWPE:
                         check_xnp(ctx);
@@ -26698,7 +26655,7 @@ static void decode_opc_special3_r6(CPUMIPSState *=
env, DisasContext *ctx)
         }
         break;
     case R6_OPC_SC:
-        gen_st_cond(ctx, op1, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TESL, false);
         break;
     case R6_OPC_LL:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -26725,7 +26682,7 @@ static void decode_opc_special3_r6(CPUMIPSState *=
env, DisasContext *ctx)
         break;
 #if defined(TARGET_MIPS64)
     case R6_OPC_SCD:
-        gen_st_cond(ctx, op1, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TEQ, false);
         break;
     case R6_OPC_LLD:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -27580,7 +27537,7 @@ static void decode_opc_special3(CPUMIPSState *env=
, DisasContext *ctx)
             return;
         case OPC_SCE:
             check_cp0_enabled(ctx);
-            gen_st_cond(ctx, op1, rt, rs, imm);
+            gen_st_cond(ctx, rt, rs, imm, MO_TESL, true);
             return;
         case OPC_CACHEE:
             check_cp0_enabled(ctx);
@@ -29172,8 +29129,8 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-         gen_st_cond(ctx, op, rt, rs, imm);
-         break;
+        gen_st_cond(ctx, rt, rs, imm, MO_TESL, false);
+        break;
     case OPC_CACHE:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         check_cp0_enabled(ctx);
@@ -29472,7 +29429,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
         check_mips_64(ctx);
-        gen_st_cond(ctx, op, rt, rs, imm);
+        gen_st_cond(ctx, rt, rs, imm, MO_TEQ, false);
         break;
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC, OPC_DADDI */
         if (ctx->insn_flags & ISA_MIPS32R6) {
@@ -29853,6 +29810,10 @@ void mips_tcg_init(void)
     fpu_fcr31 =3D tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu=
.fcr31),
                                        "fcr31");
+    cpu_lladdr =3D tcg_global_mem_new(cpu_env, offsetof(CPUMIPSState, ll=
addr),
+                                    "lladdr");
+    cpu_llval =3D tcg_global_mem_new(cpu_env, offsetof(CPUMIPSState, llv=
al),
+                                   "llval");
=20
 #if defined(TARGET_MIPS64)
     cpu_mmr[0] =3D NULL;
--=20
2.7.4
