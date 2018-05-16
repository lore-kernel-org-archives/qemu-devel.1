Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wZ-0007zc-Jm
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wX-0007lb-Sf
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:47 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wX-0007kq-HH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:45 -0400
Received: by mail-pg0-x244.google.com with SMTP id w3-v6so886350pgv.12
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:30:04 -0700
Message-Id: <20180516223007.10256-25-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 24/27] target/arm: Implement SVE Integer
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  10 ++++
 target/arm/sve_helper.c    | 108 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  88 ++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  19 ++++++-
 4 files changed, 224 insertions(+), 1 deletion(-)

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
index 979aa5c409..8c7ea989b1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1371,3 +1371,111 @@ void HELPER(sve_uqsubi_d)(void *d, void *a, uint64_t b, uint32_t desc)
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
+    mm = dup_const(MO_8, mm);
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
+    mm = dup_const(MO_16, mm);
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
+    mm = dup_const(MO_32, mm);
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
+    val = dup_const(MO_8, val);
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
+    val = dup_const(MO_16, val);
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
+    val = dup_const(MO_32, val);
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
index 9d7c18c48d..9bdd61ff84 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -62,6 +62,12 @@ static inline int plus1(int x)
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
@@ -1834,6 +1840,88 @@ static bool trans_DUPM(DisasContext *s, arg_DUPM *a, uint32_t insn)
     return true;
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
+static bool trans_FCPY(DisasContext *s, arg_FCPY *a, uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        /* Decode the VFP immediate.  */
+        uint64_t imm = vfp_expand_imm(a->esz, a->imm);
+        TCGv_i64 t_imm = tcg_const_i64(imm);
+        do_cpy_m(s, a->esz, a->rd, a->rn, a->pg, t_imm);
+        tcg_temp_free_i64(t_imm);
+    }
+    return true;
+}
+
+static bool trans_CPY_m_i(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        TCGv_i64 t_imm = tcg_const_i64(a->imm);
+        do_cpy_m(s, a->esz, a->rd, a->rn, a->pg, t_imm);
+        tcg_temp_free_i64(t_imm);
+    }
+    return true;
+}
+
+static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a, uint32_t insn)
+{
+    static gen_helper_gvec_2i * const fns[4] = {
+        gen_helper_sve_cpy_z_b, gen_helper_sve_cpy_z_h,
+        gen_helper_sve_cpy_z_s, gen_helper_sve_cpy_z_d,
+    };
+
+    if (a->esz == 0 && extract32(insn, 13, 1)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_i64 t_imm = tcg_const_i64(a->imm);
+        tcg_gen_gvec_2i_ool(vec_full_reg_offset(s, a->rd),
+                            pred_full_reg_offset(s, a->pg),
+                            t_imm, vsz, vsz, 0, fns[a->esz]);
+        tcg_temp_free_i64(t_imm);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a3277a0d21..4ee7c78cda 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -22,7 +22,7 @@
 ###########################################################################
 # Named fields.  These are primarily for disjoint fields.
 
-%imm4_16_p1             16:4 !function=plus1
+%imm4_16_p1     16:4 !function=plus1
 %imm6_22_5      22:1 5:5
 %imm9_16_10     16:s6 10:3
 
@@ -38,6 +38,9 @@
 %tszimm16_shr   22:2 16:5 !function=tszimm_shr
 %tszimm16_shl   22:2 16:5 !function=tszimm_shl
 
+# Signed 8-bit immediate, optionally shifted left by 8.
+%sh8_i8s        5:9 !function=expand_imm_sh8s
+
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx    0:5
@@ -112,6 +115,11 @@
 @rd_rn_tszimm   ........ .. ... ... ...... rn:5 rd:5 \
                 &rri_esz esz=%tszimm16_esz
 
+# Two register operand, one immediate operand, with 4-bit predicate.
+# User must fill in imm.
+@rdn_pg4        ........ esz:2 .. pg:4 ... ........ rd:5 \
+                &rpri_esz rn=%reg_movprfx
+
 # Two register operand, one encoded bitmask.
 @rdn_dbm        ........ .. .... dbm:13 rd:5 \
                 &rr_dbm rn=%reg_movprfx
@@ -345,6 +353,15 @@ AND_zzi         00000101 10 0000 ............. .....            @rdn_dbm
 # SVE broadcast bitmask immediate
 DUPM            00000101 11 0000 dbm:13 rd:5
 
+### SVE Integer Wide Immediate - Predicated Group
+
+# SVE copy floating-point immediate (predicated)
+FCPY            00000101 .. 01 .... 110 imm:8 .....             @rdn_pg4
+
+# SVE copy integer immediate (predicated)
+CPY_m_i         00000101 .. 01 .... 01 . ........ .....   @rdn_pg4 imm=%sh8_i8s
+CPY_z_i         00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.0
