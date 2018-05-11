Received: from eggs.gnu.org ([2001:4830:134:3::10]:43879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3d-0002OY-6O
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3b-00065j-Ge
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:21 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGy3b-000659-9v
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:19 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so1996922pfi.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 19:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 19:44:51 -0700
Message-Id: <20180511024454.31679-9-richard.henderson@linaro.org>
In-Reply-To: <20180511024454.31679-1-richard.henderson@linaro.org>
References: <20180511024454.31679-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/11] target/arm: Implement FCMP for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

These where missed out from the rest of the half-precision work.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[rth: Diagnose lack of FP16 before fp_access_check]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  2 +
 target/arm/helper-a64.c    | 10 +++++
 target/arm/translate-a64.c | 88 ++++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index b8028ac98c..9d3a907049 100644
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
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 549ed3513e..4f8034c513 100644
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 523fcf4801..0ac586345e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4712,14 +4712,14 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
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
@@ -4736,19 +4736,35 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
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
@@ -4769,16 +4785,35 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
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
@@ -4787,7 +4822,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
         return;
     }
 
-    handle_fp_compare(s, type, rn, rm, opc & 1, opc & 2);
+    handle_fp_compare(s, size, rn, rm, opc & 1, opc & 2);
 }
 
 /* Floating point conditional compare
@@ -4801,16 +4836,35 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
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
@@ -4831,7 +4885,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
         gen_set_label(label_match);
     }
 
-    handle_fp_compare(s, type, rn, rm, false, op);
+    handle_fp_compare(s, size, rn, rm, false, op);
 
     if (cond < 0x0e) {
         gen_set_label(label_continue);
-- 
2.17.0
