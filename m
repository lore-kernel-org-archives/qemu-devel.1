Received: from eggs.gnu.org ([2001:4830:134:3::10]:47148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCS0-000409-Kk
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRy-0006g8-PE
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:48 +1000
Message-Id: <20170609052652.23200-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/20] xics: introduce macros for ICP/ICS link
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

These properties are part of the XICS API. They deserve to appear
explicitely in the XICS header file.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c          | 8 ++++----
 hw/ppc/pnv_core.c       | 3 ++-
 hw/ppc/pnv_psi.c        | 3 ++-
 hw/ppc/spapr.c          | 3 ++-
 hw/ppc/spapr_cpu_core.c | 3 ++-
 include/hw/ppc/xics.h   | 4 ++++
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ec73f02..aa2c4e7 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -346,9 +346,9 @@ static void icp_realize(DeviceState *dev, Error **errp)
     Object *obj;
     Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "xics", &err);
+    obj = object_property_get_link(OBJECT(dev), ICP_PROP_XICS, &err);
     if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
+        error_setg(errp, "%s: required link '" ICP_PROP_XICS "' not found: %s",
                    __func__, error_get_pretty(err));
         return;
     }
@@ -654,9 +654,9 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
     Object *obj;
     Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "xics", &err);
+    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
     if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
+        error_setg(errp, "%s: required link '" ICS_PROP_XICS "' not found: %s",
                    __func__, error_get_pretty(err));
         return;
     }
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e8a9a94..0b6e729 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -121,7 +121,8 @@ static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
     obj = object_new(TYPE_PNV_ICP);
     object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
     object_unref(obj);
-    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort);
+    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
+                                   &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 2bf5bfe..9876c26 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -474,7 +474,8 @@ static void pnv_psi_realize(DeviceState *dev, Error **errp)
     }
 
     /* Create PSI interrupt control source */
-    object_property_add_const_link(OBJECT(ics), "xics", obj,  &error_abort);
+    object_property_add_const_link(OBJECT(ics), ICS_PROP_XICS, obj,
+                                   &error_abort);
     object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 01dda9e..b2951d7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -107,7 +107,8 @@ static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
 
     obj = object_new(type_ics);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
-    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
+    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
+                                   &error_abort);
     object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 029a141..e81879c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -145,7 +145,8 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     obj = object_new(spapr->icp_type);
     object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
     object_unref(obj);
-    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
+    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
+                                   &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 40a506e..3114532 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -86,6 +86,8 @@ struct ICPState {
     XICSFabric *xics;
 };
 
+#define ICP_PROP_XICS "xics"
+
 struct PnvICPState {
     ICPState parent_obj;
 
@@ -130,6 +132,8 @@ struct ICSState {
     XICSFabric *xics;
 };
 
+#define ICS_PROP_XICS "xics"
+
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
 {
     return (ics->offset != 0) && (nr >= ics->offset)
-- 
2.9.4
