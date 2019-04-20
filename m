Received: from eggs.gnu.org ([209.51.188.92]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXX-00011Q-8W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXV-0000mF-V1
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXU-0000Mw-AD
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so3539289plb.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:39 -1000
Message-Id: <20190420073442.7488-36-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 35/38] tcg: Introduce do_op3_nofail for vector
 expansion
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

This makes do_op3 match do_op2 in allowing for failure,
and thus fall back expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 7d8f7b490a..5868a51270 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -450,7 +450,7 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     }
 }
 
-static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
+static bool do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
                    TCGv_vec b, TCGOpcode opc)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
@@ -468,82 +468,91 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_3(opc, type, vece, ri, ai, bi);
-    } else {
+    } else if (can < 0) {
         const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
-        tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
         tcg_swap_vecop_list(hold_list);
+    } else {
+        return false;
     }
+    return true;
+}
+
+static void do_op3_nofail(unsigned vece, TCGv_vec r, TCGv_vec a,
+                          TCGv_vec b, TCGOpcode opc)
+{
+    bool ok = do_op3(vece, r, a, b, opc);
+    tcg_debug_assert(ok);
 }
 
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_add_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_add_vec);
 }
 
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sub_vec);
 }
 
 void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_mul_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_mul_vec);
 }
 
 void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_ssadd_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_ssadd_vec);
 }
 
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_usadd_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_usadd_vec);
 }
 
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sssub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sssub_vec);
 }
 
 void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_ussub_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_ussub_vec);
 }
 
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_smin_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_smin_vec);
 }
 
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_umin_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_umin_vec);
 }
 
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_smax_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_smax_vec);
 }
 
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_umax_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_umax_vec);
 }
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_shlv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_shlv_vec);
 }
 
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_shrv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_shrv_vec);
 }
 
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3(vece, r, a, b, INDEX_op_sarv_vec);
+    do_op3_nofail(vece, r, a, b, INDEX_op_sarv_vec);
 }
 
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
@@ -579,7 +588,7 @@ static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
         } else {
             tcg_gen_dup_i32_vec(vece, vec_s, s);
         }
-        do_op3(vece, r, a, vec_s, opc_v);
+        do_op3_nofail(vece, r, a, vec_s, opc_v);
         tcg_temp_free_vec(vec_s);
     }
     tcg_swap_vecop_list(hold_list);
-- 
2.17.1
