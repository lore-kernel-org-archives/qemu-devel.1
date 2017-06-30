Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRp-00006m-CR
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRm-0007z6-Mz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:30 +1000
Message-Id: <20170630104632.27942-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/21] spapr: Make DRC reset force DRC into
 known state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The reset handler for DRCs attempts several state transitions which are
subject to various checks and restrictions.  But at reset time we know
there is no guest, so we can ignore most of the usual sequencing rules and
just set the DRC back to a known state.  In fact, it's safer to do so.

The existing code also has several redundant checks for
drc->awaiting_release inside a block which has already tested that.  This
patch removes those and sets the DRC to a fixed initial state based only
on whether a device is currently plugged or not.

With DRCs correctly reset to a state based on device presence, we don't
need to force state transitions as cold plugged devices are processed.
This allows us to remove all the callers of the set_*_state() methods from
outside spapr_drc.c.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c     | 15 ---------------
 hw/ppc/spapr_drc.c | 35 ++++++++++++++++-------------------
 2 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3c12af0..0ee9fac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2636,12 +2636,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
 
         spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
-        if (!dev->hotplugged) {
-            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-            /* guests expect coldplugged LMBs to be pre-allocated */
-            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
-            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
-        }
     }
     /* send hotplug notification to the
      * guest only in case of hotplugged memory
@@ -3009,15 +3003,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
          * of hotplugged CPUs.
          */
         spapr_hotplug_req_add_by_index(drc);
-    } else {
-        /*
-         * Set the right DRC states for cold plugged CPU.
-         */
-        if (drc) {
-            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
-            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
-        }
     }
     core_slot->cpu = OBJECT(dev);
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 8a2b8f5..9a2511f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -378,7 +378,6 @@ static bool release_pending(sPAPRDRConnector *drc)
 static void reset(DeviceState *d)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
@@ -386,27 +385,25 @@ static void reset(DeviceState *d)
     drc->ccs = NULL;
 
     /* immediately upon reset we can safely assume DRCs whose devices
-     * are pending removal can be safely removed, and that they will
-     * subsequently be left in an ISOLATED state. move the DRC to this
-     * state in these cases (which will in turn complete any pending
-     * device removals)
+     * are pending removal can be safely removed.
      */
     if (drc->awaiting_release) {
-        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_ISOLATED);
-        /* generally this should also finalize the removal, but if the device
-         * hasn't yet been configured we normally defer removal under the
-         * assumption that this transition is taking place as part of device
-         * configuration. so check if we're still waiting after this, and
-         * force removal if we are
-         */
-        if (drc->awaiting_release) {
-            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
-        }
+        spapr_drc_release(drc);
+    }
+
+    drc->awaiting_allocation = false;
 
-        /* non-PCI devices may be awaiting a transition to UNUSABLE */
-        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
-            drc->awaiting_release) {
-            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UNUSABLE);
+    if (drc->dev) {
+        /* A device present at reset is coldplugged */
+        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
+        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
+            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
+        }
+    } else {
+        /* Otherwise device is absent, but might be hotplugged */
+        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
+        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
+            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
         }
     }
 }
-- 
2.9.4
