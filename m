Received: from eggs.gnu.org ([2001:4830:134:3::10]:54309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ay-0003VG-8s
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4aw-0002yX-Cx
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:26 +1000
Message-Id: <20170606025135.2685-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/17] target/ppc: Fixup set_spr error in
 h_register_process_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

set_spr is used in the function h_register_process_table() to update the
LPCR_GTSE and LPCR_UPRT values based on the flags passed by the guest.
The set_spr function takes the last two arguments mask and value used to
mask and set the value of the spr respectively.

The current call site passes these arguments in the wrong order and thus
bot GTSE and UPRT will be set irrespective, which is obviously
incorrect.

Rearrange the function call so that these arguments are passed in the
correct order and the correct behaviour is exhibited.

It is worth noting that this wasn't detected earlier since these were
always both set in all cases where this H_CALL was made.

Fixes: 6de833070ca2 ("target/ppc: Set UPRT and GTSE on all cpus in H_REGISTER_PROCESS_TABLE")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aae5a62..aa1ffea 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -992,9 +992,10 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
 
     /* Update the UPRT and GTSE bits in the LPCR for all cpus */
     CPU_FOREACH(cs) {
-        set_spr(cs, SPR_LPCR, LPCR_UPRT | LPCR_GTSE,
+        set_spr(cs, SPR_LPCR,
                 ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT : 0) |
-                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0));
+                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
+                LPCR_UPRT | LPCR_GTSE);
     }
 
     if (kvm_enabled()) {
-- 
2.9.4
