Received: from eggs.gnu.org ([2001:4830:134:3::10]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKf-0003rc-H6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKd-0005LW-Tk
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:25 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:26 -0500
Message-Id: <20180723201748.25573-78-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 77/99] target/arm: Implement FCVT (scalar,
 integer) for fp16
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

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 564a0632504fad840491aa9a59453f4e64a316c4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper.c        | 38 ++++++++++++++-
 target/arm/helper.h        |  6 +++
 target/arm/translate-a64.c | 96 +++++++++++++++++++++++++++++++-------
 3 files changed, 122 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c07c1d7f48..1043d6ed32 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11416,8 +11416,12 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
 #undef VFP_CONV_FIX_A64
 
 /* Conversion to/from f16 can overflow to infinity before/after scaling.
- * Therefore we convert to f64 (which does not round), scale,
- * and then convert f64 to f16 (which may round).
+ * Therefore we convert to f64, scale, and then convert f64 to f16; or
+ * vice versa for conversion to integer.
+ *
+ * For 16- and 32-bit integers, the conversion to f64 never rounds.
+ * For 64-bit integers, any integer that would cause rounding will also
+ * overflow to f16 infinity, so there is no double rounding problem.
  */
 
 static float16 do_postscale_fp16(float64 f, int shift, float_status *fpst)
@@ -11435,6 +11439,16 @@ float16 HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
     return do_postscale_fp16(uint32_to_float64(x, fpst), shift, fpst);
 }
 
+float16 HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
+{
+    return do_postscale_fp16(int64_to_float64(x, fpst), shift, fpst);
+}
+
+float16 HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
+{
+    return do_postscale_fp16(uint64_to_float64(x, fpst), shift, fpst);
+}
+
 static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
 {
     if (unlikely(float16_is_any_nan(f))) {
@@ -11464,6 +11478,26 @@ uint32_t HELPER(vfp_touhh)(float16 x, uint32_t shift, void *fpst)
     return float64_to_uint16(do_prescale_fp16(x, shift, fpst), fpst);
 }
 
+uint32_t HELPER(vfp_toslh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_int32(do_prescale_fp16(x, shift, fpst), fpst);
+}
+
+uint32_t HELPER(vfp_toulh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_uint32(do_prescale_fp16(x, shift, fpst), fpst);
+}
+
+uint64_t HELPER(vfp_tosqh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_int64(do_prescale_fp16(x, shift, fpst), fpst);
+}
+
+uint64_t HELPER(vfp_touqh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_uint64(do_prescale_fp16(x, shift, fpst), fpst);
+}
+
 /* Set the current fp rounding mode and return the old one.
  * The argument is a softfloat float_round_ value.
  */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1969b37f2d..ce89968b2d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -151,6 +151,10 @@ DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
+DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
@@ -177,6 +181,8 @@ DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
 DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
+DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
 
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(set_neon_rmode, TCG_CALL_NO_RWG, i32, i32, env)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b05f9bfe91..33be611bdb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5268,11 +5268,11 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
                            bool itof, int rmode, int scale, int sf, int type)
 {
     bool is_signed = !(opcode & 1);
-    bool is_double = type;
     TCGv_ptr tcg_fpstatus;
-    TCGv_i32 tcg_shift;
+    TCGv_i32 tcg_shift, tcg_single;
+    TCGv_i64 tcg_double;
 
-    tcg_fpstatus = get_fpstatus_ptr(false);
+    tcg_fpstatus = get_fpstatus_ptr(type == 3);
 
     tcg_shift = tcg_const_i32(64 - scale);
 
@@ -5290,8 +5290,9 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
             tcg_int = tcg_extend;
         }
 
