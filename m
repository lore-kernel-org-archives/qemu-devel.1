Received: from eggs.gnu.org ([2001:4830:134:3::10]:56242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fb8jj-0007HE-V6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fb8je-00024H-UX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:12:11 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:57280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fb8je-00023n-Nw
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:12:06 -0400
Received: from player693.ha.ovh.net (unknown [10.109.122.113])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id EDF24F93AB
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 20:12:04 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  5 Jul 2018 20:11:48 +0200
Message-Id: <20180705181148.26871-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

PCI devices needing a ROM allocate an optional MemoryRegion with
pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
device is destroyed. The only action taken by this routine is to call
vmstate_unregister_ram() which clears the id string of the optional
ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
was recently added by commit b895de502717 ("migration: discard
non-migratable RAMBlocks"), .

VFIO devices do their own allocation of the PCI ROM region. It is
initialized in vfio_pci_size_rom() in which the PCI attribute
'has_rom' is set to true but the RAMBlock of the ROM region is not
allocated. When the associated PCI device is deleted,
pci_del_option_rom() calls vmstate_unregister_ram() which tries to
flag a NULL RAMBlock because 'has_rom' is set, leading to a SEGV .

The use of vmstate_unregister_ram() in the PCI device was added in
commit b0e56e0b63f350691b52d3e75e89bb64143fbeff ("unset RAMBlock idstr
when unregister MemoryRegion") and from the archive in
http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html, it
seems that it was trying to fix a reference count issue.

vmstate_unregister_ram() being a work around, let's remove it to fix
the current SEGV issue and let's try to find a fix for the initial ref
count issue if we can reproduce.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/pci/pci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 80bc45930dee..78bf74e19f22 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -191,7 +191,6 @@ static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_n=
um);
 static void pci_update_mappings(PCIDevice *d);
 static void pci_irq_handler(void *opaque, int irq_num, int level);
 static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, Err=
or **);
-static void pci_del_option_rom(PCIDevice *pdev);
=20
 static uint16_t pci_default_sub_vendor_id =3D PCI_SUBVENDOR_ID_REDHAT_QU=
MRANET;
 static uint16_t pci_default_sub_device_id =3D PCI_SUBDEVICE_ID_QEMU;
@@ -1096,7 +1095,6 @@ static void pci_qdev_unrealize(DeviceState *dev, Er=
ror **errp)
     PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
=20
     pci_unregister_io_regions(pci_dev);
-    pci_del_option_rom(pci_dev);
=20
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -2262,15 +2260,6 @@ static void pci_add_option_rom(PCIDevice *pdev, bo=
ol is_default_rom,
     pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
 }
=20
-static void pci_del_option_rom(PCIDevice *pdev)
-{
-    if (!pdev->has_rom)
-        return;
-
-    vmstate_unregister_ram(&pdev->rom, &pdev->qdev);
-    pdev->has_rom =3D false;
-}
-
 /*
  * On success, pci_add_capability() returns a positive value
  * that the offset of the pci capability.
--=20
2.13.6
