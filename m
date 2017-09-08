Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe7-0002AG-2Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdx-0003AD-4s
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:24 +1000
Message-Id: <20170908103558.31632-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/40] spapr_drc: use g_strdup_printf() instead
 of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Passing a stack allocated buffer of arbitrary length to snprintf()
without checking the return value can cause the resultant strings
to be silently truncated.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 85c999d9cb..644a6fffaf 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -492,7 +492,7 @@ static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
-    char link_name[256];
+    gchar *link_name;
     gchar *child_name;
     Error *err = NULL;
 
@@ -505,12 +505,13 @@ static void realize(DeviceState *d, Error **errp)
      * existing in the composition tree
      */
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(link_name, sizeof(link_name), "%x", spapr_drc_index(drc));
+    link_name = g_strdup_printf("%x", spapr_drc_index(drc));
     child_name = object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name, &err);
     g_free(child_name);
+    g_free(link_name);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -525,14 +526,15 @@ static void unrealize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
-    char name[256];
+    gchar *name;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
     qemu_unregister_reset(drc_reset, drc);
     vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
+    name = g_strdup_printf("%x", spapr_drc_index(drc));
     object_property_del(root_container, name, errp);
+    g_free(name);
 }
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
@@ -730,10 +732,11 @@ static const TypeInfo spapr_drc_lmb_info = {
 sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
 {
     Object *obj;
-    char name[256];
+    gchar *name;
 
-    snprintf(name, sizeof(name), "%s/%x", DRC_CONTAINER_PATH, index);
+    name = g_strdup_printf("%s/%x", DRC_CONTAINER_PATH, index);
     obj = object_resolve_path(name, NULL);
+    g_free(name);
 
     return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
 }
-- 
2.13.5
