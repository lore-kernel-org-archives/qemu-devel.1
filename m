Received: from eggs.gnu.org ([2001:4830:134:3::10]:55360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1el8Bh-0001Z4-8i
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1el8Bd-0005sB-R4
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:06:05 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1el8Bd-0005rW-HX
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:06:01 -0500
Received: by mail-ot0-x243.google.com with SMTP id l10so13103781oth.1
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 23:06:01 -0800 (PST)
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
Date: Mon, 12 Feb 2018 18:05:54 +1100
MIME-Version: 1.0
In-Reply-To: <20180212051954.GE11634@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pOXEMTJUiq3nfK4pUII58QaWsvti7NCrY"
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
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
--pOXEMTJUiq3nfK4pUII58QaWsvti7NCrY
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
Subject: Re: [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors for MMIO
 regions
References: <20180209075503.16996-1-aik@ozlabs.ru>
 <20180209075503.16996-3-aik@ozlabs.ru>
 <20180212051954.GE11634@umbus.fritz.box>
In-Reply-To: <20180212051954.GE11634@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/02/18 16:19, David Gibson wrote:
> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:
>> At the moment if vfio_memory_listener is registered in the system memo=
ry
>> address space, it maps/unmaps every RAM memory region for DMA.
>> It expects system page size aligned memory sections so vfio_dma_map
>> would not fail and so far this has been the case. A mapping failure
>> would be fatal. A side effect of such behavior is that some MMIO pages=

>> would not be mapped silently.
>>
>> However we are going to change MSIX BAR handling so we will end having=

>> non-aligned sections in vfio_memory_listener (more details is in
>> the next patch) and vfio_dma_map will exit QEMU.
>>
>> In order to avoid fatal failures on what previously was not a failure =
and
>> was just silently ignored, this checks the section alignment to
>> the smallest supported IOMMU page size and prints an error if not alig=
ned;
>> it also prints an error if vfio_dma_map failed despite the page size c=
heck.
>> Both errors are not fatal; only MMIO RAM regions are checked
>> (aka "RAM device" regions).
>>
>> If the amount of errors printed is overwhelming, the MSIX relocation
>> could be used to avoid excessive error output.
>>
>> This is unlikely to cause any behavioral change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> There are some relatively superficial problems noted below.
>=20
> But more fundamentally, this feels like it's extending an existing
> hack past the point of usefulness.
>=20
> The explicit check for is_ram_device() here has always bothered me -
> it's not like a real bus bridge magically knows whether a target
> address maps to RAM or not.
>=20
> What I think is really going on is that even for systems without an
> IOMMU, it's not really true to say that the PCI address space maps
> directly onto address_space_memory.  Instead, there's a large, but
> much less than 2^64 sized, "upstream window" at address 0 on the PCI
> bus, which is identity mapped to the system bus.  Details will vary
> with the system, but in practice we expect nothing but RAM to be in
> that window.  Addresses not within that window won't be mapped to the
> system bus but will just be broadcast on the PCI bus and might be
> picked up as a p2p transaction.

Currently this p2p works only via the IOMMU, direct p2p is not possible a=
s
the guest needs to know physical MMIO addresses to make p2p work and it
does not.


> Actually on classic PC, I suspect
> there may be two windows, below and above the "ISA IO hole".
>=20
> With PCIe it gets more complicated, of course.  I still suspect
> there's some sort of upstream window to the host, but whether things
> outside the window get reflected back down the PCIe heirarchy will
> depend on those p2p relevant configuration parameters.
>=20
> Maybe it's time we had a detailed look at what really happens in
> physical bridges, rather than faking it with the is_ram_device()
> check?
>=20
> Anyway, that said, the patch below might still be a reasonable interim
> hack, once the smaller problems are fixed.
>=20
>> ---
>>  hw/vfio/common.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++=
++------
>>  1 file changed, 49 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index f895e3c..736f271 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -544,18 +544,40 @@ static void vfio_listener_region_add(MemoryListe=
ner *listener,
>> =20
>>      llsize =3D int128_sub(llend, int128_make64(iova));
>> =20
>> +    if (memory_region_is_ram_device(section->mr)) {
>> +        hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;=

>> +
>> +        if ((iova & pgmask) || (llsize & pgmask)) {
>> +            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
>> +                         " is not aligned to 0x%"HWADDR_PRIx
>> +                         " and cannot be mapped for DMA",
>> +                         section->offset_within_region,
>> +                         int128_getlo(section->size),
>> +                         pgmask + 1);
>> +            return;
>> +        }
>> +    }
>> +
>>      ret =3D vfio_dma_map(container, iova, int128_get64(llsize),
>>                         vaddr, section->readonly);
>>      if (ret) {
>>          error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                       "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
>>                       container, iova, int128_get64(llsize), vaddr, re=
t);
>> +        if (memory_region_is_ram_device(section->mr)) {
>> +            /* Allow unexpected mappings not to be fatal for RAM devi=
ces */
>> +            return;
>> +        }
>>          goto fail;
>>      }
>> =20
>>      return;
>> =20
>>  fail:
>> +    if (memory_region_is_ram_device(section->mr)) {
>> +        error_report("failed to vfio_dma_map. pci p2p may not work");=

>=20
> Isn't this logic exactly backwards?  p2p will be affected when a *non
> RAM* device (itself probably a PCI MMIO window) can't be mapped in.


"RAM device MR" =3D=3D "mapped MMIO MR". "Non RAM device" is just the gue=
st
RAM. Everything else (such as IO MRs) is filtered out by
vfio_listener_skipped_section().



>=20
>> +        return;
>> +    }
>>      /*
>>       * On the initfn path, store the first error in the container so =
we
>>       * can gracefully fail.  Runtime, there's not much we can do othe=
r
>> @@ -577,6 +599,7 @@ static void vfio_listener_region_del(MemoryListene=
r *listener,
>>      hwaddr iova, end;
>>      Int128 llend, llsize;
>>      int ret;
>> +    bool try_unmap =3D true;
>> =20
>>      if (vfio_listener_skipped_section(section)) {
>>          trace_vfio_listener_region_del_skip(
>> @@ -629,13 +652,33 @@ static void vfio_listener_region_del(MemoryListe=
ner *listener,
>> =20
>>      trace_vfio_listener_region_del(iova, end);
>> =20
>> -    ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
>> +    if (memory_region_is_ram_device(section->mr)) {
>> +        hwaddr pgmask;
>> +        VFIOHostDMAWindow *hostwin;
>> +        bool hostwin_found =3D false;
>> +
>> +        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next=
) {
>> +            if (hostwin->min_iova <=3D iova && end <=3D hostwin->max_=
iova) {
>> +                hostwin_found =3D true;
>> +                break;
>> +            }
>> +        }
>> +        assert(hostwin_found); /* or region_add() would have failed *=
/
>> +
>> +        pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>> +        try_unmap =3D !((iova & pgmask) || (llsize & pgmask));
>=20
> Explicit page mask checks seem bogus here.  We should unmap based on
> whether we mapped, not on some other criterion which may or may not
> evaluate to the same thing.


There is no mapped sections tracking on the QEMU side, adding it for the
purpose of this patchset looks overkill.



>> +    }
>> +
>> +    if (try_unmap) {
>> +        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize))=
;
>> +        if (ret) {
>> +            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> +                         "0x%"HWADDR_PRIx") =3D %d (%m)",
>> +                         container, iova, int128_get64(llsize), ret);=

>> +        }
>> +    }
>> +
>>      memory_region_unref(section->mr);
>> -    if (ret) {
>> -        error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> -                     "0x%"HWADDR_PRIx") =3D %d (%m)",
>> -                     container, iova, int128_get64(llsize), ret);
>> -    }
>> =20
>>      if (container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU) {
>>          vfio_spapr_remove_window(container,
>=20


--=20
Alexey


--pOXEMTJUiq3nfK4pUII58QaWsvti7NCrY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqBPNIOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILnvGA//VIXAVajNUi7sw1oakXiCmhSXGo/2xp59HVS3
c0+xBPkUObSiDoQE2lwxN7YAOrS6piFLt5zd69sYUSMq2aTK8IFrXbdPil66C/yY
aDlApXApkLkUGAyMhzNHLR1Wgkqhpj4x9yl/e2KSHq+66uvR8MOGsVk146+okgto
tzAwhqtWTooq+NgcF1Meax8o+4dfa/BSe8ormFKcU+ECbh5H2Me+1dxzQgZMv9bJ
6jQRMwNhvOfkSW2CuSvHUjB8VTCPHlRBGfeQwIlF2bYgtKdz2g/3WxzCD7lIb+np
1huZ4lrAxI+281dHEVZQ5vs6TAzjSZ3bLA80wgSKaM8ycvsyYl6Ie7AZRMv9yBWc
R8UXuTZik8ly3BQd09+81inLCHXMuTXajbFOJ60lZeyVEKhP+u2vfUtTHW5DheWn
ktenUjPs44ALN1ZNi4lg+M3OozyU5c5rbDLri/KCQILv/6QVJP+P7FO9qi5Ag4UZ
hYkZogx0tRr5KJEJhaPc4vSP+fpVOU0bfXaLeRTHMIoPNyBPUJF62MQNlIJKws+k
Hbj35Xg4gdNQWnFoyDFiKbtYWRl77vCjcXtuFl/xbtUIMjt6QnmyYviiWr52RdYY
+2xp2ngLcOvMh/WK5XtJ3eMz1g6/lke5Kk5QPNyodoJNm0T+pkfq9xjvhHqvnMXF
NDdDwLs=
=onxH
-----END PGP SIGNATURE-----

--pOXEMTJUiq3nfK4pUII58QaWsvti7NCrY--
