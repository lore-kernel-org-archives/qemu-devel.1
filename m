Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpG-0005vd-GS
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpF-0002G0-5n
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:14 -0500
Date: Mon, 19 Nov 2018 13:36:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119023614.GE23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <20181113083104.2692-5-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu RFC 4/7] vfio/nvidia-v100: Disable
 VBIOS update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:31:01PM +1100, Alexey Kardashevskiy wrote:
> The NVIDIA V100 GPUs often come in several instances on the same system
> board where they are connected directly via out of band fabric called
> "NVLink".
>=20
> In order to make GPUs talk to each other, NVLink has to be enabled on
> both GPUs and this is guaranteed by the firmware by providing special
> MMIO registers to disable NVLink till GPU is reset.
>=20
> This blocks GPU VBIOS update to add an extra level of assurance that
> the firmware does not get reflashed with a malicious firmware which
> does not implement NVLink disabling mechanism.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> NVIDIA firmwares come signed and GPUs do not accept unsigned images
> anyway so this is probably overkill, or not?
>=20
> Also, there is no available documentation on the magic value of 0x22408;
> however it does help as the nvflash upgrade tool stops working with this
> applied.

IIUC, the upshot of this is basically not to permit firmware updates
of the V100 from within a guest, yes?  However, it would still be
possible to update the firmware from a userspace vfio program?

Given that, I'm not sure this really gives us anything over the
existing signature verifications.  Alex, any thoughts?

> ---
>  hw/vfio/pci.h            |  1 +
>  include/hw/pci/pci_ids.h |  1 +
>  hw/vfio/pci-quirks.c     | 26 ++++++++++++++++++++++++++
>  hw/vfio/pci.c            |  2 ++
>  hw/vfio/trace-events     |  1 +
>  5 files changed, 31 insertions(+)
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b1ae4c0..f4c5fb6 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -163,6 +163,7 @@ typedef struct VFIOPCIDevice {
>      bool no_kvm_msi;
>      bool no_kvm_msix;
>      bool no_geforce_quirks;
> +    bool no_nvidia_v100_quirks;
>      bool no_kvm_ioeventfd;
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 3ed7d10..2140dad 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -272,5 +272,6 @@
>  #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
> =20
>  #define PCI_VENDOR_ID_NVIDIA             0x10de
> +#define PCI_VENDOR_ID_NVIDIA_V100_SXM2   0x1db1
> =20
>  #endif
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 40a1200..2796837 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -996,6 +996,31 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevi=
ce *vdev, int nr)
>      trace_vfio_quirk_nvidia_bar0_probe(vdev->vbasedev.name);
>  }
> =20
> +static void vfio_probe_nvidia_v100_bar0_quirk(VFIOPCIDevice *vdev, int n=
r)
> +{
> +    VFIOQuirk *quirk;
> +
> +    if (vdev->no_nvidia_v100_quirks ||
> +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA,
> +                     PCI_VENDOR_ID_NVIDIA_V100_SXM2) ||
> +        nr !=3D 0) {
> +        return;
> +    }
> +
> +    quirk =3D vfio_quirk_alloc(1);
> +
> +    memory_region_init_io(quirk->mem, OBJECT(vdev),
> +                          NULL, quirk,
> +                          "vfio-nvidia-v100_bar0-block-quirk",
> +                          4);
> +    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                        0x22408, quirk->mem, 1);
> +
> +    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
> +
> +    trace_vfio_quirk_nvidia_v100_bar0_probe(vdev->vbasedev.name);
> +}
> +
>  /*
>   * TODO - Some Nvidia devices provide config access to their companion H=
DA
>   * device and even to their parent bridge via these config space mirrors.
> @@ -1853,6 +1878,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int =
nr)
>      vfio_probe_ati_bar2_quirk(vdev, nr);
>      vfio_probe_nvidia_bar5_quirk(vdev, nr);
>      vfio_probe_nvidia_bar0_quirk(vdev, nr);
> +    vfio_probe_nvidia_v100_bar0_quirk(vdev, nr);
>      vfio_probe_rtl8168_bar2_quirk(vdev, nr);
>      vfio_probe_igd_bar4_quirk(vdev, nr);
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5c7bd96..7848b28 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3203,6 +3203,8 @@ static Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
>      DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
>                       no_geforce_quirks, false),
> +    DEFINE_PROP_BOOL("x-no-nvidia-v100-quirks", VFIOPCIDevice,
> +                     no_nvidia_v100_quirks, false),
>      DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioevent=
fd,
>                       false),
>      DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeve=
ntfd,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index db730f3..adfa75e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -68,6 +68,7 @@ vfio_quirk_nvidia_bar5_state(const char *name, const ch=
ar *state) "%s %s"
>  vfio_quirk_nvidia_bar5_probe(const char *name) "%s"
>  vfio_quirk_nvidia_bar0_msi_ack(const char *name) "%s"
>  vfio_quirk_nvidia_bar0_probe(const char *name) "%s"
> +vfio_quirk_nvidia_v100_bar0_probe(const char *name) "%s"
>  vfio_quirk_rtl8168_fake_latch(const char *name, uint64_t val) "%s 0x%"PR=
Ix64
>  vfio_quirk_rtl8168_msix_write(const char *name, uint16_t offset, uint64_=
t val) "%s MSI-X table write[0x%x]: 0x%"PRIx64
>  vfio_quirk_rtl8168_msix_read(const char *name, uint16_t offset, uint64_t=
 val) "%s MSI-X table read[0x%x]: 0x%"PRIx64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyIZsACgkQbDjKyiDZ
s5JafBAAlIITzaPOC9Si/+noUptj3ZfIMCqM/RhqRxbzM17eg1NlZwmxOLNo2LP8
brb4d7aV6sqoQgcd4PNzXdhAif8XdD2X9gZmhp7MctGUEY2AMnTKfEdFWz7OSTsf
K4UlizhLcXZpoL8bEEzP6GN1CG6sS/xBaGRoMZyWr4OPBv2Re0CHcbmoLyi96DAw
ksshnP4wtNDj66y20FOJU2cuYtowYeqB6khydf++VSD9qV+wRKOjktZsYvssgl71
v77Oe2Ly2hFJYsd1SadXp6ZpChUV4T13telMeMujvEto3LNxyJVp6z71ONfb9WIf
mNsKYQ6aukVBj/WUvZZFVZ3KTWTpvmCHRYLS9PkwC56WUWWC6K8MF0tvfhe2Iv1R
orhq1y4bQlkIhtV0mQf5ggnWgLMjHWwHkTWkRKyIEB5h1m0A0a5rMWBGVf6KvjgB
WHStIu12/zrVQSMxLTSlG/SnIlzdofj6nuAnanAbiIRC5M5S9q2idbHruUg+bBo3
qBnaJ8TobtyXdvxRW50TtPoEHxFQqdG8Uc9DWFgMDlZ6lj4riBHzvZKcFsrLjwj6
8NdZMs9GDzjf0QGHoGlbW/G7cO6ONVAoBSrSw6px9LnbkDjYJMwsAkHav28aMFjC
Mu1jMutkmltomAaUH7fXH9g4+bkf4kIAJ6ijuJtWdhjQ/L3Vay4=
=e7Ev
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
