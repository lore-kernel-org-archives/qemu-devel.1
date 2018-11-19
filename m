Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpG-0005vb-6X
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpF-0002Fo-58
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:14 -0500
Date: Mon, 19 Nov 2018 12:45:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119014513.GC23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20181113083104.2692-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu RFC 1/7] vfio/spapr: Fix indirect
 levels calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:30:58PM +1100, Alexey Kardashevskiy wrote:
> The current code assumes that we can address more bits on a PCI bus
> for DMA than we really can. Limit to the known tested maximum of 55 bits
> and assume 64K IOMMU pages.

This doesn't make much sense to me.  It looks nothing like the
calculation it's replacing, and not just for extreme values.  For
example the new calculation doesn't depend on the size of the window
at all, whereas the previous one did.  You say you're assuming 64k
IOMMU pages, but create.page_shift (the actual IOMMU page size) is in
there.  Nor is it clear to me why the maximum PCI address is relevant
to the number of levels in the first place.

In addition, AFAICT the new calculation gives the answer '2' for all
likely IOMMU page sizes (4k, 64k, 2M)

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/vfio/spapr.c      | 3 ++-
>  hw/vfio/trace-events | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index becf71a..f5fdc53 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -183,7 +183,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>      entries =3D create.window_size >> create.page_shift;
>      pages =3D MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
>      pages =3D MAX(pow2ceil(pages), 1); /* Round up */
> -    create.levels =3D ctz64(pages) / 6 + 1;
> +    create.levels =3D MAX(1, (55 - create.page_shift) / 16);
> =20
>      ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
>      if (ret) {
> @@ -200,6 +200,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>          return -EINVAL;
>      }
>      trace_vfio_spapr_create_window(create.page_shift,
> +                                   create.levels,
>                                     create.window_size,
>                                     create.start_addr);
>      *pgsize =3D pagesize;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index a85e866..db730f3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -128,6 +128,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, =
uint64_t end) "0x%"PRIx64"
>  vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"=
PRIx64" - 0x%"PRIx64
>  vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=3D0x%"PRIx=
64" size=3D0x%"PRIx64" ret=3D%d"
>  vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=3D0x%"PR=
Ix64" size=3D0x%"PRIx64" ret=3D%d"
> -vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=
=3D0x%x winsize=3D0x%"PRIx64" offset=3D0x%"PRIx64
> +vfio_spapr_create_window(int ps, unsigned int levels, uint64_t ws, uint6=
4_t off) "pageshift=3D0x%x levels=3D%u winsize=3D0x%"PRIx64" offset=3D0x%"P=
RIx64
>  vfio_spapr_remove_window(uint64_t off) "offset=3D0x%"PRIx64
>  vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d t=
o liobn fd %d"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyFaYACgkQbDjKyiDZ
s5JgdhAA0CAI+pYPCaXVYQkGiGysNExX4lksRzctxDTSvYIv/QJIYoCyzLBh8AKv
+Ci8buIJI0WgHTtAL1cPfyHHFDG3orAfBUt+8vLHMiH1hAcuAWOmwS428JSl8+nj
2qI86lYIX+TMbkqqeQit5OODPxxD2IxQha8wB9iV0eAvBVl4P7ftA9ANd9Ck+n7m
p8Qa8zTO2vdPGwg/HcNEVaf4EvvsRILy7evOIS357jyMRc/8nHNFBfY9ikGwYddv
f/9xC0LZqh4NjnOPgeNpcyvJJ09VvGZ/7/eaALcXKF44V/yqxr+FL6pVWyI24zBg
XNlBfmPYCm6DMXHtv4KHAPsph9PCBv3zik8ZdrfDpE8OFRJj9P9RAr9U6AWXtC/2
9fNQ8SsBcN+Geq7qe9AYGiD4h2bMlqrQ4+f5tZtMoKKoKINxERNQGBi59Wzcs4OL
W0YRJ6LFwtMsjDLj5OL7op/39DbKsDFih1yX7d+XL6t1YSO/D2jtWZZ+sp/JyfK2
M0G9OwvGUyXNuDDpFR4Ee3iWECOLlfOAEbKZU84VvcInaPTp9KTr+9KZXGcjTrSS
A2Zs5cbQLqVOfUavwFypi6tbsGxXs3/aTnXaz71oztmi1P7lMHKFZGL9Ln7BwFiL
m0CEm9ics5SBaOGmz29xWzHy0MBAzULJhwcuy+lPW+OUKz/TO0E=
=yW5+
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
