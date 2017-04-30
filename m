Received: from eggs.gnu.org ([2001:4830:134:3::10]:36648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d4sbv-0005NZ-MQ
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d4sbu-0005uV-8z
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45054
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d4sbu-0005ty-3A
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 13:26:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3UHNfeN027614
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 13:26:13 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a5m2q8avd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 13:26:13 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Sun, 30 Apr 2017 14:26:11 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Sun, 30 Apr 2017 14:25:45 -0300
In-Reply-To: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170430172547.13415-4-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/5] hw/ppc: migrating the DRC state of
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

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

- 'isolation_state', 'allocation_state' and 'configured' are involved
in the DR state transition diagram from PAPR+ 2.7, 13.4;

- 'configured' and 'signalled' are needed in attaching and detaching
devices;

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
index 6f98242..0da5f02 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -506,6 +506,64 @@ static void reset(DeviceState *d)
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
+        VMSTATE_BOOL(signalled, sPAPRDRConnector),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
@@ -534,6 +592,8 @@ static void realize(DeviceState *d, Error **errp)
         object_unref(OBJECT(drc));
     }
     g_free(child_name);
+    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_drc,
+                     drc);
     trace_spapr_drc_realize_complete(drck->get_index(drc));
 }
 
@@ -652,6 +712,7 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->reset = reset;
     dk->realize = realize;
     dk->unrealize = unrealize;
+    dk->vmsd = &vmstate_spapr_drc;
     drck->set_isolation_state = set_isolation_state;
     drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
-- 
2.9.3
