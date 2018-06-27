Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29h-0004Xa-BN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29f-0000uE-VY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:09 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:39451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29f-0000ti-OP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:07 -0400
Received: by mail-pf0-x22a.google.com with SMTP id s21-v6so385001pfm.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:18 -0700
Message-Id: <20180627043328.11531-26-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 25/35] target/arm: Implement SVE
 floating-point round to integral value
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
 target/arm/helper-sve.h    | 14 +++++++
 target/arm/sve_helper.c    |  8 ++++
 target/arm/translate-sve.c | 77 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  9 +++++
 4 files changed, 108 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 37fa9eb9bb..36168c5bb2 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -985,6 +985,20 @@ DEF_HELPER_FLAGS_5(sve_fcvtzu_sd, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_fcvtzu_dd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_frint_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frint_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frint_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_frintx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frintx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frintx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b6421ec19c..af8221c714 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3290,6 +3290,14 @@ DO_ZPZ_FP(sve_fcvtzu_sd, uint64_t,     , vfp_float32_to_uint64_rtz)
 DO_ZPZ_FP(sve_fcvtzu_ds, uint64_t,     , helper_vfp_touizd)
 DO_ZPZ_FP(sve_fcvtzu_dd, uint64_t,     , vfp_float64_to_uint64_rtz)
 
+DO_ZPZ_FP(sve_frint_h, uint16_t, H1_2, helper_advsimd_rinth)
+DO_ZPZ_FP(sve_frint_s, uint32_t, H1_4, helper_rints)
+DO_ZPZ_FP(sve_frint_d, uint64_t,     , helper_rintd)
+
+DO_ZPZ_FP(sve_frintx_h, uint16_t, H1_2, float16_round_to_int)
+DO_ZPZ_FP(sve_frintx_s, uint32_t, H1_4, float32_round_to_int)
+DO_ZPZ_FP(sve_frintx_d, uint64_t,     , float64_round_to_int)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index be589a1cf2..270bf9101b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4040,6 +4040,83 @@ static bool trans_FCVTZU_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_dd);
 }
 
+static gen_helper_gvec_3_ptr * const frint_fns[3] = {
+    gen_helper_sve_frint_h,
+    gen_helper_sve_frint_s,
+    gen_helper_sve_frint_d
+};
+
+static bool trans_FRINTI(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16,
+                      frint_fns[a->esz - 1]);
+}
+
+static bool trans_FRINTX(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[3] = {
+        gen_helper_sve_frintx_h,
+        gen_helper_sve_frintx_s,
+        gen_helper_sve_frintx_d
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16, fns[a->esz - 1]);
+}
+
+static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a, int mode)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_i32 tmode = tcg_const_i32(mode);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+
+        gen_helper_set_rmode(tmode, tmode, status);
+
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           pred_full_reg_offset(s, a->pg),
+                           status, vsz, vsz, 0, frint_fns[a->esz - 1]);
+
+        gen_helper_set_rmode(tmode, tmode, status);
+        tcg_temp_free_i32(tmode);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+static bool trans_FRINTN(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_frint_mode(s, a, float_round_nearest_even);
+}
+
+static bool trans_FRINTP(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_frint_mode(s, a, float_round_up);
+}
+
+static bool trans_FRINTM(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_frint_mode(s, a, float_round_down);
+}
+
+static bool trans_FRINTZ(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_frint_mode(s, a, float_round_to_zero);
+}
+
+static bool trans_FRINTA(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_frint_mode(s, a, float_round_ties_away);
+}
+
 static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ddfb5316c9..e45faaec3a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -845,6 +845,15 @@ FCVTZU_sd       01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
 FCVTZS_dd       01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
 FCVTZU_dd       01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
+# SVE floating-point round to integral value
+FRINTN          01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
+FRINTP          01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
+FRINTM          01100101 .. 000 010 101 ... ..... .....         @rd_pg_rn
+FRINTZ          01100101 .. 000 011 101 ... ..... .....         @rd_pg_rn
+FRINTA          01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
+FRINTX          01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
+FRINTI          01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
+
 # SVE integer convert to floating-point
 SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
 SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-- 
2.17.1
