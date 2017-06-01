Received: from eggs.gnu.org ([2001:4830:134:3::10]:56343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGFHs-0007Gx-VI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 21:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGFHp-0005ty-PV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 21:52:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  1 Jun 2017 11:52:16 +1000
Message-Id: <20170601015218.9299-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170601015218.9299-1-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/4] spapr: Abolish DRC get_fdt method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The DRConnectorClass includes a get_fdt method.  However
  * There's only one implementation, and there's only likely to ever be one
  * Both callers are local to spapr_drc
  * Each caller only uses one half of the actual implementation

So abolish get_fdt() entirely, and just open-code what we need.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 23 ++++++-----------------
 include/hw/ppc/spapr_drc.h |  1 -
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index ae8800d..f5b7b68 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -199,14 +199,6 @@ static const char *get_name(sPAPRDRConnector *drc)
     return drc->name;
 }
 
-static const void *get_fdt(sPAPRDRConnector *drc, int *fdt_start_offset)
-{
-    if (fdt_start_offset) {
-        *fdt_start_offset = drc->fdt_start_offset;
-    }
-    return drc->fdt;
-}
-
 static void set_configured(sPAPRDRConnector *drc)
 {
     trace_spapr_drc_set_configured(get_index(drc));
@@ -753,7 +745,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->get_index = get_index;
     drck->get_type = get_type;
     drck->get_name = get_name;
-    drck->get_fdt = get_fdt;
     drck->set_configured = set_configured;
     drck->entity_sense = entity_sense;
     drck->attach = attach;
@@ -1126,7 +1117,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     sPAPRConfigureConnectorState *ccs;
     sPAPRDRCCResponse resp = SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
-    const void *fdt;
 
     if (nargs != 2 || nret != 1) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -1144,8 +1134,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     }
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    fdt = drck->get_fdt(drc, NULL);
-    if (!fdt) {
+    if (!drc->fdt) {
         trace_spapr_rtas_ibm_configure_connector_missing_fdt(drc_index);
         rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
         goto out;
@@ -1154,7 +1143,7 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     ccs = spapr_ccs_find(spapr, drc_index);
     if (!ccs) {
         ccs = g_new0(sPAPRConfigureConnectorState, 1);
-        (void)drck->get_fdt(drc, &ccs->fdt_offset);
+        ccs->fdt_offset = drc->fdt_start_offset;
         ccs->drc_index = drc_index;
         spapr_ccs_add(spapr, ccs);
     }
@@ -1165,12 +1154,12 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         const struct fdt_property *prop;
         int fdt_offset_next, prop_len;
 
-        tag = fdt_next_tag(fdt, ccs->fdt_offset, &fdt_offset_next);
+        tag = fdt_next_tag(drc->fdt, ccs->fdt_offset, &fdt_offset_next);
 
         switch (tag) {
         case FDT_BEGIN_NODE:
             ccs->fdt_depth++;
-            name = fdt_get_name(fdt, ccs->fdt_offset, NULL);
+            name = fdt_get_name(drc->fdt, ccs->fdt_offset, NULL);
 
             /* provide the name of the next OF node */
             wa_offset = CC_VAL_DATA_OFFSET;
@@ -1193,9 +1182,9 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
             }
             break;
         case FDT_PROP:
-            prop = fdt_get_property_by_offset(fdt, ccs->fdt_offset,
+            prop = fdt_get_property_by_offset(drc->fdt, ccs->fdt_offset,
                                               &prop_len);
-            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+            name = fdt_string(drc->fdt, fdt32_to_cpu(prop->nameoff));
 
             /* provide the name of the next OF property */
             wa_offset = CC_VAL_DATA_OFFSET;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 813b9ff..80db955 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -178,7 +178,6 @@ typedef struct sPAPRDRConnectorClass {
     uint32_t (*entity_sense)(sPAPRDRConnector *drc, sPAPRDREntitySense *state);
 
     /* QEMU interfaces for managing FDT/configure-connector */
-    const void *(*get_fdt)(sPAPRDRConnector *drc, int *fdt_start_offset);
     void (*set_configured)(sPAPRDRConnector *drc);
 
     /* QEMU interfaces for managing hotplug operations */
-- 
2.9.4
