Received: from eggs.gnu.org ([2001:4830:134:3::10]:55555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUM-00085X-An
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUJ-0001qj-Li
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:06 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUJ-0001q6-EI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:03 -0500
Received: by mail-pg0-x241.google.com with SMTP id m25so9422165pgv.12
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:34 -0800
Message-Id: <20171218174552.18871-6-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/23] target/arm: Implement SVE predicate
 logical operations
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  37 ++++++
 target/arm/helper.h        |   1 +
 target/arm/sve_helper.c    | 126 ++++++++++++++++++
 target/arm/translate-sve.c | 314 ++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/Makefile.objs   |   2 +-
 target/arm/sve.def         |  21 +++
 6 files changed, 498 insertions(+), 3 deletions(-)
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/sve_helper.c

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
new file mode 100644
index 0000000000..4a923a33b8
--- /dev/null
+++ b/target/arm/helper-sve.h
@@ -0,0 +1,37 @@
+/*
+ *  AArch64 SVE specific helper definitions
+ *
+ *  Copyright (c) 2017 Linaro, Ltd
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sel_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orr_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orn_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nand_pred, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_ands_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bics_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eors_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orrs_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orns_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nors_pred, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_nands_pred, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 206e39a207..3c4fca220e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -587,4 +587,5 @@ DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
 
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
+#include "helper-sve.h"
 #endif
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
new file mode 100644
index 0000000000..5d2a6b2239
--- /dev/null
+++ b/target/arm/sve_helper.c
@@ -0,0 +1,126 @@
+/*
+ *  ARM SVE Operations
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+
+
+/* Note that vector data is stored in host-endian 64-bit chunks,
+   so addressing units smaller than that needs a host-endian fixup.  */
+#ifdef HOST_WORDS_BIGENDIAN
+#define H1(x)  ((x) ^ 7)
+#define H2(x)  ((x) ^ 3)
+#define H4(x)  ((x) ^ 1)
+#else
+#define H1(x)  (x)
+#define H2(x)  (x)
+#define H4(x)  (x)
+#endif
+
+
+/* Given the first and last word of the result, the first and last word
+   of the governing mask, and the sum of the result, return a mask that
+   can be used to quickly set NZCV.  */
+static uint32_t predtest(uint64_t first_d, uint64_t first_g, uint64_t last_d,
+                         uint64_t last_g, uint64_t sum_d, uint64_t size_mask)
+{
+    first_g &= size_mask;
+    first_d &= first_g & -first_g;
+    last_g &= size_mask;
+    last_d &= pow2floor(last_g);
+
+    return ((first_d != 0) << 31) | ((sum_d != 0) << 1) | (last_d == 0);
+}
+
+#define LOGICAL_PRED(NAME, FUNC) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
+{                                                                         \
+    uintptr_t opr_sz = simd_oprsz(desc);                                  \
+    uint64_t *d = vd, *n = vn, *m = vm, *g = vg;                          \
+    uintptr_t i;                                                          \
+    for (i = 0; i < opr_sz / 8; ++i) {                                    \
+        d[i] = FUNC(n[i], m[i], g[i]);                                    \
+    }                                                                     \
+}
+
+#define LOGICAL_PRED_FLAGS(NAME, FUNC) \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t bits) \
+{                                                                            \
+    uint64_t *d = vd, *n = vn, *m = vm, *g = vg;                             \
+    uint64_t first_d = 0, first_g = 0, last_d = 0, last_g = 0, sum_d = 0;    \
+    uintptr_t i = 0;                                                         \
+    for (; i < bits / 64; ++i) {                                             \
+        last_g = g[i];                                                       \
+        d[i] = last_d = FUNC(n[i], m[i], last_g);                            \
+        sum_d |= last_d;                                                     \
+        if (i == 0) {                                                        \
+            first_g = last_g, first_d = last_d;                              \
+        }                                                                    \
+        d[i] = last_d;                                                       \
+    }                                                                        \
+    if (bits % 64) {                                                         \
+        last_g = g[i] & ~(-1ull << bits % 64);                               \
+        d[i] = last_d = FUNC(n[i], m[i], last_g);                            \
+        sum_d |= last_d;                                                     \
+        if (i == 0) {                                                        \
+            first_g = last_g, first_d = last_d;                              \
+        }                                                                    \
+    }                                                                        \
+    return predtest(first_d, first_g, last_d, last_g, sum_d, -1);            \
+}
+
+#define DO_AND(N, M, G)  (((N) & (M)) & (G))
+#define DO_BIC(N, M, G)  (((N) & ~(M)) & (G))
+#define DO_EOR(N, M, G)  (((N) ^ (M)) & (G))
+#define DO_ORR(N, M, G)  (((N) | (M)) & (G))
+#define DO_ORN(N, M, G)  (((N) | ~(M)) & (G))
+#define DO_NOR(N, M, G)  (~((N) | (M)) & (G))
+#define DO_NAND(N, M, G) (~((N) & (M)) & (G))
+#define DO_SEL(N, M, G)  (((N) & (G)) | ((M) & ~(G)))
+
+LOGICAL_PRED(sve_and_pred, DO_AND)
+LOGICAL_PRED(sve_bic_pred, DO_BIC)
+LOGICAL_PRED(sve_eor_pred, DO_EOR)
+LOGICAL_PRED(sve_sel_pred, DO_SEL)
+LOGICAL_PRED(sve_orr_pred, DO_ORR)
+LOGICAL_PRED(sve_orn_pred, DO_ORN)
+LOGICAL_PRED(sve_nor_pred, DO_NOR)
+LOGICAL_PRED(sve_nand_pred, DO_NAND)
+
+LOGICAL_PRED_FLAGS(sve_ands_pred, DO_AND)
+LOGICAL_PRED_FLAGS(sve_bics_pred, DO_BIC)
+LOGICAL_PRED_FLAGS(sve_eors_pred, DO_EOR)
+LOGICAL_PRED_FLAGS(sve_orrs_pred, DO_ORR)
+LOGICAL_PRED_FLAGS(sve_orns_pred, DO_ORN)
+LOGICAL_PRED_FLAGS(sve_nors_pred, DO_NOR)
+LOGICAL_PRED_FLAGS(sve_nands_pred, DO_NAND)
+
+#undef LOGICAL_PRED
+#undef LOGICAL_PRED_FLAGS
+#undef DO_ADD
+#undef DO_BIC
+#undef DO_EOR
+#undef DO_ORR
+#undef DO_ORN
+#undef DO_NOR
+#undef DO_NAND
+#undef DO_SEL
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fabf6f0a67..ab03ead000 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -63,6 +63,14 @@ static void do_genfn2(DisasContext *s, GVecGen2Fn *gvec_fn,
             vec_full_reg_offset(s, rn), vsz, vsz);
 }
 
