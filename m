Received: from eggs.gnu.org ([2001:4830:134:3::10]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79e-0000la-9F
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79c-0001m2-Cn
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:10 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79c-0001ld-4z
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:08 -0500
Received: by mail-pl0-x244.google.com with SMTP id w21so3426672plp.11
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:41 -0800
Message-Id: <20180217182323.25885-26-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 25/67] target/arm: Implement SVE Integer
 Wide Immediate - Predicated Group
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
 target/arm/helper-sve.h    |  10 +++++
 target/arm/sve_helper.c    | 108 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  92 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  17 +++++++
 4 files changed, 227 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2831e1643b..79493ab647 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -404,6 +404,16 @@ DEF_HELPER_FLAGS_4(sve_uqaddi_s, TCG_CALL_NO_RWG, void, ptr, ptr, s64, i32)
 DEF_HELPER_FLAGS_4(sve_uqaddi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_uqsubi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
+DEF_HELPER_FLAGS_5(sve_cpy_m_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_5(sve_cpy_m_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_5(sve_cpy_m_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_5(sve_cpy_m_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(sve_cpy_z_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_cpy_z_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_cpy_z_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_cpy_z_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cfda16d520..6a95d1ec48 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1361,3 +1361,111 @@ void HELPER(sve_uqsubi_d)(void *d, void *a, uint64_t b, uint32_t desc)
         *(uint64_t *)(d + i) = (ai < b ? 0 : ai - b);
     }
 }
+
+/* Two operand predicated copy immediate with merge.  All valid immediates
+ * can fit within 17 signed bits in the simd_data field.
+ */
+void HELPER(sve_cpy_m_b)(void *vd, void *vn, void *vg,
+                         uint64_t mm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    mm = (mm & 0xff) * (-1ull / 0xff);
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        uint64_t pp = expand_pred_b(pg[H1(i)]);
+        d[i] = (mm & pp) | (nn & ~pp);
+    }
+}
+
+void HELPER(sve_cpy_m_h)(void *vd, void *vn, void *vg,
+                         uint64_t mm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    mm = (mm & 0xffff) * (-1ull / 0xffff);
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        uint64_t pp = expand_pred_h(pg[H1(i)]);
+        d[i] = (mm & pp) | (nn & ~pp);
+    }
+}
+
+void HELPER(sve_cpy_m_s)(void *vd, void *vn, void *vg,
+                         uint64_t mm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    mm = deposit64(mm, 32, 32, mm);
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        uint64_t pp = expand_pred_s(pg[H1(i)]);
+        d[i] = (mm & pp) | (nn & ~pp);
+    }
+}
+
+void HELPER(sve_cpy_m_d)(void *vd, void *vn, void *vg,
+                         uint64_t mm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        uint64_t nn = n[i];
+        d[i] = (pg[H1(i)] & 1 ? mm : nn);
+    }
+}
+
+void HELPER(sve_cpy_z_b)(void *vd, void *vg, uint64_t val, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+
+    val = (val & 0xff) * (-1ull / 0xff);
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = val & expand_pred_b(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_cpy_z_h)(void *vd, void *vg, uint64_t val, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+
+    val = (val & 0xffff) * (-1ull / 0xffff);
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = val & expand_pred_h(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_cpy_z_s)(void *vd, void *vg, uint64_t val, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+
+    val = deposit64(val, 32, 32, val);
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = val & expand_pred_s(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] = (pg[H1(i)] & 1 ? val : 0);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 21b1e4df85..dd085b084b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -68,6 +68,12 @@ static inline int plus1(int x)
     return x + 1;
 }
 
+/* The SH bit is in bit 8.  Extract the low 8 and shift.  */
+static inline int expand_imm_sh8s(int x)
+{
+    return (int8_t)x << (x & 0x100 ? 8 : 0);
+}
+
 /*
  * Include the generated decoder.
  */
@@ -1698,6 +1704,92 @@ static void trans_DUPM(DisasContext *s, arg_DUPM *a, uint32_t insn)
     do_dupi_z(s, a->rd, imm);
 }
 
+/*
+ *** SVE Integer Wide Immediate - Predicated Group
+ */
+
+/* Implement all merging copies.  This is used for CPY (immediate),
+ * FCPY, CPY (scalar), CPY (SIMD&FP scalar).
+ */
+static void do_cpy_m(DisasContext *s, int esz, int rd, int rn, int pg,
+                     TCGv_i64 val)
+{
+    typedef void gen_cpy(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
+    static gen_cpy * const fns[4] = {
+        gen_helper_sve_cpy_m_b, gen_helper_sve_cpy_m_h,
+        gen_helper_sve_cpy_m_s, gen_helper_sve_cpy_m_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_i32 desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+    TCGv_ptr t_zd = tcg_temp_new_ptr();
+    TCGv_ptr t_zn = tcg_temp_new_ptr();
+    TCGv_ptr t_pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(t_zd, cpu_env, vec_full_reg_offset(s, rd));
+    tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, rn));
+    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
+
+    fns[esz](t_zd, t_zn, t_pg, val, desc);
+
+    tcg_temp_free_ptr(t_zd);
+    tcg_temp_free_ptr(t_zn);
+    tcg_temp_free_ptr(t_pg);
+    tcg_temp_free_i32(desc);
+}
+
+static void trans_FCPY(DisasContext *s, arg_FCPY *a, uint32_t insn)
+{
+    uint64_t imm;
+    TCGv_i64 t_imm;
+
+    if (a->esz == 0) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    /* Decode the VFP immediate.  */
+    imm = vfp_expand_imm(a->esz, a->imm);
+
+    t_imm = tcg_const_i64(imm);
+    do_cpy_m(s, a->esz, a->rd, a->rn, a->pg, t_imm);
+    tcg_temp_free_i64(t_imm);
+}
+
+static void trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    TCGv_i64 t_imm;
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    t_imm = tcg_const_i64(a->imm);
+    do_cpy_m(s, a->esz, a->rd, a->rn, a->pg, t_imm);
+    tcg_temp_free_i64(t_imm);
+}
+
+static void trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
+{
+    static gen_helper_gvec_2i * const fns[4] = {
+        gen_helper_sve_cpy_z_b, gen_helper_sve_cpy_z_h,
+        gen_helper_sve_cpy_z_s, gen_helper_sve_cpy_z_d,
+    };
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_i64 t_imm;
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    t_imm = tcg_const_i64(a->imm);
+    tcg_gen_gvec_2i_ool(vec_full_reg_offset(s, a->rd),
+                        pred_full_reg_offset(s, a->pg),
+                        t_imm, vsz, vsz, 0, fns[a->esz]);
+    tcg_temp_free_i64(t_imm);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0990d135f4..e6e10a4f84 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -39,6 +39,9 @@
 %tszimm16_shr	22:2 16:5 !function=tszimm_shr
 %tszimm16_shl	22:2 16:5 !function=tszimm_shl
 
+# Signed 8-bit immediate, optionally shifted left by 8.
+%sh8_i8s		5:9 !function=expand_imm_sh8s
+
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx	0:5
@@ -113,6 +116,11 @@
 @rd_rn_tszimm	........ .. ... ... ...... rn:5 rd:5 \
 		&rri_esz esz=%tszimm16_esz
 
+# Two register operand, one immediate operand, with 4-bit predicate.
+# User must fill in imm.
+@rdn_pg4	........ esz:2 .. pg:4 ... ........ rd:5 \
+		&rpri_esz rn=%reg_movprfx
+
 # Two register operand, one encoded bitmask.
 @rdn_dbm	........ .. .... dbm:13 rd:5 \
 		&rr_dbm rn=%reg_movprfx
@@ -346,6 +354,15 @@ AND_zzi		00000101 10 0000 ............. .....		@rdn_dbm
 # SVE broadcast bitmask immediate
 DUPM		00000101 11 0000 dbm:13 rd:5
 
+### SVE Integer Wide Immediate - Predicated Group
+
+# SVE copy floating-point immediate (predicated)
+FCPY		00000101 .. 01 .... 110 imm:8 .....		@rdn_pg4
+
+# SVE copy integer immediate (predicated)
+CPY_m_i		00000101 .. 01 .... 01 . ........ .....   @rdn_pg4 imm=%sh8_i8s
+CPY_z_i		00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3
