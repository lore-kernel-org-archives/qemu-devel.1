Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJq-00034K-So
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJp-00036Z-H2
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cSKJp-00036J-7R
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 14 Jan 2017 10:07:50 +0100
Message-Id: <1484384878-29179-2-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
References: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 1/9] target-m68k: Implement bitfield ops for
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478699171-10637-5-git-send-email-rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5329317..1487914 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3504,6 +3504,210 @@ DISAS_INSN(rotate_mem)
     set_cc_op(s, CC_OP_FLAGS);
 }
 
+DISAS_INSN(bfext_reg)
+{
+    int ext = read_im16(env, s);
+    int is_sign = insn & 0x200;
+    TCGv src = DREG(insn, 0);
+    TCGv dst = DREG(ext, 12);
+    int len = ((extract32(ext, 0, 5) - 1) & 31) + 1;
+    int ofs = extract32(ext, 6, 5);  /* big bit-endian */
+    int pos = 32 - ofs - len;        /* little bit-endian */
+    TCGv tmp = tcg_temp_new();
+    TCGv shift;
+
+    /* In general, we're going to rotate the field so that it's at the
+       top of the word and then right-shift by the compliment of the
+       width to extend the field.  */
+    if (ext & 0x20) {
+        /* Variable width.  */
+        if (ext & 0x800) {
+            /* Variable offset.  */
+            tcg_gen_andi_i32(tmp, DREG(ext, 6), 31);
+            tcg_gen_rotl_i32(tmp, src, tmp);
+        } else {
+            tcg_gen_rotli_i32(tmp, src, ofs);
+        }
+
+        shift = tcg_temp_new();
+        tcg_gen_neg_i32(shift, DREG(ext, 0));
+        tcg_gen_andi_i32(shift, shift, 31);
+        tcg_gen_sar_i32(QREG_CC_N, tmp, shift);
+        if (is_sign) {
+            tcg_gen_mov_i32(dst, QREG_CC_N);
+        } else {
+            tcg_gen_shr_i32(dst, tmp, shift);
+        }
+        tcg_temp_free(shift);
+    } else {
+        /* Immediate width.  */
+        if (ext & 0x800) {
+            /* Variable offset */
+            tcg_gen_andi_i32(tmp, DREG(ext, 6), 31);
+            tcg_gen_rotl_i32(tmp, src, tmp);
+            src = tmp;
+            pos = 32 - len;
+        } else {
+            /* Immediate offset.  If the field doesn't wrap around the
+               end of the word, rely on (s)extract completely.  */
+            if (pos < 0) {
+                tcg_gen_rotli_i32(tmp, src, ofs);
+                src = tmp;
+                pos = 32 - len;
+            }
+        }
+
+        tcg_gen_sextract_i32(QREG_CC_N, src, pos, len);
+        if (is_sign) {
+            tcg_gen_mov_i32(dst, QREG_CC_N);
+        } else {
+            tcg_gen_extract_i32(dst, src, pos, len);
+        }
+    }
+
+    tcg_temp_free(tmp);
+    set_cc_op(s, CC_OP_LOGIC);
+}
+
+DISAS_INSN(bfop_reg)
+{
+    int ext = read_im16(env, s);
+    TCGv src = DREG(insn, 0);
+    int len = ((extract32(ext, 0, 5) - 1) & 31) + 1;
+    int ofs = extract32(ext, 6, 5);  /* big bit-endian */
+    TCGv mask;
+
+    if ((ext & 0x820) == 0) {
+        /* Immediate width and offset.  */
+        uint32_t maski = 0x7fffffffu >> (len - 1);
+        if (ofs + len <= 32) {
+            tcg_gen_shli_i32(QREG_CC_N, src, ofs);
+        } else {
+            tcg_gen_rotli_i32(QREG_CC_N, src, ofs);
+        }
+        tcg_gen_andi_i32(QREG_CC_N, QREG_CC_N, ~maski);
+        mask = tcg_const_i32(ror32(maski, ofs));
+    } else {
+        TCGv tmp = tcg_temp_new();
+        if (ext & 0x20) {
+            /* Variable width */
+            tcg_gen_subi_i32(tmp, DREG(ext, 0), 1);
+            tcg_gen_andi_i32(tmp, tmp, 31);
+            mask = tcg_const_i32(0x7fffffffu);
+            tcg_gen_shr_i32(mask, mask, tmp);
+        } else {
+            /* Immediate width */
+            mask = tcg_const_i32(0x7fffffffu >> (len - 1));
+        }
+        if (ext & 0x800) {
+            /* Variable offset */
+            tcg_gen_andi_i32(tmp, DREG(ext, 6), 31);
+            tcg_gen_rotl_i32(QREG_CC_N, src, tmp);
+            tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
+            tcg_gen_rotr_i32(mask, mask, tmp);
+        } else {
+            /* Immediate offset (and variable width) */
+            tcg_gen_rotli_i32(QREG_CC_N, src, ofs);
+            tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
+            tcg_gen_rotri_i32(mask, mask, ofs);
+        }
+        tcg_temp_free(tmp);
+    }
+    set_cc_op(s, CC_OP_LOGIC);
+
+    switch (insn & 0x0f00) {
+    case 0x0a00: /* bfchg */
+        tcg_gen_eqv_i32(src, src, mask);
+        break;
+    case 0x0c00: /* bfclr */
+        tcg_gen_and_i32(src, src, mask);
+        break;
+    case 0x0e00: /* bfset */
+        tcg_gen_orc_i32(src, src, mask);
+        break;
+    case 0x0800: /* bftst */
+        /* flags already set; no other work to do.  */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_temp_free(mask);
+}
+
+DISAS_INSN(bfins_reg)
+{
+    int ext = read_im16(env, s);
+    TCGv dst = DREG(insn, 0);
+    TCGv src = DREG(ext, 12);
+    int len = ((extract32(ext, 0, 5) - 1) & 31) + 1;
+    int ofs = extract32(ext, 6, 5);  /* big bit-endian */
+    int pos = 32 - ofs - len;        /* little bit-endian */
+    TCGv tmp;
+
+    tmp = tcg_temp_new();
+
+    if (ext & 0x20) {
+        /* Variable width */
+        tcg_gen_neg_i32(tmp, DREG(ext, 0));
+        tcg_gen_andi_i32(tmp, tmp, 31);
+        tcg_gen_shl_i32(QREG_CC_N, src, tmp);
+    } else {
+        /* Immediate width */
+        tcg_gen_shli_i32(QREG_CC_N, src, 32 - len);
+    }
+    set_cc_op(s, CC_OP_LOGIC);
+
+    /* Immediate width and offset */
+    if ((ext & 0x820) == 0) {
+        /* Check for suitability for deposit.  */
+        if (pos >= 0) {
+            tcg_gen_deposit_i32(dst, dst, src, pos, len);
+        } else {
+            uint32_t maski = -2U << (len - 1);
+            uint32_t roti = (ofs + len) & 31;
+            tcg_gen_andi_i32(tmp, src, ~maski);
+            tcg_gen_rotri_i32(tmp, tmp, roti);
+            tcg_gen_andi_i32(dst, dst, ror32(maski, roti));
+            tcg_gen_or_i32(dst, dst, tmp);
+        }
+    } else {
+        TCGv mask = tcg_temp_new();
+        TCGv rot = tcg_temp_new();
+
+        if (ext & 0x20) {
+            /* Variable width */
+            tcg_gen_subi_i32(rot, DREG(ext, 0), 1);
+            tcg_gen_andi_i32(rot, rot, 31);
+            tcg_gen_movi_i32(mask, -2);
+            tcg_gen_shl_i32(mask, mask, rot);
+            tcg_gen_mov_i32(rot, DREG(ext, 0));
+            tcg_gen_andc_i32(tmp, src, mask);
+        } else {
+            /* Immediate width (variable offset) */
+            uint32_t maski = -2U << (len - 1);
+            tcg_gen_andi_i32(tmp, src, ~maski);
+            tcg_gen_movi_i32(mask, maski);
+            tcg_gen_movi_i32(rot, len & 31);
+        }
+        if (ext & 0x800) {
+            /* Variable offset */
+            tcg_gen_add_i32(rot, rot, DREG(ext, 6));
+        } else {
+            /* Immediate offset (variable width) */
+            tcg_gen_addi_i32(rot, rot, ofs);
+        }
+        tcg_gen_andi_i32(rot, rot, 31);
+        tcg_gen_rotr_i32(mask, mask, rot);
+        tcg_gen_rotr_i32(tmp, tmp, rot);
+        tcg_gen_and_i32(dst, dst, mask);
+        tcg_gen_or_i32(dst, dst, tmp);
+
+        tcg_temp_free(rot);
+        tcg_temp_free(mask);
+    }
+    tcg_temp_free(tmp);
+}
+
 DISAS_INSN(ff1)
 {
     TCGv reg;
@@ -4595,6 +4799,12 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(rotate8_reg, e030, f0f0, M68000);
     INSN(rotate16_reg, e070, f0f0, M68000);
     INSN(rotate_mem, e4c0, fcc0, M68000);
+    INSN(bfext_reg, e9c0, fdf8, BITFIELD);  /* bfextu & bfexts */
+    INSN(bfins_reg, efc0, fff8, BITFIELD);
+    INSN(bfop_reg, eac0, fff8, BITFIELD);   /* bfchg */
+    INSN(bfop_reg, ecc0, fff8, BITFIELD);   /* bfclr */
+    INSN(bfop_reg, eec0, fff8, BITFIELD);   /* bfset */
+    INSN(bfop_reg, e8c0, fff8, BITFIELD);   /* bftst */
     INSN(undef_fpu, f000, f000, CF_ISA_A);
     INSN(fpu,       f200, ffc0, CF_FPU);
     INSN(fbcc,      f280, ffc0, CF_FPU);
-- 
2.7.4
