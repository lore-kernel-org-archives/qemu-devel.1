Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevu-0007Tp-BQ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevs-00051q-ON
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:06 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevs-00050G-F7
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:04 -0500
Received: by mail-pl0-x242.google.com with SMTP id 1so4240867plv.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:04 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:31 -0800
Message-Id: <20180106031346.6650-9-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 08/23] tcg: Add generic vector ops for
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
index 28abf30d76..c4a2e6b215 100644
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
index c71aded066..41839a61a6 100644
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
index 777db6ad59..f967790cd9 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -920,6 +920,7 @@ void tcg_gen_movi_v128(TCGv_vec, uint64_t, uint64_t);
 void tcg_gen_movi_v256(TCGv_vec, uint64_t, uint64_t, uint64_t, uint64_t);
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index d3fa014507..b21a30273c 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -220,6 +220,7 @@ DEF(st_vec, 0, 2, 1, IMPLVEC)
 
 DEF(add_vec, 1, 2, 0, IMPLVEC)
 DEF(sub_vec, 1, 2, 0, IMPLVEC)
+DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
 DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
 
 DEF(and_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index ceef8742b5..64078a2e92 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -185,6 +185,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_uzp_vec          0
 #define TCG_TARGET_HAS_trn_vec          0
 #define TCG_TARGET_HAS_cmp_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index e0cde3216f..9406ccd769 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -141,6 +141,50 @@ void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
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
index 664dcae041..5e970cb2aa 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1404,6 +1404,35 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t opsz, uint32_t maxsz)
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
+    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+}
+
 /* Perform a vector negation using normal negation and a mask.
    Compare gen_subv_mask above.  */
 static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index b3f0ec324a..9038cc6c84 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -503,3 +503,25 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
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
index a85547a6d2..5608391dca 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1404,6 +1404,8 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
         return have_vec && TCG_TARGET_HAS_orc_vec;
+    case INDEX_op_mul_vec:
+        return have_vec && TCG_TARGET_HAS_mul_vec;
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
diff --git a/tcg/README b/tcg/README
index 18b6bbd8f1..17695ff7f6 100644
--- a/tcg/README
+++ b/tcg/README
@@ -547,6 +547,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Similarly, v0 = v1 - v2.
 
+* mul_vec   v0, v1, v2
+
+  Similarly, v0 = v1 * v2.
+
 * neg_vec   v0, v1
 
   Similarly, v0 = -v1.
-- 
2.14.3
