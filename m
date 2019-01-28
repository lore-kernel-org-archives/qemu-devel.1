Received: from eggs.gnu.org ([209.51.188.92]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jf-0004ne-1q
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9Jd-0007hv-5J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:18 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9Jc-0007hR-U9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:17 -0500
Received: by mail-pg1-x535.google.com with SMTP id v28so7381336pgk.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:47 -0800
Message-Id: <20190128155907.20607-4-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/23] tcg: Add write_aofs to GVecGen4
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

This allows writing 2 output, 3 input operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h |  2 ++
 tcg/tcg-op-gvec.c | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index d65b9d9d4c..2cb447112e 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -181,6 +181,8 @@ typedef struct {
     uint8_t vece;
     /* Prefer i64 to v64.  */
     bool prefer_i64;
+    /* Write aofs as a 2nd dest operand.  */
+    bool write_aofs;
 } GVecGen4;
 
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 81689d02f7..c10d3d7b26 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -665,7 +665,7 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
 
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                         uint32_t cofs, uint32_t oprsz,
+                         uint32_t cofs, uint32_t oprsz, bool write_aofs,
                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
@@ -680,6 +680,9 @@ static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         tcg_gen_ld_i32(t3, cpu_env, cofs + i);
         fni(t0, t1, t2, t3);
         tcg_gen_st_i32(t0, cpu_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_i32(t1, cpu_env, aofs + i);
+        }
     }
     tcg_temp_free_i32(t3);
     tcg_temp_free_i32(t2);
@@ -769,7 +772,7 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
 
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
 static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                         uint32_t cofs, uint32_t oprsz,
+                         uint32_t cofs, uint32_t oprsz, bool write_aofs,
                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -784,6 +787,9 @@ static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         tcg_gen_ld_i64(t3, cpu_env, cofs + i);
         fni(t0, t1, t2, t3);
         tcg_gen_st_i64(t0, cpu_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_i64(t1, cpu_env, aofs + i);
+        }
     }
     tcg_temp_free_i64(t3);
     tcg_temp_free_i64(t2);
@@ -880,7 +886,7 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 /* Expand OPSZ bytes worth of four-operand operations using host vectors.  */
 static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t cofs, uint32_t oprsz,
-                         uint32_t tysz, TCGType type,
+                         uint32_t tysz, TCGType type, bool write_aofs,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec,
                                      TCGv_vec, TCGv_vec))
 {
@@ -896,6 +902,9 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         tcg_gen_ld_vec(t3, cpu_env, cofs + i);
         fni(vece, t0, t1, t2, t3);
         tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        if (write_aofs) {
+            tcg_gen_st_vec(t1, cpu_env, aofs + i);
+        }
     }
     tcg_temp_free_vec(t3);
     tcg_temp_free_vec(t2);
@@ -1187,7 +1196,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,
-                     32, TCG_TYPE_V256, g->fniv);
+                     32, TCG_TYPE_V256, g->write_aofs, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1200,18 +1209,20 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
         /* fallthru */
     case TCG_TYPE_V128:
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
-                     16, TCG_TYPE_V128, g->fniv);
+                     16, TCG_TYPE_V128, g->write_aofs, g->fniv);
         break;
     case TCG_TYPE_V64:
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
-                     8, TCG_TYPE_V64, g->fniv);
+                     8, TCG_TYPE_V64, g->write_aofs, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_4_i64(dofs, aofs, bofs, cofs, oprsz, g->fni8);
+            expand_4_i64(dofs, aofs, bofs, cofs, oprsz,
+                         g->write_aofs, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_4_i32(dofs, aofs, bofs, cofs, oprsz, g->fni4);
+            expand_4_i32(dofs, aofs, bofs, cofs, oprsz,
+                         g->write_aofs, g->fni4);
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
-- 
2.17.2
