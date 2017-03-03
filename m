Received: from eggs.gnu.org ([2001:4830:134:3::10]:44240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqV-00083z-Kp
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqU-0001MV-Cz
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:03 +1100
Message-Id: <20170303032507.16142-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/17] target/ppc: Move no-execute and guarded
 page checking into new function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

A pte entry has bit fields which can be used to make a page no-execute or
guarded, if either of these bits are set then an instruction access to this
page will fail. Currently these bits are checked with the pp_prot function
however the ISA specifies that the access authority controlled by the
key-pp value pair should only be checked on an instruction access after
the no-execute and guard bits have already been verified to permit the
access.

Move the no-execute and guard bit checking into a new separate function.
Note that we can remove the check for the no-execute bit in the slb entry
since this check was already performed above when we obtained the slb
entry.

In the event that the no-execute or guard bits are set, an ISI should be
generated with the SRR1_NOEXEC_GUARD (0x10000000) bit set in srr1. Add a
define for this for clarity.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Move constants to cpu.h since they're not MMUv3 specific]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        |  1 +
 target/ppc/mmu-hash64.c | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 42fed6e..14c286e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -475,6 +475,7 @@ struct ppc_slb_t {
 
 /* SRR1 error code fields */
 
+#define SRR1_NOEXEC_GUARD        0x10000000
 #define SRR1_PROTFAULT           0x08000000
 #define SRR1_IAMR                0x00200000
 
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 99f936d..d985617 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -290,6 +290,16 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env, target_ulong rb)
     return rt;
 }
 
+/* Check No-Execute or Guarded Storage */
+static inline int ppc_hash64_pte_noexec_guard(PowerPCCPU *cpu,
+                                              ppc_hash_pte64_t pte)
+{
+    /* Exec permissions CANNOT take away read or write permissions */
+    return (pte.pte1 & HPTE64_R_N) || (pte.pte1 & HPTE64_R_G) ?
+            PAGE_READ | PAGE_WRITE : PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+}
+
+/* Check Basic Storage Protection */
 static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
                                ppc_slb_t *slb, ppc_hash_pte64_t pte)
 {
@@ -333,12 +343,6 @@ static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
         }
     }
 
-    /* No execute if either noexec or guarded bits set */
-    if (!(pte.pte1 & HPTE64_R_N) || (pte.pte1 & HPTE64_R_G)
-        || (slb->vsid & SLB_VSID_N)) {
-        prot |= PAGE_EXEC;
-    }
-
     return prot;
 }
 
@@ -696,7 +700,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
     unsigned apshift;
     hwaddr ptex;
     ppc_hash_pte64_t pte;
-    int pp_prot, amr_prot, prot;
+    int exec_prot, pp_prot, amr_prot, prot;
     uint64_t new_pte1, dsisr;
     const int need_prot[] = {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
@@ -803,16 +807,19 @@ skip_slb_search:
 
     /* 5. Check access permissions */
 
+    exec_prot = ppc_hash64_pte_noexec_guard(cpu, pte);
     pp_prot = ppc_hash64_pte_prot(cpu, slb, pte);
     amr_prot = ppc_hash64_amr_prot(cpu, pte);
-    prot = pp_prot & amr_prot;
+    prot = exec_prot & pp_prot & amr_prot;
 
     if ((need_prot[rwx] & ~prot) != 0) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (rwx == 2) {
             int srr1 = 0;
-            if (PAGE_EXEC & ~pp_prot) {
+            if (PAGE_EXEC & ~exec_prot) {
+                srr1 |= SRR1_NOEXEC_GUARD; /* Access violates noexec or guard */
+            } else if (PAGE_EXEC & ~pp_prot) {
                 srr1 |= SRR1_PROTFAULT; /* Access violates access authority */
             }
             if (PAGE_EXEC & ~amr_prot) {
-- 
2.9.3
