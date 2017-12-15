Received: from eggs.gnu.org ([2001:4830:134:3::10]:51527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePiuQ-0001yM-5Q
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePiuO-00013C-Ku
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:51:46 -0500
Date: Fri, 15 Dec 2017 15:07:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215040731.GD7753@umbus.fritz.box>
References: <20171212052131.24649-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20171212052131.24649-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: vfio-pci: Allow mmap of MSIX BAR
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


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 04:21:31PM +1100, Alexey Kardashevskiy wrote:
> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> which tells that a region with MSIX data can be mapped entirely, i.e.
> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
>=20
> This adds a "msix-no-mmap" property to the vfio-pci device, it is "true"
> by default and "false" for pseries-2.12+ machines.
>=20
> This requites kernel's "vfio-pci: Allow mapping MSIX BAR"
> https://www.spinics.net/lists/kvm/msg160282.html
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This is an RFC as it requires kernel headers update which is not there ye=
t.
>=20
> I'd like to make it "msix-mmap" (without "no") but could not find a way
> of enabling a device property for machine versions newer than some value.
>=20
> I changed 2.11 machine just for the demonstration purpose.

As Alex says, the mmap()ability of the MSI-X BAR isn't really the
point.  The point is whether we need to intercept guest MMIOs to the
MSI-X region.  Still, the logic's basically right, just rename your
property to, say, "intercept_msix_mmio".  It would be true by default,
set to false by the pseries machine type.

I don't think you actually need to make it vary depending on the
version of the pseries machine type: whether the BAR is mmap()ed or
qemu emulated shouldn't be a guest visible change.  No PAPR guest
should have been directly poking the MSI-X region (ever), so we
shouldn't need to intercept the region even for old versions.

>=20
>=20
> ---
>  hw/vfio/pci.h                 |  1 +
>  include/hw/vfio/vfio-common.h |  1 +
>  linux-headers/linux/vfio.h    |  5 +++++
>  hw/ppc/spapr.c                | 10 +++++++++-
>  hw/vfio/common.c              | 15 +++++++++++++++
>  hw/vfio/pci.c                 | 11 +++++++++++
>  6 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a8fb3b3..53912ef 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
>      bool no_kvm_intx;
>      bool no_kvm_msi;
>      bool no_kvm_msix;
> +    bool msix_no_mmap;
>  } VFIOPCIDevice;
> =20
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9..927d600 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int in=
dex,
>                           struct vfio_region_info **info);
>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>                               uint32_t subtype, struct vfio_region_info *=
*info);
> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int re=
gion);
>  #endif
>  extern const MemoryListener vfio_prereg_listener;
> =20
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4e7ab4c..bce9baf 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -300,6 +300,11 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> =20
> +/*
> + * The MSIX mappable capability informs that MSIX data of a BAR can be m=
mapped.
> + */
> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9de63f0..1dfc386 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3742,13 +3742,21 @@ static const TypeInfo spapr_machine_info =3D {
>  /*
>   * pseries-2.11
>   */
> +#define SPAPR_COMPAT_2_11                                             \
> +    HW_COMPAT_2_10                                                    \
> +    {                                                                 \
> +        .driver =3D "vfio-pci",                                         \
> +        .property =3D "msix-no-mmap",                                   \
> +        .value    =3D "on",                                             \
> +    },                                                                \
> +
>  static void spapr_machine_2_11_instance_options(MachineState *machine)
>  {
>  }
> =20
>  static void spapr_machine_2_11_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ed7717d..593514c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1408,6 +1408,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev,=
 uint32_t type,
>      return -ENODEV;
>  }
> =20
> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int re=
gion)
> +{
> +        struct vfio_region_info *info =3D NULL;
> +        bool ret =3D false;
> +
> +        if (!vfio_get_region_info(vbasedev, region, &info)) {
> +            if (vfio_get_region_info_cap(info, cap_type)) {
> +                ret =3D true;
> +            }
> +            g_free(info);
> +        }
> +
> +        return ret;
> +}
> +
>  /*
>   * Interfaces for IBM EEH (Enhanced Error Handling)
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c977ee3..d9aeae8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1289,6 +1289,12 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevi=
ce *vdev)
>      off_t start, end;
>      VFIORegion *region =3D &vdev->bars[vdev->msix->table_bar].region;
> =20
> +    if (!vdev->msix_no_mmap &&
> +        vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_M=
APPABLE,
> +                            vdev->msix->table_bar)) {
> +        return;
> +    }
> +
>      /*
>       * We expect to find a single mmap covering the whole BAR, anything =
else
>       * means it's either unsupported or already setup.
> @@ -1473,6 +1479,10 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, in=
t pos, Error **errp)
>       */
>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> =20
> +    if (!vdev->msix_no_mmap) {
> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> +    }
> +
>      return 0;
>  }
> =20
> @@ -2986,6 +2996,7 @@ static Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false=
),
> +    DEFINE_PROP_BOOL("msix-no-mmap", VFIOPCIDevice, msix_no_mmap, true),
>      DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>      DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozSoAACgkQbDjKyiDZ
s5JHfxAAiVhZpQNqHx3YJU0e3l43FPwJ6d54lk8tLLi12G9rhJ2+CVrTtUVMRshL
eXx5MKVboMalJSaQOx1zNoCuXqQUtiNtPt+dpYR3cdXBWqe6KsKM9HIdiw+gw4Kf
HxpNHGpoUvnsDJwAnF7GseaeL6JFRh6Tr/r/GBVB8mSsY9XFQ/7oghtJmFDlggmt
0hXtLgF4JT7YQTGJe2x/0MLhh6tlfFJY9f+6ahYBtVriJY0b7+rRvXm49rs6eIPS
18k0kTzymG0FAEzsJmsgVPIV3/wDrw2xGx5tvyby9vYBKeSrKwcbpAlZ0x4FoCfg
WZD3awUOOohfXrY423Qg+10ikhaXrrDK9zHSmaXIb7PlYEjSk0YV5AZf0O1G+NCk
XUBtpLepeXav7dVkrt/mJWlf2I3wXmM9GbBIsVmrZ7w34qPSuCl+oGQgZRFFJxCx
yqaCEg0ZEvTCmyBatgnRjkVaPFNNGYnOBA7R+DNpo3kqCuM4E8YHxWhG0tqmNJl5
hf/1WuR3zC5DhvWqHYV1Xs0o2bOr0McKbGKqXw1lLk7UQ3M99XPKPo8wTno1Xl0D
7E6GGp/NtYzPvvm8pp3OlrXW2jxTapZQuAJSDI2bdCed1feFA5JyFJQh7Q8oDdXq
mX5eREMAp3S6RPXMQYrZD8Bw11WAgUTvk+yThlCIm58SiaGp5T4=
=UPAV
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
