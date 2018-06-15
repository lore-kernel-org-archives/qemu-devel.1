Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfg-0001sD-CD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfe-0006O6-Br
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfd-0006My-VJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfc-0003nc-Fs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:08 +0100
Message-Id: <20180615142521.19143-31-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/43] target/arm: Implement SVE Integer Compare
 - Immediate Group
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
Message-id: 20180613015641.5667-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 44 +++++++++++++++++++
 target/arm/sve_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 66 ++++++++++++++++++++++++++++
 target/arm/sve.decode      | 23 ++++++++++
 4 files changed, 221 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6ffd1fbe8ef..ae38c0a4bee 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -605,6 +605,50 @@ DEF_HELPER_FLAGS_5(sve_cmplo_ppzw_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_cmpls_ppzw_s, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_cmpeq_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpne_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpgt_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpge_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplt_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmple_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphs_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphi_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplo_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpls_ppzi_b, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_cmpeq_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpne_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpgt_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpge_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplt_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmple_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphs_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphi_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplo_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpls_ppzi_h, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_cmpeq_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpne_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpgt_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpge_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplt_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmple_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphs_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphi_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplo_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpls_ppzi_s, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_cmpeq_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpne_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpgt_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpge_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplt_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmple_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphs_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmphi_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmplo_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_cmpls_ppzi_d, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d11f591661e..c1d95edfcad 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2388,3 +2388,91 @@ DO_CMP_PPZW_S(sve_cmpls_ppzw_s, uint32_t, uint64_t, <=)
 #undef DO_CMP_PPZW_H
 #undef DO_CMP_PPZW_S
 #undef DO_CMP_PPZW
+
+/* Similar, but the second source is immediate.  */
+#define DO_CMP_PPZI(NAME, TYPE, OP, H, MASK)                         \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)   \
+{                                                                    \
+    intptr_t opr_sz = simd_oprsz(desc);                              \
+    uint32_t flags = PREDTEST_INIT;                                  \
+    TYPE mm = simd_data(desc);                                       \
+    intptr_t i = opr_sz;                                             \
+    do {                                                             \
+        uint64_t out = 0, pg;                                        \
+        do {                                                         \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);                 \
+            TYPE nn = *(TYPE *)(vn + H(i));                          \
+            out |= nn OP mm;                                         \
+        } while (i & 63);                                            \
+        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                    \
+        out &= pg;                                                   \
+        *(uint64_t *)(vd + (i >> 3)) = out;                          \
+        flags = iter_predtest_bwd(out, pg, flags);                   \
+    } while (i > 0);                                                 \
+    return flags;                                                    \
+}
+
+#define DO_CMP_PPZI_B(NAME, TYPE, OP) \
+    DO_CMP_PPZI(NAME, TYPE, OP, H1,   0xffffffffffffffffull)
+#define DO_CMP_PPZI_H(NAME, TYPE, OP) \
+    DO_CMP_PPZI(NAME, TYPE, OP, H1_2, 0x5555555555555555ull)
+#define DO_CMP_PPZI_S(NAME, TYPE, OP) \
+    DO_CMP_PPZI(NAME, TYPE, OP, H1_4, 0x1111111111111111ull)
+#define DO_CMP_PPZI_D(NAME, TYPE, OP) \
+    DO_CMP_PPZI(NAME, TYPE, OP,     , 0x0101010101010101ull)
+
+DO_CMP_PPZI_B(sve_cmpeq_ppzi_b, uint8_t,  ==)
+DO_CMP_PPZI_H(sve_cmpeq_ppzi_h, uint16_t, ==)
+DO_CMP_PPZI_S(sve_cmpeq_ppzi_s, uint32_t, ==)
+DO_CMP_PPZI_D(sve_cmpeq_ppzi_d, uint64_t, ==)
+
+DO_CMP_PPZI_B(sve_cmpne_ppzi_b, uint8_t,  !=)
+DO_CMP_PPZI_H(sve_cmpne_ppzi_h, uint16_t, !=)
+DO_CMP_PPZI_S(sve_cmpne_ppzi_s, uint32_t, !=)
+DO_CMP_PPZI_D(sve_cmpne_ppzi_d, uint64_t, !=)
+
+DO_CMP_PPZI_B(sve_cmpgt_ppzi_b, int8_t,  >)
+DO_CMP_PPZI_H(sve_cmpgt_ppzi_h, int16_t, >)
+DO_CMP_PPZI_S(sve_cmpgt_ppzi_s, int32_t, >)
+DO_CMP_PPZI_D(sve_cmpgt_ppzi_d, int64_t, >)
+
+DO_CMP_PPZI_B(sve_cmpge_ppzi_b, int8_t,  >=)
+DO_CMP_PPZI_H(sve_cmpge_ppzi_h, int16_t, >=)
+DO_CMP_PPZI_S(sve_cmpge_ppzi_s, int32_t, >=)
+DO_CMP_PPZI_D(sve_cmpge_ppzi_d, int64_t, >=)
+
+DO_CMP_PPZI_B(sve_cmphi_ppzi_b, uint8_t,  >)
+DO_CMP_PPZI_H(sve_cmphi_ppzi_h, uint16_t, >)
+DO_CMP_PPZI_S(sve_cmphi_ppzi_s, uint32_t, >)
+DO_CMP_PPZI_D(sve_cmphi_ppzi_d, uint64_t, >)
+
+DO_CMP_PPZI_B(sve_cmphs_ppzi_b, uint8_t,  >=)
+DO_CMP_PPZI_H(sve_cmphs_ppzi_h, uint16_t, >=)
+DO_CMP_PPZI_S(sve_cmphs_ppzi_s, uint32_t, >=)
+DO_CMP_PPZI_D(sve_cmphs_ppzi_d, uint64_t, >=)
+
+DO_CMP_PPZI_B(sve_cmplt_ppzi_b, int8_t,  <)
+DO_CMP_PPZI_H(sve_cmplt_ppzi_h, int16_t, <)
+DO_CMP_PPZI_S(sve_cmplt_ppzi_s, int32_t, <)
+DO_CMP_PPZI_D(sve_cmplt_ppzi_d, int64_t, <)
+
+DO_CMP_PPZI_B(sve_cmple_ppzi_b, int8_t,  <=)
+DO_CMP_PPZI_H(sve_cmple_ppzi_h, int16_t, <=)
+DO_CMP_PPZI_S(sve_cmple_ppzi_s, int32_t, <=)
+DO_CMP_PPZI_D(sve_cmple_ppzi_d, int64_t, <=)
+
+DO_CMP_PPZI_B(sve_cmplo_ppzi_b, uint8_t,  <)
+DO_CMP_PPZI_H(sve_cmplo_ppzi_h, uint16_t, <)
+DO_CMP_PPZI_S(sve_cmplo_ppzi_s, uint32_t, <)
+DO_CMP_PPZI_D(sve_cmplo_ppzi_d, uint64_t, <)
+
+DO_CMP_PPZI_B(sve_cmpls_ppzi_b, uint8_t,  <=)
+DO_CMP_PPZI_H(sve_cmpls_ppzi_h, uint16_t, <=)
+DO_CMP_PPZI_S(sve_cmpls_ppzi_s, uint32_t, <=)
+DO_CMP_PPZI_D(sve_cmpls_ppzi_d, uint64_t, <=)
+
+#undef DO_CMP_PPZI_B
+#undef DO_CMP_PPZI_H
+#undef DO_CMP_PPZI_S
+#undef DO_CMP_PPZI_D
+#undef DO_CMP_PPZI
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 1510af6ece8..00481e92dee 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -34,6 +34,8 @@
 #include "translate-a64.h"
 
 
