Received: from eggs.gnu.org ([209.51.188.92]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOh-0005s5-Ih
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOf-0004zw-0G
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:59 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOe-0004Rn-Ju
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:56 -0500
Received: by mail-pf1-x443.google.com with SMTP id y126so337556pfb.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:41 -0800
Message-Id: <20190211235258.542-12-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 11/28] target/arm: Implement ADDG,
 SUBG instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Shift offset in translate; use extract32.
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/internals.h     |  4 +++
 target/arm/mte_helper.c    | 32 +++++++++++++++++
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++------------
 4 files changed, 86 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 0f6e78c77e..6ad23bf9ee 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -106,3 +106,5 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(mte_check1, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(mte_check2, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
+DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fbfa770c23..8d1a81df8c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1008,4 +1008,8 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
  */
 #define GMID_EL1_BS  6
 
+/* We associate one allocation tag per 16 bytes, the minimum.  */
+#define LOG2_TAG_GRANULE 4
+#define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
+
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index cd04e4954b..7aca5b074f 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -188,3 +188,35 @@ uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 
     return address_with_allocation_tag(rn, rtag);
 }
+
+uint64_t HELPER(addg)(CPUARMState *env, uint64_t ptr,
+                      uint32_t offset, uint32_t tag_offset)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int start_tag = allocation_tag_from_addr(ptr);
+        uint16_t exclude = extract32(env->cp15.gcr_el1, 0, 16);
+        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
+    }
+
+    return address_with_allocation_tag(ptr + offset, rtag);
+}
+
+uint64_t HELPER(subg)(CPUARMState *env, uint64_t ptr,
+                      uint32_t offset, uint32_t tag_offset)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int start_tag = allocation_tag_from_addr(ptr);
+        uint16_t exclude = extract32(env->cp15.gcr_el1, 0, 16);
+        rtag = choose_nonexcluded_tag(start_tag, tag_offset, exclude);
+    }
+
+    return address_with_allocation_tag(ptr - offset, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 141a03a88f..8e322bd6a0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3679,7 +3679,9 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
  *    sf: 0 -> 32bit, 1 -> 64bit
  *    op: 0 -> add  , 1 -> sub
  *     S: 1 -> set flags
- * shift: 00 -> LSL imm by 0, 01 -> LSL imm by 12
+ * shift: 00 -> LSL imm by 0,
+ *        01 -> LSL imm by 12
+ *        10 -> ADDG, SUBG
  */
 static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
 {
@@ -3690,10 +3692,10 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool is_64bit = extract32(insn, 31, 1);
+    bool is_tag = false;
 
     TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
     TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
-    TCGv_i64 tcg_result;
 
     switch (shift) {
     case 0x0:
@@ -3701,35 +3703,58 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     case 0x1:
         imm <<= 12;
         break;
+    case 0x2:
+        /* ADDG, SUBG */
+        if (!is_64bit || setflags || (imm & 0x30) ||
+            !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        is_tag = true;
+        break;
     default:
+    do_unallocated:
         unallocated_encoding(s);
         return;
     }
 
-    tcg_result = tcg_temp_new_i64();
-    if (!setflags) {
-        if (sub_op) {
-            tcg_gen_subi_i64(tcg_result, tcg_rn, imm);
-        } else {
-            tcg_gen_addi_i64(tcg_result, tcg_rn, imm);
-        }
-    } else {
-        TCGv_i64 tcg_imm = tcg_const_i64(imm);
-        if (sub_op) {
-            gen_sub_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        } else {
-            gen_add_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
-        }
-        tcg_temp_free_i64(tcg_imm);
-    }
+    if (is_tag) {
+        TCGv_i32 tag_offset = tcg_const_i32(imm & 15);
+        TCGv_i32 offset = tcg_const_i32((imm >> 6) << LOG2_TAG_GRANULE);
 
-    if (is_64bit) {
-        tcg_gen_mov_i64(tcg_rd, tcg_result);
+        if (sub_op) {
+            gen_helper_subg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+        } else {
+            gen_helper_addg(tcg_rd, cpu_env, tcg_rn, offset, tag_offset);
+        }
+        tcg_temp_free_i32(tag_offset);
+        tcg_temp_free_i32(offset);
     } else {
-        tcg_gen_ext32u_i64(tcg_rd, tcg_result);
-    }
+        TCGv_i64 tcg_result;
 
-    tcg_temp_free_i64(tcg_result);
+        if (!setflags) {
+            tcg_result = tcg_rd;
+            if (sub_op) {
+                tcg_gen_subi_i64(tcg_result, tcg_rn, imm);
+            } else {
+                tcg_gen_addi_i64(tcg_result, tcg_rn, imm);
+            }
+        } else {
+            TCGv_i64 tcg_imm = tcg_const_i64(imm);
+            tcg_result = new_tmp_a64(s);
+            if (sub_op) {
+                gen_sub_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
+            } else {
+                gen_add_CC(is_64bit, tcg_result, tcg_rn, tcg_imm);
+            }
+            tcg_temp_free_i64(tcg_imm);
+        }
+
+        if (is_64bit) {
+            tcg_gen_mov_i64(tcg_rd, tcg_result);
+        } else {
+            tcg_gen_ext32u_i64(tcg_rd, tcg_result);
+        }
+    }
 }
 
 /* The input should be a value in the bottom e bits (with higher
-- 
2.17.2
