Received: from eggs.gnu.org ([2001:4830:134:3::10]:36459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP7-0006BH-Sj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP5-0004Eg-W1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP5-0004DZ-LQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:07 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP4-00025X-Cf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:47 +0000
Message-Id: <20180215183700.26101-8-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/20] target/arm: Handle SVE registers when
 using clear_vec_high
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

When storing to an AdvSIMD FP register, all of the high
bits of the SVE register are zeroed.  Therefore, call it
more often with is_q as a parameter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180211205848.4568-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 162 +++++++++++++++++----------------------------
 1 file changed, 62 insertions(+), 100 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e3881d4999..1c88539d62 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -602,13 +602,30 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
     return v;
 }
 
+/* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
+ * If SVE is not enabled, then there are only 128 bits in the vector.
+ */
+static void clear_vec_high(DisasContext *s, bool is_q, int rd)
+{
+    unsigned ofs = fp_reg_offset(s, rd, MO_64);
+    unsigned vsz = vec_full_reg_size(s);
+
+    if (!is_q) {
+        TCGv_i64 tcg_zero = tcg_const_i64(0);
+        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
+        tcg_temp_free_i64(tcg_zero);
+    }
+    if (vsz > 16) {
+        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
+    }
+}
+
 static void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
 {
-    TCGv_i64 tcg_zero = tcg_const_i64(0);
+    unsigned ofs = fp_reg_offset(s, reg, MO_64);
 
-    tcg_gen_st_i64(v, cpu_env, fp_reg_offset(s, reg, MO_64));
-    tcg_gen_st_i64(tcg_zero, cpu_env, fp_reg_hi_offset(s, reg));
-    tcg_temp_free_i64(tcg_zero);
+    tcg_gen_st_i64(v, cpu_env, ofs);
+    clear_vec_high(s, false, reg);
 }
 
 static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
@@ -1009,6 +1026,8 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
 
     tcg_temp_free_i64(tmplo);
     tcg_temp_free_i64(tmphi);
+
+    clear_vec_high(s, true, destidx);
 }
 
 /*
@@ -1124,17 +1143,6 @@ static void write_vec_element_i32(DisasContext *s, TCGv_i32 tcg_src,
     }
 }
 
-/* Clear the high 64 bits of a 128 bit vector (in general non-quad
- * vector ops all need to do this).
- */
-static void clear_vec_high(DisasContext *s, int rd)
-{
-    TCGv_i64 tcg_zero = tcg_const_i64(0);
-
-    write_vec_element(s, tcg_zero, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_zero);
-}
-
 /* Store from vector register to memory */
 static void do_vec_st(DisasContext *s, int srcidx, int element,
                       TCGv_i64 tcg_addr, int size)
@@ -2794,12 +2802,13 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
                     /* For non-quad operations, setting a slice of the low
                      * 64 bits of the register clears the high 64 bits (in
                      * the ARM ARM pseudocode this is implicit in the fact
-                     * that 'rval' is a 64 bit wide variable). We optimize
-                     * by noticing that we only need to do this the first
-                     * time we touch a register.
+                     * that 'rval' is a 64 bit wide variable).
+                     * For quad operations, we might still need to zero the
+                     * high bits of SVE.  We optimize by noticing that we only
+                     * need to do this the first time we touch a register.
                      */
-                    if (!is_q && e == 0 && (r == 0 || xs == selem - 1)) {
-                        clear_vec_high(s, tt);
+                    if (e == 0 && (r == 0 || xs == selem - 1)) {
+                        clear_vec_high(s, is_q, tt);
                     }
                 }
                 tcg_gen_addi_i64(tcg_addr, tcg_addr, ebytes);
@@ -2942,10 +2951,9 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
             write_vec_element(s, tcg_tmp, rt, 0, MO_64);
             if (is_q) {
                 write_vec_element(s, tcg_tmp, rt, 1, MO_64);
-            } else {
-                clear_vec_high(s, rt);
             }
             tcg_temp_free_i64(tcg_tmp);
