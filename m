Received: from eggs.gnu.org ([2001:4830:134:3::10]:56660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46f-0000lz-3t
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46c-0000xT-2r
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:53 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:44076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da46b-0000wX-SG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:50 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6CD7711641C
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:58:48 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:58:40 +0200
Message-ID: <150100552078.27487.390170136970607382.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 03/26] spapr_iommu: use
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
 hw/ppc/spapr_iommu.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e614621a8317..740d42608b61 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -252,17 +252,19 @@ static int spapr_tce_table_realize(DeviceState *dev)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
     Object *tcetobj = OBJECT(tcet);
-    char tmp[32];
+    gchar *tmp;
 
     tcet->fd = -1;
     tcet->need_vfio = false;
-    snprintf(tmp, sizeof(tmp), "tce-root-%x", tcet->liobn);
+    tmp = g_strdup_printf("tce-root-%x", tcet->liobn);
     memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
+    g_free(tmp);
 
-    snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
+    tmp = g_strdup_printf("tce-iommu-%x", tcet->liobn);
     memory_region_init_iommu(&tcet->iommu, sizeof(tcet->iommu),
                              TYPE_SPAPR_IOMMU_MEMORY_REGION,
                              tcetobj, tmp, 0);
+    g_free(tmp);
 
     QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
 
@@ -307,7 +309,7 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
 {
     sPAPRTCETable *tcet;
-    char tmp[32];
+    gchar *tmp;
 
     if (spapr_tce_find_by_liobn(liobn)) {
         error_report("Attempted to create TCE table with duplicate"
@@ -318,8 +320,9 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
     tcet = SPAPR_TCE_TABLE(object_new(TYPE_SPAPR_TCE_TABLE));
     tcet->liobn = liobn;
 
-    snprintf(tmp, sizeof(tmp), "tce-table-%x", liobn);
+    tmp = g_strdup_printf("tce-table-%x", liobn);
     object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
+    g_free(tmp);
 
     object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
 
