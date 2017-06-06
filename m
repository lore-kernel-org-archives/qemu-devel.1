Received: from eggs.gnu.org ([2001:4830:134:3::10]:55005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9ul-0003Ow-8e
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9uf-00021O-LM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 18:32:18 +1000
Message-Id: <20170606083221.9299-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170606083221.9299-1-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 4/7] spapr: Don't misuse DR-indicator in
 spapr_recover_pending_dimm_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

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
---
 hw/ppc/spapr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 671cdbb..e8cecaf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2683,7 +2683,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineState *ms,
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
-        if (drc->indicator_state != SPAPR_DR_INDICATOR_STATE_INACTIVE) {
+        if (drc->dev) {
             avail_lmbs++;
         }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
@@ -2707,10 +2707,11 @@ void spapr_lmb_release(DeviceState *dev)
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
