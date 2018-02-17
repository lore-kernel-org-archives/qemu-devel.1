Received: from eggs.gnu.org ([2001:4830:134:3::10]:40545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A4-0001Fz-10
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A2-00020l-Ei
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:36 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7A2-000201-5H
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:34 -0500
Received: by mail-pf0-x244.google.com with SMTP id a6so591965pfi.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:58 -0800
Message-Id: <20180217182323.25885-43-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 42/67] target/arm: Implement SVE Integer
 Wide Immediate - Unpredicated Group
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
 target/arm/helper-sve.h    |  25 +++++++++
 target/arm/sve_helper.c    |  41 ++++++++++++++
 target/arm/translate-sve.c | 135 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  26 +++++++++
 4 files changed, 227 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 1863106d0f..97bfe0f47b 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -680,3 +680,28 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve_while, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+
+DEF_HELPER_FLAGS_4(sve_subri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_subri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_subri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_subri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(sve_smaxi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smaxi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smaxi_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smaxi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(sve_smini_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smini_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smini_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_smini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(sve_umaxi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umaxi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umaxi_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umaxi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(sve_umini_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umini_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umini_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_umini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 80b78da834..4f45f11bff 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -803,6 +803,46 @@ DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
 #undef DO_VPZ
 #undef DO_VPZ_D
 
+/* Two vector operand, one scalar operand, unpredicated.  */
+#define DO_ZZI(NAME, TYPE, OP)                                       \
+void HELPER(NAME)(void *vd, void *vn, uint64_t s64, uint32_t desc)   \
+{                                                                    \
+    intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(TYPE);            \
+    TYPE s = s64, *d = vd, *n = vn;                                  \
+    for (i = 0; i < opr_sz; ++i) {                                   \
+        d[i] = OP(n[i], s);                                          \
+    }                                                                \
+}
+
+#define DO_SUBR(X, Y)   (Y - X)
+
+DO_ZZI(sve_subri_b, uint8_t, DO_SUBR)
+DO_ZZI(sve_subri_h, uint16_t, DO_SUBR)
+DO_ZZI(sve_subri_s, uint32_t, DO_SUBR)
+DO_ZZI(sve_subri_d, uint64_t, DO_SUBR)
+
+DO_ZZI(sve_smaxi_b, int8_t, DO_MAX)
+DO_ZZI(sve_smaxi_h, int16_t, DO_MAX)
+DO_ZZI(sve_smaxi_s, int32_t, DO_MAX)
+DO_ZZI(sve_smaxi_d, int64_t, DO_MAX)
+
+DO_ZZI(sve_smini_b, int8_t, DO_MIN)
+DO_ZZI(sve_smini_h, int16_t, DO_MIN)
+DO_ZZI(sve_smini_s, int32_t, DO_MIN)
+DO_ZZI(sve_smini_d, int64_t, DO_MIN)
+
+DO_ZZI(sve_umaxi_b, uint8_t, DO_MAX)
+DO_ZZI(sve_umaxi_h, uint16_t, DO_MAX)
+DO_ZZI(sve_umaxi_s, uint32_t, DO_MAX)
+DO_ZZI(sve_umaxi_d, uint64_t, DO_MAX)
+
+DO_ZZI(sve_umini_b, uint8_t, DO_MIN)
+DO_ZZI(sve_umini_h, uint16_t, DO_MIN)
+DO_ZZI(sve_umini_s, uint32_t, DO_MIN)
+DO_ZZI(sve_umini_d, uint64_t, DO_MIN)
+
+#undef DO_ZZI
+
 #undef DO_AND
 #undef DO_ORR
 #undef DO_EOR
@@ -817,6 +857,7 @@ DO_VPZ_D(sve_uminv_d, uint64_t, uint64_t, -1, DO_MIN)
 #undef DO_ASR
 #undef DO_LSR
 #undef DO_LSL
+#undef DO_SUBR
 
 /* Similar to the ARM LastActiveElement pseudocode function, except the
    result is multiplied by the element size.  This includes the not found
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7571d02237..72abcb543a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -81,6 +81,11 @@ static inline int expand_imm_sh8s(int x)
     return (int8_t)x << (x & 0x100 ? 8 : 0);
 }
 
+static inline int expand_imm_sh8u(int x)
+{
+    return (uint8_t)x << (x & 0x100 ? 8 : 0);
+}
+
 /*
  * Include the generated decoder.
  */
@@ -2974,6 +2979,136 @@ static void trans_DUP_i(DisasContext *s, arg_DUP_i *a, uint32_t insn)
     tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
 }
 
+static void trans_ADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+    tcg_gen_gvec_addi(a->esz, vec_full_reg_offset(s, a->rd),
+                      vec_full_reg_offset(s, a->rn), a->imm, vsz, vsz);
+}
+
+static void trans_SUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    a->imm = -a->imm;
+    trans_ADD_zzi(s, a, insn);
+}
+
+static void trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    static const GVecGen2s op[4] = {
+        { .fni8 = tcg_gen_vec_sub8_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_sve_subri_b,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_8,
+          .scalar_first = true },
+        { .fni8 = tcg_gen_vec_sub16_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_sve_subri_h,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_16,
+          .scalar_first = true },
+        { .fni4 = tcg_gen_sub_i32,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_sve_subri_s,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_32,
+          .scalar_first = true },
+        { .fni8 = tcg_gen_sub_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_sve_subri_d,
+          .opc = INDEX_op_sub_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64,
+          .scalar_first = true }
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_i64 c;
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+    c = tcg_const_i64(a->imm);
+    tcg_gen_gvec_2s(vec_full_reg_offset(s, a->rd),
+                    vec_full_reg_offset(s, a->rn), vsz, vsz, c, &op[a->esz]);
+    tcg_temp_free_i64(c);
+}
+
+static void trans_MUL_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_muli(a->esz, vec_full_reg_offset(s, a->rd),
+                      vec_full_reg_offset(s, a->rn), a->imm, vsz, vsz);
+}
+
+static void do_zzi_sat(DisasContext *s, arg_rri_esz *a, uint32_t insn,
+                       bool u, bool d)
+{
+    TCGv_i64 val;
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+    val = tcg_const_i64(a->imm);
+    do_sat_addsub_vec(s, a->esz, a->rd, a->rn, val, u, d);
+    tcg_temp_free_i64(val);
+}
+
+static void trans_SQADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_zzi_sat(s, a, insn, false, false);
+}
+
+static void trans_UQADD_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_zzi_sat(s, a, insn, true, false);
+}
+
+static void trans_SQSUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_zzi_sat(s, a, insn, false, true);
+}
+
+static void trans_UQSUB_zzi(DisasContext *s, arg_rri_esz *a, uint32_t insn)
+{
+    do_zzi_sat(s, a, insn, true, true);
+}
+
+static void do_zzi_ool(DisasContext *s, arg_rri_esz *a, gen_helper_gvec_2i *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_i64 c = tcg_const_i64(a->imm);
+
+    tcg_gen_gvec_2i_ool(vec_full_reg_offset(s, a->rd),
+                        vec_full_reg_offset(s, a->rn),
+                        c, vsz, vsz, 0, fn);
+    tcg_temp_free_i64(c);
+}
+
+#define DO_ZZI(NAME, name) \
+static void trans_##NAME##_zzi(DisasContext *s, arg_rri_esz *a,         \
+                               uint32_t insn)                           \
+{                                                                       \
+    static gen_helper_gvec_2i * const fns[4] = {                        \
+        gen_helper_sve_##name##i_b, gen_helper_sve_##name##i_h,         \
+        gen_helper_sve_##name##i_s, gen_helper_sve_##name##i_d,         \
+    };                                                                  \
+    do_zzi_ool(s, a, fns[a->esz]);                                      \
+}
+
+DO_ZZI(SMAX, smax)
+DO_ZZI(UMAX, umax)
+DO_ZZI(SMIN, smin)
+DO_ZZI(UMIN, umin)
+
+#undef DO_ZZI
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ea1bfe7579..1ede152360 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -43,6 +43,8 @@
 
 # Signed 8-bit immediate, optionally shifted left by 8.
 %sh8_i8s		5:9 !function=expand_imm_sh8s
