Received: from eggs.gnu.org ([2001:4830:134:3::10]:39328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoo7-0004bG-Ug
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoo6-0003Gz-G6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:44 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVoo6-0003Fo-77
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:42 -0400
Received: by mail-pg0-x22c.google.com with SMTP id i7-v6so648518pgp.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:43 -1000
Message-Id: <20180621015359.12018-20-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 19/35] target/arm: Implement SVE FP Fast
 Reduction Group
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 35 ++++++++++++++++++++++
 target/arm/sve_helper.c    | 61 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 57 +++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 +++++
 4 files changed, 161 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 087819ec2b..ff69d143a0 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -725,6 +725,41 @@ DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_faddv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fmaxnmv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fmaxnmv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fmaxnmv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fminnmv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fminnmv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fminnmv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fmaxv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fmaxv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fmaxv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_fminv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fminv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_fminv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a40df62414..befea9ba54 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2852,6 +2852,67 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
     return predtest_ones(d, oprsz, esz_mask);
 }
 
+/* Recursive reduction on a function;
+ * C.f. the ARM ARM function ReducePredicated.
+ *
+ * While it would be possible to write this without the DATA temporary,
+ * it is much simpler to process the predicate register this way.
+ * The recursion is bounded to depth 7 (128 fp16 elements), so there's
+ * little to gain with a more complex non-recursive form.
+ */
+#define DO_REDUCE(NAME, TYPE, H, FUNC, IDENT)                         \
+static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
+{                                                                     \
+    if (n == 1) {                                                     \
+        return *data;                                                 \
+    } else {                                                          \
+        uintptr_t half = n / 2;                                       \
+        TYPE lo = NAME##_reduce(data, status, half);                  \
+        TYPE hi = NAME##_reduce(data + half, status, half);           \
+        return TYPE##_##FUNC(lo, hi, status);                         \
+    }                                                                 \
+}                                                                     \
+uint64_t HELPER(NAME)(void *vn, void *vg, void *vs, uint32_t desc)    \
+{                                                                     \
+    uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_maxsz(desc);  \
+    TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
+    for (i = 0; i < oprsz; ) {                                        \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
+        do {                                                          \
+            TYPE nn = *(TYPE *)(vn + H(i));                           \
+            *(TYPE *)((void *)data + i) = (pg & 1 ? nn : IDENT);      \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);                   \
+        } while (i & 15);                                             \
+    }                                                                 \
+    for (; i < maxsz; i += sizeof(TYPE)) {                            \
+        *(TYPE *)((void *)data + i) = IDENT;                          \
+    }                                                                 \
+    return NAME##_reduce(data, vs, maxsz / sizeof(TYPE));             \
+}
+
+DO_REDUCE(sve_faddv_h, float16, H1_2, add, float16_zero)
+DO_REDUCE(sve_faddv_s, float32, H1_4, add, float32_zero)
+DO_REDUCE(sve_faddv_d, float64,     , add, float64_zero)
+
+/* Identity is floatN_default_nan, without the function call.  */
+DO_REDUCE(sve_fminnmv_h, float16, H1_2, minnum, 0x7E00)
+DO_REDUCE(sve_fminnmv_s, float32, H1_4, minnum, 0x7FC00000)
+DO_REDUCE(sve_fminnmv_d, float64,     , minnum, 0x7FF8000000000000ULL)
+
+DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, maxnum, 0x7E00)
+DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, maxnum, 0x7FC00000)
+DO_REDUCE(sve_fmaxnmv_d, float64,     , maxnum, 0x7FF8000000000000ULL)
+
+DO_REDUCE(sve_fminv_h, float16, H1_2, min, float16_infinity)
+DO_REDUCE(sve_fminv_s, float32, H1_4, min, float32_infinity)
+DO_REDUCE(sve_fminv_d, float64,     , min, float64_infinity)
+
+DO_REDUCE(sve_fmaxv_h, float16, H1_2, max, float16_chs(float16_infinity))
+DO_REDUCE(sve_fmaxv_s, float32, H1_4, max, float32_chs(float32_infinity))
+DO_REDUCE(sve_fmaxv_d, float64,     , max, float64_chs(float64_infinity))
+
+#undef DO_REDUCE
+
 uint64_t HELPER(sve_fadda_h)(uint64_t nn, void *vm, void *vg,
                              void *status, uint32_t desc)
 {
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4ba84cadd..47d64f2fc7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3450,6 +3450,63 @@ static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_zzx *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Floating Point Fast Reduction Group
+ */
+
+typedef void gen_helper_fp_reduce(TCGv_i64, TCGv_ptr, TCGv_ptr,
+                                  TCGv_ptr, TCGv_i32);
+
+static void do_reduce(DisasContext *s, arg_rpr_esz *a,
+                      gen_helper_fp_reduce *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned p2vsz = pow2ceil(vsz);
+    TCGv_i32 t_desc = tcg_const_i32(simd_desc(vsz, p2vsz, 0));
+    TCGv_ptr t_zn, t_pg, status;
+    TCGv_i64 temp;
+
+    temp = tcg_temp_new_i64();
+    t_zn = tcg_temp_new_ptr();
+    t_pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
+    status = get_fpstatus_ptr(a->esz == MO_16);
+
+    fn(temp, t_zn, t_pg, status, t_desc);
+    tcg_temp_free_ptr(t_zn);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_ptr(status);
+    tcg_temp_free_i32(t_desc);
+
+    write_fp_dreg(s, a->rd, temp);
+    tcg_temp_free_i64(temp);
+}
+
+#define DO_VPZ(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+{                                                                        \
+    static gen_helper_fp_reduce * const fns[3] = {                       \
+        gen_helper_sve_##name##_h,                                       \
+        gen_helper_sve_##name##_s,                                       \
+        gen_helper_sve_##name##_d,                                       \
+    };                                                                   \
+    if (a->esz == 0) {                                                   \
+        return false;                                                    \
+    }                                                                    \
+    if (sve_access_check(s)) {                                           \
+        do_reduce(s, a, fns[a->esz - 1]);                                \
+    }                                                                    \
+    return true;                                                         \
+}
+
+DO_VPZ(FADDV, faddv)
+DO_VPZ(FMINNMV, fminnmv)
+DO_VPZ(FMAXNMV, fmaxnmv)
+DO_VPZ(FMINV, fminv)
+DO_VPZ(FMAXV, fmaxv)
+
 /*
  *** SVE Floating Point Accumulating Reduction Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f64e74fa9d..39a803621f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -731,6 +731,14 @@ FMUL_zzx        01100100 0.1 .. rm:3 001000 rn:5 rd:5 \
 FMUL_zzx        01100100 101 index:2 rm:3 001000 rn:5 rd:5      esz=2
 FMUL_zzx        01100100 111 index:1 rm:4 001000 rn:5 rd:5      esz=3
 
+### SVE FP Fast Reduction Group
+
+FADDV           01100101 .. 000 000 001 ... ..... .....         @rd_pg_rn
+FMAXNMV         01100101 .. 000 100 001 ... ..... .....         @rd_pg_rn
+FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
+FMAXV           01100101 .. 000 110 001 ... ..... .....         @rd_pg_rn
+FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
+
 ### SVE FP Accumulating Reduction Group
 
 # SVE floating-point serial reduction (predicated)
-- 
2.17.1
