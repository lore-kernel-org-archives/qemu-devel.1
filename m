Received: from eggs.gnu.org ([2001:4830:134:3::10]:33817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2fZ-0005MH-IY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 21:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2fW-0002d7-A1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 21:04:25 -0400
Date: Thu, 3 May 2018 11:03:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503010342.GE13229@umbus.fritz.box>
References: <20180502044557.21035-1-aik@ozlabs.ru>
	<20180502063706.GD3517@umbus.fritz.box>
	<43ff86df-7368-3857-1443-2cbde839039b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <43ff86df-7368-3857-1443-2cbde839039b@ozlabs.ru>
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


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 06:59:53PM +1000, Alexey Kardashevskiy wrote:
> On 2/5/18 4:37 pm, David Gibson wrote:
> > On Wed, May 02, 2018 at 02:45:57PM +1000, Alexey Kardashevskiy wrote:
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
> >> this later when creating a new DMA window.
> >>
> >> There should be no behavioral changes on platforms other than pseries.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > What will happen if you try to use this on an older kernel without
> > your mismatching pagesize changes?
>=20
> I tried 1GB huge pages and "-global spapr-pci-host-bridge.pgsz=3D0x101100=
0"
> or 0x41011000.

With a hash guest or a radix guest?

> With or without this change and kernel change, the P9 host says:
>=20
> pci 0001:01     : [PE# fd] Disabling 64-bit DMA bypass
>=20
> pci 0001:01     : [PE# fd] Removing DMA window #0
>=20
> pci 0001:01     : [PE# fd] Setting up window#0 0..3fffffff pg=3D1000
>=20
> pci 0001:01     : [PE# fd] Setting up window#1
> 800000000000000..800001fffffffff pg=3D1000000
> pci 0001:01     : [PE# fd] Failed to configure TCE table, err -1
>=20
> pci 0001:01     : [PE# fd] Removing DMA window #1
>=20
>=20
> Which is a failure from opal_pci_map_pe_dma_window().


> QEMU calls hw_error:
>=20
> xhci_hcd 0000:00:00.0: xHCI Host Controller
> xhci_hcd 0000:00:00.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:00:00.0: node is /pci@800000020000000/usb@0
> 5700@1525248659.671888:spapr_iommu_ddw_query buid=3D0x800000020000000
> addr=3D0x0, 1 windows available, max window size=3D0x800000
> 00, mask=3D0x7
> xhci_hcd 0000:00:00.0: ibm,query-pe-dma-windows(2026) 0 8000000 20000000
> returned 0
> 5700@1525248659.672138:spapr_iommu_new_table liobn=3D0x80000001
> table=3D0x7fffb9080000 fd=3D26
> qemu-system-ppc64: Failed to create a window, ret =3D -1 (Operation not
> permitted)
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> CPU #0:
> NIP 000000000daf0010   LR 000000000000c11c CTR c00000000fe80000 XER
> 0000000020040000 CPU#0
> MSR 0000000002001000 HID0 0000000000000000  HF 8000000000000000 iidx 3 di=
dx 3
> TB 00000000 00000000 DECR 00000000
> GPR00 8000000002001031 c00000007e503230 c0000000013a1f00 000000000000f000
> GPR04 00000000014007d0 000000000daf0000 0000000002001000 8000000002001033
> GPR08 0000000000000000 8000000000002933 000000000000000c 000000000daf0000
> GPR12 0000000000008000 c00000000fe80000 c00000000000def8 0000000008000000
> GPR16 0000000000000000 0000000020000000 000000000000001f 0000000000000000
> GPR20 c00000007e034440 0000000000000018 c000000009164900 c00000007fffab78
> GPR24 c0000000012e6768 c000000001529394 0000000000000001 0000000000000005
> GPR28 0000000000002027 c0000000014007b0 c00000007e50351c 0000000000000004

Yeah, it'd be nice to handle this failure a bit more gracefully.

> aaand I found a bug below...
>=20
>=20
> >=20
> >> ---
> >>  include/hw/vfio/vfio-common.h |  1 +
> >>  hw/vfio/common.c              |  3 +++
> >>  hw/vfio/spapr.c               | 15 ++++++++++++++-
> >>  3 files changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
> >> index d936014..dd8d0d3 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -83,6 +83,7 @@ typedef struct VFIOContainer {
> >>      unsigned iommu_type;
> >>      int error;
> >>      bool initialized;
> >> +    unsigned long pgsizes;
> >>      /*
> >>       * This assumes the host IOMMU can support only a single
> >>       * contiguous IOVA window.  We may need to generalize that in
> >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >> index 07ffa0b..15ddef2 100644
> >> --- a/hw/vfio/common.c
> >> +++ b/hw/vfio/common.c
> >> @@ -1103,6 +1103,7 @@ static int vfio_connect_container(VFIOGroup *gro=
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
> >> @@ -1167,6 +1168,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >>          }
> >> =20
> >>          if (v2) {
> >> +            container->pgsizes =3D info.ddw.pgsizes;
> >>              /*
> >>               * There is a default window in just created container.
> >>               * To make region_add/del simpler, we better remove this
> >> @@ -1181,6 +1183,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >>              }
> >>          } else {
> >>              /* The default table uses 4K pages */
> >> +            container->pgsizes =3D 0x1000;
> >>              vfio_host_win_add(container, info.dma32_window_start,
> >>                                info.dma32_window_start +
> >>                                info.dma32_window_size - 1,
> >> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> >> index 259397c..9637ed5 100644
> >> --- a/hw/vfio/spapr.c
> >> +++ b/hw/vfio/spapr.c
> >> @@ -144,11 +144,24 @@ int vfio_spapr_create_window(VFIOContainer *cont=
ainer,
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
> >> =20
> >>      /*
> >> +     * The host might not support the guest supported IOMMU page size,
> >> +     * so we will use smaller physical IOMMU pages to back them.
> >> +     */
> >> +    pagesize =3D 1ULL << ctz64(container->pgsizes & (pagesize | (page=
size - 1)));
>=20
>=20
>=20
> ... and here is a bug - must be:
>=20
> pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
>                                (pagesize | (pagesize - 1))));
>=20
>=20
> With the original version, it picked 4K page size, created a huge window
> with 4K pages but KVM VFIO device did not attach to LIOBN because of page
> size mismatch (guest sees 16M, vfio sees 4K) so actual TCE table remained
> empty and EEH happened (and recovered later after killing QEMU).

Ah, yes.  You want to pick the biggest host pagesize smaller than the
guest one, not the smallest.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqX+4ACgkQbDjKyiDZ
s5Kg3w//eBqkXPXO7uOBAx6V2J6O4TxgSwelKl1yfAzw0jAor7g6MRsM11c2/sri
6j2rOFUf7r84/Dnk+P+hkL/LwlPZhRDlOZeF+kLzlzxhKoIPSJtM6PfTtAQ6rrBi
8MW679FVkQNxsMY1YdJQmm9ryr9uNlwKGmFLyXvRaGlzJnHZscEsv4Kp0HtBG7lo
QFi2YjH139dyXGUbI5G3aioYB405z8ib8XTdFHmRSCKeuw1ixxZLjn4UKat3myU9
h++HymCXYFbB93rFbZ/XbT5OC2fU4diT9m7gcCg7WevHa1UUeX4rmxFRCj9QOQsi
DhiSdRQr2c1jMBCFQqFTb8VmMfQzMVo9U+pOKZ7T/2+AZciaV511g57dyb4zOtpU
Qq+aT/ggVwJg2z2oiEmom5befy7V7fBi5tXSrvDCmbyhpJIP8J9BlSyiNkZOp2Cj
ApLRT18msTSaNw6RilntDYNhvinWSlSFrG1JhGF778nRlMR18Wx8asFnxlTKmpZV
WiOQ8z8FGo2nIxyJj1ZPvfZjCO5aU53phOGN16EV0AypN6BVm3ABDeGOEGuP2/JN
0nxQ5QiSfbjNHaDnS8acI3hvcCNXMunlO6QLjH0mGDaCxCvdvbszYzIGBmDJyFfC
a1cWk8dQrcy0ibLVcpFDCXvcE9mptIq/g2RpqDeqeRCUGKo6Ago=
=Q5YM
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
