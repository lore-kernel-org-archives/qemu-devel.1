Received: from eggs.gnu.org ([2001:4830:134:3::10]:56229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUz-0005Nl-2e
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUx-0001WS-EI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:18 +1000
Message-Id: <20170511041426.6488-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/23] target/ppc: Update tlbie to check
 privilege level based on GTSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The Guest Translation Shootdown Enable (GTSE) bit in the Logical Partition
Control Register (LPCR) can be set to enable a guest to use the tlbie
instruction directly to invalidate translations.

When the GTSE bit is set then the tlbie instruction is supervisor
privileged, otherwise it is hypervisor privileged.

Add a guest translation shootdown enable (gtse) field to the diassembly
context and use this to check the correct privilege level at code
generation time.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a1f24a..1ce6ab1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -218,6 +218,7 @@ struct DisasContext {
     bool vsx_enabled;
     bool spe_enabled;
     bool tm_enabled;
+    bool gtse;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
     uint64_t insns_flags;
@@ -4538,7 +4539,12 @@ static void gen_tlbie(DisasContext *ctx)
     GEN_PRIV;
 #else
     TCGv_i32 t1;
-    CHK_HV;
+
+    if (ctx->gtse) {
+        CHK_SV; /* If gtse is set then tblie is supervisor privileged */
+    } else {
+        CHK_HV; /* Else hypervisor privileged */
+    }
 
     if (NARROW_MODE(ctx)) {
         TCGv t0 = tcg_temp_new();
@@ -7252,6 +7258,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
         ctx.tm_enabled = false;
     }
 #endif
+    ctx.gtse = !!(env->spr[SPR_LPCR] & LPCR_GTSE);
     if ((env->flags & POWERPC_FLAG_SE) && msr_se)
         ctx.singlestep_enabled = CPU_SINGLE_STEP;
     else
-- 
2.9.3
