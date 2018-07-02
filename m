Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZpy9-0003qE-MK
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fZpy6-0000HP-H5
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fZpy6-0000GX-Ao
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 23:57:38 -0400
Date: Mon, 2 Jul 2018 11:57:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180702035726.GK2455@xz-mi>
References: <20180701171953.9921-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180701171953.9921-1-clg@kaod.org>
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

On Sun, Jul 01, 2018 at 07:19:53PM +0200, C=C3=A9dric Le Goater wrote:
> When a PCI device is unplugged, the PCI memory regions are deleted
> before the optional ROM RAMBlock is flagged non-migratable. But, when
> this is done, the RAMBlock has already been cleared from the region,
> leading to a segv.
>=20
> Fix the issue by testing the RAMBlock before flagging it, as it is
> done in qemu_ram_unset_idstr()
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20
>  I caught this bug while deleting a passthrough device from a pseries
>  machine. Here is the stack:
>   =20
>    #0  qemu_ram_unset_migratable (rb=3D0x0) at /home/legoater/work/qemu=
/qemu-xive-3.0.git/exec.c:1994
>    #1  0x000000010072def0 in vmstate_unregister_ram (mr=3D0x101796af0, =
dev=3D<optimized out>)
>    #2  0x0000000100694e5c in pci_del_option_rom (pdev=3D0x101796330)
>    #3  pci_qdev_unrealize (dev=3D<optimized out>, errp=3D<optimized out=
>)
>    #4  0x00000001005ff910 in device_set_realized (obj=3D0x101796330, va=
lue=3D<optimized out>, errp=3D0x0)
>    #5  0x00000001007a487c in property_set_bool (obj=3D0x101796330, v=3D=
<optimized out>, name=3D<optimized out>,=20
>    #6  0x00000001007a7878 in object_property_set (obj=3D0x101796330, v=3D=
0x7fff70033110,=20
>    #7  0x00000001007aaf1c in object_property_set_qobject (obj=3D0x10179=
6330, value=3D<optimized out>,=20
>    #8  0x00000001007a7b90 in object_property_set_bool (obj=3D0x10179633=
0, value=3D<optimized out>,=20
>    #9  0x00000001005fcdd8 in device_unparent (obj=3D0x101796330)
>    #10 0x00000001007a6dd0 in object_finalize_child_property (obj=3D<opt=
imized out>, name=3D<optimized out>,=20
>    #11 0x00000001007a50c0 in object_property_del_child (obj=3D0x10111f8=
00, child=3D0x101796330,=20
>    #12 0x0000000100425cc0 in spapr_phb_remove_pci_device_cb (dev=3D0x10=
1796330)
>    #13 0x0000000100427974 in spapr_drc_release (drc=3D0x1017e2df0)
>    #14 0x0000000100429098 in spapr_drc_detach (drc=3D0x1017e2df0)
>    #15 0x00000001004294e0 in drc_isolate_physical (drc=3D0x1017e2df0)
>    #16 0x000000010042a50c in rtas_set_isolation_state (state=3D0, idx=3D=
<optimized out>)
>=20
>  May be we should call pci_del_option_rom() before
>  pci_unregister_io_regions() ?

This seems to make more sense to me.

Meanwhile I assume the name pci_del_option_rom() is a bit misleading -
it's not really deleting the ROM but unregistering the ROM only.
Instead IIUC it's pci_unregister_io_regions() which deleted that. So
maybe we can either rename the function pci_del_option_rom(), or we
can pick the ROM destruction out of pci_unregister_io_regions() and
put it into pci_del_option_rom() to make sure it's done as the last
step?

Regards,

>=20
>  exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/exec.c b/exec.c
> index ebadc0e302ad..0dabf7380438 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1992,7 +1992,9 @@ void qemu_ram_set_migratable(RAMBlock *rb)
> =20
>  void qemu_ram_unset_migratable(RAMBlock *rb)
>  {
> -    rb->flags &=3D ~RAM_MIGRATABLE;
> +    if (rb) {
> +        rb->flags &=3D ~RAM_MIGRATABLE;
> +    }
>  }
> =20
>  /* Called with iothread lock held.  */
> --=20
> 2.13.6
>=20
>=20

--=20
Peter Xu
