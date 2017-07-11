Received: from eggs.gnu.org ([2001:4830:134:3::10]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxo-0002nN-GN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxl-0007jL-Rt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:56 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:04 +1000
Message-Id: <20170711043917.1757-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/17] spapr: fix migration to pseries machine <
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

since commit 5c4537bd ("spapr: Fix 2.7<->2.8 migration of PCI host bridge"),
some migration fields are forged from the new ones in spapr_pci_pre_save().

It works well, except when the number of MSI devices is 0,
because in this case the function exits immediately.

This fix moves the migration code before the exit code.

The problem can be reproduced with these commands:

source qemu-2.9:

    qemu-system-ppc64 -monitor stdio -M pseries-2.6 -nodefaults -S

destination qemu-2.6:

    qemu-system-ppc64 -monitor stdio -M pseries-2.6 -nodefaults \
                      -incoming tcp:0:4444

on the source:

    migrate tcp:localhost:4444

Destination fails with the following error:

    qemu-system-ppc64: error while loading state for
                       instance 0x0 of device 'spapr_pci'
    qemu-system-ppc64: load of migration failed: Invalid argument

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3b37dcd..f09b4e1 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1873,20 +1873,6 @@ static void spapr_pci_pre_save(void *opaque)
     gpointer key, value;
     int i;
 
-    g_free(sphb->msi_devs);
-    sphb->msi_devs = NULL;
-    sphb->msi_devs_num = g_hash_table_size(sphb->msi);
-    if (!sphb->msi_devs_num) {
-        return;
-    }
-    sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
-
-    g_hash_table_iter_init(&iter, sphb->msi);
-    for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
-        sphb->msi_devs[i].key = *(uint32_t *) key;
-        sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
-    }
-
     if (sphb->pre_2_8_migration) {
         sphb->mig_liobn = sphb->dma_liobn[0];
         sphb->mig_mem_win_addr = sphb->mem_win_addr;
@@ -1900,6 +1886,20 @@ static void spapr_pci_pre_save(void *opaque)
             sphb->mig_mem_win_size += sphb->mem64_win_size;
         }
     }
+
+    g_free(sphb->msi_devs);
+    sphb->msi_devs = NULL;
+    sphb->msi_devs_num = g_hash_table_size(sphb->msi);
+    if (!sphb->msi_devs_num) {
+        return;
+    }
+    sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
+
+    g_hash_table_iter_init(&iter, sphb->msi);
+    for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
+        sphb->msi_devs[i].key = *(uint32_t *) key;
+        sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
+    }
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
-- 
2.9.4
