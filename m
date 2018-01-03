Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWXFj-0008S8-El
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWXFf-0001AG-T4
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:49:55 -0500
Date: Wed, 3 Jan 2018 11:39:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180103003904.GH24581@umbus.fritz.box>
References: <1513618512-30070-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <1513618512-30070-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Remove the deprecated
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


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 06:35:12PM +0100, Thomas Huth wrote:
> It's a deprecated dummy device since QEMU v2.6.0. That should have
> been enough time to allow the users to update their scripts in case
> they still use it, so let's remove this legacy code now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I'm afraid this has bitrotted due to ongoing changes in the
ppc-for-2.12 tree, can you rebase and resend, please.

> ---
>  hw/ppc/spapr_pci_vfio.c   | 47 -----------------------------------------=
------
>  qemu-doc.texi             |  5 -----
>  scripts/device-crash-test |  1 -
>  3 files changed, 53 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index 8448e0b..053efb0 100644
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
> -        error_report("spapr-pci-vfio-host-bridge is deprecated");
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
> index f7317df..14d818d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2533,11 +2533,6 @@ The ``host_net_remove'' command is replaced by the=
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
> index 1aca55f..7417177 100755
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

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMJiUACgkQbDjKyiDZ
s5LhSRAAl/P/qDLw67iUj7w2tTWTtSbHGYrbB7OjhLgLvRcrC2XoKpdXlciF9KID
WKZGusCvCkWgV5m/Q3bivu2NVNrs+Q3qboGXt6ybIZAxZSVzc2cADzYTBuj+neo0
aN4ui+44ctUhcbMIkysIXJmHUS7j1TZ5g1/jWItWM1e4heXk1BHzN0KhP+IQSC87
e9aAXzu9y7GH4xa28sfAxfFnRrzwbHpFv21XwEDonACwz9WJMiSVSB1hOLDpwHbX
0xrQXJCQEqb1UscA7D7Ob0Jk7MC12FfSIhJ0DmrLWuLA1a/rFH+GiPjim+ZmlMci
xjzeFnzNlTYxUuANbBUsY9W9y9HDlNEaMe3sBA9Di+DEclarSE9tEIbKHDNbuZDs
rXFUtHKoWlEizRG1hvMjMfxip3iaK1P8+L1jjkfEiVjWEG5R6mn4ZmRzYny4rKSO
6fyjdoCsHgP2cgnIXEerNlWWzISwQNuSszaq77YC1qgnU7QG7fd8OLPYhhfMGdgL
+Husb30rzED5UlJ9m1pXV6sxkTS/i/RCd3sCOADlL6G6xGkFKCE8fC0pHdBcQQKs
cWyiVt426qM3AJc5Nh5ZHzYW90lN2w9cLSk/Io11gw1eZZgzAufmIB3ExR6LCdmM
nhUs55rZ95g4o1esXGWweGHWvCoLlIBapfI0TKBWHeNqIbxG4M4=
=eUd7
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
