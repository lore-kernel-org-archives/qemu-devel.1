Received: from eggs.gnu.org ([2001:4830:134:3::10]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDlOh-000395-7G
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDlOd-000767-GJ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:37:51 -0400
Date: Wed, 2 May 2018 16:37:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180502063706.GD3517@umbus.fritz.box>
References: <20180502044557.21035-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <20180502044557.21035-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow backing bigger
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


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 02:45:57PM +1000, Alexey Kardashevskiy wrote:
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
> this later when creating a new DMA window.
>=20
> There should be no behavioral changes on platforms other than pseries.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

What will happen if you try to use this on an older kernel without
your mismatching pagesize changes?

> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              |  3 +++
>  hw/vfio/spapr.c               | 15 ++++++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d936014..dd8d0d3 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -83,6 +83,7 @@ typedef struct VFIOContainer {
>      unsigned iommu_type;
>      int error;
>      bool initialized;
> +    unsigned long pgsizes;
>      /*
>       * This assumes the host IOMMU can support only a single
>       * contiguous IOVA window.  We may need to generalize that in
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 07ffa0b..15ddef2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1103,6 +1103,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>              info.iova_pgsizes =3D 4096;
>          }
>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
> +        container->pgsizes =3D info.iova_pgsizes;
>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU))=
 {
>          struct vfio_iommu_spapr_tce_info info;
> @@ -1167,6 +1168,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>          }
> =20
>          if (v2) {
> +            container->pgsizes =3D info.ddw.pgsizes;
>              /*
>               * There is a default window in just created container.
>               * To make region_add/del simpler, we better remove this
> @@ -1181,6 +1183,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>              }
>          } else {
>              /* The default table uses 4K pages */
> +            container->pgsizes =3D 0x1000;
>              vfio_host_win_add(container, info.dma32_window_start,
>                                info.dma32_window_start +
>                                info.dma32_window_size - 1,
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 259397c..9637ed5 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -144,11 +144,24 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
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
> =20
>      /*
> +     * The host might not support the guest supported IOMMU page size,
> +     * so we will use smaller physical IOMMU pages to back them.
> +     */
> +    pagesize =3D 1ULL << ctz64(container->pgsizes & (pagesize | (pagesiz=
e - 1)));
> +    if (!pagesize) {
> +        error_report("Host doesn't support page size 0x%"PRIx64
> +                     ", the supported mask is 0x%lx",
> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> +                     container->pgsizes);
> +        return -EINVAL;
> +    }
> +
> +    /*
>       * FIXME: For VFIO iommu types which have KVM acceleration to
>       * avoid bouncing all map/unmaps through qemu this way, this
>       * would be the right place to wire that up (tell the KVM

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrpXI0ACgkQbDjKyiDZ
s5J9shAAidqMm7mOzprfffNesgSQOMV+l8wKvxaolKtDQMWJkaUIthD1zqNl+LBl
uArXJbN5C4USKw5qFNaoPSOrYJEx/X9/bgg1w6IPg4qlY0RjZtai45ow2V9JdCCk
QGAQfirKSgLp3oT/Gn2Nvbf97dFf40jzuxPTd9UgmxMdCP48xO8vSX4OQb9ScrGz
61ZxnEnLaHnX+Y3ZI5fvzZvDRZkBJj7t/NcFMyiibgLRTHnlOX0JuWZ+zkOXqyyc
Z+VPFdoWNYc1XUWAEkYy0KTggZsTJScZyn7ZL6GuA0G97Z+/wo1XniIoMt7S+kEc
vX107QSSz2XB1WeVLA7QvZarephKKlyoR49hABpTtQIV8P3jPd6Ry0hs1MgFNyKa
i6ofFLV2XkJoIYOcmcAOmwePUfxw6witlqIVKdT7XBqQoXMVJ4abfLU4PMDNWkFH
gqhnHSLvytHf3LYsxEie0GhvrQe6pLLuRLmTSlJwnUCpp6wwS4ApT3mQosSHDMnn
BmGGkfp3EEtR0Qo9vBHC3cPwsAaTgmtp09ibMJo7xydDi2wCddIgodfXvQT82iKx
pRKL2w4BcjA9uOL+Y6wTxmvNLBSrItFcwKj1nVqQWSa2GAWOG77Dg/SlHrAeVj22
7KxG/kfRNJpM2ThqU5SQs8phTTPwPHBIKBd2PZPaWwdtgPm7FEc=
=vv/u
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
