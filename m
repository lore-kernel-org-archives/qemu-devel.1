Received: from eggs.gnu.org ([2001:4830:134:3::10]:58575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02Z-0000ap-DF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02X-0007pA-Gt
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:15:59 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02X-0007oK-BS
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:15:57 -0400
Received: by mail-pf0-x244.google.com with SMTP id b26so199724pfi.10
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:15:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:39 -0700
Message-Id: <20180502221552.3873-2-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/14] target/arm: Implement vector shifted
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org

While we have some of the scalar paths for *CVF for fp16,
we failed to decode the fp16 version of these instructions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v2: Use parens with (x << y) >> z.
---
 target/arm/translate-a64.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bff4e13bf6..68ca445691 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7165,13 +7165,26 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
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
@@ -7179,20 +7192,14 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
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
2.14.3
