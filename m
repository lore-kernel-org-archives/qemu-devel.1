Received: from eggs.gnu.org ([209.51.188.92]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzHhH-0002xx-Mc
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzHhF-0003lx-Rl
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:09:43 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:57751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzHhA-0003fq-RP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:09:39 -0500
Received: from player739.ha.ovh.net (unknown [10.109.146.32])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CABEB185F65
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:24 +0100 (CET)
Date: Thu, 28 Feb 2019 10:09:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190228100917.7761bbfb@bahia.lan>
In-Reply-To: <20190226232012.GT6872@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-3-david@gibson.dropbear.id.au>
	<20190222100822.73515a4d@bahia.lan>
	<20190224233711.GD7668@umbus.fritz.box>
	<20190225102651.762e2520@bahia.lan>
	<20190226232012.GT6872@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/AKTYFNSwXPc1oUmAaqMbQG9";
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
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

--Sig_/AKTYFNSwXPc1oUmAaqMbQG9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Feb 2019 10:20:12 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Feb 25, 2019 at 10:26:51AM +0100, Greg Kurz wrote:
> > On Mon, 25 Feb 2019 10:37:11 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Feb 22, 2019 at 10:08:22AM +0100, Greg Kurz wrote: =20
> > > > On Thu, 14 Feb 2019 15:39:13 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > The virtio-balloon device's verification of the address given to =
it by the
> > > > > guest has a number of faults:
> > > > >     * The addresses here are guest physical addresses, which shou=
ld be
> > > > >       'hwaddr' rather than 'ram_addr_t' (the distinction is admit=
tedly
> > > > >       pretty subtle and confusing)
> > > > >     * We don't check for section.mr being NULL, which is the main=
 way that
> > > > >       memory_region_find() reports basic failures.  We really nee=
d to check
> > > > >       that before looking at any other section fields, because
> > > > >       memory_region_find() doesn't initialize them on the failure=
 path
> > > > >     * We're passing a length of '1' to memory_region_find(), but =
really the
> > > > >       guest is requesting that we put the entire page into the ba=
lloon,
> > > > >       so it makes more sense to call it with BALLOON_PAGE_SIZE
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
> > > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloo=
n.c
> > > > > index 43af521884..eb357824d8 100644
> > > > > --- a/hw/virtio/virtio-balloon.c
> > > > > +++ b/hw/virtio/virtio-balloon.c
> > > > > @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(Vi=
rtIODevice *vdev, VirtQueue *vq)
> > > > >          }
> > > > > =20
> > > > >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &=
pfn, 4) =3D=3D 4) {
> > > > > -            ram_addr_t pa;
> > > > > -            ram_addr_t addr;
> > > > > +            hwaddr pa;
> > > > > +            hwaddr addr;
> > > > >              int p =3D virtio_ldl_p(vdev, &pfn);
> > > > > =20
> > > > > -            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> > > > > +            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> > > > >              offset +=3D 4;
> > > > > =20
> > > > > -            /* FIXME: remove get_system_memory(), but how? */
> > > > > -            section =3D memory_region_find(get_system_memory(), =
pa, 1);
> > > > > -            if (!int128_nz(section.size) ||
> > > > > -                !memory_region_is_ram(section.mr) ||
> > > > > +            section =3D memory_region_find(get_system_memory(), =
pa,
> > > > > +                                         BALLOON_PAGE_SIZE);
> > > > > +            if (!section.mr) {
> > > > > +                trace_virtio_balloon_bad_addr(pa);
> > > > > +                continue;
> > > > > +            }   =20
> > > >=20
> > > > memory_region_unref(section.mr) with section.mr =3D=3D NULL is safe=
 and
> > > > resolves to a nop. Not sure you need a separate if to handle this
> > > > case.   =20
> > >=20
> > > memory_region_is_ram() and friends are not, however - they will
> > > dereference their argument unconditionally.
> > >  =20
> >=20
> > Indeed but the two ifs can be merged anyway:
> >=20
> >             if (!section.mr ||
> >                 !memory_region_is_ram(section.mr) ||
> >                 memory_region_is_rom(section.mr) ||
> >                 memory_region_is_romd(section.mr)) {
> >                 trace_virtio_balloon_bad_addr(pa);
> >                 memory_region_unref(section.mr);
> >                 continue;
> >             } =20
>=20
> Oh, I see what you mean.  Hrm, I still kind of prefer visually
> separating the validity check from tests which depend on that validity.
>=20

Makes sense. It's alright then :)

> >  =20
> > > >=20
> > > > Apart from that,
> > > >=20
> > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > >    =20
> > > > > +            if (!memory_region_is_ram(section.mr) ||
> > > > >                  memory_region_is_rom(section.mr) ||
> > > > >                  memory_region_is_romd(section.mr)) {
> > > > >                  trace_virtio_balloon_bad_addr(pa);   =20
> > > >    =20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/AKTYFNSwXPc1oUmAaqMbQG9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlx3pT0ACgkQcdTV5YIv
c9Y/0RAAmZDnTZSEyJxW7q/9NcvHh/nte6wrog5rRkncI+6gxJ87QB0TmyX/YUjU
KDhNtlKt0cMPZTgDEGouxbg0FWRABbNflAXFbOUwhBAL/7yvsGt4s2kzQ3y0pUbn
wYlbhIiycb7W8hYhobHqzUusGOT3qaySLlaKWqLJTKAKWsLZTqMCX97qBibh7wRA
6+k2y4DrXk7Sj7o1juO8/0FF/RZH4fuOti1d+mr99OSjMCaofX5Vnd5Nyct8h1lk
JxuJ/G835rM5lrssyU/SeWtZk8BQl/WRtfzOJXDzT5G/vT2UIWV9Oxn5avKrZLV0
cxdq+LQKo/dPsaChQy0s0DnwYNJWbWKbixOo/mWLMVAIZ2JTWwXzAdnuJ0Dy8nP3
kT2WVXc+mf2V9z+7O1pv3kLnjzJf9OHcDyzG7UzQx3SkmPJTJg0i/5Gu4CrfPsn/
X9mSzvozndksXLBzpxox44rzthdMtgt65bkw4PAs0/s6hk56s+ihcTpTqjZOFx8f
buB0h5Ixa+GJw7oUGKbLMiTqwv3fsx/6DWZgVdu4jpFJhxyhbhtARWyG+yf9Vbze
MX/cxfhIsHgZ0AeM98r9k7GYxz9h7TDZMNJLgZrYdsSQvkSS6zMP1J0IYIsKKsfP
iqIYTQODttKtXAkpMadxCDvkYFZRaGunxemXMvHOtR0v9Mp2KEo=
=+Xe1
-----END PGP SIGNATURE-----

--Sig_/AKTYFNSwXPc1oUmAaqMbQG9--
