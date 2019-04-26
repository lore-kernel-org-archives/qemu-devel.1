Received: from eggs.gnu.org ([209.51.188.92]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0008QG-CE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aM-0006KL-Dd
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aM-0006I7-7S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d31so1929522pgl.7
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:10 -0700
Message-Id: <20190426172421.27133-5-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/15] tcg: Use extract2 in tcg_gen_deposit_{i32, i64}
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
 tcg/tcg-op.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fbc70649dd..a00d1df37e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -611,9 +611,22 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
 
-    mask = (1u << len) - 1;
     t1 = tcg_temp_new_i32();
 
+    if (TCG_TARGET_HAS_extract2_i32) {
+        if (ofs + len == 32) {
+            tcg_gen_shli_i32(t1, arg1, len);
+            tcg_gen_extract2_i32(ret, t1, arg2, len);
+            goto done;
+        }
+        if (ofs == 0) {
+            tcg_gen_extract2_i32(ret, arg1, arg2, len);
+            tcg_gen_rotli_i32(ret, ret, len);
+            goto done;
+        }
+    }
+
+    mask = (1u << len) - 1;
     if (ofs + len < 32) {
         tcg_gen_andi_i32(t1, arg2, mask);
         tcg_gen_shli_i32(t1, t1, ofs);
@@ -622,7 +635,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     }
     tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i32(ret, ret, t1);
-
+ done:
     tcg_temp_free_i32(t1);
 }
 
@@ -2024,9 +2037,22 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         }
     }
 
-    mask = (1ull << len) - 1;
     t1 = tcg_temp_new_i64();
 
+    if (TCG_TARGET_HAS_extract2_i64) {
+        if (ofs + len == 64) {
+            tcg_gen_shli_i64(t1, arg1, len);
+            tcg_gen_extract2_i64(ret, t1, arg2, len);
+            goto done;
+        }
+        if (ofs == 0) {
+            tcg_gen_extract2_i64(ret, arg1, arg2, len);
+            tcg_gen_rotli_i64(ret, ret, len);
+            goto done;
+        }
+    }
+
+    mask = (1ull << len) - 1;
     if (ofs + len < 64) {
         tcg_gen_andi_i64(t1, arg2, mask);
         tcg_gen_shli_i64(t1, t1, ofs);
@@ -2035,7 +2061,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     }
     tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i64(ret, ret, t1);
-
+ done:
     tcg_temp_free_i64(t1);
 }
 
-- 
2.17.1
