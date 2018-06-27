Received: from eggs.gnu.org ([2001:4830:134:3::10]:60873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29g-0004XW-C1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29e-0000sr-Ik
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:08 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:43435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29e-0000rX-9o
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:06 -0400
Received: by mail-pl0-x22d.google.com with SMTP id c41-v6so408586plj.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:17 -0700
Message-Id: <20180627043328.11531-25-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 24/35] target/arm: Implement SVE
 floating-point convert to integer
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
 target/arm/helper-sve.h    | 30 +++++++++++++
 target/arm/helper.h        | 12 +++---
 target/arm/helper.c        |  2 +-
 target/arm/sve_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 70 ++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 16 +++++++
 6 files changed, 211 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4c379dbb05..37fa9eb9bb 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -955,6 +955,36 @@ DEF_HELPER_FLAGS_5(sve_fcvt_hd, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_fcvt_sd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_fcvtzs_hh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_hs, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_ss, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_hd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzs_dd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fcvtzu_hh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_hs, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_ss, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_hd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvtzu_dd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/helper.h b/target/arm/helper.h
index ad9cb6c7d5..8607077dda 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -134,12 +134,12 @@ DEF_HELPER_2(vfp_touid, i32, f64, ptr)
 DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
 DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
 DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
-DEF_HELPER_2(vfp_tosih, i32, f16, ptr)
-DEF_HELPER_2(vfp_tosis, i32, f32, ptr)
-DEF_HELPER_2(vfp_tosid, i32, f64, ptr)
-DEF_HELPER_2(vfp_tosizh, i32, f16, ptr)
-DEF_HELPER_2(vfp_tosizs, i32, f32, ptr)
-DEF_HELPER_2(vfp_tosizd, i32, f64, ptr)
+DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
+DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
 
 DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1248d84e6f..a36f5b1899 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11360,7 +11360,7 @@ ftype HELPER(name)(uint32_t x, void *fpstp)                         \
 }
 
 #define CONV_FTOI(name, ftype, fsz, sign, round)                \
