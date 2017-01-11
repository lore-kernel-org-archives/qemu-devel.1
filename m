Received: from eggs.gnu.org ([2001:4830:134:3::10]:35612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VE-0006cN-E9
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VC-0003U5-6w
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:04 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VB-0003TJ-Um
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:02 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so12526231pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:01 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:01 -0800
Message-Id: <20170111021820.24416-47-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 46/65] tcg/i386: Hoist common arguments in
 tcg_out_op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 197 ++++++++++++++++++++++------------------------
 1 file changed, 95 insertions(+), 102 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e497bef..83572ac 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1791,7 +1791,8 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
-    int c, vexop, rexw = 0;
+    TCGArg a0, a1, a2;
+    int c, const_a2, vexop, rexw = 0;
 
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
@@ -1803,9 +1804,15 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         case glue(glue(INDEX_op_, x), _i32)
 #endif
 
-    switch(opc) {
+    /* Hoist the loads of the most common arguments.  */
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+    const_a2 = const_args[2];
+
+    switch (opc) {
     case INDEX_op_exit_tb:
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, args[0]);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, a0);
         tcg_out_jmp(s, tb_ret_addr);
         break;
     case INDEX_op_goto_tb:
@@ -1820,57 +1827,53 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                 tcg_out_nopn(s, gap - 1);
             }
             tcg_out8(s, OPC_JMP_long); /* jmp im */
-            s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
+            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
             tcg_out32(s, 0);
         } else {
             /* indirect jump method */
             tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, -1,
-                                 (intptr_t)(s->tb_jmp_target_addr + args[0]));
+                                 (intptr_t)(s->tb_jmp_target_addr + a0));
         }
-        s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
+        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
     case INDEX_op_br:
-        tcg_out_jxx(s, JCC_JMP, arg_label(args[0]), 0);
+        tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
         break;
     OP_32_64(ld8u):
         /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZBL, args[0], args[1], args[2]);
+        tcg_out_modrm_offset(s, OPC_MOVZBL, a0, a1, a2);
         break;
     OP_32_64(ld8s):
-        tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, args[0], args[1], args[2]);
+        tcg_out_modrm_offset(s, OPC_MOVSBL + rexw, a0, a1, a2);
         break;
     OP_32_64(ld16u):
         /* Note that we can ignore REXW for the zero-extend to 64-bit.  */
-        tcg_out_modrm_offset(s, OPC_MOVZWL, args[0], args[1], args[2]);
+        tcg_out_modrm_offset(s, OPC_MOVZWL, a0, a1, a2);
         break;
     OP_32_64(ld16s):
-        tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, args[0], args[1], args[2]);
+        tcg_out_modrm_offset(s, OPC_MOVSWL + rexw, a0, a1, a2);
         break;
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_ld32u_i64:
 #endif
     case INDEX_op_ld_i32:
-        tcg_out_ld(s, TCG_TYPE_I32, args[0], args[1], args[2]);
+        tcg_out_ld(s, TCG_TYPE_I32, a0, a1, a2);
         break;
 
     OP_32_64(st8):
         if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvIz,
-                                 0, args[1], args[2]);
-            tcg_out8(s, args[0]);
+            tcg_out_modrm_offset(s, OPC_MOVB_EvIz, 0, a1, a2);
+            tcg_out8(s, a0);
         } else {
-            tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R,
-                                 args[0], args[1], args[2]);
+            tcg_out_modrm_offset(s, OPC_MOVB_EvGv | P_REXB_R, a0, a1, a2);
         }
         break;
     OP_32_64(st16):
         if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16,
-                                 0, args[1], args[2]);
-            tcg_out16(s, args[0]);
+            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_DATA16, 0, a1, a2);
+            tcg_out16(s, a0);
         } else {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16,
-                                 args[0], args[1], args[2]);
+            tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_DATA16, a0, a1, a2);
         }
         break;
 #if TCG_TARGET_REG_BITS == 64
@@ -1878,19 +1881,18 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #endif
     case INDEX_op_st_i32:
         if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz, 0, args[1], args[2]);
