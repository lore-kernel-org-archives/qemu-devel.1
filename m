Received: from eggs.gnu.org ([2001:4830:134:3::10]:35234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc9-0000hI-M9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc8-0006kp-J1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Feb 2017 16:12:38 +1100
Message-Id: <20170227051239.2680-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170227051239.2680-1-david@gibson.dropbear.id.au>
References: <20170227051239.2680-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 8/9] target/ppc: Remove the function
 ppc_hash64_set_sdr1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The function ppc_hash64_set_sdr1 basically checked the htabsize and set an
error if it was too big, otherwise it just stored the value in SPR_SDR1.

Given that the only function which calls ppc_hash64_set_sdr1() is
ppc_store_sdr1(), why not handle the checking in ppc_store_sdr1() to avoid
the extra function call. Note that ppc_store_sdr1() already stores the
value in SPR_SDR1 anyway, so we were doing it twice.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Remove unnecessary error temporary]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 18 ------------------
 target/ppc/mmu-hash64.h |  3 ---
 target/ppc/mmu_helper.c | 11 +++++------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 8fe0e78..d44f2bb 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -289,24 +289,6 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env, target_ulong rb)
     return rt;
 }
 
-/*
- * 64-bit hash table MMU handling
- */
-void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
-                         Error **errp)
-{
-    CPUPPCState *env = &cpu->env;
-    target_ulong htabsize = value & SDR_64_HTABSIZE;
-
-    if (htabsize > 28) {
-        error_setg(errp,
-                   "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
-                   htabsize);
-        return;
-    }
-    env->spr[SPR_SDR1] = value;
-}
-
 static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
                                ppc_slb_t *slb, ppc_hash_pte64_t pte)
 {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index c8d3458..9c74823 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -109,9 +109,6 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
     return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 - 7)) - 1;
 }
 
-void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
-                         Error **errp);
-
 struct ppc_hash_pte64 {
     uint64_t pte0, pte1;
 };
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 0176ab6..3bc8030 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "helper_regs.h"
+#include "qemu/error-report.h"
 
 //#define DEBUG_MMU
 //#define DEBUG_BATS
@@ -2006,13 +2007,11 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
     assert(!cpu->vhyp);
 #if defined(TARGET_PPC64)
     if (env->mmu_model & POWERPC_MMU_64) {
-        PowerPCCPU *cpu = ppc_env_get_cpu(env);
-        Error *local_err = NULL;
+        target_ulong htabsize = value & SDR_64_HTABSIZE;
 
-        ppc_hash64_set_sdr1(cpu, value, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            error_free(local_err);
+        if (htabsize > 28) {
+            error_report("Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
+                         htabsize);
             return;
         }
     }
-- 
2.9.3
