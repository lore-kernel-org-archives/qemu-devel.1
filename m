Received: from eggs.gnu.org ([2001:4830:134:3::10]:33500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dHgDj-0002xm-SF
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dHgDi-0000nw-VQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:50:11 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  5 Jun 2017 10:49:51 +1000
Message-Id: <20170605004951.1009-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH] target/ppc: Fixup set_spr error in
 h_register_process_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
