Received: from eggs.gnu.org ([2001:4830:134:3::10]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9g-00064Q-9L
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9e-0008In-FG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:44 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9e-0008Hf-88
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:42 -0500
Received: by mail-pl0-x243.google.com with SMTP id d21so5200663pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:23 -0800
Message-Id: <20171218172425.18200-10-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/11] target/arm: Decode aa64 armv8.3 fcmla
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         |  11 ++++
 target/arm/advsimd_helper.c | 144 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c  | 149 ++++++++++++++++++++++++++++++++------------
 3 files changed, 265 insertions(+), 39 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0f0fc942b0..5b6333347d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -574,6 +574,17 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
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
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
index afc2bb1142..6a2a53e111 100644
--- a/target/arm/advsimd_helper.c
+++ b/target/arm/advsimd_helper.c
@@ -274,3 +274,147 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
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
+    neg_real <<= 15;
+    neg_imag <<= 15;
+
+    for (i = 0; i < opr_sz / 2; i += 2) {
+        float16 e0 = n[H2(i + flip)];
+        float16 e1 = m[H2(i + flip)] ^ neg_real;
+        float16 e2 = e0;
+        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;
+
+        d[H2(i)] = float16_muladd(e0, e1, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e2, e3, d[H2(i + 1)], 0, fpst);
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
+    float16 e1 = m[H2(flip)];
+    float16 e3 = m[H2(1 - flip)];
+
+    neg_real <<= 15;
+    neg_imag <<= 15;
+    e1 ^= neg_real;
+    e3 ^= neg_imag;
+
+    for (i = 0; i < opr_sz / 2; i += 2) {
+        float16 e0 = n[H2(i + flip)];
+        float16 e2 = e0;
+
+        d[H2(i)] = float16_muladd(e0, e1, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e2, e3, d[H2(i + 1)], 0, fpst);
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
+    neg_real <<= 31;
+    neg_imag <<= 31;
+
+    for (i = 0; i < opr_sz / 4; i += 2) {
+        float32 e0 = n[H4(i + flip)];
+        float32 e1 = m[H4(i + flip)] ^ neg_real;
+        float32 e2 = e0;
+        float32 e3 = m[H4(i + 1 - flip)] ^ neg_imag;
+
+        d[H4(i)] = float32_muladd(e0, e1, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e2, e3, d[H4(i + 1)], 0, fpst);
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
+    float32 e1 = m[H4(flip)];
+    float32 e3 = m[H4(1 - flip)];
+
+    neg_real <<= 31;
+    neg_imag <<= 31;
+    e1 ^= neg_real;
+    e3 ^= neg_imag;
+
+    for (i = 0; i < opr_sz / 4; i += 2) {
+        float32 e0 = n[H4(i + flip)];
+        float32 e2 = e0;
+
+        d[H4(i)] = float32_muladd(e0, e1, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e2, e3, d[H4(i + 1)], 0, fpst);
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
+    neg_real <<= 63;
+    neg_imag <<= 63;
+
+    for (i = 0; i < opr_sz / 8; i += 2) {
+        float64 e0 = n[i + flip];
+        float64 e1 = m[i + flip] ^ neg_real;
+        float64 e2 = e0;
+        float64 e3 = m[i + 1 - flip] ^ neg_imag;
+
+        d[i] = float64_muladd(e0, e1, d[i], 0, fpst);
+        d[i + 1] = float64_muladd(e2, e3, d[i + 1], 0, fpst);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 89a0616894..79fede35c1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10713,6 +10713,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = ARM_FEATURE_V8_1_SIMD;
         break;
+    case 0x8: /* FCMLA, #0 */
+    case 0x9: /* FCMLA, #90 */
+    case 0xa: /* FCMLA, #180 */
+    case 0xb: /* FCMLA, #270 */
     case 0xc: /* FCADD, #90 */
     case 0xe: /* FCADD, #270 */
         if (size == 0 || (size == 3 && !is_q)) {
@@ -10767,6 +10771,26 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
                            0, fn_gvec_ptr);
         break;
 
+    case 0x8: /* FCMLA, #0 */
+    case 0x9: /* FCMLA, #90 */
+    case 0xa: /* FCMLA, #180 */
+    case 0xb: /* FCMLA, #270 */
+        switch (size) {
+        case 1:
+            fn_gvec_ptr = gen_helper_gvec_fcmlah;
+            break;
+        case 2:
+            fn_gvec_ptr = gen_helper_gvec_fcmlas;
+            break;
+        case 3:
+            fn_gvec_ptr = gen_helper_gvec_fcmlad;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        data = extract32(opcode, 0, 2);
+        goto do_fpst;
+
     case 0xc: /* FCADD, #90 */
     case 0xe: /* FCADD, #270 */
         switch (size) {
@@ -10783,6 +10807,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
             g_assert_not_reached();
         }
         data = extract32(opcode, 1, 1);
+    do_fpst:
         fpst = get_fpstatus_ptr(size == 1);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                            vec_full_reg_offset(s, rn),
@@ -11864,80 +11889,80 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     bool is_long = false;
-    bool is_fp = false;
+    int is_fp = 0;
+    bool is_fp16 = false;
     int index;
     TCGv_ptr fpst;
 
-    switch (opcode) {
-    case 0x0: /* MLA */
-    case 0x4: /* MLS */
-        if (!u || is_scalar) {
+    switch (16 * u + opcode) {
+    case 0x00: /* MLA */
+    case 0x04: /* MLS */
+    case 0x08: /* MUL */
+        if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         break;
-    case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-    case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-    case 0xa: /* SMULL, SMULL2, UMULL, UMULL2 */
+    case 0x02: /* SMLAL, SMLAL2 */
+    case 0x12: /* UMLAL, UMLAL2 */
+    case 0x06: /* SMLSL, SMLSL2 */
+    case 0x16: /* UMLSL, UMLSL2 */
+    case 0x0a: /* SMULL, SMULL2 */
+    case 0x1a: /* UMULL, UMULL2 */
         if (is_scalar) {
             unallocated_encoding(s);
             return;
         }
         is_long = true;
         break;
-    case 0x3: /* SQDMLAL, SQDMLAL2 */
-    case 0x7: /* SQDMLSL, SQDMLSL2 */
-    case 0xb: /* SQDMULL, SQDMULL2 */
+    case 0x03: /* SQDMLAL, SQDMLAL2 */
+    case 0x07: /* SQDMLSL, SQDMLSL2 */
+    case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
-        /* fall through */
-    case 0xc: /* SQDMULH */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
         break;
-    case 0xd: /* SQRDMULH / SQRDMLAH */
-        if (u && !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
-            unallocated_encoding(s);
-            return;
-        }
+    case 0x0c: /* SQDMULH */
+    case 0x0d: /* SQRDMULH */
         break;
-    case 0xf: /* SQRDMLSH */
-        if (!u || !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+    case 0x1d: /* SQRDMLAH */
+    case 0x1f: /* SQRDMLSH */
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
             unallocated_encoding(s);
             return;
         }
         break;
-    case 0x8: /* MUL */
-        if (u || is_scalar) {
+    case 0x11: /* FCMLA #0 */
+    case 0x13: /* FCMLA #90 */
+    case 0x15: /* FCMLA #180 */
+    case 0x17: /* FCMLA #270 */
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FCMA)) {
             unallocated_encoding(s);
             return;
         }
+        is_fp = 2;
         break;
-    case 0x1: /* FMLA */
-    case 0x5: /* FMLS */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x9: /* FMUL, FMULX */
-        if (size == 1 || (size < 2 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+    case 0x01: /* FMLA */
+    case 0x05: /* FMLS */
+    case 0x09: /* FMUL */
+    case 0x19: /* FMULX */
+        if (size == 1
+            || (size < 2 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
             unallocated_encoding(s);
             return;
         }
-        is_fp = true;
+        is_fp = 1;
         break;
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
             size = MO_16;
+            is_fp16 = true;
             index = h << 2 | l << 1 | m;
             break;
         case 2: /* single precision */
@@ -11958,7 +11983,36 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             g_assert_not_reached();
             break;
         }
-    } else {
+        break;
+
+    case 2: /* complex fp */
+        switch (size) {
+        case 1:
+            size = MO_32;
+            is_fp16 = true;
+            if (h && !is_q) {
+                unallocated_encoding(s);
+                return;
+            }
+            index = h << 1 | l;
+            rm |= (m << 4);
+            break;
+        case 2:
+            size = MO_64;
+            if (l || !is_q) {
+                unallocated_encoding(s);
+                return;
+            }
+            index = h;
+            rm |= (m << 4);
+            break;
+        default:
+            unallocated_encoding(s);
+            return;
+        }
+        break;
+
+    default: /* integer */
         switch (size) {
         case 1:
             index = h << 2 | l << 1 | m;
@@ -11978,11 +12032,28 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        fpst = get_fpstatus_ptr(false);
+        fpst = get_fpstatus_ptr(is_fp16);
     } else {
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
-- 
2.14.3
