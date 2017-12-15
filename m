Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePiuQ-0001yL-5P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePiuO-00012w-Iy
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:51:46 -0500
Date: Fri, 15 Dec 2017 15:09:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215040928.GE7753@umbus.fritz.box>
References: <20171212052131.24649-1-aik@ozlabs.ru>
	<20171211225411.6fd08ff8@w520.home>
	<60d96072-55c2-93fd-3cf7-011abf4926e1@ozlabs.ru>
	<e31b3238-0fe0-1cfc-92b6-39e03170c669@ozlabs.ru>
	<20171212090525.19a21378@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20171212090525.19a21378@t450s.home>
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 09:05:25AM -0700, Alex Williamson wrote:
> On Tue, 12 Dec 2017 18:01:40 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 12/12/17 17:06, Alexey Kardashevskiy wrote:
> > > On 12/12/17 16:54, Alex Williamson wrote: =20
> > >> On Tue, 12 Dec 2017 16:21:31 +1100
> > >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >> =20
> > >>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capabili=
ty
> > >>> which tells that a region with MSIX data can be mapped entirely, i.=
e.
> > >>> the VFIO PCI driver won't prevent MSIX vectors area from being mapp=
ed.
> > >>>
> > >>> This adds a "msix-no-mmap" property to the vfio-pci device, it is "=
true"
> > >>> by default and "false" for pseries-2.12+ machines.
> > >>>
> > >>> This requites kernel's "vfio-pci: Allow mapping MSIX BAR"
> > >>> https://www.spinics.net/lists/kvm/msg160282.html
> > >>>
> > >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > >>> ---
> > >>>
> > >>> This is an RFC as it requires kernel headers update which is not th=
ere yet.
> > >>>
> > >>> I'd like to make it "msix-mmap" (without "no") but could not find a=
 way
> > >>> of enabling a device property for machine versions newer than some =
value.
> > >>>
> > >>> I changed 2.11 machine just for the demonstration purpose.
> > >>>
> > >>>
> > >>> ---
> > >>>  hw/vfio/pci.h                 |  1 +
> > >>>  include/hw/vfio/vfio-common.h |  1 +
> > >>>  linux-headers/linux/vfio.h    |  5 +++++
> > >>>  hw/ppc/spapr.c                | 10 +++++++++-
> > >>>  hw/vfio/common.c              | 15 +++++++++++++++
> > >>>  hw/vfio/pci.c                 | 11 +++++++++++
> > >>>  6 files changed, 42 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > >>> index a8fb3b3..53912ef 100644
> > >>> --- a/hw/vfio/pci.h
> > >>> +++ b/hw/vfio/pci.h
> > >>> @@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
> > >>>      bool no_kvm_intx;
> > >>>      bool no_kvm_msi;
> > >>>      bool no_kvm_msix;
> > >>> +    bool msix_no_mmap;
> > >>>  } VFIOPCIDevice;
> > >>> =20
> > >>>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int =
len);
> > >>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-c=
ommon.h
> > >>> index f3a2ac9..927d600 100644
> > >>> --- a/include/hw/vfio/vfio-common.h
> > >>> +++ b/include/hw/vfio/vfio-common.h
> > >>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, =
int index,
> > >>>                           struct vfio_region_info **info);
> > >>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
> > >>>                               uint32_t subtype, struct vfio_region_=
info **info);
> > >>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, =
int region);
> > >>>  #endif
> > >>>  extern const MemoryListener vfio_prereg_listener;
> > >>> =20
> > >>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > >>> index 4e7ab4c..bce9baf 100644
> > >>> --- a/linux-headers/linux/vfio.h
> > >>> +++ b/linux-headers/linux/vfio.h
> > >>> @@ -300,6 +300,11 @@ struct vfio_region_info_cap_type {
> > >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> > >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> > >>> =20
> > >>> +/*
> > >>> + * The MSIX mappable capability informs that MSIX data of a BAR ca=
n be mmapped.
> > >>> + */
> > >>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> > >>> +
> > >>>  /**
> > >>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> > >>>   *				    struct vfio_irq_info)
> > >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >>> index 9de63f0..1dfc386 100644
> > >>> --- a/hw/ppc/spapr.c
> > >>> +++ b/hw/ppc/spapr.c
> > >>> @@ -3742,13 +3742,21 @@ static const TypeInfo spapr_machine_info =
=3D {
> > >>>  /*
> > >>>   * pseries-2.11
> > >>>   */
> > >>> +#define SPAPR_COMPAT_2_11                                         =
    \
> > >>> +    HW_COMPAT_2_10                                                =
    \
> > >>> +    {                                                             =
    \
> > >>> +        .driver =3D "vfio-pci",                                   =
      \
> > >>> +        .property =3D "msix-no-mmap",                             =
      \
> > >>> +        .value    =3D "on",                                       =
      \
> > >>> +    },                                                            =
    \
> > >>> +
> > >>>  static void spapr_machine_2_11_instance_options(MachineState *mach=
ine)
> > >>>  {
> > >>>  }
> > >>> =20
> > >>>  static void spapr_machine_2_11_class_options(MachineClass *mc)
> > >>>  {
> > >>> -    /* Defaults for the latest behaviour inherited from the base c=
lass */
> > >>> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> > >>>  }
> > >>> =20
> > >>>  DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > >>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > >>> index ed7717d..593514c 100644
> > >>> --- a/hw/vfio/common.c
> > >>> +++ b/hw/vfio/common.c
> > >>> @@ -1408,6 +1408,21 @@ int vfio_get_dev_region_info(VFIODevice *vba=
sedev, uint32_t type,
> > >>>      return -ENODEV;
> > >>>  }
> > >>> =20
> > >>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, =
int region)
> > >>> +{
> > >>> +        struct vfio_region_info *info =3D NULL;
> > >>> +        bool ret =3D false;
> > >>> +
> > >>> +        if (!vfio_get_region_info(vbasedev, region, &info)) {
> > >>> +            if (vfio_get_region_info_cap(info, cap_type)) {
> > >>> +                ret =3D true;
> > >>> +            }
> > >>> +            g_free(info);
> > >>> +        }
> > >>> +
> > >>> +        return ret;
> > >>> +}
> > >>> +
> > >>>  /*
> > >>>   * Interfaces for IBM EEH (Enhanced Error Handling)
> > >>>   */
> > >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > >>> index c977ee3..d9aeae8 100644
> > >>> --- a/hw/vfio/pci.c
> > >>> +++ b/hw/vfio/pci.c
> > >>> @@ -1289,6 +1289,12 @@ static void vfio_pci_fixup_msix_region(VFIOP=
CIDevice *vdev)
> > >>>      off_t start, end;
> > >>>      VFIORegion *region =3D &vdev->bars[vdev->msix->table_bar].regi=
on;
> > >>> =20
> > >>> +    if (!vdev->msix_no_mmap &&
> > >>> +        vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_=
MSIX_MAPPABLE,
> > >>> +                            vdev->msix->table_bar)) {
> > >>> +        return;
> > >>> +    }
> > >>> +
> > >>>      /*
> > >>>       * We expect to find a single mmap covering the whole BAR, any=
thing else
> > >>>       * means it's either unsupported or already setup.
> > >>> @@ -1473,6 +1479,10 @@ static int vfio_msix_setup(VFIOPCIDevice *vd=
ev, int pos, Error **errp)
> > >>>       */
> > >>>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> > >>> =20
> > >>> +    if (!vdev->msix_no_mmap) {
> > >>> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, fal=
se);
> > >>> +    } =20
> > >>
> > >> No, you're conflating issues.  There's (a) can we mmap over the MSI-X
> > >> vector table and (b) do we require QEMU emulation of the MSI-X vector
> > >> table.  (a) does NOT imply (b).  AFAICT, (a) should be enabled any t=
ime
> > >> the kernel supports it, =20
> > >=20
> > > This is the default setting, or you do not want it to be a property s=
o the
> > > user cannot shoot himself in a foot?
>=20
> If the kernel allows mmap, other than debugging, why would it ever need
> to be disabled?
>=20
>   =20
> > >> (b) should never be enabled on ppc, regardless
> > >> of (a).  Thanks, =20
> > >=20
> > >=20
> > > The intention is to have a property - msix_no_mmap=3Dtrue, except a s=
ingle
> > > case - ppc-pseries, I just do not know how to enforce it for a specif=
ic
> > > machine type. =20
>=20
> The intention is wrong.  (a) should be done any time the kernel allows
> it.  (b) is an independent concept of disabling QEMU MSI-X emulation
> for platforms, ie. machine types, that do not require it.  (b) has
> nothing to do with the mmap'ability of the msix table area.  So far (b)
> includes only the ppc spapr machine and I don't see a reason to allow
> the user to control this.  Thanks,

