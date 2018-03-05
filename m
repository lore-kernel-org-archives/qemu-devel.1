Received: from eggs.gnu.org ([2001:4830:134:3::10]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esgu6-0001Of-N6
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esgu3-0004BM-EB
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:10 -0500
Received: from ozlabs.org ([103.22.144.67]:58027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1esgu2-0004AX-ON
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:07 -0500
Date: Mon, 5 Mar 2018 14:31:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305033144.GI2650@umbus.fritz.box>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900322-30263-6-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0NB0lE7sNnW8+0qW"
Content-Disposition: inline
In-Reply-To: <1519900322-30263-6-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/12] hw/pci: introduce PCISVAOps to
 PCIDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com


--0NB0lE7sNnW8+0qW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 06:31:55PM +0800, Liu, Yi L wrote:
> This patch intoduces PCISVAOps for virt-SVA.
>=20
> So far, to setup virt-SVA for assigned SVA capable device, needs to
> config host translation structures. e.g. for VT-d, needs to set the
> guest pasid table to host and enable nested translation. Besides,
> vIOMMU emulator needs to forward guest's cache invalidation to host.
> On VT-d, it is guest's invalidation to 1st level translation related
> cache, such invalidation should be forwarded to host.
>=20
> Proposed PCISVAOps are:
> * sva_bind_guest_pasid_table: set the guest pasid table to host, and
>                               enable nested translation in host
> * sva_register_notifier: register sva_notifier to forward guest's
>                          cache invalidation to host
> * sva_unregister_notifier: unregister sva_notifier
>=20
> The PCISVAOps should be provided by vfio or modules alike. Mainly for
> assigned SVA capable devices.
>=20
> Take virt-SVA on VT-d as an exmaple:
> If a guest wants to setup virt-SVA for an assigned SVA capable device,
> it programs its context entry. vIOMMU emulator captures guest's context
> entry programming, and figure out the target device. vIOMMU emulator
> use the pci_device_sva_bind_pasid_table() API to bind the guest pasid
> table to host.
>=20
> Guest would also program its pasid table. vIOMMU emulator captures
> guest's pasid entry programming. In Qemu, needs to allocate an
> AddressSpace to stand for the pasid tagged address space and Qemu also
> needs to register sva_notifier to forward future cache invalidation
> request to host.
>=20
> Allocating AddressSpace to stand for the pasid tagged address space is
> for the emulation of emulated SVA capable devices. Emulated SVA capable
> devices may issue SVA aware DMAs, Qemu needs to emulate read/write to a
> pasid tagged AddressSpace. Thus needs an abstraction for such address
> space in Qemu.
>=20
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>

So PCISVAOps is roughly equivalent to the cluster-of-PASIDs context I
was suggesting in my earlier comments, however it's only an ops
structure.  That means you can't easily share a context between
multiple PCI devices which is unfortunate because:
    * The simplest use case for SVA I can see would just put the
      same set of PASIDs into place for every SVA capable device
    * Sometimes the IOMMU can't determine exactly what device a DMA
      came from.  Now the bridge cases where this applies are probably
      unlikely with SVA devices, but I wouldn't want to bet on it.  In
      addition, the chances some manufacturer will eventually put out
      a buggy multifunction SVA capable device that use the wrong RIDs
      for the secondary functions is pretty darn high.

So I think instead you want a cluster-of-PASIDs object which has an
ops table including both these and the per-PASID calls from the
earlier patches (but the per-PASID calls would now take an explicit
PASID value).

> ---
>  hw/pci/pci.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/pci/pci.h | 21 ++++++++++++++++++
>  2 files changed, 81 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e006b6a..157fe21 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2573,6 +2573,66 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn,=
 void *opaque)
