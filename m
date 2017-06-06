Received: from eggs.gnu.org ([2001:4830:134:3::10]:54315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ay-0003VM-DB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ax-0002zQ-07
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:23 +1000
Message-Id: <20170606025135.2685-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/17] spapr: Abolish DRC set_configured method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

DRConnectorClass has a set_configured method, however:
  * There is only one implementation, and only ever likely to be one
  * There's exactly one caller, and that's (now) local
  * The implementation is very straightforward

So abolish the method entirely, and just open-code what we need.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 24 ++++++++----------------
 include/hw/ppc/spapr_drc.h |  3 ---
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index f5b7b68..693571a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -199,18 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
     return drc->name;
 }
 
-static void set_configured(sPAPRDRConnector *drc)
-{
-    trace_spapr_drc_set_configured(get_index(drc));
-
-    if (drc->isolation_state != SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
-        /* guest should be not configuring an isolated device */
-        trace_spapr_drc_set_configured_skipping(get_index(drc));
-        return;
-    }
-    drc->configured = true;
-}
-
 /* has the guest been notified of device attachment? */
 static void set_signalled(sPAPRDRConnector *drc)
 {
@@ -745,7 +733,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->get_index = get_index;
     drck->get_type = get_type;
     drck->get_name = get_name;
-    drck->set_configured = set_configured;
     drck->entity_sense = entity_sense;
     drck->attach = attach;
     drck->detach = detach;
@@ -1113,7 +1100,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     uint64_t wa_offset;
     uint32_t drc_index;
     sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
     sPAPRConfigureConnectorState *ccs;
     sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
@@ -1133,7 +1119,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         goto out;
     }
 
-    drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     if (!drc->fdt) {
         trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
         rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
@@ -1170,10 +1155,17 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         case FDT_END_NODE:
             ccs->fdt_depth--;
             if (ccs->fdt_depth == 0) {
+                sPAPRDRIsolationState state = drc->isolation_state;
                 /* done sending the device tree, don't need to track
                  * the state anymore
                  */
-                drck->set_configured(drc);
+                trace_spapr_drc_set_configured(get_index(drc));
+                if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
+                    drc->configured = true;
+                } else {
+                    /* guest should be not configuring an isolated device */
+                    trace_spapr_drc_set_configured_skipping(get_index(drc));
+                }
                 spapr_ccs_remove(spapr, ccs);
                 ccs = NULL;
                 resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 80db955..90f4953 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -177,9 +177,6 @@ typedef struct sPAPRDRConnectorClass {
 
     uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *state);
 
-    /* QEMU interfaces for managing FDT/configure-connector */
-    void (*set_configured)(sPAPRDRConnector *drc);
-
     /* QEMU interfaces for managing hotplug operations */
     void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                    int fdt_start_offset, bool coldplug, Error **errp);
-- 
2.9.4
