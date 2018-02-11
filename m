Received: from eggs.gnu.org ([2001:4830:134:3::10]:48804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyPY-00058u-29
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyPS-0006YA-Mi
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:39:44 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekyPS-0006XH-Hd
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:39:38 -0500
Received: by mail-pl0-x242.google.com with SMTP id k8so4044676pli.8
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 12:39:38 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47])
	by smtp.gmail.com with ESMTPSA id 10sm2327640pfo.69.2018.02.11.12.39.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 11 Feb 2018 12:39:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 11 Feb 2018 12:39:34 -0800
Message-Id: <20180211203934.15546-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Improve tcg_gen_muli_i32/i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Convert multiplication by power of two to left shift.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3467787323..34b96d68f3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -277,9 +277,15 @@ void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
 
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    TCGv_i32 t0 = tcg_const_i32(arg2);
-    tcg_gen_mul_i32(ret, arg1, t0);
-    tcg_temp_free_i32(t0);
+    if (arg2 == 0) {
+        tcg_gen_movi_i32(ret, 0);
+    } else if (is_power_of_2(arg2)) {
+        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
+    } else {
+        TCGv_i32 t0 = tcg_const_i32(arg2);
+        tcg_gen_mul_i32(ret, arg1, t0);
+        tcg_temp_free_i32(t0);
+    }
 }
 
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -1430,9 +1436,15 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
 
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    TCGv_i64 t0 = tcg_const_i64(arg2);
-    tcg_gen_mul_i64(ret, arg1, t0);
-    tcg_temp_free_i64(t0);
+    if (arg2 == 0) {
+        tcg_gen_movi_i64(ret, 0);
+    } else if (is_power_of_2(arg2)) {
+        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
+    } else {
+        TCGv_i64 t0 = tcg_const_i64(arg2);
+        tcg_gen_mul_i64(ret, arg1, t0);
+        tcg_temp_free_i64(t0);
+    }
 }
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-- 
2.14.3
