Received: from eggs.gnu.org ([2001:4830:134:3::10]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI16-0004wL-SP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI14-0003Cq-5G
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebI13-0003Cf-RV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:26 -0500
Received: by mail-pg0-x241.google.com with SMTP id k68so1205206pga.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:34:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:33:43 -0800
Message-Id: <20180116033404.31532-6-richard.henderson@linaro.org>
In-Reply-To: <20180116033404.31532-1-richard.henderson@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v9 05/26] tcg: Add generic vector ops for
 interleave
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

Includes zip, unzip, and transform.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  15 +++
 tcg/tcg-op-gvec.h            |  13 ++
 tcg/tcg-op.h                 |   6 +
 tcg/tcg-opc.h                |   7 +
 tcg/tcg.h                    |   3 +
 accel/tcg/tcg-runtime-gvec.c |  78 ++++++++++++
 tcg/tcg-op-gvec.c            | 297 +++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  55 ++++++++
 tcg/tcg.c                    |   9 ++
 tcg/README                   |  40 ++++++
 10 files changed, 523 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 76ee41ce58..c6de749134 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -163,3 +163,18 @@ DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_zip8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_zip16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_zip32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_zip64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uzp8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uzp16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uzp32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uzp64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_trn8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_trn16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_trn32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_trn64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 57285ec293..f4afcd258e 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -179,6 +179,19 @@ void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
 void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
 void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
 
+void tcg_gen_gvec_zipl(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_ziph(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_uzpe(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_uzpo(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_trne(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 09fec5693f..87be11a90d 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -927,6 +927,12 @@ void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_zipl_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_ziph_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_uzpe_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_uzpo_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_trne_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_trno_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index b4e16cfbc3..c911d62442 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -229,6 +229,13 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
 DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
 DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
 
+DEF(zipl_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_zip_vec))
+DEF(ziph_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_zip_vec))
+DEF(uzpe_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_uzp_vec))
+DEF(uzpo_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_uzp_vec))
+DEF(trne_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
+DEF(trno_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
+
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #if TCG_TARGET_MAYBE_vec
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5560e6439a..bccdaa5eca 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -178,6 +178,9 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_zip_vec          0
+#define TCG_TARGET_HAS_uzp_vec          0
+#define TCG_TARGET_HAS_trn_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index cd1ce12b7e..628df811b2 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -293,3 +293,81 @@ void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+/* The size of the alloca in the following is currently bounded to 2k.  */
+
+#define DO_ZIP(NAME, TYPE) \
+void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                  \
+{                                                                            \
+    intptr_t oprsz = simd_oprsz(desc);                                       \
+    intptr_t oprsz_2 = oprsz / 2;                                            \
+    intptr_t i;                                                              \
+    /* We produce output faster than we consume input.                       \
+       Therefore we must be mindful of possible overlap.  */                 \
+    if (unlikely((a - d) < (uintptr_t)oprsz)) {                              \
+        void *a_new = alloca(oprsz_2);                                       \
+        memcpy(a_new, a, oprsz_2);                                           \
+        a = a_new;                                                           \
+    }                                                                        \
+    if (unlikely((b - d) < (uintptr_t)oprsz)) {                              \
+        void *b_new = alloca(oprsz_2);                                       \
+        memcpy(b_new, b, oprsz_2);                                           \
+        b = b_new;                                                           \
+    }                                                                        \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                            \
+	*(TYPE *)(d + 2 * i + 0) = *(TYPE *)(a + i);                         \
+	*(TYPE *)(d + 2 * i + sizeof(TYPE)) = *(TYPE *)(b + i);              \
+    }                                                                        \
+    clear_high(d, oprsz, desc);                                              \
+}
+
+DO_ZIP(gvec_zip8, uint8_t)
+DO_ZIP(gvec_zip16, uint16_t)
+DO_ZIP(gvec_zip32, uint32_t)
+DO_ZIP(gvec_zip64, uint64_t)
+
+#define DO_UZP(NAME, TYPE) \
+void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                  \
+{                                                                            \
+    intptr_t oprsz = simd_oprsz(desc);                                       \
+    intptr_t oprsz_2 = oprsz / 2;                                            \
+    intptr_t odd_ofs = simd_data(desc);                                      \
+    intptr_t i;                                                              \
+    if (unlikely((b - d) < (uintptr_t)oprsz)) {                              \
+        void *b_new = alloca(oprsz);                                         \
+        memcpy(b_new, b, oprsz);                                             \
+        b = b_new;                                                           \
+    }                                                                        \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                            \
+        *(TYPE *)(d + i) = *(TYPE *)(a + 2 * i + odd_ofs);                   \
+    }                                                                        \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                            \
+        *(TYPE *)(d + oprsz_2 + i) = *(TYPE *)(b + 2 * i + odd_ofs);         \
+    }                                                                        \
+    clear_high(d, oprsz, desc);                                              \
+}
+
+DO_UZP(gvec_uzp8, uint8_t)
+DO_UZP(gvec_uzp16, uint16_t)
+DO_UZP(gvec_uzp32, uint32_t)
+DO_UZP(gvec_uzp64, uint64_t)
+
+#define DO_TRN(NAME, TYPE) \
+void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                  \
+{                                                                            \
+    intptr_t oprsz = simd_oprsz(desc);                                       \
+    intptr_t odd_ofs = simd_data(desc);                                      \
+    intptr_t i;                                                              \
+    for (i = 0; i < oprsz; i += 2 * sizeof(TYPE)) {                          \
+        TYPE ae = *(TYPE *)(a + i + odd_ofs);                                \
+        TYPE be = *(TYPE *)(b + i + odd_ofs);                                \
+	*(TYPE *)(d + i + 0) = ae;                                           \
+	*(TYPE *)(d + i + sizeof(TYPE)) = be;                                \
+    }                                                                        \
+    clear_high(d, oprsz, desc);                                              \
+}
+
+DO_TRN(gvec_trn8, uint8_t)
+DO_TRN(gvec_trn16, uint16_t)
+DO_TRN(gvec_trn32, uint32_t)
+DO_TRN(gvec_trn64, uint64_t)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 206ae16b19..18f5da2c8b 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1293,3 +1293,300 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
 }
