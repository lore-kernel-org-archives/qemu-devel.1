Received: from eggs.gnu.org ([209.51.188.92]:33451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw926-0002IO-5O
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw922-0007If-7f
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43364
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw91y-0006r7-9s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEI0N129297
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qrmd2dxv8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:17:44 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:38 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059665823.1466090.18358845122627355537.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 01/17] spapr_drc: Allow FDT fragment to be
 added later
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

ibm,dma-window = < 0x80000000 0x00 0x00 0x00 0x00 >;

This will cause linux in the guest to panic, by simply removing and
re-adding the PHB using the drmgr command:

	page = alloc_pages_node(nid, GFP_KERNEL, get_order(sz));
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
---
v5: - pass drc to callback (needed for LMBs, in order to derive the addr
      from the DRC index)
---
 hw/ppc/spapr_drc.c         |   36 +++++++++++++++++++++++++++++++-----
 include/hw/ppc/spapr_drc.h |    6 ++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2edb7d1e9c8c..66b965a0a7c2 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
+#include "sysemu/device_tree.h"
 #include "trace.h"
 
 #define DRC_CONTAINER_PATH "/dr-connector"
@@ -376,6 +377,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                       int fdt_start_offset, Error **errp)
 {
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
     if (drc->dev) {
@@ -384,11 +387,14 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     }
     g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
-    g_assert(fdt);
+    g_assert(fdt || drck->dt_populate);
 
     drc->dev = d;
-    drc->fdt = fdt;
-    drc->fdt_start_offset = fdt_start_offset;
+
+    if (fdt) {
+        drc->fdt = fdt;
+        drc->fdt_start_offset = fdt_start_offset;
+    }
 
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
@@ -1102,10 +1108,30 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         goto out;
     }
 
-    g_assert(drc->fdt);
-
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
+    g_assert(drc->fdt || drck->dt_populate);
+
+    if (!drc->fdt) {
+        Error *local_err = NULL;
+        void *fdt;
+        int fdt_size;
+
+        fdt = create_device_tree(&fdt_size);
+
+        if (drck->dt_populate(drc, spapr, fdt, &drc->fdt_start_offset,
+                              &local_err)) {
+            g_free(fdt);
+            error_free(local_err);
+            rc = SPAPR_DR_CC_RESPONSE_ERROR;
+            goto out;
+        }
+
+        drc->fdt = fdt;
+        drc->ccs_offset = drc->fdt_start_offset;
+        drc->ccs_depth = 0;
+    }
+
     do {
         uint32_t tag;
         const char *name;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f6ff32e7e2f2..2aa919f0cfe5 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -18,6 +18,7 @@
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev.h"
+#include "qapi/error.h"
 
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
 #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
@@ -213,6 +214,8 @@ typedef struct sPAPRDRConnector {
     int fdt_start_offset;
 } sPAPRDRConnector;
 
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
+    int (*dt_populate)(sPAPRDRConnector *drc, struct sPAPRMachineState *spapr,
+                       void *fdt, int *fdt_start_offset, Error **errp);
 } sPAPRDRConnectorClass;
 
 typedef struct sPAPRDRCPhysical {
