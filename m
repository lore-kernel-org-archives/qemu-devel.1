Received: from eggs.gnu.org ([2001:4830:134:3::10]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9ul-0003Ov-8f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9uf-00021T-LV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 18:32:16 +1000
Message-Id: <20170606083221.9299-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170606083221.9299-1-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/7] spapr: Abolish DRC get_name method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

DRConnectorClass has a get_name method, however:
  * There's only one implementation, and only ever likely to be one
  * There's exactly one caller, which is (now) local
  * The implementation is trivial

So just open-code what we need.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 11 ++---------
 include/hw/ppc/spapr_drc.h |  1 -
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index da3779e..9140b48 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -167,11 +167,6 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
     return RTAS_OUT_SUCCESS;
 }
 
-static const char *get_name(sPAPRDRConnector *drc)
-{
-    return drc->name;
-}
-
 /* has the guest been notified of device attachment? */
 static void set_signalled(sPAPRDRConnector *drc)
 {
@@ -221,8 +216,7 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
 static char *prop_get_name(Object *obj, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    return g_strdup(drck->get_name(drc));
+    return g_strdup(drc->name);
 }
 
 static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
@@ -653,7 +647,6 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     drck->set_isolation_state = set_isolation_state;
     drck->set_indicator_state = set_indicator_state;
     drck->set_allocation_state = set_allocation_state;
-    drck->get_name = get_name;
     drck->attach = attach;
     drck->detach = detach;
     drck->release_pending = release_pending;
@@ -848,7 +841,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
         g_array_append_val(drc_power_domains, drc_power_domain);
 
         /* ibm,drc-names */
-        drc_names = g_string_append(drc_names, drck->get_name(drc));
+        drc_names = g_string_append(drc_names, drc->name);
         drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
 
         /* ibm,drc-types */
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f892b94..795b7dd 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -223,7 +223,6 @@ typedef struct sPAPRDRConnectorClass {
                                     sPAPRDRIndicatorState state);
     uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
                                      sPAPRDRAllocationState state);
-    const char *(*get_name)(sPAPRDRConnector *drc);
 
     /* QEMU interfaces for managing hotplug operations */
     void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-- 
2.9.4
