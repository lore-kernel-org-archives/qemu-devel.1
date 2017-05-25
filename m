Received: from eggs.gnu.org ([2001:4830:134:3::10]:57237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0006Ua-SA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoL-0007S9-Ow
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:17 +1000
Message-Id: <20170525035132.24268-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/18] spapr: sanitize error handling in
 spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The spapr_ics_create() function handles errors in a rather convoluted
way, with two local Error * variables. Moreover, failing to parent the
ICS object to the machine should be considered as a bug but it is
currently ignored.

This patch addresses both issues.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 18709ad..a9471b9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -101,21 +101,26 @@ static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
                                   const char *type_ics,
                                   int nr_irqs, Error **errp)
 {
-    Error *err = NULL, *local_err = NULL;
+    Error *local_err = NULL;
     Object *obj;
 
     obj = object_new(type_ics);
-    object_property_add_child(OBJECT(spapr), "ics", obj, NULL);
+    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
-    object_property_set_int(obj, nr_irqs, "nr-irqs", &err);
+    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
+    if (local_err) {
+        goto error;
+    }
     object_property_set_bool(obj, true, "realized", &local_err);
-    error_propagate(&err, local_err);
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
+    if (local_err) {
+        goto error;
     }
 
     return ICS_SIMPLE(obj);
+
+error:
+    error_propagate(errp, local_err);
+    return NULL;
 }
 
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
-- 
2.9.4
