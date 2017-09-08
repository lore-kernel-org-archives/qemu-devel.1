Received: from eggs.gnu.org ([2001:4830:134:3::10]:58624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe3-00026p-7G
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdy-0003CJ-Lk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:27 +1000
Message-Id: <20170908103558.31632-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/40] spapr_drc: add unrealize method to
 physical DRC class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When hot-unplugging a PHB, all its PCI DRC connectors get unrealized. This
patch adds an unrealize method to the physical DRC class, in order to undo
registrations performed in realize_physical().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 644a6fffaf..b10f849d37 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -630,12 +630,28 @@ static void realize_physical(DeviceState *d, Error **errp)
     qemu_register_reset(drc_physical_reset, drcp);
 }
 
+static void unrealize_physical(DeviceState *d, Error **errp)
+{
+    sPAPRDRCPhysical *drcp = SPAPR_DRC_PHYSICAL(d);
+    Error *local_err = NULL;
+
+    unrealize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    vmstate_unregister(DEVICE(drcp), &vmstate_spapr_drc_physical, drcp);
+    qemu_unregister_reset(drc_physical_reset, drcp);
+}
+
 static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     dk->realize = realize_physical;
+    dk->unrealize = unrealize_physical;
     drck->dr_entity_sense = physical_entity_sense;
     drck->isolate = drc_isolate_physical;
     drck->unisolate = drc_unisolate_physical;
-- 
2.13.5