-        if (is_double) {
-            TCGv_i64 tcg_double = tcg_temp_new_i64();
+        switch (type) {
+        case 1: /* float64 */
+            tcg_double = tcg_temp_new_i64();
             if (is_signed) {
                 gen_helper_vfp_sqtod(tcg_double, tcg_int,
                                      tcg_shift, tcg_fpstatus);
@@ -5301,8 +5302,10 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
             }
             write_fp_dreg(s, rd, tcg_double);
             tcg_temp_free_i64(tcg_double);
-        } else {
-            TCGv_i32 tcg_single = tcg_temp_new_i32();
+            break;
+
+        case 0: /* float32 */
+            tcg_single = tcg_temp_new_i32();
             if (is_signed) {
                 gen_helper_vfp_sqtos(tcg_single, tcg_int,
                                      tcg_shift, tcg_fpstatus);
@@ -5312,6 +5315,23 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
             }
             write_fp_sreg(s, rd, tcg_single);
             tcg_temp_free_i32(tcg_single);
+            break;
+
+        case 3: /* float16 */
+            tcg_single = tcg_temp_new_i32();
+            if (is_signed) {
+                gen_helper_vfp_sqtoh(tcg_single, tcg_int,
+                                     tcg_shift, tcg_fpstatus);
+            } else {
+                gen_helper_vfp_uqtoh(tcg_single, tcg_int,
+                                     tcg_shift, tcg_fpstatus);
+            }
+            write_fp_sreg(s, rd, tcg_single);
+            tcg_temp_free_i32(tcg_single);
+            break;
+
+        default:
+            g_assert_not_reached();
         }
     } else {
         TCGv_i64 tcg_int = cpu_reg(s, rd);
@@ -5328,8 +5348,9 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
 
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
 
-        if (is_double) {
-            TCGv_i64 tcg_double = read_fp_dreg(s, rn);
+        switch (type) {
+        case 1: /* float64 */
+            tcg_double = read_fp_dreg(s, rn);
             if (is_signed) {
                 if (!sf) {
                     gen_helper_vfp_tosld(tcg_int, tcg_double,
@@ -5347,9 +5368,14 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
                                          tcg_shift, tcg_fpstatus);
                 }
             }
+            if (!sf) {
+                tcg_gen_ext32u_i64(tcg_int, tcg_int);
+            }
             tcg_temp_free_i64(tcg_double);
-        } else {
-            TCGv_i32 tcg_single = read_fp_sreg(s, rn);
+            break;
+
+        case 0: /* float32 */
+            tcg_single = read_fp_sreg(s, rn);
             if (sf) {
                 if (is_signed) {
                     gen_helper_vfp_tosqs(tcg_int, tcg_single,
@@ -5371,14 +5397,39 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
                 tcg_temp_free_i32(tcg_dest);
             }
             tcg_temp_free_i32(tcg_single);
+            break;
+
+        case 3: /* float16 */
+            tcg_single = read_fp_sreg(s, rn);
+            if (sf) {
+                if (is_signed) {
+                    gen_helper_vfp_tosqh(tcg_int, tcg_single,
+                                         tcg_shift, tcg_fpstatus);
+                } else {
+                    gen_helper_vfp_touqh(tcg_int, tcg_single,
+                                         tcg_shift, tcg_fpstatus);
+                }
+            } else {
+                TCGv_i32 tcg_dest = tcg_temp_new_i32();
+                if (is_signed) {
+                    gen_helper_vfp_toslh(tcg_dest, tcg_single,
+                                         tcg_shift, tcg_fpstatus);
+                } else {
+                    gen_helper_vfp_toulh(tcg_dest, tcg_single,
+                                         tcg_shift, tcg_fpstatus);
+                }
+                tcg_gen_extu_i32_i64(tcg_int, tcg_dest);
+                tcg_temp_free_i32(tcg_dest);
+            }
+            tcg_temp_free_i32(tcg_single);
+            break;
+
+        default:
+            g_assert_not_reached();
         }
 
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
         tcg_temp_free_i32(tcg_rmode);
-
-        if (!sf) {
-            tcg_gen_ext32u_i64(tcg_int, tcg_int);
-        }
     }
 
     tcg_temp_free_ptr(tcg_fpstatus);
@@ -5548,7 +5599,20 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         /* actual FP conversions */
         bool itof = extract32(opcode, 1, 1);
 
-        if (type > 1 || (rmode != 0 && opcode > 1)) {
+        if (rmode != 0 && opcode > 1) {
+            unallocated_encoding(s);
+            return;
+        }
+        switch (type) {
+        case 0: /* float32 */
+        case 1: /* float64 */
+            break;
+        case 3: /* float16 */
+            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                break;
+            }
+            /* fallthru */
+        default:
             unallocated_encoding(s);
             return;
         }
-- 
2.17.1
