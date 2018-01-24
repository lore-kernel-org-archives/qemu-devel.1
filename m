Received: from eggs.gnu.org ([2001:4830:134:3::10]:51188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURf-0004qq-1h
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURa-0001wK-59
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:07 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURZ-0001w0-W1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:02 -0500
Received: by mail-pg0-x242.google.com with SMTP id y27so3815289pgc.5
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:01 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:02 -0800
Message-Id: <20180124232625.30105-23-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 22/45] target/hppa: Implement P*TLB and
 P*TLBE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We now have all of the TLB manipulation instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  2 ++
 target/hppa/mem_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index d412093914..f059ddf3b9 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -88,4 +88,6 @@ DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tr)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tr, env, tr)
 DEF_HELPER_FLAGS_3(itlba, TCG_CALL_NO_RWG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(itlbp, TCG_CALL_NO_RWG, void, env, tl, tr)
+DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 7c3c7d1415..2835d890f2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -270,4 +270,41 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
     ent->t = extract32(reg, 29, 1);
     ent->entry_valid = 1;
 }
+
+/* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
+   synchronous across all processors.  */
+static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
+{
+    CPUHPPAState *env = cpu->env_ptr;
+    target_ulong addr = (target_ulong) data.target_ptr;
+    hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
+
+    if (ent && ent->entry_valid) {
+        hppa_flush_tlb_ent(env, ent);
+    }
+}
+
+void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
+{
+    CPUState *src = CPU(hppa_env_get_cpu(env));
+    CPUState *cpu;
+    run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
+
+    CPU_FOREACH(cpu) {
+        if (cpu != src) {
+            async_run_on_cpu(cpu, ptlb_work, data);
+        }
+    }
+    async_safe_run_on_cpu(src, ptlb_work, data);
+}
+
+/* Purge (Insn/Data) TLB entry.  This affects an implementation-defined
+   number of pages/entries (we choose all), and is local to the cpu.  */
+void HELPER(ptlbe)(CPUHPPAState *env)
+{
+    CPUState *src = CPU(hppa_env_get_cpu(env));
+
+    memset(env->tlb, 0, sizeof(env->tlb));
+    tlb_flush_by_mmuidx(src, 0xf);
+}
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c02d107041..5b77688fc0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2397,6 +2397,42 @@ static DisasJumpType trans_ixtlbx(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
                        ? DISAS_IAQ_N_STALE : DISAS_NEXT);
 }
+
+static DisasJumpType trans_pxtlbx(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned m = extract32(insn, 5, 1);
+    unsigned sp;
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned is_data = insn & 0x1000;
+    unsigned is_local = insn & 0x40;
+    TCGv_tl addr;
+    TCGv_reg ofs;
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
+    form_gva(ctx, &addr, &ofs, rb, rx, 0, 0, sp, m, false);
+    if (m) {
+        save_gpr(ctx, rb, ofs);
+    }
+    if (is_local) {
+        gen_helper_ptlbe(cpu_env);
+    } else {
+        gen_helper_ptlb(cpu_env, addr);
+    }
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    return nullify_end(ctx, !is_data && (ctx->base.tb->flags & PSW_C)
+                       ? DISAS_IAQ_N_STALE : DISAS_NEXT);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_mem_mgmt[] = {
@@ -2420,6 +2456,10 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04000040u, 0xfc001fffu, trans_ixtlbx },       /* iitlba */
     { 0x04001000u, 0xfc001fffu, trans_ixtlbx },       /* idtlbp */
     { 0x04001040u, 0xfc001fffu, trans_ixtlbx },       /* idtlba */
+    { 0x04000200u, 0xfc001fdfu, trans_pxtlbx },       /* pitlb */
+    { 0x04000240u, 0xfc001fdfu, trans_pxtlbx },       /* pitlbe */
+    { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
+    { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
 #endif
 };
 
-- 
2.14.3
