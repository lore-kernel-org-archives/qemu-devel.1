Received: from eggs.gnu.org ([2001:4830:134:3::10]:34514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRn-000053-Qz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRm-0007yC-0y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:29 +1000
Message-Id: <20170630104632.27942-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/21] spapr: Split DRC release from DRC detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

spapr_drc_detach() is called when qemu generic code requests a device be
unplugged.  It makes a number of tests, which could well delay further
action until later, before actually detach the device from the DRC.

This splits out the part which actually removes the device from the DRC
into spapr_drc_release().  This will be useful for further cleanups.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 21f5bf1..8a2b8f5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -315,29 +315,8 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                              NULL, 0, NULL);
 }
 
-void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
+static void spapr_drc_release(sPAPRDRConnector *drc)
 {
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
-        drc->awaiting_release = true;
-        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
-        return;
-    }
-
     drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
 
     /* Calling release callbacks based on spapr_drc_type(drc). */
@@ -365,6 +344,32 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
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
+        drc->awaiting_release = true;
+        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
+        return;
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
