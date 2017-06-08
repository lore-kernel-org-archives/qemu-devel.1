Received: from eggs.gnu.org ([2001:4830:134:3::10]:48109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxi4-0005eJ-4i
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxi3-0006yt-3y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:48 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:53927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIxi2-0006yT-TU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:42:47 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id ADE723EAC7
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:42:45 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 08 Jun 2017 15:42:41 +0200
Message-ID: <149692936183.12119.5013623492394505174.stgit@bahia>
In-Reply-To: <149692935202.12119.3614006195497745877.stgit@bahia>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS link
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

These properties are part of the XICS API. They deserve to appear
explicitely in the XICS header file.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c          |    8 ++++----
 hw/ppc/pnv_core.c       |    3 ++-
 hw/ppc/pnv_psi.c        |    3 ++-
 hw/ppc/spapr.c          |    3 ++-
 hw/ppc/spapr_cpu_core.c |    3 ++-
 include/hw/ppc/xics.h   |    4 ++++
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ec73f02144c9..aa2c4e744f65 100644
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
index e8a9a94d5a24..0b6e72950ca3 100644
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
index 2bf5bfe3fdd6..9876c266223d 100644
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
index 01dda9ea9fb7..b2951d7618d6 100644
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
index 029a14120edd..e81879c7cad7 100644
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
index 40a506eacfb4..31145326ebf9 100644
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
