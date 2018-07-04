Received: from eggs.gnu.org ([2001:4830:134:3::10]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faXVa-0004cZ-Gs
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faXVV-0001mw-IK
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:27:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faXVV-0001mU-CL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 22:27:01 -0400
Date: Wed, 4 Jul 2018 10:26:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180704022648.GA2568@xz-mi>
References: <20180701171953.9921-1-clg@kaod.org> <20180702035726.GK2455@xz-mi>
	<b5f38492-22a4-aa8a-ab42-f7e06c28c753@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5f38492-22a4-aa8a-ab42-f7e06c28c753@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec.c: check RAMBlock validity before
 changing its flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Jul 03, 2018 at 02:45:24PM +0200, C=C3=A9dric Le Goater wrote:
> On 07/02/2018 05:57 AM, Peter Xu wrote:
> > On Sun, Jul 01, 2018 at 07:19:53PM +0200, C=C3=A9dric Le Goater wrote=
:
> >> When a PCI device is unplugged, the PCI memory regions are deleted
> >> before the optional ROM RAMBlock is flagged non-migratable. But, whe=
n
> >> this is done, the RAMBlock has already been cleared from the region,
> >> leading to a segv.
> >>
> >> Fix the issue by testing the RAMBlock before flagging it, as it is
> >> done in qemu_ram_unset_idstr()
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>
> >>  I caught this bug while deleting a passthrough device from a pserie=
s
> >>  machine. Here is the stack:
> >>   =20
> >>    #0  qemu_ram_unset_migratable (rb=3D0x0) at /home/legoater/work/q=
emu/qemu-xive-3.0.git/exec.c:1994
> >>    #1  0x000000010072def0 in vmstate_unregister_ram (mr=3D0x101796af=
0, dev=3D<optimized out>)
> >>    #2  0x0000000100694e5c in pci_del_option_rom (pdev=3D0x101796330)
> >>    #3  pci_qdev_unrealize (dev=3D<optimized out>, errp=3D<optimized =
out>)
> >>    #4  0x00000001005ff910 in device_set_realized (obj=3D0x101796330,=
 value=3D<optimized out>, errp=3D0x0)
> >>    #5  0x00000001007a487c in property_set_bool (obj=3D0x101796330, v=
=3D<optimized out>, name=3D<optimized out>,=20
> >>    #6  0x00000001007a7878 in object_property_set (obj=3D0x101796330,=
 v=3D0x7fff70033110,=20
> >>    #7  0x00000001007aaf1c in object_property_set_qobject (obj=3D0x10=
1796330, value=3D<optimized out>,=20
> >>    #8  0x00000001007a7b90 in object_property_set_bool (obj=3D0x10179=
6330, value=3D<optimized out>,=20
> >>    #9  0x00000001005fcdd8 in device_unparent (obj=3D0x101796330)
> >>    #10 0x00000001007a6dd0 in object_finalize_child_property (obj=3D<=
optimized out>, name=3D<optimized out>,=20
> >>    #11 0x00000001007a50c0 in object_property_del_child (obj=3D0x1011=
1f800, child=3D0x101796330,=20
> >>    #12 0x0000000100425cc0 in spapr_phb_remove_pci_device_cb (dev=3D0=
x101796330)
> >>    #13 0x0000000100427974 in spapr_drc_release (drc=3D0x1017e2df0)
> >>    #14 0x0000000100429098 in spapr_drc_detach (drc=3D0x1017e2df0)
> >>    #15 0x00000001004294e0 in drc_isolate_physical (drc=3D0x1017e2df0=
)
> >>    #16 0x000000010042a50c in rtas_set_isolation_state (state=3D0, id=
x=3D<optimized out>)
> >>
> >>  May be we should call pci_del_option_rom() before
> >>  pci_unregister_io_regions() ?
> >=20
> > This seems to make more sense to me.
> >=20
> > Meanwhile I assume the name pci_del_option_rom() is a bit misleading =
-
> > it's not really deleting the ROM but unregistering the ROM only.
> > Instead IIUC it's pci_unregister_io_regions() which deleted that. So
> > maybe we can either rename the function pci_del_option_rom(), or we
> > can pick the ROM destruction out of pci_unregister_io_regions() and
> > put it into pci_del_option_rom() to make sure it's done as the last
> > step?
>=20
> So it is a little more complex than I thought.=20
>=20
> The PCI device is a vfio PCI device and the PCI ROM region is initializ=
ed=20
> in vfio_pci_size_rom() with memory_region_init_io(), which does not=20
> allocate the RAMBlock, but has_rom is still set to true.=20
>=20
> When the device is deleted, pci_del_option_rom() is called and with it,=
 vmstate_unregister_ram() because has_rom is set to true. Leading to the
> SEGV.
>=20
> I am not sure how to handle this case. It seems that the realize routin=
e=20
> of VFIOPCIDevice is hijacking a little the PCIDevice layer.

Indeed.

Then now I'm a bit confused on who actually deleted the ROM memory
region that was created when pci_add_option_rom() was called.  It
seems to be leaked.

AFAIU the rest of the memory regions of the BARs (0-5) are managed by
specific device emulation code, however this ROM memory region is
managed by PCI subsystem.  Not sure whether that means we should
destroy the region in PCI subsystem too, e.g. in pci_del_option_rom().

And now I see this patch might be a valid fix for the VFIO-specific
issue (though we might comment that a bit somewhere).

Thanks,

--=20
Peter Xu
