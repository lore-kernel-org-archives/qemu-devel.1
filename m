Received: from eggs.gnu.org ([2001:4830:134:3::10]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqU-00083p-9B
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqT-0001KE-4U
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:30 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:01 +1100
Message-Id: <20170303032507.16142-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/17] target/ppc: Add Instruction Authority
 Mask Register Check
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

The instruction authority mask register (IAMR) can be used to restrict
permissions for instruction fetch accesses on a per key basis for each
of 32 different key values. Access permissions are derived based on the
specific key value stored in the relevant page table entry.

The IAMR was introduced in, and is present in processors since, POWER8
(ISA v2.07). Thus introduce a function to check access permissions based
on the pte key value and the contents of the IAMR when handling a page
fault to ensure sufficient access permissions for an instruction fetch.

A hash pte contains a key value in bits 2:3|52:54 of the second double word
of the pte, this key value gives an index into the IAMR which contains 32
2-bit access masks. If the least significant bit of the 2-bit access mask
corresponding to the given key value is set (IAMR[key] & 0x1 == 0x1) then
the instruction fetch is not permitted and an ISI is generated accordingly.
While we're here, add defines for the srr1 bits to be set for the ISI for
clarity.

e.g.

pte:
dw0 [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]
dw1 [XX01XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX010XXXXXXXXX]
       ^^                                                ^^^
key = 01010 (0x0a)

IAMR: [XXXXXXXXXXXXXXXXXXXX01XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]
                           ^^
Access mask = 0b01

Test access mask: 0b01 & 0x1 == 0x1

Least significant bit of the access mask is set, thus the instruction fetch
is not permitted. We should generate an instruction storage interrupt (ISI)
with bit 42 of SRR1 set to indicate access precluded by virtual page class
key protection.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Move new constants to cpu.h, since they're not MMUv3 specific]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        |  5 +++++
 target/ppc/mmu-hash64.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 674bb3f..42fed6e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -473,6 +473,11 @@ struct ppc_slb_t {
 #endif
 #endif
 
+/* SRR1 error code fields */
+
+#define SRR1_PROTFAULT           0x08000000
+#define SRR1_IAMR                0x00200000
+
 /* Facility Status and Control (FSCR) bits */
 #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
 #define FSCR_TAR        (63 - 55) /* Target Address Register */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 368ee60..ee94f13 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -343,6 +343,23 @@ static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
     return prot;
 }
 
+/* Check the instruction access permissions specified in the IAMR */
+static int ppc_hash64_iamr_prot(PowerPCCPU *cpu, int key)
+{
+    CPUPPCState *env = &cpu->env;
+    int iamr_bits = (env->spr[SPR_IAMR] >> 2 * (31 - key)) & 0x3;
+
+    /*
+     * An instruction fetch is permitted if the IAMR bit is 0.
+     * If the bit is set, return PAGE_READ | PAGE_WRITE because this bit
+     * can only take away EXEC permissions not READ or WRITE permissions.
+     * If bit is cleared return PAGE_READ | PAGE_WRITE | PAGE_EXEC since
+     * EXEC permissions are allowed.
+     */
+    return (iamr_bits & 0x1) ? PAGE_READ | PAGE_WRITE :
+                               PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+}
+
 static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
 {
     CPUPPCState *env = &cpu->env;
@@ -375,6 +392,21 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
         prot &= ~PAGE_READ;
     }
 
+    switch (env->mmu_model) {
+    /*
+     * MMU version 2.07 and later support IAMR
+     * Check if the IAMR allows the instruction access - it will return
+     * PAGE_EXEC if it doesn't (and thus that bit will be cleared) or 0
+     * if it does (and prot will be unchanged indicating execution support).
+     */
+    case POWERPC_MMU_2_07:
+    case POWERPC_MMU_3_00:
+        prot &= ppc_hash64_iamr_prot(cpu, key);
+        break;
+    default:
+        break;
+    }
+
     return prot;
 }
 
@@ -780,7 +812,14 @@ skip_slb_search:
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (rwx == 2) {
-            ppc_hash64_set_isi(cs, env, 0x08000000);
+            int srr1 = 0;
+            if (PAGE_EXEC & ~pp_prot) {
+                srr1 |= SRR1_PROTFAULT; /* Access violates access authority */
+            }
+            if (PAGE_EXEC & ~amr_prot) {
+                srr1 |= SRR1_IAMR; /* Access violates virt pg class key prot */
+            }
+            ppc_hash64_set_isi(cs, env, srr1);
         } else {
             dsisr = 0;
             if (need_prot[rwx] & ~pp_prot) {
-- 
2.9.3
