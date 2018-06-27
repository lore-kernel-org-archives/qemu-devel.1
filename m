Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29n-0004dr-8f
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29l-00010b-El
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:15 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29l-0000zp-72
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:13 -0400
Received: by mail-pl0-x241.google.com with SMTP id w17-v6so411779pll.9
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:22 -0700
Message-Id: <20180627043328.11531-30-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 29/35] target/arm: Implement SVE fp complex
 multiply add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |   4 +
 target/arm/sve_helper.c    | 162 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  37 +++++++++
 target/arm/sve.decode      |   4 +
 4 files changed, 207 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0bd9fe2f28..023952a9a4 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1115,6 +1115,10 @@ DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index bdb7565779..790cbacd14 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3757,6 +3757,168 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
     } while (i != 0);
 }
 
+/*
+ * FP Complex Multiply
+ */
+
+QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 22 > 32);
+
+void HELPER(sve_fcmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
+    bool flip = rot & 1;
+    float16 neg_imag, neg_real;
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    neg_imag = float16_set_sign(0, (rot & 2) != 0);
+    neg_real = float16_set_sign(0, rot == 1 || rot == 2);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float16 e1, e2, e3, e4, nr, ni, mr, mi, d;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float16);
+            i -= 2 * sizeof(float16);
+
+            nr = *(float16 *)(vn + H1_2(i));
+            ni = *(float16 *)(vn + H1_2(j));
+            mr = *(float16 *)(vm + H1_2(i));
+            mi = *(float16 *)(vm + H1_2(j));
+
+            e2 = (flip ? ni : nr);
+            e1 = (flip ? mi : mr) ^ neg_real;
+            e4 = e2;
+            e3 = (flip ? mr : mi) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                d = *(float16 *)(va + H1_2(i));
+                d = float16_muladd(e2, e1, d, 0, &env->vfp.fp_status_f16);
+                *(float16 *)(vd + H1_2(i)) = d;
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                d = *(float16 *)(va + H1_2(j));
+                d = float16_muladd(e4, e3, d, 0, &env->vfp.fp_status_f16);
+                *(float16 *)(vd + H1_2(j)) = d;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fcmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
+    bool flip = rot & 1;
+    float32 neg_imag, neg_real;
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    neg_imag = float32_set_sign(0, (rot & 2) != 0);
+    neg_real = float32_set_sign(0, rot == 1 || rot == 2);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float32 e1, e2, e3, e4, nr, ni, mr, mi, d;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float32);
+            i -= 2 * sizeof(float32);
+
+            nr = *(float32 *)(vn + H1_2(i));
+            ni = *(float32 *)(vn + H1_2(j));
+            mr = *(float32 *)(vm + H1_2(i));
+            mi = *(float32 *)(vm + H1_2(j));
+
+            e2 = (flip ? ni : nr);
+            e1 = (flip ? mi : mr) ^ neg_real;
+            e4 = e2;
+            e3 = (flip ? mr : mi) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                d = *(float32 *)(va + H1_2(i));
+                d = float32_muladd(e2, e1, d, 0, &env->vfp.fp_status);
+                *(float32 *)(vd + H1_2(i)) = d;
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                d = *(float32 *)(va + H1_2(j));
+                d = float32_muladd(e4, e3, d, 0, &env->vfp.fp_status);
+                *(float32 *)(vd + H1_2(j)) = d;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
+    bool flip = rot & 1;
+    float64 neg_imag, neg_real;
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    neg_imag = float64_set_sign(0, (rot & 2) != 0);
+    neg_real = float64_set_sign(0, rot == 1 || rot == 2);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float64 e1, e2, e3, e4, nr, ni, mr, mi, d;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float64);
+            i -= 2 * sizeof(float64);
+
+            nr = *(float64 *)(vn + H1_2(i));
+            ni = *(float64 *)(vn + H1_2(j));
+            mr = *(float64 *)(vm + H1_2(i));
+            mi = *(float64 *)(vm + H1_2(j));
+
+            e2 = (flip ? ni : nr);
+            e1 = (flip ? mi : mr) ^ neg_real;
+            e4 = e2;
+            e3 = (flip ? mr : mi) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                d = *(float64 *)(va + H1_2(i));
+                d = float64_muladd(e2, e1, d, 0, &env->vfp.fp_status);
+                *(float64 *)(vd + H1_2(i)) = d;
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                d = *(float64 *)(va + H1_2(j));
+                d = float64_muladd(e4, e3, d, 0, &env->vfp.fp_status);
+                *(float64 *)(vd + H1_2(j)) = d;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b1764f099b..7ce3222158 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3968,6 +3968,43 @@ DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
 
 #undef DO_FMLA
 
+static bool trans_FCMLA_zpzzz(DisasContext *s,
+                              arg_FCMLA_zpzzz *a, uint32_t insn)
+{
+    static gen_helper_sve_fmla * const fns[3] = {
+        gen_helper_sve_fcmla_zpzzz_h,
+        gen_helper_sve_fcmla_zpzzz_s,
+        gen_helper_sve_fcmla_zpzzz_d,
+    };
+
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned desc;
+        TCGv_i32 t_desc;
+        TCGv_ptr pg = tcg_temp_new_ptr();
+
+        /* We would need 7 operands to pass these arguments "properly".
+         * So we encode all the register numbers into the descriptor.
+         */
+        desc = deposit32(a->rd, 5, 5, a->rn);
+        desc = deposit32(desc, 10, 5, a->rm);
+        desc = deposit32(desc, 15, 5, a->ra);
+        desc = deposit32(desc, 20, 2, a->rot);
+        desc = sextract32(desc, 0, 22);
+        desc = simd_desc(vsz, vsz, desc);
+
+        t_desc = tcg_const_i32(desc);
+        tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
+        fns[a->esz - 1](cpu_env, pg, t_desc);
+        tcg_temp_free_i32(t_desc);
+        tcg_temp_free_ptr(pg);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Unary Operations Prediated Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e5f8f43254..e342cfdf14 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -729,6 +729,10 @@ MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
                 rn=%reg_movprfx
 
+# SVE floating-point complex multiply-add (predicated)
+FCMLA_zpzzz     01100100 esz:2 0 rm:5 0 rot:2 pg:3 rn:5 rd:5 \
+                ra=%reg_movprfx
+
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
-- 
2.17.1
