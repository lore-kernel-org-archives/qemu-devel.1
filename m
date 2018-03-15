Received: from eggs.gnu.org ([2001:4830:134:3::10]:59741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqK-0003PO-3M
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqI-00051L-UP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewWqI-00050s-P2
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:06 -0400
Received: by mail-pf0-x244.google.com with SMTP id 68so3100101pfx.3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:39:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 01:38:53 +0800
Message-Id: <20180315173855.22456-2-richard.henderson@linaro.org>
In-Reply-To: <20180315173855.22456-1-richard.henderson@linaro.org>
References: <20180315173855.22456-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 1/3] tcg: Improve tcg_gen_muli_i32/i64
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

Convert multiplication by power of two to left shift.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
