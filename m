Received: from eggs.gnu.org ([2001:4830:134:3::10]:51104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVw-0002tt-Oz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVs-00028a-OD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGVs-00027P-BP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:25 +0100
Message-Id: <20170130181634.13934-8-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 07/16] target-m68k: manage FPU exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h        |  28 +++++++++++++
 target/m68k/fpu_helper.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h     |   1 +
 target/m68k/translate.c  |  27 ++++++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 6b3cb26..7985dc3 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -57,6 +57,15 @@
 #define EXCP_TRAP15         47   /* User trap #15.  */
 #define EXCP_UNSUPPORTED    61
 #define EXCP_ICE            13
+#define EXCP_FP_BSUN        48 /* Branch Set on Unordered */
+#define EXCP_FP_INEX        49 /* Inexact result */
+#define EXCP_FP_DZ          50 /* Divide by Zero */
+#define EXCP_FP_UNFL        51 /* Underflow */
+#define EXCP_FP_OPERR       52 /* Operand Error */
+#define EXCP_FP_OVFL        53 /* Overflow */
+#define EXCP_FP_SNAN        54 /* Signaling Not-A-Number */
+#define EXCP_FP_UNIMP       55 /* Unimplemented Data type */
+
 
 #define EXCP_RTE            0x100
 #define EXCP_HALT_INSN      0x101
@@ -222,6 +231,25 @@ typedef enum {
 #define FPSR_CC_Z     0x04000000 /* Zero */
 #define FPSR_CC_N     0x08000000 /* Negative */
 
+/* Exception Status */
+#define FPSR_ES_MASK  0x0000ff00
+#define FPSR_ES_BSUN  0x00008000 /* Branch Set on Unordered */
+#define FPSR_ES_SNAN  0x00004000 /* Signaling Not-A-Number */
+#define FPSR_ES_OPERR 0x00002000 /* Operand Error */
+#define FPSR_ES_OVFL  0x00001000 /* Overflow */
+#define FPSR_ES_UNFL  0x00000800 /* Underflow */
+#define FPSR_ES_DZ    0x00000400 /* Divide by Zero */
+#define FPSR_ES_INEX2 0x00000200 /* Inexact operation */
+#define FPSR_ES_INEX  0x00000100 /* Inexact decimal input */
+
+/* Accrued Exception */
+#define FPSR_AE_MASK  0x000000ff
+#define FPSR_AE_IOP   0x00000080 /* Invalid Operation */
+#define FPSR_AE_OVFL  0x00000040 /* Overflow */
+#define FPSR_AE_UNFL  0x00000020 /* Underflow */
+#define FPSR_AE_DZ    0x00000010 /* Divide by Zero */
+#define FPSR_AE_INEX  0x00000008 /* Inexact */
+
 /* Quotient */
 
 #define FPSR_QT_MASK  0x00ff0000
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 9d39118..1e68c41 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -177,6 +177,70 @@ static void restore_rounding_mode(CPUM68KState *env)
     }
 }
 
+static void set_fpsr_exception(CPUM68KState *env)
+{
+    uint32_t fpsr = 0;
+    int flags;
+
+    flags = get_float_exception_flags(&env->fp_status);
+    if (flags == 0) {
+        return;
+    }
+    set_float_exception_flags(0, &env->fp_status);
+
+    if (flags & float_flag_invalid) {
+        fpsr |= FPSR_AE_IOP;
+    }
+    if (flags & float_flag_divbyzero) {
+        fpsr |= FPSR_AE_DZ;
+    }
+    if (flags & float_flag_overflow) {
+        fpsr |= FPSR_AE_OVFL;
+    }
+    if (flags & float_flag_underflow) {
+        fpsr |= FPSR_AE_UNFL;
+    }
+    if (flags & float_flag_inexact) {
+        fpsr |= FPSR_AE_INEX;
+    }
+
+    env->fpsr = (env->fpsr & ~FPSR_AE_MASK) | fpsr;
+}
+
+static void fpu_exception(CPUM68KState *env, uint32_t exception)
+{
+    CPUState *cs = CPU(m68k_env_get_cpu(env));
+
+    env->fpsr = (env->fpsr & ~FPSR_ES_MASK) | exception;
+    if (env->fpcr & exception) {
+        switch (exception) {
+        case FPSR_ES_BSUN:
+            cs->exception_index = EXCP_FP_BSUN;
+            break;
+        case FPSR_ES_SNAN:
+            cs->exception_index = EXCP_FP_SNAN;
+            break;
+        case FPSR_ES_OPERR:
+            cs->exception_index = EXCP_FP_OPERR;
+            break;
+        case FPSR_ES_OVFL:
+            cs->exception_index = EXCP_FP_OVFL;
+            break;
+        case FPSR_ES_UNFL:
+            cs->exception_index = EXCP_FP_UNFL;
+            break;
+        case FPSR_ES_DZ:
+            cs->exception_index = EXCP_FP_DZ;
+            break;
+        case FPSR_ES_INEX:
+        case FPSR_ES_INEX2:
+            cs->exception_index = EXCP_FP_INEX;
+            break;
+        }
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+}
+
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
 {
     env->fpcr = val & 0xffff;
@@ -292,10 +356,16 @@ void HELPER(cmp_FP0_FP1)(CPUM68KState *env)
 {
     floatx80 fp0 = FP0_to_floatx80(env);
     floatx80 fp1 = FP1_to_floatx80(env);
-    int float_compare;
+    int flags, float_compare;
 
     float_compare = floatx80_compare(fp1, fp0, &env->fp_status);
     env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | float_comp_to_cc(float_compare);
+
+    flags = get_float_exception_flags(&env->fp_status);
+    if (flags & float_flag_invalid) {
+        fpu_exception(env, FPSR_ES_OPERR);
+   }
+   set_fpsr_exception(env);
 }
 
 void HELPER(tst_FP0)(CPUM68KState *env)
@@ -315,4 +385,39 @@ void HELPER(tst_FP0)(CPUM68KState *env)
         fpsr |= FPSR_CC_Z;
     }
     env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | fpsr;
+
+    set_fpsr_exception(env);
+}
+
+void HELPER(update_fpstatus)(CPUM68KState *env)
+{
+    int flags = get_float_exception_flags(&env->fp_status);
+
+    if (env->fpsr & FPSR_AE_IOP) {
+        flags |= float_flag_invalid;
+    } else {
+        flags &= ~float_flag_invalid;
+    }
+    if (env->fpsr & FPSR_AE_DZ) {
+        flags |= float_flag_divbyzero;
+    } else {
+        flags &= ~float_flag_divbyzero;
+    }
+    if (env->fpsr & FPSR_AE_OVFL) {
+        flags |= float_flag_overflow;
+    } else {
+        flags &= ~float_flag_overflow;
+    }
+    if (env->fpsr & FPSR_AE_UNFL) {
+        flags |= float_flag_underflow;
+    } else {
+        flags &= ~float_flag_underflow;
+    }
+    if (env->fpsr & FPSR_AE_INEX) {
+        flags |= float_flag_inexact;
+    } else {
+        flags &= ~float_flag_inexact;
+    }
+
+    set_float_exception_flags(flags, &env->fp_status);
 }
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 03fb268..072a6d0 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -30,6 +30,7 @@ DEF_HELPER_1(div_FP0_FP1, void, env)
 DEF_HELPER_1(cmp_FP0_FP1, void, env)
 DEF_HELPER_2(set_fpcr, void, env, i32)
 DEF_HELPER_1(tst_FP0, void, env)
