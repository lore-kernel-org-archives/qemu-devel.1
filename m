Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4Z-0002Jq-3F
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4T-0001yj-Km
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49149
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4T-0001xn-FR
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXkEY096379
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:24 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gp3ha1s4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:24 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:21 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:04:01 +0530
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486636445-24109-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/6] target-ppc: add slbieg instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

slbieg: SLB Invalidate Entry Global

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
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
2.7.4
