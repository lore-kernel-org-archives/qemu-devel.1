Received: from eggs.gnu.org ([209.51.188.92]:57247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1h0zhl-0006vU-P0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1h0zhk-0003Aq-TO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:21:17 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue,  5 Mar 2019 13:21:02 +1100
Message-Id: <20190305022102.17610-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc/spapr: Clear partition
 table entry when allocating hash table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

If we allocate a hash page table then we know that the guest won't be
using process tables, so set the partition table entry maintained for
the guest to zero. If this isn't done, then the guest radix bit will
remain set in the entry. This means that when the guest calls
H_REGISTER_PROCESS_TABLE there will be a mismatch between then flags
and the value in spapr->patb_entry, and the call will fail. The guest
will then panic:

Failed to register process table (rc=-4)
kernel BUG at arch/powerpc/platforms/pseries/lpar.c:959

The result being that it isn't possible to boot a hash guest on a P9
system.

Also fix a bug in the flags parsing in h_register_process_table() which
was introduced by the same patch, and simplify the handling to make it
less likely that errors will be introduced in the future. The effect
would have been setting the host radix bit LPCR_HR for a hash guest
using process tables, which currently isn't supported and so couldn't
have been triggered.

Fixes: 00fd075e18 "target/ppc/spapr: Set LPCR:HR when using Radix mode"

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e39068578e..cf1ef9ebd4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1632,6 +1632,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
+    spapr->patb_entry = 0;
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8bfdddc964..7016a09386 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1339,6 +1339,7 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     target_ulong proc_tbl = args[1];
     target_ulong page_size = args[2];
     target_ulong table_size = args[3];
+    target_ulong update_lpcr = 0;
     uint64_t cproc;
 
     if (flags & ~FLAGS_MASK) { /* Check no reserved bits are set */
@@ -1394,10 +1395,13 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     spapr->patb_entry = cproc; /* Save new process table */
 
     /* Update the UPRT, HR and GTSE bits in the LPCR for all cpus */
-    spapr_set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ?
-                         (LPCR_UPRT | LPCR_HR) : 0) |
-                        ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
-                        LPCR_UPRT | LPCR_HR | LPCR_GTSE);
+    if (flags & FLAG_RADIX)     /* Radix must use process tables, also set HR */
+        update_lpcr |= (LPCR_UPRT | LPCR_HR);
+    else if (flags & FLAG_HASH_PROC_TBL) /* Hash with process tables */
+        update_lpcr |= LPCR_UPRT;
+    if (flags & FLAG_GTSE)      /* Guest translation shootdown enable */
+        update_lpcr |= FLAG_GTSE;
+    spapr_set_all_lpcrs(update_lpcr, LPCR_UPRT | LPCR_HR | LPCR_GTSE);
 
     if (kvm_enabled()) {
         return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
-- 
2.13.6
