Received: from eggs.gnu.org ([2001:4830:134:3::10]:41070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wF-0007dn-OV
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wD-0007RS-4t
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:27 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:40331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wC-0007Ql-DC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:24 -0400
Received: by mail-pf0-x230.google.com with SMTP id f189-v6so1051980pfa.7
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:49 -0700
Message-Id: <20180516223007.10256-10-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 09/27] target/arm: Implement SVE Integer
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Excepting MOVPRFX, which isn't a reduction.  Presumably it is
placed within the group because of its encoding.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 44 ++++++++++++++++++
 target/arm/sve_helper.c    | 91 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 68 ++++++++++++++++++++++++++++
 target/arm/sve.decode      | 22 +++++++++
 4 files changed, 225 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 5b82ba1501..6b6bbeb272 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -168,6 +168,50 @@ DEF_HELPER_FLAGS_5(sve_udiv_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_udiv_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_orv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_orv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_orv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_orv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_eorv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_eorv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_eorv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_eorv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_andv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_andv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_andv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_andv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_saddv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_saddv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_saddv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_uaddv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uaddv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uaddv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uaddv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_smaxv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_smaxv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_smaxv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_smaxv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_umaxv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_umaxv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_umaxv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_umaxv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_sminv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_sminv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_sminv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_sminv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_uminv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uminv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uminv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_uminv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b8c8a06122..c1719e407a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -298,6 +298,97 @@ DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
 
 #undef DO_ZPZZ
 #undef DO_ZPZZ_D
+
+/* Two-operand reduction expander, controlled by a predicate.
+ * The difference between TYPERED and TYPERET has to do with
+ * sign-extension.  E.g. for SMAX, TYPERED must be signed,
+ * but TYPERET must be unsigned so that e.g. a 32-bit value
+ * is not sign-extended to the ABI uint64_t return type.
+ */
+/* ??? If we were to vectorize this by hand the reduction ordering
+ * would change.  For integer operands, this is perfectly fine.
+ */
+#define DO_VPZ(NAME, TYPEELT, TYPERED, TYPERET, H, INIT, OP) \
+uint64_t HELPER(NAME)(void *vn, void *vg, uint32_t desc)   \
+{                                                          \
+    intptr_t i, opr_sz = simd_oprsz(desc);                 \
+    TYPERED ret = INIT;                                    \
+    for (i = 0; i < opr_sz; ) {                            \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));    \
+        do {                                               \
+            if (pg & 1) {                                  \
+                TYPEELT nn = *(TYPEELT *)(vn + H(i));      \
+                ret = OP(ret, nn);                         \
+            }                                              \
+            i += sizeof(TYPEELT), pg >>= sizeof(TYPEELT);  \
+        } while (i & 15);                                  \
+    }                                                      \
+    return (TYPERET)ret;                                   \
+}
+
+#define DO_VPZ_D(NAME, TYPEE, TYPER, INIT, OP)             \
+uint64_t HELPER(NAME)(void *vn, void *vg, uint32_t desc)   \
+{                                                          \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;             \
+    TYPEE *n = vn;                                         \
+    uint8_t *pg = vg;                                      \
+    TYPER ret = INIT;                                      \
+    for (i = 0; i < opr_sz; i += 1) {                      \
+        if (pg[H1(i)] & 1) {                               \
+            TYPEE nn = n[i];                               \
+            ret = OP(ret, nn);                             \
+        }                                                  \
+    }                                                      \
+    return ret;                                            \
+}
+
+DO_VPZ(sve_orv_b, uint8_t, uint8_t, uint8_t, H1, 0, DO_ORR)
+DO_VPZ(sve_orv_h, uint16_t, uint16_t, uint16_t, H1_2, 0, DO_ORR)
+DO_VPZ(sve_orv_s, uint32_t, uint32_t, uint32_t, H1_4, 0, DO_ORR)
+DO_VPZ_D(sve_orv_d, uint64_t, uint64_t, 0, DO_ORR)
+
+DO_VPZ(sve_eorv_b, uint8_t, uint8_t, uint8_t, H1, 0, DO_EOR)
+DO_VPZ(sve_eorv_h, uint16_t, uint16_t, uint16_t, H1_2, 0, DO_EOR)
+DO_VPZ(sve_eorv_s, uint32_t, uint32_t, uint32_t, H1_4, 0, DO_EOR)
+DO_VPZ_D(sve_eorv_d, uint64_t, uint64_t, 0, DO_EOR)
+
+DO_VPZ(sve_andv_b, uint8_t, uint8_t, uint8_t, H1, -1, DO_AND)
+DO_VPZ(sve_andv_h, uint16_t, uint16_t, uint16_t, H1_2, -1, DO_AND)
+DO_VPZ(sve_andv_s, uint32_t, uint32_t, uint32_t, H1_4, -1, DO_AND)
+DO_VPZ_D(sve_andv_d, uint64_t, uint64_t, -1, DO_AND)
+
+DO_VPZ(sve_saddv_b, int8_t, uint64_t, uint64_t, H1, 0, DO_ADD)
+DO_VPZ(sve_saddv_h, int16_t, uint64_t, uint64_t, H1_2, 0, DO_ADD)
+DO_VPZ(sve_saddv_s, int32_t, uint64_t, uint64_t, H1_4, 0, DO_ADD)
+
+DO_VPZ(sve_uaddv_b, uint8_t, uint64_t, uint64_t, H1, 0, DO_ADD)
+DO_VPZ(sve_uaddv_h, uint16_t, uint64_t, uint64_t, H1_2, 0, DO_ADD)
+DO_VPZ(sve_uaddv_s, uint32_t, uint64_t, uint64_t, H1_4, 0, DO_ADD)
+DO_VPZ_D(sve_uaddv_d, uint64_t, uint64_t, 0, DO_ADD)
+
+DO_VPZ(sve_smaxv_b, int8_t, int8_t, uint8_t, H1, INT8_MIN, DO_MAX)
+DO_VPZ(sve_smaxv_h, int16_t, int16_t, uint16_t, H1_2, INT16_MIN, DO_MAX)
+DO_VPZ(sve_smaxv_s, int32_t, int32_t, uint32_t, H1_4, INT32_MIN, DO_MAX)
+DO_VPZ_D(sve_smaxv_d, int64_t, int64_t, INT64_MIN, DO_MAX)
+
+DO_VPZ(sve_umaxv_b, uint8_t, uint8_t, uint8_t, H1, 0, DO_MAX)
+DO_VPZ(sve_umaxv_h, uint16_t, uint16_t, uint16_t, H1_2, 0, DO_MAX)
+DO_VPZ(sve_umaxv_s, uint32_t, uint32_t, uint32_t, H1_4, 0, DO_MAX)
+DO_VPZ_D(sve_umaxv_d, uint64_t, uint64_t, 0, DO_MAX)
+
+DO_VPZ(sve_sminv_b, int8_t, int8_t, uint8_t, H1, INT8_MAX, DO_MIN)
+DO_VPZ(sve_sminv_h, int16_t, int16_t, uint16_t, H1_2, INT16_MAX, DO_MIN)
+DO_VPZ(sve_sminv_s, int32_t, int32_t, uint32_t, H1_4, INT32_MAX, DO_MIN)
+DO_VPZ_D(sve_sminv_d, int64_t, int64_t, INT64_MAX, DO_MIN)
+
+DO_VPZ(sve_uminv_b, uint8_t, uint8_t, uint8_t, H1, -1, DO_MIN)
+DO_VPZ(sve_uminv_h, uint16_t, uint16_t, uint16_t, H1_2, -1, DO_MIN)
+DO_VPZ(sve_uminv_s, uint32_t, uint32_t, uint32_t, H1_4, -1, DO_MIN)
+DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
+
+#undef DO_VPZ
+#undef DO_VPZ_D
+
 #undef DO_AND
 #undef DO_ORR
 #undef DO_EOR
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index bba04ea0af..66ef01712d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -295,6 +295,74 @@ static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 
 #undef DO_ZPZZ
 
