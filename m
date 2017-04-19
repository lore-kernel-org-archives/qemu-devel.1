Received: from eggs.gnu.org ([2001:4830:134:3::10]:48719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYK-0002qs-35
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYH-0005xp-3s
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:33:00 -0400
Date: Wed, 19 Apr 2017 10:29:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170419002926.GC23273@umbus.fritz.box>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20170418221724.5707-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 07:17:21PM -0300, Eduardo Habkost wrote:
> pci_bus_new*() and pci_register_bus() work only when the 'parent'
> argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> are meant to initialize a bus that's in a PCI host bridge.
>=20
> The new function names are:
> * pci_host_bus_init() (replacing pci_bus_new())
> * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> * pci_host_bus_init_irqs() (replacing pci_register_bus())

I like the idea, but I'm not terribly convinced by these names.
Aren't functions which allocate objects usually called whatever_new()
rather than whatever_init()?  And pci_register_bus() appears to do
more than just initialize irqs.

> This also replaces the DeviceState *parent parameter on those functions
> with a PCIHostState *phb parameter.
>=20
> This was implemented using the following Coccinelle patch:
>=20
>     // 1) Rename pci_bus_new():
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     typedef DeviceState;
>     identifier parent;
>     parameter list ARGS;
>     @@
>     -PCIBus *pci_bus_new(DeviceState *parent, ARGS);
>     +PCIBus *pci_host_bus_init(PCIHostState *phb, ARGS);
>=20
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     identifier parent;
>     parameter list ARGS;
>     @@
>     -PCIBus *pci_bus_new(DeviceState *parent, ARGS)
>     +PCIBus *pci_host_bus_init(PCIHostState *phb, ARGS)
>      {
>      <...
>     -parent
>     +DEVICE(phb)
>      ...>
>      }
>=20
>     @@
>     expression parent;
>     expression list ARGS;
>     @@
>     -pci_bus_new(parent, ARGS)
>     +pci_host_bus_init(PCI_HOST_BRIDGE(parent), ARGS)
>=20
>     // 2) Rename pci_bus_new_inplace():
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     typedef DeviceState;
>     identifier bus, bus_size, parent;
>     parameter list ARGS;
>     @@
>     -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size,
>     -                         DeviceState *parent, ARGS);
>     +void pci_host_bus_init_inplace(PCIHostState *phb,
>     +                               PCIBus *bus, size_t bus_size, ARGS);
>=20
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     typedef DeviceState;
>     identifier bus, bus_size, parent;
>     parameter list ARGS;
>     @@
>     -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size,
>     -                         DeviceState *parent, ARGS)
>     +void pci_host_bus_init_inplace(PCIHostState *phb,
>     +                               PCIBus *bus, size_t bus_size, ARGS)
>      {
>     -PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
>      <...
>     -parent
>     +DEVICE(phb)
>      ...>
>      }
>=20
>     @@
>     expression bus, bus_size, parent;
>     expression list ARGS;
>     @@
>     -pci_bus_new_inplace(bus, bus_size, parent, ARGS)
>     +pci_host_bus_init_inplace(PCI_HOST_BRIDGE(parent), bus, bus_size, AR=
GS)
>=20
>     // 3) Rename pci_register_bus():
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     identifier parent;
>     parameter list ARGS;
>     @@
>     -PCIBus *pci_register_bus(DeviceState *parent, ARGS);
>     +PCIBus *pci_host_bus_init_irqs(PCIHostState *phb, ARGS);
>=20
>     @@
>     typedef PCIBus;
>     typedef PCIHostState;
>     identifier parent;
>     parameter list ARGS;
>     @@
>     -PCIBus *pci_register_bus(DeviceState *parent, ARGS)
>     +PCIBus *pci_host_bus_init_irqs(PCIHostState *phb, ARGS)
>      {
>      <...
>     -parent
>     +DEVICE(phb)
>      ...>
>      }
>=20
>     @@
>     expression parent;
>     expression list ARGS;
>     @@
>     -pci_register_bus(parent, ARGS)
>     +pci_host_bus_init_irqs(PCI_HOST_BRIDGE(parent), ARGS)
>=20
>     // 5) fix redundant casts on the resulting code:
>     @@
>     expression o;
>     @@
>     -PCI_HOST_BRIDGE(DEVICE(o))
>     +PCI_HOST_BRIDGE(o)
>=20
>     @@
>     expression o;
>     @@
>     -DEVICE(PCI_HOST_BRIDGE(o))
>     +DEVICE(o)
>=20
>     @@
>     idexpression PCIHostState *phb;
>     @@
>     -PCI_HOST_BRIDGE(phb)
>     +phb
>=20
>     @@
>     idexpression PCIHostState *phb;
>     expression dev;
>     @@
>      phb =3D PCI_HOST_BRIDGE(dev);
>      <...
>     -PCI_HOST_BRIDGE(dev)
>     +phb
>      ...>
>=20
>     @@
>     identifier phb;
>     identifier dev;
>     @@
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>      <...
>     -PCI_HOST_BRIDGE(dev)
>     +phb
>      ...>
>=20
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Herv=E9 Poussineau" <hpoussin@reactos.org>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/pci/pci.h                | 31 ++++++++++++-------------
>  hw/alpha/typhoon.c                  |  7 +++---
>  hw/mips/gt64xxx_pci.c               | 11 +++++----
>  hw/pci-bridge/pci_expander_bridge.c |  6 +++--
>  hw/pci-host/apb.c                   |  9 ++++----
>  hw/pci-host/bonito.c                |  8 +++----
>  hw/pci-host/gpex.c                  |  7 +++---
>  hw/pci-host/grackle.c               | 11 ++++-----
>  hw/pci-host/piix.c                  |  4 ++--
>  hw/pci-host/ppce500.c               |  7 +++---
>  hw/pci-host/prep.c                  |  5 +++--
>  hw/pci-host/q35.c                   |  6 ++---
>  hw/pci-host/uninorth.c              | 20 +++++++----------
>  hw/pci-host/versatile.c             |  7 +++---
>  hw/pci-host/xilinx-pcie.c           |  7 +++---
>  hw/pci/pci.c                        | 45 +++++++++++++++++++------------=
------
>  hw/ppc/ppc4xx_pci.c                 |  7 +++---
>  hw/ppc/spapr_pci.c                  |  8 +++----
>  hw/s390x/s390-pci-bus.c             |  8 +++----
>  hw/sh4/sh_pci.c                     | 10 ++++-----
>  20 files changed, 111 insertions(+), 113 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a37a2d5cb6..85fe3ae743 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -393,26 +393,27 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaq=
ue, int pin);
> =20
>  bool pci_bus_is_express(PCIBus *bus);
>  bool pci_bus_is_root(PCIBus *bus);
> -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pare=
nt,
> -                         const char *name,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, const char *typename);
> -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    uint8_t devfn_min, const char *typename);
> +void pci_host_bus_init_inplace(PCIHostState *phb, PCIBus *bus,
> +                               size_t bus_size, const char *name,
> +                               MemoryRegion *address_space_mem,
> +                               MemoryRegion *address_space_io,
> +                               uint8_t devfn_min, const char *typename);
> +PCIBus *pci_host_bus_init(PCIHostState *phb, const char *name,
> +                          MemoryRegion *address_space_mem,
> +                          MemoryRegion *address_space_io, uint8_t devfn_=
min,
> +                          const char *typename);
>  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn ma=
p_irq,
>                    void *irq_opaque, int nirq);
>  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
>  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
>  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> -PCIBus *pci_register_bus(DeviceState *parent, const char *name,
> -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> -                         void *irq_opaque,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, int nirq, const char *typena=
me);
> +PCIBus *pci_host_bus_init_irqs(PCIHostState *phb, const char *name,
> +                               pci_set_irq_fn set_irq, pci_map_irq_fn ma=
p_irq,
> +                               void *irq_opaque,
> +                               MemoryRegion *address_space_mem,
> +                               MemoryRegion *address_space_io,
> +                               uint8_t devfn_min, int nirq,
> +                               const char *typename);
>  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
>  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
>  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index f50f5cf186..24f1959ab8 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -883,10 +883,9 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **i=
sa_bus,
>      memory_region_add_subregion(addr_space, 0x801fc000000ULL,
>                                  &s->pchip.reg_io);
> =20
> -    b =3D pci_register_bus(dev, "pci",
> -                         typhoon_set_irq, sys_map_irq, s,
> -                         &s->pchip.reg_mem, &s->pchip.reg_io,
> -                         0, 64, TYPE_PCI_BUS);
> +    b =3D pci_host_bus_init_irqs(phb, "pci", typhoon_set_irq,
> +                               sys_map_irq, s, &s->pchip.reg_mem,
> +                               &s->pchip.reg_io, 0, 64, TYPE_PCI_BUS);
>      phb->bus =3D b;
>      qdev_init_nofail(dev);
> =20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index 4811843ab6..5ca9f07031 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1171,12 +1171,11 @@ PCIBus *gt64120_register(qemu_irq *pic)
>      phb =3D PCI_HOST_BRIDGE(dev);
>      memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_MAX=
);
>      address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
> -    phb->bus =3D pci_register_bus(dev, "pci",
> -                                gt64120_pci_set_irq, gt64120_pci_map_irq,
> -                                pic,
> -                                &d->pci0_mem,
> -                                get_system_io(),
> -                                PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
> +    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
> +                                      gt64120_pci_set_irq,
> +                                      gt64120_pci_map_irq, pic, &d->pci0=
_mem,
> +                                      get_system_io(), PCI_DEVFN(18, 0),=
 4,
> +                                      TYPE_PCI_BUS);
>      qdev_init_nofail(dev);
>      memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "is=
d-mem", 0x1000);
> =20
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index 6ac187fa32..853448ef70 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -230,9 +230,11 @@ static void pxb_dev_realize_common(PCIDevice *dev, b=
ool pcie, Error **errp)
> =20
>      ds =3D qdev_create(NULL, TYPE_PXB_HOST);
>      if (pcie) {
> -        bus =3D pci_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_B=
US);
> +        bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(ds), dev_name, NULL, N=
ULL, 0,
> +                                TYPE_PXB_PCIE_BUS);
>      } else {
> -        bus =3D pci_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_=
BUS);
> +        bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(ds), "pxb-internal", N=
ULL,
> +                                NULL, 0, TYPE_PXB_BUS);
>          bds =3D qdev_create(BUS(bus), "pci-bridge");
>          bds->id =3D dev_name;
>          qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bu=
s_nr);
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 653e711121..38d08c661c 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -671,11 +671,10 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      dev =3D qdev_create(NULL, TYPE_APB);
>      d =3D APB_DEVICE(dev);
>      phb =3D PCI_HOST_BRIDGE(dev);
> -    phb->bus =3D pci_register_bus(DEVICE(phb), "pci",
> -                                pci_apb_set_irq, pci_pbm_map_irq, d,
> -                                &d->pci_mmio,
> -                                get_system_io(),
> -                                0, 32, TYPE_PCI_BUS);
> +    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
> +                                      pci_apb_set_irq, pci_pbm_map_irq, =
d,
> +                                      &d->pci_mmio, get_system_io(), 0, =
32,
> +                                      TYPE_PCI_BUS);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      /* apb_config */
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 1999ece590..8b6e80aa82 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -714,10 +714,10 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
>  {
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> =20
> -    phb->bus =3D pci_register_bus(DEVICE(dev), "pci",
> -                                pci_bonito_set_irq, pci_bonito_map_irq, =
dev,
> -                                get_system_memory(), get_system_io(),
> -                                0x28, 32, TYPE_PCI_BUS);
> +    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
> +                                      pci_bonito_set_irq, pci_bonito_map=
_irq,
> +                                      dev, get_system_memory(),
> +                                      get_system_io(), 0x28, 32, TYPE_PC=
I_BUS);
> =20
>      return 0;
>  }
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 66055ee5cc..9ea9927cf8 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -62,9 +62,10 @@ static void gpex_host_realize(DeviceState *dev, Error =
**errp)
>          sysbus_init_irq(sbd, &s->irq[i]);
>      }
> =20
> -    pci->bus =3D pci_register_bus(dev, "pcie.0", gpex_set_irq,
> -                                pci_swizzle_map_irq_fn, s, &s->io_mmio,
> -                                &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
> +    pci->bus =3D pci_host_bus_init_irqs(pci, "pcie.0",
> +                                      gpex_set_irq, pci_swizzle_map_irq_=
fn, s,
> +                                      &s->io_mmio, &s->io_ioport, 0, 4,
> +                                      TYPE_PCIE_BUS);
> =20
>      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->gpex_root));
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 2c8acdaaca..0844c30d9a 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -82,13 +82,10 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
> =20
> -    phb->bus =3D pci_register_bus(dev, NULL,
> -                                pci_grackle_set_irq,
> -                                pci_grackle_map_irq,
> -                                pic,
> -                                &d->pci_mmio,
> -                                address_space_io,
> -                                0, 4, TYPE_PCI_BUS);
> +    phb->bus =3D pci_host_bus_init_irqs(phb, NULL,
> +                                      pci_grackle_set_irq,
> +                                      pci_grackle_map_irq, pic, &d->pci_=
mmio,
> +                                      address_space_io, 0, 4, TYPE_PCI_B=
US);
> =20
>      pci_create_simple(phb->bus, 0, "grackle");
>      qdev_init_nofail(dev);
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index f9218aa952..364d57039b 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -340,8 +340,8 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
> =20
>      dev =3D qdev_create(NULL, host_type);
>      s =3D PCI_HOST_BRIDGE(dev);
> -    b =3D pci_bus_new(dev, NULL, pci_address_space,
> -                    address_space_io, 0, TYPE_PCI_BUS);
> +    b =3D pci_host_bus_init(s, NULL, pci_address_space,
> +                          address_space_io, 0, TYPE_PCI_BUS);
>      s->bus =3D b;
>      object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev),=
 NULL);
