Received: from eggs.gnu.org ([2001:4830:134:3::10]:38152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fhoS9-0004zu-Mh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 23:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fhoS6-00009k-Lp
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 23:57:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fhoS6-000091-Cn
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 23:57:34 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6-v6so1869781pgv.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 20:57:33 -0700 (PDT)
References: <20180620091013.2224-1-aik@ozlabs.ru>
	<20180723031142.GA6830@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56186722-1b3a-2273-b3e3-b2a86c73869e@ozlabs.ru>
Date: Tue, 24 Jul 2018 13:56:54 +1000
MIME-Version: 1.0
In-Reply-To: <20180723031142.GA6830@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sQJjMP0WT7E9cgxGZSZmR3AKgkPzZIgUZ"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sQJjMP0WT7E9cgxGZSZmR3AKgkPzZIgUZ
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <56186722-1b3a-2273-b3e3-b2a86c73869e@ozlabs.ru>
Subject: Re: [PATCH qemu v2] vfio/spapr: Allow backing bigger guest IOMMU
 pages with smaller physical pages
References: <20180620091013.2224-1-aik@ozlabs.ru>
 <20180723031142.GA6830@umbus.fritz.box>
In-Reply-To: <20180723031142.GA6830@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/07/2018 13:11, David Gibson wrote:
> On Wed, Jun 20, 2018 at 07:10:12PM +1000, Alexey Kardashevskiy wrote:
>> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
>> pages and POWER8 CPU supports the exact same set of page size so
>> so far things worked fine.
>>
>> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
>> the last two - 2M and 1G - are not even allowed in the paravirt interf=
ace
>> (RTAS DDW) so we always end up using 64K IOMMU pages, although we coul=
d
>> back guest's 16MB IOMMU pages with 2MB pages on the host.
>>
>> This stores the supported host IOMMU page sizes in VFIOContainer and u=
ses
>> this later when creating a new DMA window. This uses the system page s=
ize
>> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
>> the IOMMU pagesize.
>>
>> This changes the type of @pagesize to uint64_t as this is what
>> memory_region_iommu_get_min_page_size() returns and clz64() takes.
>>
>> There should be no behavioral changes on platforms other than pseries.=

>> The guest will keep using the IOMMU page size selected by the PHB page=
size
>> property as this only changes the underlying hardware TCE table
>> granularity.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * fixed biggest but smaller page size calculation
>> * limit IOMMU pagesize to the system pagesize
>=20
> Sorry, this fell of my radar for a bit.
>=20
> I've now applied it to ppc-for-3.1.


Alex might object that as it does not have his "rb" ;)


>=20
>> ---
>>  include/hw/vfio/vfio-common.h |  1 +
>>  hw/vfio/common.c              |  3 +++
>>  hw/vfio/spapr.c               | 21 ++++++++++++++++++++-
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
>> index a903692..c20524d 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -73,6 +73,7 @@ typedef struct VFIOContainer {
>>      unsigned iommu_type;
>>      int error;
>>      bool initialized;
>> +    unsigned long pgsizes;
>>      /*
>>       * This assumes the host IOMMU can support only a single
>>       * contiguous IOVA window.  We may need to generalize that in
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index fb396cf..40f0356 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1108,6 +1108,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
>>              info.iova_pgsizes =3D 4096;
>>          }
>>          vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes=
);
>> +        container->pgsizes =3D info.iova_pgsizes;
>>      } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) =
||
>>                 ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMM=
U)) {
>>          struct vfio_iommu_spapr_tce_info info;
>> @@ -1172,6 +1173,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
>>          }
>> =20
>>          if (v2) {
>> +            container->pgsizes =3D info.ddw.pgsizes;
>>              /*
>>               * There is a default window in just created container.
>>               * To make region_add/del simpler, we better remove this
>> @@ -1186,6 +1188,7 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
>>              }
>>          } else {
>>              /* The default table uses 4K pages */
>> +            container->pgsizes =3D 0x1000;
>>              vfio_host_win_add(container, info.dma32_window_start,
>>                                info.dma32_window_start +
>>                                info.dma32_window_size - 1,
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 259397c..becf71a 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -15,6 +15,7 @@
>> =20
>>  #include "hw/vfio/vfio-common.h"
>>  #include "hw/hw.h"
>> +#include "exec/ram_addr.h"
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>> =20
>> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
>>  {
>>      int ret;
>>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);=

>> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
>> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
>>      unsigned entries, pages;
>>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof=
(create) };
>> +    long systempagesize =3D qemu_getrampagesize();
>> +
>> +    /*
>> +     * The host might not support the guest supported IOMMU page size=
,
>> +     * so we will use smaller physical IOMMU pages to back them.
>> +     */
>> +    if (pagesize > systempagesize) {
>> +        pagesize =3D systempagesize;
>> +    }
>> +    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
>> +                                   (pagesize | (pagesize - 1))));
>> +    if (!pagesize) {
>> +        error_report("Host doesn't support page size 0x%"PRIx64
>> +                     ", the supported mask is 0x%lx",
>> +                     memory_region_iommu_get_min_page_size(iommu_mr),=

>> +                     container->pgsizes);
>> +        return -EINVAL;
>> +    }
>> =20
>>      /*
>>       * FIXME: For VFIO iommu types which have KVM acceleration to
>=20

--=20
Alexey


--sQJjMP0WT7E9cgxGZSZmR3AKgkPzZIgUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAltWo6cACgkQze7KtGKK
021n2A//YONQSU11brwbwabwAgX2jC7u5cs4ZsCau8IFpbC0Xof0t673xBlxQ2ks
O50fzJQZA7Xyug7sBEjbqp59uCNfJYGGPNi3AIr1HGQ6JJloxio5Wbn3YFCt8gVm
89/EoyRYXa2ltzcn8FWGqc66Cu1Tk41FnQyCIAPgh67fBsNCfuZQdgESdljLYz19
Uc11xOX6r7OGbmrPTZZa0yOn2ntF+1KNoWCOOuxjHuJOTZ2mBuwFEVDFcNq3+2iH
VfTLg+MYYRr3Srvhcey2IOD/D7ySmEQIwPB72cg5+AiVv4pwpf6ZhlkxrTnemrY5
Dtmks2NggtfI9cO4SkE0V9CpkqAeB1w6WI5+i2h6mJxRx+PucLMDWWFQ8vTABD6O
DBbFkXOnyRdljyc9AqqJjdnTWgezp1T4oD7HBInZoZc0AkXUJ+Uifnw8VDpEoYFY
D3mLTXce0fhPC2ZOTibXLAllkQR9TDMFkhPJMzqb3NfxBbhhPJL7p7R/v+znCIbN
PuvqrJ+dcB5YME+qh1wfDwSpOC+G81IOjNikWywDmDqJEbMJq9B0FMxMU0/nvYui
mxMyLSvPEK0g364wg0HhaXTdeEh7uLlcjd+G6BT5EYQ7ttU++FOs0iZGR9OOoYmY
OQBVpGxw3e27CVmiOnDlkdVujsTbYe4/OQ9CN+gtqN+EZXLXKCU=
=uKCp
-----END PGP SIGNATURE-----

--sQJjMP0WT7E9cgxGZSZmR3AKgkPzZIgUZ--
