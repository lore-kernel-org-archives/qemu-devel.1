Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cd7Lt-00026g-I2
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cd7Ls-0004iT-Hr
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:30:57 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 13 Feb 2017 14:30:27 +1100
Message-Id: <1486956627-11123-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Stop parsing pvr list
 in H_CAS when exact match found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, sjitindarsingh@gmail.com

The pvr-list passed in H_Client_Architecture_Support is used to
communicate the supported pvrs of the client program. When an
exact match is found you are allowed to stop parsing the list and continue
the boot process.

Currently while explicit_match is set when we find an exact match, we still
set a compat mode based on best_compat irrespective of whether an exact
match was found or not. This is wrong since it means we can only ever run
in an architected state, not a raw state since we always set a compat mode.
We are basically ignoring the case were we find an exact match.

Fix the code to stop parsing the pvr list when an exact match is found.
This means that best_compat will always be zero in the case of an exact
match which means we will not set a compat mode an thus run in raw mode,
which is the desired functionality when we have an exact match.

Fixes: 152ef803ceb1 ("pseries: Rewrite CAS PVR compatibility logic")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---
 hw/ppc/spapr_hcall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 590105a..215c385 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1028,6 +1028,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
         if ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask)) {
             explicit_match = true;
+            break;
         } else {
             if (ppc_check_compat(cpu, pvr, best_compat, max_compat)) {
                 best_compat = pvr;
-- 
2.5.5