+DEF_HELPER_1(update_fpstatus, void, env)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c9a86ae..030773b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4388,6 +4388,7 @@ static void gen_load_fcr(DisasContext *s, TCGv addr, int reg)
     switch (reg) {
     case 0: /* FPSR */
         tcg_gen_qemu_ld32u(QEMU_FPSR, addr, index);
+        gen_helper_update_fpstatus(cpu_env);
         break;
     case 1: /* FPIAR */
         break;
@@ -4431,6 +4432,7 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
         case 2: /* FPSR */
             SRC_EA(env, val, OS_LONG, 0, NULL);
             tcg_gen_mov_i32(QEMU_FPSR, val);
+            gen_helper_update_fpstatus(cpu_env);
             break;
         case 4: /* FPCR */
             SRC_EA(env, val, OS_LONG, 0, NULL);
@@ -5481,6 +5483,21 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                 (env->fpsr & FPSR_CC_I) ? 'I' : '-',
                 (env->fpsr & FPSR_CC_Z) ? 'Z' : '-',
                 (env->fpsr & FPSR_CC_N) ? 'N' : '-');
+    cpu_fprintf(f, "%c%c%c%c%c%c%c%c ",
+                (env->fpsr & FPSR_ES_BSUN) ? 'B' : '-',
+                (env->fpsr & FPSR_ES_SNAN) ? 'A' : '-',
+                (env->fpsr & FPSR_ES_OPERR) ? 'O' : '-',
+                (env->fpsr & FPSR_ES_OVFL) ? 'V' : '-',
+                (env->fpsr & FPSR_ES_UNFL) ? 'U' : '-',
+                (env->fpsr & FPSR_ES_DZ) ? 'Z' : '-',
+                (env->fpsr & FPSR_ES_INEX2) ? '2' : '-',
+                (env->fpcr & FPSR_ES_INEX) ? 'I' : '-');
+    cpu_fprintf(f, "%c%c%c%c%c",
+                (env->fpsr & FPSR_AE_IOP) ? 'O' : '-',
+                (env->fpsr & FPSR_AE_OVFL) ? 'V' : '-',
+                (env->fpsr & FPSR_AE_UNFL) ? 'U' : '-',
+                (env->fpsr & FPSR_AE_DZ) ? 'Z' : '-',
+                (env->fpcr & FPSR_ES_INEX) ? 'I' : '-');
     cpu_fprintf(f, "\n                                "
                    "FPCR =     %04x ", env->fpcr);
     switch (env->fpcr & FPCR_PREC_MASK) {
@@ -5508,6 +5525,16 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         cpu_fprintf(f, "RP ");
         break;
     }
+    /* FPCR exception mask uses the same bitmask as FPSR */
+    cpu_fprintf(f, "%c%c%c%c%c%c%c%c\n",
+                (env->fpcr & FPSR_ES_BSUN) ? 'B' : '-',
+                (env->fpcr & FPSR_ES_SNAN) ? 'A' : '-',
+                (env->fpcr & FPSR_ES_OPERR) ? 'O' : '-',
+                (env->fpcr & FPSR_ES_OVFL) ? 'V' : '-',
+                (env->fpcr & FPSR_ES_UNFL) ? 'U' : '-',
+                (env->fpcr & FPSR_ES_DZ) ? 'Z' : '-',
+                (env->fpcr & FPSR_ES_INEX2) ? '2' : '-',
+                (env->fpcr & FPSR_ES_INEX) ? 'I' : '-');
 }
 
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
-- 
2.9.3
