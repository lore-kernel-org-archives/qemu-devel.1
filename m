Received: from eggs.gnu.org ([2001:4830:134:3::10]:42909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKT-0003hn-CJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKQ-0005Fg-6G
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:13 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:20 -0500
Message-Id: <20180723201748.25573-72-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 71/99] target/arm: Implement vector shifted
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

While we have some of the scalar paths for *CVF for fp16,
we failed to decode the fp16 version of these instructions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a6117fae4576edfe7a5a5b802a742c33112c0993)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c91329249d..f0fa6045e4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7159,13 +7159,26 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
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
@@ -7173,20 +7186,14 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
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
2.17.1
