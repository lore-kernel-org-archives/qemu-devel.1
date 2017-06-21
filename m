Received: from eggs.gnu.org ([2001:4830:134:3::10]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmw-0003DB-IT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmt-0001yC-Bp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 21 Jun 2017 17:18:45 +0800
Message-Id: <20170621091848.28256-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170621091848.28256-1-david@gibson.dropbear.id.au>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/5] spapr: Refactor spapr_drc_detach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, groug@kaod.org, sursingh@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This function has two unused parameters - remove them.

It also sets awaiting_release on all paths, except one.  On that path
setting it is harmless, since it will be immediately cleared by
spapr_drc_release().  So factor it out of the if statements.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  9 ++-------
 hw/ppc/spapr_drc.c         | 12 ++++++------
 hw/ppc/spapr_pci.c         |  7 +------
 include/hw/ppc/spapr_drc.h |  2 +-
 4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5aa3760..8b5ab3a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2827,7 +2827,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
-        spapr_drc_detach(drc, dev, errp);
+        spapr_drc_detach(drc);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
 
@@ -2902,7 +2902,6 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     int index;
     sPAPRDRConnector *drc;
-    Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     int smt = kvmppc_smt_threads();
 
@@ -2919,11 +2918,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
     g_assert(drc);
 
-    spapr_drc_detach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    spapr_drc_detach(drc);
 
     spapr_hotplug_req_remove_by_index(drc);
 }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 59e19f8..dae1f79 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -70,7 +70,7 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
         uint32_t drc_index = spapr_drc_index(drc);
         if (drc->configured) {
             trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
+            spapr_drc_detach(drc);
         } else {
             trace_spapr_drc_set_isolation_state_deferring(drc_index);
         }
@@ -134,7 +134,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
         uint32_t drc_index = spapr_drc_index(drc);
         if (drc->configured) {
             trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
+            spapr_drc_detach(drc);
         } else {
             trace_spapr_drc_set_isolation_state_deferring(drc_index);
         }
@@ -187,7 +187,7 @@ static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
     if (drc->awaiting_release) {
         uint32_t drc_index = spapr_drc_index(drc);
         trace_spapr_drc_set_allocation_state_finalizing(drc_index);
-        spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
+        spapr_drc_detach(drc);
     }
 
     return RTAS_OUT_SUCCESS;
@@ -371,20 +371,20 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
     drc->dev = NULL;
 }
 
-void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
+void spapr_drc_detach(sPAPRDRConnector *drc)
 {
     trace_spapr_drc_detach(spapr_drc_index(drc));
 
+    drc->awaiting_release = true;
+
     if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
         trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
-        drc->awaiting_release = true;
         return;
     }
 
     if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
         drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
         trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
-        drc->awaiting_release = true;
         return;
     }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bda8938..af925c0 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1476,7 +1476,6 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     sPAPRDRConnectorClass *drck;
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
-    Error *local_err = NULL;
 
     if (!phb->dr_enabled) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG,
@@ -1514,11 +1513,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
             }
         }
 
-        spapr_drc_detach(drc, DEVICE(pdev), &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        spapr_drc_detach(drc);
 
         /* if this isn't func 0, defer unplug event. otherwise signal removal
          * for all present functions
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 42c3722..ab64235 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -234,6 +234,6 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
 
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                       int fdt_start_offset, Error **errp);
-void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
+void spapr_drc_detach(sPAPRDRConnector *drc);
 
 #endif /* HW_SPAPR_DRC_H */
-- 
2.9.4
