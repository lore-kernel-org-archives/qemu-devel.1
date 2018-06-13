Received: from eggs.gnu.org ([2001:4830:134:3::10]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2M-0002Y0-Vn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv2K-0006JK-Uz
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:27 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv2K-0006J9-MK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:24 -0400
Received: by mail-pl0-x241.google.com with SMTP id b14-v6so553871pls.5
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:57:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:36 -1000
Message-Id: <20180613015641.5667-14-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 13/18] target/arm: Implement SVE Partition
 Break Group
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  18 +++
 target/arm/sve_helper.c    | 248 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 106 ++++++++++++++++
 target/arm/sve.decode      |  19 +++
 4 files changed, 391 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ae38c0a4be..f0a3ed3414 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -658,3 +658,21 @@ DEF_HELPER_FLAGS_5(sve_orn_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_nor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_nand_pppp, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_brkpa, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_brkpb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_brkpas, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_brkpbs, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_brka_z, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkb_z, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brka_m, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkb_m, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_brkas_z, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkbs_z, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkas_m, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkbs_m, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_brkn, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index c1d95edfca..b27b502d75 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2476,3 +2476,251 @@ DO_CMP_PPZI_D(sve_cmpls_ppzi_d, uint64_t, <=)
 #undef DO_CMP_PPZI_S
 #undef DO_CMP_PPZI_D
 #undef DO_CMP_PPZI
+
+/* Similar to the ARM LastActive pseudocode function.  */
+static bool last_active_pred(void *vd, void *vg, intptr_t oprsz)
+{
+    intptr_t i;
+
+    for (i = QEMU_ALIGN_UP(oprsz, 8) - 8; i >= 0; i -= 8) {
+        uint64_t pg = *(uint64_t *)(vg + i);
+        if (pg) {
+            return (pow2floor(pg) & *(uint64_t *)(vd + i)) != 0;
+        }
+    }
+    return 0;
+}
+
+/* Compute a mask into RETB that is true for all G, up to and including
+ * (if after) or excluding (if !after) the first G & N.
+ * Return true if BRK found.
+ */
+static bool compute_brk(uint64_t *retb, uint64_t n, uint64_t g,
+                        bool brk, bool after)
+{
+    uint64_t b;
+
+    if (brk) {
+        b = 0;
+    } else if ((g & n) == 0) {
+        /* For all G, no N are set; break not found.  */
+        b = g;
+    } else {
+        /* Break somewhere in N.  Locate it.  */
+        b = g & n;            /* guard true, pred true */
+        b = b & -b;           /* first such */
+        if (after) {
+            b = b | (b - 1);  /* break after same */
+        } else {
+            b = b - 1;        /* break before same */
+        }
+        brk = true;
+    }
+
+    *retb = b;
+    return brk;
+}
+
+/* Compute a zeroing BRK.  */
+static void compute_brk_z(uint64_t *d, uint64_t *n, uint64_t *g,
+                          intptr_t oprsz, bool after)
+{
+    bool brk = false;
+    intptr_t i;
+
+    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); ++i) {
+        uint64_t this_b, this_g = g[i];
+
+        brk = compute_brk(&this_b, n[i], this_g, brk, after);
+        d[i] = this_b & this_g;
+    }
+}
+
+/* Likewise, but also compute flags.  */
+static uint32_t compute_brks_z(uint64_t *d, uint64_t *n, uint64_t *g,
+                               intptr_t oprsz, bool after)
+{
+    uint32_t flags = PREDTEST_INIT;
+    bool brk = false;
+    intptr_t i;
+
+    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); ++i) {
+        uint64_t this_b, this_d, this_g = g[i];
+
+        brk = compute_brk(&this_b, n[i], this_g, brk, after);
+        d[i] = this_d = this_b & this_g;
+        flags = iter_predtest_fwd(this_d, this_g, flags);
+    }
+    return flags;
+}
+
+/* Compute a merging BRK.  */
+static void compute_brk_m(uint64_t *d, uint64_t *n, uint64_t *g,
+                          intptr_t oprsz, bool after)
+{
+    bool brk = false;
+    intptr_t i;
+
+    for (i = 0; i < DIV_ROUND_UP(oprsz, 8); ++i) {
+        uint64_t this_b, this_g = g[i];
+
+        brk = compute_brk(&this_b, n[i], this_g, brk, after);
+        d[i] = (this_b & this_g) | (d[i] & ~this_g);
+    }
+}
+
+/* Likewise, but also compute flags.  */
+static uint32_t compute_brks_m(uint64_t *d, uint64_t *n, uint64_t *g,
+                               intptr_t oprsz, bool after)
+{
+    uint32_t flags = PREDTEST_INIT;
+    bool brk = false;
+    intptr_t i;
+
+    for (i = 0; i < oprsz / 8; ++i) {
+        uint64_t this_b, this_d = d[i], this_g = g[i];
+
+        brk = compute_brk(&this_b, n[i], this_g, brk, after);
+        d[i] = this_d = (this_b & this_g) | (this_d & ~this_g);
+        flags = iter_predtest_fwd(this_d, this_g, flags);
+    }
+    return flags;
+}
+
+static uint32_t do_zero(ARMPredicateReg *d, intptr_t oprsz)
+{
+    /* It is quicker to zero the whole predicate than loop on OPRSZ.
+     * The compiler should turn this into 4 64-bit integer stores.
+     */
+    memset(d, 0, sizeof(ARMPredicateReg));
+    return PREDTEST_INIT;
+}
+
+void HELPER(sve_brkpa)(void *vd, void *vn, void *vm, void *vg,
+                       uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    if (last_active_pred(vn, vg, oprsz)) {
+        compute_brk_z(vd, vm, vg, oprsz, true);
+    } else {
+        do_zero(vd, oprsz);
+    }
+}
+
+uint32_t HELPER(sve_brkpas)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    if (last_active_pred(vn, vg, oprsz)) {
+        return compute_brks_z(vd, vm, vg, oprsz, true);
+    } else {
+        return do_zero(vd, oprsz);
+    }
+}
+
+void HELPER(sve_brkpb)(void *vd, void *vn, void *vm, void *vg,
+                       uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    if (last_active_pred(vn, vg, oprsz)) {
+        compute_brk_z(vd, vm, vg, oprsz, false);
+    } else {
+        do_zero(vd, oprsz);
+    }
+}
+
+uint32_t HELPER(sve_brkpbs)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    if (last_active_pred(vn, vg, oprsz)) {
+        return compute_brks_z(vd, vm, vg, oprsz, false);
+    } else {
+        return do_zero(vd, oprsz);
+    }
+}
+
+void HELPER(sve_brka_z)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    compute_brk_z(vd, vn, vg, oprsz, true);
+}
+
+uint32_t HELPER(sve_brkas_z)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    return compute_brks_z(vd, vn, vg, oprsz, true);
+}
+
+void HELPER(sve_brkb_z)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    compute_brk_z(vd, vn, vg, oprsz, false);
+}
+
+uint32_t HELPER(sve_brkbs_z)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    return compute_brks_z(vd, vn, vg, oprsz, false);
+}
+
+void HELPER(sve_brka_m)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    compute_brk_m(vd, vn, vg, oprsz, true);
+}
+
+uint32_t HELPER(sve_brkas_m)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    return compute_brks_m(vd, vn, vg, oprsz, true);
+}
+
+void HELPER(sve_brkb_m)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    compute_brk_m(vd, vn, vg, oprsz, false);
+}
+
+uint32_t HELPER(sve_brkbs_m)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+    return compute_brks_m(vd, vn, vg, oprsz, false);
+}
+
+void HELPER(sve_brkn)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+
+    if (!last_active_pred(vn, vg, oprsz)) {
+        do_zero(vd, oprsz);
+    }
+}
+
+/* As if PredTest(Ones(PL), D, esz).  */
+static uint32_t predtest_ones(ARMPredicateReg *d, intptr_t oprsz,
+                              uint64_t esz_mask)
+{
+    uint32_t flags = PREDTEST_INIT;
+    intptr_t i;
+
+    for (i = 0; i < oprsz / 8; i++) {
+        flags = iter_predtest_fwd(d->p[i], esz_mask, flags);
+    }
+    if (oprsz & 7) {
+        uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
+        flags = iter_predtest_fwd(d->p[i], esz_mask & mask, flags);
+    }
+    return flags;
+}
+
+uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
+
+    if (last_active_pred(vn, vg, oprsz)) {
+        return predtest_ones(vd, oprsz, -1);
+    } else {
+        return do_zero(vd, oprsz);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 00481e92de..c381240b6f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2853,6 +2853,112 @@ DO_PPZI(CMPLS, cmpls)
 
 #undef DO_PPZI
 
+/*
+ *** SVE Partition Break Group
+ */
+
+static bool do_brk3(DisasContext *s, arg_rprr_s *a,
+                    gen_helper_gvec_4 *fn, gen_helper_gvec_flags_4 *fn_s)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = pred_full_reg_size(s);
+
+    /* Predicate sizes may be smaller and cannot use simd_desc.  */
+    TCGv_ptr d = tcg_temp_new_ptr();
+    TCGv_ptr n = tcg_temp_new_ptr();
+    TCGv_ptr m = tcg_temp_new_ptr();
+    TCGv_ptr g = tcg_temp_new_ptr();
+    TCGv_i32 t = tcg_const_i32(vsz - 2);
+
+    tcg_gen_addi_ptr(d, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(n, cpu_env, pred_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(m, cpu_env, pred_full_reg_offset(s, a->rm));
+    tcg_gen_addi_ptr(g, cpu_env, pred_full_reg_offset(s, a->pg));
+
+    if (a->s) {
+        fn_s(t, d, n, m, g, t);
+        do_pred_flags(t);
+    } else {
+        fn(d, n, m, g, t);
+    }
+    tcg_temp_free_ptr(d);
+    tcg_temp_free_ptr(n);
+    tcg_temp_free_ptr(m);
+    tcg_temp_free_ptr(g);
+    tcg_temp_free_i32(t);
+    return true;
+}
+
+static bool do_brk2(DisasContext *s, arg_rpr_s *a,
+                    gen_helper_gvec_3 *fn, gen_helper_gvec_flags_3 *fn_s)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned vsz = pred_full_reg_size(s);
+
+    /* Predicate sizes may be smaller and cannot use simd_desc.  */
+    TCGv_ptr d = tcg_temp_new_ptr();
+    TCGv_ptr n = tcg_temp_new_ptr();
+    TCGv_ptr g = tcg_temp_new_ptr();
+    TCGv_i32 t = tcg_const_i32(vsz - 2);
+
+    tcg_gen_addi_ptr(d, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(n, cpu_env, pred_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(g, cpu_env, pred_full_reg_offset(s, a->pg));
+
+    if (a->s) {
+        fn_s(t, d, n, g, t);
+        do_pred_flags(t);
+    } else {
+        fn(d, n, g, t);
+    }
+    tcg_temp_free_ptr(d);
+    tcg_temp_free_ptr(n);
+    tcg_temp_free_ptr(g);
+    tcg_temp_free_i32(t);
+    return true;
+}
+
+static bool trans_BRKPA(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    return do_brk3(s, a, gen_helper_sve_brkpa, gen_helper_sve_brkpas);
+}
+
+static bool trans_BRKPB(DisasContext *s, arg_rprr_s *a, uint32_t insn)
+{
+    return do_brk3(s, a, gen_helper_sve_brkpb, gen_helper_sve_brkpbs);
+}
+
+static bool trans_BRKA_m(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+{
+    return do_brk2(s, a, gen_helper_sve_brka_m, gen_helper_sve_brkas_m);
+}
+
+static bool trans_BRKB_m(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+{
+    return do_brk2(s, a, gen_helper_sve_brkb_m, gen_helper_sve_brkbs_m);
+}
+
+static bool trans_BRKA_z(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+{
+    return do_brk2(s, a, gen_helper_sve_brka_z, gen_helper_sve_brkas_z);
+}
+
+static bool trans_BRKB_z(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+{
+    return do_brk2(s, a, gen_helper_sve_brkb_z, gen_helper_sve_brkbs_z);
+}
+
+static bool trans_BRKN(DisasContext *s, arg_rpr_s *a, uint32_t insn)
+{
+    return do_brk2(s, a, gen_helper_sve_brkn, gen_helper_sve_brkns);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 9bc383b085..66e1ee6b5c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -59,6 +59,7 @@
 &rri_esz        rd rn imm esz
 &rrr_esz        rd rn rm esz
 &rpr_esz        rd pg rn esz
+&rpr_s          rd pg rn s
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
 &rprrr_esz      rd pg rn rm ra esz
@@ -78,6 +79,9 @@
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
 
+# Two operand with governing predicate, flags setting
+@pd_pg_pn_s     ........ . s:1 ...... .. pg:4 . rn:4 . rd:4     &rpr_s
+
 # Three operand with unused vector element size
 @rd_rn_rm_e0    ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
 
@@ -560,6 +564,21 @@ PFIRST          00100101 01 011 000 11000 00 .... 0 ....        @pd_pn_e0
 # SVE predicate next active
 PNEXT           00100101 .. 011 001 11000 10 .... 0 ....        @pd_pn
 
+### SVE Partition Break Group
+
+# SVE propagate break from previous partition
+BRKPA           00100101 0. 00 .... 11 .... 0 .... 0 ....       @pd_pg_pn_pm_s
+BRKPB           00100101 0. 00 .... 11 .... 0 .... 1 ....       @pd_pg_pn_pm_s
+
+# SVE partition break condition
+BRKA_z          00100101 0. 01000001 .... 0 .... 0 ....         @pd_pg_pn_s
+BRKB_z          00100101 1. 01000001 .... 0 .... 0 ....         @pd_pg_pn_s
+BRKA_m          00100101 0. 01000001 .... 0 .... 1 ....         @pd_pg_pn_s
+BRKB_m          00100101 1. 01000001 .... 0 .... 1 ....         @pd_pg_pn_s
+
+# SVE propagate break to next partition
+BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.17.1
