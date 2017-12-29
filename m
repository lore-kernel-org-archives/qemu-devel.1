Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDZ-0003M0-SC
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDY-0004t6-TV
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:33 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDY-0004sy-O2
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:32 -0500
Received: by mail-pg0-x244.google.com with SMTP id q67so11473642pga.9
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:40 -0800
Message-Id: <20171229063145.29167-34-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 33/38] target/hppa: Implement B,GATE insn
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c |  8 ++++++++
 target/hppa/translate.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 648b78986e..0f8db1ec75 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -352,6 +352,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 extern const MemoryRegionOps hppa_io_eir_ops;
 extern const struct VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
+int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9d93894019..e2f94faab5 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -123,6 +123,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         break;
     default: /* execute: promote to privilege level type & 3 */
         prot = x_prot;
+        break;
     }
 
     /* ??? Check PSW_P and ent->access_prot.  This can remove PROT_WRITE.  */
@@ -318,4 +319,11 @@ target_ureg HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
     }
     return phys;
 }
+
+/* Return the ar_type of the TLB at VADDR, or -1.  */
+int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr)
+{
+    hppa_tlb_entry *ent = hppa_find_tlb(env, vaddr);
+    return ent ? ent->ar_type : -1;
+}
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 23ec43eff8..4430a4bfdb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3769,6 +3769,53 @@ static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
     return do_dbranch(ctx, iaoq_dest(ctx, disp), link, n);
 }
 
+static DisasJumpType trans_b_gate(DisasContext *ctx, uint32_t insn,
+                                  const DisasInsn *di)
+{
+    unsigned n = extract32(insn, 1, 1);
+    unsigned link = extract32(insn, 21, 5);
+    target_sreg disp = assemble_17(insn);
+    target_ureg dest = iaoq_dest(ctx, disp);
+
+    /* Make sure the caller hasn't done something weird with the queue.
+     * ??? This is not quite the same as the PSW[B] bit, which would be
+     * expensive to track.  Real hardware will trap for
+     *    b  gateway
+     *    b  gateway+4  (in delay slot of first branch)
+     * However, checking for a non-sequential instruction queue *will*
+     * diagnose the security hole
+     *    b  gateway
+     *    b  evil
+     * in which instructions at evil would run with increased privs.
+     */
+    if (ctx->iaoq_b == -1 || ctx->iaoq_b != ctx->iaoq_f + 4) {
+        return gen_illegal(ctx);
+    }
+
+#ifndef CONFIG_USER_ONLY
+    if (ctx->tb_flags & PSW_C) {
+        CPUHPPAState *env = ctx->cs->env_ptr;
+        int type = hppa_artype_for_page(env, ctx->base.pc_next);
+        /* If we could not find a TLB entry, then we need to generate an
+           ITLB miss exception so the kernel will provide it.
+           The resulting TLB fill operation will invalidate this TB and
+           we will re-translate, at which point we *will* be able to find
+           the TLB entry and determine if this is in fact a gateway page.  */
+        if (type < 0) {
+            return gen_excp(ctx, EXCP_ITLB_MISS);
+        }
+        /* No change for non-gateway pages or for priv decrease.  */
+        if (type >= 4 && type - 4 < ctx->privilege) {
+            dest = deposit32(dest, 0, 2, type - 4);
+        }
+    } else {
+        dest &= -4;  /* priv = 0 */
+    }
+#endif
+
+    return do_dbranch(ctx, dest, link, n);
+}
+
 static DisasJumpType trans_bl_long(DisasContext *ctx, uint32_t insn,
                                    const DisasInsn *di)
 {
@@ -3847,6 +3894,7 @@ static const DisasInsn table_branch[] = {
     { 0xe8004000u, 0xfc00fffdu, trans_blr },
     { 0xe800c000u, 0xfc00fffdu, trans_bv },
     { 0xe800d000u, 0xfc00dffcu, trans_bve },
+    { 0xe8002000u, 0xfc00e000u, trans_b_gate },
 };
 
 static DisasJumpType trans_fop_wew_0c(DisasContext *ctx, uint32_t insn,
-- 
2.14.3
