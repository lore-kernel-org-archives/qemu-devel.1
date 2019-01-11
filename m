Received: from eggs.gnu.org ([209.51.188.92]:49707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3wF-00051l-52
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3wE-0001rj-1v
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:59 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:45560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3wD-0001rH-Sp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:58 -0500
Received: from player730.ha.ovh.net (unknown [10.109.160.226])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 77F42E8FCF
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:01:56 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:01:35 +0100
Message-ID: <154724049571.525985.13385611401284661365.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 04/13] spapr: create DR connectors for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             |   13 +++++++++++++
 hw/ppc/spapr_drc.c         |   17 +++++++++++++++++
 include/hw/ppc/spapr.h     |    1 +
 include/hw/ppc/spapr_drc.h |    8 ++++++++
 4 files changed, 39 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 26f8e55cc25e..9eeb6792e261 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2797,6 +2797,19 @@ static void spapr_machine_init(MachineState *machine)
     /* We always have at least the nvram device on VIO */
     spapr_create_nvram(spapr);
 
+    /*
+     * Setup hotplug / dynamic-reconfiguration connectors. top-level
+     * connectors (described in root DT node's "ibm,drc-types" property)
+     * are pre-initialized here. additional child connectors (such as
+     * connectors for a PHBs PCI slots) are added as needed during their
+     * parent's realization.
+     */
+    if (smc->dr_phb_enabled) {
+        for (i = 0; i < SPAPR_MAX_PHBS; i++) {
+            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
+        }
+    }
+
     /* Set up PCI */
     spapr_pci_rtas_init();
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2edb7d1e9c8c..189ee681062a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -696,6 +696,15 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
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
@@ -739,6 +748,13 @@ static const TypeInfo spapr_drc_lmb_info = {
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
@@ -1189,6 +1205,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_cpu_info);
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
+    type_register_static(&spapr_drc_phb_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7193ce094689..4eb80c3d888c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -103,6 +103,7 @@ struct sPAPRMachineClass {
 
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
+    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f6ff32e7e2f2..56bba36ad4da 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -70,6 +70,14 @@
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
