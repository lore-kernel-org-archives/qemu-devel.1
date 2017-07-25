Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47T-0001TJ-F7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da47Q-0001Ig-F5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:43 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:59462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da47Q-0001IO-7w
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:40 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1F522116555
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:39 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:59:31 +0200
Message-ID: <150100557147.27487.5031800506520955290.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 07/26] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

If object_property_add_alias() returns an error in realize(), we should
propagate it to the caller and certainly not unref the DRC.

Same thing goes for unrealize(). Since object_property_del() is the last
call, we can even get rid of the intermediate Error *.

And finally, unrealize() should undo all registrations performed by
realize().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index e4e8383ec7b5..d72453bcb42f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -506,12 +506,12 @@ static void realize(DeviceState *d, Error **errp)
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name, &err);
+    g_free(child_name);
     g_free(link_name);
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
@@ -523,17 +523,14 @@ static void unrealize(DeviceState *d, Error **errp)
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     gchar *name;
-    Error *err = NULL;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
+    qemu_unregister_reset(drc_reset, drc);
+    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
     name = g_strdup_printf("%x", spapr_drc_index(drc));
-    object_property_del(root_container, name, &err);
+    object_property_del(root_container, name, errp);
     g_free(name);
-    if (err) {
-        error_report_err(err);
-        object_unref(OBJECT(drc));
-    }
 }
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
