Received: from eggs.gnu.org ([2001:4830:134:3::10]:33949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumr-0007Wh-D5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumo-0006sb-U0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumo-0006kj-Fs
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumm-0004eO-VX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:16 +0100
Message-Id: <20180629145347.652-25-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/55] target/arm: Implement SVE Floating Point
 Multiply Indexed Group
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
Message-id: 20180627043328.11531-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        | 14 +++++++++++
 target/arm/translate-sve.c | 50 ++++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    | 48 ++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 19 +++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 879a7229e99..56439ac1e41 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -620,6 +620,20 @@ DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 1b467a5ddcd..e90f593f6ca 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3400,6 +3400,56 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
+/*
+ *** SVE Floating Point Multiply-Add Indexed Group
+ */
+
+static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a, uint32_t insn)
+{
+    static gen_helper_gvec_4_ptr * const fns[3] = {
+        gen_helper_gvec_fmla_idx_h,
+        gen_helper_gvec_fmla_idx_s,
+        gen_helper_gvec_fmla_idx_d,
+    };
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           status, vsz, vsz, (a->index << 1) | a->sub,
+                           fns[a->esz - 1]);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+/*
+ *** SVE Floating Point Multiply Indexed Group
+ */
+
+static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_zzx *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[3] = {
+        gen_helper_gvec_fmul_idx_h,
+        gen_helper_gvec_fmul_idx_s,
+        gen_helper_gvec_fmul_idx_d,
+    };
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, a->index, fns[a->esz - 1]);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index f504dd53c8f..97af75a61b3 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -495,3 +495,51 @@ DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 
 #endif
 #undef DO_3OP
+
+/* For the indexed ops, SVE applies the index per 128-bit vector segment.
+ * For AdvSIMD, there is of course only one such vector segment.
+ */
+
+#define DO_MUL_IDX(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
+        }                                                                  \
+    }                                                                      \
+}
+
+DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
+DO_MUL_IDX(gvec_fmul_idx_s, float32, H4)
+DO_MUL_IDX(gvec_fmul_idx_d, float64, )
+
+#undef DO_MUL_IDX
+
+#define DO_FMLA_IDX(NAME, TYPE, H)                                         \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
+                  void *stat, uint32_t desc)                               \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    TYPE op1_neg = extract32(desc, SIMD_DATA_SHIFT, 1);                    \
+    intptr_t idx = desc >> (SIMD_DATA_SHIFT + 1);                          \
+    TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
+    op1_neg <<= (8 * sizeof(TYPE) - 1);                                    \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = TYPE##_muladd(n[i + j] ^ op1_neg,                   \
+                                     mm, a[i + j], 0, stat);               \
+        }                                                                  \
+    }                                                                      \
+}
+
+DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
+DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4)
+DO_FMLA_IDX(gvec_fmla_idx_d, float64, )
+
+#undef DO_FMLA_IDX
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 267eb2dcfc6..15fa790d5b2 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
 %dtype_23_13    23:2 13:2
+%index3_22_19   22:1 19:2
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz     22:2 5:5 !function=tszimm_esz
@@ -716,6 +717,24 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 
+### SVE FP Multiply-Add Indexed Group
+
+# SVE floating-point multiply-add (indexed)
+FMLA_zzxz       01100100 0.1 .. rm:3 00000 sub:1 rn:5 rd:5 \
+                ra=%reg_movprfx index=%index3_22_19 esz=1
+FMLA_zzxz       01100100 101 index:2 rm:3 00000 sub:1 rn:5 rd:5 \
+                ra=%reg_movprfx esz=2
+FMLA_zzxz       01100100 111 index:1 rm:4 00000 sub:1 rn:5 rd:5 \
+                ra=%reg_movprfx esz=3
+
+### SVE FP Multiply Indexed Group
+
+# SVE floating-point multiply (indexed)
+FMUL_zzx        01100100 0.1 .. rm:3 001000 rn:5 rd:5 \
+                index=%index3_22_19 esz=1
+FMUL_zzx        01100100 101 index:2 rm:3 001000 rn:5 rd:5      esz=2
+FMUL_zzx        01100100 111 index:1 rm:4 001000 rn:5 rd:5      esz=3
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.17.1
