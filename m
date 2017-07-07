Received: from eggs.gnu.org ([2001:4830:134:3::10]:39194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTagQ-0003U5-HX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTagM-0002V5-8r
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:21:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33678
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dTagL-0002UM-Oe
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 17:20:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67LDf3h114023
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 17:20:56 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bjhr6gp12-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 17:20:56 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 7 Jul 2017 18:20:54 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  7 Jul 2017 18:20:37 -0300
Message-Id: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC drcVI PATCH] spapr: reset DRCs on migration
 pre_load
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

"spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
was originally was being used to prevent a race condition between
hot unplug and hotplug. The DRC code base got simplified and more
robust over time, eliminating the conditions that led to this race.
Thus the awaiting_allocation existence wasn't justifiable anymore.

A side effect of the flag removal was seen when testing the Libvirt
hotplug-migration-unplug scenario, where a device is hotplugged in both
source and target using device_add prior to the migration, then the
device is removed after migration in the target. Before that cleanup, the
hot unplug at the target fails in both QEMU and guest kernel because
the DRC state at the target is inconsistent. After removing that flag,
the hot unplug works at QEMU but the guest kernel hungs on the middle
of the unplug process.

It turns out that the awaiting_allocation logic was preventing the hot
unplug from happening at the target because the DRC state, at this specific
hot unplug scenario, was matching the race condition the flag was
originally designed to avoid. Removing the flag allowed the device
to be removed from QEMU, leading to this new behavior.

The root cause of those problems is, in fact, the inconsistent state of the
target DRCs after migration is completed. Doing device_add in the
INMIGRATE status leaves the DRC in a state that isn't recognized as a
valid hotplugged device in the guest OS.

This patch fixes the problem by using the recently modified 'drc_reset'
function, that now forces the DRC to a known state by checking its device
status, to reset all DRCs in the pre_load hook of the migration. Resetting
the DRCs in pre_load allows the DRCs to be in a predictable state when
we load the migration at the target, allowing for hot unplugs to work
as expected.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c             |  7 +++++++
 hw/ppc/spapr_drc.c         | 17 +++++++++++++++++
 include/hw/ppc/spapr_drc.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 089d41d..aea85b0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1473,6 +1473,12 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
     }
 }
 
+static int spapr_pre_load(void *opaque)
+{
+    spapr_reset_all_drcs();
+    return 0;
+}
+
 static int spapr_post_load(void *opaque, int version_id)
 {
     sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
@@ -1598,6 +1604,7 @@ static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
     .minimum_version_id = 1,
+    .pre_load = spapr_pre_load,
     .post_load = spapr_post_load,
     .fields = (VMStateField[]) {
         /* used to be @next_irq */
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 63637d8..74f3957 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -449,6 +449,23 @@ static void drc_reset(void *opaque)
     drc->ccs_depth = -1;
 }
 
+void spapr_reset_all_drcs(void)
+{
+    Object *drc_container, *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+
+    drc_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    object_property_iter_init(&iter, drc_container);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (!strstart(prop->type, "link<", NULL)) {
+            continue;
+        }
+        obj = object_property_get_link(drc_container, prop->name, NULL);
+        drc_reset(SPAPR_DR_CONNECTOR(obj));
+    }
+}
+
 static bool spapr_drc_needed(void *opaque)
 {
     sPAPRDRConnector *drc = (sPAPRDRConnector *)opaque;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 4c54864..c7553e6 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -250,4 +250,5 @@ static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
     return drc->unplug_requested;
 }
 
+void spapr_reset_all_drcs(void);
 #endif /* HW_SPAPR_DRC_H */
-- 
2.9.4
