Received: from eggs.gnu.org ([209.51.188.92]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw928-0002J6-32
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw925-0007M7-Uw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51820
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw922-0007GH-Q3
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEHeb129181
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qrmd2dyna-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:06 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:18:04 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:58 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059667853.1466090.16527852453054217565.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 05/17] spapr/drc: Drop spapr_drc_attach()
 fdt argument
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

All DRC subtypes have been converted to generate the FDT fragment at
configure connector time instead of attach time. The fdt and fdt_offset
arguments of spapr_drc_attach() aren't needed anymore. Drop them and
make the implementation of the dt_populate() method mandatory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             |    4 ++--
 hw/ppc/spapr_drc.c         |   13 +------------
 hw/ppc/spapr_pci.c         |    2 +-
 include/hw/ppc/spapr_drc.h |    3 +--
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6cf7a9f5c1f2..9364d07364ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3362,7 +3362,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
-        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
+        spapr_drc_attach(drc, dev, &local_err);
         if (local_err) {
             while (addr > addr_start) {
                 addr -= SPAPR_MEMORY_BLOCK_SIZE;
@@ -3744,7 +3744,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
     if (drc) {
-        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
+        spapr_drc_attach(drc, dev, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 248eb8a93d6d..87ca7d973564 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -374,11 +374,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
     } while (fdt_depth != 0);
 }
 
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, Error **errp)
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
 {
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
     if (drc->dev) {
@@ -387,15 +384,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     }
     g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
-    g_assert(fdt || drck->dt_populate);
 
     drc->dev = d;
 
-    if (fdt) {
-        drc->fdt = fdt;
-        drc->fdt_start_offset = fdt_start_offset;
-    }
-
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
@@ -1113,8 +1104,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
-    g_assert(drc->fdt || drck->dt_populate);
-
     if (!drc->fdt) {
         Error *local_err = NULL;
         void *fdt;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b22c9f57b2dd..e2bc9fec824b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1457,7 +1457,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
         goto out;
     }
 
-    spapr_drc_attach(drc, DEVICE(pdev), NULL, 0, &local_err);
+    spapr_drc_attach(drc, DEVICE(pdev), &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 2aa919f0cfe5..f32758ec8487 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -261,8 +261,7 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
 
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, Error **errp);
+void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(sPAPRDRConnector *drc);
 bool spapr_drc_needed(void *opaque);
 
