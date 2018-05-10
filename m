Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdJ-0005AG-7t
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdI-0000wc-CR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpdI-0000vB-68
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdG-0003b7-UG
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:16 +0100
Message-Id: <20180510174519.11264-19-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/21] target/arm: Implement vector shifted
 SCVF/UCVF for fp16
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

While we have some of the scalar paths for *CVF for fp16,
we failed to decode the fp16 version of these instructions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fa60cf908f..f4e2afa72c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7405,13 +7405,26 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
                                          int immh, int immb, int opcode,
                                          int rn, int rd)
 {
-    bool is_double = extract32(immh, 3, 1);
-    int size = is_double ? MO_64 : MO_32;
-    int elements;
+    int size, elements, fracbits;
     int immhb = immh << 3 | immb;
-    int fracbits = (is_double ? 128 : 64) - immhb;
 
-    if (!extract32(immh, 2, 2)) {
+    if (immh & 8) {
+        size = MO_64;
+        if (!is_scalar && !is_q) {
+            unallocated_encoding(s);
+            return;
+        }
+    } else if (immh & 4) {
+        size = MO_32;
+    } else if (immh & 2) {
+        size = MO_16;
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            unallocated_encoding(s);
+            return;
+        }
+    } else {
+        /* immh == 0 would be a failure of the decode logic */
+        g_assert(immh == 1);
         unallocated_encoding(s);
         return;
     }
@@ -7419,20 +7432,14 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
     if (is_scalar) {
         elements = 1;
     } else {
-        elements = is_double ? 2 : is_q ? 4 : 2;
-        if (is_double && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
+        elements = (8 << is_q) >> size;
     }
+    fracbits = (16 << size) - immhb;
 
     if (!fp_access_check(s)) {
         return;
     }
 
-    /* immh == 0 would be a failure of the decode logic */
-    g_assert(immh);
-
     handle_simd_intfp_conv(s, rd, rn, elements, !is_u, fracbits, size);
 }
 
-- 
2.17.0
