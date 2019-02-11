Received: from eggs.gnu.org ([209.51.188.92]:38154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOG-0005R0-Ui
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOE-0004ar-Ka
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOC-0004Ta-Ai
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so330360pgs.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:45 -0800
Message-Id: <20190211235258.542-16-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 15/28] target/arm: Implement LDG, STG,
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
v2: Split out allocation_tag_mem.  Handle atomicity of stores.
v3: Add X[t] input to these insns; require pre-cleaned addresses.
---
 target/arm/helper-a64.h    |   5 ++
 target/arm/mte_helper.c    | 151 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 115 ++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 3b78e19279..91e6a6ea94 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -109,3 +109,8 @@ DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index e60c6f48eb..e8873f1e75 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -25,8 +25,21 @@
 #include "exec/helper-proto.h"
 
 
+static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
+                                   bool write, uintptr_t ra)
+{
+    /* Tag storage not implemented.  */
+    return NULL;
+}
+
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
 {
+    uint8_t *mem = allocation_tag_mem(env, ptr, false, ra);
+
+    if (mem) {
+        int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+        return extract32(atomic_read(mem), ofs, 4);
+    }
     /* Tag storage not implemented.  */
     return -1;
 }
@@ -226,3 +239,141 @@ uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
     int tag = allocation_tag_from_addr(ptr);
     return mask | (1ULL << tag);
 }
+
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    int el;
+    uint64_t sctlr;
+    int rtag;
+
+    /* Trap if accessing an invalid page.  */
+    rtag = get_allocation_tag(env, ptr, GETPC());
+
+    /*
+     * The tag is squashed to zero if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (rtag < 0 || !allocation_tag_access_enabled(env, el, sctlr)) {
+        rtag = 0;
+    }
+
+    return address_with_allocation_tag(xt, rtag);
+}
+
+static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
+{
+    if (unlikely(!QEMU_IS_ALIGNED(ptr, TAG_GRANULE))) {
+        arm_cpu_do_unaligned_access(ENV_GET_CPU(env), ptr, MMU_DATA_STORE,
+                                    cpu_mmu_index(env, false), ra);
+        g_assert_not_reached();
+    }
+}
+
+/* For use in a non-parallel context, store to the given nibble.  */
+static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    uint8_t old = atomic_read(mem);
+    uint8_t new = deposit32(old, ofs, 4, tag);
+
+    atomic_set(mem, new);
+}
+
+/* For use in a parallel context, atomically store to the given nibble.  */
+static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    uint8_t old = atomic_read(mem);
+
+    while (1) {
+        uint8_t new = deposit32(old, ofs, 4, tag);
+        uint8_t cmp = atomic_cmpxchg(mem, old, new);
+        if (likely(cmp == old)) {
+            return;
+        }
+        old = cmp;
+    }
+}
+
+typedef void stg_store1(uint64_t, uint8_t *, int);
+
+static void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                   uintptr_t ra, stg_store1 store1)
+{
+    int el;
+    uint64_t sctlr;
+    uint8_t *mem;
+
+    check_tag_aligned(env, ptr, ra);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, ra);
+
+    /* Store if page supports tags and access is enabled.  */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (mem && allocation_tag_access_enabled(env, el, sctlr)) {
+        store1(ptr, mem, allocation_tag_from_addr(xt));
+    }
+}
+
+void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
+
+static void do_st2g(CPUARMState *env, uint64_t ptr1, uint64_t xt,
+                    uintptr_t ra, stg_store1 store1)
+{
+    int el;
+    uint64_t ptr2, sctlr;
+    uint8_t *mem1, *mem2;
+
+    check_tag_aligned(env, ptr1, ra);
+    ptr2 = ptr1 + TAG_GRANULE;
+
+    /* Trap if accessing an invalid page(s).  */
+    mem1 = mem2 = allocation_tag_mem(env, ptr1, true, ra);
+    if (unlikely((ptr1 ^ ptr2) & TARGET_PAGE_MASK)) {
+        /* The two stores are across two pages.  */
+        mem2 = allocation_tag_mem(env, ptr2, true, ra);
+    }
+
+    /* Store if page supports tags and access is enabled.  */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if ((mem1 || mem2) && allocation_tag_access_enabled(env, el, sctlr)) {
+        int tag = allocation_tag_from_addr(xt);
+
+        if (likely(mem1 == mem2)) {
+            /* The two stores are aligned 32, and modify one byte.  */
+            tag |= tag << 4;
+            atomic_set(mem1, tag);
+        } else {
+            /* The two stores are unaligned and modify two bytes.  */
+            if (mem1) {
+                store1(ptr1, mem1, tag);
+            }
+            if (mem2) {
+                store1(ptr2, mem2, tag);
+            }
+        }
+    }
+}
+
+void HELPER(st2g)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2339556320..feed325083 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3610,6 +3610,118 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
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
+    TCGv_i64 dirty_addr, clean_addr, tcg_rt;
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
+    clean_addr = clean_data_tbi(s, dirty_addr, false);
+    tcg_rt = cpu_reg(s, rt);
+
+    if (is_load) {
+        gen_helper_ldg(tcg_rt, cpu_env, clean_addr, tcg_rt);
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        if (is_pair) {
+            gen_helper_st2g_parallel(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rt);
+        }
+    } else {
+        if (is_pair) {
+            gen_helper_st2g(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stg(cpu_env, clean_addr, tcg_rt);
+        }
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
@@ -3634,6 +3746,9 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
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
