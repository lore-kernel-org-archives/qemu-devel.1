Received: from eggs.gnu.org ([2001:4830:134:3::10]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfb-0001ku-PS
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfZ-0006Jh-MG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfZ-0006IB-Bj
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfY-0003kx-6X
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:02 +0100
Message-Id: <20180615142521.19143-25-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/43] target/arm: Implement SVE conditionally
 broadcast/extract element
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
Message-id: 20180613015641.5667-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |   2 +
 target/arm/sve_helper.c    |  12 ++
 target/arm/translate-sve.c | 328 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  20 +++
 4 files changed, 362 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index d977aea00d8..a58fb4ba011 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -463,6 +463,8 @@ DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_2(sve_last_active_element, TCG_CALL_NO_RWG, s32, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ed3c6d4ca9d..cb7d101b573 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2070,3 +2070,15 @@ void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
         d[j] = 0;
     }
 }
+
+/* Similar to the ARM LastActiveElement pseudocode function, except the
+ * result is multiplied by the element size.  This includes the not found
+ * indication; e.g. not found for esz=3 is -8.
+ */
+int32_t HELPER(sve_last_active_element)(void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    intptr_t esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
+
+    return last_active_element(vg, DIV_ROUND_UP(oprsz, 8), esz);
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ed0f48a927c..feb4c09f1b8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2296,6 +2296,334 @@ static bool trans_COMPACT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return do_zpz_ool(s, a, fns[a->esz]);
 }
 
