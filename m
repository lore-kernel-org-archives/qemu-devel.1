Received: from eggs.gnu.org ([209.51.188.92]:33524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw928-0002JM-4d
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw920-0007Gm-6s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw91y-0006yP-5h
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHENSL132123
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:53 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrn0bumpv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:52 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:17:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:43 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059666331.1466090.6766540766297333313.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 02/17] spapr: Generate FDT fragment for LMBs
 at configure connector time
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

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   33 ++++++++++++++++++---------------
 hw/ppc/spapr_drc.c     |    1 +
 include/hw/ppc/spapr.h |    4 +++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 00eb3b643c03..b92deee771b9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3333,14 +3333,26 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp)
+{
+    uint64_t addr;
+    uint32_t node;
+
+    addr = spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
+    node = object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PROP,
+                                    &error_abort);
+    *fdt_start_offset = spapr_populate_memory_node(fdt, node, addr,
+                                                   SPAPR_MEMORY_BLOCK_SIZE);
+    return 0;
+}
+
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
-                           uint32_t node, bool dedicated_hp_event_source,
-                           Error **errp)
+                           bool dedicated_hp_event_source, Error **errp)
 {
     sPAPRDRConnector *drc;
     uint32_t nr_lmbs = size/SPAPR_MEMORY_BLOCK_SIZE;
-    int i, fdt_offset, fdt_size;
-    void *fdt;
+    int i;
     uint64_t addr = addr_start;
     bool hotplugged = spapr_drc_hotplugged(dev);
     Error *local_err = NULL;
@@ -3350,11 +3362,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
-        fdt = create_device_tree(&fdt_size);
-        fdt_offset = spapr_populate_memory_node(fdt, node, addr,
-                                                SPAPR_MEMORY_BLOCK_SIZE);
-
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        spapr_drc_attach(drc, dev, NULL, 0, &local_err);
         if (local_err) {
             while (addr > addr_start) {
                 addr -= SPAPR_MEMORY_BLOCK_SIZE;
@@ -3362,7 +3370,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            g_free(fdt);
             error_propagate(errp, local_err);
             return;
         }
@@ -3395,7 +3402,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     uint64_t size, addr;
-    uint32_t node;
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
 
@@ -3410,10 +3416,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out_unplug;
     }
 
-    node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
-                                    &error_abort);
-    spapr_add_lmbs(dev, addr, size, node,
-                   spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
+    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
                    &local_err);
     if (local_err) {
         goto out_unplug;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 66b965a0a7c2..634c28695a1c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -700,6 +700,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
     drck->typename = "MEM";
     drck->drc_name_prefix = "LMB ";
     drck->release = spapr_lmb_release;
+    drck->dt_populate = spapr_lmb_dt_populate;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 659204ea93f0..0ec309da497e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -764,9 +764,11 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
 void spapr_clear_pending_events(sPAPRMachineState *spapr);
 int spapr_max_server_number(sPAPRMachineState *spapr);
 
-/* CPU and LMB DRC release callbacks. */
+/* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
 void spapr_lmb_release(DeviceState *dev);
+int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp);
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
