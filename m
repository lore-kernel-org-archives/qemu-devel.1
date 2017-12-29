Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDM-00036i-39
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDK-0004mL-Mz
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:20 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDK-0004m8-EU
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:18 -0500
Received: by mail-pl0-x244.google.com with SMTP id z5so22529651plo.10
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:29 -0800
Message-Id: <20171229063145.29167-23-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/38] target/hppa: Implement I*TLBA and I*TLBP
 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

The TLB can now be populated, but it cannot yet be cleared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  2 ++
 target/hppa/mem_helper.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++--
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++--
 3 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 744b11cb66..d412093914 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -86,4 +86,6 @@ DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
+DEF_HELPER_FLAGS_3(itlba, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_3(itlbp, TCG_CALL_NO_RWG, void, env, tl, tr)
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 4e92e35957..9d4bf132d6 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -42,13 +42,40 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 
     for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
         hppa_tlb_entry *ent = &env->tlb[i];
-        if (ent->va_b <= addr && addr <= ent->va_e && ent->entry_valid) {
+        if (ent->va_b <= addr && addr <= ent->va_e) {
             return ent;
         }
     }
     return NULL;
 }
 
+static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
+{
+    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    unsigned i, n = 1 << (2 * ent->page_size);
+    uint64_t addr = ent->va_b;
+
+    for (i = 0; i < n; ++i, addr += TARGET_PAGE_SIZE) {
+        /* Do not flush MMU_PHYS_IDX.  */
+        tlb_flush_page_by_mmuidx(cs, addr, 0xf);
+    }
+
+    memset(ent, 0, sizeof(*ent));
+    ent->va_b = -1;
+}
+
+static hppa_tlb_entry *hppa_alloc_tlb_ent(CPUHPPAState *env)
+{
+    hppa_tlb_entry *ent;
+    uint32_t i = env->tlb_last;
+
+    env->tlb_last = (i == ARRAY_SIZE(env->tlb) - 1 ? 0 : i + 1);
+    ent = &env->tlb[i];
+
+    hppa_flush_tlb_ent(env, ent);
+    return ent;
+}
+
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               MMUAccessType type, hwaddr *pphys, int *pprot)
 {
@@ -67,7 +94,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     /* Find a valid tlb entry that matches the virtual address.  */
     ent = hppa_find_tlb(env, addr);
-    if (ent == NULL) {
+    if (ent == NULL || !ent->entry_valid) {
         phys = 0;
         prot = 0;
         ret = (ifetch ? EXCP_ITLB_MISS : EXCP_DTLB_MISS);
@@ -192,4 +219,53 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType type,
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
 }
+
+/* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
+void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+{
+    hppa_tlb_entry *empty = NULL;
+    int i;
+
+    /* Zap any old entries covering ADDR; notice empty entries on the way.  */
+    for (i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
+        hppa_tlb_entry *ent = &env->tlb[i];
+        if (!ent->entry_valid) {
+            empty = ent;
+        } else if (ent->va_b <= addr && addr <= ent->va_e) {
+            hppa_flush_tlb_ent(env, ent);
+            empty = ent;
+        }
+    }
+
+    /* If we didn't see an empty entry, evict one.  */
+    if (empty == NULL) {
+        empty = hppa_alloc_tlb_ent(env);
+    }
+
+    /* Note that empty->entry_valid == 0 already.  */
+    empty->va_b = addr & TARGET_PAGE_MASK;
+    empty->va_e = empty->va_b + TARGET_PAGE_SIZE - 1;
+    empty->pa = extract32(reg, 5, 20) << TARGET_PAGE_BITS;
+}
+
+/* Insert (Insn/Data) TLB Protection.  Note this is PA 1.1 only.  */
+void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
+{
+    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
+
+    if (unlikely(ent == NULL || ent->entry_valid)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "ITLBP not following ITLBA\n");
+        return;
+    }
+
+    ent->access_id = extract32(reg, 1, 18);
+    ent->u = extract32(reg, 19, 1);
+    ent->ar_pl2 = extract32(reg, 20, 2);
+    ent->ar_pl1 = extract32(reg, 22, 2);
+    ent->ar_type = extract32(reg, 24, 3);
+    ent->b = extract32(reg, 27, 1);
+    ent->d = extract32(reg, 28, 1);
+    ent->t = extract32(reg, 29, 1);
+    ent->entry_valid = 1;
+}
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a670d9d777..13ac727583 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1335,7 +1335,10 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 }
 
 #ifndef CONFIG_USER_ONLY
-/* Top 2 bits of the base register select sp[4-7].  */
+/* The "normal" usage is SP >= 0, wherein SP == 0 selects the space
+   from the top 2 bits of the base register.  There are a few system
+   instructions that have a 3-bit space specifier, for which SR0 is
+   not special.  To handle this, pass ~SP.  */
 static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
 {
     TCGv_ptr ptr;
@@ -1343,7 +1346,12 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
     TCGv_i64 spc;
 
     if (sp != 0) {
-        return cpu_sr[sp];
+        if (sp < 0) {
+            sp = ~sp;
+        }
+        spc = get_temp_tl(ctx);
+        load_spr(ctx, spc, sp);
+        return spc;
     }
 
     ptr = tcg_temp_new_ptr();
@@ -2346,6 +2354,42 @@ static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, DISAS_NEXT);
 }
 
+#ifndef CONFIG_USER_ONLY
+static DisasJumpType trans_ixtlbx(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned sp;
+    unsigned rr = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned is_data = insn & 0x1000;
+    unsigned is_addr = insn & 0x40;
+    TCGv_tl addr;
+    TCGv_reg ofs, reg;
+
+    if (is_data) {
+        sp = extract32(insn, 14, 2);
+    } else {
+        sp = ~assemble_sr3(insn);
+    }
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+
+    form_gva(ctx, &addr, &ofs, rb, 0, 0, 0, sp, 0, false);
+    reg = load_gpr(ctx, rr);
+    if (is_addr) {
+        gen_helper_itlba(cpu_env, addr, reg);
+    } else {
+        gen_helper_itlbp(cpu_env, addr, reg);
+    }
+
+    /* Exit TB for ITLB change if mmu is enabled.  This *should* not be
+       the case, since the OS TLB fill handler runs with mmu disabled.  */
+    return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
+                       ? DISAS_IAQ_N_STALE : DISAS_NEXT);
+}
+#endif /* !CONFIG_USER_ONLY */
+
 static const DisasInsn table_mem_mgmt[] = {
     { 0x04003280u, 0xfc003fffu, trans_nop },          /* fdc, disp */
     { 0x04001280u, 0xfc003fffu, trans_nop },          /* fdc, index */
@@ -2362,6 +2406,12 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04002720u, 0xfc003fffu, trans_base_idx_mod }, /* pdc, base mod */
     { 0x04001180u, 0xfc003fa0u, trans_probe },        /* probe */
     { 0x04003180u, 0xfc003fa0u, trans_probe },        /* probei */
+#ifndef CONFIG_USER_ONLY
+    { 0x04000000u, 0xfc001fffu, trans_ixtlbx },       /* iitlbp */
+    { 0x04000040u, 0xfc001fffu, trans_ixtlbx },       /* iitlba */
+    { 0x04001000u, 0xfc001fffu, trans_ixtlbx },       /* idtlbp */
+    { 0x04001040u, 0xfc001fffu, trans_ixtlbx },       /* idtlba */
+#endif
 };
 
 static DisasJumpType trans_add(DisasContext *ctx, uint32_t insn,
-- 
2.14.3
