Received: from eggs.gnu.org ([2001:4830:134:3::10]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mAP-0000y1-1m
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d2mAL-0008IC-MA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39369
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d2mAL-0008Hc-GQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 18:09:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3OM3ufP127400
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:09:04 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1hwtf49p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:09:04 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 24 Apr 2017 19:09:02 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 24 Apr 2017 19:08:26 -0300
In-Reply-To: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
References: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20170424220828.1472-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/4] hw/ppc: migrating the DRC state of
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

The instance_id is used to identify objects in migration. We set
instance_id of DRC using the unique index so that it is the same
across migration.

In hw/ppc/spapr_pci.c, a function called spapr_pci_set_detach_cb
was created to set the detach_cb of the migrated DRC in the
spapr_pci_post_load. The reason is that detach_cb is a DRC function
pointer that can't be migrated but we need it set in the target
so a ongoing hot-unplug event can properly finish.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c | 22 ++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a1cdc87..5c2baad 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -651,6 +651,70 @@ static void spapr_dr_connector_instance_init(Object *obj)
                         NULL, NULL, NULL, NULL);
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
+/* return the unique drc index as instance_id for qom interfaces*/
+static int get_instance_id(DeviceState *dev)
+{
+    return (int)get_index(SPAPR_DR_CONNECTOR(OBJECT(dev)));
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
 static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
@@ -659,6 +723,8 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->reset = reset;
     dk->realize = realize;
     dk->unrealize = unrealize;
+    dk->vmsd = &vmstate_spapr_drc;
+    dk->dev_get_instance_id = get_instance_id;
     drck->set_isolation_state = set_isolation_state;
     drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
@@ -672,6 +738,7 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->detach = detach;
     drck->release_pending = release_pending;
     drck->set_signalled = set_signalled;
+
     /*
      * Reason: it crashes FIXME find and document the real reason
      */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e4..639dad2 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1922,12 +1922,34 @@ static void spapr_pci_pre_save(void *opaque)
     }
 }
 
+/*
+ * detach_cb in the DRC state is a function pointer that cannot be
+ * migrated. We set it right after migration so that a migrated
+ * hot-unplug event could finish its work.
+ */
+static void spapr_pci_set_detach_cb(PCIBus *bus, PCIDevice *pdev,
+                                 void *opaque)
+{
+    sPAPRPHBState *sphb = opaque;
+    sPAPRDRConnector *drc = spapr_phb_get_pci_drc(sphb, pdev);
+    drc->detach_cb = spapr_phb_remove_pci_device_cb;
+}
+
 static int spapr_pci_post_load(void *opaque, int version_id)
 {
     sPAPRPHBState *sphb = opaque;
     gpointer key, value;
     int i;
 
+    PCIBus *bus = PCI_HOST_BRIDGE(sphb)->bus;
+    unsigned int bus_no = 0;
+
+    /* Set detach_cb for the drc unconditionally after migration */
+    if (bus) {
+        pci_for_each_device(bus, pci_bus_num(bus), spapr_pci_set_detach_cb,
+                            &bus_no);
+    }
+
     for (i = 0; i < sphb->msi_devs_num; ++i) {
         key = g_memdup(&sphb->msi_devs[i].key,
                        sizeof(sphb->msi_devs[i].key));
-- 
2.9.3