>      qdev_init_nofail(dev);
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index e502bc0505..babb12af31 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -465,9 +465,10 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      /* PIO lives at the bottom of our bus space */
>      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
> =20
> -    b =3D pci_register_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
> -                         mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
> -                         PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
> +    b =3D pci_host_bus_init_irqs(h, NULL,
> +                               mpc85xx_pci_set_irq, mpc85xx_pci_map_irq,=
 s,
> +                               &s->busmem, &s->pio,
> +                               PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_=
BUS);
>      h->bus =3D b;
> =20
>      /* Set up PCI view of memory */
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 260a119a9e..65add936c7 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -269,8 +269,9 @@ static void raven_pcihost_initfn(Object *obj)
>      memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
>                                          &s->pci_io_non_contiguous, 1);
>      memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_m=
emory);
> -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NU=
LL,
> -                        &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
> +    pci_host_bus_init_inplace(h, &s->pci_bus,
> +                              sizeof(s->pci_bus), NULL, &s->pci_memory,
> +                              &s->pci_io, 0, TYPE_PCI_BUS);
> =20
>      /* Bus master address space */
>      memory_region_init(&s->bm, obj, "bm-raven", UINT32_MAX);
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 344f77b10c..947dc3f124 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -49,9 +49,9 @@ static void q35_host_realize(DeviceState *dev, Error **=
errp)
>      sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
>      sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
> =20
> -    pci->bus =3D pci_bus_new(DEVICE(s), "pcie.0",
> -                           s->mch.pci_address_space, s->mch.address_spac=
e_io,
> -                           0, TYPE_PCIE_BUS);
> +    pci->bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(s), "pcie.0",
> +                                 s->mch.pci_address_space,
> +                                 s->mch.address_space_io, 0, TYPE_PCIE_B=
US);
>      PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
>      qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->mch));
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index df342ac3cb..079faad6ff 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -233,12 +233,10 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
> =20
> -    h->bus =3D pci_register_bus(dev, NULL,
> -                              pci_unin_set_irq, pci_unin_map_irq,
> -                              pic,
> -                              &d->pci_mmio,
> -                              address_space_io,
> -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +    h->bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
> +                                    pci_unin_set_irq, pci_unin_map_irq, =
pic,
> +                                    &d->pci_mmio, address_space_io,
> +                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> =20
>  #if 0
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
> @@ -299,12 +297,10 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
> =20
> -    h->bus =3D pci_register_bus(dev, NULL,
> -                              pci_unin_set_irq, pci_unin_map_irq,
> -                              pic,
> -                              &d->pci_mmio,
> -                              address_space_io,
> -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +    h->bus =3D pci_host_bus_init_irqs(h, NULL,
> +                                    pci_unin_set_irq, pci_unin_map_irq, =
pic,
> +                                    &d->pci_mmio, address_space_io,
> +                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> =20
>      sysbus_mmio_map(s, 0, 0xf0800000);
>      sysbus_mmio_map(s, 1, 0xf0c00000);
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index 467cbb9cb8..cad8848723 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -386,9 +386,10 @@ static void pci_vpb_init(Object *obj)
>      memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << 32=
);
>      memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL << =
32);
> =20
> -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), "p=
ci",
> -                        &s->pci_mem_space, &s->pci_io_space,
> -                        PCI_DEVFN(11, 0), TYPE_PCI_BUS);
> +    pci_host_bus_init_inplace(h, &s->pci_bus,
> +                              sizeof(s->pci_bus), "pci", &s->pci_mem_spa=
ce,
> +                              &s->pci_io_space, PCI_DEVFN(11, 0),
> +                              TYPE_PCI_BUS);
>      h->bus =3D &s->pci_bus;
> =20
>      object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PC=
I_HOST);
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 8b71e2d950..0a3d19b22c 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -129,9 +129,10 @@ static void xilinx_pcie_host_realize(DeviceState *de=
v, Error **errp)
>      sysbus_init_mmio(sbd, &pex->mmio);
>      sysbus_init_mmio(sbd, &s->mmio);
> =20
> -    pci->bus =3D pci_register_bus(dev, s->name, xilinx_pcie_set_irq,
> -                                pci_swizzle_map_irq_fn, s, &s->mmio,
> -                                &s->io, 0, 4, TYPE_PCIE_BUS);
> +    pci->bus =3D pci_host_bus_init_irqs(pci, s->name,
> +                                      xilinx_pcie_set_irq,
> +                                      pci_swizzle_map_irq_fn, s, &s->mmi=
o,
> +                                      &s->io, 0, 4, TYPE_PCIE_BUS);
> =20
>      qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->root));
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0d28ee4e3f..37d65eaf7e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -367,15 +367,13 @@ bool pci_bus_is_root(PCIBus *bus)
>      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
>  }
> =20
> -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pare=
nt,
> -                         const char *name,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, const char *typename)
> +void pci_host_bus_init_inplace(PCIHostState *phb, PCIBus *bus,
> +                               size_t bus_size, const char *name,
> +                               MemoryRegion *address_space_mem,
> +                               MemoryRegion *address_space_io,
> +                               uint8_t devfn_min, const char *typename)
>  {
> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
> -
> -    qbus_create_inplace(bus, bus_size, typename, parent, name);
> +    qbus_create_inplace(bus, bus_size, typename, DEVICE(phb), name);
> =20
>      assert(PCI_FUNC(devfn_min) =3D=3D 0);
>      bus->devfn_min =3D devfn_min;
> @@ -389,16 +387,17 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_si=
ze, DeviceState *parent,
> =20
>  }
> =20
> -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    uint8_t devfn_min, const char *typename)
> +PCIBus *pci_host_bus_init(PCIHostState *phb, const char *name,
> +                           MemoryRegion *address_space_mem,
> +                           MemoryRegion *address_space_io, uint8_t devfn=
_min,
> +                           const char *typename)
>  {
>      size_t bus_size =3D object_type_get_instance_size(typename);
>      PCIBus *bus =3D g_malloc(bus_size);
> =20
> -    pci_bus_new_inplace(bus, bus_size, parent, name, address_space_mem,
> -                        address_space_io, devfn_min, typename);
> +    pci_host_bus_init_inplace(phb, bus, bus_size,
> +                              name, address_space_mem, address_space_io,
> +                              devfn_min, typename);
>      return bus;
>  }
> =20
> @@ -412,17 +411,19 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_i=
rq, pci_map_irq_fn map_irq,
>      bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
>  }
> =20
> -PCIBus *pci_register_bus(DeviceState *parent, const char *name,
> -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> -                         void *irq_opaque,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, int nirq, const char *typena=
me)
> +PCIBus *pci_host_bus_init_irqs(PCIHostState *phb, const char *name,
> +                                pci_set_irq_fn set_irq,
> +                                pci_map_irq_fn map_irq, void *irq_opaque,
> +                                MemoryRegion *address_space_mem,
> +                                MemoryRegion *address_space_io,
> +                                uint8_t devfn_min, int nirq,
> +                                const char *typename)
>  {
>      PCIBus *bus;
> =20
> -    bus =3D pci_bus_new(parent, name, address_space_mem,
> -                      address_space_io, devfn_min, typename);
> +    bus =3D pci_host_bus_init(phb, name,
> +                            address_space_mem,
> +                            address_space_io, devfn_min, typename);
>      pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
>      return bus;
>  }
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index dc19682970..0d767a1a23 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -314,9 +314,10 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
> =20
> -    b =3D pci_register_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
> -                         ppc4xx_pci_map_irq, s->irq, get_system_memory(),
> -                         get_system_io(), 0, 4, TYPE_PCI_BUS);
> +    b =3D pci_host_bus_init_irqs(h, NULL,
> +                               ppc4xx_pci_set_irq, ppc4xx_pci_map_irq, s=
->irq,
> +                               get_system_memory(), get_system_io(), 0, =
4,
> +                               TYPE_PCI_BUS);
>      h->bus =3D b;
> =20
>      pci_create_simple(b, 0, "ppc4xx-host-bridge");
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 98c52e411f..7f29cc77b0 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1697,10 +1697,10 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>      memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
>                                  &sphb->iowindow);
> =20
> -    bus =3D pci_register_bus(dev, NULL,
> -                           pci_spapr_set_irq, pci_spapr_map_irq, sphb,
> -                           &sphb->memspace, &sphb->iospace,
> -                           PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
> +    bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
> +                                 pci_spapr_set_irq, pci_spapr_map_irq, s=
phb,
> +                                 &sphb->memspace, &sphb->iospace,
> +                                 PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI=
_BUS);
>      phb->bus =3D bus;
>      qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
> =20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69b0291e8a..267e1de510 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -560,10 +560,10 @@ static int s390_pcihost_init(SysBusDevice *dev)
> =20
>      DPRINTF("host_init\n");
> =20
> -    b =3D pci_register_bus(DEVICE(dev), NULL,
> -                         s390_pci_set_irq, s390_pci_map_irq, NULL,
> -                         get_system_memory(), get_system_io(), 0, 64,
> -                         TYPE_PCI_BUS);
> +    b =3D pci_host_bus_init_irqs(phb, NULL,
> +                               s390_pci_set_irq, s390_pci_map_irq, NULL,
> +                               get_system_memory(), get_system_io(), 0, =
64,
> +                               TYPE_PCI_BUS);
>      pci_setup_iommu(b, s390_pci_dma_iommu, s);
> =20
>      bus =3D BUS(b);
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 1747628f3d..f589b1628e 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -131,12 +131,10 @@ static int sh_pci_device_init(SysBusDevice *dev)
>      for (i =3D 0; i < 4; i++) {
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
> -    phb->bus =3D pci_register_bus(DEVICE(dev), "pci",
> -                                sh_pci_set_irq, sh_pci_map_irq,
> -                                s->irq,
> -                                get_system_memory(),
> -                                get_system_io(),
> -                                PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
> +    phb->bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), "pci",
> +                                      sh_pci_set_irq, sh_pci_map_irq, s-=
>irq,
> +                                      get_system_memory(), get_system_io=
(),
> +                                      PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
>      memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, =
s,
>                            "sh_pci", 0x224);
>      memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9q9mAAoJEGw4ysog2bOSU8MP+gIRRm++6K41jfx764uu21FL
k6OrE+97b90cCtMOuxo1jFgHPKwfXBubHmtz6m8RJ1f4Hc+UDFJpHpn6IWelMHFi
YG07G6hYuR4eKgy6G0bk3EiWLkEocqmsI8IiOVdYBCs+J+LoucHbxNiYaF3oMYkp
KDaB2Dh58GRcPBHklmNjo+7QbsaFBDOq/feoP34FXD2/FVtF6mSLwiquk2aZvjhs
AaT5nsBDXkC6tY3O9p98pDfDiErFs9U0zYIXtVfIkJvecw6WEKFu0HfL4JrgLGwv
gwjWosFQ5kO3na2iMADgMINprOp72chquaMYY+H1M8FFo0IZpeY4j91Z5xxs6IkV
H8QBFK9OXWw14D0XmyzU4Xju84huZR0jpA3MdwC6Hf0kjMjPSRPcC+dN4fHQK3gT
0W4OCCOb2I1pTka1TcWqI3uWgR9rTOGKMD6zVLFI8wmZCTVleE36TinNWxfIOQSA
x8Z8mo7/q3sYrhwQE2RV/WX9PJDFFuLuLqrc0CtBm0b7HAuTlUxP+urks27aOBP/
3Du5BTXhhJ+nu43rs8ybR2NF0qFjJEvwXGxeukL4qjbw4ZdwUrd17UEL6XtNCEm2
6zMEHU3QK9AXTeTC0TXBuS5mrfVR3bKX3ds0OlwFHH+y3+tTl3CL5BG8VxBQVtLs
h5w5gZynFXZMz1ys3gi/
=FlmY
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
