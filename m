Received: from eggs.gnu.org ([209.51.188.92]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWW-0008Og-P6
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWV-0007mj-LP
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWV-0007kM-FN
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id bf11so3528508plb.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:09 -1000
Message-Id: <20190420073442.7488-6-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/38] tcg: Allow add_vec, sub_vec, neg_vec,
 not_vec to be expanded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 27f65600c3..cfb18682b1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -226,16 +226,6 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType low_type)
     vec_gen_3(INDEX_op_st_vec, low_type, 0, ri, bi, o);
 }
 
-void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-{
-    vec_gen_op3(INDEX_op_add_vec, vece, r, a, b);
-}
-
-void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-{
-    vec_gen_op3(INDEX_op_sub_vec, vece, r, a, b);
-}
-
 void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     vec_gen_op3(INDEX_op_and_vec, 0, r, a, b);
@@ -296,11 +286,30 @@ void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     tcg_gen_not_vec(0, r, r);
 }
 
+static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGType type = rt->base_type;
+    int can;
+
+    tcg_debug_assert(at->base_type >= type);
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_2(opc, type, vece, ri, ai);
+    } else if (can < 0) {
+        tcg_expand_vec_op(opc, type, vece, ri, ai);
+    } else {
+        return false;
+    }
+    return true;
+}
+
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    if (TCG_TARGET_HAS_not_vec) {
-        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
-    } else {
+    if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
         TCGv_vec t = tcg_const_ones_vec_matching(r);
         tcg_gen_xor_vec(0, r, a, t);
         tcg_temp_free_vec(t);
@@ -309,9 +318,7 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    if (TCG_TARGET_HAS_neg_vec) {
-        vec_gen_op2(INDEX_op_neg_vec, vece, r, a);
-    } else {
+    if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)) {
         TCGv_vec t = tcg_const_zeros_vec_matching(r);
         tcg_gen_sub_vec(vece, r, t, a);
         tcg_temp_free_vec(t);
@@ -409,6 +416,16 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
     }
 }
 
+void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_add_vec);
+}
+
+void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_sub_vec);
+}
+
 void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_mul_vec);
-- 
2.17.1
