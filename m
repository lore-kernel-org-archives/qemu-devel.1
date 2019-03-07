Received: from eggs.gnu.org ([209.51.188.92]:38679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234y-0002yt-Bu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h234w-0002qP-RZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:36 -0500
Date: Fri, 8 Mar 2019 10:11:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307231130.GR7722@umbus.fritz.box>
References: <20190307050518.64968-1-aik@ozlabs.ru>
	<20190307050518.64968-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U5J2I87mWnf1KeOw"
Content-Disposition: inline
In-Reply-To: <20190307050518.64968-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v4 1/3] spapr_iommu: Do not replay
 mappings from just created DMA window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--U5J2I87mWnf1KeOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 04:05:16PM +1100, Alexey Kardashevskiy wrote:
> On sPAPR vfio_listener_region_add() is called in 2 situations:
> 1. a new listener is registered from vfio_connect_container();
> 2. a new IOMMU Memory Region is added from rtas_ibm_create_pe_dma_window(=
).
>=20
> In both cases vfio_listener_region_add() calls
> memory_region_iommu_replay() to notify newly registered IOMMU notifiers
> about existing mappings which is totally desirable for case 1.
>=20
> However for case 2 it is nothing but noop as the window has just been
> created and has no valid mappings so replaying those does not do anything.
> It is barely noticeable with usual guests but if the window happens to be
> really big, such no-op replay might take minutes and trigger RCU stall
> warnings in the guest.
>=20
> For example, a upcoming GPU RAM memory region mapped at 64TiB (right
> after SPAPR_PCI_LIMIT) causes a 64bit DMA window to be at least 128TiB
> which is (128<<40)/0x10000=3D2.147.483.648 TCEs to replay.
>=20
> This mitigates the problem by adding an "skipping_replay" flag to
> sPAPRTCETable and defining sPAPR own IOMMU MR replay() hook which does
> exactly the same thing as the generic one except it returns early if
> @skipping_replay=3D=3Dtrue.
>=20
> Another way of fixing this would be delaying replay till the very first
> H_PUT_TCE but this does not work if in-kernel H_PUT_TCE handler is
> enabled (a likely case).
>=20
> When "ibm,create-pe-dma-window" is complete, the guest will map only
> required regions of the huge DMA window.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied, thanks.

> ---
> Changes:
> v4:
> * more explaining in the commit log and comments
> ---
>  include/hw/ppc/spapr.h  |  1 +
>  hw/ppc/spapr_iommu.c    | 31 +++++++++++++++++++++++++++++++
>  hw/ppc/spapr_rtas_ddw.c | 10 ++++++++++
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ff1bd6061540..2b368e6677c5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -723,6 +723,7 @@ struct sPAPRTCETable {
>      uint64_t *mig_table;
>      bool bypass;
>      bool need_vfio;
> +    bool skipping_replay;
>      int fd;
>      MemoryRegion root;
>      IOMMUMemoryRegion iommu;
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 37e98f93214d..8f231799b29b 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -141,6 +141,36 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMU=
MemoryRegion *iommu,
>      return ret;
>  }
> =20
> +static void spapr_tce_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier =
*n)
> +{
> +    MemoryRegion *mr =3D MEMORY_REGION(iommu_mr);
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(iommu=
_mr);
> +    hwaddr addr, granularity;
> +    IOMMUTLBEntry iotlb;
> +    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iommu);
> +
> +    if (tcet->skipping_replay) {
> +        return;
> +    }
> +
> +    granularity =3D memory_region_iommu_get_min_page_size(iommu_mr);
> +
> +    for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granularit=
y) {
> +        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iommu_i=
dx);
> +        if (iotlb.perm !=3D IOMMU_NONE) {
> +            n->notify(n, &iotlb);
> +        }
> +
> +        /*
> +         * if (2^64 - MR size) < granularity, it's possible to get an
> +         * infinite loop here.  This should catch such a wraparound.
> +         */
> +        if ((addr + granularity) < addr) {
> +            break;
> +        }
> +    }
> +}
> +
>  static int spapr_tce_table_pre_save(void *opaque)
>  {
>      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
> @@ -659,6 +689,7 @@ static void spapr_iommu_memory_region_class_init(Obje=
ctClass *klass, void *data)
>      IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> =20
>      imrc->translate =3D spapr_tce_translate_iommu;
> +    imrc->replay =3D spapr_tce_replay;
>      imrc->get_min_page_size =3D spapr_tce_get_min_page_size;
>      imrc->notify_flag_changed =3D spapr_tce_notify_flag_changed;
>      imrc->get_attr =3D spapr_tce_get_attr;
> diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
> index cb8a4103592e..cc9d1f5c1cc8 100644
> --- a/hw/ppc/spapr_rtas_ddw.c
> +++ b/hw/ppc/spapr_rtas_ddw.c
> @@ -171,8 +171,18 @@ static void rtas_ibm_create_pe_dma_window(PowerPCCPU=
 *cpu,
>      }
> =20
>      win_addr =3D (windows =3D=3D 0) ? sphb->dma_win_addr : sphb->dma64_w=
in_addr;
> +    /*
> +     * We have just created a window, we know for the fact that it is em=
pty,
> +     * use a hack to avoid iterating over the table as it is quite possi=
ble
> +     * to have billions of TCEs, all empty.
> +     * Note that we cannot delay this to the first H_PUT_TCE as this hca=
ll is
> +     * mostly likely to be handled in KVM so QEMU just does not know if =
it
> +     * happened.
> +     */
> +    tcet->skipping_replay =3D true;
>      spapr_tce_table_enable(tcet, page_shift, win_addr,
>                             1ULL << (window_shift - page_shift));
> +    tcet->skipping_replay =3D false;
>      if (!tcet->nb_table) {
>          goto hw_error_exit;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U5J2I87mWnf1KeOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBpSAACgkQbDjKyiDZ
s5JX6Q/+M+kxZWVa29cKJ42ZRTamZdcBadnHe7qkY83dKRJUk+HDhfY1ke7+wfs2
AqKvnyHVOj7Lu0pHBMOBH9XR2f0LTdKw+7Y7prQf+ofAxdnKwZpxeXTrx7RIf82b
b00447SGL7QKXD90vi1VuB7LG/seZDKB9yBoLhYc7b7IqKVLKj/1ATlgEuVQXeU1
+G3KFDon2Vrux9BXS7/zGgk7m4hax+mENnB6NyrIYakr53u/6wdAjfBqM5qeQUAV
wjbrTg1JyC8/oG57Iz1RQkwytNX1SQuz/Q/RUJ25IN92eHjsnhPWtHLchb/kRjCK
FWSV41sqzT6Vm+LBvS/y8j7rXdaZhcX7/M93y05KdFYGkb5Vuf19APiaZJIlmoLW
6XtLAKi+vuh3gVQj7uV4LdSf8zteyLXze/xSlQnPG/DOoWOBm+cw37gaeOSPyvsi
ZFtweSXOEIddPxB+G19953Wb55I/TbiD4T3AVnKEZRx3WL+623tP+zp6ohgWKgMu
DKScH5gO4duPFehRlbLyHh3UsDD6301BnzRtn94jU8dzn13cj8SM6fQTib4aSsAY
VmJn3I7PQaRJav0LDoNvo037RK5k1c9nFq1LuYu7DYzFScDdDp8fuIwTS6Qgs3NY
dQ4cK8x5utOu5EKJMtkt5XKzcBc0tY+qBAKFrVeO9svyXFcgTzU=
=P95s
-----END PGP SIGNATURE-----

--U5J2I87mWnf1KeOw--
