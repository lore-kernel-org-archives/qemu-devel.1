Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhRGU-0002HV-9I
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 23:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhRGQ-0007aP-CO
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 23:12:02 -0400
Date: Mon, 23 Jul 2018 13:11:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180723031142.GA6830@umbus.fritz.box>
References: <20180620091013.2224-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20180620091013.2224-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] vfio/spapr: Allow backing bigger
 guest IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 07:10:12PM +1000, Alexey Kardashevskiy wrote:
> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
> pages and POWER8 CPU supports the exact same set of page size so
> so far things worked fine.
>=20
> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
> the last two - 2M and 1G - are not even allowed in the paravirt interface
> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
> back guest's 16MB IOMMU pages with 2MB pages on the host.
>=20
> This stores the supported host IOMMU page sizes in VFIOContainer and uses
> this later when creating a new DMA window. This uses the system page size
> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
> the IOMMU pagesize.
>=20
> This changes the type of @pagesize to uint64_t as this is what
> memory_region_iommu_get_min_page_size() returns and clz64() takes.
>=20
> There should be no behavioral changes on platforms other than pseries.
> The guest will keep using the IOMMU page size selected by the PHB pagesize
> property as this only changes the underlying hardware TCE table
> granularity.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * fixed biggest but smaller page size calculation
> * limit IOMMU pagesize to the system pagesize

Sorry, this fell of my radar for a bit.

I've now applied it to ppc-for-3.1.

> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              |  3 +++
>  hw/vfio/spapr.c               | 21 ++++++++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a903692..c20524d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,7 @@ typedef struct VFIOContainer {
>      unsigned iommu_type;
>      int error;
>      bool initialized;
> +    unsigned long pgsizes;
>      /*
>       * This assumes the host IOMMU can support only a single
>       * contiguous IOVA window.  We may need to generalize that in
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fb396cf..40f0356 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1108,6 +1108,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>              info.iova_pgsizes =3D 4096;
>          }
>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
> +        container->pgsizes =3D info.iova_pgsizes;
>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU))=
 {
>          struct vfio_iommu_spapr_tce_info info;
> @@ -1172,6 +1173,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>          }
> =20
>          if (v2) {
> +            container->pgsizes =3D info.ddw.pgsizes;
>              /*
>               * There is a default window in just created container.
>               * To make region_add/del simpler, we better remove this
> @@ -1186,6 +1188,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>              }
>          } else {
>              /* The default table uses 4K pages */
> +            container->pgsizes =3D 0x1000;
>              vfio_host_win_add(container, info.dma32_window_start,
>                                info.dma32_window_start +
>                                info.dma32_window_size - 1,
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 259397c..becf71a 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -15,6 +15,7 @@
> =20
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/hw.h"
> +#include "exec/ram_addr.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
> =20
> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *containe=
r,
>  {
>      int ret;
>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
>      unsigned entries, pages;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
> +    long systempagesize =3D qemu_getrampagesize();
> +
> +    /*
> +     * The host might not support the guest supported IOMMU page size,
> +     * so we will use smaller physical IOMMU pages to back them.
> +     */
> +    if (pagesize > systempagesize) {
> +        pagesize =3D systempagesize;
> +    }
> +    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> +                                   (pagesize | (pagesize - 1))));
> +    if (!pagesize) {
> +        error_report("Host doesn't support page size 0x%"PRIx64
> +                     ", the supported mask is 0x%lx",
> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> +                     container->pgsizes);
> +        return -EINVAL;
> +    }
> =20
>      /*
>       * FIXME: For VFIO iommu types which have KVM acceleration to

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltVR2wACgkQbDjKyiDZ
s5K/XhAApec8r+hygpbbEqTdCxEIKnkn733c6qbHr5fw5x/qAswvS+PtOqpVjxSU
PW4o83ifHk5cLnl8nAlRp+XXDOpYGu+e79UVTqC93e9747bI7oaod9D5jbOtxufu
iLx6NFZUsbnQW3/EfPCwjwQhLGZXVfTirnV9eY4YPCA6BtstHzPZxS/qKSz8EW4+
XvSgOHwy2EGQ5iCq1EJLNGJB6JNZwd9mOsIk4G1EA674eNtJ4hcZ8ARZCz2Kg2XC
1oZb6fjrvSRKbz3OtvWCEnzI0Cy5sPsACRtw5ketV0vBukl9Dh1G1aIvbLcLZJof
AKMdVhfNpax9rUZH638m3XtHv+6e+IKxTCsCUkaBh132elff5DpeJ/UXSDMg/rbF
3g7yRNccePdDSOK0El3ib6q4gXQEH92xoVLsnZb4svEbpJ40rSpjtc2H/pkNJmVj
497Et2R+swYDSHube5eL6c0e7ssd7uCA4+uHklyie8b/InY89K8XtKs4VmRQmZHX
YYnahlFRFDO+CQL1emhNc05q3bn0CSEAV3yFURkB2/v2TAxzUHN6At+Ag5+/sozm
YYV5WMIOHTXT1rjVS+aynKSuvCd8M/3eQnBVfr45ERtToYQQqP/snp3i8Joko7UU
LTxAmyhp4vqsEAeiQi+tpcsz/OZ8i+Esl8YMpNukItXen8IbIwU=
=GMpF
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
