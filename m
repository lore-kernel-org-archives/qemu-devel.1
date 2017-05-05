Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k99-0004xb-H6
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6k95-0006Tb-0B
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57317
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6k94-0006TH-QG
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:48:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45KhjFr118970
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 16:48:10 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8yhsjsnx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:48:09 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 May 2017 17:48:07 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 17:47:43 -0300
In-Reply-To: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170505204746.14116-4-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 3/6] hw/ppc: migrating the DRC state of
 hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

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
---
 hw/ppc/spapr_drc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1c72160..926b945 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -519,6 +519,65 @@ static void reset(DeviceState *d)
     }
 }
 
+static bool spapr_drc_needed(void *opaque)
+{
+    sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    bool rc = false;
+    sPAPRDREntitySense value;
+    drck->entity_sense(drc, &value);
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
+
+    case SPAPR_DR_CONNECTOR_TYPE_PCI:
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
+               drc->configured && drc->signalled && !drc->awaiting_release);
+        break;
+
+    case SPAPR_DR_CONNECTOR_TYPE_LMB:
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) &&
+               drc->configured && drc->signalled && !drc->awaiting_release);
+        break;
+
+    case SPAPR_DR_CONNECTOR_TYPE_CPU:
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) &&
+                drc->configured && drc->signalled && !drc->awaiting_release);
+        break;
+
+    default:
+        ;
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
@@ -547,6 +606,8 @@ static void realize(DeviceState *d, Error **errp)
         object_unref(OBJECT(drc));
     }
     g_free(child_name);
+    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
+                     drc);
     trace_spapr_drc_realize_complete(drck->get_index(drc));
 }
 
-- 
2.9.3
