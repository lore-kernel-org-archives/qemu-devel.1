Received: from eggs.gnu.org ([2001:4830:134:3::10]:42075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etM14-0003rm-3a
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etM10-0007n4-4k
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:29:06 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 7 Mar 2018 00:15:15 +0100
Message-Id: <20180306232851.8DD617456A5@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] sii3112: Remove unneeded exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>

An exit function was mistakenly left here but it's not needed because
the PCI bars are organised differently in this device. Calling this
exit function during device_del was causing an abort with
memory_region_del_subregion: `Assertion subregion->container == mr' failed.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/sii3112.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index e3896c6..743a50e 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -327,17 +327,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
     qemu_register_reset(sii3112_reset, s);
 }
 
-static void sii3112_pci_exitfn(PCIDevice *dev)
-{
-    PCIIDEState *d = PCI_IDE(dev);
-    int i;
-
-    for (i = 0; i < 2; ++i) {
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
-        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
-    }
-}
-
 static void sii3112_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -348,7 +337,6 @@ static void sii3112_pci_class_init(ObjectClass *klass, void *data)
     pd->class_id = PCI_CLASS_STORAGE_RAID;
     pd->revision = 1;
     pd->realize = sii3112_pci_realize;
-    pd->exit = sii3112_pci_exitfn;
     dc->desc = "SiI3112A SATA controller";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
-- 
2.7.6
