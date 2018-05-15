Received: from eggs.gnu.org ([2001:4830:134:3::10]:39597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabm-0003pt-Bl
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabi-0002qA-En
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabi-0002pO-8b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabh-0001Q9-Bp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:58 +0100
Message-Id: <20180515140707.15957-8-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/16] target/arm: Implement FCVT (scalar,
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

From: Richard Henderson <richard.henderson@linaro.org>

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 93fb15d185..d0ed125442 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5697,8 +5697,21 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
     bool sf = extract32(insn, 31, 1);
     bool itof;
 
-    if (sbit || (type > 1)
-        || (!sf && scale < 32)) {
+    if (sbit || (!sf && scale < 32)) {
+        unallocated_encoding(s);
+        return;
+    }
+
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
         unallocated_encoding(s);
         return;
     }
-- 
2.17.0
