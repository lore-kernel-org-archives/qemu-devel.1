Received: from eggs.gnu.org ([209.51.188.92]:35321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gymHY-0006In-Ba
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gymHM-0003yG-9N
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:36:55 -0500
Date: Wed, 27 Feb 2019 10:20:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226232012.GT6872@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-3-david@gibson.dropbear.id.au>
	<20190222100822.73515a4d@bahia.lan>
	<20190224233711.GD7668@umbus.fritz.box>
	<20190225102651.762e2520@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="15k5Fuw+yLfT1d9X"
Content-Disposition: inline
In-Reply-To: <20190225102651.762e2520@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/5] virtio-balloon: Corrections
 to address verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mst@redhat.com, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org


--15k5Fuw+yLfT1d9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 10:26:51AM +0100, Greg Kurz wrote:
> On Mon, 25 Feb 2019 10:37:11 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Feb 22, 2019 at 10:08:22AM +0100, Greg Kurz wrote:
> > > On Thu, 14 Feb 2019 15:39:13 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > The virtio-balloon device's verification of the address given to it=
 by the
> > > > guest has a number of faults:
> > > >     * The addresses here are guest physical addresses, which should=
 be
> > > >       'hwaddr' rather than 'ram_addr_t' (the distinction is admitte=
dly
> > > >       pretty subtle and confusing)
> > > >     * We don't check for section.mr being NULL, which is the main w=
ay that
> > > >       memory_region_find() reports basic failures.  We really need =
to check
> > > >       that before looking at any other section fields, because
> > > >       memory_region_find() doesn't initialize them on the failure p=
ath
> > > >     * We're passing a length of '1' to memory_region_find(), but re=
ally the
> > > >       guest is requesting that we put the entire page into the ball=
oon,
> > > >       so it makes more sense to call it with BALLOON_PAGE_SIZE
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
> > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > > > index 43af521884..eb357824d8 100644
> > > > --- a/hw/virtio/virtio-balloon.c
> > > > +++ b/hw/virtio/virtio-balloon.c
> > > > @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(Virt=
IODevice *vdev, VirtQueue *vq)
> > > >          }
> > > > =20
> > > >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pf=
n, 4) =3D=3D 4) {
> > > > -            ram_addr_t pa;
> > > > -            ram_addr_t addr;
> > > > +            hwaddr pa;
> > > > +            hwaddr addr;
> > > >              int p =3D virtio_ldl_p(vdev, &pfn);
> > > > =20
> > > > -            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> > > > +            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> > > >              offset +=3D 4;
> > > > =20
> > > > -            /* FIXME: remove get_system_memory(), but how? */
> > > > -            section =3D memory_region_find(get_system_memory(), pa=
, 1);
> > > > -            if (!int128_nz(section.size) ||
> > > > -                !memory_region_is_ram(section.mr) ||
> > > > +            section =3D memory_region_find(get_system_memory(), pa,
> > > > +                                         BALLOON_PAGE_SIZE);
> > > > +            if (!section.mr) {
> > > > +                trace_virtio_balloon_bad_addr(pa);
> > > > +                continue;
> > > > +            } =20
> > >=20
> > > memory_region_unref(section.mr) with section.mr =3D=3D NULL is safe a=
nd
> > > resolves to a nop. Not sure you need a separate if to handle this
> > > case. =20
> >=20
> > memory_region_is_ram() and friends are not, however - they will
> > dereference their argument unconditionally.
> >=20
>=20
> Indeed but the two ifs can be merged anyway:
>=20
>             if (!section.mr ||
>                 !memory_region_is_ram(section.mr) ||
>                 memory_region_is_rom(section.mr) ||
>                 memory_region_is_romd(section.mr)) {
>                 trace_virtio_balloon_bad_addr(pa);
>                 memory_region_unref(section.mr);
>                 continue;
>             }

Oh, I see what you mean.  Hrm, I still kind of prefer visually
separating the validity check from tests which depend on that validity.

>=20
> > >=20
> > > Apart from that,
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > >  =20
> > > > +            if (!memory_region_is_ram(section.mr) ||
> > > >                  memory_region_is_rom(section.mr) ||
> > > >                  memory_region_is_romd(section.mr)) {
> > > >                  trace_virtio_balloon_bad_addr(pa); =20
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--15k5Fuw+yLfT1d9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1yawACgkQbDjKyiDZ
s5K79hAAi0WpOgckoAef4N3al9aIj/puSMVHuW+gU6q5hDwdUpNkADW+hJCcKlZP
DgQfYELKHyFzWp//GuvXuBhfPJha32LS/RoFKpV1mrZcwhG5+4tdm+P0GTzPYVUe
kIO1T2488yhfWQzQsjy9T5BhTYEMQgZ6c8ANGKDFhnbDeYVRXZnF0C4BGwNobHCM
b0ATnzWJY1IjGVSf+wyCShkfji20sUMHdyILFUXUSMYRIFl2WxtAMtHCVFBPABkS
Pq/CkA+lR/xlPq3YsiymvnkJnwF7EdrFAj7q0LSeSvtxeBBckA46KiLZgAZCOKp9
Izv6hO/L8tslb9lbkn97+jt2rDeRhxwoaf1zmDHHbGcbxIllJAAPRKkPAqtEENlb
TlwajWCFrnXHTKbxxTgQXXYTkJ+cBPPGweqHziVKBcQZRy5talVipJWw0U8VvFfw
JoRZwOW5DIKXQ2E+H5o4dOUkM7TTTHZu3BDoRk/3llgwAn8dU/GAsLpNx0K0u7o7
smpCfmcPJc7J8tBBjfBpyPknmtvpcA79NWz70R2LN0utMf5AOj8zkykfdWNUKiiI
rSqVnJzKgvBR6T708KsWF6NshFqd2KhcEgYb4a/fIMX0fS65TAg1gCSLy/e7OfUa
smO6wflye3uqm7gNFkqksiJ6I4zJiL9Lz/+m+MiHQrOVqB3sQ9s=
=k+k5
-----END PGP SIGNATURE-----

--15k5Fuw+yLfT1d9X--
