Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fbULU-0002M8-Eg
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fbULP-0001h3-Qh
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fbULP-0001gp-HW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:16:31 -0400
Date: Fri, 6 Jul 2018 11:16:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180706111626.0a55d77b@t450s.home>
In-Reply-To: <20180706163614.23993-1-clg@kaod.org>
References: <20180706163614.23993-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: do not set the PCIDevice
 'has_rom' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Fri,  6 Jul 2018 18:36:14 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> PCI devices needing a ROM allocate an optional MemoryRegion with
> pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
> device is destroyed. The only action taken by this routine is to call
> vmstate_unregister_ram() which clears the id string of the optional
> ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
> was recently added by commit b895de502717 ("migration: discard
> non-migratable RAMBlocks"), .
>=20
> VFIO devices do their own loading of the PCI option ROM in
> vfio_pci_size_rom(). The memory region is switched to an I/O region
> and the PCI attribute 'has_rom' is set but the RAMBlock of the ROM
> region is not allocated. When the associated PCI device is deleted,
> pci_del_option_rom() calls vmstate_unregister_ram() which tries to
> flag a NULL RAMBlock, leading to a SEGV.
>=20
> It seems that 'has_rom' was set to have memory_region_destroy()
> called, but since commit 469b046ead06 ("memory: remove
> memory_region_destroy") this is not necessary anymore as the
> MemoryRegion is freed automagically.
>=20
> Remove the PCIDevice 'has_rom' attribute setting in vfio.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

I think the segfault can be attributed to:

fa53a0e53efd ("memory: drop find_ram_block()")

Prior to that vmstate_unregister_ram() called
memory_region_get_ram_addr() which would have resulted in
RAM_ADDR_INVALID.  This would have been passed to
qemu_ram_unset_idstr() which would have used find_ram_block() to lookup
the RAMBlock, which would be NULL for the invalid address, safely
avoiding any sort of segfault.

TL;DR, I'll add the above commit with a Fixes: tag for stable and
downstream releases, looks good otherwise.  Thanks,

Alex

> ---
>=20
>  Tested on a KVM POWER9 pseries machine and a Mellanox MT27710
>  Ethernet controller. Performed a couple of plug/unplug, migrated, and
>  did a couple more unplug/plug before powering off.
>=20
>  The same tests were done with the previous patches which were
>  addressing the issue at a different level :=20
>=20
>    1. [PATCH] exec.c: check RAMBlock validity before changing its flag
>       https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00009.html
>=20
>    2. [PATCH] pci: remove pci_del_option_rom()
>       https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg01651.html
>=20
>  Do we still want to remove pci_del_option_rom() ?
>=20
>  I caught this bug while deleting a passthrough device from a pseries
>  machine. Here is the stack:
>   =20
>    #0  qemu_ram_unset_migratable (rb=3D0x0) at /home/legoater/work/qemu/q=
emu-xive-3.0.git/exec.c:1994
>    #1  0x000000010072def0 in vmstate_unregister_ram (mr=3D0x101796af0, de=
v=3D<optimized out>)
>    #2  0x0000000100694e5c in pci_del_option_rom (pdev=3D0x101796330)
>    #3  pci_qdev_unrealize (dev=3D<optimized out>, errp=3D<optimized out>)
>    #4  0x00000001005ff910 in device_set_realized (obj=3D0x101796330, valu=
e=3D<optimized out>, errp=3D0x0)
>    #5  0x00000001007a487c in property_set_bool (obj=3D0x101796330, v=3D<o=
ptimized out>, name=3D<optimized out>,=20
>    #6  0x00000001007a7878 in object_property_set (obj=3D0x101796330, v=3D=
0x7fff70033110,=20
>    #7  0x00000001007aaf1c in object_property_set_qobject (obj=3D0x1017963=
30, value=3D<optimized out>,=20
>    #8  0x00000001007a7b90 in object_property_set_bool (obj=3D0x101796330,=
 value=3D<optimized out>,=20
>    #9  0x00000001005fcdd8 in device_unparent (obj=3D0x101796330)
>    #10 0x00000001007a6dd0 in object_finalize_child_property (obj=3D<optim=
ized out>, name=3D<optimized out>,=20
>    #11 0x00000001007a50c0 in object_property_del_child (obj=3D0x10111f800=
, child=3D0x101796330,=20
>    #12 0x0000000100425cc0 in spapr_phb_remove_pci_device_cb (dev=3D0x1017=
96330)
>    #13 0x0000000100427974 in spapr_drc_release (drc=3D0x1017e2df0)
>    #14 0x0000000100429098 in spapr_drc_detach (drc=3D0x1017e2df0)
>    #15 0x00000001004294e0 in drc_isolate_physical (drc=3D0x1017e2df0)
>    #16 0x000000010042a50c in rtas_set_isolation_state (state=3D0, idx=3D<=
optimized out>)
> =20
>  hw/vfio/pci.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a1577dea7fdb..6cbb8fa0549d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -990,7 +990,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>      pci_register_bar(&vdev->pdev, PCI_ROM_SLOT,
>                       PCI_BASE_ADDRESS_SPACE_MEMORY, &vdev->pdev.rom);
> =20
> -    vdev->pdev.has_rom =3D true;
>      vdev->rom_read_failed =3D false;
>  }
> =20
