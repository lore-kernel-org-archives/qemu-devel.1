Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooG-0004is-Cb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooF-0003MF-BK
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:52 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooF-0003Lj-2f
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:51 -0400
Received: by mail-pf0-x232.google.com with SMTP id y5-v6so685998pfn.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:47 -1000
Message-Id: <20180621015359.12018-24-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 23/35] target/arm: Implement SVE
 floating-point convert precision
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
 target/arm/helper-sve.h    | 13 +++++++++++++
 target/arm/sve_helper.c    | 27 +++++++++++++++++++++++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 4 files changed, 78 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index aca137fc37..4c379dbb05 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -942,6 +942,19 @@ DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i64, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_fcvt_sh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvt_dh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvt_hs, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvt_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvt_hd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fcvt_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 3dc35d8b12..e1bbe1f550 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3147,6 +3147,33 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
     } while (i != 0);                                                 \
 }
 
+static inline float32 sve_f16_to_f32(float16 f, float_status *s)
+{
+    return float16_to_float32(f, true, s);
+}
+
+static inline float64 sve_f16_to_f64(float16 f, float_status *s)
+{
+    return float16_to_float64(f, true, s);
+}
+
+static inline float16 sve_f32_to_f16(float32 f, float_status *s)
+{
+    return float32_to_float16(f, true, s);
+}
+
+static inline float16 sve_f64_to_f16(float64 f, float_status *s)
+{
+    return float64_to_float16(f, true, s);
+}
+
+DO_ZPZ_FP(sve_fcvt_sh, uint32_t, H1_4, sve_f32_to_f16)
+DO_ZPZ_FP(sve_fcvt_hs, uint32_t, H1_4, sve_f16_to_f32)
+DO_ZPZ_FP(sve_fcvt_dh, uint64_t,     , sve_f64_to_f16)
+DO_ZPZ_FP(sve_fcvt_hd, uint64_t,     , sve_f16_to_f64)
+DO_ZPZ_FP(sve_fcvt_ds, uint64_t,     , float64_to_float32)
+DO_ZPZ_FP(sve_fcvt_sd, uint64_t,     , float32_to_float64)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fb225d56a1..c08c1263f1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3940,6 +3940,36 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
     return true;
 }
 
+static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
+}
+
+static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hs);
+}
+
+static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
+}
+
+static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hd);
+}
+
+static bool trans_FCVT_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_ds);
+}
+
+static bool trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sd);
+}
+
 static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e29c598783..fd45f51029 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -816,6 +816,14 @@ FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
 
 ### SVE FP Unary Operations Predicated Group
 
+# SVE floating-point convert precision
+FCVT_sh         01100101 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hs         01100101 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_dh         01100101 11 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_hd         01100101 11 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_ds         01100101 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVT_sd         01100101 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
+
 # SVE integer convert to floating-point
 SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
 SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-- 
2.17.1
