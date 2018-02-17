Received: from eggs.gnu.org ([2001:4830:134:3::10]:41094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7Ae-00021V-N4
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7Ad-0002Li-8S
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:12 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7Ad-0002L6-1b
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:11 -0500
Received: by mail-pg0-x243.google.com with SMTP id m1so262275pgp.13
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:20 -0800
Message-Id: <20180217182323.25885-65-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 64/67] target/arm: Implement SVE
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 13 +++++++++++++
 target/arm/sve_helper.c    | 27 +++++++++++++++++++++++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 4 files changed, 78 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ce5fe24dc2..bac4bfdc60 100644
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
index 53e3516f47..9db01ac2f2 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3157,6 +3157,33 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
     }                                                           \
 }
 
+static inline float32 float16_to_float32_ieee(float16 f, float_status *s)
+{
+    return float16_to_float32(f, true, s);
+}
+
+static inline float64 float16_to_float64_ieee(float16 f, float_status *s)
+{
+    return float16_to_float64(f, true, s);
+}
+
+static inline float16 float32_to_float16_ieee(float32 f, float_status *s)
+{
+    return float32_to_float16(f, true, s);
+}
+
+static inline float16 float64_to_float16_ieee(float64 f, float_status *s)
+{
+    return float64_to_float16(f, true, s);
+}
+
+DO_ZPZ_FP(sve_fcvt_sh, uint32_t, H1_4, float32_to_float16_ieee)
+DO_ZPZ_FP(sve_fcvt_hs, uint32_t, H1_4, float16_to_float32_ieee)
+DO_ZPZ_FP_D(sve_fcvt_dh, uint64_t, float64_to_float16_ieee)
+DO_ZPZ_FP_D(sve_fcvt_hd, uint64_t, float16_to_float64_ieee)
+DO_ZPZ_FP_D(sve_fcvt_ds, uint64_t, float64_to_float32)
+DO_ZPZ_FP_D(sve_fcvt_sd, uint64_t, float32_to_float64)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e185af29e3..361d545965 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3651,6 +3651,36 @@ static void do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
     tcg_temp_free_ptr(status);
 }
 
+static void trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
+}
+
+static void trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hs);
+}
+
+static void trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
+}
+
+static void trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_hd);
+}
+
+static void trans_FCVT_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_ds);
+}
+
+static void trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sd);
+}
+
 static void trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ca54895900..d44cf17fc8 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -824,6 +824,14 @@ FNMLS_zpzzz	01100101 .. 1 ..... 111 ... ..... .....		@rdn_pg_rm_ra
 
 ### SVE FP Unary Operations Predicated Group
 
+# SVE floating-point convert precision
+FCVT_sh		01100101 10 0010 00 101 ... ..... .....		@rd_pg_rn_e0
+FCVT_hs		01100101 10 0010 01 101 ... ..... .....		@rd_pg_rn_e0
+FCVT_dh		01100101 11 0010 00 101 ... ..... .....		@rd_pg_rn_e0
+FCVT_hd		01100101 11 0010 01 101 ... ..... .....		@rd_pg_rn_e0
+FCVT_ds		01100101 11 0010 10 101 ... ..... .....		@rd_pg_rn_e0
+FCVT_sd		01100101 11 0010 11 101 ... ..... .....		@rd_pg_rn_e0
+
 # SVE integer convert to floating-point
 SCVTF_hh	01100101 01 010 01 0 101 ... ..... .....	@rd_pg_rn_e0
 SCVTF_sh	01100101 01 010 10 0 101 ... ..... .....	@rd_pg_rn_e0
-- 
2.14.3
