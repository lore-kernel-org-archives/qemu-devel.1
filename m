Received: from eggs.gnu.org ([209.51.188.92]:47795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqtgw-000706-Od
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 00:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqtgv-00085I-Hj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 00:54:42 -0500
Date: Tue, 5 Feb 2019 16:54:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190205055427.GK22661@umbus.fritz.box>
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<20190117025115.81178-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
In-Reply-To: <20190117025115.81178-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 1/3] vfio/spapr: Fix indirect levels
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 01:51:13PM +1100, Alexey Kardashevskiy wrote:
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
>  hw/vfio/spapr.c      | 38 +++++++++++++++++++++++++++++---------
>  hw/vfio/trace-events |  2 +-
>  2 files changed, 30 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index becf71a..2675bf5 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -146,7 +146,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>      int ret;
>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
>      uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
> -    unsigned entries, pages;
> +    unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
>      long systempagesize =3D qemu_getrampagesize();

So, "systempagesize" is a bad name, since this is *not* the system
page size, but rather the (minimum) page size we're using to map guest
RAM...

> @@ -176,16 +176,35 @@ int vfio_spapr_create_window(VFIOContainer *contain=
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
> +    bits_total =3D ctz64((entries * sizeof(uint64_t)));
> +    /*
> +     * bits_per_level is a safe guess of how much we can allocate per le=
vel:
> +     * 8 is the current minimum for CONFIG_FORCE_MAX_ZONEORDER and MAX_O=
RDER
> +     * is usually bigger than that.
> +     */
> +    bits_per_level =3D ctz64(systempagesize) + 8;

=2E.which is relevant, because here you really do want the system page
size, since you're guestimating what the kernel will be able to put on
a page, entirely unrelated to the guest page size.

> +    create.levels =3D bits_total / bits_per_level;

Don't you need a div-rounded-up here?

> +    create.levels =3D MAX(1, create.levels);
> +    max_levels =3D (64 - create.page_shift) / ctz64(systempagesize);

And I think you want the real system page size here again.

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
> @@ -200,6 +219,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>          return -EINVAL;
>      }
>      trace_vfio_spapr_create_window(create.page_shift,
> +                                   create.levels,
>                                     create.window_size,
>                                     create.start_addr);
>      *pgsize =3D pagesize;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 0f9f810..adfa75e 100644
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

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZJREACgkQbDjKyiDZ
s5JbyhAAxgDxi2KWTB7U/TPXynP2OCcii46pC80+veBiSH9MpUlBZLhX9P5OFJ2D
lgcTWngzsCd4FJkWA1HVv8DDI7CEHWHQYyLEeqx/HYjn5ivC4Wj3LJHzijjGVvPG
Vw6HrAPPJ4lVMv2lW5G5XM94x6XD9ndcTl5iNdcjPlWZ+RTjnOJRmrXN3DgTll5Z
ovrnqw2Na4qnE0aQlyB5+bu6IDXpC1kfR2dCEHxPAcvRXvlJN4z6ODzbvtXWBVGg
bROjfxz7IDAUrJ9DMyWrobdNnrpo5jhpemwR/v5JMpbUgujkRmg3zY6gvJniYYDi
6j9c+J3kGrUwp/JLJpXeWhHLM+eViKBR/QEekpCB6L98J2pZfHHoJgbdeKO3jt/+
LmIhQQwNt+6BSu98mdoByAGH8Q2dJb+jnnyaVvSQ5mVxVKPOKEAW3LQEHYxWBqSn
YEA9MuorrUjLSBEMX1gcKEv2H4q7TPaPCHPoK0Ka5toemBt5s5Lp0ReOS68T3Zqv
VL5KvmL3DJHUQUsPp6NpSOCFDxvM36Z5u2pSNNtiB4OhsnWSXAiHkjJqVdnnghLg
eexO1OEEloVh1kTb9CE6NAkCuydrFuJQZUpgqBfJCX7x7gGmh58SB5wJbMlaU+W/
AdtsEylWxpdDNCaTnQf5xjPIjts7VIttK4HhRrA/X9/iOz86xT4=
=sOg8
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
