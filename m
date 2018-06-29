Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun4-0007li-Bp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun2-0007VG-Qk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun2-0007Qj-EL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun1-0004lu-CO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:33 +0100
Message-Id: <20180629145347.652-42-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 41/55] target/arm: Implement ARMv8.2-DotProd
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

We've already added the helpers with an SVE patch, all that remains
is to wire up the aa64 and aa32 translators.  Enable the feature
within -cpu max for CONFIG_USER_ONLY.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  1 +
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 36 +++++++++++++++++++
 target/arm/translate.c     | 74 +++++++++++++++++++++++++++-----------
 6 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a4507a2d6f0..6a8441c2dd6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1480,6 +1480,7 @@ enum arm_features {
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_ATOMICS, /* ARMv8.1-Atomics feature */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
+    ARM_FEATURE_V8_DOTPROD, /* implements v8.2 simd dot product */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d1231ad07a3..942a1b661f4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -583,6 +583,7 @@ static uint32_t get_elf_hwcap(void)
                 ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE(ARM_FEATURE_V8_DOTPROD, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
     GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
 #undef GET_FEATURE
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6dcc552e143..aa62315cea2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1805,6 +1805,7 @@ static void arm_max_initfn(Object *obj)
         set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
         set_feature(&cpu->env, ARM_FEATURE_CRC);
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
         set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
 #endif
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0360d7efc5e..3b4bc73ffa6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -250,6 +250,7 @@ static void aarch64_max_initfn(Object *obj)
         set_feature(&cpu->env, ARM_FEATURE_CRC);
         set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
         set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
         set_feature(&cpu->env, ARM_FEATURE_SVE);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index eb3a4ab2f08..f9863408324 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -640,6 +640,16 @@ static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                    vec_full_reg_size(s), gvec_op);
 }
 
+/* Expand a 3-operand operation using an out-of-line helper.  */
+static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
+                             int rn, int rm, int data, gen_helper_gvec_3 *fn)
+{
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+}
+
 /* Expand a 3-operand + env pointer operation using
  * an out-of-line helper.
  */
@@ -11336,6 +11346,14 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_RDM;
         break;
+    case 0x02: /* SDOT (vector) */
+    case 0x12: /* UDOT (vector) */
+        if (size != MO_32) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_DOTPROD;
+        break;
     case 0x8: /* FCMLA, #0 */
     case 0x9: /* FCMLA, #90 */
     case 0xa: /* FCMLA, #180 */
@@ -11389,6 +11407,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
+    case 0x2: /* SDOT / UDOT */
+        gen_gvec_op3_ool(s, is_q, rd, rn, rm, 0,
+                         u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b);
+        return;
+
     case 0x8: /* FCMLA, #0 */
     case 0x9: /* FCMLA, #90 */
     case 0xa: /* FCMLA, #180 */
@@ -12568,6 +12591,13 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+    case 0x0e: /* SDOT */
+    case 0x1e: /* UDOT */
+        if (size != MO_32 || !arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+            unallocated_encoding(s);
+            return;
+        }
+        break;
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
@@ -12665,6 +12695,12 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     switch (16 * u + opcode) {
+    case 0x0e: /* SDOT */
+    case 0x1e: /* UDOT */
+        gen_gvec_op3_ool(s, is_q, rd, rn, rm, index,
+                         u ? gen_helper_gvec_udot_idx_b
+                         : gen_helper_gvec_sdot_idx_b);
+        return;
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a7a980b1f29..f845da7c638 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7762,9 +7762,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
  */
 static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 {
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
-    int rd, rn, rm, rot, size, opr_sz;
-    TCGv_ptr fpst;
+    gen_helper_gvec_3 *fn_gvec = NULL;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
+    int rd, rn, rm, opr_sz;
+    int data = 0;
     bool q;
 
     q = extract32(insn, 6, 1);
@@ -7777,8 +7778,8 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 
     if ((insn & 0xfe200f10) == 0xfc200800) {
         /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
-        size = extract32(insn, 20, 1);
-        rot = extract32(insn, 23, 2);
+        int size = extract32(insn, 20, 1);
+        data = extract32(insn, 23, 2); /* rot */
         if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
@@ -7786,13 +7787,20 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
         fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
     } else if ((insn & 0xfea00f10) == 0xfc800800) {
         /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
-        size = extract32(insn, 20, 1);
-        rot = extract32(insn, 24, 1);
+        int size = extract32(insn, 20, 1);
+        data = extract32(insn, 24, 1); /* rot */
         if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
         }
         fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
+    } else if ((insn & 0xfeb00f00) == 0xfc200d00) {
+        /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
+        bool u = extract32(insn, 4, 1);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+            return 1;
+        }
+        fn_gvec = u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
     } else {
         return 1;
     }
@@ -7807,12 +7815,19 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     }
 
     opr_sz = (1 + q) * 8;
-    fpst = get_fpstatus_ptr(1);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                       vfp_reg_offset(1, rn),
-                       vfp_reg_offset(1, rm), fpst,
-                       opr_sz, opr_sz, rot, fn_gvec_ptr);
-    tcg_temp_free_ptr(fpst);
+    if (fn_gvec_ptr) {
+        TCGv_ptr fpst = get_fpstatus_ptr(1);
+        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                           vfp_reg_offset(1, rn),
+                           vfp_reg_offset(1, rm), fpst,
+                           opr_sz, opr_sz, data, fn_gvec_ptr);
+        tcg_temp_free_ptr(fpst);
+    } else {
+        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd),
+                           vfp_reg_offset(1, rn),
+                           vfp_reg_offset(1, rm),
+                           opr_sz, opr_sz, data, fn_gvec);
+    }
     return 0;
 }
 
@@ -7826,9 +7841,9 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 
 static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
 {
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    gen_helper_gvec_3 *fn_gvec = NULL;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
     int rd, rn, rm, opr_sz, data;
-    TCGv_ptr fpst;
     bool q;
 
     q = extract32(insn, 6, 1);
@@ -7862,6 +7877,16 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         data = (index << 2) | rot;
         fn_gvec_ptr = (size ? gen_helper_gvec_fcmlas_idx
                        : gen_helper_gvec_fcmlah_idx);
+    } else if ((insn & 0xffb00f00) == 0xfe200d00) {
+        /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
+        int u = extract32(insn, 4, 1);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+            return 1;
+        }
+        fn_gvec = u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
+        /* rm is just Vm, and index is M.  */
+        data = extract32(insn, 5, 1); /* index */
+        rm = extract32(insn, 0, 4);
     } else {
         return 1;
     }
@@ -7876,12 +7901,19 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     }
 
     opr_sz = (1 + q) * 8;
-    fpst = get_fpstatus_ptr(1);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                       vfp_reg_offset(1, rn),
-                       vfp_reg_offset(1, rm), fpst,
-                       opr_sz, opr_sz, data, fn_gvec_ptr);
-    tcg_temp_free_ptr(fpst);
+    if (fn_gvec_ptr) {
+        TCGv_ptr fpst = get_fpstatus_ptr(1);
+        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
+                           vfp_reg_offset(1, rn),
+                           vfp_reg_offset(1, rm), fpst,
+                           opr_sz, opr_sz, data, fn_gvec_ptr);
+        tcg_temp_free_ptr(fpst);
+    } else {
+        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd),
+                           vfp_reg_offset(1, rn),
+                           vfp_reg_offset(1, rm),
+                           opr_sz, opr_sz, data, fn_gvec);
+    }
     return 0;
 }
 
-- 
2.17.1
