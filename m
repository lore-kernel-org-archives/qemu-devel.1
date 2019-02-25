Received: from eggs.gnu.org ([209.51.188.92]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gyCXp-0007Wj-Us
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gyCXo-0006mF-0Y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:27:29 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:44793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gyCXj-0006Tq-TB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:27:25 -0500
Received: from player737.ha.ovh.net (unknown [10.109.143.146])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0270811C5EC
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 10:26:58 +0100 (CET)
Date: Mon, 25 Feb 2019 10:26:51 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190225102651.762e2520@bahia.lan>
In-Reply-To: <20190224233711.GD7668@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-3-david@gibson.dropbear.id.au>
	<20190222100822.73515a4d@bahia.lan>
	<20190224233711.GD7668@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/8=QYiygxEyObaqsx9qOLpor";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mst@redhat.com, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org

--Sig_/8=QYiygxEyObaqsx9qOLpor
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Feb 2019 10:37:11 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 22, 2019 at 10:08:22AM +0100, Greg Kurz wrote:
> > On Thu, 14 Feb 2019 15:39:13 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > The virtio-balloon device's verification of the address given to it b=
y the
> > > guest has a number of faults:
> > >     * The addresses here are guest physical addresses, which should be
> > >       'hwaddr' rather than 'ram_addr_t' (the distinction is admittedly
> > >       pretty subtle and confusing)
> > >     * We don't check for section.mr being NULL, which is the main way=
 that
> > >       memory_region_find() reports basic failures.  We really need to=
 check
> > >       that before looking at any other section fields, because
> > >       memory_region_find() doesn't initialize them on the failure path
> > >     * We're passing a length of '1' to memory_region_find(), but real=
ly the
> > >       guest is requesting that we put the entire page into the balloo=
n,
> > >       so it makes more sense to call it with BALLOON_PAGE_SIZE
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > > index 43af521884..eb357824d8 100644
> > > --- a/hw/virtio/virtio-balloon.c
> > > +++ b/hw/virtio/virtio-balloon.c
> > > @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(VirtIO=
Device *vdev, VirtQueue *vq)
> > >          }
> > > =20
> > >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn,=
 4) =3D=3D 4) {
> > > -            ram_addr_t pa;
> > > -            ram_addr_t addr;
> > > +            hwaddr pa;
> > > +            hwaddr addr;
> > >              int p =3D virtio_ldl_p(vdev, &pfn);
> > > =20
> > > -            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> > > +            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> > >              offset +=3D 4;
> > > =20
> > > -            /* FIXME: remove get_system_memory(), but how? */
> > > -            section =3D memory_region_find(get_system_memory(), pa, =
1);
> > > -            if (!int128_nz(section.size) ||
> > > -                !memory_region_is_ram(section.mr) ||
> > > +            section =3D memory_region_find(get_system_memory(), pa,
> > > +                                         BALLOON_PAGE_SIZE);
> > > +            if (!section.mr) {
> > > +                trace_virtio_balloon_bad_addr(pa);
> > > +                continue;
> > > +            } =20
> >=20
> > memory_region_unref(section.mr) with section.mr =3D=3D NULL is safe and
> > resolves to a nop. Not sure you need a separate if to handle this
> > case. =20
>=20
> memory_region_is_ram() and friends are not, however - they will
> dereference their argument unconditionally.
>=20

Indeed but the two ifs can be merged anyway:

            if (!section.mr ||
                !memory_region_is_ram(section.mr) ||
                memory_region_is_rom(section.mr) ||
                memory_region_is_romd(section.mr)) {
                trace_virtio_balloon_bad_addr(pa);
                memory_region_unref(section.mr);
                continue;
            }

> >=20
> > Apart from that,
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >  =20
> > > +            if (!memory_region_is_ram(section.mr) ||
> > >                  memory_region_is_rom(section.mr) ||
> > >                  memory_region_is_romd(section.mr)) {
> > >                  trace_virtio_balloon_bad_addr(pa); =20
> >  =20
>=20


--Sig_/8=QYiygxEyObaqsx9qOLpor
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxztNsACgkQcdTV5YIv
c9bi0Q/+JObWXZqwTsp9L8YEl7a/3CoNRs25T3qQZZasrk0AFmwQdX+u8Pj+qME5
VxiJH4OK8kI6zGnOrHStkBo5Y6UFEy3ayXWiSpMcSuLyOqrfr2crFAZak5aa/Ewv
fSmP6115SgWzf72Y2m1LNGGVCYG9MfXYwN1E3dHWtHjD4NDq44KeU2hC+knm0hwb
wzPuMvQWkMELLLwva/7T7RKGgGmU0YM1Mtyz02fDPZbyRZM60PKhdaAFfAeRyriC
4oeaWOjYkvOPOJGi8o9ia6VGHdMNMwAurJVkH1uATUCWxj8UH2YTkqYksc4QkI3O
6X5Y2tmxDHQxXyXmJU2VE4ikv6IhDFuxlq3zhLSyILdLoUSEV8VF+HjRaYGWsf2I
y1DM442qGaqnCuq80oF/W1dlbFAMh7r6aeGGxgrBRjkTBoh6EMXJNm8xUinFoalz
7wARvKTM4MFnLt0Unw3EH9XagnTNHY9h+YKcIfpvkbYZMi40VeXAm/VJi4+ijrc/
ydOaV1n6eYE/eZd5scru15sHUVdiqx89T7qujgkE1GzYNl1EIM0aEOXEDuHO3HHF
xXcOhI04q7ML2LYtFm02AsTXqkaWhHD28TTp81leRCJR+ex3tSfzhChoZJGBk0OL
sflIfMvD6mVIKsua6wqCNrrwPCHsopGHGRECSmLXQb8N6EIBY9A=
=cEb+
-----END PGP SIGNATURE-----

--Sig_/8=QYiygxEyObaqsx9qOLpor--
