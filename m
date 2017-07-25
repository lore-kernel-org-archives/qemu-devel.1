Received: from eggs.gnu.org ([2001:4830:134:3::10]:56700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46r-0000zM-N9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46o-00013c-NB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:05 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:34550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da46o-00013F-GI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:59:02 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 20FB911641E
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:58:53 +0200
Message-ID: <150100553345.27487.10049014405920351882.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 04/26] spapr_drc: use
 g_strdup_printf() instead of snprintf()
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

Passing a stack allocated buffer of arbitrary length to snprintf()
without checking the return value can cause the resultant strings
to be silently truncated.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 15bae5c216a9..e4e8383ec7b5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -488,7 +488,7 @@ static void realize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
-    char link_name[256];
+    gchar *link_name;
     gchar *child_name;
     Error *err = NULL;
 
@@ -501,11 +501,12 @@ static void realize(DeviceState *d, Error **errp)
      * existing in the composition tree
      */
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(link_name, sizeof(link_name), "%x", spapr_drc_index(drc));
+    link_name = g_strdup_printf("%x", spapr_drc_index(drc));
     child_name = object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
                               drc->owner, child_name, &err);
+    g_free(link_name);
     if (err) {
         error_report_err(err);
         object_unref(OBJECT(drc));
@@ -521,13 +522,14 @@ static void unrealize(DeviceState *d, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
-    char name[256];
+    gchar *name;
     Error *err = NULL;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
+    name = g_strdup_printf("%x", spapr_drc_index(drc));
     object_property_del(root_container, name, &err);
+    g_free(name);
     if (err) {
         error_report_err(err);
         object_unref(OBJECT(drc));
@@ -729,10 +731,11 @@ static const TypeInfo spapr_drc_lmb_info = {
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
