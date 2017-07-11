Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxq-0002qC-Cf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxp-0007mX-BI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:08 +1000
Message-Id: <20170711043917.1757-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/17] spapr: Add DRC release method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

At the moment, spapr_drc_release() has an ugly switch on the DRC type to
call the right, device-specific release function.  This cleans it up by
doing that via a proper QOM method.

It's still arguably an abstraction violation for the DRC code to call into
the specific device code, but one mess at a time.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c         | 22 ++++++----------------
 include/hw/ppc/spapr_drc.h |  1 +
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index c831aa3..aa37a47 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -370,22 +370,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
 
 static void spapr_drc_release(sPAPRDRConnector *drc)
 {
-    /* Calling release callbacks based on spapr_drc_type(drc). */
-    switch (spapr_drc_type(drc)) {
-    case SPAPR_DR_CONNECTOR_TYPE_CPU:
-        spapr_core_release(drc->dev);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_PCI:
-        spapr_phb_remove_pci_device_cb(drc->dev);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        spapr_lmb_release(drc->dev);
-        break;
-    case SPAPR_DR_CONNECTOR_TYPE_PHB:
-    case SPAPR_DR_CONNECTOR_TYPE_VIO:
-    default:
-        g_assert(false);
-    }
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+
+    drck->release(drc->dev);
 
     drc->awaiting_release = false;
     g_free(drc->fdt);
@@ -631,6 +618,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
     drck->typename = "CPU";
     drck->drc_name_prefix = "CPU ";
+    drck->release = spapr_core_release;
 }
 
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
@@ -640,6 +628,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
     drck->typename = "28";
     drck->drc_name_prefix = "C";
+    drck->release = spapr_phb_remove_pci_device_cb;
 }
 
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
@@ -649,6 +638,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
     drck->typename = "MEM";
     drck->drc_name_prefix = "LMB ";
+    drck->release = spapr_lmb_release;
 }
 
 static const TypeInfo spapr_dr_connector_info = {
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index d9cacb3..6fd84d1 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -217,6 +217,7 @@ typedef struct sPAPRDRConnectorClass {
     sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
     uint32_t (*isolate)(sPAPRDRConnector *drc);
     uint32_t (*unisolate)(sPAPRDRConnector *drc);
+    void (*release)(DeviceState *dev);
 
     /* QEMU interfaces for managing hotplug operations */
     bool (*release_pending)(sPAPRDRConnector *drc);
-- 
2.9.4