+
+static void do_zip(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t bofs, uint32_t oprsz, uint32_t maxsz,
+                   bool high)
+{
+    static gen_helper_gvec_3 * const zip_fns[4] = {
+        gen_helper_gvec_zip8,
+        gen_helper_gvec_zip16,
+        gen_helper_gvec_zip32,
+        gen_helper_gvec_zip64,
+    };
+
+    TCGType type;
+    uint32_t step, i, n;
+    TCGOpcode zip_op;
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, oprsz);
+    tcg_debug_assert(vece <= MO_64);
+
+    zip_op = high ? INDEX_op_ziph_vec : INDEX_op_zipl_vec;
+
+    /* Since these operations don't operate in lock-step lanes,
+       we must care for overlap.  */
+    if (TCG_TARGET_HAS_v256 && oprsz % 32 == 0 && oprsz / 32 <= 8
+        && tcg_can_emit_vec_op(zip_op, TCG_TYPE_V256, vece)) {
+        type = TCG_TYPE_V256;
+        step = 32;
+        n = oprsz / 32;
+    } else if (TCG_TARGET_HAS_v128 && oprsz % 16 == 0 && oprsz / 16 <= 8
+               && tcg_can_emit_vec_op(zip_op, TCG_TYPE_V128, vece)) {
+        type = TCG_TYPE_V128;
+        step = 16;
+        n = oprsz / 16;
+    } else if (TCG_TARGET_HAS_v64 && oprsz % 8 == 0 && oprsz / 8 <= 8
+               && tcg_can_emit_vec_op(zip_op, TCG_TYPE_V64, vece)) {
+        type = TCG_TYPE_V64;
+        step = 8;
+        n = oprsz / 8;
+    } else {
+        if (high) {
+            aofs += oprsz / 2;
+            bofs += oprsz / 2;
+        }
+        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, zip_fns[vece]);
+        return;
+    }
+
+    if (n == 1) {
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
+
+        tcg_gen_ld_vec(t1, cpu_env, aofs);
+        tcg_gen_ld_vec(t2, cpu_env, bofs);
+        if (high) {
+            tcg_gen_ziph_vec(vece, t1, t1, t2);
+        } else {
+            tcg_gen_zipl_vec(vece, t1, t1, t2);
+        }
+        tcg_gen_st_vec(t1, cpu_env, dofs);
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+    } else {
+        TCGv_vec ta[4], tb[4], tmp;
+
+        if (high) {
+            aofs += oprsz / 2;
+            bofs += oprsz / 2;
+        }
+
+        for (i = 0; i < (n / 2 + n % 2); ++i) {
+            ta[i] = tcg_temp_new_vec(type);
+            tb[i] = tcg_temp_new_vec(type);
+            tcg_gen_ld_vec(ta[i], cpu_env, aofs + i * step);
+            tcg_gen_ld_vec(tb[i], cpu_env, bofs + i * step);
+        }
+
+        tmp = tcg_temp_new_vec(type);
+        for (i = 0; i < n; ++i) {
+            if (i & 1) {
+                tcg_gen_ziph_vec(vece, tmp, ta[i / 2], tb[i / 2]);
+            } else {
+                tcg_gen_zipl_vec(vece, tmp, ta[i / 2], tb[i / 2]);
+            }
+            tcg_gen_st_vec(tmp, cpu_env, dofs + i * step);
+        }
+        tcg_temp_free_vec(tmp);
+
+        for (i = 0; i < (n / 2 + n % 2); ++i) {
+            tcg_temp_free_vec(ta[i]);
+            tcg_temp_free_vec(tb[i]);
+        }
+    }
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
+void tcg_gen_gvec_zipl(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    do_zip(vece, dofs, aofs, bofs, oprsz, maxsz, false);
+}
+
+void tcg_gen_gvec_ziph(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    do_zip(vece, dofs, aofs, bofs, oprsz, maxsz, true);
+}
+
+static void do_uzp(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t bofs, uint32_t oprsz, uint32_t maxsz, bool odd)
+{
+    static gen_helper_gvec_3 * const uzp_fns[4] = {
+        gen_helper_gvec_uzp8,
+        gen_helper_gvec_uzp16,
+        gen_helper_gvec_uzp32,
+        gen_helper_gvec_uzp64,
+    };
+
+    TCGType type;
+    uint32_t step, i, n;
+    TCGv_vec t[8];
+    TCGOpcode uzp_op;
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, oprsz);
+    tcg_debug_assert(vece <= MO_64);
+
+    uzp_op = odd ? INDEX_op_uzpo_vec : INDEX_op_uzpe_vec;
+
+    /* Since these operations don't operate in lock-step lanes,
+       we must care for overlap.  */
+    if (TCG_TARGET_HAS_v256 && oprsz % 32 == 0 && oprsz / 32 <= 4
+        && tcg_can_emit_vec_op(uzp_op, TCG_TYPE_V256, vece)) {
+        type = TCG_TYPE_V256;
+        step = 32;
+        n = oprsz / 32;
+    } else if (TCG_TARGET_HAS_v128 && oprsz % 16 == 0 && oprsz / 16 <= 4
+               && tcg_can_emit_vec_op(uzp_op, TCG_TYPE_V128, vece)) {
+        type = TCG_TYPE_V128;
+        step = 16;
+        n = oprsz / 16;
+    } else if (TCG_TARGET_HAS_v64 && oprsz % 8 == 0 && oprsz / 8 <= 4
+               && tcg_can_emit_vec_op(uzp_op, TCG_TYPE_V64, vece)) {
+        type = TCG_TYPE_V64;
+        step = 8;
+        n = oprsz / 8;
+    } else {
+        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz,
+                           (1 << vece) * odd, uzp_fns[vece]);
+        return;
+    }
+
+    for (i = 0; i < n; ++i) {
+        t[i] = tcg_temp_new_vec(type);
+        tcg_gen_ld_vec(t[i], cpu_env, aofs + i * step);
+    }
+    for (i = 0; i < n; ++i) {
+        t[n + i] = tcg_temp_new_vec(type);
+        tcg_gen_ld_vec(t[n + i], cpu_env, bofs + i * step);
+    }
+    for (i = 0; i < n; ++i) {
+        if (odd) {
+            tcg_gen_uzpo_vec(vece, t[2 * i], t[2 * i], t[2 * i + 1]);
+        } else {
+            tcg_gen_uzpe_vec(vece, t[2 * i], t[2 * i], t[2 * i + 1]);
+        }
+        tcg_gen_st_vec(t[2 * i], cpu_env, dofs + i * step);
+        tcg_temp_free_vec(t[2 * i]);
+        tcg_temp_free_vec(t[2 * i + 1]);
+    }
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
+void tcg_gen_gvec_uzpe(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    do_uzp(vece, dofs, aofs, bofs, oprsz, maxsz, false);
+}
+
+void tcg_gen_gvec_uzpo(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    do_uzp(vece, dofs, aofs, bofs, oprsz, maxsz, true);
+}
+
+static void gen_trne8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    uint64_t m = 0x00ff00ff00ff00ffull;
+    tcg_gen_andi_i64(a, a, m);
+    tcg_gen_andi_i64(b, b, m);
+    tcg_gen_shli_i64(b, b, 8);
+    tcg_gen_or_i64(d, a, b);
+}
+
+static void gen_trne16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    uint64_t m = 0x0000ffff0000ffffull;
+    tcg_gen_andi_i64(a, a, m);
+    tcg_gen_andi_i64(b, b, m);
+    tcg_gen_shli_i64(b, b, 16);
+    tcg_gen_or_i64(d, a, b);
+}
+
+static void gen_trne32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_deposit_i64(d, a, b, 32, 32);
+}
+
+void tcg_gen_gvec_trne(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_trne8_i64,
+          .fniv = tcg_gen_trne_vec,
+          .fno = gen_helper_gvec_trn8,
+          .opc = INDEX_op_trne_vec,
+          .vece = MO_8 },
+        { .fni8 = gen_trne16_i64,
+          .fniv = tcg_gen_trne_vec,
+          .fno = gen_helper_gvec_trn16,
+          .opc = INDEX_op_trne_vec,
+          .vece = MO_16 },
+        { .fni8 = gen_trne32_i64,
+          .fniv = tcg_gen_trne_vec,
+          .fno = gen_helper_gvec_trn32,
+          .opc = INDEX_op_trne_vec,
+          .vece = MO_32 },
+        { .fniv = tcg_gen_trne_vec,
+          .fno = gen_helper_gvec_trn64,
+          .opc = INDEX_op_trne_vec,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+static void gen_trno8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    uint64_t m = 0xff00ff00ff00ff00ull;
+    tcg_gen_andi_i64(a, a, m);
+    tcg_gen_andi_i64(b, b, m);
+    tcg_gen_shri_i64(a, a, 8);
+    tcg_gen_or_i64(d, a, b);
+}
+
+static void gen_trno16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    uint64_t m = 0xffff0000ffff0000ull;
+    tcg_gen_andi_i64(a, a, m);
+    tcg_gen_andi_i64(b, b, m);
+    tcg_gen_shri_i64(a, a, 16);
+    tcg_gen_or_i64(d, a, b);
+}
+
+static void gen_trno32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_shri_i64(a, a, 32);
+    tcg_gen_deposit_i64(d, b, a, 0, 32);
+}
+
+void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fni8 = gen_trno8_i64,
+          .fniv = tcg_gen_trno_vec,
+          .fno = gen_helper_gvec_trn8,
+          .opc = INDEX_op_trno_vec,
+          .data = 1,
+          .vece = MO_8 },
+        { .fni8 = gen_trno16_i64,
+          .fniv = tcg_gen_trno_vec,
+          .fno = gen_helper_gvec_trn16,
+          .opc = INDEX_op_trno_vec,
+          .data = 2,
+          .vece = MO_16 },
+        { .fni8 = gen_trno32_i64,
+          .fniv = tcg_gen_trno_vec,
+          .fno = gen_helper_gvec_trn32,
+          .opc = INDEX_op_trno_vec,
+          .data = 4,
+          .vece = MO_32 },
+        { .fniv = tcg_gen_trno_vec,
+          .fno = gen_helper_gvec_trn64,
+          .opc = INDEX_op_trno_vec,
+          .data = 8,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 5cfe4af6bd..a5d0ff89c3 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -380,3 +380,58 @@ void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
         tcg_temp_free_vec(t);
     }
 }
