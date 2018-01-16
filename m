Received: from eggs.gnu.org ([2001:4830:134:3::10]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9j-0007zB-7q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9g-0004mV-5H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jan 2018 15:47:13 +1100
Message-Id: <20180116044714.12571-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180116044714.12571-1-david@gibson.dropbear.id.au>
References: <20180116044714.12571-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 1/2] spapr: Allow some cases where we can't
 set VSMT mode in the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

At present if we require a vsmt mode that's not equal to the kernel's
default, and the kernel doesn't let us change it (e.g. because it's an old
kernel without support) then we always fail.

But in fact we can cope with the kernel having a different vsmt as long as
  a) it's >= the actual number of vthreads/vcore (so that guest threads
     that are supposed to be on the same core act like it)
  b) it's a submultiple of the requested vsmt mode (so that guest threads
     spaced by the vsmt value will act like they're on different cores)

Allowing this case gives us a bit more freedom to adjust the vsmt behaviour
without breaking existing cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e35214bfc3..6d3613d934 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2314,17 +2314,29 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
     if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
         ret = kvmppc_set_smt_threads(spapr->vsmt);
         if (ret) {
+            /* Looks like KVM isn't able to change VSMT mode */
             error_setg(&local_err,
                        "Failed to set KVM's VSMT mode to %d (errno %d)",
                        spapr->vsmt, ret);
-            if (!vsmt_user) {
-                error_append_hint(&local_err, "On PPC, a VM with %d threads/"
-                             "core on a host with %d threads/core requires "
-                             " the use of VSMT mode %d.\n",
-                             smp_threads, kvm_smt, spapr->vsmt);
+            /* We can live with that if the default one is big enough
+             * for the number of threads, and a submultiple of the one
+             * we want.  In this case we'll waste some vcpu ids, but
+             * behaviour will be correct */
+            if ((kvm_smt >= smp_threads) && (spapr->vsmt % kvm_smt) == 0) {
+                warn_report_err(local_err);
+                local_err = NULL;
+                goto out;
+            } else {
+                if (!vsmt_user) {
+                    error_append_hint(&local_err,
+                                      "On PPC, a VM with %d threads/core"
+                                      " on a host with %d threads/core"
+                                      " requires the use of VSMT mode %d.\n",
+                                      smp_threads, kvm_smt, spapr->vsmt);
+                }
+                kvmppc_hint_smt_possible(&local_err);
+                goto out;
             }
-            kvmppc_hint_smt_possible(&local_err);
-            goto out;
         }
     }
     /* else TCG: nothing to do currently */
-- 
2.14.3
