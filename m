Received: from eggs.gnu.org ([2001:4830:134:3::10]:39465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooO-0004oz-8g
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooK-0003Q9-Ux
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:00 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:38078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooK-0003PO-PL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:56 -0400
Received: by mail-pl0-x235.google.com with SMTP id d10-v6so757826plo.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:50 -1000
Message-Id: <20180621015359.12018-27-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 26/35] target/arm: Implement SVE
 floating-point unary operations
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
 target/arm/helper-sve.h    | 14 ++++++++++++++
 target/arm/sve_helper.c    |  8 ++++++++
 target/arm/translate-sve.c | 26 ++++++++++++++++++++++++++
 target/arm/sve.decode      |  4 ++++
 4 files changed, 52 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 36168c5bb2..891346a5ac 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -999,6 +999,20 @@ DEF_HELPER_FLAGS_5(sve_frintx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_frintx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_frecpx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frecpx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_frecpx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_fsqrt_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fsqrt_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_fsqrt_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_scvt_hh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_scvt_sh, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 3b7a2f58c1..5309cf0866 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3270,6 +3270,14 @@ DO_ZPZ_FP(sve_frintx_h, uint16_t, H1_2, float16_round_to_int)
 DO_ZPZ_FP(sve_frintx_s, uint32_t, H1_4, float32_round_to_int)
 DO_ZPZ_FP(sve_frintx_d, uint64_t,     , float64_round_to_int)
 
+DO_ZPZ_FP(sve_frecpx_h, uint16_t, H1_2, helper_frecpx_f16)
+DO_ZPZ_FP(sve_frecpx_s, uint32_t, H1_4, helper_frecpx_f32)
+DO_ZPZ_FP(sve_frecpx_d, uint64_t,     , helper_frecpx_f64)
+
+DO_ZPZ_FP(sve_fsqrt_h, uint16_t, H1_2, float16_sqrt)
+DO_ZPZ_FP(sve_fsqrt_s, uint32_t, H1_4, float32_sqrt)
+DO_ZPZ_FP(sve_fsqrt_d, uint64_t,     , float64_sqrt)
+
 DO_ZPZ_FP(sve_scvt_hh, uint16_t, H1_2, int16_to_float16)
 DO_ZPZ_FP(sve_scvt_sh, uint32_t, H1_4, int32_to_float16)
 DO_ZPZ_FP(sve_scvt_ss, uint32_t, H1_4, int32_to_float32)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 15e4f2888b..308c04de89 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4117,6 +4117,32 @@ static bool trans_FRINTA(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_frint_mode(s, a, float_round_ties_away);
 }
 
+static bool trans_FRECPX(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[3] = {
+        gen_helper_sve_frecpx_h,
+        gen_helper_sve_frecpx_s,
+        gen_helper_sve_frecpx_d
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16, fns[a->esz - 1]);
+}
+
+static bool trans_FSQRT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3_ptr * const fns[3] = {
+        gen_helper_sve_fsqrt_h,
+        gen_helper_sve_fsqrt_s,
+        gen_helper_sve_fsqrt_d
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, a->esz == MO_16, fns[a->esz - 1]);
+}
+
 static bool trans_SCVTF_hh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_scvt_hh);
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index eeab3d485f..94d7b157b4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -849,6 +849,10 @@ FRINTA          01100101 .. 000 100 101 ... ..... .....         @rd_pg_rn
 FRINTX          01100101 .. 000 110 101 ... ..... .....         @rd_pg_rn
 FRINTI          01100101 .. 000 111 101 ... ..... .....         @rd_pg_rn
 
+# SVE floating-point unary operations
+FRECPX          01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
+FSQRT           01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
+
 # SVE integer convert to floating-point
 SCVTF_hh        01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
 SCVTF_sh        01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
-- 
2.17.1
