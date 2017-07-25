Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47g-0001eV-Hp
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47d-0001Nw-Hh
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:56 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:55023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da47d-0001NH-B3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:53 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C38C01164EB
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:51 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:59:44 +0200
Message-ID: <150100558414.27487.6550654617210440325.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 08/26] spapr_drc: add unrealize method
 to physical DRC class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

When hot-unplugging a PHB, all its PCI DRC connectors get unrealized. This
patch adds an unrealize method to the physical DRC class, in order to undo
registrations performed in realize_physical().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index d72453bcb42f..105ce85b6d04 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -626,12 +626,28 @@ static void realize_physical(DeviceState *d, Error **errp)
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
