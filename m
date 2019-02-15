Received: from eggs.gnu.org ([209.51.188.92]:36139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guULs-0008U2-RN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guU8j-0007Lk-Hj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:26:14 -0500
Date: Fri, 15 Feb 2019 12:03:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215010317.GD4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <20190214052144.59541-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 1/4] vfio/spapr: Fix indirect
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 04:21:41PM +1100, Alexey Kardashevskiy wrote:
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

So, looking at this, it seems kind of bogus that qemu chooses the
number of levels, when those levels aren't really visible to it.  The
kernel has better information to choose a sensible number of levels -
witness qemu here attempting to guess what the kernel will do.

But, I guess the interface is what it is now, so,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * replace systempagesize with getpagesize() when calculating bits_per_lev=
el/max_levels
> ---
>  hw/vfio/spapr.c      | 41 ++++++++++++++++++++++++++++++++---------
>  hw/vfio/trace-events |  2 +-
>  2 files changed, 33 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index becf71a..302d6b0 100644
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
> index f41ca96..579be19 100644
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

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmD9MACgkQbDjKyiDZ
s5KxCRAAmJL2HXnfmKqzQDPnG+ozNWy1y+Lx3k99knQ/vZIUYY/bqWOubBtCJHQq
RaJJvB3CzhK+K1FhOEWZXuxc+aTuXEWS7W3JCoL3DWWupNaBFgn7KYgvj5AlyC6g
KI33lHi2zW4aHHIEqi29bZ8szIoRyWV5YJDdYdU5K6ZFvNdFwVdEUStfHjVPku0f
deUXwnVVUSpZ8Q/Vcdkv6UUu/M+WP/41Lq3vBSm7vVM3xhPCN8YwhdwzBEWRP3Uj
M2IDzjXNmCbam2eDjZC17SAjaFUjo/02Q4p0JvBVy4VfWxGJ4mTmbSSAgR7pefKT
HukkRR5E/ogvYI1s9JwEZHwOR1Wp2b2BNEx0WP5DRU8wAJnn0/yAUCVhrZrq0Cmc
q5PB8atNRUdcEOrWRGfWi7Xz22L78tWhLFU1UJFH19Igv7D5QkC4fWqs+5lhHVoB
v52WgCpkLG89E/B7yDjdiWUHv3TzRQLFGuZKyUjwUPKBDOZUCYiA+0kPUAPI+a5U
b7RU088HV8hE/v8AnAcgOml5GxWze/VZl0Fc97HpennCBo0Rp3dQNBP7mKHd7/hP
FXuYUdBN3Xgb9vELYJtyU152W9gbO3hTQWA7o7DVWATN5MrQwEXYX+hl+bieE27a
Jo/LgQT/dtqWDYkGZ3GgnZ9OzsThH+CnlbEtFFzv4zdl7nYX5rE=
=16uk
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