+/*
+ *** SVE Integer Reduction Group
+ */
+
+typedef void gen_helper_gvec_reduc(TCGv_i64, TCGv_ptr, TCGv_ptr, TCGv_i32);
+static bool do_vpz_ool(DisasContext *s, arg_rpr_esz *a,
+                       gen_helper_gvec_reduc *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr t_zn, t_pg;
+    TCGv_i32 desc;
+    TCGv_i64 temp;
+
+    if (fn == NULL) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+    temp = tcg_temp_new_i64();
+    t_zn = tcg_temp_new_ptr();
+    t_pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
+    fn(temp, t_zn, t_pg, desc);
+    tcg_temp_free_ptr(t_zn);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(desc);
+
+    write_fp_dreg(s, a->rd, temp);
+    tcg_temp_free_i64(temp);
+    return true;
+}
+
+#define DO_VPZ(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a, uint32_t insn) \
+{                                                                        \
+    static gen_helper_gvec_reduc * const fns[4] = {                      \
+        gen_helper_sve_##name##_b, gen_helper_sve_##name##_h,            \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,            \
+    };                                                                   \
+    return do_vpz_ool(s, a, fns[a->esz]);                                \
+}
+
+DO_VPZ(ORV, orv)
+DO_VPZ(ANDV, andv)
+DO_VPZ(EORV, eorv)
+
+DO_VPZ(UADDV, uaddv)
+DO_VPZ(SMAXV, smaxv)
+DO_VPZ(UMAXV, umaxv)
+DO_VPZ(SMINV, sminv)
+DO_VPZ(UMINV, uminv)
+
+static bool trans_SADDV(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_reduc * const fns[4] = {
+        gen_helper_sve_saddv_b, gen_helper_sve_saddv_h,
+        gen_helper_sve_saddv_s, NULL
+    };
+    return do_vpz_ool(s, a, fns[a->esz]);
+}
+
+#undef DO_VPZ
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index c444357c82..ba27ff0979 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -36,6 +36,7 @@
 &rr_esz         rd rn esz
 &rri            rd rn imm
 &rrr_esz        rd rn rm esz
