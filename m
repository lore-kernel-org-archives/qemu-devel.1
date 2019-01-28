Received: from eggs.gnu.org ([209.51.188.92]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jj-0004sV-B7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jh-0007jc-DD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:23 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:37800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9Jh-0007jK-4m
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:21 -0500
Received: by mail-pg1-x534.google.com with SMTP id c25so7390876pgb.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:50 -0800
Message-Id: <20190128155907.20607-7-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/23] tcg/i386: Split subroutines out of
 tcg_expand_vec_op
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

This routine was becoming too large.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 459 +++++++++++++++++++-------------------
 1 file changed, 232 insertions(+), 227 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1b4e3b80e1..6f4c16326f 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3079,253 +3079,258 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
+static void expand_vec_shi(TCGType type, unsigned vece, bool shr,
+                           TCGv_vec v0, TCGv_vec v1, TCGArg imm)
+{
+    TCGv_vec t1, t2;
+
+    tcg_debug_assert(vece == MO_8);
+
+    t1 = tcg_temp_new_vec(type);
+    t2 = tcg_temp_new_vec(type);
+
+    /* Unpack to W, shift, and repack.  Tricky bits:
+       (1) Use punpck*bw x,x to produce DDCCBBAA,
+           i.e. duplicate in other half of the 16-bit lane.
+       (2) For right-shift, add 8 so that the high half of
+           the lane becomes zero.  For left-shift, we must
+           shift up and down again.
+       (3) Step 2 leaves high half zero such that PACKUSWB
+           (pack with unsigned saturation) does not modify
+           the quantity.  */
+    vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+              tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
+    vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+              tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
+
+    if (shr) {
+        tcg_gen_shri_vec(MO_16, t1, t1, imm + 8);
+        tcg_gen_shri_vec(MO_16, t2, t2, imm + 8);
+    } else {
+        tcg_gen_shli_vec(MO_16, t1, t1, imm + 8);
+        tcg_gen_shli_vec(MO_16, t2, t2, imm + 8);
+        tcg_gen_shri_vec(MO_16, t1, t1, 8);
+        tcg_gen_shri_vec(MO_16, t2, t2, 8);
+    }
+
+    vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+              tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t2);
+}
+
+static void expand_vec_sari(TCGType type, unsigned vece,
+                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
+{
+    TCGv_vec t1, t2;
+
+    switch (vece) {
+    case MO_8:
+        /* Unpack to W, shift, and repack, as in expand_vec_shi.  */
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+                  tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
+        tcg_gen_sari_vec(MO_16, t1, t1, imm + 8);
+        tcg_gen_sari_vec(MO_16, t2, t2, imm + 8);
+        vec_gen_3(INDEX_op_x86_packss_vec, type, MO_8,
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
+    case MO_64:
+        if (imm <= 32) {
+            /* We can emulate a small sign extend by performing an arithmetic
+             * 32-bit shift and overwriting the high half of a 64-bit logical
+             * shift (note that the ISA says shift of 32 is valid).
+             */
+            t1 = tcg_temp_new_vec(type);
+            tcg_gen_sari_vec(MO_32, t1, v1, imm);
+            tcg_gen_shri_vec(MO_64, v0, v1, imm);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      tcgv_vec_arg(v0), tcgv_vec_arg(v0),
+                      tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+        } else {
+            /* Otherwise we will need to use a compare vs 0 to produce
+             * the sign-extend, shift and merge.
+             */
+            t1 = tcg_const_zeros_vec(type);
+            tcg_gen_cmp_vec(TCG_COND_GT, MO_64, t1, t1, v1);
+            tcg_gen_shri_vec(MO_64, v0, v1, imm);
+            tcg_gen_shli_vec(MO_64, t1, t1, 64 - imm);
+            tcg_gen_or_vec(MO_64, v0, v0, t1);
+            tcg_temp_free_vec(t1);
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void expand_vec_mul(TCGType type, unsigned vece,
+                           TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
+{
+    TCGv_vec t1, t2, t3, t4;
+
+    tcg_debug_assert(vece == MO_8);
+
+    /*
+     * Unpack v1 bytes to words, 0 | x.
+     * Unpack v2 bytes to words, y | 0.
+     * This leaves the 8-bit result, x * y, with 8 bits of right padding.
+     * Shift logical right by 8 bits to clear the high 8 bytes before
+     * using an unsigned saturated pack.
+     *
+     * The difference between the V64, V128 and V256 cases is merely how
+     * we distribute the expansion between temporaries.
+     */
+    switch (type) {
+    case TCG_TYPE_V64:
+        t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+        t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+        tcg_gen_dup16i_vec(t2, 0);
+        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
+        vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
+                  tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
+        tcg_gen_mul_vec(MO_16, t1, t1, t2);
+        tcg_gen_shri_vec(MO_16, t1, t1, 8);
+        vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        t3 = tcg_temp_new_vec(type);
+        t4 = tcg_temp_new_vec(type);
+        tcg_gen_dup16i_vec(t4, 0);
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
+                  tcgv_vec_arg(t2), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
+                  tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+        tcg_gen_mul_vec(MO_16, t1, t1, t2);
+        tcg_gen_mul_vec(MO_16, t3, t3, t4);
+        tcg_gen_shri_vec(MO_16, t1, t1, 8);
+        tcg_gen_shri_vec(MO_16, t3, t3, 8);
+        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        tcg_temp_free_vec(t3);
+        tcg_temp_free_vec(t4);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGv_vec v2, TCGCond cond)
+{
+    enum {
+        NEED_SWAP = 1,
+        NEED_INV  = 2,
+        NEED_BIAS = 4
+    };
+    static const uint8_t fixups[16] = {
+        [0 ... 15] = -1,
+        [TCG_COND_EQ] = 0,
+        [TCG_COND_NE] = NEED_INV,
+        [TCG_COND_GT] = 0,
+        [TCG_COND_LT] = NEED_SWAP,
+        [TCG_COND_LE] = NEED_INV,
+        [TCG_COND_GE] = NEED_SWAP | NEED_INV,
+        [TCG_COND_GTU] = NEED_BIAS,
+        [TCG_COND_LTU] = NEED_BIAS | NEED_SWAP,
+        [TCG_COND_LEU] = NEED_BIAS | NEED_INV,
+        [TCG_COND_GEU] = NEED_BIAS | NEED_SWAP | NEED_INV,
+    };
+    TCGv_vec t1, t2;
+    uint8_t fixup;
+
+    fixup = fixups[cond & 15];
+    tcg_debug_assert(fixup != 0xff);
+
+    if (fixup & NEED_INV) {
+        cond = tcg_invert_cond(cond);
+    }
+    if (fixup & NEED_SWAP) {
+        t1 = v1, v1 = v2, v2 = t1;
+        cond = tcg_swap_cond(cond);
+    }
+
+    t1 = t2 = NULL;
+    if (fixup & NEED_BIAS) {
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
+        tcg_gen_sub_vec(vece, t1, v1, t2);
+        tcg_gen_sub_vec(vece, t2, v2, t2);
+        v1 = t1;
+        v2 = t2;
+        cond = tcg_signed_cond(cond);
+    }
+
+    tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
+    /* Expand directly; do not recurse.  */
+    vec_gen_4(INDEX_op_cmp_vec, type, vece,
+              tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v2), cond);
+
+    if (t1) {
+        tcg_temp_free_vec(t1);
+        if (t2) {
+            tcg_temp_free_vec(t2);
+        }
+    }
+    if (fixup & NEED_INV) {
+        tcg_gen_not_vec(vece, v0, v0);
+    }
+}
+
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGArg a1, a2;
-    TCGv_vec v0, t1, t2, t3, t4;
+    TCGArg a2;
+    TCGv_vec v0, v1, v2;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
 
     switch (opc) {
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
-        tcg_debug_assert(vece == MO_8);
-        a1 = va_arg(va, TCGArg);
-        a2 = va_arg(va, TCGArg);
-        /* Unpack to W, shift, and repack.  Tricky bits:
-           (1) Use punpck*bw x,x to produce DDCCBBAA,
-               i.e. duplicate in other half of the 16-bit lane.
-           (2) For right-shift, add 8 so that the high half of
-               the lane becomes zero.  For left-shift, we must
-               shift up and down again.
-           (3) Step 2 leaves high half zero such that PACKUSWB
-               (pack with unsigned saturation) does not modify
-               the quantity.  */
-        t1 = tcg_temp_new_vec(type);
-        t2 = tcg_temp_new_vec(type);
-        vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                  tcgv_vec_arg(t1), a1, a1);
-        vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                  tcgv_vec_arg(t2), a1, a1);
-        if (opc == INDEX_op_shri_vec) {
-            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
-                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
-            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
-                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
-        } else {
-            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
-                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
-            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
-                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
-            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
-                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), 8);
-            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
-                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), 8);
-        }
-        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
-                 a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
-        tcg_temp_free_vec(t1);
-        tcg_temp_free_vec(t2);
+        expand_vec_shi(type, vece, opc == INDEX_op_shri_vec, v0, v1, a2);
         break;
 
     case INDEX_op_sari_vec:
-        a1 = va_arg(va, TCGArg);
-        a2 = va_arg(va, TCGArg);
-        if (vece == MO_8) {
-            /* Unpack to W, shift, and repack, as above.  */
-            t1 = tcg_temp_new_vec(type);
-            t2 = tcg_temp_new_vec(type);
-            vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                      tcgv_vec_arg(t1), a1, a1);
-            vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                      tcgv_vec_arg(t2), a1, a1);
-            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
-                      tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
-            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
-                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
-            vec_gen_3(INDEX_op_x86_packss_vec, type, MO_8,
-                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
-            tcg_temp_free_vec(t1);
-            tcg_temp_free_vec(t2);
-            break;
-        }
-        tcg_debug_assert(vece == MO_64);
-        /* MO_64: If the shift is <= 32, we can emulate the sign extend by
-           performing an arithmetic 32-bit shift and overwriting the high
-           half of the result (note that the ISA says shift of 32 is valid). */
-        if (a2 <= 32) {
-            t1 = tcg_temp_new_vec(type);
-            vec_gen_3(INDEX_op_sari_vec, type, MO_32, tcgv_vec_arg(t1), a1, a2);
-            vec_gen_3(INDEX_op_shri_vec, type, MO_64, a0, a1, a2);
-            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
-                      a0, a0, tcgv_vec_arg(t1), 0xaa);
-            tcg_temp_free_vec(t1);
-            break;
-        }
-        /* Otherwise we will need to use a compare vs 0 to produce the
-           sign-extend, shift and merge.  */
-        t1 = tcg_temp_new_vec(type);
-        t2 = tcg_const_zeros_vec(type);
-        vec_gen_4(INDEX_op_cmp_vec, type, MO_64,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(t2), a1, TCG_COND_GT);
-        tcg_temp_free_vec(t2);
-        vec_gen_3(INDEX_op_shri_vec, type, MO_64, a0, a1, a2);
-        vec_gen_3(INDEX_op_shli_vec, type, MO_64,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(t1), 64 - a2);
-        vec_gen_3(INDEX_op_or_vec, type, MO_64, a0, a0, tcgv_vec_arg(t1));
-        tcg_temp_free_vec(t1);
+        expand_vec_sari(type, vece, v0, v1, a2);
         break;
 
     case INDEX_op_mul_vec:
