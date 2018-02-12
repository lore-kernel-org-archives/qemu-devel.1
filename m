Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el6Yz-0004HB-VJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 00:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el6Yw-00087v-2v
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 00:22:01 -0500
Date: Mon, 12 Feb 2018 16:19:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180212051954.GE11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H7BnLk9CMipoMykF"
Content-Disposition: inline
In-Reply-To: <20180209075503.16996-3-aik@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--H7BnLk9CMipoMykF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:
> At the moment if vfio_memory_listener is registered in the system memory
> address space, it maps/unmaps every RAM memory region for DMA.
> It expects system page size aligned memory sections so vfio_dma_map
> would not fail and so far this has been the case. A mapping failure
> would be fatal. A side effect of such behavior is that some MMIO pages
> would not be mapped silently.
>=20
> However we are going to change MSIX BAR handling so we will end having
> non-aligned sections in vfio_memory_listener (more details is in
> the next patch) and vfio_dma_map will exit QEMU.
>=20
> In order to avoid fatal failures on what previously was not a failure and
> was just silently ignored, this checks the section alignment to
> the smallest supported IOMMU page size and prints an error if not aligned;
> it also prints an error if vfio_dma_map failed despite the page size chec=
k.
> Both errors are not fatal; only MMIO RAM regions are checked
> (aka "RAM device" regions).
>=20
> If the amount of errors printed is overwhelming, the MSIX relocation
> could be used to avoid excessive error output.
>=20
> This is unlikely to cause any behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

There are some relatively superficial problems noted below.

But more fundamentally, this feels like it's extending an existing
hack past the point of usefulness.

The explicit check for is_ram_device() here has always bothered me -
it's not like a real bus bridge magically knows whether a target
address maps to RAM or not.

What I think is really going on is that even for systems without an
IOMMU, it's not really true to say that the PCI address space maps
directly onto address_space_memory.  Instead, there's a large, but
much less than 2^64 sized, "upstream window" at address 0 on the PCI
bus, which is identity mapped to the system bus.  Details will vary
with the system, but in practice we expect nothing but RAM to be in
that window.  Addresses not within that window won't be mapped to the
system bus but will just be broadcast on the PCI bus and might be
picked up as a p2p transaction.  Actually on classic PC, I suspect
there may be two windows, below and above the "ISA IO hole".

With PCIe it gets more complicated, of course.  I still suspect
there's some sort of upstream window to the host, but whether things
outside the window get reflected back down the PCIe heirarchy will
depend on those p2p relevant configuration parameters.

Maybe it's time we had a detailed look at what really happens in
physical bridges, rather than faking it with the is_ram_device()
check?

Anyway, that said, the patch below might still be a reasonable interim
hack, once the smaller problems are fixed.