>      bus->iommu_opaque =3D opaque;
>  }
> =20
> +void pci_setup_sva_ops(PCIDevice *dev, PCISVAOps *ops)
> +{
> +    if (dev) {
> +        dev->sva_ops =3D ops;
> +    }
> +    return;
> +}
> +
> +void pci_device_sva_bind_pasid_table(PCIBus *bus,
> +                     int32_t devfn, uint64_t addr, uint32_t size)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    dev =3D bus->devices[devfn];
> +    if (dev && dev->sva_ops) {
> +        dev->sva_ops->sva_bind_pasid_table(bus, devfn, addr, size);
> +    }
> +    return;
> +}
> +
> +void pci_device_sva_register_notifier(PCIBus *bus, int32_t devfn,
> +                                      IOMMUSVAContext *sva_ctx)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    dev =3D bus->devices[devfn];
> +    if (dev && dev->sva_ops) {
> +        dev->sva_ops->sva_register_notifier(bus,
> +                                            devfn,
> +                                            sva_ctx);
> +    }
> +    return;
> +}
> +
> +void pci_device_sva_unregister_notifier(PCIBus *bus, int32_t devfn,
> +                                        IOMMUSVAContext *sva_ctx)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    dev =3D bus->devices[devfn];
> +    if (dev && dev->sva_ops) {
> +        dev->sva_ops->sva_unregister_notifier(bus,
> +                                              devfn,
> +                                              sva_ctx);
> +    }
> +    return;
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range =3D opaque;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index d8c18c7..32889a4 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -10,6 +10,8 @@
> =20
>  #include "hw/pci/pcie.h"
> =20
> +#include "hw/core/pasid.h"
> +
>  extern bool pci_available;
> =20
>  /* PCI bus */
> @@ -262,6 +264,16 @@ struct PCIReqIDCache {
>  };
>  typedef struct PCIReqIDCache PCIReqIDCache;
> =20
> +typedef struct PCISVAOps PCISVAOps;
> +struct PCISVAOps {
> +    void (*sva_bind_pasid_table)(PCIBus *bus, int32_t devfn,
> +             uint64_t pasidt_addr, uint32_t size);
> +    void (*sva_register_notifier)(PCIBus *bus, int32_t devfn,
> +                                  IOMMUSVAContext *sva_ctx);
> +    void (*sva_unregister_notifier)(PCIBus *bus, int32_t devfn,
> +                                    IOMMUSVAContext *sva_ctx);
> +};
> +
>  struct PCIDevice {
>      DeviceState qdev;
> =20
> @@ -351,6 +363,7 @@ struct PCIDevice {
>      MSIVectorUseNotifier msix_vector_use_notifier;
>      MSIVectorReleaseNotifier msix_vector_release_notifier;
>      MSIVectorPollNotifier msix_vector_poll_notifier;
> +    PCISVAOps *sva_ops;
>  };
> =20
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> @@ -477,6 +490,14 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void=
 *, int);
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
> =20
> +void pci_setup_sva_ops(PCIDevice *dev, PCISVAOps *ops);
> +void pci_device_sva_bind_pasid_table(PCIBus *bus, int32_t devfn,
> +                     uint64_t pasidt_addr, uint32_t size);
> +void pci_device_sva_register_notifier(PCIBus *bus, int32_t devfn,
> +                                      IOMMUSVAContext *sva_ctx);
> +void pci_device_sva_unregister_notifier(PCIBus *bus, int32_t devfn,
> +                                       IOMMUSVAContext *sva_ctx);
> +
>  static inline void
>  pci_set_byte(uint8_t *config, uint8_t val)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0NB0lE7sNnW8+0qW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcuiAACgkQbDjKyiDZ
s5JRRw//VQiM2WfdZtbqJcpcp7GkwYykY82AXdGTRMg+lpqOCwEqYfPqLnBpgmVJ
4/HNTcZ0H6O4A/Ki8Y65x6CvuXpRIDxW0eaxEoO+kA1RnoeuCpBeSQVkd5y1Ellc
ILl/Own05HrcKUGSwPew11LtIICMfBN51MTVRcLXI16/1N4r4aMIJiqtonnf+BAK
JVkQcU2ELvPYePnYBZFM0pUBgQX7PSeEoKZvwmPRhDz3ZcANWqBHkOjGAzdflxnu
8OPv0M/4Qj+FRaIORDrxQdAL0r0njMq+fk0hhHuUhaXRnEOjt8XmsXYGBiPnayN4
ikSl1/ZsK3GoGzpczhfaudTZakHfD915R2OJ45ieCltaeAvB+1neOkQ3m1BeDIlZ
TYRFCqyhZNMmrJ4APgTw7KmJU3+HYkpj3qsRj46PlVNYKRVD4caZlTYGXt3ZT5oK
ajjb7llpnzhEpmMA8hXPIXbVagSyZg0esd7uTfh69qnJX79jTVgVSn5me14sHM7d
PJxVW0+M0Dkk62lENq4Mq+A+zO/0UNyBvyEOsVcyUY8kiGsdPTiLd9Wisx9Qfc8t
MXQCHonfpmfz+tbHz7xrpMtazz/1WOronxerE3iOFaU6U3QrBW7ugxDJCt7mFMug
Z72f5YFQPuPeBSGBLJdZkeVlIPsquT0kCFzB7e4j84wn+jvQV2Q=
=YQkJ
-----END PGP SIGNATURE-----

--0NB0lE7sNnW8+0qW--
