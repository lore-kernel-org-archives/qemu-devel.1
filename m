Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1L-000569-Db
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1K-0003Hc-FU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:43 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebI1K-0003HQ-9H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:42 -0500
Received: by mail-pg0-x241.google.com with SMTP id i196so8856536pgd.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:34:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:33:49 -0800
Message-Id: <20180116033404.31532-12-richard.henderson@linaro.org>
In-Reply-To: <20180116033404.31532-1-richard.henderson@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v9 11/26] tcg: Loosen vec_gen_op* typecheck
 rules
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

For ARM SVE with VQ=3, we want to be able to dup a scalar
into a v256, use that, and then perform a second operation
with the v256 punned to a v128.

Allow operands to a vector operation be wider than necessary
for the output.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index a73d094ddb..ad9a45b653 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -78,7 +78,7 @@ static void vec_gen_op2(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
     TCGTemp *at = tcgv_vec_temp(a);
     TCGType type = rt->base_type;
 
-    tcg_debug_assert(at->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
     vec_gen_2(opc, type, vece, temp_arg(rt), temp_arg(at));
 }
 
@@ -90,8 +90,8 @@ static void vec_gen_op3(TCGOpcode opc, unsigned vece,
     TCGTemp *bt = tcgv_vec_temp(b);
     TCGType type = rt->base_type;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
 }
 
@@ -257,14 +257,14 @@ void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
 
     if (TCG_TARGET_REG_BITS == 64) {
         TCGArg ai = tcgv_i64_arg(a);
-        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
+        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
     } else if (vece == MO_64) {
         TCGArg al = tcgv_i32_arg(TCGV_LOW(a));
         TCGArg ah = tcgv_i32_arg(TCGV_HIGH(a));
         vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
     } else {
         TCGArg ai = tcgv_i32_arg(TCGV_LOW(a));
-        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
+        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
     }
 }
 
@@ -493,8 +493,8 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     TCGType type = rt->base_type;
     int can;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
     if (can > 0) {
         vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
@@ -515,8 +515,8 @@ void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     TCGType type = rt->base_type;
     int can;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     can = tcg_can_emit_vec_op(INDEX_op_mul_vec, type, vece);
     if (can > 0) {
         vec_gen_3(INDEX_op_mul_vec, type, vece, ri, ai, bi);
-- 
2.14.3
