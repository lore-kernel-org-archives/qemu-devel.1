Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49j-0003WV-6u
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49g-0003Fc-52
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:03 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:56356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da49f-0003Dx-VJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:00 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7BA6E11667B
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:01:58 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:01:50 +0200
Message-ID: <150100571083.27487.4628655387393519076.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 18/26] spapr: create DR connectors for
 PHBs
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

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10 (reset hooks registering already merged)
- added new DRC type for PHB
---
 hw/ppc/spapr.c             |   15 +++++++++++++++
 hw/ppc/spapr_drc.c         |   17 +++++++++++++++++
 include/hw/ppc/spapr_drc.h |    8 ++++++++
 3 files changed, 40 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8dc505343c0f..5950c009ab7e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -98,6 +98,9 @@
 
 #define PHANDLE_XICP            0x00001111
 
+/* maximum number of hotpluggable PHBs */
+#define SPAPR_DRC_MAX_PHB       256
+
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
                                   const char *type_ics,
                                   int nr_irqs, Error **errp)
@@ -2384,6 +2387,18 @@ static void ppc_spapr_init(MachineState *machine)
 
     spapr->dr_phb_enabled = smc->dr_phb_enabled;
 
+    /* Setup hotplug / dynamic-reconfiguration connectors. top-level
+     * connectors (described in root DT node's "ibm,drc-types" property)
+     * are pre-initialized here. additional child connectors (such as
+     * connectors for a PHBs PCI slots) are added as needed during their
+     * parent's realization.
+     */
+    if (spapr->dr_phb_enabled) {
+        for (i = 0; i < SPAPR_DRC_MAX_PHB; i++) {
+            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
+        }
+    }
+
     /* Set up PCI */
     spapr_pci_rtas_init();
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index eb8024d37c54..2e1049ce61c7 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -697,6 +697,15 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
     drck->release = spapr_lmb_release;
 }
 
+static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
+    drck->typename = "PHB";
+    drck->drc_name_prefix = "PHB ";
+}
+
 static const TypeInfo spapr_dr_connector_info = {
     .name          = TYPE_SPAPR_DR_CONNECTOR,
     .parent        = TYPE_DEVICE,
@@ -740,6 +749,13 @@ static const TypeInfo spapr_drc_lmb_info = {
     .class_init    = spapr_drc_lmb_class_init,
 };
 
+static const TypeInfo spapr_drc_phb_info = {
+    .name          = TYPE_SPAPR_DRC_PHB,
+    .parent        = TYPE_SPAPR_DRC_LOGICAL,
+    .instance_size = sizeof(sPAPRDRConnector),
+    .class_init    = spapr_drc_phb_class_init,
+};
+
 /* helper functions for external users */
 
 sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
@@ -1179,6 +1195,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_cpu_info);
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
+    type_register_static(&spapr_drc_phb_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index a7958d0a8d14..535fc61b98a8 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -69,6 +69,14 @@
 #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
                                         TYPE_SPAPR_DRC_LMB)
 
+#define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
+#define SPAPR_DRC_PHB_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHB)
+#define SPAPR_DRC_PHB_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_PHB)
+#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                        TYPE_SPAPR_DRC_PHB)
+
 /*
  * Various hotplug types managed by sPAPRDRConnector
  *
