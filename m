Received: from eggs.gnu.org ([2001:4830:134:3::10]:47000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRx-0003vp-0I
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRv-0006dS-KB
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:38 +1000
Message-Id: <20170609052652.23200-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/20] spapr: Don't misuse DR-indicator in
 spapr_recover_pending_dimm_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, David Gibson <david@gibson.dropbear.id.au>

With some combinations of migration and hotplug we can lost temporary state
indicating how many DRCs (guest side hotplug handles) are still connected
to a DIMM object in the process of removal.  When we hit that situation
spapr_recover_pending_dimm_state() is used to scan more extensively and
work out the right number.

It does this using drc->indicator state to determine what state of
disconnection the DRC is in.  However, this is not safe, because the
indicator state is guest settable - in fact it's more-or-less a purely
guest->host notification mechanism which should have no bearing on the
internals of hotplug state management.

So, replace the test for this with a test on drc->dev, which is a purely
qemu side managed variable, and updated the same BQL critical section as
the indicator state.

This does introduce an off-by-one change, because the indicator state was
updated before the call to spapr_lmb_release() on the current DRC, whereas
drc->dev is updated afterwards.  That's corrected by always decrementing
the nr_lmbs value instead of only doing so in the case where we didn't
have to recover information.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9b7ae28..b2311dc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2676,7 +2676,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
-        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
+        if (drc->dev) {
             avail_lmbs++;
         }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
@@ -2700,10 +2700,11 @@ void spapr_lmb_release(DeviceState *dev)
      * during the unplug process. In this case recover it. */
     if (ds == NULL) {
         ds = spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
-        if (ds->nr_lmbs) {
-            return;
-        }
-    } else if (--ds->nr_lmbs) {
+        /* The DRC being examined by the caller at least must be counted */
+        g_assert(ds->nr_lmbs);
+    }
+
+    if (--ds->nr_lmbs) {
         return;
     }
 
-- 
2.9.4
