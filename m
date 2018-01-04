Received: from eggs.gnu.org ([2001:4830:134:3::10]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWvtt-0001HP-5s
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 22:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWvtr-0004rK-GX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 22:09:01 -0500
Date: Thu, 4 Jan 2018 14:06:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180104030601.GX24581@umbus.fritz.box>
References: <1514970638-12868-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hNtiuZBcYkRjyNT4"
Content-Disposition: inline
In-Reply-To: <1514970638-12868-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc: Remove the deprecated
 spapr-pci-vfio-host-bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--hNtiuZBcYkRjyNT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 10:10:38AM +0100, Thomas Huth wrote:
> It's a deprecated dummy device since QEMU v2.6.0. That should have
> been enough time to allow the users to update their scripts in case
> they still use it, so let's remove this legacy code now.
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Rebased to the ppc-for-2.12 branch to solve a conflict

Applied, thanks.

>=20
>  hw/ppc/spapr_pci_vfio.c   | 47 -----------------------------------------=
------
>  qemu-doc.texi             |  5 -----
>  scripts/device-crash-test |  1 -
>  3 files changed, 53 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index 1f775ea..053efb0 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -29,31 +29,6 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> =20
> -#define TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE "spapr-pci-vfio-host-bridge"
> -
> -#define SPAPR_PCI_VFIO_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(sPAPRPHBVFIOState, (obj), TYPE_SPAPR_PCI_VFIO_HOST_BRID=
GE)
> -
> -typedef struct sPAPRPHBVFIOState sPAPRPHBVFIOState;
> -
> -struct sPAPRPHBVFIOState {
> -    sPAPRPHBState phb;
> -
> -    int32_t iommugroupid;
> -};
> -
> -static Property spapr_phb_vfio_properties[] =3D {
> -    DEFINE_PROP_INT32("iommu", sPAPRPHBVFIOState, iommugroupid, -1),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void spapr_phb_vfio_instance_init(Object *obj)
> -{
> -    if (!qtest_enabled()) {
> -        warn_report("spapr-pci-vfio-host-bridge is deprecated");
> -    }
> -}
> -
>  bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
>  {
>      return vfio_eeh_as_ok(&sphb->iommu_as);
> @@ -218,25 +193,3 @@ int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
> =20
>      return RTAS_OUT_SUCCESS;
>  }
> -
> -static void spapr_phb_vfio_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->props =3D spapr_phb_vfio_properties;
> -}
> -
> -static const TypeInfo spapr_phb_vfio_info =3D {
> -    .name          =3D TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE,
> -    .parent        =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
> -    .instance_size =3D sizeof(sPAPRPHBVFIOState),
> -    .instance_init =3D spapr_phb_vfio_instance_init,
> -    .class_init    =3D spapr_phb_vfio_class_init,
> -};
> -
> -static void spapr_pci_vfio_register_types(void)
> -{
> -    type_register_static(&spapr_phb_vfio_info);
> -}
> -
> -type_init(spapr_pci_vfio_register_types)
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 90bea73..5449695 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2744,11 +2744,6 @@ The ``host_net_remove'' command is replaced by the=
 ``netdev_del'' command.
>  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
>  or ``ivshmem-doorbell`` device types.
> =20
> -@subsection spapr-pci-vfio-host-bridge (since 2.6.0)
> -
> -The ``spapr-pci-vfio-host-bridge'' device type is replaced by
> -the ``spapr-pci-host-bridge'' device type.
> -
>  @section System emulator machines
> =20
>  @subsection Xilinx EP108 (since 2.11.0)
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index c11fd81..827d8ec 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -119,7 +119,6 @@ ERROR_WHITELIST =3D [
>      {'device':'scsi-generic', 'expected':True},            # drive prope=
rty not set
>      {'device':'scsi-hd', 'expected':True},                 # drive prope=
rty not set
>      {'device':'spapr-pci-host-bridge', 'expected':True},   # BUID not sp=
ecified for PHB
> -    {'device':'spapr-pci-vfio-host-bridge', 'expected':True}, # BUID not=
 specified for PHB
>      {'device':'spapr-rng', 'expected':True},               # spapr-rng n=
eeds an RNG backend!
>      {'device':'spapr-vty', 'expected':True},               # chardev pro=
perty not set
>      {'device':'tpm-tis', 'expected':True},                 # tpm_tis: ba=
ckend driver with id (null) could not be found

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hNtiuZBcYkRjyNT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpNmhkACgkQbDjKyiDZ
s5JrNw//Qe1ocQSy0EygxiwOCnfP2AZLe5MHQtUIX1UEa54U6DmIFTPh013lhMIl
RPRjvPjYwUlCXuLi/5hacAi8nWkY9mtITcOVyeXZikr+tuo4lKkdB2txF/aVJ6uT
1xx0Hp+AvIKALEJc47GzZSIY2CDcN+5MM1AyPiuBVuowXeWvjOQJCGgToGUqlcch
JSSmIy9XFgiCWNi85BOprs1HL/5yGF1dNM9/WFHCla42lp5e6VkQD8jO/hJwd1yz
UlWBg8kIokPyDuAmDD2ei/PwdVcQ/fWW+C/Q789UAGoZSaY0CZJ1BjyS4fbRR+1I
YrshWEosUgQAkdo6UMae179E/+5nskQnlriunhCBH7e+ww/qaVa8dr5J31fuPba8
lQ1Thwx27Lh45m+0Qa3OCLncmdO8ycSm+C6p2+NB1LyHZ3b3YhgR51rAgDQWXLT7
bEhXRLs01yyRaZjcd8S5TVNL8lLNEZ+ubbvgHntR19lhhzncSysGt0wkeFPh6oHQ
gdIYTp0mA/fX8RvteqhMz1aKpFN0o6+U7bbTIGwBFdyA3VZTDUgtKtmWzvbpxR+5
37HcEk6bilUS2gJ4XX5K45FNJzOf8fiMCttrhGjfHs6PRnBGLAk8teU2XjpaEQNP
Axbznfn9XgpJOWTNeVID/4T6w8YyqnkoGSKUjFXnnMVeABLfAUw=
=jJwc
-----END PGP SIGNATURE-----

--hNtiuZBcYkRjyNT4--
