Received: from eggs.gnu.org ([2001:4830:134:3::10]:50913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewAh-0003EG-1e
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewAd-0008Jh-3B
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:27 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eewAc-0008J5-Rj
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:23 -0500
Received: by mail-pf0-x241.google.com with SMTP id m26so7496850pfj.11
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 21:03:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Jan 2018 20:57:28 -0800
Message-Id: <20180126045742.5487-7-richard.henderson@linaro.org>
In-Reply-To: <20180126045742.5487-1-richard.henderson@linaro.org>
References: <20180126045742.5487-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v11 06/20] tcg: Add generic vector ops for
 comparisons
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
 accel/tcg/tcg-runtime.h      |  30 +++++++++
 tcg/tcg-op-gvec.h            |   4 ++
 tcg/tcg-op.h                 |   3 +
 tcg/tcg-opc.h                |   2 +
 accel/tcg/tcg-runtime-gvec.c |  36 +++++++++++
 tcg/tcg-op-gvec.c            | 151 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  23 +++++++
 tcg/tcg.c                    |   2 +
 tcg/README                   |   4 ++
 9 files changed, 255 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index df23c9aea9..c840debc40 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -178,3 +178,33 @@ DEF_HELPER_FLAGS_3(gvec_sar8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_eq64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_ne8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ne16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ne32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ne64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_lt8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_lt16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_lt32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_lt64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_le8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_le16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_le32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_le64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_ltu8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ltu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ltu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ltu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_leu8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_leu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index b9f9eb7b84..60a17ee908 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -207,6 +207,10 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
+                      uint32_t aofs, uint32_t bofs,
+                      uint32_t oprsz, uint32_t maxsz);
+
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 98e2dfbe90..113d9a6c3a 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -929,6 +929,9 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
+void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
+                     TCGv_vec a, TCGv_vec b);
+
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 43ef67bf46..13c0eed3da 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -240,6 +240,8 @@ DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 
+DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #if TCG_TARGET_MAYBE_vec
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index f0964aadb2..f2b0cba4a2 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -467,3 +467,39 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+/* If vectors are enabled, the compiler fills in -1 for true.
+   Otherwise, we must take care of this by hand.  */
+#ifdef CONFIG_VECTOR16
+# define DO_CMP0(X)  X
+#else
+# define DO_CMP0(X)  -(X)
+#endif
+
+#define DO_CMP1(NAME, TYPE, OP)                                            \
+void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
+{                                                                          \
+    intptr_t oprsz = simd_oprsz(desc);                                     \
+    intptr_t i;                                                            \
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {                           \
+        *(TYPE *)(d + i) = DO_CMP0(*(TYPE *)(a + i) OP *(TYPE *)(b + i));  \
+    }                                                                      \
+    clear_high(d, oprsz, desc);                                            \
+}
+
+#define DO_CMP2(SZ) \
+    DO_CMP1(gvec_eq##SZ, vec##SZ, ==)    \
+    DO_CMP1(gvec_ne##SZ, vec##SZ, !=)    \
+    DO_CMP1(gvec_lt##SZ, svec##SZ, <)    \
+    DO_CMP1(gvec_le##SZ, svec##SZ, <=)   \
+    DO_CMP1(gvec_ltu##SZ, vec##SZ, <)    \
+    DO_CMP1(gvec_leu##SZ, vec##SZ, <=)
+
+DO_CMP2(8)
+DO_CMP2(16)
+DO_CMP2(32)
+DO_CMP2(64)
+
+#undef DO_CMP0
+#undef DO_CMP1
+#undef DO_CMP2
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index ab946a064c..30c825108e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1582,3 +1582,154 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
         tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
     }
 }
+
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
+static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                           uint32_t oprsz, TCGCond cond)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
+        tcg_gen_setcond_i32(cond, t0, t0, t1);
+        tcg_gen_neg_i32(t0, t0);
+        tcg_gen_st_i32(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+}
+
+static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                           uint32_t oprsz, TCGCond cond)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
+        tcg_gen_setcond_i64(cond, t0, t0, t1);
+        tcg_gen_neg_i64(t0, t0);
+        tcg_gen_st_i64(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t0);
+}
+
+static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                           uint32_t bofs, uint32_t oprsz, uint32_t tysz,
+                           TCGType type, TCGCond cond)
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
+        tcg_gen_cmp_vec(cond, vece, t0, t0, t1);
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t0);
+}
+
+void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
+                      uint32_t aofs, uint32_t bofs,
+                      uint32_t oprsz, uint32_t maxsz)
+{
+    static gen_helper_gvec_3 * const eq_fn[4] = {
+        gen_helper_gvec_eq8, gen_helper_gvec_eq16,
+        gen_helper_gvec_eq32, gen_helper_gvec_eq64
+    };
+    static gen_helper_gvec_3 * const ne_fn[4] = {
+        gen_helper_gvec_ne8, gen_helper_gvec_ne16,
+        gen_helper_gvec_ne32, gen_helper_gvec_ne64
+    };
+    static gen_helper_gvec_3 * const lt_fn[4] = {
+        gen_helper_gvec_lt8, gen_helper_gvec_lt16,
+        gen_helper_gvec_lt32, gen_helper_gvec_lt64
+    };
+    static gen_helper_gvec_3 * const le_fn[4] = {
+        gen_helper_gvec_le8, gen_helper_gvec_le16,
+        gen_helper_gvec_le32, gen_helper_gvec_le64
+    };
+    static gen_helper_gvec_3 * const ltu_fn[4] = {
+        gen_helper_gvec_ltu8, gen_helper_gvec_ltu16,
+        gen_helper_gvec_ltu32, gen_helper_gvec_ltu64
+    };
+    static gen_helper_gvec_3 * const leu_fn[4] = {
+        gen_helper_gvec_leu8, gen_helper_gvec_leu16,
+        gen_helper_gvec_leu32, gen_helper_gvec_leu64
+    };
+    static gen_helper_gvec_3 * const * const fns[16] = {
+        [TCG_COND_EQ] = eq_fn,
+        [TCG_COND_NE] = ne_fn,
+        [TCG_COND_LT] = lt_fn,
+        [TCG_COND_LE] = le_fn,
+        [TCG_COND_LTU] = ltu_fn,
+        [TCG_COND_LEU] = leu_fn,
+    };
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, maxsz);
+
+    if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
+        do_dup(MO_8, dofs, oprsz, maxsz,
+               NULL, NULL, -(cond == TCG_COND_ALWAYS));
+        return;
+    }
+
+    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+       Expand with successively smaller host vector sizes.  The intent is
+       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+
+    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
+        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V256, vece)) {
+        uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_cmp_vec(vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256, cond);
+        if (some == oprsz) {
+            goto done;
+        }
+        dofs += some;
+        aofs += some;
+        bofs += some;
+        oprsz -= some;
+        maxsz -= some;
+    }
+
+    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
+        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V128, vece)) {
+        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128, cond);
+    } else if (TCG_TARGET_HAS_v64
+               && check_size_impl(oprsz, 8)
+               && (TCG_TARGET_REG_BITS == 32 || vece != MO_64)
+               && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V64, vece)) {
+        expand_cmp_vec(vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64, cond);
+    } else if (vece == MO_64 && check_size_impl(oprsz, 8)) {
+        expand_cmp_i64(dofs, aofs, bofs, oprsz, cond);
+    } else if (vece == MO_32 && check_size_impl(oprsz, 4)) {
+        expand_cmp_i32(dofs, aofs, bofs, oprsz, cond);
+    } else {
+        gen_helper_gvec_3 * const *fn = fns[cond];
+
+        if (fn == NULL) {
+            uint32_t tmp;
+            tmp = aofs, aofs = bofs, bofs = tmp;
+            cond = tcg_swap_cond(cond);
+            fn = fns[cond];
+            assert(fn != NULL);
+        }
+        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]);
+        return;
+    }
+
+ done:
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6f3060325e..4a6f92fd11 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -342,3 +342,26 @@ void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
 {
     do_shifti(INDEX_op_sari_vec, vece, r, a, i);
 }
+
+void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
+                     TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGArg bi = temp_arg(bt);
+    TCGType type = rt->base_type;
+    int can;
+
+    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(bt->base_type == type);
+    can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
+    if (can > 0) {
+        vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
+    } else {
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
+    }
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 47fb73eecc..de709833b1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1391,6 +1391,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_cmp_vec:
         return have_vec;
     case INDEX_op_dup2_vec:
         return have_vec && TCG_TARGET_REG_BITS == 32;
@@ -1778,6 +1779,7 @@ void tcg_dump_ops(TCGContext *s)
             case INDEX_op_brcond_i64:
             case INDEX_op_setcond_i64:
             case INDEX_op_movcond_i64:
+            case INDEX_op_cmp_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
                     && cond_name[op->args[k]]) {
                     col += qemu_log(",%s", cond_name[op->args[k++]]);
diff --git a/tcg/README b/tcg/README
index 42d301961b..90d4de7776 100644
--- a/tcg/README
+++ b/tcg/README
@@ -581,6 +581,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Similarly for logical and arithmetic right shift.
 
+* cmp_vec  v0, v1, v2, cond
+
+  Compare vectors by element, storing -1 for true and 0 for false.
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.14.3
