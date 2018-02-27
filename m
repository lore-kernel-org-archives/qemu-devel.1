Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgY3-0003WR-Sk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgXz-00011U-2i
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:07 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgXy-0000xe-P4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:48:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id k9so25158331wre.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:48:02 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:50 +0000
Message-Id: <20180227143852.11175-30-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 29/31] arm/translate-a64: add all FP16 ops
 in simd_scalar_pairwise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

I only needed to do a little light re-factoring to support the
half-precision helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 80 +++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7c2bc05b92..9d3a6ac49f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6416,24 +6416,30 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
     case 0xf: /* FMAXP */
     case 0x2c: /* FMINNMP */
     case 0x2f: /* FMINP */
-        /* FP op, size[0] is 32 or 64 bit */
+        /* FP op, size[0] is 32 or 64 bit*/
         if (!u) {
-            unallocated_encoding(s);
-            return;
+            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                unallocated_encoding(s);
+                return;
+            } else {
+                size = MO_16;
+            }
+        } else {
+            size = extract32(size, 0, 1) ? MO_64 : MO_32;
         }
+
         if (!fp_access_check(s)) {
             return;
         }
 
-        size = extract32(size, 0, 1) ? 3 : 2;
-        fpst = get_fpstatus_ptr(false);
+        fpst = get_fpstatus_ptr(size == MO_16);
         break;
     default:
         unallocated_encoding(s);
         return;
     }
 
-    if (size == 3) {
+    if (size == MO_64) {
         TCGv_i64 tcg_op1 = tcg_temp_new_i64();
         TCGv_i64 tcg_op2 = tcg_temp_new_i64();
         TCGv_i64 tcg_res = tcg_temp_new_i64();
@@ -6474,27 +6480,49 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         TCGv_i32 tcg_op2 = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
 
-        read_vec_element_i32(s, tcg_op1, rn, 0, MO_32);
-        read_vec_element_i32(s, tcg_op2, rn, 1, MO_32);
+        read_vec_element_i32(s, tcg_op1, rn, 0, size);
+        read_vec_element_i32(s, tcg_op2, rn, 1, size);
 
-        switch (opcode) {
-        case 0xc: /* FMAXNMP */
-            gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0xd: /* FADDP */
-            gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0xf: /* FMAXP */
-            gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x2c: /* FMINNMP */
-            gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        case 0x2f: /* FMINP */
-            gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
-            break;
-        default:
-            g_assert_not_reached();
+        if (size == MO_16) {
+            switch (opcode) {
+            case 0xc: /* FMAXNMP */
+                gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xd: /* FADDP */
+                gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xf: /* FMAXP */
+                gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x2c: /* FMINNMP */
+                gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x2f: /* FMINP */
+                gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            switch (opcode) {
+            case 0xc: /* FMAXNMP */
+                gen_helper_vfp_maxnums(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xd: /* FADDP */
+                gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0xf: /* FMAXP */
+                gen_helper_vfp_maxs(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x2c: /* FMINNMP */
+                gen_helper_vfp_minnums(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            case 0x2f: /* FMINP */
+                gen_helper_vfp_mins(tcg_res, tcg_op1, tcg_op2, fpst);
+                break;
+            default:
+                g_assert_not_reached();
+            }
         }
 
         write_fp_sreg(s, rd, tcg_res);
-- 
2.15.1
