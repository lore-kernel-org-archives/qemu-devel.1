Received: from eggs.gnu.org ([2001:4830:134:3::10]:36937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqHf-0001mx-Rl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqHc-0001GR-Lc
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:51 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqHc-0001Fo-G0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:09:48 -0500
Received: by mail-pl0-x243.google.com with SMTP id f8so7200420plk.11
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:09:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:09:17 -0800
Message-Id: <20180117160933.28086-6-richard.henderson@linaro.org>
In-Reply-To: <20180117160933.28086-1-richard.henderson@linaro.org>
References: <20180117160933.28086-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v10 05/21] tcg: Loosen vec_gen_op* typecheck
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
 tcg/tcg-op-vec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 5cfe4af6bd..97b437e41a 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -78,7 +78,8 @@ static void vec_gen_op2(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
     TCGTemp *at = tcgv_vec_temp(a);
     TCGType type = rt->base_type;
 
-    tcg_debug_assert(at->base_type == type);
+    /* Must enough inputs for the output.  */
+    tcg_debug_assert(at->base_type >= type);
     vec_gen_2(opc, type, vece, temp_arg(rt), temp_arg(at));
 }
 
@@ -90,8 +91,9 @@ static void vec_gen_op3(TCGOpcode opc, unsigned vece,
     TCGTemp *bt = tcgv_vec_temp(b);
     TCGType type = rt->base_type;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    /* Must enough inputs for the output.  */
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
 }
 
@@ -257,14 +259,14 @@ void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
 
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
 
-- 
2.14.3
