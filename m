Received: from eggs.gnu.org ([209.51.188.92]:58206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlL-0005TS-7T
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlJ-0002we-Ea
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:52 +1100
Message-Id: <20190226045304.25618-39-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/50] spapr: create DR connectors for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059670389.1466090.10015601248906623076.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 13 +++++++++++++
 hw/ppc/spapr_drc.c         | 17 +++++++++++++++++
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_drc.h |  8 ++++++++
 4 files changed, 39 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9364d07364..96bea7580a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2875,6 +2875,19 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* We always have at least the nvram device on VIO */
     spapr_create_nvram(spapr);
=20
+    /*
+     * Setup hotplug / dynamic-reconfiguration connectors. top-level
+     * connectors (described in root DT node's "ibm,drc-types" property)
+     * are pre-initialized here. additional child connectors (such as
+     * connectors for a PHBs PCI slots) are added as needed during their
+     * parent's realization.
+     */
+    if (smc->dr_phb_enabled) {
+        for (i =3D 0; i < SPAPR_MAX_PHBS; i++) {
+            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, =
i);
+        }
+    }
+
     /* Set up PCI */
     spapr_pci_rtas_init();
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 87ca7d9735..fd6380adb3 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -696,6 +696,15 @@ static void spapr_drc_lmb_class_init(ObjectClass *k,=
 void *data)
     drck->dt_populate =3D spapr_lmb_dt_populate;
 }
=20
+static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
+{
+    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
+    drck->typename =3D "PHB";
+    drck->drc_name_prefix =3D "PHB ";
+}
+
 static const TypeInfo spapr_dr_connector_info =3D {
     .name          =3D TYPE_SPAPR_DR_CONNECTOR,
     .parent        =3D TYPE_DEVICE,
@@ -739,6 +748,13 @@ static const TypeInfo spapr_drc_lmb_info =3D {
     .class_init    =3D spapr_drc_lmb_class_init,
 };
=20
+static const TypeInfo spapr_drc_phb_info =3D {
+    .name          =3D TYPE_SPAPR_DRC_PHB,
+    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
+    .instance_size =3D sizeof(sPAPRDRConnector),
+    .class_init    =3D spapr_drc_phb_class_init,
+};
+
 /* helper functions for external users */
=20
 sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
@@ -1207,6 +1223,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_cpu_info);
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
+    type_register_static(&spapr_drc_phb_info);
=20
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5e3c760725..b173fd7149 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -104,6 +104,7 @@ struct sPAPRMachineClass {
=20
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
+    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHB=
s */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f32758ec84..46b0f6216d 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -71,6 +71,14 @@
 #define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
                                         TYPE_SPAPR_DRC_LMB)
=20
+#define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
+#define SPAPR_DRC_PHB_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHB)
+#define SPAPR_DRC_PHB_CLASS(klass) \
+        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
PHB)
+#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+                                        TYPE_SPAPR_DRC_PHB)
+
 /*
  * Various hotplug types managed by sPAPRDRConnector
  *
--=20
2.20.1