+            clear_vec_high(s, is_q, rt);
         } else {
             /* Load/store one element per register */
             if (is_load) {
@@ -6718,7 +6726,6 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
     }
 
     if (!is_q) {
-        clear_vec_high(s, rd);
         write_vec_element(s, tcg_final, rd, 0, MO_64);
     } else {
         write_vec_element(s, tcg_final, rd, 1, MO_64);
@@ -6731,7 +6738,8 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
     tcg_temp_free_i64(tcg_rd);
     tcg_temp_free_i32(tcg_rd_narrowed);
     tcg_temp_free_i64(tcg_final);
-    return;
+
+    clear_vec_high(s, is_q, rd);
 }
 
 /* SQSHLU, UQSHL, SQSHL: saturating left shifts */
@@ -6795,10 +6803,7 @@ static void handle_simd_qshl(DisasContext *s, bool scalar, bool is_q,
             tcg_temp_free_i64(tcg_op);
         }
         tcg_temp_free_i64(tcg_shift);
-
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
+        clear_vec_high(s, is_q, rd);
     } else {
         TCGv_i32 tcg_shift = tcg_const_i32(shift);
         static NeonGenTwoOpEnvFn * const fns[2][2][3] = {
@@ -6847,8 +6852,8 @@ static void handle_simd_qshl(DisasContext *s, bool scalar, bool is_q,
         }
         tcg_temp_free_i32(tcg_shift);
 
-        if (!is_q && !scalar) {
-            clear_vec_high(s, rd);
+        if (!scalar) {
+            clear_vec_high(s, is_q, rd);
         }
     }
 }
@@ -6901,13 +6906,11 @@ static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
         }
     }
 
-    if (!is_double && elements == 2) {
-        clear_vec_high(s, rd);
-    }
-
     tcg_temp_free_i64(tcg_int);
     tcg_temp_free_ptr(tcg_fpst);
     tcg_temp_free_i32(tcg_shift);
+
+    clear_vec_high(s, elements << size == 16, rd);
 }
 
 /* UCVTF/SCVTF - Integer to FP conversion */
@@ -6995,9 +6998,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
             write_vec_element(s, tcg_op, rd, pass, MO_64);
             tcg_temp_free_i64(tcg_op);
         }
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
+        clear_vec_high(s, is_q, rd);
     } else {
         int maxpass = is_scalar ? 1 : is_q ? 4 : 2;
         for (pass = 0; pass < maxpass; pass++) {
@@ -7016,8 +7017,8 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
             }
             tcg_temp_free_i32(tcg_op);
         }
-        if (!is_q && !is_scalar) {
-            clear_vec_high(s, rd);
+        if (!is_scalar) {
+            clear_vec_high(s, is_q, rd);
         }
     }
 
@@ -7502,10 +7503,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
 
     tcg_temp_free_ptr(fpst);
 
-    if ((elements << size) < 4) {
-        /* scalar, or non-quad vector op */
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, elements * (size ? 8 : 4) > 8, rd);
 }
 
 /* AdvSIMD scalar three same
@@ -7831,13 +7829,11 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             }
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
-        if (is_scalar) {
-            clear_vec_high(s, rd);
-        }
-
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_zero);
         tcg_temp_free_i64(tcg_op);
+
+        clear_vec_high(s, !is_scalar, rd);
     } else {
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_zero = tcg_const_i32(0);
@@ -7888,8 +7884,8 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_zero);
         tcg_temp_free_i32(tcg_op);
-        if (!is_q && !is_scalar) {
-            clear_vec_high(s, rd);
+        if (!is_scalar) {
+            clear_vec_high(s, is_q, rd);
         }
     }
 
@@ -7925,12 +7921,9 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
             }
             write_vec_element(s, tcg_res, rd, pass, MO_64);
         }
-        if (is_scalar) {
-            clear_vec_high(s, rd);
-        }
-
         tcg_temp_free_i64(tcg_res);
         tcg_temp_free_i64(tcg_op);
+        clear_vec_high(s, !is_scalar, rd);
     } else {
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
@@ -7970,8 +7963,8 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
         }
         tcg_temp_free_i32(tcg_res);
         tcg_temp_free_i32(tcg_op);
-        if (!is_q && !is_scalar) {
-            clear_vec_high(s, rd);
+        if (!is_scalar) {
+            clear_vec_high(s, is_q, rd);
         }
     }
     tcg_temp_free_ptr(fpst);
@@ -8077,9 +8070,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         write_vec_element_i32(s, tcg_res[pass], rd, destelt + pass, MO_32);
         tcg_temp_free_i32(tcg_res[pass]);
     }
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* Remaining saturating accumulating ops */
@@ -8104,12 +8095,9 @@ static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
             }
             write_vec_element(s, tcg_rd, rd, pass, MO_64);
         }
