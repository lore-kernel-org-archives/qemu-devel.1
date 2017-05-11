Received: from eggs.gnu.org ([2001:4830:134:3::10]:56074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUv-0005JR-W1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUu-0001Re-CQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:17 +1000
Message-Id: <20170511041426.6488-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/23] target/ppc: Set UPRT and GTSE on all cpus
 in H_REGISTER_PROCESS_TABLE
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

The UPRT and GTSE bits are set when a guest calls H_REGISTER_PROCESS_TABLE
to choose determine how address translation is performed. Currently these
bits in the LPCR are only set for the cpu which handles the H_CALL, however
they need to be set for all cpus for that guest as address translation
cannot be performed differently on a per cpu basis.

Update the H_CALL handler to set these bits in the LPCR correctly for all
cpus of the guest.

Note it is the reponsibility of the guest to ensure that any secondary cpus
are suspended when the H_CALL is made and thus we can safely update these
values here.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9f18f75..0d608d6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -936,7 +936,7 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
-    CPUPPCState *env = &cpu->env;
+    CPUState *cs;
     target_ulong flags = args[0];
     target_ulong proc_tbl = args[1];
     target_ulong page_size = args[2];
@@ -992,16 +992,12 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     spapr_check_setup_free_hpt(spapr, spapr->patb_entry, cproc);
 
     spapr->patb_entry = cproc; /* Save new process table */
-    if ((flags & FLAG_RADIX) || (flags & FLAG_HASH_PROC_TBL)) {
-        /* Use Process TBL */
-        env->spr[SPR_LPCR] |= LPCR_UPRT;
-    } else {
-        env->spr[SPR_LPCR] &= ~LPCR_UPRT;
-    }
-    if (flags & FLAG_GTSE) { /* Partition Uses Guest Translation Shootdwn */
-        env->spr[SPR_LPCR] |= LPCR_GTSE;
-    } else {
-        env->spr[SPR_LPCR] &= ~LPCR_GTSE;
+
+    /* Update the UPRT and GTSE bits in the LPCR for all cpus */
+    CPU_FOREACH(cs) {
+        set_spr(cs, SPR_LPCR, LPCR_UPRT | LPCR_GTSE,
+                ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT : 0) |
+                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0));
     }
 
     if (kvm_enabled()) {
-- 
2.9.3