+static void do_genfn2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
+                        int esz, int rd, int rn)
+{
+    unsigned vsz = size_for_gvec(pred_full_reg_size(s));
+    gvec_fn(esz, pred_full_reg_offset(s, rd),
+            pred_full_reg_offset(s, rn), vsz, vsz);
+}
+
 static void do_genfn3(DisasContext *s, GVecGen3Fn *gvec_fn,
                       int esz, int rd, int rn, int rm)
 {
@@ -71,9 +79,27 @@ static void do_genfn3(DisasContext *s, GVecGen3Fn *gvec_fn,
             vec_full_reg_offset(s, rm), vsz, vsz);
 }
 
-static void do_zzz_genfn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *gvec_fn)
+static void do_genfn3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
+                        int esz, int rd, int rn, int rm)
+{
+    unsigned vsz = size_for_gvec(pred_full_reg_size(s));
+    gvec_fn(esz, pred_full_reg_offset(s, rd), pred_full_reg_offset(s, rn),
+            pred_full_reg_offset(s, rm), vsz, vsz);
+}
+
+static void do_genop4_p(DisasContext *s, const GVecGen4 *gvec_op,
+                        int rd, int rn, int rm, int pg)
+{
+    unsigned vsz = size_for_gvec(pred_full_reg_size(s));
+    tcg_gen_gvec_4(pred_full_reg_offset(s, rd), pred_full_reg_offset(s, rn),
+                   pred_full_reg_offset(s, rm), pred_full_reg_offset(s, pg),
+                   vsz, vsz, gvec_op);
+}
+
+
+static void do_zzz_genfn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *fn)
 {
-    do_genfn3(s, gvec_fn, a->esz, a->rd, a->rn, a->rm);
+    do_genfn3(s, fn, a->esz, a->rd, a->rn, a->rm);
 }
 
 void trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
@@ -216,3 +242,287 @@ void trans_pred_set(DisasContext *s, arg_pred_set *a, uint32_t insn)
         tcg_gen_movi_i32(cpu_VF, 0);
     }
 }
