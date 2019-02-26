Received: from eggs.gnu.org ([209.51.188.92]:58112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlH-0005PE-IM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlF-0002tl-H2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:43 +1100
Message-Id: <20190226045304.25618-30-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/50] spapr_drc: Allow FDT fragment to be added
 later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The current logic is to provide the FDT fragment when attaching a device
to a DRC. This works perfectly fine for our current hotplug support, but
soon we will add support for PHB hotplug which has some constraints, that
CPU, PCI and LMB devices don't seem to have.

The first constraint is that the "ibm,dma-window" property of the PHB
node requires the IOMMU to be configured, ie, spapr_tce_table_enable()
has been called, which happens during PHB reset. It is okay in the case
of hotplug since the device is reset before the hotplug handler is
called. On the contrary with coldplug, the hotplug handler is called
first and device is only reset during the initial system reset. Trying
to create the FDT fragment on the hotplug path in this case, would
result in somthing like this:

ibm,dma-window =3D < 0x80000000 0x00 0x00 0x00 0x00 >;

This will cause linux in the guest to panic, by simply removing and
re-adding the PHB using the drmgr command:

	page =3D alloc_pages_node(nid, GFP_KERNEL, get_order(sz));
	if (!page)
		panic("iommu_init_table: Can't allocate %ld bytes\n", sz);

The second and maybe more problematic constraint is that the
"interrupt-map" property needs to reference the interrupt controller
node using the very same phandle that SLOF has already exposed to the
guest. QEMU requires SLOF to call the private KVMPPC_H_UPDATE_DT hcall
at some point to know about this phandle. With the latest QEMU and SLOF,
this happens when SLOF gets quiesced. This means that if the PHB gets
hotplugged after CAS but before SLOF quiesce, then we're sure that the
phandle is not known when the hotplug handler is called.

The FDT is only needed when the guest first invokes RTAS to configure
the connector actually, long after SLOF quiesce. Let's postpone the
creation of FDT fragments for PHBs to rtas_ibm_configure_connector().

Since we only need this for PHBs, introduce a new method in the base
DRC class for that. DRC subtypes will be converted to use it in
subsequent patches.

Allow spapr_drc_attach() to be passed a NULL fdt argument if the method
is available. When all DRC subtypes have been converted, the fdt argument
will eventually disappear.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059665823.1466090.18358845122627355537.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 36 +++++++++++++++++++++++++++++++-----
 include/hw/ppc/spapr_drc.h |  6 ++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2edb7d1e9c..66b965a0a7 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callbac=
k */
+#include "sysemu/device_tree.h"
 #include "trace.h"
=20
 #define DRC_CONTAINER_PATH "/dr-connector"
@@ -376,6 +377,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                       int fdt_start_offset, Error **errp)
 {
+    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     trace_spapr_drc_attach(spapr_drc_index(drc));
=20
     if (drc->dev) {
@@ -384,11 +387,14 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Device=
State *d, void *fdt,
     }
     g_assert((drc->state =3D=3D SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state =3D=3D SPAPR_DRC_STATE_PHYSICAL_POWERON));
-    g_assert(fdt);
+    g_assert(fdt || drck->dt_populate);
=20
     drc->dev =3D d;
-    drc->fdt =3D fdt;
-    drc->fdt_start_offset =3D fdt_start_offset;
+
+    if (fdt) {
+        drc->fdt =3D fdt;
+        drc->fdt_start_offset =3D fdt_start_offset;
+    }
=20
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
@@ -1102,10 +1108,30 @@ static void rtas_ibm_configure_connector(PowerPCC=
PU *cpu,
         goto out;
     }
=20
-    g_assert(drc->fdt);
-
     drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
+    g_assert(drc->fdt || drck->dt_populate);
+
+    if (!drc->fdt) {
+        Error *local_err =3D NULL;
+        void *fdt;
+        int fdt_size;
+
+        fdt =3D create_device_tree(&fdt_size);
+
+        if (drck->dt_populate(drc, spapr, fdt, &drc->fdt_start_offset,
+                              &local_err)) {
+            g_free(fdt);
+            error_free(local_err);
+            rc =3D SPAPR_DR_CC_RESPONSE_ERROR;
+            goto out;
+        }
+
+        drc->fdt =3D fdt;
+        drc->ccs_offset =3D drc->fdt_start_offset;
+        drc->ccs_depth =3D 0;
+    }
+
     do {
         uint32_t tag;
         const char *name;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f6ff32e7e2..2aa919f0cf 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -18,6 +18,7 @@
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev.h"
+#include "qapi/error.h"
=20
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
 #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
@@ -213,6 +214,8 @@ typedef struct sPAPRDRConnector {
     int fdt_start_offset;
 } sPAPRDRConnector;
=20
+struct sPAPRMachineState;
+
 typedef struct sPAPRDRConnectorClass {
     /*< private >*/
     DeviceClass parent;
@@ -228,6 +231,9 @@ typedef struct sPAPRDRConnectorClass {
     uint32_t (*isolate)(sPAPRDRConnector *drc);
     uint32_t (*unisolate)(sPAPRDRConnector *drc);
     void (*release)(DeviceState *dev);
+
+    int (*dt_populate)(sPAPRDRConnector *drc, struct sPAPRMachineState *=
spapr,
+                       void *fdt, int *fdt_start_offset, Error **errp);
 } sPAPRDRConnectorClass;
=20
 typedef struct sPAPRDRCPhysical {
--=20
2.20.1