+
+static void do_interleave(TCGOpcode opc, unsigned vece,
+                          TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGArg bi = temp_arg(bt);
+    TCGType type = rt->base_type;
+    unsigned vecl = type - TCG_TYPE_V64;
+    int can;
+
+    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert((8 << vece) <= (32 << vecl));
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_3(opc, type, vece, ri, ai, bi);
+    } else {
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
+    }
+}
+
+void tcg_gen_zipl_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_zipl_vec, vece, r, a, b);
+}
+
+void tcg_gen_ziph_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_ziph_vec, vece, r, a, b);
+}
+
+void tcg_gen_uzpe_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_uzpe_vec, vece, r, a, b);
+}
+
+void tcg_gen_uzpo_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_uzpo_vec, vece, r, a, b);
+}
+
+void tcg_gen_trne_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_trne_vec, vece, r, a, b);
+}
+
+void tcg_gen_trno_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_interleave(INDEX_op_trno_vec, vece, r, a, b);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b4f8938fb0..33e3c03cbc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1403,6 +1403,15 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
         return have_vec && TCG_TARGET_HAS_orc_vec;
+    case INDEX_op_zipl_vec:
+    case INDEX_op_ziph_vec:
+        return have_vec && TCG_TARGET_HAS_zip_vec;
+    case INDEX_op_uzpe_vec:
+    case INDEX_op_uzpo_vec:
+        return have_vec && TCG_TARGET_HAS_uzp_vec;
+    case INDEX_op_trne_vec:
+    case INDEX_op_trno_vec:
+        return have_vec && TCG_TARGET_HAS_trn_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
diff --git a/tcg/README b/tcg/README
index e14990fb9b..8ab8d3ab7e 100644
--- a/tcg/README
+++ b/tcg/README
@@ -561,6 +561,46 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
   Similarly, logical operations with and without compliment.
   Note that VECE is unused.
 
