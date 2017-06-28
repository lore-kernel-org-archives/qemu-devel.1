Received: from eggs.gnu.org ([2001:4830:134:3::10]:41092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQDeo-0002aA-CU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQDel-0008Dn-7N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:09:26 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 28 Jun 2017 16:09:19 +0200
Message-Id: <20170628140919.27167-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: fix migration to pseries machine < 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

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
---
 hw/ppc/spapr_pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0b447f2..bd30b4f 100644
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
