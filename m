Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqX-00085q-Av
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqV-0001NK-Pu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:04 +1100
Message-Id: <20170303032507.16142-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/17] target/ppc: Rework hash mmu page fault
 code and add defines for clarity
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

The hash mmu page fault handling code is responsible for generating ISIs
and DSIs when access permissions cause an access to fail. Part of this
involves setting the srr1 or dsisr registers to indicate what causes the
access to fail. Add defines for the bit fields of these registers and
rework the code to use these new defines in order to improve readability
and code clarity.

While we're here, update what is logged when an access fails to include
information as to what caused to access to fail for debug purposes.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Moved constants to cpu.h since they're not MMUv3 specific]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        | 14 ++++++++++++--
 target/ppc/mmu-hash64.c | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 14c286e..7c4a1f5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -473,11 +473,21 @@ struct ppc_slb_t {
 #endif
 #endif
 
+/* DSISR */
+#define DSISR_NOPTE              0x40000000
+/* Not permitted by access authority of encoded access authority */
+#define DSISR_PROTFAULT          0x08000000
+#define DSISR_ISSTORE            0x02000000
+/* Not permitted by virtual page class key protection */
+#define DSISR_AMR                0x00200000
+
 /* SRR1 error code fields */
 
+#define SRR1_NOPTE               DSISR_NOPTE
+/* Not permitted due to no-execute or guard bit set */
 #define SRR1_NOEXEC_GUARD        0x10000000
-#define SRR1_PROTFAULT           0x08000000
-#define SRR1_IAMR                0x00200000
+#define SRR1_PROTFAULT           DSISR_PROTFAULT
+#define SRR1_IAMR                DSISR_AMR
 
 /* Facility Status and Control (FSCR) bits */
 #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d985617..d5a871f 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -701,7 +701,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
     hwaddr ptex;
     ppc_hash_pte64_t pte;
     int exec_prot, pp_prot, amr_prot, prot;
-    uint64_t new_pte1, dsisr;
+    uint64_t new_pte1;
     const int need_prot[] = {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
     hwaddr raddr;
 
@@ -742,11 +742,11 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
             } else {
                 /* The access failed, generate the approriate interrupt */
                 if (rwx == 2) {
-                    ppc_hash64_set_isi(cs, env, 0x08000000);
+                    ppc_hash64_set_isi(cs, env, SRR1_PROTFAULT);
                 } else {
-                    dsisr = 0x08000000;
+                    int dsisr = DSISR_PROTFAULT;
                     if (rwx == 1) {
-                        dsisr |= 0x02000000;
+                        dsisr |= DSISR_ISSTORE;
                     }
                     ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
                 }
@@ -784,19 +784,19 @@ skip_slb_search:
 
     /* 3. Check for segment level no-execute violation */
     if ((rwx == 2) && (slb->vsid & SLB_VSID_N)) {
-        ppc_hash64_set_isi(cs, env, 0x10000000);
+        ppc_hash64_set_isi(cs, env, SRR1_NOEXEC_GUARD);
         return 1;
     }
 
     /* 4. Locate the PTE in the hash table */
     ptex = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
     if (ptex == -1) {
-        dsisr = 0x40000000;
         if (rwx == 2) {
-            ppc_hash64_set_isi(cs, env, dsisr);
+            ppc_hash64_set_isi(cs, env, SRR1_NOPTE);
         } else {
+            int dsisr = DSISR_NOPTE;
             if (rwx == 1) {
-                dsisr |= 0x02000000;
+                dsisr |= DSISR_ISSTORE;
             }
             ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
         }
@@ -827,15 +827,15 @@ skip_slb_search:
             }
             ppc_hash64_set_isi(cs, env, srr1);
         } else {
-            dsisr = 0;
+            int dsisr = 0;
             if (need_prot[rwx] & ~pp_prot) {
-                dsisr |= 0x08000000;
+                dsisr |= DSISR_PROTFAULT;
             }
             if (rwx == 1) {
-                dsisr |= 0x02000000;
+                dsisr |= DSISR_ISSTORE;
             }
             if (need_prot[rwx] & ~amr_prot) {
-                dsisr |= 0x00200000;
+                dsisr |= DSISR_AMR;
             }
             ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
         }
-- 
2.9.3
