Received: from eggs.gnu.org ([2001:4830:134:3::10]:56442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2Ia-0005uG-2g
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2IZ-0003VF-7T
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 31 Jul 2017 14:27:09 +1000
Message-Id: <20170731042710.19924-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170731042710.19924-1-david@gibson.dropbear.id.au>
References: <20170731042710.19924-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/2] spapr_drc: fix realize and unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

If object_property_add_alias() returns an error in realize(), we should
propagate it to the caller and certainly not unref the DRC.

Same thing goes for unrealize(). Since object_property_del() is the last
call, we can even get rid of the intermediate Error *.

And finally, unrealize() should undo all registrations performed by
realize().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 15bae5c216..47d94e782a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -506,11 +506,11 @@ static void realize(DeviceState *d, Error **errp)
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name, &err);
+    g_free(child_name);
     if (err) {
-        error_report_err(err);
-        object_unref(OBJECT(drc));
+        error_propagate(errp, err);
+        return;
     }
-    g_free(child_name);
     vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc,
                      drc);
     qemu_register_reset(drc_reset, drc);
@@ -522,16 +522,13 @@ static void unrealize(DeviceState *d, Error **errp)
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     char name[256];
-    Error *err = NULL;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
+    qemu_unregister_reset(drc_reset, drc);
+    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
     snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
-    object_property_del(root_container, name, &err);
-    if (err) {
-        error_report_err(err);
-        object_unref(OBJECT(drc));
-    }
+    object_property_del(root_container, name, errp);
 }
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
-- 
2.13.3
