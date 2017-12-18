Received: from eggs.gnu.org ([2001:4830:134:3::10]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3d-0000X5-8k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3Y-0001C7-HI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:29 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3Y-0001BA-6g
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:24 -0500
Received: by mail-pl0-x241.google.com with SMTP id b12so5186261plm.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:46 -0800
Message-Id: <20171218171758.16964-15-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 14/26] tcg: Add generic vector ops for
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
 accel/tcg/tcg-runtime.h      |  30 +++++++
 tcg/i386/tcg-target.h        |   1 +
 tcg/tcg-op-gvec.h            |   4 +
 tcg/tcg-op.h                 |   3 +
 tcg/tcg-opc.h                |   2 +
 tcg/tcg.h                    |   1 +
 accel/tcg/tcg-runtime-gvec.c |  24 +++++
 tcg/tcg-op-gvec.c            | 202 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  23 +++++
 tcg/tcg.c                    |   2 +
 tcg/README                   |   4 +
 11 files changed, 296 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index cb05a755b8..28abf30d76 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -193,3 +193,33 @@ DEF_HELPER_FLAGS_4(gvec_trn8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_trn16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_trn32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_trn64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 92d533eb92..46c4dca7be 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -183,6 +183,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_zip_vec          0
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
+#define TCG_TARGET_HAS_cmp_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index de2c0e669a..308bdc13b4 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -178,6 +178,10 @@ void tcg_gen_gvec_trne(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t opsz, uint32_t clsz);
 
+void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
+                      uint32_t aofs, uint32_t bofs,
+                      uint32_t opsz, uint32_t clsz);
+
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 83478ab006..b4f73c6048 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -939,6 +939,9 @@ void tcg_gen_uzpo_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_trne_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_trno_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
+void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
+                     TCGv_vec a, TCGv_vec b);
+
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index a085fc077b..d3fa014507 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -248,6 +248,8 @@ DEF(uzpo_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_uzp_vec))
 DEF(trne_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
 DEF(trno_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
 
+DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #if TCG_TARGET_MAYBE_vec
diff --git a/tcg/tcg.h b/tcg/tcg.h
index bdfe058c45..ceef8742b5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -184,6 +184,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_zip_vec          0
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
+#define TCG_TARGET_HAS_cmp_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index fba62f1192..e0cde3216f 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -520,3 +520,27 @@ DO_TRN(gvec_trn8, uint8_t)
 DO_TRN(gvec_trn16, uint16_t)
 DO_TRN(gvec_trn32, uint32_t)
 DO_TRN(gvec_trn64, uint64_t)
+
+#define DO_CMP1(NAME, TYPE, OP)                                              \
+void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                  \
+{                                                                            \
+    intptr_t oprsz = simd_oprsz(desc);                                       \
+    intptr_t i;                                                              \
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {                             \
+        *(TYPE *)(d + i) = *(TYPE *)(a + i) OP *(TYPE *)(b + i);             \
+    }                                                                        \
+    clear_high(d, oprsz, desc);                                              \
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
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index b29a30a78b..0db48bc75a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1721,3 +1721,205 @@ void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_debug_assert(vece <= MO_64);
     tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
 }
+
+/* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
+static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                           uint32_t opsz, TCGCond cond)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 4) {
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
+                           uint32_t opsz, TCGCond cond)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += 8) {
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
+                           uint32_t bofs, uint32_t opsz, uint32_t tysz,
+                           TCGType type, TCGCond cond)
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < opsz; i += tysz) {
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
+    gen_helper_gvec_3 *fn;
+    uint32_t tmp;
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, maxsz);
+
+    if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
+        tcg_gen_gvec_dup32i(dofs, oprsz, maxsz, -(cond == TCG_COND_ALWAYS));
+        return;
+    }
+
+    /* Quick check for sizes we won't support inline.  */
+    if (oprsz > MAX_UNROLL * 32 || maxsz > MAX_UNROLL * 32) {
+        goto do_ool;
+    }
+
+    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+       Expand with successively smaller host vector sizes.  The intent is
+       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+    /* ??? For maxsz > oprsz, the host may be able to use an op-sized
+       operation, zeroing the balance of the register.  We can then
+       use a cl-sized store to implement the clearing without an extra
+       store operation.  This is true for aarch64 and x86_64 hosts.  */
+
+    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
+        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V256, vece)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_cmp_vec(vece, dofs, aofs, bofs, done, 32, TCG_TYPE_V256, cond);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
+        && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V128, vece)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
+        expand_cmp_vec(vece, dofs, aofs, bofs, done, 16, TCG_TYPE_V128, cond);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (check_size_impl(oprsz, 8)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
+        if (TCG_TARGET_HAS_v64
+            && (TCG_TARGET_REG_BITS == 32 || vece != MO_64)
+            && tcg_can_emit_vec_op(INDEX_op_cmp_vec, TCG_TYPE_V64, vece)) {
+            expand_cmp_vec(vece, dofs, aofs, bofs, done, 8, TCG_TYPE_V64, cond);
+        } else if (vece == MO_64) {
+            expand_cmp_i64(dofs, aofs, bofs, done, cond);
+        } else {
+            done = 0;
+        }
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (vece == MO_32 && check_size_impl(oprsz, 4)) {
+        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
+        expand_cmp_i32(dofs, aofs, bofs, done, cond);
+        dofs += done;
+        aofs += done;
+        bofs += done;
+        oprsz -= done;
+        maxsz -= done;
+    }
+
+    if (oprsz == 0) {
+        if (maxsz != 0) {
+            expand_clr(dofs, maxsz);
+        }
+        return;
+    }
+
+ do_ool:
+    switch (cond) {
+    case TCG_COND_EQ:
+        fn = eq_fn[vece];
+        break;
+    case TCG_COND_NE:
+        fn = ne_fn[vece];
+        break;
+    case TCG_COND_GT:
+        tmp = aofs, aofs = bofs, bofs = tmp;
+        /* fallthru */
+    case TCG_COND_LT:
+        fn = lt_fn[vece];
+        break;
+    case TCG_COND_GE:
+        tmp = aofs, aofs = bofs, bofs = tmp;
+        /* fallthru */
+    case TCG_COND_LE:
+        fn = le_fn[vece];
+        break;
+    case TCG_COND_GTU:
+        tmp = aofs, aofs = bofs, bofs = tmp;
+        /* fallthru */
+    case TCG_COND_LTU:
+        fn = ltu_fn[vece];
+        break;
+    case TCG_COND_GEU:
+        tmp = aofs, aofs = bofs, bofs = tmp;
+        /* fallthru */
+    case TCG_COND_LEU:
+        fn = leu_fn[vece];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn);
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 502c5ba891..2c636ebbd6 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -480,3 +480,26 @@ void tcg_gen_trno_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_interleave(INDEX_op_trno_vec, vece, r, a, b);
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
index f82d6e80b0..a85547a6d2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1392,6 +1392,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_cmp_vec:
         return have_vec;
     case INDEX_op_dup2_vec:
         return have_vec && TCG_TARGET_REG_BITS == 32;
@@ -1791,6 +1792,7 @@ void tcg_dump_ops(TCGContext *s)
             case INDEX_op_brcond_i64:
             case INDEX_op_setcond_i64:
             case INDEX_op_movcond_i64:
+            case INDEX_op_cmp_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
                     && cond_name[op->args[k]]) {
                     col += qemu_log(",%s", cond_name[op->args[k++]]);
diff --git a/tcg/README b/tcg/README
index 75db47922d..18b6bbd8f1 100644
--- a/tcg/README
+++ b/tcg/README
@@ -630,6 +630,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
       v0[2i + 1] = v2[2i + part];
     }
 
+* cmp_vec  v0, v1, v2, cond
+
+  Compare vectors by element, storing -1 for true and 0 for false.
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.14.3
