Received: from eggs.gnu.org ([2001:4830:134:3::10]:60538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eESz2-0006Lc-RR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eESz1-0002r6-L4
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 23:38:00 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Nov 2017 15:37:46 +1100
Message-Id: <20171114043747.4810-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171114043747.4810-1-david@gibson.dropbear.id.au>
References: <20171114043747.4810-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/2] target/ppc: correct htab shift for hash on
 radix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

KVM HV will soon support running a guest in hash mode on a POWER9 host
running in radix mode (see [1]), however the guest currently fails to
boot.

This is because the "htab_shift" value (the size of the MMU's hash
table) is added to the device tree before KVM has had a chance to
change it. If the host is in hash mode, KVM does not need to change it
and so the problem is not seen, but when the host is in radix mode a
change is required and we see a problem.

To fix this, move the call spapr_setup_hpt_and_vrma() (where
htab_shift could be changed) up a little so that it's called before
spapr_h_cas_compose_response() (where htab_shift is added to the
device tree).

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

[1] See http://www.spinics.net/lists/kvm-ppc/msg13057.html
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d59d1534d..be22a6b289 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1636,6 +1636,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
+        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
+         * (because the guest isn't going to use radix) then set it up here. */
+        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
+            /* legacy hash or new hash: */
+            spapr_setup_hpt_and_vrma(spapr);
+        }
         spapr->cas_reboot =
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) != 0);
@@ -1644,13 +1650,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (spapr->cas_reboot) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    } else {
-        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
-         * (because the guest isn't going to use radix) then set it up here. */
-        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt_and_vrma(spapr);
-        }
     }
 
     return H_SUCCESS;
-- 
2.13.6
