Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-00026J-HB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdx-0003Ak-Cg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:23 +1000
Message-Id: <20170908103558.31632-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/40] spapr_iommu: use g_strdup_printf()
 instead of snprintf()
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
 hw/ppc/spapr_iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ed2d53559a..ed4388bd75 100644
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
 
-- 
2.13.5
