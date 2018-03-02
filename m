Received: from eggs.gnu.org ([2001:4830:134:3::10]:43527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWk-00033O-C3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWj-0004ye-6b
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:02 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWi-0004wk-VU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:01 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWh-0001Oo-OW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:27 +0000
Message-Id: <20180302110640.28004-27-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/39] target/arm: Refactor disas_simd_indexed
 size checks
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

The integer size check was already outside of the opcode switch;
move the floating-point size check outside as well.  Unify the
size vs index adjustment between fp and integer paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180228193125.20577-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 65 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fc928b61f6..cbb4510e3a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11820,10 +11820,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
     case 0x19: /* FMULX */
-        if (size == 1) {
-            unallocated_encoding(s);
-            return;
-        }
         is_fp = true;
         break;
     default:
@@ -11834,45 +11830,48 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     if (is_fp) {
         /* convert insn encoded size to TCGMemOp size */
         switch (size) {
-        case 2: /* single precision */
-            size = MO_32;
-            index = h << 1 | l;
-            rm |= (m << 4);
-            break;
-        case 3: /* double precision */
-            size = MO_64;
-            if (l || !is_q) {
+        case 0: /* half-precision */
+            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
                 unallocated_encoding(s);
                 return;
             }
-            index = h;
-            rm |= (m << 4);
-            break;
-        case 0: /* half precision */
             size = MO_16;
-            index = h << 2 | l << 1 | m;
-            is_fp16 = true;
-            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
-                break;
-            }
-            /* fallthru */
-        default: /* unallocated */
-            unallocated_encoding(s);
-            return;
-        }
-    } else {
-        switch (size) {
-        case 1:
-            index = h << 2 | l << 1 | m;
             break;
-        case 2:
-            index = h << 1 | l;
-            rm |= (m << 4);
+        case MO_32: /* single precision */
+        case MO_64: /* double precision */
             break;
         default:
             unallocated_encoding(s);
             return;
         }
+    } else {
+        switch (size) {
+        case MO_8:
+        case MO_64:
+            unallocated_encoding(s);
+            return;
+        }
+    }
+
+    /* Given TCGMemOp size, adjust register and indexing.  */
+    switch (size) {
+    case MO_16:
+        index = h << 2 | l << 1 | m;
+        break;
+    case MO_32:
+        index = h << 1 | l;
+        rm |= m << 4;
+        break;
+    case MO_64:
+        if (l || !is_q) {
+            unallocated_encoding(s);
+            return;
+        }
+        index = h;
+        rm |= m << 4;
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     if (!fp_access_check(s)) {
-- 
2.16.2
