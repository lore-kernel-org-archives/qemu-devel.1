Received: from eggs.gnu.org ([2001:4830:134:3::10]:46493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nH-0006Fe-1C
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nC-0002zf-My
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:43 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 20 Jul 2017 17:22:29 +1000
Message-Id: <20170720072231.35054-2-aik@ozlabs.ru>
In-Reply-To: <20170720072231.35054-1-aik@ozlabs.ru>
References: <20170720072231.35054-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 1/3] spapr_iommu: Realloc guest visible
 TCE table when hot(un)plugging vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

This replaces g_malloc() with spapr_tce_alloc_table() as this is
the standard way of allocating tables and this allows moving the table
back to KVM when unplugging a VFIO PCI device and VFIO TCE acceleration
support is not present in the KVM.

Although spapr_tce_alloc_table() is expected to fail with EBUSY
if called when previous fd is not closed yet, in practice we will not
see it because cap_spapr_vfio is false at the moment.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_iommu.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e614621a83..307dc3021e 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -275,33 +275,26 @@ static int spapr_tce_table_realize(DeviceState *dev)
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
+    g_assert(need_vfio != tcet->need_vfio);
 
-    if (!need_vfio) {
-        /* FIXME: We don't support transition back to KVM accelerated
-         * TCEs yet */
-        return;
-    }
+    tcet->need_vfio = need_vfio;
 
-    tcet->need_vfio = true;
+    oldtable = tcet->table;
 
-    if (tcet->fd < 0) {
-        /* Table is already in userspace, nothing to be do */
-        return;
-    }
+    tcet->table = spapr_tce_alloc_table(tcet->liobn,
+                                        tcet->page_shift,
+                                        tcet->bus_offset,
+                                        tcet->nb_table,
+                                        &newfd,
+                                        need_vfio);
+    memcpy(tcet->table, oldtable, table_size);
 
-    newtable = g_malloc(table_size);
-    memcpy(newtable, tcet->table, table_size);
+    spapr_tce_free_table(oldtable, tcet->fd, tcet->nb_table);
 
-    kvmppc_remove_spapr_tce(tcet->table, tcet->fd, tcet->nb_table);
-
-    tcet->fd = -1;
-    tcet->table = newtable;
+    tcet->fd = newfd;
 }
 
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
-- 
2.11.0