+# Unsigned 8-bit immediate, optionally shifted left by 8.
+%sh8_i8u		5:9 !function=expand_imm_sh8u
 
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
@@ -96,6 +98,12 @@
 @pd_pn_pm	........ esz:2 .. rm:4 ....... rn:4 . rd:4	&rrr_esz
 @rdn_rm		........ esz:2 ...... ...... rm:5 rd:5 \
 		&rrr_esz rn=%reg_movprfx
+@rdn_sh_i8u	........ esz:2 ...... ...... ..... rd:5 \
+		&rri_esz rn=%reg_movprfx imm=%sh8_i8u
+@rdn_i8u	........ esz:2 ...... ... imm:8 rd:5 \
+		&rri_esz rn=%reg_movprfx
+@rdn_i8s	........ esz:2 ...... ... imm:s8 rd:5 \
+		&rri_esz rn=%reg_movprfx
 
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm	........ ... rm:5 .... imm:2 rn:5 rd:5		&rrri
@@ -630,6 +638,24 @@ FDUP		00100101 esz:2 111 00 1110 imm:8 rd:5
 # SVE broadcast integer immediate (unpredicated)
 DUP_i		00100101 esz:2 111 00 011 . ........ rd:5	imm=%sh8_i8s
 
+# SVE integer add/subtract immediate (unpredicated)
+ADD_zzi		00100101 .. 100 000 11 . ........ .....		@rdn_sh_i8u
+SUB_zzi		00100101 .. 100 001 11 . ........ .....		@rdn_sh_i8u
+SUBR_zzi	00100101 .. 100 011 11 . ........ .....		@rdn_sh_i8u
+SQADD_zzi	00100101 .. 100 100 11 . ........ .....		@rdn_sh_i8u
+UQADD_zzi	00100101 .. 100 101 11 . ........ .....		@rdn_sh_i8u
+SQSUB_zzi	00100101 .. 100 110 11 . ........ .....		@rdn_sh_i8u
+UQSUB_zzi	00100101 .. 100 111 11 . ........ .....		@rdn_sh_i8u
+
+# SVE integer min/max immediate (unpredicated)
+SMAX_zzi	00100101 .. 101 000 110 ........ .....		@rdn_i8s
+UMAX_zzi	00100101 .. 101 001 110 ........ .....		@rdn_i8u
+SMIN_zzi	00100101 .. 101 010 110 ........ .....		@rdn_i8s
+UMIN_zzi	00100101 .. 101 011 110 ........ .....		@rdn_i8u
+
+# SVE integer multiply immediate (unpredicated)
+MUL_zzi		00100101 .. 110 000 110 ........ .....		@rdn_i8s
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.14.3
