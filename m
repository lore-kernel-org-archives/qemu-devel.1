Received: from eggs.gnu.org ([2001:4830:134:3::10]:58837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02i-0000kg-GG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02f-0007v6-6e
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:08 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02f-0007uf-04
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:05 -0400
Received: by mail-pf0-x242.google.com with SMTP id b26so199950pfi.10
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:45 -0700
Message-Id: <20180502221552.3873-8-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/14] target/arm: Implement FCVT (scalar,
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d794744aec..e19d97e8f1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5460,8 +5460,7 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
     bool sf = extract32(insn, 31, 1);
     bool itof;
 
-    if (sbit || (type > 1)
-        || (!sf && scale < 32)) {
+    if (sbit || (!sf && scale < 32)) {
         unallocated_encoding(s);
         return;
     }
@@ -5480,6 +5479,20 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
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