+/* Call the helper that computes the ARM LastActiveElement pseudocode
+ * function, scaled by the element size.  This includes the not found
+ * indication; e.g. not found for esz=3 is -8.
+ */
+static void find_last_active(DisasContext *s, TCGv_i32 ret, int esz, int pg)
+{
+    /* Predicate sizes may be smaller and cannot use simd_desc.  We cannot
+     * round up, as we do elsewhere, because we need the exact size.
+     */
+    TCGv_ptr t_p = tcg_temp_new_ptr();
+    TCGv_i32 t_desc;
+    unsigned vsz = pred_full_reg_size(s);
+    unsigned desc;
+
+    desc = vsz - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, esz);
+
+    tcg_gen_addi_ptr(t_p, cpu_env, pred_full_reg_offset(s, pg));
+    t_desc = tcg_const_i32(desc);
+
+    gen_helper_sve_last_active_element(ret, t_p, t_desc);
+
+    tcg_temp_free_i32(t_desc);
+    tcg_temp_free_ptr(t_p);
+}
+
+/* Increment LAST to the offset of the next element in the vector,
+ * wrapping around to 0.
+ */
+static void incr_last_active(DisasContext *s, TCGv_i32 last, int esz)
+{
+    unsigned vsz = vec_full_reg_size(s);
+
+    tcg_gen_addi_i32(last, last, 1 << esz);
+    if (is_power_of_2(vsz)) {
+        tcg_gen_andi_i32(last, last, vsz - 1);
+    } else {
+        TCGv_i32 max = tcg_const_i32(vsz);
+        TCGv_i32 zero = tcg_const_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_GEU, last, last, max, zero, last);
+        tcg_temp_free_i32(max);
+        tcg_temp_free_i32(zero);
+    }
+}
+
+/* If LAST < 0, set LAST to the offset of the last element in the vector.  */
+static void wrap_last_active(DisasContext *s, TCGv_i32 last, int esz)
+{
+    unsigned vsz = vec_full_reg_size(s);
+
+    if (is_power_of_2(vsz)) {
+        tcg_gen_andi_i32(last, last, vsz - 1);
+    } else {
+        TCGv_i32 max = tcg_const_i32(vsz - (1 << esz));
+        TCGv_i32 zero = tcg_const_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_LT, last, last, zero, max, last);
+        tcg_temp_free_i32(max);
+        tcg_temp_free_i32(zero);
+    }
+}
+
+/* Load an unsigned element of ESZ from BASE+OFS.  */
+static TCGv_i64 load_esz(TCGv_ptr base, int ofs, int esz)
+{
+    TCGv_i64 r = tcg_temp_new_i64();
+
+    switch (esz) {
+    case 0:
+        tcg_gen_ld8u_i64(r, base, ofs);
+        break;
+    case 1:
+        tcg_gen_ld16u_i64(r, base, ofs);
+        break;
+    case 2:
+        tcg_gen_ld32u_i64(r, base, ofs);
+        break;
+    case 3:
+        tcg_gen_ld_i64(r, base, ofs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return r;
+}
+
+/* Load an unsigned element of ESZ from RM[LAST].  */
+static TCGv_i64 load_last_active(DisasContext *s, TCGv_i32 last,
+                                 int rm, int esz)
+{
+    TCGv_ptr p = tcg_temp_new_ptr();
+    TCGv_i64 r;
+
+    /* Convert offset into vector into offset into ENV.
+     * The final adjustment for the vector register base
+     * is added via constant offset to the load.
+     */
+#ifdef HOST_WORDS_BIGENDIAN
+    /* Adjust for element ordering.  See vec_reg_offset.  */
+    if (esz < 3) {
+        tcg_gen_xori_i32(last, last, 8 - (1 << esz));
+    }
+#endif
+    tcg_gen_ext_i32_ptr(p, last);
+    tcg_gen_add_ptr(p, p, cpu_env);
+
+    r = load_esz(p, vec_full_reg_offset(s, rm), esz);
+    tcg_temp_free_ptr(p);
+
+    return r;
+}
+
+/* Compute CLAST for a Zreg.  */
+static bool do_clast_vector(DisasContext *s, arg_rprr_esz *a, bool before)
+{
+    TCGv_i32 last;
+    TCGLabel *over;
+    TCGv_i64 ele;
+    unsigned vsz, esz = a->esz;
+
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    last = tcg_temp_local_new_i32();
+    over = gen_new_label();
+
+    find_last_active(s, last, esz, a->pg);
+
+    /* There is of course no movcond for a 2048-bit vector,
+     * so we must branch over the actual store.
+     */
+    tcg_gen_brcondi_i32(TCG_COND_LT, last, 0, over);
+
+    if (!before) {
+        incr_last_active(s, last, esz);
+    }
+
+    ele = load_last_active(s, last, a->rm, esz);
+    tcg_temp_free_i32(last);
+
+    vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_dup_i64(esz, vec_full_reg_offset(s, a->rd), vsz, vsz, ele);
+    tcg_temp_free_i64(ele);
+
+    /* If this insn used MOVPRFX, we may need a second move.  */
+    if (a->rd != a->rn) {
+        TCGLabel *done = gen_new_label();
+        tcg_gen_br(done);
+
+        gen_set_label(over);
+        do_mov_z(s, a->rd, a->rn);
+
+        gen_set_label(done);
+    } else {
+        gen_set_label(over);
+    }
+    return true;
+}
+
+static bool trans_CLASTA_z(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    return do_clast_vector(s, a, false);
+}
+
+static bool trans_CLASTB_z(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    return do_clast_vector(s, a, true);
+}
+
+/* Compute CLAST for a scalar.  */
+static void do_clast_scalar(DisasContext *s, int esz, int pg, int rm,
+                            bool before, TCGv_i64 reg_val)
+{
+    TCGv_i32 last = tcg_temp_new_i32();
+    TCGv_i64 ele, cmp, zero;
+
+    find_last_active(s, last, esz, pg);
+
+    /* Extend the original value of last prior to incrementing.  */
+    cmp = tcg_temp_new_i64();
+    tcg_gen_ext_i32_i64(cmp, last);
+
+    if (!before) {
+        incr_last_active(s, last, esz);
+    }
+
+    /* The conceit here is that while last < 0 indicates not found, after
+     * adjusting for cpu_env->vfp.zregs[rm], it is still a valid address
+     * from which we can load garbage.  We then discard the garbage with
+     * a conditional move.
+     */
+    ele = load_last_active(s, last, rm, esz);
+    tcg_temp_free_i32(last);
+
+    zero = tcg_const_i64(0);
+    tcg_gen_movcond_i64(TCG_COND_GE, reg_val, cmp, zero, ele, reg_val);
+
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(cmp);
+    tcg_temp_free_i64(ele);
+}
+
+/* Compute CLAST for a Vreg.  */
+static bool do_clast_fp(DisasContext *s, arg_rpr_esz *a, bool before)
+{
+    if (sve_access_check(s)) {
+        int esz = a->esz;
+        int ofs = vec_reg_offset(s, a->rd, 0, esz);
+        TCGv_i64 reg = load_esz(cpu_env, ofs, esz);
+
+        do_clast_scalar(s, esz, a->pg, a->rn, before, reg);
+        write_fp_dreg(s, a->rd, reg);
+        tcg_temp_free_i64(reg);
+    }
+    return true;
+}
+
+static bool trans_CLASTA_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_clast_fp(s, a, false);
+}
+
+static bool trans_CLASTB_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_clast_fp(s, a, true);
+}
+
+/* Compute CLAST for a Xreg.  */
+static bool do_clast_general(DisasContext *s, arg_rpr_esz *a, bool before)
+{
+    TCGv_i64 reg;
+
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    reg = cpu_reg(s, a->rd);
+    switch (a->esz) {
+    case 0:
+        tcg_gen_ext8u_i64(reg, reg);
+        break;
+    case 1:
+        tcg_gen_ext16u_i64(reg, reg);
+        break;
+    case 2:
+        tcg_gen_ext32u_i64(reg, reg);
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    do_clast_scalar(s, a->esz, a->pg, a->rn, before, reg);
+    return true;
+}
+
+static bool trans_CLASTA_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_clast_general(s, a, false);
+}
+
+static bool trans_CLASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_clast_general(s, a, true);
+}
+
+/* Compute LAST for a scalar.  */
+static TCGv_i64 do_last_scalar(DisasContext *s, int esz,
+                               int pg, int rm, bool before)
+{
+    TCGv_i32 last = tcg_temp_new_i32();
+    TCGv_i64 ret;
+
+    find_last_active(s, last, esz, pg);
+    if (before) {
+        wrap_last_active(s, last, esz);
+    } else {
+        incr_last_active(s, last, esz);
+    }
+
+    ret = load_last_active(s, last, rm, esz);
+    tcg_temp_free_i32(last);
+    return ret;
+}
+
+/* Compute LAST for a Vreg.  */
+static bool do_last_fp(DisasContext *s, arg_rpr_esz *a, bool before)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 val = do_last_scalar(s, a->esz, a->pg, a->rn, before);
+        write_fp_dreg(s, a->rd, val);
+        tcg_temp_free_i64(val);
+    }
+    return true;
+}
+
+static bool trans_LASTA_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_last_fp(s, a, false);
+}
+
+static bool trans_LASTB_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_last_fp(s, a, true);
+}
+
+/* Compute LAST for a Xreg.  */
+static bool do_last_general(DisasContext *s, arg_rpr_esz *a, bool before)
+{
+    if (sve_access_check(s)) {
+        TCGv_i64 val = do_last_scalar(s, a->esz, a->pg, a->rn, before);
+        tcg_gen_mov_i64(cpu_reg(s, a->rd), val);
+        tcg_temp_free_i64(val);
+    }
+    return true;
+}
+
+static bool trans_LASTA_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_last_general(s, a, false);
+}
+
+static bool trans_LASTB_r(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_last_general(s, a, true);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 9da6566d325..1226867f698 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -430,6 +430,26 @@ TRN2_z          00000101 .. 1 ..... 011 101 ..... .....         @rd_rn_rm
 # Note esz >= 2
 COMPACT         00000101 .. 100001 100 ... ..... .....          @rd_pg_rn
 
+# SVE conditionally broadcast element to vector
+CLASTA_z        00000101 .. 10100 0 100 ... ..... .....         @rdn_pg_rm
+CLASTB_z        00000101 .. 10100 1 100 ... ..... .....         @rdn_pg_rm
+
+# SVE conditionally copy element to SIMD&FP scalar
+CLASTA_v        00000101 .. 10101 0 100 ... ..... .....         @rd_pg_rn
+CLASTB_v        00000101 .. 10101 1 100 ... ..... .....         @rd_pg_rn
+
+# SVE conditionally copy element to general register
+CLASTA_r        00000101 .. 11000 0 101 ... ..... .....         @rd_pg_rn
+CLASTB_r        00000101 .. 11000 1 101 ... ..... .....         @rd_pg_rn
+
+# SVE copy element to SIMD&FP scalar register
+LASTA_v         00000101 .. 10001 0 100 ... ..... .....         @rd_pg_rn
+LASTB_v         00000101 .. 10001 1 100 ... ..... .....         @rd_pg_rn
+
+# SVE copy element to general register
+LASTA_r         00000101 .. 10000 0 101 ... ..... .....         @rd_pg_rn
+LASTB_r         00000101 .. 10000 1 101 ... ..... .....         @rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1