-        if (is_scalar) {
-            clear_vec_high(s, rd);
-        }
-
         tcg_temp_free_i64(tcg_rd);
         tcg_temp_free_i64(tcg_rn);
+        clear_vec_high(s, !is_scalar, rd);
     } else {
         TCGv_i32 tcg_rn = tcg_temp_new_i32();
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
@@ -8167,13 +8155,9 @@ static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
             }
             write_vec_element_i32(s, tcg_rd, rd, pass, MO_32);
         }
-
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
-
         tcg_temp_free_i32(tcg_rd);
         tcg_temp_free_i32(tcg_rn);
+        clear_vec_high(s, is_q, rd);
     }
 }
 
@@ -8664,9 +8648,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     tcg_temp_free_i64(tcg_round);
 
  done:
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, is_q, rd);
 }
 
 static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
@@ -8855,19 +8837,18 @@ static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
     }
 
     if (!is_q) {
-        clear_vec_high(s, rd);
         write_vec_element(s, tcg_final, rd, 0, MO_64);
     } else {
         write_vec_element(s, tcg_final, rd, 1, MO_64);
     }
-
     if (round) {
         tcg_temp_free_i64(tcg_round);
     }
     tcg_temp_free_i64(tcg_rn);
     tcg_temp_free_i64(tcg_rd);
     tcg_temp_free_i64(tcg_final);
-    return;
+
+    clear_vec_high(s, is_q, rd);
 }
 
 
@@ -9261,9 +9242,7 @@ static void handle_3rd_narrowing(DisasContext *s, int is_q, int is_u, int size,
         write_vec_element_i32(s, tcg_res[pass], rd, pass + part, MO_32);
         tcg_temp_free_i32(tcg_res[pass]);
     }
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, is_q, rd);
 }
 
 static void handle_pmull_64(DisasContext *s, int is_q, int rd, int rn, int rm)
@@ -9671,9 +9650,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
             write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
             tcg_temp_free_i32(tcg_res[pass]);
         }
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
+        clear_vec_high(s, is_q, rd);
     }
 
     if (fpst) {
@@ -10161,10 +10138,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             tcg_temp_free_i32(tcg_op2);
         }
     }
-
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* AdvSIMD three same
@@ -10303,9 +10277,7 @@ static void handle_rev(DisasContext *s, int opcode, bool u,
             write_vec_element(s, tcg_tmp, rd, i, grp_size);
             tcg_temp_free_i64(tcg_tmp);
         }
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
+        clear_vec_high(s, is_q, rd);
     } else {
         int revmask = (1 << grp_size) - 1;
         int esize = 8 << size;
@@ -10949,9 +10921,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             tcg_temp_free_i32(tcg_op);
         }
     }
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    clear_vec_high(s, is_q, rd);
 
     if (need_rmode) {
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
@@ -11130,11 +11100,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             tcg_temp_free_i64(tcg_res);
         }
 
-        if (is_scalar) {
-            clear_vec_high(s, rd);
-        }
-
         tcg_temp_free_i64(tcg_idx);
+        clear_vec_high(s, !is_scalar, rd);
     } else if (!is_long) {
         /* 32 bit floating point, or 16 or 32 bit integer.
          * For the 16 bit scalar case we use the usual Neon helpers and
@@ -11238,10 +11205,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
 
         tcg_temp_free_i32(tcg_idx);
-
-        if (!is_q) {
-            clear_vec_high(s, rd);
-        }
+        clear_vec_high(s, is_q, rd);
     } else {
         /* long ops: 16x16->32 or 32x32->64 */
         TCGv_i64 tcg_res[2];
@@ -11318,9 +11282,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             }
             tcg_temp_free_i64(tcg_idx);
 
-            if (is_scalar) {
-                clear_vec_high(s, rd);
-            }
+            clear_vec_high(s, !is_scalar, rd);
         } else {
             TCGv_i32 tcg_idx = tcg_temp_new_i32();
 
-- 
2.16.1
