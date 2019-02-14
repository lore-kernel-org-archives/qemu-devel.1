Received: from eggs.gnu.org ([209.51.188.92]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu89b-0006hY-GA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu7wL-000789-Tm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:44:00 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu7wL-0006zn-Im
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:43:57 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so2379984plb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 19:43:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 19:43:42 -0800
Message-Id: <20190214034345.24722-2-richard.henderson@linaro.org>
In-Reply-To: <20190214034345.24722-1-richard.henderson@linaro.org>
References: <20190214034345.24722-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] target/arm: Add helpers for FMLAL and FMLSL
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

Note that float16_to_float32 rightly squashes SNaN to QNaN.
But of course pickNaNMulAdd, for ARM, selects SNaNs first.
So we have to preserve SNaN long enough for the correct NaN
to be selected.  Thus float16_to_float32_by_bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h     |   9 +++
 target/arm/vec_helper.c | 154 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c6..0302e13604 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -653,6 +653,15 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmlal_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlsl_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlsl_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 37f338732e..0c3b3de961 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -766,3 +766,157 @@ DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4)
 DO_FMLA_IDX(gvec_fmla_idx_d, float64, )
 
 #undef DO_FMLA_IDX
+
+/*
+ * Convert float16 to float32, raising no exceptions and
+ * preserving exceptional values, including SNaN.
+ * This is effectively an unpack+repack operation.
+ */
+static float32 float16_to_float32_by_bits(uint32_t f16)
+{
+    const int f16_bias = 15;
+    const int f32_bias = 127;
+    uint32_t sign = extract32(f16, 15, 1);
+    uint32_t exp = extract32(f16, 10, 5);
+    uint32_t frac = extract32(f16, 0, 10);
+
+    if (exp == 0x1f) {
+        /* Inf or NaN */
+        exp = 0xff;
+    } else if (exp == 0) {
+        /* Zero or denormal.  */
+        if (frac != 0) {
+            /*
+             * Denormal; these are all normal float32.
+             * Shift the fraction so that the msb is at bit 11,
+             * then remove bit 11 as the implicit bit of the
+             * normalized float32.  Note that we still go through
+             * the shift for normal numbers below, to put the
+             * float32 fraction at the right place.
+             */
+            int shift = clz32(frac) - 21;
+            frac = (frac << shift) & 0x3ff;
+            exp = f32_bias - f16_bias - shift + 1;
+        }
+    } else {
+        /* Normal number; adjust the bias.  */
+        exp += f32_bias - f16_bias;
+    }
+    sign <<= 31;
+    exp <<= 23;
+    frac <<= 23 - 10;
+
+    return sign | exp | frac;
+}
+
+static float32 fmlal(float32 a, float16 n16, float16 m16, float_status *fpst)
+{
+    float32 n = float16_to_float32_by_bits(n16);
+    float32 m = float16_to_float32_by_bits(m16);
+    return float32_muladd(n, m, a, 0, fpst);
+}
+
+static float32 fmlsl(float32 a, float16 n16, float16 m16, float_status *fpst)
+{
+    float32 n = float16_to_float32_by_bits(n16);
+    float32 m = float16_to_float32_by_bits(m16);
+    return float32_muladd(float32_chs(n), m, a, 0, fpst);
+}
+
+static inline uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
+{
+    /*
+     * Branchless load of u32[0], u64[0], u32[1], or u64[1].
+     * Load the 2nd qword iff is_q & is_2.
+     * Shift to the 2nd dword iff !is_q & is_2.
+     * For !is_q & !is_2, the upper bits of the result are garbage.
+     */
+    return ptr[is_q & is_2] >> ((is_2 & ~is_q) << 5);
+}
+
+/*
+ * Note that FMLAL and FMLSL require oprsz == 8 or oprsz == 16,
+ * as there is not yet SVE versions that might use blocking.
+ */
+
+void HELPER(gvec_fmlal_h)(void *vd, void *vn, void *vm,
+                          void *fpst, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int is_q = oprsz == 16;
+    float32 *d = vd;
+    uint64_t n_4, m_4;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+    m_4 = load4_f16(vm, is_q, is_2);
+
+    for (i = 0; i < oprsz / 4; i++) {
+        d[H4(i)] = fmlal(d[H4(i)], extract64(n_4, i*16, 16),
+                         extract64(m_4, i*16, 16), fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmlsl_h)(void *vd, void *vn, void *vm,
+                          void *fpst, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int is_q = oprsz == 16;
+    float32 *d = vd;
+    uint64_t n_4, m_4;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+    m_4 = load4_f16(vm, is_q, is_2);
+
+    for (i = 0; i < oprsz / 4; i++) {
+        d[H4(i)] = fmlsl(d[H4(i)], extract64(n_4, i*16, 16),
+                         extract64(m_4, i*16, 16), fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmlal_idx_h)(void *vd, void *vn, void *vm,
+                              void *fpst, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int index = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    int is_q = oprsz == 16;
+    float32 *d = vd;
+    uint64_t n_4;
+    float16 m_1;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+    m_1 = ((float16 *)vm)[H2(index)];
+
+    for (i = 0; i < oprsz / 4; i++) {
+        d[H4(i)] = fmlal(d[H4(i)], extract64(n_4, i * 16, 16), m_1, fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmlsl_idx_h)(void *vd, void *vn, void *vm,
+                              void *fpst, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int index = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    int is_q = oprsz == 16;
+    float32 *d = vd;
+    uint64_t n_4;
+    float16 m_1;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+    m_1 = ((float16 *)vm)[H2(index)];
+
+    for (i = 0; i < oprsz / 4; i++) {
+        d[H4(i)] = fmlsl(d[H4(i)], extract64(n_4, i*16, 16), m_1, fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
-- 
2.17.2
