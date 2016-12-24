Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh0-0007Lw-0u
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgw-0007z6-R6
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:62775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgw-0007yd-Ej
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:46 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:32 +0100
Message-Id: <1482579633-3393-12-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/12] target-m68k: add rol/ror/roxl/roxr
 instructions
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
---
 target/m68k/translate.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 391 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 76c77ee..bb5a299 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3097,6 +3097,390 @@ DISAS_INSN(shift_mem)
     set_cc_op(s, CC_OP_FLAGS);
 }
 
+static void rotate(TCGv reg, TCGv shift, int left, int size)
+{
+    switch (size) {
+    case 8:
+        /* Replicate the 8-bit input so that a 32-bit rotate works.  */
+        tcg_gen_ext8u_i32(reg, reg);
+        tcg_gen_muli_i32(reg, reg, 0x01010101);
+        goto do_long;
+    case 16:
+        /* Replicate the 16-bit input so that a 32-bit rotate works.  */
+        tcg_gen_deposit_i32(reg, reg, reg, 16, 16);
+        goto do_long;
+    do_long:
+    default:
+        if (left) {
+            tcg_gen_rotl_i32(reg, reg, shift);
+        } else {
+            tcg_gen_rotr_i32(reg, reg, shift);
+        }
+    }
+
+    /* compute flags */
+
+    switch (size) {
+    case 8:
+        tcg_gen_ext8s_i32(reg, reg);
+        break;
+    case 16:
+        tcg_gen_ext16s_i32(reg, reg);
+        break;
+    default:
+        break;
+    }
+
+    /* QREG_CC_X is not affected */
+
+    tcg_gen_mov_i32(QREG_CC_N, reg);
+    tcg_gen_mov_i32(QREG_CC_Z, reg);
+
+    if (left) {
+        tcg_gen_andi_i32(QREG_CC_C, reg, 1);
+    } else {
+        tcg_gen_shri_i32(QREG_CC_C, reg, 31);
+    }
+
+    tcg_gen_movi_i32(QREG_CC_V, 0); /* always cleared */
+}
+
+static void rotate_x_flags(TCGv reg, TCGv X, int size)
+{
+    switch (size) {
+    case 8:
+        tcg_gen_ext8s_i32(reg, reg);
+        break;
+    case 16:
+        tcg_gen_ext16s_i32(reg, reg);
+        break;
+    default:
+        break;
+    }
+    tcg_gen_mov_i32(QREG_CC_N, reg);
+    tcg_gen_mov_i32(QREG_CC_Z, reg);
+    tcg_gen_mov_i32(QREG_CC_X, X);
+    tcg_gen_mov_i32(QREG_CC_C, X);
+    tcg_gen_movi_i32(QREG_CC_V, 0);
+}
+
+/* Result of rotate_x() is valid if 0 <= shift <= size */
+static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
+{
+    TCGv X, shl, shr, shx, sz, zero;
+
+    sz = tcg_const_i32(size);
+
+    shr = tcg_temp_new();
+    shl = tcg_temp_new();
+    shx = tcg_temp_new();
+    if (left) {
+        tcg_gen_mov_i32(shl, shift);      /* shl = shift */
+        tcg_gen_movi_i32(shr, size + 1);
+        tcg_gen_sub_i32(shr, shr, shift); /* shr = size + 1 - shift */
+        tcg_gen_subi_i32(shx, shift, 1);  /* shx = shift - 1 */
+        /* shx = shx < 0 ? size : shx; */
+        zero = tcg_const_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_LT, shx, shx, zero, sz, shx);
+        tcg_temp_free(zero);
+    } else {
+        tcg_gen_mov_i32(shr, shift);      /* shr = shift */
+        tcg_gen_movi_i32(shl, size + 1);
+        tcg_gen_sub_i32(shl, shl, shift); /* shl = size + 1 - shift */
+        tcg_gen_sub_i32(shx, sz, shift); /* shx = size - shift */
+    }
+
+    /* reg = (reg << shl) | (reg >> shr) | (x << shx); */
+
+    tcg_gen_shl_i32(shl, reg, shl);
+    tcg_gen_shr_i32(shr, reg, shr);
+    tcg_gen_or_i32(reg, shl, shr);
+    tcg_temp_free(shl);
+    tcg_temp_free(shr);
+    tcg_gen_shl_i32(shx, QREG_CC_X, shx);
+    tcg_gen_or_i32(reg, reg, shx);
+    tcg_temp_free(shx);
+
+    /* X = (reg >> size) & 1 */
+
+    X = tcg_temp_new();
+    tcg_gen_shr_i32(X, reg, sz);
+    tcg_gen_andi_i32(X, X, 1);
+    tcg_temp_free(sz);
+
+    return X;
+}
+
+/* Result of rotate32_x() is valid if 0 <= shift < 33 */
+static TCGv rotate32_x(TCGv reg, TCGv shift, int left)
+{
+    TCGv_i64 t0, shift64;
+    TCGv X, lo, hi, zero;
+
+    shift64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(shift64, shift);
+
+    t0 = tcg_temp_new_i64();
+
+    X = tcg_temp_new();
+    lo = tcg_temp_new();
+    hi = tcg_temp_new();
+
+    if (left) {
+        /* create [reg:X:..] */
+
+        tcg_gen_shli_i32(lo, QREG_CC_X, 31);
+        tcg_gen_concat_i32_i64(t0, lo, reg);
+
+        /* rotate */
+
+        tcg_gen_rotl_i64(t0, t0, shift64);
+        tcg_temp_free_i64(shift64);
+
+        /* result is [reg:..:reg:X] */
+
+        tcg_gen_extr_i64_i32(lo, hi, t0);
+        tcg_gen_andi_i32(X, lo, 1);
+
+        tcg_gen_shri_i32(lo, lo, 1);
+    } else {
+        /* create [..:X:reg] */
+
+        tcg_gen_concat_i32_i64(t0, reg, QREG_CC_X);
+
+        tcg_gen_rotr_i64(t0, t0, shift64);
+        tcg_temp_free_i64(shift64);
+
+        /* result is value: [X:reg:..:reg] */
+
+        tcg_gen_extr_i64_i32(lo, hi, t0);
+
+        /* extract X */
+
+        tcg_gen_shri_i32(X, hi, 31);
+
+        /* extract result */
+
+        tcg_gen_shli_i32(hi, hi, 1);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_gen_or_i32(lo, lo, hi);
+    tcg_temp_free(hi);
+
+    /* if shift == 0, register and X are not affected */
+
+    zero = tcg_const_i32(0);
+    tcg_gen_movcond_i32(TCG_COND_EQ, X, shift, zero, QREG_CC_X, X);
+    tcg_gen_movcond_i32(TCG_COND_EQ, reg, shift, zero, reg, lo);
+    tcg_temp_free(zero);
+    tcg_temp_free(lo);
+
+    return X;
+}
+
+DISAS_INSN(rotate_im)
+{
+    TCGv shift;
+    int tmp;
+    int left = (insn & 0x100);
+
+    tmp = (insn >> 9) & 7;
+    if (tmp == 0) {
+        tmp = 8;
+    }
+
+    shift = tcg_const_i32(tmp);
+    if (insn & 8) {
+        rotate(DREG(insn, 0), shift, left, 32);
+    } else {
+        TCGv X = rotate32_x(DREG(insn, 0), shift, left);
+        rotate_x_flags(DREG(insn, 0), X, 32);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(shift);
+
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate8_im)
+{
+    int left = (insn & 0x100);
+    TCGv reg;
+    TCGv shift;
+    int tmp;
+
+    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+
+    tmp = (insn >> 9) & 7;
+    if (tmp == 0) {
+        tmp = 8;
+    }
+
+    shift = tcg_const_i32(tmp);
+    if (insn & 8) {
+        rotate(reg, shift, left, 8);
+    } else {
+        TCGv X = rotate_x(reg, shift, left, 8);
+        rotate_x_flags(reg, X, 8);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(shift);
+    gen_partset_reg(OS_BYTE, DREG(insn, 0), reg);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate16_im)
+{
+    int left = (insn & 0x100);
+    TCGv reg;
+    TCGv shift;
+    int tmp;
+
+    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    tmp = (insn >> 9) & 7;
+    if (tmp == 0) {
+        tmp = 8;
+    }
+
+    shift = tcg_const_i32(tmp);
+    if (insn & 8) {
+        rotate(reg, shift, left, 16);
+    } else {
+        TCGv X = rotate_x(reg, shift, left, 16);
+        rotate_x_flags(reg, X, 16);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(shift);
+    gen_partset_reg(OS_WORD, DREG(insn, 0), reg);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate_reg)
+{
+    TCGv reg;
+    TCGv src;
+    TCGv t0, t1;
+    int left = (insn & 0x100);
+
+    reg = DREG(insn, 0);
+    src = DREG(insn, 9);
+    /* shift in [0..63] */
+    t0 = tcg_temp_new();
+    tcg_gen_andi_i32(t0, src, 63);
+    t1 = tcg_temp_new_i32();
+    if (insn & 8) {
+        tcg_gen_andi_i32(t1, src, 31);
+        rotate(reg, t1, left, 32);
+        /* if shift == 0, clear C */
+        tcg_gen_movcond_i32(TCG_COND_EQ, QREG_CC_C,
+                            t0, QREG_CC_V /* 0 */,
+                            QREG_CC_V /* 0 */, QREG_CC_C);
+    } else {
+        TCGv X;
+        /* modulo 33 */
+        tcg_gen_movi_i32(t1, 33);
+        tcg_gen_remu_i32(t1, t0, t1);
+        X = rotate32_x(DREG(insn, 0), t1, left);
+        rotate_x_flags(DREG(insn, 0), X, 32);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(t1);
+    tcg_temp_free(t0);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate8_reg)
+{
+    TCGv reg;
+    TCGv src;
+    TCGv t0, t1;
+    int left = (insn & 0x100);
+
+    reg = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    src = DREG(insn, 9);
+    /* shift in [0..63] */
+    t0 = tcg_temp_new_i32();
+    tcg_gen_andi_i32(t0, src, 63);
+    t1 = tcg_temp_new_i32();
+    if (insn & 8) {
+        tcg_gen_andi_i32(t1, src, 7);
+        rotate(reg, t1, left, 8);
+        /* if shift == 0, clear C */
+        tcg_gen_movcond_i32(TCG_COND_EQ, QREG_CC_C,
+                            t0, QREG_CC_V /* 0 */,
+                            QREG_CC_V /* 0 */, QREG_CC_C);
+    } else {
+        TCGv X;
+        /* modulo 9 */
+        tcg_gen_movi_i32(t1, 9);
+        tcg_gen_remu_i32(t1, t0, t1);
+        X = rotate_x(reg, t1, left, 8);
+        rotate_x_flags(reg, X, 8);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(t1);
+    tcg_temp_free(t0);
+    gen_partset_reg(OS_BYTE, DREG(insn, 0), reg);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate16_reg)
+{
+    TCGv reg;
+    TCGv src;
+    TCGv t0, t1;
+    int left = (insn & 0x100);
+
+    reg = gen_extend(DREG(insn, 0), OS_WORD, 0);
+    src = DREG(insn, 9);
+    /* shift in [0..63] */
+    t0 = tcg_temp_new_i32();
+    tcg_gen_andi_i32(t0, src, 63);
+    t1 = tcg_temp_new_i32();
+    if (insn & 8) {
+        tcg_gen_andi_i32(t1, src, 15);
+        rotate(reg, t1, left, 16);
+        /* if shift == 0, clear C */
+        tcg_gen_movcond_i32(TCG_COND_EQ, QREG_CC_C,
+                            t0, QREG_CC_V /* 0 */,
+                            QREG_CC_V /* 0 */, QREG_CC_C);
+    } else {
+        TCGv X;
+        /* modulo 17 */
+        tcg_gen_movi_i32(t1, 17);
+        tcg_gen_remu_i32(t1, t0, t1);
+        X = rotate_x(reg, t1, left, 16);
+        rotate_x_flags(reg, X, 16);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(t1);
+    tcg_temp_free(t0);
+    gen_partset_reg(OS_WORD, DREG(insn, 0), reg);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+DISAS_INSN(rotate_mem)
+{
+    TCGv src;
+    TCGv addr;
+    TCGv shift;
+    int left = (insn & 0x100);
+
+    SRC_EA(env, src, OS_WORD, 0, &addr);
+
+    shift = tcg_const_i32(1);
+    if (insn & 0x0200) {
+        rotate(src, shift, left, 16);
+    } else {
+        TCGv X = rotate_x(src, shift, left, 16);
+        rotate_x_flags(src, X, 16);
+        tcg_temp_free(X);
+    }
+    tcg_temp_free(shift);
+    DEST_EA(env, insn, OS_WORD, src, &addr);
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
 DISAS_INSN(ff1)
 {
     TCGv reg;
@@ -4181,6 +4565,13 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(shift16_reg, e060, f0f0, M68000);
     INSN(shift_reg, e0a0, f0f0, M68000);
     INSN(shift_mem, e0c0, fcc0, M68000);
+    INSN(rotate_im, e090, f0f0, M68000);
+    INSN(rotate8_im, e010, f0f0, M68000);
+    INSN(rotate16_im, e050, f0f0, M68000);
+    INSN(rotate_reg, e0b0, f0f0, M68000);
+    INSN(rotate8_reg, e030, f0f0, M68000);
+    INSN(rotate16_reg, e070, f0f0, M68000);
+    INSN(rotate_mem, e4c0, fcc0, M68000);
     INSN(undef_fpu, f000, f000, CF_ISA_A);
     INSN(fpu,       f200, ffc0, CF_FPU);
     INSN(fbcc,      f280, ffc0, CF_FPU);
-- 
2.7.4
