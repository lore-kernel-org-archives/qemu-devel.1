Received: from eggs.gnu.org ([2001:4830:134:3::10]:52223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U8-000397-Fr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U2-0008HU-UC
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:20 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:34082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5U2-0008Gz-Lb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:14 -0400
Received: by mail-pf0-x232.google.com with SMTP id e1so1640681pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:41 -0700
Message-Id: <20170907224051.21518-14-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/23] tcg/sparc: Introduce TCG_REG_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/sparc/tcg-target.inc.c | 170 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 140 insertions(+), 30 deletions(-)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index bb7f7e8906..7d73c25347 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -85,6 +85,9 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 # define TCG_GUEST_BASE_REG TCG_REG_I5
 #endif
 
+#define TCG_REG_TB  TCG_REG_I1
+#define USE_REG_TB  (sizeof(void *) > 4)
+
 static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_L0,
     TCG_REG_L1,
@@ -249,6 +252,8 @@ static const int tcg_target_call_oarg_regs[] = {
 
 #define MEMBAR     (INSN_OP(2) | INSN_OP3(0x28) | INSN_RS1(15) | (1 << 13))
 
+#define NOP        (SETHI | INSN_RD(TCG_REG_G0) | 0)
+
 #ifndef ASI_PRIMARY_LITTLE
 #define ASI_PRIMARY_LITTLE 0x88
 #endif
@@ -423,10 +428,11 @@ static inline void tcg_out_movi_imm13(TCGContext *s, TCGReg ret, int32_t arg)
     tcg_out_arithi(s, ret, TCG_REG_G0, arg, ARITH_OR);
 }
 
-static void tcg_out_movi(TCGContext *s, TCGType type,
-                         TCGReg ret, tcg_target_long arg)
+static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long arg, bool in_prologue)
 {
     tcg_target_long hi, lo = (int32_t)arg;
+    tcg_target_long test, lsb;
 
     /* Make sure we test 32-bit constants for imm13 properly.  */
     if (type == TCG_TYPE_I32) {
@@ -455,6 +461,27 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
         return;
     }
 
+    /* A 21-bit constant, shifted.  */
+    lsb = ctz64(arg);
+    test = (tcg_target_long)arg >> lsb;
+    if (check_fit_tl(test, 13)) {
+        tcg_out_movi_imm13(s, ret, test);
+        tcg_out_arithi(s, ret, ret, lsb, SHIFT_SLLX);
+        return;
+    } else if (lsb > 10 && test == extract64(test, 0, 21)) {
+        tcg_out_sethi(s, ret, test << 10);
+        tcg_out_arithi(s, ret, ret, lsb - 10, SHIFT_SLLX);
+        return;
+    }
+
+    if (USE_REG_TB && !in_prologue) {
+        intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
+        if (check_fit_ptr(diff, 13)) {
+            tcg_out_arithi(s, ret, TCG_REG_TB, diff, ARITH_ADD);
+            return;
+        }
+    }
+
     /* A 64-bit constant decomposed into 2 32-bit pieces.  */
     if (check_fit_i32(lo, 13)) {
         hi = (arg - lo) >> 32;
@@ -470,6 +497,12 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
+static inline void tcg_out_movi(TCGContext *s, TCGType type,
+                                TCGReg ret, tcg_target_long arg)
+{
+    tcg_out_movi_int(s, type, ret, arg, false);
+}
+
 static inline void tcg_out_ldst_rr(TCGContext *s, TCGReg data, TCGReg a1,
                                    TCGReg a2, int op)
 {
@@ -512,6 +545,11 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 
 static void tcg_out_ld_ptr(TCGContext *s, TCGReg ret, uintptr_t arg)
 {
+    intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
+    if (USE_REG_TB && check_fit_ptr(diff, 13)) {
+        tcg_out_ld(s, TCG_TYPE_PTR, ret, TCG_REG_TB, diff);
+        return;
+    }
     tcg_out_movi(s, TCG_TYPE_PTR, ret, arg & ~0x3ff);
     tcg_out_ld(s, TCG_TYPE_PTR, ret, ret, arg & 0x3ff);
 }
@@ -543,7 +581,7 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
 
 static inline void tcg_out_nop(TCGContext *s)
 {
-    tcg_out_sethi(s, TCG_REG_G0, 0);
+    tcg_out32(s, NOP);
 }
 
 static const uint8_t tcg_cond_to_bcond[] = {
@@ -812,7 +850,8 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
     tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
 }
 
-static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
+                                 bool in_prologue)
 {
     ptrdiff_t disp = tcg_pcrel_diff(s, dest);
 
@@ -820,14 +859,15 @@ static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest)
         tcg_out32(s, CALL | (uint32_t)disp >> 2);
     } else {
         uintptr_t desti = (uintptr_t)dest;
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T1, desti & ~0xfff);
+        tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_REG_T1,
+                         desti & ~0xfff, in_prologue);
         tcg_out_arithi(s, TCG_REG_O7, TCG_REG_T1, desti & 0xfff, JMPL);
     }
 }
 
 static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
 {
-    tcg_out_call_nodelay(s, dest);
+    tcg_out_call_nodelay(s, dest, false);
     tcg_out_nop(s);
 }
 