-        tcg_debug_assert(vece == MO_8);
-        a1 = va_arg(va, TCGArg);
-        a2 = va_arg(va, TCGArg);
-        switch (type) {
-        case TCG_TYPE_V64:
-            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
-            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
-            tcg_gen_dup16i_vec(t2, 0);
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t2));
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2);
-            tcg_gen_mul_vec(MO_16, t1, t1, t2);
-            tcg_gen_shri_vec(MO_16, t1, t1, 8);
-            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
-                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
-            tcg_temp_free_vec(t1);
-            tcg_temp_free_vec(t2);
-            break;
-
-        case TCG_TYPE_V128:
-            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
-            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
-            t3 = tcg_temp_new_vec(TCG_TYPE_V128);
-            t4 = tcg_temp_new_vec(TCG_TYPE_V128);
-            tcg_gen_dup16i_vec(t4, 0);
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
-            vec_gen_3(INDEX_op_x86_punpckh_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
-            vec_gen_3(INDEX_op_x86_punpckh_vec, TCG_TYPE_V128, MO_8,
-                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
-            tcg_gen_mul_vec(MO_16, t1, t1, t2);
-            tcg_gen_mul_vec(MO_16, t3, t3, t4);
-            tcg_gen_shri_vec(MO_16, t1, t1, 8);
-            tcg_gen_shri_vec(MO_16, t3, t3, 8);
-            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
-                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
-            tcg_temp_free_vec(t1);
-            tcg_temp_free_vec(t2);
-            tcg_temp_free_vec(t3);
-            tcg_temp_free_vec(t4);
-            break;
-
-        case TCG_TYPE_V256:
-            t1 = tcg_temp_new_vec(TCG_TYPE_V256);
-            t2 = tcg_temp_new_vec(TCG_TYPE_V256);
-            t3 = tcg_temp_new_vec(TCG_TYPE_V256);
-            t4 = tcg_temp_new_vec(TCG_TYPE_V256);
-            tcg_gen_dup16i_vec(t4, 0);
-            /* a1: A[0-7] ... D[0-7]; a2: W[0-7] ... Z[0-7]
-               t1: extends of B[0-7], D[0-7]
-               t2: extends of X[0-7], Z[0-7]
-               t3: extends of A[0-7], C[0-7]
-               t4: extends of W[0-7], Y[0-7].  */
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V256, MO_8,
-                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
-            vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V256, MO_8,
-                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
-            vec_gen_3(INDEX_op_x86_punpckh_vec, TCG_TYPE_V256, MO_8,
-                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
-            vec_gen_3(INDEX_op_x86_punpckh_vec, TCG_TYPE_V256, MO_8,
-                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
-            /* t1: BX DZ; t2: AW CY.  */
-            tcg_gen_mul_vec(MO_16, t1, t1, t2);
-            tcg_gen_mul_vec(MO_16, t3, t3, t4);
-            tcg_gen_shri_vec(MO_16, t1, t1, 8);
-            tcg_gen_shri_vec(MO_16, t3, t3, 8);
-            /* a0: AW BX CY DZ.  */
-            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V256, MO_8,
-                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
-            tcg_temp_free_vec(t1);
-            tcg_temp_free_vec(t2);
-            tcg_temp_free_vec(t3);
-            tcg_temp_free_vec(t4);
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_mul(type, vece, v0, v1, v2);
         break;
 
     case INDEX_op_cmp_vec:
-        {
-            enum {
-                NEED_SWAP = 1,
-                NEED_INV  = 2,
-                NEED_BIAS = 4
-            };
-            static const uint8_t fixups[16] = {
-                [0 ... 15] = -1,
-                [TCG_COND_EQ] = 0,
-                [TCG_COND_NE] = NEED_INV,
-                [TCG_COND_GT] = 0,
-                [TCG_COND_LT] = NEED_SWAP,
-                [TCG_COND_LE] = NEED_INV,
-                [TCG_COND_GE] = NEED_SWAP | NEED_INV,
-                [TCG_COND_GTU] = NEED_BIAS,
-                [TCG_COND_LTU] = NEED_BIAS | NEED_SWAP,
-                [TCG_COND_LEU] = NEED_BIAS | NEED_INV,
-                [TCG_COND_GEU] = NEED_BIAS | NEED_SWAP | NEED_INV,
-            };
-
-            TCGCond cond;
-            uint8_t fixup;
-
-            a1 = va_arg(va, TCGArg);
-            a2 = va_arg(va, TCGArg);
-            cond = va_arg(va, TCGArg);
-            fixup = fixups[cond & 15];
-            tcg_debug_assert(fixup != 0xff);
-
-            if (fixup & NEED_INV) {
-                cond = tcg_invert_cond(cond);
-            }
-            if (fixup & NEED_SWAP) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-            }
-
-            t1 = t2 = NULL;
-            if (fixup & NEED_BIAS) {
-                t1 = tcg_temp_new_vec(type);
-                t2 = tcg_temp_new_vec(type);
-                tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
-                tcg_gen_sub_vec(vece, t1, temp_tcgv_vec(arg_temp(a1)), t2);
-                tcg_gen_sub_vec(vece, t2, temp_tcgv_vec(arg_temp(a2)), t2);
-                a1 = tcgv_vec_arg(t1);
-                a2 = tcgv_vec_arg(t2);
-                cond = tcg_signed_cond(cond);
-            }
-
-            tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
-            vec_gen_4(INDEX_op_cmp_vec, type, vece, a0, a1, a2, cond);
-
-            if (fixup & NEED_BIAS) {
-                tcg_temp_free_vec(t1);
-                tcg_temp_free_vec(t2);
-            }
-            if (fixup & NEED_INV) {
-                tcg_gen_not_vec(vece, v0, v0);
-            }
-        }
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
 
     default:
-- 
2.17.2
