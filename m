Received: from eggs.gnu.org ([2001:4830:134:3::10]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3W-00020K-Sw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3W-0005zI-3T
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:14 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGy3V-0005yr-UK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:14 -0400
Received: by mail-pl0-x241.google.com with SMTP id v24-v6so2422348plo.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 19:45:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 19:44:47 -0700
Message-Id: <20180511024454.31679-5-richard.henderson@linaro.org>
In-Reply-To: <20180511024454.31679-1-richard.henderson@linaro.org>
References: <20180511024454.31679-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/11] target/arm: Implement FCVT (scalar,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 14f35e878a..eb69a548e1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5491,6 +5491,20 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
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
@@ -5697,8 +5711,7 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
     bool sf = extract32(insn, 31, 1);
     bool itof;
 
-    if (sbit || (type > 1)
-        || (!sf && scale < 32)) {
+    if (sbit || (!sf && scale < 32)) {
         unallocated_encoding(s);
         return;
     }
-- 
2.17.0
