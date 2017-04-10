Received: from eggs.gnu.org ([2001:4830:134:3::10]:37777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cxfJA-0008TX-Sl
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cxfJ6-0003aI-Tr
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:49:04 -0400
Date: Mon, 10 Apr 2017 22:48:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170410153148-mutt-send-email-mst@kernel.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-19-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1491396106-26376-19-git-send-email-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/21] pci: Use the new
 pci_can_add_device() to enforce devfn_min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Apr 05, 2017 at 02:41:43PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This adds a devfn_max field to PCIBus and adds a pci_can_add_device()
> function which, if no "addr" (aka devfn) is specified, will tell whethe=
r
> there is any slot free between devfn_min and devfn_max.
>=20
> When devfn_max is 0 (default), it will be ignored (no constraints).
>=20
> This will be used by some PCI root complex implementations that support
> only one direct child to avoid having qemu put dumb devices at differen=
t
> slot numbers.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: updated for qemu-2.9 ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/pci/pci.c             | 22 ++++++++++++++++++++++
>  include/hw/pci/pci_bus.h |  1 +
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b1c01a..817ad14ed987 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -143,6 +143,27 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>      return NUMA_NODE_UNASSIGNED;
>  }
> =20
> +static bool pci_can_add_device(BusState *bus, QemuOpts *opts)
> +{
> +    unsigned int devfn, max;
> +    PCIBus *pbus =3D PCI_BUS(bus);
> +
> +    /* If address is specified, say yes and let it fail if that doesn'=
t work */
> +    if (qemu_opt_get(opts, "addr") !=3D NULL) {
> +        return true;
> +    }
> +    max =3D ARRAY_SIZE(pbus->devices);
> +    if (pbus->devfn_max && pbus->devfn_max < max) {
> +        max =3D pbus->devfn_max;
> +    }
> +    for (devfn =3D pbus->devfn_min ; devfn < max; devfn +=3D PCI_FUNC_=
MAX) {
> +        if (!pbus->devices[devfn]) {
> +            break;
> +        }
> +    }
> +    return devfn < max;
> +}
> +

This doesn't do the right thing for AER I think.


>  static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k =3D BUS_CLASS(klass);
> @@ -154,6 +175,7 @@ static void pci_bus_class_init(ObjectClass *klass, =
void *data)
>      k->realize =3D pci_bus_realize;
>      k->unrealize =3D pci_bus_unrealize;
>      k->reset =3D pcibus_reset;
> +    k->can_add_device =3D pci_can_add_device;
> =20
>      pbc->is_root =3D pcibus_is_root;
>      pbc->bus_num =3D pcibus_num;
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 5484a9b5c573..05c9dd22a8fa 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -23,6 +23,7 @@ struct PCIBus {
>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
>      uint8_t devfn_min;
> +    uint8_t devfn_max;
>      pci_set_irq_fn set_irq;
>      pci_map_irq_fn map_irq;
>      pci_route_irq_fn route_intx_to_irq;
> --=20
> 2.7.4
>=20
