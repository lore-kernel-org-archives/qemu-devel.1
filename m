Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTLT-0005cL-Ii
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTLQ-00029R-Ej
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:41:35 -0500
Date: Tue, 13 Feb 2018 16:39:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213053900.GM11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiGzRFbP+7h+smMw"
Content-Disposition: inline
In-Reply-To: <20180209075503.16996-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v7 3/4] vfio-pci: Allow mmap of MSIX
 BAR
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


--xiGzRFbP+7h+smMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:55:02PM +1100, Alexey Kardashevskiy wrote:
> At the moment we unconditionally avoid mapping MSIX data of a BAR and
> emulate MSIX table in QEMU. However it is 1) not always necessary as
> a platform may prodive a paravirt interface for MSIX configuration;
> 2) can affect the speed of MMIO access by emulating them in QEMU when
> frequently accessed registers share same system page with MSIX data,
> this is particularly a problem for systems with the page size bigger
> than 4KB.
>=20
> A new capability - VFIO_REGION_INFO_CAP_MSIX_MAPPABLE - has been added
> to the kernel [1] which tells the userspace that mapping of the MSIX data
> is possible now. This makes use of it so from now on QEMU tries mapping
> the entire BAR as a whole and emulate MSIX on top of that.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Da32295c612c57990d17fb0f41e7134394b2f35f6
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v7:
> * test iova/llsize against pgmask in vfio_listener_region_add/del
> * s/vfio_is_cap_present/vfio_has_region_cap/
> * added comments here and there
> * s/vdev->msix->table_bar/region-nr/
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              | 15 +++++++++++++++
>  hw/vfio/pci.c                 |  9 +++++++++
>  3 files changed, 25 insertions(+)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9..42dd2b0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int in=
dex,
>                           struct vfio_region_info **info);
>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>                               uint32_t subtype, struct vfio_region_info *=
*info);
> +bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_=
type);
>  #endif
>  extern const MemoryListener vfio_prereg_listener;
> =20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 736f271..b99ae77 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1464,6 +1464,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev,=
 uint32_t type,
>      return -ENODEV;
>  }
> =20
> +bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_=
type)
> +{
> +    struct vfio_region_info *info =3D NULL;
> +    bool ret =3D false;
> +
> +    if (!vfio_get_region_info(vbasedev, region, &info)) {
> +        if (vfio_get_region_info_cap(info, cap_type)) {
> +            ret =3D true;
> +        }
> +        g_free(info);
> +    }
> +
> +    return ret;
> +}
> +
>  /*
>   * Interfaces for IBM EEH (Enhanced Error Handling)
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 879510c..ae9098d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1294,6 +1294,15 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevi=
ce *vdev)
>      VFIORegion *region =3D &vdev->bars[vdev->msix->table_bar].region;
> =20
>      /*
> +     * If the host driver allows mapping of a MSIX data, we are going to
> +     * do map the entire BAR and emulate MSIX table on top of that.
> +     */
> +    if (vfio_has_region_cap(&vdev->vbasedev, region->nr,
> +                            VFIO_REGION_INFO_CAP_MSIX_MAPPABLE)) {
> +        return;
> +    }
> +
> +    /*
>       * We expect to find a single mmap covering the whole BAR, anything =
else
>       * means it's either unsupported or already setup.
>       */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xiGzRFbP+7h+smMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCefQACgkQbDjKyiDZ
s5IRvA//RCM+c2EwcZUha5IZh22aSJRPTDhlzFnrMiKqo7jPZMeyGalV7Ny+Cfdz
sou7Vh4PVDMCaGAHo6Rut53omfFuHwVLoggbs1G7HV830NVYR7nRjJVDpNplSGrk
/f+8NRuUR3lHFkuMthMHEi3kUDURONqyfQ3LbyLgGRYD43seHDwMMO1b6diQcEvo
9FX8dbPKoNz8+WtNn9thg4WJKfFxnpwKwtP5lnn7tjwHJs+V7XfLFsbYmWE2fhK4
Fb+VvIZFv3elNaCK1M7cGylNkSd13uf4Rsu1O0sqK2h4oWmaJ11ITH1ZQjiYxwsz
tD3T+5JGDznYGo4I7/V6KxZ9lF2XBnFcmsPWcnh3ujvgQ5mEmI4TgpvBGc/1ZSKX
z2i31YdTxIeu1dg5fgBaxRUiCMUs+XzJb8UFyY49KjJwn2CnRX+wkO0JwV0ciAZ+
H7dtP0Gm3AbKJYLn07c1CRR+phKZwL6RSMeLe62FRlwsSmcFu1pa/83NYxufn8wV
ykoS0lJ/s8uCfZaE0wYN7dknzk/EMIX7KUmxxTeg6YRca3k/qcuMO3AiBLF0g0nK
9g3b9HhFGBd1FLgJTTUTpjvzj2tszLi/0dG+f/0OiKGrbB4c5YUmNCHXJkfEx25w
k53aQFT7AqcHBier5SCMgXqNz4hSgSXgYp/mp6sy9kzVks0ViWE=
=kphE
-----END PGP SIGNATURE-----

--xiGzRFbP+7h+smMw--
