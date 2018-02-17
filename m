Received: from eggs.gnu.org ([2001:4830:134:3::10]:41121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7Ag-00024M-QM
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7Af-0002NF-8w
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:14 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7Ae-0002MW-Ok
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:25:13 -0500
Received: by mail-pf0-x243.google.com with SMTP id a6so592302pfi.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:25:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:21 -0800
Message-Id: <20180217182323.25885-66-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 65/67] target/arm: Implement SVE
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 30 ++++++++++++++++++++
 target/arm/sve_helper.c    | 16 +++++++++++
 target/arm/translate-sve.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 16 +++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index bac4bfdc60..0f5fea9045 100644
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
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9db01ac2f2..09f5c77254 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3184,6 +3184,22 @@ DO_ZPZ_FP_D(sve_fcvt_hd, uint64_t, float16_to_float64_ieee)
 DO_ZPZ_FP_D(sve_fcvt_ds, uint64_t, float64_to_float32)
 DO_ZPZ_FP_D(sve_fcvt_sd, uint64_t, float32_to_float64)
 
+DO_ZPZ_FP(sve_fcvtzs_hh, uint16_t, H1_2, float16_to_int16_round_to_zero)
+DO_ZPZ_FP(sve_fcvtzs_hs, uint32_t, H1_4, float16_to_int32_round_to_zero)
+DO_ZPZ_FP(sve_fcvtzs_ss, uint32_t, H1_4, float32_to_int32_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzs_hd, uint64_t, float16_to_int64_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzs_sd, uint64_t, float32_to_int64_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzs_ds, uint64_t, float64_to_int32_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzs_dd, uint64_t, float64_to_int64_round_to_zero)
+
+DO_ZPZ_FP(sve_fcvtzu_hh, uint16_t, H1_2, float16_to_uint16_round_to_zero)
+DO_ZPZ_FP(sve_fcvtzu_hs, uint32_t, H1_4, float16_to_uint32_round_to_zero)
+DO_ZPZ_FP(sve_fcvtzu_ss, uint32_t, H1_4, float32_to_uint32_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzu_hd, uint64_t, float16_to_uint64_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzu_sd, uint64_t, float32_to_uint64_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzu_ds, uint64_t, float64_to_uint32_round_to_zero)
+DO_ZPZ_FP_D(sve_fcvtzu_dd, uint64_t, float64_to_uint64_round_to_zero)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 361d545965..bc865dfd15 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3681,6 +3681,76 @@ static void trans_FCVT_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sd);
 }
 
+static void trans_FCVTZS_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hh);
+}
+
+static void trans_FCVTZU_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hh);
+}
+
+static void trans_FCVTZS_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hs);
+}
+
+static void trans_FCVTZU_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hs);
+}
+
+static void trans_FCVTZS_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzs_hd);
+}
+
+static void trans_FCVTZU_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvtzu_hd);
+}
+
+static void trans_FCVTZS_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ss);
+}
+
+static void trans_FCVTZU_ss(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ss);
+}
+
+static void trans_FCVTZS_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_sd);
+}
+
+static void trans_FCVTZU_sd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_sd);
+}
+
+static void trans_FCVTZS_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_ds);
+}
+
+static void trans_FCVTZU_ds(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_ds);
+}
+
+static void trans_FCVTZS_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzs_dd);
+}
+
+static void trans_FCVTZU_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvtzu_dd);
+}
+
 static void trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index d44cf17fc8..92dda3a241 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -832,6 +832,22 @@ FCVT_hd		01100101 11 0010 01 101 ... ..... .....		@rd_pg_rn_e0
 FCVT_ds		01100101 11 0010 10 101 ... ..... .....		@rd_pg_rn_e0
 FCVT_sd		01100101 11 0010 11 101 ... ..... .....		@rd_pg_rn_e0
 
+# SVE floating-point convert to integer
+FCVTZS_hh	01100101 01 011 01 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_hh	01100101 01 011 01 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_hs	01100101 01 011 10 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_hs	01100101 01 011 10 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_hd	01100101 01 011 11 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_hd	01100101 01 011 11 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_ss	01100101 10 011 10 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_ss	01100101 10 011 10 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_ds	01100101 11 011 00 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_ds	01100101 11 011 00 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_sd	01100101 11 011 10 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_sd	01100101 11 011 10 1 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZS_dd	01100101 11 011 11 0 101 ... ..... .....	@rd_pg_rn_e0
+FCVTZU_dd	01100101 11 011 11 1 101 ... ..... .....	@rd_pg_rn_e0
+
 # SVE integer convert to floating-point
 SCVTF_hh	01100101 01 010 01 0 101 ... ..... .....	@rd_pg_rn_e0
 SCVTF_sh	01100101 01 010 10 0 101 ... ..... .....	@rd_pg_rn_e0
-- 
2.14.3
