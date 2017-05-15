Received: from eggs.gnu.org ([2001:4830:134:3::10]:41715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELz-0004Ef-7Y
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELv-0002Px-A6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:55 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:53750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAELv-0002PO-3j
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:51 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1C5EA1FBF7
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:39:50 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 15 May 2017 13:39:45 +0200
Message-ID: <149484838558.20089.5029926585755792842.stgit@bahia.lan>
In-Reply-To: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/6] spapr: sanitize error handling in
 spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

The spapr_ics_create() function handles errors in a rather convoluted
way, with two local Error * variables. Moreover, failing to parent the
ICS object to the machine should be considered as a bug but it is
currently ignored.

This patch addresses both issues.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 44f7dc7f40e9..c53989bb10b1 100644
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