+typedef void gen_helper_gvec_flags_3(TCGv_i32, TCGv_ptr, TCGv_ptr,
+                                     TCGv_ptr, TCGv_i32);
 typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
                                      TCGv_ptr, TCGv_ptr, TCGv_i32);
 
@@ -2787,6 +2789,70 @@ DO_PPZW(CMPLS, cmpls)
 
 #undef DO_PPZW
 
+/*
+ *** SVE Integer Compare - Immediate Groups
+ */
+
+static bool do_ppzi_flags(DisasContext *s, arg_rpri_esz *a,
+                          gen_helper_gvec_flags_3 *gen_fn)
+{
+    TCGv_ptr pd, zn, pg;
+    unsigned vsz;
+    TCGv_i32 t;
+
+    if (gen_fn == NULL) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vsz = vec_full_reg_size(s);
+    t = tcg_const_i32(simd_desc(vsz, vsz, a->imm));
+    pd = tcg_temp_new_ptr();
+    zn = tcg_temp_new_ptr();
+    pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(pd, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(zn, cpu_env, vec_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
+
+    gen_fn(t, pd, zn, pg, t);
+
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(zn);
+    tcg_temp_free_ptr(pg);
+
+    do_pred_flags(t);
+
+    tcg_temp_free_i32(t);
+    return true;
+}
+
+#define DO_PPZI(NAME, name) \
+static bool trans_##NAME##_ppzi(DisasContext *s, arg_rpri_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_gvec_flags_3 * const fns[4] = {                     \
+        gen_helper_sve_##name##_ppzi_b, gen_helper_sve_##name##_ppzi_h,   \
+        gen_helper_sve_##name##_ppzi_s, gen_helper_sve_##name##_ppzi_d,   \
+    };                                                                    \
+    return do_ppzi_flags(s, a, fns[a->esz]);                              \
+}
+
+DO_PPZI(CMPEQ, cmpeq)
+DO_PPZI(CMPNE, cmpne)
+DO_PPZI(CMPGT, cmpgt)
+DO_PPZI(CMPGE, cmpge)
+DO_PPZI(CMPHI, cmphi)
+DO_PPZI(CMPHS, cmphs)
+DO_PPZI(CMPLT, cmplt)
+DO_PPZI(CMPLE, cmple)
+DO_PPZI(CMPLO, cmplo)
+DO_PPZI(CMPLS, cmpls)
+
+#undef DO_PPZI
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 76a42193e4b..9bc383b085c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -131,6 +131,11 @@
 @rdn_dbm        ........ .. .... dbm:13 rd:5 \
                 &rr_dbm rn=%reg_movprfx
 