I don't either, but setting properties like this seems to be the
more-or-less standard way for the machine type (and/or version) to
affect operation of other devices.

Allowing the user to shoot themselves in the foot is a side effect of
that, but seems to be one we're ok with.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozSvgACgkQbDjKyiDZ
s5LSmw//UUaao3xYSfHsVb+Teb7UIG8MN+NdnHpNVXV948A2iQOXQT1H9SyMTAF0
/aZK6psOM6RfIChtjdsNshGo5djz+BwDNLnCj6ka9kpJpcJl9GEMOLizZBsvR2Xy
hTdKhRre7mneGGy3/NPO8r57x0S68JSbqtH4vX2o9yDebWhT/enQJS3XW1bUtNRD
QvMopZEkc1mbaFZkOkCY7RHlKxUWS+g6iTPPnq/vIRJoOq+zvnXo4F4b03hvRwBl
BZ2Odkf2iJRPzSfx1uSCTpRAvk2Tc6Wq7Gn/70uGOYpADHojE7MmRqAEZBxC/NC3
Xbvz5rXmBdm1413nw6DmI/bQ1+5ld8HTcW4mHP4YDi3lHyxG/6GBGY/DImr2VRxy
+p3LUw1ty7CBiYTP9HXp1LDXHB91HpIbHVH3Gd4JfzfyFjlHyN/fwmM3T4KbEzLw
L+11J8+VfBP9K6SpyZHBF9Gpm8NqyVlFvuNpcrsDiZiq8jyhvULij2VznEdNHjrn
AYVb23g3dis5cti3ALUphkz5qEIrNi5j42h1hs82fNuTdihLlQjmcNHuhhyWe2dW
WmjChTduTHzUAz/uSxEWFfHrJ5Gcw88hOrVV8Ws6oh43uxrjCHlcXU8efQ4e6+Qf
7a+zMbYtg0XrTnOzav0TugrpkWfbCvSLNPmSny4WNZb6EK2GuLc=
=GCSz
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
