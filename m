Received: from eggs.gnu.org ([2001:4830:134:3::10]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb9f1-0007SJ-BF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fb9ey-0005Uw-6f
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:11:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fb9ey-0005Ua-05
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 15:11:20 -0400
Date: Thu, 5 Jul 2018 22:11:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180705220402-mutt-send-email-mst@kernel.org>
References: <20180705181148.26871-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180705181148.26871-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, Jul 05, 2018 at 08:11:48PM +0200, C=E9dric Le Goater wrote:
> PCI devices needing a ROM allocate an optional MemoryRegion with
> pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
> device is destroyed. The only action taken by this routine is to call
> vmstate_unregister_ram() which clears the id string of the optional
> ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
> was recently added by commit b895de502717 ("migration: discard
> non-migratable RAMBlocks"), .
>=20
> VFIO devices do their own allocation of the PCI ROM region. It is
> initialized in vfio_pci_size_rom() in which the PCI attribute
> 'has_rom' is set to true but the RAMBlock of the ROM region is not
> allocated. When the associated PCI device is deleted,
> pci_del_option_rom() calls vmstate_unregister_ram() which tries to
> flag a NULL RAMBlock because 'has_rom' is set, leading to a SEGV .
>=20
> The use of vmstate_unregister_ram() in the PCI device was added in
> commit b0e56e0b63f350691b52d3e75e89bb64143fbeff ("unset RAMBlock idstr
> when unregister MemoryRegion")

I don't see it in that commit. I think it was part of the original
split by Avi.

> and from the archive in
> http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html, it
> seems that it was trying to fix a reference count issue.
>=20
> vmstate_unregister_ram() being a work around, let's remove it to fix
> the current SEGV issue
> and let's try to find a fix for the initial ref
> count issue if we can reproduce.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

What kind of testing did you do on this patch? Could you include
that info in the commit log pls?

I think you need to at least add/remove some devices, then migrate.

> ---
>  hw/pci/pci.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc45930dee..78bf74e19f22 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -191,7 +191,6 @@ static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus=
_num);
>  static void pci_update_mappings(PCIDevice *d);
>  static void pci_irq_handler(void *opaque, int irq_num, int level);
>  static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, E=
rror **);
> -static void pci_del_option_rom(PCIDevice *pdev);
> =20
>  static uint16_t pci_default_sub_vendor_id =3D PCI_SUBVENDOR_ID_REDHAT_=
QUMRANET;
>  static uint16_t pci_default_sub_device_id =3D PCI_SUBDEVICE_ID_QEMU;
> @@ -1096,7 +1095,6 @@ static void pci_qdev_unrealize(DeviceState *dev, =
Error **errp)
>      PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
> =20
>      pci_unregister_io_regions(pci_dev);
> -    pci_del_option_rom(pci_dev);
> =20
>      if (pc->exit) {
>          pc->exit(pci_dev);
> @@ -2262,15 +2260,6 @@ static void pci_add_option_rom(PCIDevice *pdev, =
bool is_default_rom,
>      pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
>  }
> =20
> -static void pci_del_option_rom(PCIDevice *pdev)
> -{
> -    if (!pdev->has_rom)
> -        return;
> -
> -    vmstate_unregister_ram(&pdev->rom, &pdev->qdev);
> -    pdev->has_rom =3D false;
> -}
> -
>  /*
>   * On success, pci_add_capability() returns a positive value
>   * that the offset of the pci capability.
> --=20
> 2.13.6
