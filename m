Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S8-0003V7-B4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S6-0006S5-Lz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:48 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7S6-0006RO-Eh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:46 -0500
Received: by mail-pg0-x243.google.com with SMTP id r26so1321600pgv.13
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:21 -0800
Message-Id: <20180228193125.20577-13-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/16] target/arm: Decode aa64 armv8.3 fcmla
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  11 ++++
 target/arm/translate-a64.c |  94 +++++++++++++++++++++++++---
 target/arm/vec_helper.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1e2d7025de..0d2094f2be 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -585,6 +585,17 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fcmlah, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcmlas, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #endif
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index efed4fd9d2..31ff0479e6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10842,6 +10842,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_RDM;
         break;
+    case 0x8: /* FCMLA, #0 */
+    case 0x9: /* FCMLA, #90 */
+    case 0xa: /* FCMLA, #180 */
+    case 0xb: /* FCMLA, #270 */
     case 0xc: /* FCADD, #90 */
     case 0xe: /* FCADD, #270 */
         if (size == 0
@@ -10891,6 +10895,29 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
+    case 0x8: /* FCMLA, #0 */
+    case 0x9: /* FCMLA, #90 */
+    case 0xa: /* FCMLA, #180 */
+    case 0xb: /* FCMLA, #270 */
+        rot = extract32(opcode, 0, 2);
+        switch (size) {
+        case 1:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, true, rot,
+                              gen_helper_gvec_fcmlah);
+            break;
+        case 2:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
+                              gen_helper_gvec_fcmlas);
+            break;
+        case 3:
+            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
+                              gen_helper_gvec_fcmlad);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return;
+
     case 0xc: /* FCADD, #90 */
     case 0xe: /* FCADD, #270 */
         rot = extract32(opcode, 1, 1);
@@ -11993,7 +12020,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool is_long = false;
-    bool is_fp = false;
+    int is_fp = 0;
     bool is_fp16 = false;
     int index;
     TCGv_ptr fpst;
@@ -12031,7 +12058,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
     case 0x19: /* FMULX */
-        is_fp = true;
+        is_fp = 1;
         break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
@@ -12040,20 +12067,28 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+    case 0x11: /* FCMLA #0 */
+    case 0x13: /* FCMLA #90 */
+    case 0x15: /* FCMLA #180 */
+    case 0x17: /* FCMLA #270 */
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
+            unallocated_encoding(s);
+            return;
+        }
+        is_fp = 2;
+        break;
     default:
         unallocated_encoding(s);
         return;
     }
 
-    if (is_fp) {
+    switch (is_fp) {
+    case 1: /* normal fp */
         /* convert insn encoded size to TCGMemOp size */
         switch (size) {
         case 0: /* half-precision */
-            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
-                unallocated_encoding(s);
-                return;
-            }
             size = MO_16;
+            is_fp16 = true;
             break;
         case MO_32: /* single precision */
         case MO_64: /* double precision */
@@ -12062,13 +12097,39 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-    } else {
+        break;
+
+    case 2: /* complex fp */
+        /* Each indexable element is a complex pair.  */
+        size <<= 1;
+        switch (size) {
+        case MO_32:
+            if (h && !is_q) {
+                unallocated_encoding(s);
+                return;
+            }
+            is_fp16 = true;
+            break;
+        case MO_64:
+            break;
+        default:
+            unallocated_encoding(s);
+            return;
+        }
+        break;
+
+    default: /* integer */
         switch (size) {
         case MO_8:
         case MO_64:
             unallocated_encoding(s);
             return;
         }
+        break;
+    }
+    if (is_fp16 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        unallocated_encoding(s);
+        return;
     }
 
     /* Given TCGMemOp size, adjust register and indexing.  */
@@ -12102,6 +12163,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         fpst = NULL;
     }
 
