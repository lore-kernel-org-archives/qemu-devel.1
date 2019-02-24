Received: from eggs.gnu.org ([209.51.188.92]:37043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3L0-0002bk-D4
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Kz-0003Lo-3N
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:38 -0500
Date: Mon, 25 Feb 2019 10:37:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190224233711.GD7668@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-3-david@gibson.dropbear.id.au>
	<20190222100822.73515a4d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20190222100822.73515a4d@bahia.lan>
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


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 10:08:22AM +0100, Greg Kurz wrote:
> On Thu, 14 Feb 2019 15:39:13 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The virtio-balloon device's verification of the address given to it by =
the
> > guest has a number of faults:
> >     * The addresses here are guest physical addresses, which should be
> >       'hwaddr' rather than 'ram_addr_t' (the distinction is admittedly
> >       pretty subtle and confusing)
> >     * We don't check for section.mr being NULL, which is the main way t=
hat
> >       memory_region_find() reports basic failures.  We really need to c=
heck
> >       that before looking at any other section fields, because
> >       memory_region_find() doesn't initialize them on the failure path
> >     * We're passing a length of '1' to memory_region_find(), but really=
 the
> >       guest is requesting that we put the entire page into the balloon,
> >       so it makes more sense to call it with BALLOON_PAGE_SIZE
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 43af521884..eb357824d8 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(VirtIODe=
vice *vdev, VirtQueue *vq)
> >          }
> > =20
> >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4=
) =3D=3D 4) {
> > -            ram_addr_t pa;
> > -            ram_addr_t addr;
> > +            hwaddr pa;
> > +            hwaddr addr;
> >              int p =3D virtio_ldl_p(vdev, &pfn);
> > =20
> > -            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> > +            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> >              offset +=3D 4;
> > =20
> > -            /* FIXME: remove get_system_memory(), but how? */
> > -            section =3D memory_region_find(get_system_memory(), pa, 1);
> > -            if (!int128_nz(section.size) ||
> > -                !memory_region_is_ram(section.mr) ||
> > +            section =3D memory_region_find(get_system_memory(), pa,
> > +                                         BALLOON_PAGE_SIZE);
> > +            if (!section.mr) {
> > +                trace_virtio_balloon_bad_addr(pa);
> > +                continue;
> > +            }
>=20
> memory_region_unref(section.mr) with section.mr =3D=3D NULL is safe and
> resolves to a nop. Not sure you need a separate if to handle this
> case.

memory_region_is_ram() and friends are not, however - they will
dereference their argument unconditionally.

>=20
> Apart from that,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +            if (!memory_region_is_ram(section.mr) ||
> >                  memory_region_is_rom(section.mr) ||
> >                  memory_region_is_romd(section.mr)) {
> >                  trace_virtio_balloon_bad_addr(pa);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzKqcACgkQbDjKyiDZ
s5I+uA/+OBU3C+aU6Re9845pogF2aT27JBooyD04Zej5Ni12kEnwvwwlbmLAkzEW
qV2IrYNN7WK7PI/go/K01tbrLvYWwOXZ+hN4AJOWKC/urj4IcyquHXVD5KWF3Vy4
/IK03lUt8kjiTSptaG15TzaoFU9S9MSAyyt1Ebs/hJk8cr03/Ej+OGEZLRY5tPRQ
Q3oiw/RAl5v848Fo0YkaG8j5XdqsZmnHpvKISYBrcCxrPCDi/cHoqmtfEVZe1VkX
3VXp3FsopcxicD/KAD9GMQ9/721r69izl1hbhA4VRE8/u2wTeDPIa57jsBT4/CIh
oC4nYZhqzRw3itBZHAbZ8MXaaVC8nPBw+8wVaOzqXn+xB/UBRrpu9vOmcdXRRMBq
wcl7dQjRziszxTKAUTiMMzVWiBfxh3SPP5s2vyyRaiJRCwEKstnHeMmdPrCHKGe0
OavrdohFGK0zS1nCGKNOkZ5OvbxkWj5hoNI0kTc98hXcyDgT/Mqmo54nCy0Gvla1
mUz3mq6hh+3DOL8AsZHZ0K8Hlhl53we9Z72RnwM4bcpVmNADKUt7XnS9WqkME/fC
r3tNmFUg9uqRqdc8qwruEvaNl3DD0HevLed7yLigg8mjVeW6Lvp9xZQp4bpP4vdY
uDP8B4tlBHpnB0Q6Z+Vo5pcnt7+O6MQP2kqSWnHeOwdMMntAJcs=
=0758
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
