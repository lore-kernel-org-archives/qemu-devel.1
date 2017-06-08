Received: from eggs.gnu.org ([2001:4830:134:3::10]:37219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIphV-0006X4-14
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIphQ-0008OD-Bg
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:09:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Jun 2017 15:09:27 +1000
Message-Id: <20170608050930.2613-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170608050930.2613-1-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 3/6] spapr: Split DRC release from DRC detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

spapr_drc_detach() is called when qemu generic code requests a device be
unplugged.  It makes a number of tests, which could well delay further
action until later, before actually detach the device from the DRC.

This splits out the part which actually removes the device from the DRC
into spapr_drc_release().  This will be useful for further cleanups.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index afd68f4..dc4ac77 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -326,31 +326,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                              NULL, 0, NULL);
 }
 
-void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
-{
-    trace_spapr_drc_detach(spapr_drc_index(drc));
-
-    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
-        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
-        drc->awaiting_release = true;
-        return;
-    }
-
-    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
-        drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
-        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
-        drc->awaiting_release = true;
-        return;
-    }
-
-    if (drc->awaiting_allocation) {
-        if (!drc->awaiting_allocation_skippable) {
-            drc->awaiting_release = true;
-            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
-            return;
-        }
-    }
 
+static void spapr_drc_release(sPAPRDRConnector *drc)
+{
     drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
 
     /* Calling release callbacks based on spapr_drc_type(drc). */
@@ -379,6 +357,34 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     drc->dev = NULL;
 }
 
+void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
+{
+    trace_spapr_drc_detach(spapr_drc_index(drc));
+
+    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_ISOLATED) {
+        trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
+        drc->awaiting_release = true;
+        return;
+    }
+
+    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
+        drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
+        trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
+        drc->awaiting_release = true;
+        return;
+    }
+
+    if (drc->awaiting_allocation) {
+        if (!drc->awaiting_allocation_skippable) {
+            drc->awaiting_release = true;
+            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
+            return;
+        }
+    }
+
+    spapr_drc_release(drc);
+}
+
 static bool release_pending(sPAPRDRConnector *drc)
 {
     return drc->awaiting_release;
-- 
2.9.4
