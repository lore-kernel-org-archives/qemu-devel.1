Received: from eggs.gnu.org ([2001:4830:134:3::10]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8nV-0005CZ-MJ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8nQ-0005qC-Og
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:13 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:37287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8nQ-0005og-Gj
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:08 -0500
Received: from player157.ha.ovh.net (unknown [10.109.143.18])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 87A01177065
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:36:07 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:35:52 +0100
Message-ID: <154535255201.862554.4906401457640454977.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 04/15] spapr_pci: add proper rollback on PHB
 realize error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

The current realize code assumes the PHB is coldplugged, ie, QEMU will
terminate if an error is detected, and does not bother to free anything
it has already allocated.

In order to support PHB hotplug, let's first ensure spapr_phb_realize()
doesn't leak anything in case of error.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e59adbe706bb..46d7062dd143 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1570,6 +1570,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     sPAPRTCETable *tcet;
     const unsigned windows_supported =
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    Object *drcs[PCI_SLOT_MAX * 8];
 
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
@@ -1733,7 +1734,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         spapr_irq_claim(spapr, irq, true, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
-            return;
+            while (--i >= 0) {
+                spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
+            }
+            goto fail_del_msiwindow;
         }
 
         sphb->lsi_table[i].irq = irq;
@@ -1741,9 +1745,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
 
     /* allocate connectors for child PCI devices */
     if (sphb->dr_enabled) {
-        for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
-            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
-                                   (sphb->index << 16) | i);
+        for (i = 0; i < ARRAY_SIZE(drcs); i++) {
+            drcs[i] =
+                OBJECT(spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
+                                              (sphb->index << 16) | i));
         }
     }
 
@@ -1753,13 +1758,38 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         if (!tcet) {
             error_setg(errp, "Creating window#%d failed for %s",
                        i, sphb->dtbusname);
-            return;
+            while (--i >= 0) {
+                tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
+                assert(tcet);
+                memory_region_del_subregion(&sphb->iommu_root,
+                                            spapr_tce_get_iommu(tcet));
+                object_unparent(OBJECT(tcet));
+            }
+            goto fail_free_drcs;
         }
         memory_region_add_subregion(&sphb->iommu_root, 0,
                                     spapr_tce_get_iommu(tcet));
     }
 
     sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
+    return;
+
+fail_free_drcs:
+    if (sphb->dr_enabled) {
+        for (i = 0; i < ARRAY_SIZE(drcs); i++) {
+            object_unparent(drcs[i]);
+        }
+    }
+fail_del_msiwindow:
+    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
+    address_space_destroy(&sphb->iommu_as);
+    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
+    pci_unregister_root_bus(phb->bus);
+    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
+    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
+        memory_region_del_subregion(get_system_memory(), &sphb->mem64window);
+    }
+    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
 }
 
 static int spapr_phb_children_reset(Object *child, void *opaque)
