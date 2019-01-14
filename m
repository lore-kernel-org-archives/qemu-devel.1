Received: from eggs.gnu.org ([209.51.188.92]:37078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnO-0005ml-95
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnN-000111-6D
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:06 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnN-00010i-1F
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:05 -0500
Received: by mail-pf1-x441.google.com with SMTP id w73so9535309pfk.10
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:15 +1100
Message-Id: <20190114011122.5995-11-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/17] target/arm: Implement LDG, STG,
 ST2G instructions
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |   3 ++
 target/arm/mte_helper.c    |  53 +++++++++++++++++++
 target/arm/translate-a64.c | 106 +++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index ef340cb6f9..ff37c8975a 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -108,3 +108,6 @@ DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(ldg, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(stg, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(st2g, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 2f6ac45150..06fd9c18f9 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -31,6 +31,12 @@ static int get_allocation_tag(CPUARMState *env, uint64_t ptr)
     return -1;
 }
 
+static bool set_allocation_tag(CPUARMState *env, uint64_t ptr, int tag)
+{
+    /* Tag storage not implemented.  */
+    return false;
+}
+
 static int allocation_tag_from_addr(uint64_t ptr)
 {
     return (extract64(ptr, 56, 4) + extract64(ptr, 55, 1)) & 15;
@@ -203,3 +209,50 @@ uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
     int tag = allocation_tag_from_addr(ptr);
     return mask | (1ULL << tag);
 }
+
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        rtag = get_allocation_tag(env, ptr);
+        if (rtag < 0) {
+            rtag = 0;
+        }
+    }
+    return address_with_allocation_tag(ptr, rtag);
+}
+
+uint64_t HELPER(stg)(CPUARMState *env, uint64_t ptr)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int tag = allocation_tag_from_addr(ptr);
+        set_allocation_tag(env, ptr, tag);
+    }
+
+    /* Clean the pointer for use by stgz.  */
+    /* ??? Do we need a more precise TBI here?  */
+    return sextract64(ptr, 0, 55);
+}
+
+uint64_t HELPER(st2g)(CPUARMState *env, uint64_t ptr)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        int tag = allocation_tag_from_addr(ptr);
+        if (set_allocation_tag(env, ptr, tag)) {
+            set_allocation_tag(env, ptr + (1 << LOG2_TAG_GRANULE), tag);
+        }
+    }
+
+    /* Clean the pointer for use by stgz.  */
+    /* ??? Do we need a more precise TBI here?  */
+    return sextract64(ptr, 0, 55);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 98ff60c161..60865945e4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3583,6 +3583,109 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Load/Store memory tags
+ *
+ *  31 30 29         24     22  21     12    10      5      0
+ * +-----+-------------+-----+---+------+-----+------+------+
+ * | 1 1 | 0 1 1 0 0 1 | op1 | 1 | imm9 | op2 |  Rn  |  Rt  |
+ * +-----+-------------+-----+---+------+-----+------+------+
+ */
+static void disas_ldst_tag(DisasContext *s, uint32_t insn)
+{
+    int rt = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
+    int op2 = extract32(insn, 10, 3);
+    int op1 = extract32(insn, 22, 2);
+    bool is_load = false, is_pair = false, is_zero = false;
+    int index = 0;
+    TCGv_i64 dirty_addr, clean_addr;
+
+    if ((insn & 0xff200000) != 0xd9200000
+        || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+        goto do_unallocated;
+    }
+
+    switch (op1) {
+    case 0: /* STG */
+        if (op2 != 0) {
+            /* STG */
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 1:
+        if (op2 != 0) {
+            /* STZG */
+            is_zero = true;
+            index = op2 - 2;
+        } else {
+            /* LDG */
+            is_load = true;
+        }
+        break;
+    case 2:
+        if (op2 != 0) {
+            /* ST2G */
+            is_pair = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 3:
+        if (op2 != 0) {
+            /* STZ2G */
+            is_pair = is_zero = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+
+    default:
+    do_unallocated:
+        unallocated_encoding(s);
+        return;
+    }
+
+    dirty_addr = read_cpu_reg_sp(s, rn, true);
+    if (index <= 0) {
+        /* pre-index or signed offset */
+        tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    }
+
+    clean_addr = tcg_temp_new_i64();
+    if (is_load) {
+        gen_helper_ldg(cpu_reg(s, rt), cpu_env, dirty_addr);
+    } else if (is_pair) {
+        gen_helper_st2g(clean_addr, cpu_env, dirty_addr);
+    } else {
+        gen_helper_stg(clean_addr, cpu_env, dirty_addr);
+    }
+
+    if (is_zero) {
+        TCGv_i64 tcg_zero = tcg_const_i64(0);
+        int mem_index = get_mem_index(s);
+        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
+
+        for (i = 0; i < n; i += 8) {
+            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_Q);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+        }
+        tcg_temp_free_i64(tcg_zero);
+    }
+    tcg_temp_free_i64(clean_addr);
+
+    if (index != 0) {
+        /* pre-index or post-index */
+        if (index > 0) {
+            /* post-index */
+            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+        }
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
+    }
+}
+
 /* Loads and stores */
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
@@ -3607,6 +3710,9 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     case 0x0d: /* AdvSIMD load/store single structure */
         disas_ldst_single_struct(s, insn);
         break;
+    case 0x19: /* Load/store tag */
+        disas_ldst_tag(s, insn);
+        break;
     default:
         unallocated_encoding(s);
         break;
-- 
2.17.2
