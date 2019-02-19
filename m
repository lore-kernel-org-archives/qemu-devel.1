Received: from eggs.gnu.org ([209.51.188.92]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDtw-0000Kl-A8
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDts-0002VJ-OX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwDtq-0002Qf-Ts
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id s1so11105198plp.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:29:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:29:48 -0800
Message-Id: <20190219222952.22183-2-richard.henderson@linaro.org>
In-Reply-To: <20190219222952.22183-1-richard.henderson@linaro.org>
References: <20190219222952.22183-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 1/5] target/arm: Add helpers for FMLAL
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

Note that float16_to_float32 rightly squashes SNaN to QNaN.
But of course pickNaNMulAdd, for ARM, selects SNaNs first.
So we have to preserve SNaN long enough for the correct NaN
to be selected.  Thus float16_to_float32_by_bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h     |   9 +++
 target/arm/vec_helper.c | 148 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 747cb64d29..d363904278 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -677,6 +677,15 @@ DEF_HELPER_FLAGS_5(gvec_sqsub_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_sqsub_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index dfc635cf9a..dedef62403 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -898,3 +898,151 @@ void HELPER(gvec_sqsub_d)(void *vd, void *vq, void *vn,
     }
     clear_tail(d, oprsz, simd_maxsz(desc));
 }
+
+/*
+ * Convert float16 to float32, raising no exceptions and
+ * preserving exceptional values, including SNaN.
+ * This is effectively an unpack+repack operation.
+ */
+static float32 float16_to_float32_by_bits(uint32_t f16, bool fz16)
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
+            if (fz16) {
+                frac = 0;
+            } else {
+                /*
+                 * Denormal; these are all normal float32.
+                 * Shift the fraction so that the msb is at bit 11,
+                 * then remove bit 11 as the implicit bit of the
+                 * normalized float32.  Note that we still go through
+                 * the shift for normal numbers below, to put the
+                 * float32 fraction at the right place.
+                 */
+                int shift = clz32(frac) - 21;
+                frac = (frac << shift) & 0x3ff;
+                exp = f32_bias - f16_bias - shift + 1;
+            }
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
+static uint64_t load4_f16(uint64_t *ptr, int is_q, int is_2)
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
+ * Note that FMLAL requires oprsz == 8 or oprsz == 16,
+ * as there is not yet SVE versions that might use blocking.
+ */
+
+static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
+                     uint32_t desc, bool fz16)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    int is_q = oprsz == 16;
+    uint64_t n_4, m_4;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+    m_4 = load4_f16(vm, is_q, is_2);
+
+    /* Negate all inputs for FMLSL at once.  */
+    if (is_s) {
+        n_4 ^= 0x8000800080008000ull;
+    }
+
+    for (i = 0; i < oprsz / 4; i++) {
+        float32 n_1 = float16_to_float32_by_bits(n_4 >> (i * 16), fz16);
+        float32 m_1 = float16_to_float32_by_bits(m_4 >> (i * 16), fz16);
+        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], 0, fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
+                            void *venv, uint32_t desc)
+{
+    CPUARMState *env = venv;
+    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+}
+
+void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
+                            void *venv, uint32_t desc)
+{
+    CPUARMState *env = venv;
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status, desc,
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+}
+
+static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
+                         uint32_t desc, bool fz16)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
+    int is_2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    int index = extract32(desc, SIMD_DATA_SHIFT + 2, 3);
+    int is_q = oprsz == 16;
+    uint64_t n_4;
+    float32 m_1;
+
+    /* Pre-load all of the f16 data, avoiding overlap issues.  */
+    n_4 = load4_f16(vn, is_q, is_2);
+
+    /* Negate all inputs for FMLSL at once.  */
+    if (is_s) {
+        n_4 ^= 0x8000800080008000ull;
+    }
+
+    m_1 = float16_to_float32_by_bits(((float16 *)vm)[H2(index)], fz16);
+
+    for (i = 0; i < oprsz / 4; i++) {
+        float32 n_1 = float16_to_float32_by_bits(n_4 >> (i * 16), fz16);
+        d[H4(i)] = float32_muladd(n_1, m_1, d[H4(i)], 0, fpst);
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
+                                void *venv, uint32_t desc)
+{
+    CPUARMState *env = venv;
+    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+}
+
+void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
+                                void *venv, uint32_t desc)
+{
+    CPUARMState *env = venv;
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+}
-- 
2.17.2
