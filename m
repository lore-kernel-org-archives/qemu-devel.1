Received: from eggs.gnu.org ([2001:4830:134:3::10]:50404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eew5d-0008Ga-MW
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 23:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eew5Y-0003js-Nt
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 23:58:13 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eew5Y-0003jH-GU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 23:58:08 -0500
Received: by mail-pf0-x242.google.com with SMTP id e76so7505421pfk.1
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 20:58:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Jan 2018 20:57:29 -0800
Message-Id: <20180126045742.5487-8-richard.henderson@linaro.org>
In-Reply-To: <20180126045742.5487-1-richard.henderson@linaro.org>
References: <20180126045742.5487-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v11 07/20] tcg: Add generic vector ops for
 multiplication
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
 accel/tcg/tcg-runtime.h      |  5 +++++
 tcg/tcg-op-gvec.h            |  2 ++
 tcg/tcg-op.h                 |  1 +
 tcg/tcg-opc.h                |  1 +
 tcg/tcg.h                    |  1 +
 accel/tcg/tcg-runtime-gvec.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 29 +++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             | 22 ++++++++++++++++++++++
 tcg/tcg.c                    |  2 ++
 tcg/README                   |  4 ++++
 10 files changed, 111 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c840debc40..54f7e78b09 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -152,6 +152,11 @@ DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_mul8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 60a17ee908..abe909df39 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -176,6 +176,8 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 113d9a6c3a..75bb55aeac 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -917,6 +917,7 @@ void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 13c0eed3da..d81a6c4535 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -219,6 +219,7 @@ DEF(st_vec, 0, 2, 1, IMPLVEC)
 
 DEF(add_vec, 1, 2, 0, IMPLVEC)
 DEF(sub_vec, 1, 2, 0, IMPLVEC)
+DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
 DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
 
 DEF(and_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8c19a1f41d..9e2d909a4a 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -181,6 +181,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index f2b0cba4a2..59d7a0a2fe 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -166,6 +166,50 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_mul8)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(vec8 *)(d + i) = *(vec8 *)(a + i) * *(vec8 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_mul16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec16)) {
+        *(vec16 *)(d + i) = *(vec16 *)(a + i) * *(vec16 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_mul32)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(vec32 *)(d + i) = *(vec32 *)(a + i) * *(vec32 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_mul64)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(vec64 *)(d + i) = *(vec64 *)(a + i) * *(vec64 *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 30c825108e..027f3e9740 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1279,6 +1279,35 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_mul_vec,
+          .fno = gen_helper_gvec_mul8,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_mul_vec,
+          .fno = gen_helper_gvec_mul16,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_mul_i32,
+          .fniv = tcg_gen_mul_vec,
+          .fno = gen_helper_gvec_mul32,
+          .opc = INDEX_op_mul_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_mul_i64,
+          .fniv = tcg_gen_mul_vec,
+          .fno = gen_helper_gvec_mul64,
+          .opc = INDEX_op_mul_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 /* Perform a vector negation using normal negation and a mask.
    Compare gen_subv_mask above.  */
 static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 4a6f92fd11..70ec889bc1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -365,3 +365,25 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
         tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
     }
 }
+
+void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
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
+    can = tcg_can_emit_vec_op(INDEX_op_mul_vec, type, vece);
+    if (can > 0) {
+        vec_gen_3(INDEX_op_mul_vec, type, vece, ri, ai, bi);
+    } else {
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(INDEX_op_mul_vec, type, vece, ri, ai, bi);
+    }
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index de709833b1..bb24526c93 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1403,6 +1403,8 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
         return have_vec && TCG_TARGET_HAS_orc_vec;
+    case INDEX_op_mul_vec:
+        return have_vec && TCG_TARGET_HAS_mul_vec;
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
diff --git a/tcg/README b/tcg/README
index 90d4de7776..bb2ea5121b 100644
--- a/tcg/README
+++ b/tcg/README
@@ -538,6 +538,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Similarly, v0 = v1 - v2.
 
+* mul_vec   v0, v1, v2
+
+  Similarly, v0 = v1 * v2.
+
 * neg_vec   v0, v1
 
   Similarly, v0 = -v1.
-- 
2.14.3
