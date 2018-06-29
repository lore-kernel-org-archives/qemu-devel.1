Received: from eggs.gnu.org ([2001:4830:134:3::10]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumy-0007e6-B2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumx-0007G1-2D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumw-0007Dq-NE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumv-0004j0-Lh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:26 +0100
Message-Id: <20180629145347.652-35-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 34/55] target/arm: Implement SVE floating-point
 complex add
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180627043328.11531-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |   7 +++
 target/arm/sve_helper.c    | 100 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  24 +++++++++
 target/arm/sve.decode      |   4 ++
 4 files changed, 135 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 891346a5acb..0bd9fe2f284 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1092,6 +1092,13 @@ DEF_HELPER_FLAGS_6(sve_facgt_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_facgt_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sve_fcadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve_fcadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 83bd8c42690..bdb75657792 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3657,6 +3657,106 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
     }
 }
 
+/*
+ * FP Complex Add
+ */
+
+void HELPER(sve_fcadd_h)(void *vd, void *vn, void *vm, void *vg,
+                         void *vs, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    uint64_t *g = vg;
+    float16 neg_imag = float16_set_sign(0, simd_data(desc));
+    float16 neg_real = float16_chs(neg_imag);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float16 e0, e1, e2, e3;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float16);
+            i -= 2 * sizeof(float16);
+
+            e0 = *(float16 *)(vn + H1_2(i));
+            e1 = *(float16 *)(vm + H1_2(j)) ^ neg_real;
+            e2 = *(float16 *)(vn + H1_2(j));
+            e3 = *(float16 *)(vm + H1_2(i)) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                *(float16 *)(vd + H1_2(i)) = float16_add(e0, e1, vs);
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                *(float16 *)(vd + H1_2(j)) = float16_add(e2, e3, vs);
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fcadd_s)(void *vd, void *vn, void *vm, void *vg,
+                         void *vs, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    uint64_t *g = vg;
+    float32 neg_imag = float32_set_sign(0, simd_data(desc));
+    float32 neg_real = float32_chs(neg_imag);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float32 e0, e1, e2, e3;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float32);
+            i -= 2 * sizeof(float32);
+
+            e0 = *(float32 *)(vn + H1_2(i));
+            e1 = *(float32 *)(vm + H1_2(j)) ^ neg_real;
+            e2 = *(float32 *)(vn + H1_2(j));
+            e3 = *(float32 *)(vm + H1_2(i)) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                *(float32 *)(vd + H1_2(i)) = float32_add(e0, e1, vs);
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                *(float32 *)(vd + H1_2(j)) = float32_add(e2, e3, vs);
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
+                         void *vs, uint32_t desc)
+{
+    intptr_t j, i = simd_oprsz(desc);
+    uint64_t *g = vg;
+    float64 neg_imag = float64_set_sign(0, simd_data(desc));
+    float64 neg_real = float64_chs(neg_imag);
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            float64 e0, e1, e2, e3;
+
+            /* I holds the real index; J holds the imag index.  */
+            j = i - sizeof(float64);
+            i -= 2 * sizeof(float64);
+
+            e0 = *(float64 *)(vn + H1_2(i));
+            e1 = *(float64 *)(vm + H1_2(j)) ^ neg_real;
+            e2 = *(float64 *)(vn + H1_2(j));
+            e3 = *(float64 *)(vm + H1_2(i)) ^ neg_imag;
+
+            if (likely((pg >> (i & 63)) & 1)) {
+                *(float64 *)(vd + H1_2(i)) = float64_add(e0, e1, vs);
+            }
+            if (likely((pg >> (j & 63)) & 1)) {
+                *(float64 *)(vd + H1_2(j)) = float64_add(e2, e3, vs);
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 812823777ad..1b71986e2d8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3895,6 +3895,30 @@ DO_FPCMP(FACGT, facgt)
 
 #undef DO_FPCMP
 
+static bool trans_FCADD(DisasContext *s, arg_FCADD *a, uint32_t insn)
+{
+    static gen_helper_gvec_4_ptr * const fns[3] = {
+        gen_helper_sve_fcadd_h,
+        gen_helper_sve_fcadd_s,
+        gen_helper_sve_fcadd_d
+    };
+
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           pred_full_reg_offset(s, a->pg),
+                           status, vsz, vsz, a->rot, fns[a->esz - 1]);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
 typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
 
 static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index c725ee25843..e5f8f432540 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -725,6 +725,10 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+# SVE floating-point complex add (predicated)
+FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
+                rn=%reg_movprfx
+
 ### SVE FP Multiply-Add Indexed Group
 
 # SVE floating-point multiply-add (indexed)
-- 
2.17.1
