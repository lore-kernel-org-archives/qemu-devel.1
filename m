Received: from eggs.gnu.org ([2001:4830:134:3::10]:45187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiVHI-0002Ld-QJ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiVHF-0007Gj-PO
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:41:16 -0400
Date: Thu, 26 Jul 2018 11:41:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180726014104.GK6830@umbus.fritz.box>
References: <20180620091013.2224-1-aik@ozlabs.ru>
	<20180723031142.GA6830@umbus.fritz.box>
	<56186722-1b3a-2273-b3e3-b2a86c73869e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Content-Disposition: inline
In-Reply-To: <56186722-1b3a-2273-b3e3-b2a86c73869e@ozlabs.ru>
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


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 01:56:54PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/07/2018 13:11, David Gibson wrote:
> > On Wed, Jun 20, 2018 at 07:10:12PM +1000, Alexey Kardashevskiy wrote:
> >> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
> >> pages and POWER8 CPU supports the exact same set of page size so
> >> so far things worked fine.
> >>
> >> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
> >> the last two - 2M and 1G - are not even allowed in the paravirt interf=
ace
> >> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
> >> back guest's 16MB IOMMU pages with 2MB pages on the host.
> >>
> >> This stores the supported host IOMMU page sizes in VFIOContainer and u=
ses
> >> this later when creating a new DMA window. This uses the system page s=
ize
> >> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
> >> the IOMMU pagesize.
> >>
> >> This changes the type of @pagesize to uint64_t as this is what
> >> memory_region_iommu_get_min_page_size() returns and clz64() takes.
> >>
> >> There should be no behavioral changes on platforms other than pseries.
> >> The guest will keep using the IOMMU page size selected by the PHB page=
size
> >> property as this only changes the underlying hardware TCE table
> >> granularity.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >> Changes:
> >> v2:
> >> * fixed biggest but smaller page size calculation
> >> * limit IOMMU pagesize to the system pagesize
> >=20
> > Sorry, this fell of my radar for a bit.
> >=20
> > I've now applied it to ppc-for-3.1.
>=20
>=20
> Alex might object that as it does not have his "rb" ;)

Well, if he does I'll yank it from my tree.  It won't be going
upstream for a while yet.

>=20
>=20
> >=20
> >> ---
> >>  include/hw/vfio/vfio-common.h |  1 +
> >>  hw/vfio/common.c              |  3 +++
> >>  hw/vfio/spapr.c               | 21 ++++++++++++++++++++-
> >>  3 files changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
> >> index a903692..c20524d 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -73,6 +73,7 @@ typedef struct VFIOContainer {
> >>      unsigned iommu_type;
> >>      int error;
> >>      bool initialized;
> >> +    unsigned long pgsizes;
> >>      /*
> >>       * This assumes the host IOMMU can support only a single
> >>       * contiguous IOVA window.  We may need to generalize that in
> >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >> index fb396cf..40f0356 100644
> >> --- a/hw/vfio/common.c
> >> +++ b/hw/vfio/common.c
> >> @@ -1108,6 +1108,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >>              info.iova_pgsizes =3D 4096;
> >>          }
> >>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes=
);
> >> +        container->pgsizes =3D info.iova_pgsizes;
> >>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) =
||
> >>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMM=
U)) {
> >>          struct vfio_iommu_spapr_tce_info info;
> >> @@ -1172,6 +1173,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >>          }
> >> =20
> >>          if (v2) {
> >> +            container->pgsizes =3D info.ddw.pgsizes;
> >>              /*
> >>               * There is a default window in just created container.
> >>               * To make region_add/del simpler, we better remove this
> >> @@ -1186,6 +1188,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >>              }
> >>          } else {
> >>              /* The default table uses 4K pages */
> >> +            container->pgsizes =3D 0x1000;
> >>              vfio_host_win_add(container, info.dma32_window_start,
> >>                                info.dma32_window_start +
> >>                                info.dma32_window_size - 1,
> >> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> >> index 259397c..becf71a 100644
> >> --- a/hw/vfio/spapr.c
> >> +++ b/hw/vfio/spapr.c
> >> @@ -15,6 +15,7 @@
> >> =20
> >>  #include "hw/vfio/vfio-common.h"
> >>  #include "hw/hw.h"
> >> +#include "exec/ram_addr.h"
> >>  #include "qemu/error-report.h"
> >>  #include "trace.h"
> >> =20
> >> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
> >>  {
> >>      int ret;
> >>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> >> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
> >> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
> >>      unsigned entries, pages;
> >>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof=
(create) };
> >> +    long systempagesize =3D qemu_getrampagesize();
> >> +
> >> +    /*
> >> +     * The host might not support the guest supported IOMMU page size,
> >> +     * so we will use smaller physical IOMMU pages to back them.
> >> +     */
> >> +    if (pagesize > systempagesize) {
> >> +        pagesize =3D systempagesize;
> >> +    }
> >> +    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> >> +                                   (pagesize | (pagesize - 1))));
> >> +    if (!pagesize) {
> >> +        error_report("Host doesn't support page size 0x%"PRIx64
> >> +                     ", the supported mask is 0x%lx",
> >> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> >> +                     container->pgsizes);
> >> +        return -EINVAL;
> >> +    }
> >> =20
> >>      /*
> >>       * FIXME: For VFIO iommu types which have KVM acceleration to
> >=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltZJrAACgkQbDjKyiDZ
s5JCQw//W7SuzXwn4J33KiSU/q5GvMBSm/hsgjT0Tqhj6yXUUEyVHOEh+D/jbQi9
ZvVGoCHTuGqNHhMBbpIalPDbqm1vqvDOpWetBWQzyjWGCbe4UWKUuQPOgP/8szYU
UQ78rPvma0vgpTcLc/RX3kXRE5nriF2k5iyekdB2WkxWJm4d9Y0sceSMU+rUPDmh
kKyg2OvZw7Q3kWkJp8E6jFzinWt9S0dMvr7sYez2Z4Y9Wfz4E1RGwa6mfGV6JsnO
a7Cfaib+As6Mz/G2nyhFxeKP1BXiSmtQS0msIY/XX2/oXxjidtVtaFjBoBQ0IuMB
BVhd9NVPoOTahyeFPMR6eUGFmVMrHbH3i3BysLgQIqTm8cHQrjGet1InlYBhXCpX
GGkm94c+Z4mzWAZwk2Xc1LknQLVoE44/5JzdTe49AZQiygiFDU1qi363/tugfFpl
OydCcBTn6gVev5KG7xTH1sGz6rWqSJHTxlGuHdkL6GwY7UoXsHllVBr90+IzD1We
oAocDR+cgf+67xeY1GABqJcXqi1taVbaI+T7QMLZa/5HVpgS+cZ6cjsjwWZHLpS2
+8UY/clk3e1+hzY4AR5izEJhQmLRxQFQzt1HoE0ljy5OJVj0OUKNKvlrKq52ly+3
5qE4J4s7iCwxVnWuqDiyDeLZFAXJUk1CJzEBWYn24BNBrmLQDMI=
=Fni0
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--
