Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdJ-0005Au-UI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdI-0000xH-RD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpdI-0000wG-JR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdH-0003ba-KJ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:17 +0100
Message-Id: <20180510174519.11264-20-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/21] target/arm: Implement vector shifted FCVT
 for fp16
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

While we have some of the scalar paths for FCVT for fp16,
we failed to decode the fp16 version of these instructions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 65 +++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f4e2afa72c..317f2773b4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7448,19 +7448,28 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
                                          bool is_q, bool is_u,
                                          int immh, int immb, int rn, int rd)
 {
-    bool is_double = extract32(immh, 3, 1);
     int immhb = immh << 3 | immb;
-    int fracbits = (is_double ? 128 : 64) - immhb;
-    int pass;
+    int pass, size, fracbits;
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_rmode, tcg_shift;
 
-    if (!extract32(immh, 2, 2)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!is_scalar && !is_q && is_double) {
+    if (immh & 0x8) {
+        size = MO_64;
+        if (!is_scalar && !is_q) {
+            unallocated_encoding(s);
+            return;
+        }
+    } else if (immh & 0x4) {
+        size = MO_32;
+    } else if (immh & 0x2) {
+        size = MO_16;
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            unallocated_encoding(s);
+            return;
+        }
+    } else {
+        /* Should have split out AdvSIMD modified immediate earlier.  */
+        assert(immh == 1);
         unallocated_encoding(s);
         return;
     }
@@ -7472,11 +7481,12 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     assert(!(is_scalar && is_q));
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
-    tcg_fpstatus = get_fpstatus_ptr(false);
+    tcg_fpstatus = get_fpstatus_ptr(size == MO_16);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
+    fracbits = (16 << size) - immhb;
     tcg_shift = tcg_const_i32(fracbits);
 
-    if (is_double) {
+    if (size == MO_64) {
         int maxpass = is_scalar ? 1 : 2;
 
         for (pass = 0; pass < maxpass; pass++) {
@@ -7493,20 +7503,37 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
         }
         clear_vec_high(s, is_q, rd);
     } else {
-        int maxpass = is_scalar ? 1 : is_q ? 4 : 2;
+        void (*fn)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+        int maxpass = is_scalar ? 1 : ((8 << is_q) >> size);
+
+        switch (size) {
+        case MO_16:
+            if (is_u) {
+                fn = gen_helper_vfp_toulh;
+            } else {
+                fn = gen_helper_vfp_toslh;
+            }
+            break;
+        case MO_32:
+            if (is_u) {
+                fn = gen_helper_vfp_touls;
+            } else {
+                fn = gen_helper_vfp_tosls;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
         for (pass = 0; pass < maxpass; pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
 
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
-            if (is_u) {
-                gen_helper_vfp_touls(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
-            } else {
-                gen_helper_vfp_tosls(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
-            }
+            read_vec_element_i32(s, tcg_op, rn, pass, size);
+            fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_op);
             } else {
-                write_vec_element_i32(s, tcg_op, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_op, rd, pass, size);
             }
             tcg_temp_free_i32(tcg_op);
         }
-- 
2.17.0