-uint32_t HELPER(name)(ftype x, void *fpstp)                     \
+sign##int32_t HELPER(name)(ftype x, void *fpstp)                \
 {                                                               \
     float_status *fpst = fpstp;                                 \
     if (float##fsz##_is_any_nan(x)) {                           \
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4b36c1eecf..b6421ec19c 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3195,6 +3195,78 @@ static inline float16 sve_f64_to_f16(float64 f, float_status *fpst)
     return ret;
 }
 
+static inline int16_t vfp_float16_to_int16_rtz(float16 f, float_status *s)
+{
+    if (float16_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float16_to_int16_round_to_zero(f, s);
+}
+
+static inline int64_t vfp_float16_to_int64_rtz(float16 f, float_status *s)
+{
+    if (float16_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float16_to_int64_round_to_zero(f, s);
+}
+
+static inline int64_t vfp_float32_to_int64_rtz(float32 f, float_status *s)
+{
+    if (float32_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float32_to_int64_round_to_zero(f, s);
+}
+
+static inline int64_t vfp_float64_to_int64_rtz(float64 f, float_status *s)
+{
+    if (float64_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float64_to_int64_round_to_zero(f, s);
+}
+
+static inline uint16_t vfp_float16_to_uint16_rtz(float16 f, float_status *s)
+{
+    if (float16_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float16_to_uint16_round_to_zero(f, s);
+}
+
+static inline uint64_t vfp_float16_to_uint64_rtz(float16 f, float_status *s)
+{
+    if (float16_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float16_to_uint64_round_to_zero(f, s);
+}
+
+static inline uint64_t vfp_float32_to_uint64_rtz(float32 f, float_status *s)
+{
+    if (float32_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float32_to_uint64_round_to_zero(f, s);
+}
+
+static inline uint64_t vfp_float64_to_uint64_rtz(float64 f, float_status *s)
+{
+    if (float64_is_any_nan(f)) {
+        float_raise(float_flag_invalid, s);
+        return 0;
+    }
+    return float64_to_uint64_round_to_zero(f, s);
+}
+
 DO_ZPZ_FP(sve_fcvt_sh, uint32_t, H1_4, sve_f32_to_f16)
 DO_ZPZ_FP(sve_fcvt_hs, uint32_t, H1_4, sve_f16_to_f32)
 DO_ZPZ_FP(sve_fcvt_dh, uint64_t,     , sve_f64_to_f16)
@@ -3202,6 +3274,22 @@ DO_ZPZ_FP(sve_fcvt_hd, uint64_t,     , sve_f16_to_f64)
 DO_ZPZ_FP(sve_fcvt_ds, uint64_t,     , float64_to_float32)
 DO_ZPZ_FP(sve_fcvt_sd, uint64_t,     , float32_to_float64)
 
+DO_ZPZ_FP(sve_fcvtzs_hh, uint16_t, H1_2, vfp_float16_to_int16_rtz)
+DO_ZPZ_FP(sve_fcvtzs_hs, uint32_t, H1_4, helper_vfp_tosizh)
+DO_ZPZ_FP(sve_fcvtzs_ss, uint32_t, H1_4, helper_vfp_tosizs)
+DO_ZPZ_FP(sve_fcvtzs_hd, uint64_t,     , vfp_float16_to_int64_rtz)
+DO_ZPZ_FP(sve_fcvtzs_sd, uint64_t,     , vfp_float32_to_int64_rtz)
+DO_ZPZ_FP(sve_fcvtzs_ds, uint64_t,     , helper_vfp_tosizd)
+DO_ZPZ_FP(sve_fcvtzs_dd, uint64_t,     , vfp_float64_to_int64_rtz)
+
+DO_ZPZ_FP(sve_fcvtzu_hh, uint16_t, H1_2, vfp_float16_to_uint16_rtz)
+DO_ZPZ_FP(sve_fcvtzu_hs, uint32_t, H1_4, helper_vfp_touizh)
+DO_ZPZ_FP(sve_fcvtzu_ss, uint32_t, H1_4, helper_vfp_touizs)
+DO_ZPZ_FP(sve_fcvtzu_hd, uint64_t,     , vfp_float16_to_uint64_rtz)
+DO_ZPZ_FP(sve_fcvtzu_sd, uint64_t,     , vfp_float32_to_uint64_rtz)
+DO_ZPZ_FP(sve_fcvtzu_ds, uint64_t,     , helper_vfp_touizd)
+DO_ZPZ_FP(sve_fcvtzu_dd, uint64_t,     , vfp_float64_to_uint64_rtz)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 37ad1c9459..be589a1cf2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3970,6 +3970,76 @@ static bool trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sd);
 }
 
+static bool trans_FCVTZS_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hh);
+}
+
+static bool trans_FCVTZU_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hh);
+}
+
+static bool trans_FCVTZS_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hs);
+}
+
+static bool trans_FCVTZU_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hs);
+}
+
+static bool trans_FCVTZS_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hd);
+}
+
+static bool trans_FCVTZU_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hd);
+}
+
+static bool trans_FCVTZS_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ss);
+}
+
+static bool trans_FCVTZU_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ss);
+}
+
+static bool trans_FCVTZS_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_sd);
+}
+
+static bool trans_FCVTZU_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_sd);
+}
+
+static bool trans_FCVTZS_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ds);
+}
+
+static bool trans_FCVTZU_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ds);
+}
+
+static bool trans_FCVTZS_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_dd);
+}
+
+static bool trans_FCVTZU_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_dd);
+}
+
 static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 18c174e92d..ddfb5316c9 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -829,6 +829,22 @@ FCVT_hd         01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
 FCVT_ds         01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
 FCVT_sd         01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
 
+# SVE floating-point convert to integer
+FCVTZS_hh       01100101 01 011 01 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hh       01100101 01 011 01 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hs       01100101 01 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hs       01100101 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hd       01100101 01 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hd       01100101 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ss       01100101 10 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ss       01100101 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ds       01100101 11 011 00 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ds       01100101 11 011 00 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_sd       01100101 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_sd       01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_dd       01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_dd       01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+
 # SVE integer convert to floating-point
 SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
 SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-- 
2.17.1
