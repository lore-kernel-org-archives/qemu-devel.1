Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNmkD-0001jt-UP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNmkB-0006SZ-1U
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:00:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNmkA-0006Rt-HR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:00:54 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 21 Jun 2017 23:00:47 +0200
Message-Id: <20170621210047.24083-6-laurent@vivier.eu>
In-Reply-To: <20170621210047.24083-1-laurent@vivier.eu>
References: <20170621210047.24083-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/5] target-m68k: add FPCR and FPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170620205121.26515-6-laurent@vivier.eu>
---
 target/m68k/cpu.c        |   2 +-
 target/m68k/cpu.h        |  43 +++++-
 target/m68k/fpu_helper.c | 117 +++++++++++++---
 target/m68k/helper.c     |  22 ++-
 target/m68k/helper.h     |   5 +-
 target/m68k/translate.c  | 351 +++++++++++++++++++++++++++++++++++------------
 6 files changed, 421 insertions(+), 119 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 435456f..a14b6dd 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -62,7 +62,7 @@ static void m68k_cpu_reset(CPUState *s)
     for (i = 0; i < 8; i++) {
         env->fregs[i].d = nan;
     }
-    env->fpcr = 0;
+    cpu_m68k_set_fpcr(env, 0);
     env->fpsr = 0;
 
     cpu_m68k_set_ccr(env, 0);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index beb8ebc..38a7e11 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -171,6 +171,7 @@ int cpu_m68k_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 uint32_t cpu_m68k_get_ccr(CPUM68KState *env);
 void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
+void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
 
 
 /* Instead of computing the condition codes after each m68k instruction,
@@ -215,6 +216,43 @@ typedef enum {
 #define M68K_SSP    0
 #define M68K_USP    1
 
+#define M68K_FPIAR_SHIFT  0
+#define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
+#define M68K_FPSR_SHIFT   1
+#define M68K_FPSR         (1 << M68K_FPSR_SHIFT)
+#define M68K_FPCR_SHIFT   2
+#define M68K_FPCR         (1 << M68K_FPCR_SHIFT)
+
+/* Floating-Point Status Register */
+
+/* Condition Code */
+#define FPSR_CC_MASK  0x0f000000
+#define FPSR_CC_A     0x01000000 /* Not-A-Number */
+#define FPSR_CC_I     0x02000000 /* Infinity */
+#define FPSR_CC_Z     0x04000000 /* Zero */
+#define FPSR_CC_N     0x08000000 /* Negative */
+
+/* Quotient */
+
+#define FPSR_QT_MASK  0x00ff0000
+
+/* Floating-Point Control Register */
+/* Rounding mode */
+#define FPCR_RND_MASK   0x0030
+#define FPCR_RND_N      0x0000
+#define FPCR_RND_Z      0x0010
+#define FPCR_RND_M      0x0020
+#define FPCR_RND_P      0x0030
+
+/* Rounding precision */
+#define FPCR_PREC_MASK  0x00c0
+#define FPCR_PREC_X     0x0000
+#define FPCR_PREC_S     0x0040
+#define FPCR_PREC_D     0x0080
+#define FPCR_PREC_U     0x00c0
+
+#define FPCR_EXCP_MASK 0xff00
+
 /* CACR fields are implementation defined, but some bits are common.  */
 #define M68K_CACR_EUSP  0x10
 
@@ -231,8 +269,6 @@ typedef enum {
 void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector);
 void m68k_switch_sp(CPUM68KState *env);
 
-#define M68K_FPCR_PREC (1 << 6)
-
 void do_m68k_semihosting(CPUM68KState *env, int nr);
 
 /* There are 4 ColdFire core ISA revisions: A, A+, B and C.
@@ -310,8 +346,7 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
 {
     *pc = env->pc;
     *cs_base = 0;
-    *flags = (env->fpcr & M68K_FPCR_PREC)       /* Bit  6 */
-            | (env->sr & SR_S)                  /* Bit  13 */
+    *flags = (env->sr & SR_S)                   /* Bit  13 */
             | ((env->macsr >> 4) & 0xf);        /* Bits 0-3 */
 }
 
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index f4d3821..a9e17f5 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -58,9 +58,74 @@ void HELPER(firound)(CPUM68KState *env, FPReg *res, FPReg *val)
     res->d = floatx80_round_to_int(val->d, &env->fp_status);
 }
 
