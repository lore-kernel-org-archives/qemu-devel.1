Received: from eggs.gnu.org ([2001:4830:134:3::10]:54428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fdLDo-0004xe-SA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fdLDl-0003HE-PR
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fdLDl-0003Gx-Jo
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:17 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA1795F72D
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 19:56:16 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 11 Jul 2018 13:56:13 -0600
Message-ID: <153133896639.31530.10135934557052494909.stgit@w520.home>
In-Reply-To: <153133890557.31530.586346402906852972.stgit@w520.home>
References: <153133890557.31530.586346402906852972.stgit@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] vfio/pci: do not set the PCIDevice
 'has_rom' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: C=C3=A9dric Le Goater <clg@kaod.org>

PCI devices needing a ROM allocate an optional MemoryRegion with
pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
device is destroyed. The only action taken by this routine is to call
vmstate_unregister_ram() which clears the id string of the optional
ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
was recently added by commit b895de502717 ("migration: discard
non-migratable RAMBlocks"), .

VFIO devices do their own loading of the PCI option ROM in
vfio_pci_size_rom(). The memory region is switched to an I/O region
and the PCI attribute 'has_rom' is set but the RAMBlock of the ROM
region is not allocated. When the associated PCI device is deleted,
pci_del_option_rom() calls vmstate_unregister_ram() which tries to
flag a NULL RAMBlock, leading to a SEGV.

It seems that 'has_rom' was set to have memory_region_destroy()
called, but since commit 469b046ead06 ("memory: remove
memory_region_destroy") this is not necessary anymore as the
MemoryRegion is freed automagically.

Remove the PCIDevice 'has_rom' attribute setting in vfio.

Fixes: b895de502717 ("migration: discard non-migratable RAMBlocks")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1577dea7fdb..6cbb8fa0549d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -990,7 +990,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     pci_register_bar(&vdev->pdev, PCI_ROM_SLOT,
                      PCI_BASE_ADDRESS_SPACE_MEMORY, &vdev->pdev.rom);
=20
-    vdev->pdev.has_rom =3D true;
     vdev->rom_read_failed =3D false;
 }
=20