@@ -915,7 +955,7 @@ static void build_trampolines(TCGContext *s)
         /* Set the env operand.  */
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O0, TCG_AREG0);
         /* Tail call.  */
-        tcg_out_call_nodelay(s, qemu_ld_helpers[i]);
+        tcg_out_call_nodelay(s, qemu_ld_helpers[i], true);
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O7, ra);
     }
 
@@ -964,7 +1004,7 @@ static void build_trampolines(TCGContext *s)
         /* Set the env operand.  */
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O0, TCG_AREG0);
         /* Tail call.  */
-        tcg_out_call_nodelay(s, qemu_st_helpers[i]);
+        tcg_out_call_nodelay(s, qemu_st_helpers[i], true);
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_O7, ra);
     }
 }
@@ -992,11 +1032,17 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 #ifndef CONFIG_SOFTMMU
     if (guest_base != 0) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base, true);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 #endif
 
+    /* We choose TCG_REG_TB such that no move is required.  */
+    if (USE_REG_TB) {
+        QEMU_BUILD_BUG_ON(TCG_REG_TB != TCG_REG_I1);
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);
+    }
+
     tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I1, 0, JMPL);
     /* delay slot */
     tcg_out_nop(s);
@@ -1156,7 +1202,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
         func = qemu_ld_trampoline[memop & (MO_BSWAP | MO_SSIZE)];
     }
     tcg_debug_assert(func != NULL);
-    tcg_out_call_nodelay(s, func);
+    tcg_out_call_nodelay(s, func, false);
     /* delay slot */
     tcg_out_movi(s, TCG_TYPE_I32, param, oi);
 
@@ -1235,7 +1281,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
 
     func = qemu_st_trampoline[memop & (MO_BSWAP | MO_SIZE)];
     tcg_debug_assert(func != NULL);
-    tcg_out_call_nodelay(s, func);
+    tcg_out_call_nodelay(s, func, false);
     /* delay slot */
     tcg_out_movi(s, TCG_TYPE_I32, param, oi);
 
@@ -1269,30 +1315,67 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (check_fit_ptr(a0, 13)) {
             tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
             tcg_out_movi_imm13(s, TCG_REG_O0, a0);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_I0, a0 & ~0x3ff);
-            tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
-            tcg_out_arithi(s, TCG_REG_O0, TCG_REG_O0, a0 & 0x3ff, ARITH_OR);
+            break;
+        } else if (USE_REG_TB) {
+            intptr_t tb_diff = a0 - (uintptr_t)s->code_gen_ptr;
+            if (check_fit_ptr(tb_diff, 13)) {
+                tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
+                /* Note that TCG_REG_TB has been unwound to O1.  */
+                tcg_out_arithi(s, TCG_REG_O0, TCG_REG_O1, tb_diff, ARITH_ADD);
+                break;
+            }
         }
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_I0, a0 & ~0x3ff);
+        tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
+        tcg_out_arithi(s, TCG_REG_O0, TCG_REG_O0, a0 & 0x3ff, ARITH_OR);
         break;
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
             /* direct jump method */
