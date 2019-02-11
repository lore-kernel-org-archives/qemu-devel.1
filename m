Received: from eggs.gnu.org ([209.51.188.92]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOJ-0005Uc-TF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOH-0004g1-3v
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:35 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOG-0004Uo-F6
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: by mail-pf1-x443.google.com with SMTP id b7so327892pfi.8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:47 -0800
Message-Id: <20190211235258.542-18-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 17/28] target/arm: Implement the LDGM and
 STGM instructions
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
v3: Require pre-cleaned addresses.
---
 target/arm/helper-a64.h    |  3 ++
 target/arm/mte_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 42 +++++++++++++----
 3 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 91e6a6ea94..5bcdfcf81b 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -114,3 +114,6 @@ DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stzgm, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index e8873f1e75..afa4c26535 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -377,3 +377,99 @@ void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
     do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
 }
+
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+{
+    const int size = 4 << GMID_EL1_BS;
+    int el;
+    uint64_t sctlr;
+    void *mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, size);
+
+    /* Trap if accessing an invalid page(s).  */
+    mem = allocation_tag_mem(env, ptr, false, GETPC());
+
+    /*
+     * The tag is squashed to zero if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return 0;
+    }
+
+#if GMID_EL1_BS != 6
+# error "Fill in the blanks for other sizes"
+#endif
+    /*
+     * We are loading 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    return ldq_le_p(mem);
+}
+
+static uint64_t do_stgm(CPUARMState *env, uint64_t ptr,
+                        uint64_t val, uintptr_t ra)
+{
+    const int size = 4 << GMID_EL1_BS;
+    int el;
+    uint64_t sctlr;
+    void *mem;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, size);
+
+    /* Trap if accessing an invalid page(s).  */
+    mem = allocation_tag_mem(env, ptr, true, ra);
+
+    /*
+     * No action if the page does not support tags,
+     * or if the OS is denying access to the tags.
+     */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return ptr;
+    }
+
+#if GMID_EL1_BS != 6
+# error "Fill in the blanks for other sizes"
+#endif
+    /*
+     * We are storing 64-bits worth of tags.  The ordering of elements
+     * within the word corresponds to a 64-bit little-endian operation.
+     */
+    stq_le_p(mem, val);
+
+    return ptr;
+}
+
+void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    do_stgm(env, ptr, val, GETPC());
+}
+
+void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    int i, mmu_idx, size = 4 << GMID_EL1_BS;
+    uintptr_t ra = GETPC();
+    void *mem;
+
+    ptr = do_stgm(env, ptr, val, ra);
+
+    /*
+     * We will have just probed this virtual address in do_stgm.
+     * If the tlb_vaddr_to_host fails, then the memory is not ram,
+     * or is monitored in some other way.  Fall back to stores.
+     */
+    mmu_idx = cpu_mmu_index(env, false);
+    mem = tlb_vaddr_to_host(env, ptr, MMU_DATA_STORE, mmu_idx);
+    if (mem) {
+        memset(mem, 0, size);
+    } else {
+        for (i = 0; i < size; i += 8) {
+            cpu_stq_data_ra(env, ptr + i, 0, ra);
+        }
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ef3fc3a397..b97af372f0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3643,7 +3643,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
     int op2 = extract32(insn, 10, 3);
     int op1 = extract32(insn, 22, 2);
-    bool is_load = false, is_pair = false, is_zero = false;
+    bool is_load = false, is_pair = false, is_zero = false, is_mult = false;
     int index = 0;
     TCGv_i64 dirty_addr, clean_addr, tcg_rt;
 
@@ -3653,13 +3653,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     }
 
     switch (op1) {
-    case 0: /* STG */
+    case 0:
         if (op2 != 0) {
             /* STG */
             index = op2 - 2;
-            break;
+        } else {
+            /* STZGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = is_zero = true;
         }
-        goto do_unallocated;
+        break;
     case 1:
         if (op2 != 0) {
             /* STZG */
@@ -3675,17 +3680,27 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
             /* ST2G */
             is_pair = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* STGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = true;
         }
-        goto do_unallocated;
+        break;
     case 3:
         if (op2 != 0) {
             /* STZ2G */
             is_pair = is_zero = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* LDGM */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_mult = is_load = true;
         }
-        goto do_unallocated;
+        break;
 
     default:
     do_unallocated:
@@ -3702,7 +3717,16 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     clean_addr = clean_data_tbi(s, dirty_addr, false);
     tcg_rt = cpu_reg(s, rt);
 
-    if (is_load) {
+    if (is_mult) {
+        if (is_load) {
+            gen_helper_ldgm(tcg_rt, cpu_env, clean_addr);
+        } else if (is_zero) {
+            gen_helper_stzgm(cpu_env, clean_addr, tcg_rt);
+        } else {
+            gen_helper_stgm(cpu_env, clean_addr, tcg_rt);
+        }
+        return;
+    } else if (is_load) {
         gen_helper_ldg(tcg_rt, cpu_env, clean_addr, tcg_rt);
     } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         if (is_pair) {
-- 
2.17.2