+static void m68k_restore_precision_mode(CPUM68KState *env)
+{
+    switch (env->fpcr & FPCR_PREC_MASK) {
+    case FPCR_PREC_X: /* extended */
+        set_floatx80_rounding_precision(80, &env->fp_status);
+        break;
+    case FPCR_PREC_S: /* single */
+        set_floatx80_rounding_precision(32, &env->fp_status);
+        break;
+    case FPCR_PREC_D: /* double */
+        set_floatx80_rounding_precision(64, &env->fp_status);
+        break;
+    case FPCR_PREC_U: /* undefined */
+    default:
+        break;
+    }
+}
+
+static void cf_restore_precision_mode(CPUM68KState *env)
+{
+    if (env->fpcr & FPCR_PREC_S) { /* single */
+        set_floatx80_rounding_precision(32, &env->fp_status);
+    } else { /* double */
+        set_floatx80_rounding_precision(64, &env->fp_status);
+    }
+}
+
+static void restore_rounding_mode(CPUM68KState *env)
+{
+    switch (env->fpcr & FPCR_RND_MASK) {
+    case FPCR_RND_N: /* round to nearest */
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+        break;
+    case FPCR_RND_Z: /* round to zero */
+        set_float_rounding_mode(float_round_to_zero, &env->fp_status);
+        break;
+    case FPCR_RND_M: /* round toward minus infinity */
+        set_float_rounding_mode(float_round_down, &env->fp_status);
+        break;
+    case FPCR_RND_P: /* round toward positive infinity */
+        set_float_rounding_mode(float_round_up, &env->fp_status);
+        break;
+    }
+}
+
+void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
+{
+    env->fpcr = val & 0xffff;
+
+    if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
+        cf_restore_precision_mode(env);
+    } else {
+        m68k_restore_precision_mode(env);
+    }
+    restore_rounding_mode(env);
+}
+
 void HELPER(fitrunc)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
+    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    set_float_rounding_mode(float_round_to_zero, &env->fp_status);
     res->d = floatx80_round_to_int(val->d, &env->fp_status);
+    set_float_rounding_mode(rounding_mode, &env->fp_status);
+}
+
+void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
+{
+    cpu_m68k_set_fpcr(env, val);
 }
 
 void HELPER(fsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
@@ -98,24 +163,44 @@ void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
     res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
 }
 