+* zipl_vec  v0, v1, v2
+* ziph_vec  v0, v1, v2
+
+  "Zip" two vectors together, either the low half of v1/v2 or the high half.
+  The name comes from ARM ARM; the equivalent function in Intel terminology
+  is the less scrutable "punpck".  The effect is
+
+    part = ("high" ? VECL/VECE/2 : 0);
+    for (i = 0; i < VECL/VECE/2; ++i) {
+      v0[2i + 0] = v1[i + part];
+      v0[2i + 1] = v2[i + part];
+    }
+
+* uzpe_vec  v0, v1, v2
+* uzpo_vec  v0, v1, v2
+
+  "Unzip" two vectors, either the even elements or the odd elements.
+  If v1 and v2 are the result of zipl and ziph, this performs the
+  inverse operation.  The effect is
+
+    part = ("odd" ? 1 : 0)
+    for (i = 0; i < VECL/VECE/2; ++i) {
+      v0[i] = v1[2i + part];
+    }
+    for (i = 0; i < VECL/VECE/2; ++i) {
+      v0[i + VECL/VECE/2] = v1[2i + part];
+    }
+
+* trne_vec  v0, v1, v2
+* trno_vec  v1, v1, v2
+
+  "Transpose" two vectors, either the even elements or the odd elements.
+  The effect is
+
+    part = ("odd" ? 1 : 0)
+    for (i = 0; i < VECL/VECE/2; ++i) {
+      v0[2i + 0] = v1[2i + part];
+      v0[2i + 1] = v2[2i + part];
+    }
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.14.3
