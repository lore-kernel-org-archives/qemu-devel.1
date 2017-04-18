Received: from eggs.gnu.org ([2001:4830:134:3::10]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TAT-0001Un-3r
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TAR-0003h6-J5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:27:41 -0400
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-4-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9cbafe84-88bb-ca3c-d85e-dae71af438ff@redhat.com>
Date: Tue, 18 Apr 2017 16:27:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170417215916.12431-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 3/7] pci: Change pci_bus_new*() parameter to
 PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

On 04/18/2017 12:59 AM, Eduardo Habkost wrote:
> The pci_bus_new*() functions already require the 'parent' argument to b=
e
> a PCI_HOST_BRIDGE object. Change the parameter type to reflect that.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/pci/pci.h                |  5 +++--
>  hw/pci-bridge/pci_expander_bridge.c | 15 ++++++++-------
>  hw/pci-host/piix.c                  |  2 +-
>  hw/pci-host/prep.c                  |  2 +-
>  hw/pci-host/q35.c                   |  2 +-
>  hw/pci-host/versatile.c             |  2 +-
>  hw/pci/pci.c                        | 13 ++++++-------
>  7 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a37a2d5cb6..2242aa25eb 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -393,12 +393,13 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *op=
aque, int pin);
>
>  bool pci_bus_is_express(PCIBus *bus);
>  bool pci_bus_is_root(PCIBus *bus);
> -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> +void pci_bus_new_inplace(PCIBus *bus, size_t bus_size,
> +                         PCIHostState *phb,
>                           const char *name,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename);
> -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> +PCIBus *pci_bus_new(PCIHostState *phb, const char *name,
>                      MemoryRegion *address_space_mem,
>                      MemoryRegion *address_space_io,
>                      uint8_t devfn_min, const char *typename);
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> index 6ac187fa32..39d29d2230 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -213,7 +213,8 @@ static gint pxb_compare(gconstpointer a, gconstpoin=
ter b)
>  static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **=
errp)
>  {
>      PXBDev *pxb =3D convert_to_pxb(dev);
> -    DeviceState *ds, *bds =3D NULL;
> +    DeviceState *bds =3D NULL;
> +    PCIHostState *phb;
>      PCIBus *bus;
>      const char *dev_name =3D NULL;
>      Error *local_err =3D NULL;
> @@ -228,11 +229,11 @@ static void pxb_dev_realize_common(PCIDevice *dev=
, bool pcie, Error **errp)
>          dev_name =3D dev->qdev.id;
>      }
>
> -    ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> +    phb =3D PCI_HOST_BRIDGE(qdev_create(NULL, TYPE_PXB_HOST));
>      if (pcie) {
> -        bus =3D pci_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE=
_BUS);
> +        bus =3D pci_bus_new(phb, dev_name, NULL, NULL, 0, TYPE_PXB_PCI=
E_BUS);
>      } else {
> -        bus =3D pci_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PX=
B_BUS);
> +        bus =3D pci_bus_new(phb, "pxb-internal", NULL, NULL, 0, TYPE_P=
XB_BUS);
>          bds =3D qdev_create(BUS(bus), "pci-bridge");
>          bds->id =3D dev_name;
>          qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->=
bus_nr);
> @@ -244,7 +245,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
>      bus->address_space_io =3D dev->bus->address_space_io;
>      bus->map_irq =3D pxb_map_irq_fn;
>
> -    PCI_HOST_BRIDGE(ds)->bus =3D bus;
> +    phb->bus =3D bus;
>
>      pxb_register_bus(dev, bus, &local_err);
>      if (local_err) {
> @@ -252,7 +253,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
>          goto err_register_bus;
>      }
>
> -    qdev_init_nofail(ds);
> +    qdev_init_nofail(DEVICE(phb));
>      if (bds) {
>          qdev_init_nofail(bds);
>      }
> @@ -267,7 +268,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
>  err_register_bus:
>      object_unref(OBJECT(bds));
>      object_unparent(OBJECT(bus));
> -    object_unref(OBJECT(ds));
> +    object_unref(OBJECT(phb));
>  }
>
>  static void pxb_dev_realize(PCIDevice *dev, Error **errp)
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index f9218aa952..91fec05b38 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -340,7 +340,7 @@ PCIBus *i440fx_init(const char *host_type, const ch=
ar *pci_type,
>
>      dev =3D qdev_create(NULL, host_type);
>      s =3D PCI_HOST_BRIDGE(dev);
> -    b =3D pci_bus_new(dev, NULL, pci_address_space,
> +    b =3D pci_bus_new(s, NULL, pci_address_space,
>                      address_space_io, 0, TYPE_PCI_BUS);
>      s->bus =3D b;
>      object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev=
), NULL);
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 260a119a9e..2e2cd267f4 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -269,7 +269,7 @@ static void raven_pcihost_initfn(Object *obj)
>      memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
>                                          &s->pci_io_non_contiguous, 1);
>      memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci=
_memory);
> -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), =
NULL,
> +    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), h, NULL,
>                          &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
>
>      /* Bus master address space */
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 344f77b10c..860b47a1ba 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -49,7 +49,7 @@ static void q35_host_realize(DeviceState *dev, Error =
**errp)
>      sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
>      sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
>
> -    pci->bus =3D pci_bus_new(DEVICE(s), "pcie.0",
> +    pci->bus =3D pci_bus_new(pci, "pcie.0",
>                             s->mch.pci_address_space, s->mch.address_sp=
ace_io,
>                             0, TYPE_PCIE_BUS);
>      PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index 467cbb9cb8..24ef87610b 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -386,7 +386,7 @@ static void pci_vpb_init(Object *obj)
>      memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << =
32);
>      memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL <=
< 32);
>
> -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), =
"pci",
> +    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), h, "pci",
>                          &s->pci_mem_space, &s->pci_io_space,
>                          PCI_DEVFN(11, 0), TYPE_PCI_BUS);
>      h->bus =3D &s->pci_bus;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d9535c0bdc..f4488b46fc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -388,26 +388,25 @@ bool pci_bus_is_root(PCIBus *bus)
>      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
>  }
>
> -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> +void pci_bus_new_inplace(PCIBus *bus, size_t bus_size,
> +                         PCIHostState *phb,
>                           const char *name,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename)
>  {
> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
> -    qbus_create_inplace(bus, bus_size, typename, parent, name);
> +    qbus_create_inplace(bus, bus_size, typename, DEVICE(phb), name);
>      pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_=
min);
>  }
>
> -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> +PCIBus *pci_bus_new(PCIHostState *phb, const char *name,
>                      MemoryRegion *address_space_mem,
>                      MemoryRegion *address_space_io,
>                      uint8_t devfn_min, const char *typename)
>  {
> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
>      PCIBus *bus;
>
> -    bus =3D PCI_BUS(qbus_create(typename, parent, name));
> +    bus =3D PCI_BUS(qbus_create(typename, DEVICE(phb), name));
>      pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_=
min);
>      return bus;
>  }
> @@ -431,7 +430,7 @@ PCIBus *pci_register_bus(DeviceState *parent, const=
 char *name,
>  {
>      PCIBus *bus;
>
> -    bus =3D pci_bus_new(parent, name, address_space_mem,
> +    bus =3D pci_bus_new(PCI_HOST_BRIDGE(parent), name, address_space_m=
em,

If you request the parent to be PCI_HOST_BRIDGE, why don't you change als=
o the signature of
pci_register_bus ?

Thanks,
Marcel

>                        address_space_io, devfn_min, typename);
>      pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
>      return bus;
>
