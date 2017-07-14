Received: from eggs.gnu.org ([2001:4830:134:3::10]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt0-00014x-VR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtsx-00025q-Ni
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:07 +1000
Message-Id: <20170714061521.28300-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/18] spapr: Remove 'awaiting_allocation' DRC
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The awaiting_allocation flag in the DRC was introduced by aab9913
"spapr_drc: Prevent detach racing against attach for CPU DR", allegedly to
prevent a guest crash on racing attach and detach.  Except.. information
from the BZ actually suggests a qemu crash, not a guest crash.  And there
shouldn't be a problem here anyway: if the guest has already moved the DRC
away from UNUSABLE state, the detach would already be deferred, and if it
hadn't it should be safe to detach it (the guest should fail gracefully
when it attempts to change the allocation state).

I think this was probably just a bandaid for some other problem in the
state management.  So, remove awaiting_allocation and associated code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 25 +++----------------------
 include/hw/ppc/spapr_drc.h |  1 -
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9b07f80bf4..89ba3d6b79 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -170,19 +170,13 @@ static uint32_t drc_set_usable(sPAPRDRConnector *drc)
     if (!drc->dev) {
         return RTAS_OUT_NO_SUCH_INDICATOR;
     }
-    if (drc->awaiting_release && drc->awaiting_allocation) {
-        /* kernel is acknowledging a previous hotplug event
-         * while we are already removing it.
-         * it's safe to ignore awaiting_allocation here since we know the
-         * situation is predicated on the guest either already having done
-         * so (boot-time hotplug), or never being able to acquire in the
-         * first place (hotplug followed by immediate unplug).
-         */
+    if (drc->awaiting_release) {
+        /* Don't allow the guest to move a device away from UNUSABLE
+         * state when we want to unplug it */
         return RTAS_OUT_NO_SUCH_INDICATOR;
     }
 
     drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
-    drc->awaiting_allocation = false;
 
     return RTAS_OUT_SUCCESS;
 }
@@ -357,10 +351,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     drc->fdt = fdt;
     drc->fdt_start_offset = fdt_start_offset;
 
-    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-        drc->awaiting_allocation = true;
-    }
-
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
@@ -398,12 +388,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
         return;
     }
 
-    if (drc->awaiting_allocation) {
-        drc->awaiting_release = true;
-        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
-        return;
-    }
-
     spapr_drc_release(drc);
 }
 
@@ -426,8 +410,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
         spapr_drc_release(drc);
     }
 
-    drc->awaiting_allocation = false;
-
     if (drc->dev) {
         /* A device present at reset is coldplugged */
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
@@ -493,7 +475,6 @@ static const VMStateDescription vmstate_spapr_drc = {
         VMSTATE_UINT32(dr_indicator, sPAPRDRConnector),
         VMSTATE_BOOL(configured, sPAPRDRConnector),
         VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
-        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 715016b052..18a196e831 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
     sPAPRConfigureConnectorState *ccs;
 
     bool awaiting_release;
-    bool awaiting_allocation;
 
     /* device pointer, via link property */
     DeviceState *dev;
-- 
2.13.0
