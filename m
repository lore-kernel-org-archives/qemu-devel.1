Received: from eggs.gnu.org ([2001:4830:134:3::10]:34032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumu-0007Zf-8E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYums-000734-AE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYumr-000707-WC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYumq-0004gm-TE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:21 +0100
Message-Id: <20180629145347.652-30-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 29/55] target/arm: Implement SVE floating-point
 convert precision
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
Message-id: 20180627043328.11531-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 13 +++++++++
 target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 30 +++++++++++++++++++++
 target/arm/sve.decode      |  8 ++++++
 4 files changed, 106 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index aca137fc37d..4c379dbb057 100644
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
index 79358c804bd..4b36c1eecf9 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3147,6 +3147,61 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
     } while (i != 0);                                                 \
 }
 
+/* SVE fp16 conversions always use IEEE mode.  Like AdvSIMD, they ignore
+ * FZ16.  When converting from fp16, this affects flushing input denormals;
+ * when converting to fp16, this affects flushing output denormals.
+ */
+static inline float32 sve_f16_to_f32(float16 f, float_status *fpst)
+{
+    flag save = get_flush_inputs_to_zero(fpst);
+    float32 ret;
+
+    set_flush_inputs_to_zero(false, fpst);
+    ret = float16_to_float32(f, true, fpst);
+    set_flush_inputs_to_zero(save, fpst);
+    return ret;
+}
+
+static inline float64 sve_f16_to_f64(float16 f, float_status *fpst)
+{
+    flag save = get_flush_inputs_to_zero(fpst);
+    float64 ret;
+
+    set_flush_inputs_to_zero(false, fpst);
+    ret = float16_to_float64(f, true, fpst);
+    set_flush_inputs_to_zero(save, fpst);
+    return ret;
+}
+
+static inline float16 sve_f32_to_f16(float32 f, float_status *fpst)
+{
+    flag save = get_flush_to_zero(fpst);
+    float16 ret;
+
+    set_flush_to_zero(false, fpst);
+    ret = float32_to_float16(f, true, fpst);
+    set_flush_to_zero(save, fpst);
+    return ret;
+}
+
+static inline float16 sve_f64_to_f16(float64 f, float_status *fpst)
+{
+    flag save = get_flush_to_zero(fpst);
+    float16 ret;
+
+    set_flush_to_zero(false, fpst);
+    ret = float64_to_float16(f, true, fpst);
+    set_flush_to_zero(save, fpst);
+    return ret;
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
index 50c54c171b3..f2a9057369d 100644
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
index fdcc252eaa7..18c174e92df 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -821,6 +821,14 @@ FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
 
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