-void HELPER(fsub_cmp)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
-{
-    /* ??? This may incorrectly raise exceptions.  */
-    /* ??? Should flush denormals to zero.  */
-    res->d = floatx80_sub(val0->d, val1->d, &env->fp_status);
-    if (floatx80_is_quiet_nan(res->d, &env->fp_status)) {
-        /* +/-inf compares equal against itself, but sub returns nan.  */
-        if (!floatx80_is_quiet_nan(val0->d, &env->fp_status)
-            && !floatx80_is_quiet_nan(val1->d, &env->fp_status)) {
-            res->d = floatx80_zero;
-            if (floatx80_lt_quiet(val0->d, res->d, &env->fp_status)) {
-                res->d = floatx80_chs(res->d);
-            }
-        }
+static int float_comp_to_cc(int float_compare)
+{
+    switch (float_compare) {
+    case float_relation_equal:
+        return FPSR_CC_Z;
+    case float_relation_less:
+        return FPSR_CC_N;
+    case float_relation_unordered:
+        return FPSR_CC_A;
+    case float_relation_greater:
+        return 0;
+    default:
+        g_assert_not_reached();
     }
 }
 
-uint32_t HELPER(fcompare)(CPUM68KState *env, FPReg *val)
+void HELPER(fcmp)(CPUM68KState *env, FPReg *val0, FPReg *val1)
 {
-    return floatx80_compare_quiet(val->d, floatx80_zero, &env->fp_status);
+    int float_compare;
+
+    float_compare = floatx80_compare(val1->d, val0->d, &env->fp_status);
+    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | float_comp_to_cc(float_compare);
+}
+
+void HELPER(ftst)(CPUM68KState *env, FPReg *val)
+{
+    uint32_t cc = 0;
+
+    if (floatx80_is_neg(val->d)) {
+        cc |= FPSR_CC_N;
+    }
+
+    if (floatx80_is_any_nan(val->d)) {
+        cc |= FPSR_CC_A;
+    } else if (floatx80_is_infinity(val->d)) {
+        cc |= FPSR_CC_I;
+    } else if (floatx80_is_zero(val->d)) {
+        cc |= FPSR_CC_Z;
+    }
+    env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | cc;
 }
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f2de6b5..caae291 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -80,8 +80,14 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
         stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
         return 8;
     }
-    if (n < 11) {
-        /* FP control registers (not implemented)  */
+    switch (n) {
+    case 8: /* fpcontrol */
+        stl_be_p(mem_buf, env->fpcr);
+        return 4;
+    case 9: /* fpstatus */
+        stl_be_p(mem_buf, env->fpsr);
+        return 4;
+    case 10: /* fpiar, not implemented */
         memset(mem_buf, 0, 4);
         return 4;
     }
@@ -95,8 +101,14 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
         env->fregs[n].d = float64_to_floatx80(ldfq_p(mem_buf), &s);
         return 8;
     }
-    if (n < 11) {
-        /* FP control registers (not implemented)  */
+    switch (n) {
+    case 8: /* fpcontrol */
+        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        return 4;
+    case 9: /* fpstatus */
+        env->fpsr = ldl_p(mem_buf);
+        return 4;
+    case 10: /* fpiar, not implemented */
         return 4;
     }
     return 0;
@@ -133,7 +145,7 @@ static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     }
     switch (n) {
     case 8: /* fpcontrol */
-        env->fpcr = ldl_p(mem_buf);
+        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
         env->fpsr = ldl_p(mem_buf);
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d871be6..98cbf18 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -32,8 +32,9 @@ DEF_HELPER_4(fadd, void, env, fp, fp, fp)
 DEF_HELPER_4(fsub, void, env, fp, fp, fp)
 DEF_HELPER_4(fmul, void, env, fp, fp, fp)
 DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
-DEF_HELPER_4(fsub_cmp, void, env, fp, fp, fp)
-DEF_HELPER_2(fcompare, i32, env, fp)
+DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
+DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 73f691f..7aa0fdc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -120,7 +120,6 @@ typedef struct DisasContext {
     CCOp cc_op; /* Current CC operation */
     int cc_op_synced;
     int user;
-    uint32_t fpcr;
     struct TranslationBlock *tb;
     int singlestep_enabled;
     TCGv_i64 mactmp;
@@ -4371,33 +4370,139 @@ DISAS_INSN(trap)
     gen_exception(s, s->pc - 2, EXCP_TRAP0 + (insn & 0xf));
 }
 
+static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
+{
+    switch (reg) {
+    case M68K_FPIAR:
+        tcg_gen_movi_i32(res, 0);
+        break;
+    case M68K_FPSR:
+        tcg_gen_ld_i32(res, cpu_env, offsetof(CPUM68KState, fpsr));
+        break;
+    case M68K_FPCR:
+        tcg_gen_ld_i32(res, cpu_env, offsetof(CPUM68KState, fpcr));
+        break;
+    }
+}
+
+static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
+{
+    switch (reg) {
+    case M68K_FPIAR:
+        break;
+    case M68K_FPSR:
+        tcg_gen_st_i32(val, cpu_env, offsetof(CPUM68KState, fpsr));
+        break;
+    case M68K_FPCR:
+        gen_helper_set_fpcr(cpu_env, val);
+        break;
+    }
+}
+
+static void gen_qemu_store_fcr(DisasContext *s, TCGv addr, int reg)
+{
+    int index = IS_USER(s);
+    TCGv tmp;
+
+    tmp = tcg_temp_new();
+    gen_load_fcr(s, tmp, reg);
+    tcg_gen_qemu_st32(tmp, addr, index);
+    tcg_temp_free(tmp);
+}
+
+static void gen_qemu_load_fcr(DisasContext *s, TCGv addr, int reg)
+{
+    int index = IS_USER(s);
+    TCGv tmp;
+
+    tmp = tcg_temp_new();
+    tcg_gen_qemu_ld32u(tmp, addr, index);
+    gen_store_fcr(s, tmp, reg);
+    tcg_temp_free(tmp);
+}
+
+
 static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
                              uint32_t insn, uint32_t ext)
 {
     int mask = (ext >> 10) & 7;
     int is_write = (ext >> 13) & 1;
-    TCGv val;
+    int mode = extract32(insn, 3, 3);
+    int i;
+    TCGv addr, tmp;
 
-    switch (mask) {
-    case 1: /* FPIAR */
-    case 2: /* FPSR */
-    default:
-        qemu_log_mask(LOG_UNIMP, "Unimplemented: fmove to/from control %d",
-                      mask);
-        goto undef;
-    case 4: /* FPCR */
+    switch (mode) {
+    case 0: /* Dn */
+        if (mask != M68K_FPIAR && mask != M68K_FPSR && mask != M68K_FPCR) {
+            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            return;
+        }
         if (is_write) {
-            val = tcg_const_i32(0);
-            DEST_EA(env, insn, OS_LONG, val, NULL);
-            tcg_temp_free(val);
+            gen_load_fcr(s, DREG(insn, 0), mask);
+        } else {
+            gen_store_fcr(s, DREG(insn, 0), mask);
         }
-        /* Not implemented. Ignore register update */
+        return;
+    case 1: /* An, only with FPIAR */
+        if (mask != M68K_FPIAR) {
+            gen_exception(s, s->insn_pc, EXCP_ILLEGAL);
+            return;
+        }
+        if (is_write) {
+            gen_load_fcr(s, AREG(insn, 0), mask);
+        } else {
+            gen_store_fcr(s, AREG(insn, 0), mask);
+        }
+        return;
+    default:
         break;
     }
-    return;
-undef:
-    s->pc -= 2;
-    disas_undef_fpu(env, s, insn);
+
+    tmp = gen_lea(env, s, insn, OS_LONG);
+    if (IS_NULL_QREG(tmp)) {
+        gen_addr_fault(s);
+        return;
+    }
+
+    addr = tcg_temp_new();
+    tcg_gen_mov_i32(addr, tmp);
+
+    /* mask:
+     *
+     * 0b100 Floating-Point Control Register
+     * 0b010 Floating-Point Status Register
+     * 0b001 Floating-Point Instruction Address Register
+     *
+     */
+
+    if (is_write && mode == 4) {
+        for (i = 2; i >= 0; i--, mask >>= 1) {
+            if (mask & 1) {
+                gen_qemu_store_fcr(s, addr, 1 << i);
+                if (mask != 1) {
+                    tcg_gen_subi_i32(addr, addr, opsize_bytes(OS_LONG));
+                }
+            }
+       }
+       tcg_gen_mov_i32(AREG(insn, 0), addr);
+    } else {
+        for (i = 0; i < 3; i++, mask >>= 1) {
+            if (mask & 1) {
+                if (is_write) {
+                    gen_qemu_store_fcr(s, addr, 1 << i);
+                } else {
+                    gen_qemu_load_fcr(s, addr, 1 << i);
+                }
+                if (mask != 1 || mode == 3) {
+                    tcg_gen_addi_i32(addr, addr, opsize_bytes(OS_LONG));
+                }
+            }
+        }
+        if (mode == 3) {
+            tcg_gen_mov_i32(AREG(insn, 0), addr);
+        }
+    }
+    tcg_temp_free_i32(addr);
 }
 
 /* ??? FP exceptions are not implemented.  Most exceptions are deferred until
@@ -4407,7 +4512,6 @@ DISAS_INSN(fpu)
     uint16_t ext;
     int opmode;
     TCGv tmp32;
-    int round;
     int opsize;
     TCGv_ptr cpu_src, cpu_dest;
 
@@ -4424,6 +4528,7 @@ DISAS_INSN(fpu)
         if (gen_ea_fp(env, s, insn, opsize, cpu_src, EA_STORE) == -1) {
             gen_addr_fault(s);
         }
+        gen_helper_ftst(cpu_env, cpu_src);
         tcg_temp_free_ptr(cpu_src);
         return;
     case 4: /* fmove to control register.  */
@@ -4477,7 +4582,6 @@ DISAS_INSN(fpu)
         opsize = OS_EXTENDED;
         cpu_src = gen_fp_ptr(REG(ext, 10));
     }
-    round = 1;
     cpu_dest = gen_fp_ptr(REG(ext, 7));
     switch (opmode) {
     case 0: case 0x40: case 0x44: /* fmove */
@@ -4485,11 +4589,9 @@ DISAS_INSN(fpu)
         break;
     case 1: /* fint */
         gen_helper_firound(cpu_env, cpu_dest, cpu_src);
-        round = 0;
         break;
     case 3: /* fintrz */
         gen_helper_fitrunc(cpu_env, cpu_dest, cpu_src);
-        round = 0;
         break;
     case 4: case 0x41: case 0x45: /* fsqrt */
         gen_helper_fsqrt(cpu_env, cpu_dest, cpu_src);
@@ -4513,40 +4615,16 @@ DISAS_INSN(fpu)
         gen_helper_fsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
     case 0x38: /* fcmp */
-        tcg_temp_free_ptr(cpu_dest);
-        cpu_dest = gen_fp_result_ptr();
-        gen_helper_fsub_cmp(cpu_env, cpu_dest, cpu_src, cpu_dest);
-        round = 0;
-        break;
+        gen_helper_fcmp(cpu_env, cpu_src, cpu_dest);
+        return;
     case 0x3a: /* ftst */
-        tcg_temp_free_ptr(cpu_dest);
-        cpu_dest = gen_fp_result_ptr();
-        gen_fp_move(cpu_dest, cpu_src);
-        round = 0;
-        break;
+        gen_helper_ftst(cpu_env, cpu_src);
+        return;
     default:
         goto undef;
     }
-    if (round) {
-        if (opmode & 0x40) {
-            if ((opmode & 0x4) != 0)
-                round = 0;
-        } else if ((s->fpcr & M68K_FPCR_PREC) == 0) {
-            round = 0;
-        }
-    }
-    if (round) {
-        TCGv tmp = tcg_temp_new();
-        gen_helper_redf32(tmp, cpu_env, cpu_dest);
-        gen_helper_extf32(cpu_env, cpu_dest, tmp);
-        tcg_temp_free(tmp);
-    } else {
-        TCGv_i64 t64 = tcg_temp_new_i64();
-        gen_helper_redf64(t64, cpu_env, cpu_dest);
-        gen_helper_extf64(cpu_env, cpu_dest, t64);
-        tcg_temp_free_i64(t64);
-    }
     tcg_temp_free_ptr(cpu_src);
+    gen_helper_ftst(cpu_env, cpu_dest);
     tcg_temp_free_ptr(cpu_dest);
     return;
 undef:
@@ -4559,9 +4637,8 @@ DISAS_INSN(fbcc)
 {
     uint32_t offset;
     uint32_t addr;
-    TCGv flag;
     TCGLabel *l1;
-    TCGv_ptr fp_result;
+    TCGv tmp, fpsr;
 
     addr = s->pc;
     offset = cpu_ldsw_code(env, s->pc);
@@ -4570,64 +4647,125 @@ DISAS_INSN(fbcc)
         offset = (offset << 16) | read_im16(env, s);
     }
 
+    fpsr = tcg_temp_new();
+    gen_load_fcr(s, fpsr, M68K_FPSR);
     l1 = gen_new_label();
     /* TODO: Raise BSUN exception.  */
-    flag = tcg_temp_new();
-    fp_result = gen_fp_result_ptr();
-    gen_helper_fcompare(flag, cpu_env, fp_result);
-    tcg_temp_free_ptr(fp_result);
     /* Jump to l1 if condition is true.  */
-    switch (insn & 0xf) {
-    case 0: /* f */
+    switch (insn & 0x3f)  {
+    case 0:  /* False */
+    case 16: /* Signaling False */
         break;
-    case 1: /* eq (=0) */
-        tcg_gen_brcond_i32(TCG_COND_EQ, flag, tcg_const_i32(0), l1);
+    case 1:  /* EQual Z */
+    case 17: /* Signaling EQual Z */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 2: /* ogt (=1) */
-        tcg_gen_brcond_i32(TCG_COND_EQ, flag, tcg_const_i32(1), l1);
+    case 2:  /* Ordered Greater Than !(A || Z || N) */
+    case 18: /* Greater Than !(A || Z || N) */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr,
+                         FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
         break;
-    case 3: /* oge (=0 or =1) */
-        tcg_gen_brcond_i32(TCG_COND_LEU, flag, tcg_const_i32(1), l1);
+    case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
+    case 19: /* Greater than or Equal Z || !(A || N) */
+        assert(FPSR_CC_A == (FPSR_CC_N >> 3));
+        tmp = tcg_temp_new();
+        tcg_gen_shli_i32(tmp, fpsr, 3);
+        tcg_gen_or_i32(tmp, tmp, fpsr);
+        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 4: /* olt (=-1) */
-        tcg_gen_brcond_i32(TCG_COND_LT, flag, tcg_const_i32(0), l1);
+    case 4:  /* Ordered Less Than !(!N || A || Z); */
+    case 20: /* Less Than !(!N || A || Z); */
+        tmp = tcg_temp_new();
+        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_N);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
         break;
-    case 5: /* ole (=-1 or =0) */
-        tcg_gen_brcond_i32(TCG_COND_LE, flag, tcg_const_i32(0), l1);
+    case 5:  /* Ordered Less than or Equal Z || (N && !A) */
+    case 21: /* Less than or Equal Z || (N && !A) */
+        assert(FPSR_CC_A == (FPSR_CC_N >> 3));
+        tmp = tcg_temp_new();
+        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_A);
+        tcg_gen_shli_i32(tmp, tmp, 3);
+        tcg_gen_ori_i32(tmp, tmp, FPSR_CC_Z);
+        tcg_gen_and_i32(tmp, tmp, fpsr);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 6: /* ogl (=-1 or =1) */
-        tcg_gen_andi_i32(flag, flag, 1);
-        tcg_gen_brcond_i32(TCG_COND_NE, flag, tcg_const_i32(0), l1);
+    case 6:  /* Ordered Greater or Less than !(A || Z) */
+    case 22: /* Greater or Less than !(A || Z) */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
         break;
-    case 7: /* or (=2) */
-        tcg_gen_brcond_i32(TCG_COND_EQ, flag, tcg_const_i32(2), l1);
+    case 7:  /* Ordered !A */
+    case 23: /* Greater, Less or Equal !A */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
         break;
-    case 8: /* un (<2) */
-        tcg_gen_brcond_i32(TCG_COND_LT, flag, tcg_const_i32(2), l1);
+    case 8:  /* Unordered A */
+    case 24: /* Not Greater, Less or Equal A */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 9: /* ueq (=0 or =2) */
-        tcg_gen_andi_i32(flag, flag, 1);
-        tcg_gen_brcond_i32(TCG_COND_EQ, flag, tcg_const_i32(0), l1);
+    case 9:  /* Unordered or Equal A || Z */
+    case 25: /* Not Greater or Less then A || Z */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 10: /* ugt (>0) */
-        tcg_gen_brcond_i32(TCG_COND_GT, flag, tcg_const_i32(0), l1);
+    case 10: /* Unordered or Greater Than A || !(N || Z)) */
+    case 26: /* Not Less or Equal A || !(N || Z)) */
+        assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
+        tmp = tcg_temp_new();
+        tcg_gen_shli_i32(tmp, fpsr, 1);
+        tcg_gen_or_i32(tmp, tmp, fpsr);
+        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_N | FPSR_CC_A);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 11: /* uge (>=0) */
-        tcg_gen_brcond_i32(TCG_COND_GE, flag, tcg_const_i32(0), l1);
+    case 11: /* Unordered or Greater or Equal A || Z || !N */
+    case 27: /* Not Less Than A || Z || !N */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
+        tcg_gen_xori_i32(tmp, tmp, FPSR_CC_N);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 12: /* ult (=-1 or =2) */
-        tcg_gen_brcond_i32(TCG_COND_GEU, flag, tcg_const_i32(2), l1);
+    case 12: /* Unordered or Less Than A || (N && !Z) */
+    case 28: /* Not Greater than or Equal A || (N && !Z) */
+        assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
+        tmp = tcg_temp_new();
+        tcg_gen_xori_i32(tmp, fpsr, FPSR_CC_Z);
+        tcg_gen_shli_i32(tmp, tmp, 1);
+        tcg_gen_ori_i32(tmp, tmp, FPSR_CC_A);
+        tcg_gen_and_i32(tmp, tmp, fpsr);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_CC_A | FPSR_CC_N);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 13: /* ule (!=1) */
-        tcg_gen_brcond_i32(TCG_COND_NE, flag, tcg_const_i32(1), l1);
+    case 13: /* Unordered or Less or Equal A || Z || N */
+    case 29: /* Not Greater Than A || Z || N */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
         break;