> ---
>  hw/vfio/common.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-=
-----
>  1 file changed, 49 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f895e3c..736f271 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -544,18 +544,40 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
> =20
>      llsize =3D int128_sub(llend, int128_make64(iova));
> =20
> +    if (memory_region_is_ram_device(section->mr)) {
> +        hwaddr pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
> +
> +        if ((iova & pgmask) || (llsize & pgmask)) {
> +            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
> +                         " is not aligned to 0x%"HWADDR_PRIx
> +                         " and cannot be mapped for DMA",
> +                         section->offset_within_region,
> +                         int128_getlo(section->size),
> +                         pgmask + 1);
> +            return;
> +        }
> +    }
> +
>      ret =3D vfio_dma_map(container, iova, int128_get64(llsize),
>                         vaddr, section->readonly);
>      if (ret) {
>          error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                       "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
>                       container, iova, int128_get64(llsize), vaddr, ret);
> +        if (memory_region_is_ram_device(section->mr)) {
> +            /* Allow unexpected mappings not to be fatal for RAM devices=
 */
> +            return;
> +        }
>          goto fail;
>      }
> =20
>      return;
> =20
>  fail:
> +    if (memory_region_is_ram_device(section->mr)) {
> +        error_report("failed to vfio_dma_map. pci p2p may not work");

Isn't this logic exactly backwards?  p2p will be affected when a *non
RAM* device (itself probably a PCI MMIO window) can't be mapped in.

> +        return;
> +    }
>      /*
>       * On the initfn path, store the first error in the container so we
>       * can gracefully fail.  Runtime, there's not much we can do other
> @@ -577,6 +599,7 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>      hwaddr iova, end;
>      Int128 llend, llsize;
>      int ret;
> +    bool try_unmap =3D true;
> =20
>      if (vfio_listener_skipped_section(section)) {
>          trace_vfio_listener_region_del_skip(
> @@ -629,13 +652,33 @@ static void vfio_listener_region_del(MemoryListener=
 *listener,
> =20
>      trace_vfio_listener_region_del(iova, end);
> =20
> -    ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
> +    if (memory_region_is_ram_device(section->mr)) {
> +        hwaddr pgmask;
> +        VFIOHostDMAWindow *hostwin;
> +        bool hostwin_found =3D false;
> +
> +        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +            if (hostwin->min_iova <=3D iova && end <=3D hostwin->max_iov=
a) {
> +                hostwin_found =3D true;
> +                break;
> +            }
> +        }
> +        assert(hostwin_found); /* or region_add() would have failed */
> +
> +        pgmask =3D (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
> +        try_unmap =3D !((iova & pgmask) || (llsize & pgmask));

Explicit page mask checks seem bogus here.  We should unmap based on
whether we mapped, not on some other criterion which may or may not
evaluate to the same thing.

> +    }
> +
> +    if (try_unmap) {
> +        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        if (ret) {
> +            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                         "0x%"HWADDR_PRIx") =3D %d (%m)",
> +                         container, iova, int128_get64(llsize), ret);
> +        }
> +    }
> +
>      memory_region_unref(section->mr);
> -    if (ret) {
> -        error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") =3D %d (%m)",
> -                     container, iova, int128_get64(llsize), ret);
> -    }
> =20
>      if (container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU) {
>          vfio_spapr_remove_window(container,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H7BnLk9CMipoMykF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqBI/gACgkQbDjKyiDZ
s5JjZRAA40H45e61P8dIKC+PT4rLX/wp+Nx2h0pHzl/kDeecG5D6i8z2rq/i1vLU
XDiN8MEnM17HpLWq97pKUEquicZaqad6s/PczWi9yzvL0FfTC8ez6MEbpywq9laU
k04hV0+6KPKq2SLPBrKE02BUMcW1A2mGosuHvRcj9jex4PS+rVuAQDbFyhTWOUeW
az4Our97F5Sx6+zYvpMiW6XHAybqHyFvUGHpoePEedUrfgTRdInTSgrCIcDFByhE
Vii9sF7ATM9327wfSA8DL2D8dQ/XAd7I7BcodDVf6QQirSewM2BRVkLak57GM+23
DX+VhnAupNkDne1Tb0iIo3ZJZquzZYVo5xf7gv+Pkptk1xPK0EHYgUaVA+MC99RQ
i3GWI/eqCj7TjmJaFOz65AROvIkSqFIQOVG3s17OwS9FeAQ4XEXYidrEuU/ZqnZJ
nctHxfSkuNDFZEqddKNgPm9GW6dXMtIuE6HmfseloIz30n+KotlB4+89yTUaWUJM
HUdAuA7+qDSaXMsoJOrYjso0VM7Cq6HY93E4dbf4DStgZ4YvAdubr0RNIGoJ9rKy
Dh7U2rdPJyWGyWUE1o3MJSWN9IDYi9LmPs+3i5QgB4vNzs4oZ5Y8lcYkCjjvL6C7
aVlWWRi+lQCL5kWFR23v6Ge/yM8nCLrGqstpTNaa3aZR8gdfuac=
=rRIh
-----END PGP SIGNATURE-----

--H7BnLk9CMipoMykF--
