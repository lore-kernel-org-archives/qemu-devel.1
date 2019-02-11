Received: from eggs.gnu.org ([209.51.188.92]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05z-00061P-Mm
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05t-0000AU-2j
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:15 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05s-0008Gi-Ay
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:08 -0500
Received: by mail-pl1-x642.google.com with SMTP id o6so4487431pls.13
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:08:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:18 -0800
Message-Id: <20190211010829.29869-16-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 15/26] target/arm: Implement LDG, STG,
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
---
 target/arm/helper-a64.h    |   5 ++
 target/arm/mte_helper.c    | 152 ++++++++++++++++++++++++++++++++++++-
 target/arm/translate-a64.c | 114 ++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index ef340cb6f9..a00364fb4c 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -108,3 +108,8 @@ DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(ldg, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(stg, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(st2g, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(stg_parallel, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(st2g_parallel, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index fc9e172c95..13befdbf86 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -25,8 +25,6 @@
 #include "exec/helper-proto.h"
 
 
-#if 0
-/* Don't break bisect.  This will gain another user before we're done.  */
 static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
 {
     /*
@@ -51,10 +49,22 @@ static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
         return ptr;
     }
 }
-#endif
+
+static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
+                                   bool write, uintptr_t ra)
+{
+    /* Tag storage not implemented.  */
+    return NULL;
+}
 
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
@@ -240,3 +250,139 @@ uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
     int tag = allocation_tag_from_addr(ptr);
     return mask | (1ULL << tag);
 }
+
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag;
+
+    /* Trap if accessing an invalid page.  */
+    rtag = get_allocation_tag(env, ptr, GETPC());
+
+    /*
+     * The tag is squashed to zero if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    if (rtag < 0 || !allocation_tag_access_enabled(env, el, sctlr)) {
+        rtag = 0;
+    }
+
+    return address_with_allocation_tag(ptr, rtag);
+}
+
+static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
+{
+    if (unlikely(ptr & MAKE_64BIT_MASK(0, LOG2_TAG_GRANULE))) {
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
+static uint64_t do_stg(CPUARMState *env, uint64_t ptr, uintptr_t ra,
+                       void (*store1)(uint64_t, uint8_t *, int))
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    uint8_t *mem;
+
+    check_tag_aligned(env, ptr, ra);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, ra);
+
+    /* Store if page supports tags and access is enabled.  */
+    if (mem && allocation_tag_access_enabled(env, el, sctlr)) {
+        store1(ptr, mem, allocation_tag_from_addr(ptr));
+    }
+
+    /* Clean the pointer for use by stzg.  */
+    return strip_tbi(env, ptr);
+}
+
+uint64_t HELPER(stg)(CPUARMState *env, uint64_t ptr)
+{
+    return do_stg(env, ptr, GETPC(), store_tag1);
+}
+
+uint64_t HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr)
+{
+    return do_stg(env, ptr, GETPC(), store_tag1_parallel);
+}
+
+static uint64_t do_st2g(CPUARMState *env, uint64_t ptr1, uintptr_t ra,
+                        void (*store1)(uint64_t, uint8_t *, int))
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    uint64_t ptr2 = ptr1 + (1 << LOG2_TAG_GRANULE);
+    uint8_t *mem1, *mem2;
+
+    check_tag_aligned(env, ptr1, ra);
+
+    /* Trap if accessing an invalid page(s).  */
+    mem1 = mem2 = allocation_tag_mem(env, ptr1, true, ra);
+    if (unlikely((ptr1 ^ ptr2) & TARGET_PAGE_MASK)) {
+        /* The two stores are across two pages.  */
+        mem2 = allocation_tag_mem(env, ptr2, true, ra);
+    }
+
+    /* Store if page supports tags and access is enabled.  */
+    if ((mem1 || mem2) && allocation_tag_access_enabled(env, el, sctlr)) {
+        int tag = allocation_tag_from_addr(ptr1);
+
+        if (likely(mem1 == mem2)) {
+            /* The two stores are to the same byte.  */
+            tag |= tag << 4;
+            atomic_set(mem1, tag);
+        } else {
+            /* The two stores are across two bytes.  */
+            if (mem1) {
+                store1(ptr1, mem1, tag);
+            }
+            if (mem2) {
+                store1(ptr2, mem2, tag);
+            }
+        }
+    }
+
+    /* Clean the pointer for use by stz2g.  */
+    return strip_tbi(env, ptr1);
+}
+
+uint64_t HELPER(st2g)(CPUARMState *env, uint64_t ptr)
+{
+    return do_st2g(env, ptr, GETPC(), store_tag1);
+}
+
+uint64_t HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr)
+{
+    return do_st2g(env, ptr, GETPC(), store_tag1_parallel);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3e46ee6f69..539c25a80b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3603,6 +3603,117 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
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
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        if (is_pair) {
+            gen_helper_st2g_parallel(clean_addr, cpu_env, dirty_addr);
+        } else {
+            gen_helper_stg_parallel(clean_addr, cpu_env, dirty_addr);
+        }
+    } else {
+        if (is_pair) {
+            gen_helper_st2g(clean_addr, cpu_env, dirty_addr);
+        } else {
+            gen_helper_stg(clean_addr, cpu_env, dirty_addr);
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
@@ -3627,6 +3738,9 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
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
