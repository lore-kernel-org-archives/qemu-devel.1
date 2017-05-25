Received: from eggs.gnu.org ([2001:4830:134:3::10]:57455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoT-0006Zd-GF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0007Wv-M0
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:30 +1000
Message-Id: <20170525035132.24268-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/18] hw/ppc: migrating the DRC state of
 hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

In pseries, a firmware abstraction called Dynamic Reconfiguration
Connector (DRC) is used to assign a particular dynamic resource
to the guest and provide an interface to manage configuration/removal
of the resource associated with it. In other words, DRC is the
'plugged state' of a device.

Before this patch, DRC wasn't being migrated. This causes
post-migration problems due to DRC state mismatch between source and
target. The DRC state of a device X in the source might
change, while in the target the DRC state of X is still fresh. When
migrating the guest, X will not have the same hotplugged state as it
did in the source. This means that we can't hot unplug X in the
target after migration is completed because its DRC state is not consistent.
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1677552 is one
bug that is caused by this DRC state mismatch between source and
target.

To migrate the DRC state, we defined the VMStateDescription struct for
spapr_drc to enable the transmission of spapr_drc state in migration.
Not all the elements in the DRC state are migrated - only those
that can be modified by guest actions or device add/remove
operations:

- 'isolation_state', 'allocation_state' and 'indicator_state'
are involved in the DR state transition diagram from
PAPR+ 2.7, 13.4;

- 'configured', 'signalled', 'awaiting_release' and 'awaiting_allocation'
are needed in attaching and detaching devices;

- 'indicator_state' provides users with hardware state information.

These are the DRC elements that are migrated.

In this patch the DRC state is migrated for PCI, LMB and CPU
connector types. At this moment there is no support to migrate
DRC for the PHB (PCI Host Bridge) type.

In the 'realize' function the DRC is registered using vmstate_register,
similar to what hw/ppc/spapr_iommu.c does in 'spapr_tce_table_realize'.
This approach works because  DRCs are bus-less and do not sit
on a BusClass that implements bc->get_dev_path, so as a fallback the
VMSD gets identified via "spapr_drc"/get_index(drc).

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2851e16..cc2400b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -519,6 +519,60 @@ static void reset(DeviceState *d)
     }
 }
 
+static bool spapr_drc_needed(void *opaque)
+{
+    sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    bool rc = false;
+    sPAPRDREntitySense value;
+    drck->entity_sense(drc, &value);
+
+    /* If no dev is plugged in there is no need to migrate the DRC state */
+    if (value != SPAPR_DR_ENTITY_SENSE_PRESENT) {
+        return false;
+    }
+
+    /*
+     * If there is dev plugged in, we need to migrate the DRC state when
+     * it is different from cold-plugged state
+     */
+    switch (drc->type) {
+    case SPAPR_DR_CONNECTOR_TYPE_PCI:
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
+               drc->configured && drc->signalled && !drc->awaiting_release);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_CPU:
+    case SPAPR_DR_CONNECTOR_TYPE_LMB:
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) &&
+               drc->configured && drc->signalled && !drc->awaiting_release);
+        break;
+    case SPAPR_DR_CONNECTOR_TYPE_PHB:
+    case SPAPR_DR_CONNECTOR_TYPE_VIO:
+    default:
+        g_assert(false);
+    }
+    return rc;
+}
+
+static const VMStateDescription vmstate_spapr_drc = {
+    .name = "spapr_drc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_drc_needed,
+    .fields  = (VMStateField []) {
+        VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
+        VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
+        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
+        VMSTATE_BOOL(configured, sPAPRDRConnector),
+        VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
+        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
+        VMSTATE_BOOL(signalled, sPAPRDRConnector),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
@@ -547,6 +601,8 @@ static void realize(DeviceState *d, Error **errp)
         object_unref(OBJECT(drc));
     }
     g_free(child_name);
+    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
+                     drc);
     trace_spapr_drc_realize_complete(drck->get_index(drc));
 }
 
-- 
2.9.4