+    switch (16 * u + opcode) {
+    case 0x11: /* FCMLA #0 */
+    case 0x13: /* FCMLA #90 */
+    case 0x15: /* FCMLA #180 */
+    case 0x17: /* FCMLA #270 */
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_reg_offset(s, rm, index, size), fpst,
+                           is_q ? 16 : 8, vec_full_reg_size(s),
+                           extract32(insn, 13, 2), /* rot */
+                           size == MO_64
+                           ? gen_helper_gvec_fcmlas_idx
+                           : gen_helper_gvec_fcmlah_idx);
+        tcg_temp_free_ptr(fpst);
+        return;
+    }
+
     if (size == 3) {
         TCGv_i64 tcg_idx = tcg_temp_new_i64();
         int pass;
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a868ca6aac..d81eb7730d 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -278,3 +278,152 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float16 *d = vd;
+    float16 *n = vn;
+    float16 *m = vm;
+    float_status *fpst = vfpst;
+    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t neg_real = flip ^ neg_imag;
+    uintptr_t i;
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 15;
+    neg_imag <<= 15;
+
+    for (i = 0; i < opr_sz / 2; i += 2) {
+        float16 e1 = n[H2(i + flip)];
+        float16 e2 = m[H2(i + flip)] ^ neg_real;
+        float16 e3 = e1;
+        float16 e4 = m[H2(i + 1 - flip)] ^ neg_imag;
+
+        d[H2(i)] = float16_muladd(e1, e2, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e3, e4, d[H2(i + 1)], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
+                             void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float16 *d = vd;
+    float16 *n = vn;
+    float16 *m = vm;
+    float_status *fpst = vfpst;
+    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t neg_real = flip ^ neg_imag;
+    uintptr_t i;
+    float16 e2 = m[H2(flip)];
+    float16 e4 = m[H2(1 - flip)];
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 15;
+    neg_imag <<= 15;
+    e2 ^= neg_real;
+    e4 ^= neg_imag;
+
+    for (i = 0; i < opr_sz / 2; i += 2) {
+        float16 e1 = n[H2(i + flip)];
+        float16 e3 = e1;
+
+        d[H2(i)] = float16_muladd(e1, e2, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e3, e4, d[H2(i + 1)], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float32 *d = vd;
+    float32 *n = vn;
+    float32 *m = vm;
+    float_status *fpst = vfpst;
+    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t neg_real = flip ^ neg_imag;
+    uintptr_t i;
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 31;
+    neg_imag <<= 31;
+
+    for (i = 0; i < opr_sz / 4; i += 2) {
+        float32 e1 = n[H4(i + flip)];
+        float32 e2 = m[H4(i + flip)] ^ neg_real;
+        float32 e3 = e1;
+        float32 e4 = m[H4(i + 1 - flip)] ^ neg_imag;
+
+        d[H4(i)] = float32_muladd(e1, e2, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e3, e4, d[H4(i + 1)], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
+                             void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float32 *d = vd;
+    float32 *n = vn;
+    float32 *m = vm;
+    float_status *fpst = vfpst;
+    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t neg_real = flip ^ neg_imag;
+    uintptr_t i;
+    float32 e2 = m[H4(flip)];
+    float32 e4 = m[H4(1 - flip)];
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 31;
+    neg_imag <<= 31;
+    e2 ^= neg_real;
+    e4 ^= neg_imag;
+
+    for (i = 0; i < opr_sz / 4; i += 2) {
+        float32 e1 = n[H4(i + flip)];
+        float32 e3 = e1;
+
+        d[H4(i)] = float32_muladd(e1, e2, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e3, e4, d[H4(i + 1)], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
+                         void *vfpst, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    float64 *d = vd;
+    float64 *n = vn;
+    float64 *m = vm;
+    float_status *fpst = vfpst;
+    intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint64_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint64_t neg_real = flip ^ neg_imag;
+    uintptr_t i;
+
+    /* Shift boolean to the sign bit so we can xor to negate.  */
+    neg_real <<= 63;
+    neg_imag <<= 63;
+
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        float64 e1 = n[i + flip];
+        float64 e2 = m[i + flip] ^ neg_real;
+        float64 e3 = e1;
+        float64 e4 = m[i + 1 - flip] ^ neg_imag;
+
+        d[i] = float64_muladd(e1, e2, d[i], 0, fpst);
+        d[i + 1] = float64_muladd(e3, e4, d[i + 1], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.14.3