-            tcg_out32(s, args[0]);
+            tcg_out_modrm_offset(s, OPC_MOVL_EvIz, 0, a1, a2);
+            tcg_out32(s, a0);
         } else {
-            tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
+            tcg_out_st(s, TCG_TYPE_I32, a0, a1, a2);
         }
         break;
 
     OP_32_64(add):
         /* For 3-operand addition, use LEA.  */
-        if (args[0] != args[1]) {
-            TCGArg a0 = args[0], a1 = args[1], a2 = args[2], c3 = 0;
-
-            if (const_args[2]) {
+        if (a0 != a1) {
+            TCGArg c3 = 0;
+            if (const_a2) {
                 c3 = a2, a2 = -1;
             } else if (a0 == a2) {
                 /* Watch out for dest = src + dest, since we've removed
@@ -1917,36 +1919,35 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         c = ARITH_XOR;
         goto gen_arith;
     gen_arith:
-        if (const_args[2]) {
-            tgen_arithi(s, c + rexw, args[0], args[2], 0);
+        if (const_a2) {
+            tgen_arithi(s, c + rexw, a0, a2, 0);
         } else {
-            tgen_arithr(s, c + rexw, args[0], args[2]);
+            tgen_arithr(s, c + rexw, a0, a2);
         }
         break;
 
     OP_32_64(andc):
-        if (const_args[2]) {
-            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32,
-                        args[0], args[1]);
-            tgen_arithi(s, ARITH_AND + rexw, args[0], ~args[2], 0);
+        if (const_a2) {
+            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
+            tgen_arithi(s, ARITH_AND + rexw, a0, ~a2, 0);
         } else {
-            tcg_out_vex_modrm(s, OPC_ANDN + rexw, args[0], args[2], args[1]);
+            tcg_out_vex_modrm(s, OPC_ANDN + rexw, a0, a2, a1);
         }
         break;
 
     OP_32_64(mul):
-        if (const_args[2]) {
+        if (const_a2) {
             int32_t val;
-            val = args[2];
+            val = a2;
             if (val == (int8_t)val) {
-                tcg_out_modrm(s, OPC_IMUL_GvEvIb + rexw, args[0], args[0]);
+                tcg_out_modrm(s, OPC_IMUL_GvEvIb + rexw, a0, a0);
                 tcg_out8(s, val);
             } else {
-                tcg_out_modrm(s, OPC_IMUL_GvEvIz + rexw, args[0], args[0]);
+                tcg_out_modrm(s, OPC_IMUL_GvEvIz + rexw, a0, a0);
                 tcg_out32(s, val);
             }
         } else {
-            tcg_out_modrm(s, OPC_IMUL_GvEv + rexw, args[0], args[2]);
+            tcg_out_modrm(s, OPC_IMUL_GvEv + rexw, a0, a2);
         }
         break;
 
@@ -1976,57 +1977,54 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         c = SHIFT_ROR;
         goto gen_shift;
     gen_shift_maybe_vex:
-        if (have_bmi2 && !const_args[2]) {
-            tcg_out_vex_modrm(s, vexop + rexw, args[0], args[2], args[1]);
+        if (have_bmi2 && !const_a2) {
+            tcg_out_vex_modrm(s, vexop + rexw, a0, a2, a1);
             break;
         }
         /* FALLTHRU */
     gen_shift:
-        if (const_args[2]) {
-            tcg_out_shifti(s, c + rexw, args[0], args[2]);
+        if (const_a2) {
+            tcg_out_shifti(s, c + rexw, a0, a2);
         } else {
-            tcg_out_modrm(s, OPC_SHIFT_cl + rexw, c, args[0]);
+            tcg_out_modrm(s, OPC_SHIFT_cl + rexw, c, a0);
         }
         break;
 
     case INDEX_op_brcond_i32:
-        tcg_out_brcond32(s, args[2], args[0], args[1], const_args[1],
-                         arg_label(args[3]), 0);
+        tcg_out_brcond32(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
         break;
     case INDEX_op_setcond_i32:
-        tcg_out_setcond32(s, args[3], args[0], args[1],
-                          args[2], const_args[2]);
+        tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
         break;
     case INDEX_op_movcond_i32:
-        tcg_out_movcond32(s, args[5], args[0], args[1],
-                          args[2], const_args[2], args[3]);
+        tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
     OP_32_64(bswap16):
-        tcg_out_rolw_8(s, args[0]);
+        tcg_out_rolw_8(s, a0);
         break;
     OP_32_64(bswap32):
-        tcg_out_bswap32(s, args[0]);
+        tcg_out_bswap32(s, a0);
         break;
 
     OP_32_64(neg):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, args[0]);
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
         break;
     OP_32_64(not):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, args[0]);
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
 
     OP_32_64(ext8s):
-        tcg_out_ext8s(s, args[0], args[1], rexw);
+        tcg_out_ext8s(s, a0, a1, rexw);
         break;
     OP_32_64(ext16s):
-        tcg_out_ext16s(s, args[0], args[1], rexw);
+        tcg_out_ext16s(s, a0, a1, rexw);
         break;
     OP_32_64(ext8u):
-        tcg_out_ext8u(s, args[0], args[1]);
+        tcg_out_ext8u(s, a0, a1);
         break;
     OP_32_64(ext16u):
-        tcg_out_ext16u(s, args[0], args[1]);
+        tcg_out_ext16u(s, a0, a1);
         break;
 
     case INDEX_op_qemu_ld_i32:
@@ -2050,26 +2048,26 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     OP_32_64(add2):
         if (const_args[4]) {
-            tgen_arithi(s, ARITH_ADD + rexw, args[0], args[4], 1);
+            tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
         } else {
-            tgen_arithr(s, ARITH_ADD + rexw, args[0], args[4]);
+            tgen_arithr(s, ARITH_ADD + rexw, a0, args[4]);
         }
         if (const_args[5]) {
-            tgen_arithi(s, ARITH_ADC + rexw, args[1], args[5], 1);
+            tgen_arithi(s, ARITH_ADC + rexw, a1, args[5], 1);
         } else {
-            tgen_arithr(s, ARITH_ADC + rexw, args[1], args[5]);
+            tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
         }
         break;
     OP_32_64(sub2):
         if (const_args[4]) {
-            tgen_arithi(s, ARITH_SUB + rexw, args[0], args[4], 1);
+            tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
         } else {
-            tgen_arithr(s, ARITH_SUB + rexw, args[0], args[4]);
+            tgen_arithr(s, ARITH_SUB + rexw, a0, args[4]);
         }
         if (const_args[5]) {
-            tgen_arithi(s, ARITH_SBB + rexw, args[1], args[5], 1);
+            tgen_arithi(s, ARITH_SBB + rexw, a1, args[5], 1);
         } else {
-            tgen_arithr(s, ARITH_SBB + rexw, args[1], args[5]);
+            tgen_arithr(s, ARITH_SBB + rexw, a1, args[5]);
         }
         break;
 
@@ -2082,68 +2080,63 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 #else /* TCG_TARGET_REG_BITS == 64 */
     case INDEX_op_ld32s_i64:
-        tcg_out_modrm_offset(s, OPC_MOVSLQ, args[0], args[1], args[2]);
+        tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
         break;
     case INDEX_op_ld_i64:
-        tcg_out_ld(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+        tcg_out_ld(s, TCG_TYPE_I64, a0, a1, a2);
         break;
     case INDEX_op_st_i64:
         if (const_args[0]) {
-            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW,
-                                 0, args[1], args[2]);
-            tcg_out32(s, args[0]);
+            tcg_out_modrm_offset(s, OPC_MOVL_EvIz | P_REXW, 0, a1, a2);
+            tcg_out32(s, a0);
         } else {
-            tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
+            tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
         }
         break;
 
     case INDEX_op_brcond_i64:
-        tcg_out_brcond64(s, args[2], args[0], args[1], const_args[1],
-                         arg_label(args[3]), 0);
+        tcg_out_brcond64(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
         break;
     case INDEX_op_setcond_i64:
-        tcg_out_setcond64(s, args[3], args[0], args[1],
-                          args[2], const_args[2]);
+        tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
         break;
     case INDEX_op_movcond_i64:
-        tcg_out_movcond64(s, args[5], args[0], args[1],
-                          args[2], const_args[2], args[3]);
+        tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
     case INDEX_op_bswap64_i64:
-        tcg_out_bswap64(s, args[0]);
+        tcg_out_bswap64(s, a0);
         break;
     case INDEX_op_extu_i32_i64:
     case INDEX_op_ext32u_i64:
-        tcg_out_ext32u(s, args[0], args[1]);
+        tcg_out_ext32u(s, a0, a1);
         break;
     case INDEX_op_ext_i32_i64:
     case INDEX_op_ext32s_i64:
-        tcg_out_ext32s(s, args[0], args[1]);
+        tcg_out_ext32s(s, a0, a1);
         break;
 #endif
 
     OP_32_64(deposit):
         if (args[3] == 0 && args[4] == 8) {
             /* load bits 0..7 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM,
-                          args[2], args[0]);
+            tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
         } else if (args[3] == 8 && args[4] == 8) {
             /* load bits 8..15 */
-            tcg_out_modrm(s, OPC_MOVB_EvGv, args[2], args[0] + 4);
+            tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
         } else if (args[3] == 0 && args[4] == 16) {
             /* load bits 0..15 */
-            tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, args[2], args[0]);
+            tcg_out_modrm(s, OPC_MOVL_EvGv | P_DATA16, a2, a0);
         } else {
             tcg_abort();
         }
         break;
 
     case INDEX_op_extract_i64:
-        if (args[2] + args[3] == 32) {
+        if (a2 + args[3] == 32) {
             /* This is a 32-bit zero-extending right shift.  */
-            tcg_out_mov(s, TCG_TYPE_I32, args[0], args[1]);
-            tcg_out_shifti(s, SHIFT_SHR, args[0], args[2]);
+            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+            tcg_out_shifti(s, SHIFT_SHR, a0, a2);
             break;
         }
         /* FALLTHRU */
@@ -2151,12 +2144,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* On the off-chance that we can use the high-byte registers.
            Otherwise we emit the same ext16 + shift pattern that we
            would have gotten from the normal tcg-op.c expansion.  */
-        tcg_debug_assert(args[2] == 8 && args[3] == 8);
-        if (args[1] < 4 && args[0] < 8) {
-            tcg_out_modrm(s, OPC_MOVZBL, args[0], args[1] + 4);
+        tcg_debug_assert(a2 == 8 && args[3] == 8);
+        if (a1 < 4 && a0 < 8) {
+            tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
         } else {
-            tcg_out_ext16u(s, args[0], args[1]);
-            tcg_out_shifti(s, SHIFT_SHR, args[0], 8);
+            tcg_out_ext16u(s, a0, a1);
+            tcg_out_shifti(s, SHIFT_SHR, a0, 8);
         }
         break;
 
@@ -2164,17 +2157,17 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* We don't implement sextract_i64, as we cannot sign-extend to
            64-bits without using the REX prefix that explicitly excludes
            access to the high-byte registers.  */
-        tcg_debug_assert(args[2] == 8 && args[3] == 8);
-        if (args[1] < 4 && args[0] < 8) {
-            tcg_out_modrm(s, OPC_MOVSBL, args[0], args[1] + 4);
+        tcg_debug_assert(a2 == 8 && args[3] == 8);
+        if (a1 < 4 && a0 < 8) {
+            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
         } else {
-            tcg_out_ext16s(s, args[0], args[1], 0);
-            tcg_out_shifti(s, SHIFT_SAR, args[0], 8);
+            tcg_out_ext16s(s, a0, a1, 0);
+            tcg_out_shifti(s, SHIFT_SAR, a0, 8);
         }
         break;
 
     case INDEX_op_mb:
-        tcg_out_mb(s, args[0]);
+        tcg_out_mb(s, a0);
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-- 
2.9.3