+&rpr_esz        rd pg rn esz
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
 
@@ -61,6 +62,9 @@
 @rdm_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
                 &rprr_esz rm=%reg_movprfx
 
+# One register operand, with governing predicate, vector element size
+@rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -101,6 +105,24 @@ UDIV_zpzz       00000100 .. 010 101 000 ... ..... .....   @rdn_pg_rm
 SDIV_zpzz       00000100 .. 010 110 000 ... ..... .....   @rdm_pg_rn # SDIVR
 UDIV_zpzz       00000100 .. 010 111 000 ... ..... .....   @rdm_pg_rn # UDIVR
 
+### SVE Integer Reduction Group
+
+# SVE bitwise logical reduction (predicated)
+ORV             00000100 .. 011 000 001 ... ..... .....         @rd_pg_rn
+EORV            00000100 .. 011 001 001 ... ..... .....         @rd_pg_rn
+ANDV            00000100 .. 011 010 001 ... ..... .....         @rd_pg_rn
+
+# SVE integer add reduction (predicated)
+# Note that saddv requires size != 3.
+UADDV           00000100 .. 000 001 001 ... ..... .....         @rd_pg_rn
+SADDV           00000100 .. 000 000 001 ... ..... .....         @rd_pg_rn
+
+# SVE integer min/max reduction (predicated)
+SMAXV           00000100 .. 001 000 001 ... ..... .....         @rd_pg_rn
+UMAXV           00000100 .. 001 001 001 ... ..... .....         @rd_pg_rn
+SMINV           00000100 .. 001 010 001 ... ..... .....         @rd_pg_rn
+UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0
