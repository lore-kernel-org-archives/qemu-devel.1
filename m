Received: from eggs.gnu.org ([209.51.188.92]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012q-IL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000nG-FA
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0000Px-7j
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id w23so3539961ply.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:40 -1000
Message-Id: <20190420073442.7488-37-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 36/38] tcg: Expand vector minmax using
 cmp+cmpsel
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
 tcg/tcg-op-gvec.c |  8 ++++++++
 tcg/tcg-op-vec.c  | 19 +++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index e7029d26f4..dddb00719a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -99,6 +99,14 @@ static bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_cmpsel_vec:
             /* Fallback expansion uses only required logial ops.  */
             continue;
+        case INDEX_op_smin_vec:
+        case INDEX_op_smax_vec:
+        case INDEX_op_umin_vec:
+        case INDEX_op_umax_vec:
+            if (tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece)) {
+                continue;
+            }
+            break;
         default:
             break;
         }
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 5868a51270..43abeb0674 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -520,24 +520,35 @@ void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_op3_nofail(vece, r, a, b, INDEX_op_ussub_vec);
 }
 
+static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
+                      TCGv_vec b, TCGOpcode opc, TCGCond cond)
+{
+    if (!do_op3(vece, r, a, b, opc)) {
+        TCGv_vec t = tcg_temp_new_vec_matching(r);
+        tcg_gen_cmp_vec(cond, vece, t, a, b);
+        tcg_gen_cmpsel_vec(vece, r, t, a, b);
+        tcg_temp_free_vec(t);
+    }
+}
+
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smin_vec, TCG_COND_GT);
 }
 
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umin_vec, TCG_COND_LTU);
 }
 
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smax_vec, TCG_COND_GT);
 }
 
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umax_vec, TCG_COND_GTU);
 }
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-- 
2.17.1
