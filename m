Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daj70-0001vf-Pl
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daj6z-0008J9-7S
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:45:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daj6y-0008Ib-Us
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:45:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RDj6oq116844
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:45:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2byewm7c76-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:45:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 27 Jul 2017 14:45:51 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 27 Jul 2017 15:45:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [for-2.10 PATCH] spapr_drc: fix realize and unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

If object_property_add_alias() returns an error in realize(), we should
propagate it to the caller and certainly not unref the DRC.

Same thing goes for unrealize(). Since object_property_del() is the last
call, we can even get rid of the intermediate Error *.

And finally, unrealize() should undo all registrations performed by
realize().

Signed-off-by: Greg Kurz <groug@kaod.org>
---

David,

As agreed on the list, here's the version of the fix for 2.10. I'll respin
my PHB hotplug series on top of it.

Cheers,

--
Greg

 hw/ppc/spapr_drc.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 15bae5c216a9..47d94e782ac2 100644
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