-            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
-            /* Make sure to preserve links during retranslation.  */
-            tcg_out32(s, CALL | (*s->code_ptr & ~INSN_OP(-1)));
+            if (USE_REG_TB) {
+                /* make sure the patch is 8-byte aligned.  */
+                if ((intptr_t)s->code_ptr & 4) {
+                    tcg_out_nop(s);
+                }
+                s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
+                tcg_out_sethi(s, TCG_REG_T1, 0);
+                tcg_out_arithi(s, TCG_REG_T1, TCG_REG_T1, 0, ARITH_OR);
+                tcg_out_arith(s, TCG_REG_G0, TCG_REG_TB, TCG_REG_T1, JMPL);
+                tcg_out_arith(s, TCG_REG_TB, TCG_REG_TB, TCG_REG_T1, ARITH_ADD);
+            } else {
+                s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
+                tcg_out32(s, CALL);
+                tcg_out_nop(s);
+            }
         } else {
             /* indirect jump method */
-            tcg_out_ld_ptr(s, TCG_REG_T1,
+            tcg_out_ld_ptr(s, TCG_REG_TB,
                            (uintptr_t)(s->tb_jmp_target_addr + a0));
-            tcg_out_arithi(s, TCG_REG_G0, TCG_REG_T1, 0, JMPL);
+            tcg_out_arithi(s, TCG_REG_G0, TCG_REG_TB, 0, JMPL);
+            tcg_out_nop(s);
+        }
+        s->tb_jmp_reset_offset[a0] = c = tcg_current_code_size(s);
+
+        /* For the unlinked path of goto_tb, we need to reset
+           TCG_REG_TB to the beginning of this TB.  */
+        if (USE_REG_TB) {
+            c = -c;
+            if (check_fit_i32(c, 13)) {
+                tcg_out_arithi(s, TCG_REG_TB, TCG_REG_TB, c, ARITH_ADD);
+            } else {
+                tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T1, c);
+                tcg_out_arith(s, TCG_REG_TB, TCG_REG_TB,
+                              TCG_REG_T1, ARITH_ADD);
+            }
         }
-        tcg_out_nop(s);
-        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
     case INDEX_op_goto_ptr:
         tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
-        tcg_out_nop(s);
+        if (USE_REG_TB) {
+            tcg_out_arith(s, TCG_REG_TB, a0, TCG_REG_G0, ARITH_OR);
+        } else {
+            tcg_out_nop(s);
+        }
         break;
     case INDEX_op_br:
         tcg_out_bpcc(s, COND_A, BPCC_PT, arg_label(a0));
@@ -1709,13 +1792,40 @@ void tcg_register_jit(void *buf, size_t buf_size)
 void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
-    uint32_t *ptr = (uint32_t *)jmp_addr;
-    uintptr_t disp = addr - jmp_addr;
+    intptr_t tb_disp = addr - tc_ptr;
+    intptr_t br_disp = addr - jmp_addr;
+    tcg_insn_unit i1, i2;
+
+    /* We can reach the entire address space for ILP32.
+       For LP64, the code_gen_buffer can't be larger than 2GB.  */
+    tcg_debug_assert(tb_disp == (int32_t)tb_disp);
+    tcg_debug_assert(br_disp == (int32_t)br_disp);
+
+    if (!USE_REG_TB) {
+        atomic_set((uint32_t *)jmp_addr, deposit32(CALL, 0, 30, br_disp >> 2));
+        flush_icache_range(jmp_addr, jmp_addr + 4);
+        return;
+    }
 
-    /* We can reach the entire address space for 32-bit.  For 64-bit
-       the code_gen_buffer can't be larger than 2GB.  */
-    tcg_debug_assert(disp == (int32_t)disp);
+    /* This does not exercise the range of the branch, but we do
+       still need to be able to load the new value of TCG_REG_TB.
+       But this does still happen quite often.  */
+    if (check_fit_ptr(tb_disp, 13)) {
+        /* ba,pt %icc, addr */
+        i1 = (INSN_OP(0) | INSN_OP2(1) | INSN_COND(COND_A)
+              | BPCC_ICC | BPCC_PT | INSN_OFF19(br_disp));
+        i2 = (ARITH_ADD | INSN_RD(TCG_REG_TB) | INSN_RS1(TCG_REG_TB)
+              | INSN_IMM13(tb_disp));
+    } else if (tb_disp >= 0) {
+        i1 = SETHI | INSN_RD(TCG_REG_T1) | ((tb_disp & 0xfffffc00) >> 10);
+        i2 = (ARITH_OR | INSN_RD(TCG_REG_T1) | INSN_RS1(TCG_REG_T1)
+              | INSN_IMM13(tb_disp & 0x3ff));
+    } else {
+        i1 = SETHI | INSN_RD(TCG_REG_T1) | ((~tb_disp & 0xfffffc00) >> 10);
+        i2 = (ARITH_XOR | INSN_RD(TCG_REG_T1) | INSN_RS1(TCG_REG_T1)
+              | INSN_IMM13((tb_disp & 0x3ff) | -0x400));
+    }
 
-    atomic_set(ptr, deposit32(CALL, 0, 30, disp >> 2));
-    flush_icache_range(jmp_addr, jmp_addr + 4);
+    atomic_set((uint64_t *)jmp_addr, deposit64(i2, 32, 32, i1));
+    flush_icache_range(jmp_addr, jmp_addr + 8);
 }
-- 
2.13.5
