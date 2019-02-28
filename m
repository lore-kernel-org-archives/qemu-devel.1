Received: from eggs.gnu.org ([209.51.188.92]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnj-0003x2-Ma
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnT-0005EE-QS
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:55:54 -0500
Date: Thu, 28 Feb 2019 13:24:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228022453.GD7734@umbus.fritz.box>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20190227085149.38596-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 2/6] vfio/spapr: Fix indirect
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 07:51:45PM +1100, Alexey Kardashevskiy wrote:
> The current code assumes that we can address more bits on a PCI bus
> for DMA than we really can but there is no way knowing the actual limit.
>=20
> This makes a better guess for the number of levels and if the kernel
> fails to allocate that, this increases the level numbers till succeeded
> or reached the 64bit limit.
>=20
> This adds levels to the trace point.
>=20
> This may cause the kernel to warn about failed allocation:
>    [65122.837458] Failed to allocate a TCE memory, level shift=3D28
> which might happen if MAX_ORDER is not large enough as it can vary:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/Kconfig?h=3Dv5.0-rc2#n727
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * replace systempagesize with getpagesize() when calculating
> bits_per_level/max_levels

As noted previously, guessing how the kernel will do this is pretty
gross, but the existing KVM interface kind of forces us to.  Plus it's
only non-optimal, not incorrect if we guess wrong.  So, applied.

> ---
>  hw/vfio/spapr.c      | 43 +++++++++++++++++++++++++++++++++----------
>  hw/vfio/trace-events |  2 +-
>  2 files changed, 34 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index becf71a..88437a7 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -143,10 +143,10 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
>                               MemoryRegionSection *section,
>                               hwaddr *pgsize)
>  {
> -    int ret;
> +    int ret =3D 0;
>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
>      uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
> -    unsigned entries, pages;
> +    unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
>      long systempagesize =3D qemu_getrampagesize();
> =20
> @@ -176,16 +176,38 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
>      create.window_size =3D int128_get64(section->size);
>      create.page_shift =3D ctz64(pagesize);
>      /*
> -     * SPAPR host supports multilevel TCE tables, there is some
> -     * heuristic to decide how many levels we want for our table:
> -     * 0..64 =3D 1; 65..4096 =3D 2; 4097..262144 =3D 3; 262145.. =3D 4
> +     * SPAPR host supports multilevel TCE tables. We try to guess optimal
> +     * levels number and if this fails (for example due to the host memo=
ry
> +     * fragmentation), we increase levels. The DMA address structure is:
> +     * rrrrrrrr rxxxxxxx xxxxxxxx xxxxxxxx  xxxxxxxx xxxxxxxx xxxxxxxx i=
iiiiiii
> +     * where:
> +     *   r =3D reserved (bits >=3D 55 are reserved in the existing hardw=
are)
> +     *   i =3D IOMMU page offset (64K in this example)
> +     *   x =3D bits to index a TCE which can be split to equal chunks to=
 index
> +     *      within the level.
> +     * The aim is to split "x" to smaller possible number of levels.
>       */
>      entries =3D create.window_size >> create.page_shift;
> -    pages =3D MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
> -    pages =3D MAX(pow2ceil(pages), 1); /* Round up */
> -    create.levels =3D ctz64(pages) / 6 + 1;
> -
> -    ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> +    /* bits_total is number of "x" needed */
> +    bits_total =3D ctz64(entries * sizeof(uint64_t));
> +    /*
> +     * bits_per_level is a safe guess of how much we can allocate per le=
vel:
> +     * 8 is the current minimum for CONFIG_FORCE_MAX_ZONEORDER and MAX_O=
RDER
> +     * is usually bigger than that.
> +     * Below we look at getpagesize() as TCEs are allocated from system =
pages.
> +     */
> +    bits_per_level =3D ctz64(getpagesize()) + 8;
> +    create.levels =3D bits_total / bits_per_level;
> +    if (bits_total % bits_per_level) {
> +        ++create.levels;
> +    }
> +    max_levels =3D (64 - create.page_shift) / ctz64(getpagesize());
> +    for ( ; create.levels <=3D max_levels; ++create.levels) {
> +        ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &creat=
e);
> +        if (!ret) {
> +            break;
> +        }
> +    }
>      if (ret) {
>          error_report("Failed to create a window, ret =3D %d (%m)", ret);
>          return -errno;
> @@ -200,6 +222,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>          return -EINVAL;
>      }
>      trace_vfio_spapr_create_window(create.page_shift,
> +                                   create.levels,
>                                     create.window_size,
>                                     create.start_addr);
>      *pgsize =3D pagesize;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ed2f333..cf1e886 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -129,6 +129,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, =
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

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3RnUACgkQbDjKyiDZ
s5LBLw//SGNrNULb64N24vOseh5wjlikqcsFz2GwGvhLrE3lVLjLwCm/BWnEOYpu
nZ9GzeKgF/9JmM8BPexSrTGWiD0VmnPunFxYkYWW2i89nb03BAhqxcAfFKLxvmFh
Rn4spmnjvC3nXXJPeeQL8SEUxzwlAhGn7cc5ngjEUAjYGZuyUxv+iQAlRevR1l64
82uvrIdhYXajn1PIhCuyP+buTRzT5xXNnlSVxBx637+FABAob+dARuyD9nuiHQsW
h5THs9c4AlPGWwZLgTtRB34rG99n1xGk1wYwZeSyejBPXpbg8+Zmmx4PyFx/FdDb
Agilz0LZX6LV28FKg2XrlD8Dztb2WSWxem6ftc6I7Rs1VTQfXfNtBYOUl7ZKSz0d
lbQhTt7Hga88Y70nW1wYrJH9GK+CJRfF+6zKVHbWO9+CiXRnRN6xsqFs3O9GG2lO
H+/h4RMI0ao6yzyz8aUFBoew03Bw3yosQn5rrqoAZoXWwpLva/y0J8DybtoEw7uf
MbEliCSHBjdL1tCC/FsLhL/wdM4KrCYgvrrhinsltv3nEQtDaaFZDozePnmAo6ck
A1QJ+kUJcVS96JtR5YHeSNu1xgUGKuL26hf5c22kHKwYTevCuHP8xJG2xUJ7l8S3
3+7e4BfO7hlQG/oN9lk/3vr0OkB+/1mjJEE6nBpPmiepEvm62Wk=
=NOL1
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
