Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVood-00052B-N9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoob-0003bI-Os
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:15 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:42129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVoob-0003af-FW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:13 -0400
Received: by mail-pf0-x22a.google.com with SMTP id w7-v6so683532pfn.9
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:55:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:59 -1000
Message-Id: <20180621015359.12018-36-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 35/35] target/arm: Implement ARMv8.2-DotProd
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

We've already added the helpers with an SVE patch, all that remains
is to wire up the aa64 and aa32 translators.  Enable the feature
within -cpu max for CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  1 +
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  1 +
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 36 +++++++++++++++++
 target/arm/translate.c     | 81 ++++++++++++++++++++++++++------------
 6 files changed, 96 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8488273c5b..23098474e1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1480,6 +1480,7 @@ enum arm_features {
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_ATOMICS, /* ARMv8.1-Atomics feature */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
+    ARM_FEATURE_V8_DOTPROD, /* implements v8.2 simd dot product */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
 };
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 13bc78d0c8..bdb023b477 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -583,6 +583,7 @@ static uint32_t get_elf_hwcap(void)
                 ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE(ARM_FEATURE_V8_DOTPROD, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
 #undef GET_FEATURE
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8e4f4d8c21..95ac9c064d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1794,6 +1794,7 @@ static void arm_max_initfn(Object *obj)
         set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
         set_feature(&cpu->env, ARM_FEATURE_CRC);
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
         set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
 #endif
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0360d7efc5..3b4bc73ffa 100644
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
index 038e48278f..903d6233d3 100644
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
index f405c82fb2..09f2852b29 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7748,9 +7748,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
@@ -7763,8 +7764,8 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 
     if ((insn & 0xfe200f10) == 0xfc200800) {
         /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
-        size = extract32(insn, 20, 1);
-        rot = extract32(insn, 23, 2);
+        int size = extract32(insn, 20, 1);
+        data = extract32(insn, 23, 2); /* rot */
         if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
@@ -7772,13 +7773,20 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
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
@@ -7793,12 +7801,19 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
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
 
@@ -7812,8 +7827,10 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
 
 static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
 {
-    int rd, rn, rm, rot, size, opr_sz;
-    TCGv_ptr fpst;
+    gen_helper_gvec_3 *fn_gvec = NULL;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
+    int rd, rn, rm, opr_sz;
+    int data = 0;
     bool q;
 
     q = extract32(insn, 6, 1);
@@ -7826,12 +7843,21 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
 
     if ((insn & 0xff000f10) == 0xfe000800) {
         /* VCMLA (indexed) -- 1111 1110 S.RR .... .... 1000 ...0 .... */
-        rot = extract32(insn, 20, 2);
-        size = extract32(insn, 23, 1);
+        int size = extract32(insn, 23, 1);
+        data = extract32(insn, 20, 2); /* rot */
         if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)
             || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             return 1;
         }
+        fn_gvec_ptr = (size ? gen_helper_gvec_fcmlas_idx
+                       : gen_helper_gvec_fcmlah_idx);
+    } else if ((insn & 0xffb00f00) == 0xfe200d00) {
+        /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
+        int u = extract32(insn, 4, 1);
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_DOTPROD)) {
+            return 1;
+        }
+        fn_gvec = u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
     } else {
         return 1;
     }
@@ -7846,14 +7872,19 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     }
 
     opr_sz = (1 + q) * 8;
-    fpst = get_fpstatus_ptr(1);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd),
-                       vfp_reg_offset(1, rn),
-                       vfp_reg_offset(1, rm), fpst,
-                       opr_sz, opr_sz, rot,
-                       size ? gen_helper_gvec_fcmlas_idx
-                       : gen_helper_gvec_fcmlah_idx);
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