+
+static void do_mov_p(DisasContext *s, int rd, int rn)
+{
+    do_genfn2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
+}
+
+static void gen_and_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_and_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+void trans_AND_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 and_pg = {
+        .fni8 = gen_and_pg_i64,
+        .fniv = gen_and_pg_vec,
+        .fno = gen_helper_sve_and_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (a->pg == a->rn && a->rn == a->rm) {
+        do_mov_p(s, a->rd, a->rn);
+    } else if (a->pg == a->rn || a->pg == a->rm) {
+        do_genfn3_p(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+    } else {
+        do_genop4_p(s, &and_pg, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_bic_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_andc_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_bic_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_andc_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+void trans_BIC_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 bic_pg = {
+        .fni8 = gen_bic_pg_i64,
+        .fniv = gen_bic_pg_vec,
+        .fno = gen_helper_sve_bic_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (a->pg == a->rn) {
+        do_genfn3_p(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
+    } else {
+        do_genop4_p(s, &bic_pg, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_eor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_xor_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_eor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_xor_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+void trans_EOR_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 eor_pg = {
+        .fni8 = gen_eor_pg_i64,
+        .fniv = gen_eor_pg_vec,
+        .fno = gen_helper_sve_eor_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    do_genop4_p(s, &eor_pg, a->rd, a->rn, a->rm, a->pg);
+}
+
+static void gen_sel_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pn, pn, pg);
+    tcg_gen_andc_i64(pm, pm, pg);
+    tcg_gen_or_i64(pd, pn, pm);
+}
+
+static void gen_sel_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pn, pn, pg);
+    tcg_gen_andc_vec(vece, pm, pm, pg);
+    tcg_gen_or_vec(vece, pd, pn, pm);
+}
+
+void trans_SEL_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 sel_pg = {
+        .fni8 = gen_sel_pg_i64,
+        .fniv = gen_sel_pg_vec,
+        .fno = gen_helper_sve_sel_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    do_genop4_p(s, &sel_pg, a->rd, a->rn, a->rm, a->pg);
+}
+
+static void gen_orr_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_or_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_orr_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_or_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+void trans_ORR_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 orr_pg = {
+        .fni8 = gen_orr_pg_i64,
+        .fniv = gen_orr_pg_vec,
+        .fno = gen_helper_sve_orr_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    if (a->pg == a->rn && a->rn == a->rm) {
+        do_mov_p(s, a->rd, a->rn);
+    } else {
+        do_genop4_p(s, &orr_pg, a->rd, a->rn, a->rm, a->pg);
+    }
+}
+
+static void gen_orn_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_orc_i64(pd, pn, pm);
+    tcg_gen_and_i64(pd, pd, pg);
+}
+
+static void gen_orn_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_orc_vec(vece, pd, pn, pm);
+    tcg_gen_and_vec(vece, pd, pd, pg);
+}
+
+void trans_ORN_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 orn_pg = {
+        .fni8 = gen_orn_pg_i64,
+        .fniv = gen_orn_pg_vec,
+        .fno = gen_helper_sve_orn_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    do_genop4_p(s, &orn_pg, a->rd, a->rn, a->rm, a->pg);
+}
+
+static void gen_nor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_or_i64(pd, pn, pm);
+    tcg_gen_andc_i64(pd, pg, pd);
+}
+
+static void gen_nor_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_or_vec(vece, pd, pn, pm);
+    tcg_gen_andc_vec(vece, pd, pg, pd);
+}
+
+void trans_NOR_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 nor_pg = {
+        .fni8 = gen_nor_pg_i64,
+        .fniv = gen_nor_pg_vec,
+        .fno = gen_helper_sve_nor_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    do_genop4_p(s, &nor_pg, a->rd, a->rn, a->rm, a->pg);
+}
+
+static void gen_nand_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
+{
+    tcg_gen_and_i64(pd, pn, pm);
+    tcg_gen_andc_i64(pd, pg, pd);
+}
+
+static void gen_nand_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
+                           TCGv_vec pm, TCGv_vec pg)
+{
+    tcg_gen_and_vec(vece, pd, pn, pm);
+    tcg_gen_andc_vec(vece, pd, pg, pd);
+}
+
+void trans_NAND_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static const GVecGen4 nand_pg = {
+        .fni8 = gen_nand_pg_i64,
+        .fniv = gen_nand_pg_vec,
+        .fno = gen_helper_sve_nand_pred,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+    do_genop4_p(s, &nand_pg, a->rd, a->rn, a->rm, a->pg);
+}
+
+/* A predicate logical operation that sets the flags is always implemented
+   out of line.  The helper returns a 3-bit mask to set N,Z,C --
+   N in bit 31, Z in bit 2, and C in bit 1.  */
+static void do_logical_pppp_flags(DisasContext *s, arg_rprr_esz *a,
+                                  void (*gen_fn)(TCGv_i32, TCGv_ptr, TCGv_ptr,
+                                                 TCGv_ptr, TCGv_ptr, TCGv_i32))
+{
+    TCGv_i32 t = tcg_const_i32(vec_full_reg_size(s));
+    TCGv_ptr pd = tcg_temp_new_ptr();
+    TCGv_ptr pn = tcg_temp_new_ptr();
+    TCGv_ptr pm = tcg_temp_new_ptr();
+    TCGv_ptr pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(pd, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(pn, cpu_env, pred_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(pm, cpu_env, pred_full_reg_offset(s, a->rm));
+    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
+
+    gen_fn(t, pd, pn, pm, pg, t);
+
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(pn);
+    tcg_temp_free_ptr(pm);
+    tcg_temp_free_ptr(pg);
+
+    tcg_gen_sari_i32(cpu_NF, t, 31);
+    tcg_gen_andi_i32(cpu_ZF, t, 2);
+    tcg_gen_andi_i32(cpu_CF, t, 1);
+    tcg_gen_movi_i32(cpu_VF, 0);
+
+    tcg_temp_free_i32(t);
+}
+
+void trans_ANDS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_ands_pred);
+}
+
+void trans_BICS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_bics_pred);
+}
+
+void trans_EORS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_eors_pred);
+}
+
+void trans_ORRS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_orrs_pred);
+}
+
+void trans_ORNS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_orns_pred);
+}
+
+void trans_NORS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_nors_pred);
+}
+
+void trans_NANDS_pppp(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    do_logical_pppp_flags(s, a, gen_helper_sve_nands_pred);
+}
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index d1ca1f799b..edcd32db88 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -20,4 +20,4 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.def $(DECODETREE)
 		"GEN", $@)
 
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-obj-$(TARGET_AARCH64) += translate-sve.o
+obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
diff --git a/target/arm/sve.def b/target/arm/sve.def
index f802031f51..77f96510d8 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -25,6 +25,7 @@
 # instruction patterns.
 
 &rrr_esz		rd rn rm esz
