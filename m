Received: from eggs.gnu.org ([2001:4830:134:3::10]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4b1-0003ZI-R9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4az-00031e-Td
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:35 +1000
Message-Id: <20170606025135.2685-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/17] spapr: Remove some non-useful properties
 on DRC objects
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

 * 'connector_type' is easily derived from the 'index' property, so there's
   no point to it (it's also implicit in the QOM type of the DRC)
 * 'isolation-state', 'indicator-state' and 'allocation-state' are
   part of the transaction between qemu and guest during PAPR hotplug
   operations, and outside tools really have no business looking at it
   (especially not changing, and these were RW properties)
 * 'entity-sense' is basically just a weird PAPR encoding of whether there
   is a device connected to this DRC

Strictly speaking removing these properties is breaking the qemu interface.
However, I'm pretty sure no management tools have ever used these.  For
debugging there are better alternatives.  Therefore, I think removing these
broken interfaces is the better option.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 06df5d0..39e7f30 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -228,14 +228,6 @@ static void prop_get_index(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static void prop_get_type(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
-{
-    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    uint32_t value = (uint32_t)spapr_drc_type(drc);
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static char *prop_get_name(Object *obj, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
@@ -243,17 +235,6 @@ static char *prop_get_name(Object *obj, Error **errp)
     return g_strdup(drck->get_name(drc));
 }
 
-static void prop_get_entity_sense(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
-{
-    sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    uint32_t value;
-
-    drck->entity_sense(drc, &value);
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -666,20 +647,10 @@ static void spapr_dr_connector_instance_init(Object *obj)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
 
-    object_property_add_uint32_ptr(obj, "isolation-state",
-                                   &drc->isolation_state, NULL);
-    object_property_add_uint32_ptr(obj, "indicator-state",
-                                   &drc->indicator_state, NULL);
-    object_property_add_uint32_ptr(obj, "allocation-state",
-                                   &drc->allocation_state, NULL);
     object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
                         NULL, NULL, NULL, NULL);
-    object_property_add(obj, "connector_type", "uint32", prop_get_type,
-                        NULL, NULL, NULL, NULL);
     object_property_add_str(obj, "name", prop_get_name, NULL, NULL);
-    object_property_add(obj, "entity-sense", "uint32", prop_get_entity_sense,
-                        NULL, NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL, NULL);
 }
-- 
2.9.4