-    case 14: /* ne (!=0) */
-        tcg_gen_brcond_i32(TCG_COND_NE, flag, tcg_const_i32(0), l1);
+    case 14: /* Not Equal !Z */
+    case 30: /* Signaling Not Equal !Z */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
+        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 0, l1);
         break;
-    case 15: /* t */
+    case 15: /* True */
+    case 31: /* Signaling True */
         tcg_gen_br(l1);
         break;
     }
+    tcg_temp_free(fpsr);
     gen_jmp_tb(s, 0, s->pc);
     gen_set_label(l1);
     gen_jmp_tb(s, 1, addr + offset);
@@ -5252,7 +5390,6 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_synced = 1;
     dc->singlestep_enabled = cs->singlestep_enabled;
-    dc->fpcr = env->fpcr;
     dc->user = (env->sr & SR_S) == 0;
     dc->done_mac = 0;
     dc->writeback_mask = 0;
@@ -5371,6 +5508,38 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "SR = %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-',
                 (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
                 (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
+    cpu_fprintf(f, "FPSR = %08x %c%c%c%c ", env->fpsr,
+                (env->fpsr & FPSR_CC_A) ? 'A' : '-',
+                (env->fpsr & FPSR_CC_I) ? 'I' : '-',
+                (env->fpsr & FPSR_CC_Z) ? 'Z' : '-',
+                (env->fpsr & FPSR_CC_N) ? 'N' : '-');
+    cpu_fprintf(f, "\n                                "
+                   "FPCR =     %04x ", env->fpcr);
+    switch (env->fpcr & FPCR_PREC_MASK) {
+    case FPCR_PREC_X:
+        cpu_fprintf(f, "X ");
+        break;
+    case FPCR_PREC_S:
+        cpu_fprintf(f, "S ");
+        break;
+    case FPCR_PREC_D:
+        cpu_fprintf(f, "D ");
+        break;
+    }
+    switch (env->fpcr & FPCR_RND_MASK) {
+    case FPCR_RND_N:
+        cpu_fprintf(f, "RN ");
+        break;
+    case FPCR_RND_Z:
+        cpu_fprintf(f, "RZ ");
+        break;
+    case FPCR_RND_M:
+        cpu_fprintf(f, "RM ");
+        break;
+    case FPCR_RND_P:
+        cpu_fprintf(f, "RP ");
+        break;
+    }
 }
 
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
-- 
2.9.4