+# Predicate output, vector and immediate input,
+# controlling predicate, element size.
+@pd_pg_rn_i7    ........ esz:2 . imm:7 . pg:3 rn:5 . rd:4       &rpri_esz
+@pd_pg_rn_i5    ........ esz:2 . imm:s5 ... pg:3 rn:5 . rd:4    &rpri_esz
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -496,6 +501,24 @@ CMPHI_ppzw      00100100 .. 0 ..... 110 ... ..... 1 ....        @pd_pg_rn_rm
 CMPLO_ppzw      00100100 .. 0 ..... 111 ... ..... 0 ....        @pd_pg_rn_rm
 CMPLS_ppzw      00100100 .. 0 ..... 111 ... ..... 1 ....        @pd_pg_rn_rm
 
+### SVE Integer Compare - Unsigned Immediate Group
+
+# SVE integer compare with unsigned immediate
+CMPHS_ppzi      00100100 .. 1 ....... 0 ... ..... 0 ....      @pd_pg_rn_i7
+CMPHI_ppzi      00100100 .. 1 ....... 0 ... ..... 1 ....      @pd_pg_rn_i7
+CMPLO_ppzi      00100100 .. 1 ....... 1 ... ..... 0 ....      @pd_pg_rn_i7
+CMPLS_ppzi      00100100 .. 1 ....... 1 ... ..... 1 ....      @pd_pg_rn_i7
+
+### SVE Integer Compare - Signed Immediate Group
+
+# SVE integer compare with signed immediate
+CMPGE_ppzi      00100101 .. 0 ..... 000 ... ..... 0 ....      @pd_pg_rn_i5
+CMPGT_ppzi      00100101 .. 0 ..... 000 ... ..... 1 ....      @pd_pg_rn_i5
+CMPLT_ppzi      00100101 .. 0 ..... 001 ... ..... 0 ....      @pd_pg_rn_i5
+CMPLE_ppzi      00100101 .. 0 ..... 001 ... ..... 1 ....      @pd_pg_rn_i5
+CMPEQ_ppzi      00100101 .. 0 ..... 100 ... ..... 0 ....      @pd_pg_rn_i5
+CMPNE_ppzi      00100101 .. 0 ..... 100 ... ..... 1 ....      @pd_pg_rn_i5
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
