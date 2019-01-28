Received: from eggs.gnu.org ([209.51.188.92]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcB-0006wV-Dl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRP-0006Hh-0I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRM-0006Cj-Sj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id g16so12158270otg.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:12 -0800
Message-Id: <20190128223118.5255-7-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/12] target/arm: Default handling of BTYPE
 during translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The branch target exception for guarded pages has high priority,
and only 8 instructions are valid for that case.  Perform this
check before doing any other decode.

Clear BTYPE after all insns that neither set BTYPE nor exit via
exception (DISAS_NORETURN).

Not yet handled are insns that exit via DISAS_NORETURN for some
other reason, like direct branches.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Change octal constants to binary.
---
 target/arm/internals.h     |   6 ++
 target/arm/translate.h     |   9 ++-
 target/arm/translate-a64.c | 139 +++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6fd4582b2..d01a3f9f44 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -268,6 +268,7 @@ enum arm_exception_class {
     EC_FPIDTRAP               = 0x08,
     EC_PACTRAP                = 0x09,
     EC_CP14RRTTRAP            = 0x0c,
+    EC_BTITRAP                = 0x0d,
     EC_ILLEGALSTATE           = 0x0e,
     EC_AA32_SVC               = 0x11,
     EC_AA32_HVC               = 0x12,
@@ -439,6 +440,11 @@ static inline uint32_t syn_pactrap(void)
     return EC_PACTRAP << ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_btitrap(int btype)
+{
+    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | btype;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 3d5e8bacac..f73939d7b4 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -71,8 +71,13 @@ typedef struct DisasContext {
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
-    /* A copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.  */
-    uint8_t btype;
+    /*
+     * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
+     *  < 0, set by the current instruction.
+     */
+    int8_t btype;
+    /* True if this page is guarded.  */
+    bool guarded_page;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
     /* TCG op of the current insn_start.  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9ce523e2ff..bb64a47c0f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -128,6 +128,16 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     return arm_to_core_mmu_idx(useridx);
 }
 
+static void reset_btype(DisasContext *s)
+{
+    if (s->btype != 0) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        tcg_gen_st_i32(zero, cpu_env, offsetof(CPUARMState, btype));
+        tcg_temp_free_i32(zero);
+        s->btype = 0;
+    }
+}
+
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags)
 {
@@ -13717,6 +13727,90 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
     }
 }
 
+/**
+ * is_guarded_page:
+ * @env: The cpu environment
+ * @s: The DisasContext
+ *
+ * Return true if the page is guarded.
+ */
+static bool is_guarded_page(CPUARMState *env, DisasContext *s)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;  /* FIXME */
+#else
+    uint64_t addr = s->base.pc_first;
+    int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
+    unsigned int index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+
+    /*
+     * We test this immediately after reading an insn, which means
+     * that any normal page must be in the TLB.  The only exception
+     * would be for executing from flash or device memory, which
+     * does not retain the TLB entry.
+     *
+     * FIXME: Assume false for those, for now.  We could use
+     * arm_cpu_get_phys_page_attrs_debug to re-read the page
+     * table entry even for that case.
+     */
+    return (tlb_hit(entry->addr_code, addr) &&
+            env->iotlb[mmu_idx][index].attrs.target_tlb_bit0);
+#endif
+}
+
+/**
+ * btype_destination_ok:
+ * @insn: The instruction at the branch destination
+ * @bt: SCTLR_ELx.BT
+ * @btype: PSTATE.BTYPE, and is non-zero
+ *
+ * On a guarded page, there are a limited number of insns
+ * that may be present at the branch target:
+ *   - branch target identifiers,
+ *   - paciasp, pacibsp,
+ *   - BRK insn
+ *   - HLT insn
+ * Anything else causes a Branch Target Exception.
+ *
+ * Return true if the branch is compatible, false to raise BTITRAP.
+ */
+static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
+{
+    if ((insn & 0xfffff01fu) == 0xd503201fu) {
+        /* HINT space */
+        switch (extract32(insn, 5, 7)) {
+        case 0b011001: /* PACIASP */
+        case 0b011011: /* PACIBSP */
+            /*
+             * If SCTLR_ELx.BT, then PACI*SP are not compatible
+             * with btype == 3.  Otherwise all btype are ok.
+             */
+            return !bt || btype != 3;
+        case 0b100000: /* BTI */
+            /* Not compatible with any btype.  */
+            return false;
+        case 0b100010: /* BTI c */
+            /* Not compatible with btype == 3 */
+            return btype != 3;
+        case 0b100100: /* BTI j */
+            /* Not compatible with btype == 2 */
+            return btype != 2;
+        case 0b100110: /* BTI jc */
+            /* Compatible with any btype.  */
+            return true;
+        }
+    } else {
+        switch (insn & 0xffe0001fu) {
+        case 0xd4200000u: /* BRK */
+        case 0xd4400000u: /* HLT */
+            /* Give priority to the breakpoint exception.  */
+            return true;
+        }
+    }
+    return false;
+}
+
 /* C3.1 A64 instruction index by encoding */
 static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 {
@@ -13728,6 +13822,43 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 
     s->fp_access_checked = false;
 
+    if (dc_isar_feature(aa64_bti, s)) {
+        if (s->base.num_insns == 1) {
+            /*
+             * At the first insn of the TB, compute s->guarded_page.
+             * We delayed computing this until successfully reading
+             * the first insn of the TB, above.  This (mostly) ensures
+             * that the softmmu tlb entry has been populated, and the
+             * page table GP bit is available.
+             *
+             * Note that we need to compute this even if btype == 0,
+             * because this value is used for BR instructions later
+             * where ENV is not available.
+             */
+            s->guarded_page = is_guarded_page(env, s);
+
+            /* First insn can have btype set to non-zero.  */
+            tcg_debug_assert(s->btype >= 0);
+
+            /*
+             * Note that the Branch Target Exception has fairly high
+             * priority -- below debugging exceptions but above most
+             * everything else.  This allows us to handle this now
+             * instead of waiting until the insn is otherwise decoded.
+             */
+            if (s->btype != 0
+                && s->guarded_page
+                && !btype_destination_ok(insn, s->bt, s->btype)) {
+                gen_exception_insn(s, 4, EXCP_UDEF, syn_btitrap(s->btype),
+                                   default_exception_el(s));
+                return;
+            }
+        } else {
+            /* Not the first insn: btype must be 0.  */
+            tcg_debug_assert(s->btype == 0);
+        }
+    }
+
     switch (extract32(insn, 25, 4)) {
     case 0x0: case 0x1: case 0x3: /* UNALLOCATED */
         unallocated_encoding(s);
@@ -13764,6 +13895,14 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
 
     /* if we allocated any temporaries, free them here */
     free_tmp_a64(s);
+
+    /*
+     * After execution of most insns, btype is reset to 0.
+     * Note that we set btype == -1 when the insn sets btype.
+     */
+    if (s->btype > 0 && s->base.is_jmp != DISAS_NORETURN) {
+        reset_btype(s);
+    }
 }
 
 static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
-- 
2.17.2
