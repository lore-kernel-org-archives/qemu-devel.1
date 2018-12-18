Received: from eggs.gnu.org ([2001:4830:134:3::10]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92v-0001fP-48
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92q-0002pa-Jk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:00 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92q-0001vS-4A
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:56 -0500
Received: by mail-pf1-x442.google.com with SMTP id y126so7653568pfb.4
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:42 -0800
Message-Id: <20181218063911.2112-6-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/34] tcg: Add opcodes for vector saturated
 arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h |  1 +
 tcg/i386/tcg-target.h    |  1 +
 tcg/tcg-op.h             |  4 ++
 tcg/tcg-opc.h            |  4 ++
 tcg/tcg.h                |  1 +
 tcg/tcg-op-gvec.c        | 84 ++++++++++++++++++++++++++++++----------
 tcg/tcg-op-vec.c         | 34 ++++++++++++++--
 tcg/tcg.c                |  5 +++
 8 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index f966a4fcb3..98556bcf22 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -135,6 +135,7 @@ typedef enum {
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index f378d29568..44381062e6 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -185,6 +185,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 1974bf1cae..90b3193bf3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -966,6 +966,10 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index e3a43aabb6..94691e849b 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -221,6 +221,10 @@ DEF(add_vec, 1, 2, 0, IMPLVEC)
 DEF(sub_vec, 1, 2, 0, IMPLVEC)
 DEF(mul_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_mul_vec))
 DEF(neg_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
+DEF(ssadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
+DEF(usadd_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
+DEF(sssub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
+DEF(ussub_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_sat_vec))
 
 DEF(and_vec, 1, 2, 0, IMPLVEC)
 DEF(or_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index ade692fdf5..c90f65a387 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -183,6 +183,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index c10d3d7b26..0a33f51065 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1678,10 +1678,22 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
-        { .fno = gen_helper_gvec_ssadd8, .vece = MO_8 },
-        { .fno = gen_helper_gvec_ssadd16, .vece = MO_16 },
-        { .fno = gen_helper_gvec_ssadd32, .vece = MO_32 },
-        { .fno = gen_helper_gvec_ssadd64, .vece = MO_64 }
+        { .fniv = tcg_gen_ssadd_vec,
+          .fno = gen_helper_gvec_ssadd8,
+          .opc = INDEX_op_ssadd_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_ssadd_vec,
+          .fno = gen_helper_gvec_ssadd16,
+          .opc = INDEX_op_ssadd_vec,
+          .vece = MO_16 },
+        { .fniv = tcg_gen_ssadd_vec,
+          .fno = gen_helper_gvec_ssadd32,
+          .opc = INDEX_op_ssadd_vec,
+          .vece = MO_32 },
+        { .fniv = tcg_gen_ssadd_vec,
+          .fno = gen_helper_gvec_ssadd64,
+          .opc = INDEX_op_ssadd_vec,
+          .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
@@ -1691,16 +1703,28 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
-        { .fno = gen_helper_gvec_sssub8, .vece = MO_8 },
-        { .fno = gen_helper_gvec_sssub16, .vece = MO_16 },
-        { .fno = gen_helper_gvec_sssub32, .vece = MO_32 },
-        { .fno = gen_helper_gvec_sssub64, .vece = MO_64 }
+        { .fniv = tcg_gen_sssub_vec,
+          .fno = gen_helper_gvec_sssub8,
+          .opc = INDEX_op_sssub_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_sssub_vec,
+          .fno = gen_helper_gvec_sssub16,
+          .opc = INDEX_op_sssub_vec,
+          .vece = MO_16 },
+        { .fniv = tcg_gen_sssub_vec,
+          .fno = gen_helper_gvec_sssub32,
+          .opc = INDEX_op_sssub_vec,
+          .vece = MO_32 },
+        { .fniv = tcg_gen_sssub_vec,
+          .fno = gen_helper_gvec_sssub64,
+          .opc = INDEX_op_sssub_vec,
+          .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
-static void tcg_gen_vec_usadd32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+static void tcg_gen_usadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 max = tcg_const_i32(-1);
     tcg_gen_add_i32(d, a, b);
@@ -1708,7 +1732,7 @@ static void tcg_gen_vec_usadd32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(max);
 }
 
-static void tcg_gen_vec_usadd32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 max = tcg_const_i64(-1);
     tcg_gen_add_i64(d, a, b);
@@ -1720,20 +1744,30 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
-        { .fno = gen_helper_gvec_usadd8, .vece = MO_8 },
-        { .fno = gen_helper_gvec_usadd16, .vece = MO_16 },
-        { .fni4 = tcg_gen_vec_usadd32_i32,
+        { .fniv = tcg_gen_usadd_vec,
+          .fno = gen_helper_gvec_usadd8,
+          .opc = INDEX_op_usadd_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_usadd_vec,
+          .fno = gen_helper_gvec_usadd16,
+          .opc = INDEX_op_usadd_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_usadd_i32,
+          .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd32,
+          .opc = INDEX_op_usadd_vec,
           .vece = MO_32 },
-        { .fni8 = tcg_gen_vec_usadd32_i64,
+        { .fni8 = tcg_gen_usadd_i64,
+          .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd64,
+          .opc = INDEX_op_usadd_vec,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
-static void tcg_gen_vec_ussub32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 min = tcg_const_i32(0);
     tcg_gen_sub_i32(d, a, b);
@@ -1741,7 +1775,7 @@ static void tcg_gen_vec_ussub32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(min);
 }
 
-static void tcg_gen_vec_ussub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 min = tcg_const_i64(0);
     tcg_gen_sub_i64(d, a, b);
@@ -1753,13 +1787,23 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
-        { .fno = gen_helper_gvec_ussub8, .vece = MO_8 },
-        { .fno = gen_helper_gvec_ussub16, .vece = MO_16 },
-        { .fni4 = tcg_gen_vec_ussub32_i32,
+        { .fniv = tcg_gen_ussub_vec,
+          .fno = gen_helper_gvec_ussub8,
+          .opc = INDEX_op_ussub_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_ussub_vec,
+          .fno = gen_helper_gvec_ussub16,
+          .opc = INDEX_op_ussub_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_ussub_i32,
+          .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub32,
+          .opc = INDEX_op_ussub_vec,
           .vece = MO_32 },
-        { .fni8 = tcg_gen_vec_ussub32_i64,
+        { .fni8 = tcg_gen_ussub_i64,
+          .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub64,
+          .opc = INDEX_op_ussub_vec,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index d77fdf7c1d..675aa09258 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -386,7 +386,8 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     }
 }
 
-void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
+                   TCGv_vec b, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
     TCGTemp *at = tcgv_vec_temp(a);
@@ -399,11 +400,36 @@ void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 
     tcg_debug_assert(at->base_type >= type);
     tcg_debug_assert(bt->base_type >= type);
-    can = tcg_can_emit_vec_op(INDEX_op_mul_vec, type, vece);
+    can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
-        vec_gen_3(INDEX_op_mul_vec, type, vece, ri, ai, bi);
+        vec_gen_3(opc, type, vece, ri, ai, bi);
     } else {
         tcg_debug_assert(can < 0);
-        tcg_expand_vec_op(INDEX_op_mul_vec, type, vece, ri, ai, bi);
+        tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
     }
 }
+
+void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_mul_vec);
+}
+
+void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_ssadd_vec);
+}
+
+void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_usadd_vec);
+}
+
+void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_sssub_vec);
+}
+
+void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_ussub_vec);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 963cb37892..f2cf60425b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1607,6 +1607,11 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return have_vec && TCG_TARGET_HAS_shv_vec;
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
+        return have_vec && TCG_TARGET_HAS_sat_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
-- 
2.17.2
