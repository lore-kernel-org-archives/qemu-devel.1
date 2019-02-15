Received: from eggs.gnu.org ([209.51.188.92]:40439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guUkT-0007t7-1I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guUd8-0004sQ-W7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:57:39 -0500
Date: Fri, 15 Feb 2019 14:57:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215035718.GJ4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-3-aik@ozlabs.ru>
	<20190215033202.GH4573@umbus.fritz.box>
	<50c941bc-8705-2519-737b-b688edfde395@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <50c941bc-8705-2519-737b-b688edfde395@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 2/4] vfio/spapr: Rename local
 systempagesize variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:37:55PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 15/02/2019 14:32, David Gibson wrote:
> > On Thu, Feb 14, 2019 at 04:21:42PM +1100, Alexey Kardashevskiy wrote:
> >> The "systempagesize" name suggests that it is the host system page size
> >> while it is the smallest page size of memory backing the guest RAM so
> >> let's rename it to stop confusion. This should cause no behavioral cha=
nge.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  hw/vfio/spapr.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> >> index 302d6b0..1498fee 100644
> >> --- a/hw/vfio/spapr.c
> >> +++ b/hw/vfio/spapr.c
> >> @@ -148,14 +148,14 @@ int vfio_spapr_create_window(VFIOContainer *cont=
ainer,
> >>      uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
> >>      unsigned entries, bits_total, bits_per_level, max_levels;
> >>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof=
(create) };
> >> -    long systempagesize =3D qemu_getrampagesize();
> >> +    long minpagesize =3D qemu_getrampagesize();
> >=20
> > I'd prefer "rampagesize" or "minrampagesize" here.  "minpagesize"
> > doesn't make it clear what it's the minimum of, whereas rampagesize at
> > least makes it clear it's the same thing that qemu_getrampagesize() is
> > working with.
>=20
> In my mind "ram" in this context is a guest RAM but here is it not (is
> is backend)

Well.. it is guest RAM, in that we're only considering the backing
page size for memory mapped into the guest as RAM.  I guess it is a
host page size, but then guest page sizes don't really exist until the
guest starts mapping things (and may not be unique, since it could
map the same memory in multiple ways).

> so I just avoided using any specifics in the name (system,
> ram) to make the reader of this code look around where the value comes
> from which is the qemu_getrampagesize() helper (more descriptive name).
>=20
>=20
>=20
> >=20
> >>      /*
> >>       * The host might not support the guest supported IOMMU page size,
> >>       * so we will use smaller physical IOMMU pages to back them.
> >>       */
> >> -    if (pagesize > systempagesize) {
> >> -        pagesize =3D systempagesize;
> >> +    if (pagesize > minpagesize) {
> >> +        pagesize =3D minpagesize;
> >>      }
> >>      pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> >>                                     (pagesize | (pagesize - 1))));
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmOJ4ACgkQbDjKyiDZ
s5JQPw//axuhJmwKvgFUxFgQPjWJFRJzy6tlyX9Pjr1Ovgy1tlYgFcEd/mTElIz+
XcGXtjqafXVDQakdulqzPmJ1qZLJ6iWgqGzRUleb5i2uldsdXBwWMVAz6RiR+1+O
OP1s3XRxdxrVj3N/5e299yWBj2XWbNv/GqDj54yQzs+B10nbLgAZzSLuu1U3vdP1
fquv6zswqkR2Vzyjomc7Zi2DR8+/NfWJxaclCmackg3YgaUxTK8tyF8k9ZVWJluC
MzNBkdMRge76bqzy1Zeh1VEqwIDkSDhZwyecY5vUDQUA6yAeYn1NLHOa+IBKe2VI
Zf+eVAyfL1fJC4oFW7gRe2uYyHJM2uXwKSeQM0cW47IQzhG+SxZ09p1wIqYi/H/b
4EFpXncy+aoYhdG2WSF6qeef62uAA4TDSGF4F5m8gMcUuCEvl1qhecm+wTRRKesT
Z5ROEo4PqBjKjbseYpeDHpFCWy2gnYo19ygGOunGwj6B1i+h+V3JNoHY+oS97Ncj
M/wTtEL4vX5+g892RUeHLCBpqfd15pNcn6aU23j59BoTyJzgOd4ZwQtuz/QOguX+
D5/7wPGUVwELzxoIIPxQmbxdI871jokHUeMeql/1ZpcZYZRroPxq9rDdEKNwBGbD
WNBpEKr4/D89uyiw5PrlBBewngxCfJ7iMv6IgL3s7YSrtJqicrM=
=Uzck
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
