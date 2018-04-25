Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB99Y-00046l-2D
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB99U-0007Uw-Sg
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:24 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB99U-0007U9-Li
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id i194so12140107pgd.0
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:23:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 24 Apr 2018 15:22:58 -1000
Message-Id: <20180425012300.14698-8-richard.henderson@linaro.org>
In-Reply-To: <20180425012300.14698-1-richard.henderson@linaro.org>
References: <20180425012300.14698-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] target/arm: Implement FCVT (scalar,
 fixed-point) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4f6317aa0f..794ede7222 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5372,8 +5372,7 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
     bool sf = extract32(insn, 31, 1);
     bool itof;
 
-    if (sbit || (type > 1)
-        || (!sf && scale < 32)) {
+    if (sbit || (!sf && scale < 32)) {
         unallocated_encoding(s);
         return;
     }
@@ -5392,6 +5391,20 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
         return;
     }
 
+    switch (type) {
+    case 0: /* float32 */
+    case 1: /* float64 */
+        break;
+    case 3: /* float16 */
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            break;
+        }
+        /* fallthru */
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
     if (!fp_access_check(s)) {
         return;
     }
-- 
2.14.3
