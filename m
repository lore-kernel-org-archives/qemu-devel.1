Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe4-00028F-R0
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe0-0003Do-0L
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:39 +1000
Message-Id: <20170908103558.31632-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/40] spapr_iommu: Realloc guest visible TCE
 table when hot(un)plugging vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This replaces g_malloc() with spapr_tce_alloc_table() as this is
the standard way of allocating tables and this allows moving the table
back to KVM when unplugging a VFIO PCI device and VFIO TCE acceleration
support is not present in the KVM.

Although spapr_tce_alloc_table() is expected to fail with EBUSY
if called when previous fd is not closed yet, in practice we will not
see it because cap_spapr_vfio is false at the moment.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index a75584c947..fa8b969840 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -275,33 +275,26 @@ static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
 void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
 {
     size_t table_size = tcet->nb_table * sizeof(uint64_t);
-    void *newtable;
+    uint64_t *oldtable;
+    int newfd = -1;
 
-    if (need_vfio == tcet->need_vfio) {
-        /* Nothing to do */
-        return;
-    }
-
-    if (!need_vfio) {
-        /* FIXME: We don't support transition back to KVM accelerated
-         * TCEs yet */
-        return;
-    }
+    g_assert(need_vfio != tcet->need_vfio);
 
-    tcet->need_vfio = true;
+    tcet->need_vfio = need_vfio;
 
-    if (tcet->fd < 0) {
-        /* Table is already in userspace, nothing to be do */
-        return;
-    }
+    oldtable = tcet->table;
 
-    newtable = g_malloc(table_size);
-    memcpy(newtable, tcet->table, table_size);
+    tcet->table = spapr_tce_alloc_table(tcet->liobn,
+                                        tcet->page_shift,
+                                        tcet->bus_offset,
+                                        tcet->nb_table,
+                                        &newfd,
+                                        need_vfio);
+    memcpy(tcet->table, oldtable, table_size);
 
-    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
+    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
 
-    tcet->fd = -1;
-    tcet->table = newtable;
+    tcet->fd = newfd;
 }
 
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
-- 
2.13.5