+&rprr_esz		rd pg rn rm esz
 &pred_set		rd pat esz i s
 
 ###########################################################################
@@ -34,6 +35,9 @@
 # Three operand with unused vector element size
 @rd_rn_rm		........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=0
 
+# Three prediate operand, with governing predicate, unused vector element size
+@pd_pg_pn_pm		........ .... rm:4 .. pg:4 . rn:4 . rd:4	&rprr_esz esz=0
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -55,3 +59,20 @@ pred_set		00100101 00 011 000 1110 0100 0000 rd:4		&pred_set pat=31 esz=0 i=0 s=
 
 # SVE initialize FFR (SETFFR)
 pred_set		00100101 0010 1100 1001 0000 0000 0000		&pred_set pat=31 esz=0 rd=16 i=1 s=0
+
+# SVE predicate logical operations
+AND_pppp		00100101 00 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm
+BIC_pppp		00100101 00 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm
+EOR_pppp		00100101 00 00 .... 01 .... 1 .... 0 ....	@pd_pg_pn_pm
+SEL_pppp		00100101 00 00 .... 01 .... 1 .... 1 ....	@pd_pg_pn_pm
+ANDS_pppp		00100101 01 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm
+BICS_pppp		00100101 01 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm
+EORS_pppp		00100101 01 00 .... 01 .... 1 .... 0 ....	@pd_pg_pn_pm
+ORR_pppp		00100101 10 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm
+ORN_pppp		00100101 10 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm
+NOR_pppp		00100101 10 00 .... 01 .... 1 .... 0 ....	@pd_pg_pn_pm
+NAND_pppp		00100101 10 00 .... 01 .... 1 .... 1 ....	@pd_pg_pn_pm
+ORRS_pppp		00100101 11 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm
+ORNS_pppp		00100101 11 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm
+NORS_pppp		00100101 11 00 .... 01 .... 1 .... 0 ....	@pd_pg_pn_pm
+NANDS_pppp		00100101 11 00 .... 01 .... 1 .... 1 ....	@pd_pg_pn_pm
-- 
2.14.3
