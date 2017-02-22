Received: from eggs.gnu.org ([2001:4830:134:3::10]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV7-00032Z-03
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV4-00081N-LN
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:20 +1100
Message-Id: <20170222063348.32176-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/43] target-ppc: add slbieg instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

slbieg: SLB Invalidate Entry Global

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h     |  1 +
 target/ppc/mmu-hash64.c | 16 ++++++++++++++--
 target/ppc/translate.c  | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cc81709..007a837 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -669,6 +669,7 @@ DEF_HELPER_2(load_slb_vsid, tl, env, tl)
 DEF_HELPER_2(find_slb_vsid, tl, env, tl)
 DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_FLAGS_2(load_sr, TCG_CALL_NO_RWG, tl, env, tl)
 DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index bb78fb5..2791f29 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -115,7 +115,8 @@ void helper_slbia(CPUPPCState *env)
     }
 }
 
-void helper_slbie(CPUPPCState *env, target_ulong addr)
+static void __helper_slbie(CPUPPCState *env, target_ulong addr,
+                           target_ulong global)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
     ppc_slb_t *slb;
@@ -132,10 +133,21 @@ void helper_slbie(CPUPPCState *env, target_ulong addr)
          *      and we still don't have a tlb_flush_mask(env, n, mask)
          *      in QEMU, we just invalidate all TLBs
          */
-        env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+        env->tlb_need_flush |=
+            (global == false ? TLB_NEED_LOCAL_FLUSH : TLB_NEED_GLOBAL_FLUSH);
     }
 }
 
+void helper_slbie(CPUPPCState *env, target_ulong addr)
+{
+    __helper_slbie(env, addr, false);
+}
+
+void helper_slbieg(CPUPPCState *env, target_ulong addr)
+{
+    __helper_slbie(env, addr, true);
+}
+
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
                   target_ulong esid, target_ulong vsid)
 {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80f9f15..b0f3c3b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4484,6 +4484,19 @@ static void gen_slbie(DisasContext *ctx)
     gen_helper_slbie(cpu_env, cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
+
+/* slbieg */
+static void gen_slbieg(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+
+    gen_helper_slbieg(cpu_env, cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
 #endif  /* defined(TARGET_PPC64) */
 
 /***                              External control                         ***/
@@ -6439,6 +6452,7 @@ GEN_HANDLER(tlbsync, 0x1F, 0x16, 0x11, 0x03FFF801, PPC_MEM_TLBSYNC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(slbia, 0x1F, 0x12, 0x0F, 0x031FFC01, PPC_SLBI),
 GEN_HANDLER(slbie, 0x1F, 0x12, 0x0D, 0x03FF0001, PPC_SLBI),
+GEN_HANDLER_E(slbieg, 0x1F, 0x12, 0x0E, 0x001F0001, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(eciwx, 0x1F, 0x16, 0x0D, 0x00000001, PPC_EXTERN),
 GEN_HANDLER(ecowx, 0x1F, 0x16, 0x09, 0x00000001, PPC_EXTERN),
-- 
2.9.3
