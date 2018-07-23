Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKu-00047b-RG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKr-0005TC-Ju
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:40 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:31 -0500
Message-Id: <20180723201748.25573-83-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 82/99] target/arm: Implement FCMP for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

These where missed out from the rest of the half-precision work.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180512003217.9105-9-richard.henderson@linaro.org
[rth: Diagnose lack of FP16 before fp_access_check]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

(cherry picked from commit 7a1929256ea1a03df12625e75ed571c60dca5bfb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper-a64.c    | 10 +++++
 target/arm/helper-a64.h    |  2 +
 target/arm/translate-a64.c | 88 ++++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index afb25ad20c..35df07adb9 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -85,6 +85,16 @@ static inline uint32_t float_rel_to_flags(int res)
     return flags;
 }
 
+uint64_t HELPER(vfp_cmph_a64)(float16 x, float16 y, void *fp_status)
+{
+    return float_rel_to_flags(float16_compare_quiet(x, y, fp_status));
+}
+
+uint64_t HELPER(vfp_cmpeh_a64)(float16 x, float16 y, void *fp_status)
+{
+    return float_rel_to_flags(float16_compare(x, y, fp_status));
+}
+
 uint64_t HELPER(vfp_cmps_a64)(float32 x, float32 y, void *fp_status)
 {
     return float_rel_to_flags(float32_compare_quiet(x, y, fp_status));
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index ef4ddfe9d8..5c0b9bd799 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -19,6 +19,8 @@
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
+DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
+DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
 DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, ptr)
 DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9880a5d047..05d51ecbdc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4469,14 +4469,14 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     }
 }
 
-static void handle_fp_compare(DisasContext *s, bool is_double,
+static void handle_fp_compare(DisasContext *s, int size,
                               unsigned int rn, unsigned int rm,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = get_fpstatus_ptr(false);
+    TCGv_ptr fpst = get_fpstatus_ptr(size == MO_16);
 
-    if (is_double) {
+    if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
 
         tcg_vn = read_fp_dreg(s, rn);
@@ -4493,19 +4493,35 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
         tcg_temp_free_i64(tcg_vn);
         tcg_temp_free_i64(tcg_vm);
     } else {
-        TCGv_i32 tcg_vn, tcg_vm;
+        TCGv_i32 tcg_vn = tcg_temp_new_i32();
+        TCGv_i32 tcg_vm = tcg_temp_new_i32();
 
-        tcg_vn = read_fp_sreg(s, rn);
+        read_vec_element_i32(s, tcg_vn, rn, 0, size);
         if (cmp_with_zero) {
-            tcg_vm = tcg_const_i32(0);
+            tcg_gen_movi_i32(tcg_vm, 0);
         } else {
-            tcg_vm = read_fp_sreg(s, rm);
+            read_vec_element_i32(s, tcg_vm, rm, 0, size);
         }
-        if (signal_all_nans) {
-            gen_helper_vfp_cmpes_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-        } else {
-            gen_helper_vfp_cmps_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+
+        switch (size) {
+        case MO_32:
+            if (signal_all_nans) {
+                gen_helper_vfp_cmpes_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            } else {
+                gen_helper_vfp_cmps_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            }
+            break;
+        case MO_16:
+            if (signal_all_nans) {
+                gen_helper_vfp_cmpeh_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            } else {
+                gen_helper_vfp_cmph_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            }
+            break;
+        default:
+            g_assert_not_reached();
         }
+
         tcg_temp_free_i32(tcg_vn);
         tcg_temp_free_i32(tcg_vm);
     }
@@ -4526,16 +4542,35 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
 static void disas_fp_compare(DisasContext *s, uint32_t insn)
 {
     unsigned int mos, type, rm, op, rn, opc, op2r;
+    int size;
 
     mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2); /* 0 = single, 1 = double */
+    type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     op = extract32(insn, 14, 2);
     rn = extract32(insn, 5, 5);
     opc = extract32(insn, 3, 2);
     op2r = extract32(insn, 0, 3);
 
-    if (mos || op || op2r || type > 1) {
+    if (mos || op || op2r) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (type) {
+    case 0:
+        size = MO_32;
+        break;
+    case 1:
+        size = MO_64;
+        break;
+    case 3:
+        size = MO_16;
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            break;
+        }
+        /* fallthru */
+    default:
         unallocated_encoding(s);
         return;
     }
@@ -4544,7 +4579,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
         return;
     }
 
-    handle_fp_compare(s, type, rn, rm, opc & 1, opc & 2);
+    handle_fp_compare(s, size, rn, rm, opc & 1, opc & 2);
 }
 
 /* Floating point conditional compare
@@ -4558,16 +4593,35 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
     unsigned int mos, type, rm, cond, rn, op, nzcv;
     TCGv_i64 tcg_flags;
     TCGLabel *label_continue = NULL;
+    int size;
 
     mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2); /* 0 = single, 1 = double */
+    type = extract32(insn, 22, 2);
     rm = extract32(insn, 16, 5);
     cond = extract32(insn, 12, 4);
     rn = extract32(insn, 5, 5);
     op = extract32(insn, 4, 1);
     nzcv = extract32(insn, 0, 4);
 
-    if (mos || type > 1) {
+    if (mos) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (type) {
+    case 0:
+        size = MO_32;
+        break;
+    case 1:
+        size = MO_64;
+        break;
+    case 3:
+        size = MO_16;
+        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            break;
+        }
+        /* fallthru */
+    default:
         unallocated_encoding(s);
         return;
     }
@@ -4588,7 +4642,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
         gen_set_label(label_match);
     }
 
-    handle_fp_compare(s, type, rn, rm, false, op);
+    handle_fp_compare(s, size, rn, rm, false, op);
 
     if (cond < 0x0e) {
         gen_set_label(label_continue);
-- 
2.17.1
