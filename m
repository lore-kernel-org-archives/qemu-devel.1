Received: from eggs.gnu.org ([2001:4830:134:3::10]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1R-0005Ac-HN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1P-0003JH-M0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:49 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebI1P-0003Iv-DT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:47 -0500
Received: by mail-pg0-x242.google.com with SMTP id d6so8851587pgv.2
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:34:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:33:51 -0800
Message-Id: <20180116033404.31532-14-richard.henderson@linaro.org>
In-Reply-To: <20180116033404.31532-1-richard.henderson@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v9 13/26] tcg: Add generic vector helpers with
 a scalar variable operand
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

Use dup to convert the scalar to a third vector.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |   5 ++
 tcg/tcg-op-gvec.h            |  28 ++++++
 accel/tcg/tcg-runtime-gvec.c |  48 ++++++++++
 tcg/tcg-op-gvec.c            | 207 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 30bb10f9f1..65d0c2ec3b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -157,6 +157,11 @@ DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_subs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_subs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_4(gvec_mul8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 1fbb94a0cd..0e8ba3d305 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -122,6 +122,27 @@ typedef struct {
     bool load_dest;
 } GVecGen2i;
 
+typedef struct {
+    /* Expand inline as a 64-bit or 32-bit integer.
+       Only one of these will be non-NULL.  */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
+    /* Expand out-of-line helper w/descriptor.  */
+    gen_helper_gvec_2i *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The data argument to the out-of-line helper.  */
+    uint32_t data;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load scalar as 1st source operand.  */
+    bool scalar_first;
+} GVecGen2s;
+
 typedef struct {
     /* Expand inline as a 64-bit or 32-bit integer.
        Only one of these will be non-NULL.  */
@@ -166,6 +187,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *);
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
@@ -192,6 +215,11 @@ void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz);
+
 /* Saturated arithmetic.  */
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 378658124f..ec8695dd66 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -189,6 +189,54 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec8 vecb = (vec8){ b, b, b, b, b, b, b, b, b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs16)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec16 vecb = (vec16){ b, b, b, b, b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs32)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec32 vecb = (vec32){ b, b, b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_subs64)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    vec64 vecb = (vec64){ b, b };
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) - vecb;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_mul8)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 59570cc17e..7b854841d0 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -576,6 +576,27 @@ static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i32(t1);
 }
 
+static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          TCGv_i32 c, bool scalar_first,
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(t1, c, t0);
+        } else {
+            fni(t1, t0, c);
+        }
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_3_i32(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -659,6 +680,27 @@ static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     tcg_temp_free_i64(t1);
 }
 
+static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                          TCGv_i64 c, bool scalar_first,
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(t1, c, t0);
+        } else {
+            fni(t1, t0, c);
+        }
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
 static void expand_3_i64(uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz, bool load_dest,
@@ -746,6 +788,28 @@ static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t1);
 }
 
+static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                          TCGv_vec c, bool scalar_first,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        if (scalar_first) {
+            fni(vece, t1, c, t0);
+        } else {
+            fni(vece, t1, t0, c);
+        }
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
 static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t oprsz,
@@ -845,6 +909,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     }
 }
 
+/* Expand a vector operation with two vectors and an immediate.  */
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
 {
@@ -896,6 +961,86 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     }
 }
 
+/* Expand a vector operation with two vectors and a scalar.  */
+void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *g)
+{
+    TCGType type;
+
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    type = 0;
+    if (g->fniv) {
+        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
+            type = TCG_TYPE_V256;
+        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
+            type = TCG_TYPE_V128;
+        } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
+               && check_size_impl(oprsz, 8)) {
+            type = TCG_TYPE_V64;
+        }
+    }
+    if (type != 0) {
+        TCGv_vec t_vec = tcg_temp_new_vec(type);
+        uint32_t done;
+
+        tcg_gen_dup_i64_vec(g->vece, t_vec, c);
+
+        /* Recall that ARM SVE allows vector sizes that are not a power of 2.
+           Expand with successively smaller host vector sizes.  The intent is
+           that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
+        switch (type) {
+        case TCG_TYPE_V256:
+            done = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_2s_vec(g->vece, dofs, aofs, done, 32, TCG_TYPE_V256,
+                          t_vec, g->scalar_first, g->fniv);
+            dofs += done;
+            aofs += done;
+            oprsz -= done;
+            maxsz -= done;
+            if (oprsz == 0) {
+                break;
+            }
+            /* fallthru */
+
+        case TCG_TYPE_V128:
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                          t_vec, g->scalar_first, g->fniv);
+            break;
+
+        case TCG_TYPE_V64:
+            expand_2s_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                          t_vec, g->scalar_first, g->fniv);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_vec(t_vec);
+    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
+        TCGv_i64 t64 = tcg_temp_new_i64();
+
+        gen_dup_i64(g->vece, t64, c);
+        expand_2s_i64(dofs, aofs, oprsz, t64, g->scalar_first, g->fni8);
+        tcg_temp_free_i64(t64);
+    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+
+        tcg_gen_extrl_i64_i32(t32, c);
+        gen_dup_i32(g->vece, t32, t32);
+        expand_2s_i32(dofs, aofs, oprsz, t32, g->scalar_first, g->fni4);
+        tcg_temp_free_i32(t32);
+    } else {
+        tcg_gen_gvec_2i_ool(dofs, aofs, c, oprsz, maxsz, 0, g->fno);
+        return;
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
 /* Expand a vector three-operand operation.  */
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
@@ -1264,6 +1409,68 @@ void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &g[vece]);
 }
 
+void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2s g[4] = {
+        { .fni8 = tcg_gen_vec_add8_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds8,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_add16_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds16,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_add_i32,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds32,
+          .opc = INDEX_op_add_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_add_i64,
+          .fniv = tcg_gen_add_vec,
+          .fno = gen_helper_gvec_adds64,
+          .opc = INDEX_op_add_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
+void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen2s g[4] = {
+        { .fni8 = tcg_gen_vec_sub8_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs8,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_sub16_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs16,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_sub_i32,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs32,
+          .opc = INDEX_op_sub_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_sub_i64,
+          .fniv = tcg_gen_sub_vec,
+          .fno = gen_helper_gvec_subs64,
+          .opc = INDEX_op_sub_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, c, &g[vece]);
+}
+
 /* Perform a vector subtraction using normal subtraction and a mask.
    Compare gen_addv_mask above.  */
 static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
-- 
2.14.3
