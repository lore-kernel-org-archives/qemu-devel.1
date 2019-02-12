Received: from eggs.gnu.org ([209.51.188.92]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtck0-0001P7-7g
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjy-0004Gg-As
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcjw-0003cG-BX
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJp8F136922
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:49 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm0m78bka-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:49 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:46 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:24:39 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154999587949.690774.5181981860272429438.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v4 07/15] spapr: create DR connectors for PHBs
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
index 850cfe28c414..590c67805e52 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2796,6 +2796,19 @@ static void spapr_machine_init(MachineState *machine)
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
index cbd276ed2b6a..a3074e7fea37 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -104,6 +104,7 @@ struct sPAPRMachineClass {
 
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
