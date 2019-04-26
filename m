Received: from eggs.gnu.org ([209.51.188.92]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0008Pw-1R
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aM-0006K6-0w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aL-0006H6-QN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:29 -0400
Received: by mail-pg1-x536.google.com with SMTP id k19so1949076pgh.0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:09 -0700
Message-Id: <20190426172421.27133-4-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/15] tcg: Use deposit and extract2 in
 tcg_gen_shifti_i64
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
 tcg/tcg-op.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index deacc63e3b..fbc70649dd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1355,31 +1355,32 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
-    } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_new_i32();
-        t1 = tcg_temp_new_i32();
-        if (right) {
-            tcg_gen_shli_i32(t0, TCGV_HIGH(arg1), 32 - c);
-            if (arith) {
-                tcg_gen_sari_i32(t1, TCGV_HIGH(arg1), c);
-            } else {
-                tcg_gen_shri_i32(t1, TCGV_HIGH(arg1), c);
-            }
-            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t0);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), t1);
+    } else if (right) {
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_LOW(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
-            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-            /* Note: ret can be the same as arg1, so we use t1 */
-            tcg_gen_shli_i32(t1, TCGV_LOW(arg1), c);
-            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
-            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t0);
-            tcg_gen_mov_i32(TCGV_LOW(ret), t1);
+            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
+            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
+                                TCGV_HIGH(arg1), 32 - c, c);
         }
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        if (arith) {
+            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
+        } else {
+            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
+        }
+    } else {
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_HIGH(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
+        } else {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
+            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
+                                TCGV_HIGH(arg1), c, 32 - c);
+            tcg_temp_free_i32(t0);
+        }
+        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
 
-- 
2.17.1
