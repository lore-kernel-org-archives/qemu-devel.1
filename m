Received: from eggs.gnu.org ([209.51.188.92]:49468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDH-0006m5-G3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uDG-0003V4-IX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:35 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1uDG-0003TJ-BQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:41:34 -0500
Received: by mail-pg1-x544.google.com with SMTP id u9so11414140pgo.7
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:41:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 06:41:21 -0800
Message-Id: <20190307144126.31847-5-richard.henderson@linaro.org>
In-Reply-To: <20190307144126.31847-1-richard.henderson@linaro.org>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/9] tcg: Use extract2 in tcg_gen_deposit_{i32,
 i64}
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
 tcg/tcg-op.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34e0dbc6e0..caee80235e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -614,6 +614,18 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     mask = (1u << len) - 1;
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
     if (ofs + len < 32) {
         tcg_gen_andi_i32(t1, arg2, mask);
         tcg_gen_shli_i32(t1, t1, ofs);
@@ -622,7 +634,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     }
     tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i32(ret, ret, t1);
-
+ done:
     tcg_temp_free_i32(t1);
 }
 
@@ -2027,6 +2039,18 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     mask = (1ull << len) - 1;
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
     if (ofs + len < 64) {
         tcg_gen_andi_i64(t1, arg2, mask);
         tcg_gen_shli_i64(t1, t1, ofs);
@@ -2035,7 +2059,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     }
     tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i64(ret, ret, t1);
-
+ done:
     tcg_temp_free_i64(t1);
 }
 
-- 
2.17.2
