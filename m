Received: from eggs.gnu.org ([2001:4830:134:3::10]:49606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKoE2-0008QO-G9
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKoDz-0007FX-7z
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:31:42 -0500
Received: from ozlabs.org ([103.22.144.67]:50267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eKoDx-0007Ci-Vb
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:31:39 -0500
Date: Fri, 1 Dec 2017 11:02:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201000250.GB30161@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-2-david@gibson.dropbear.id.au>
	<20171130061721.GB22901@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20171130061721.GB22901@xz-mi>
Subject: Re: [Qemu-devel] [for-2.12 1/7] pci: Rename root bus initialization
 functions for clarity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 02:17:21PM +0800, Peter Xu wrote:
> On Wed, Nov 29, 2017 at 07:46:22PM +1100, David Gibson wrote:
> > pci_bus_init(), pci_bus_new_inplace(), pci_bus_new() and pci_register_b=
us()
> > are misleadingly named.  They're not used for initializing *any* PCI bu=
s,
> > but only for a root PCI bus.
> >=20
> > Non-root buses - i.e. ones under a logical PCI to PCI bridge - are inst=
ead
> > created with a direct qbus_create_inplace() (see pci_bridge_initfn()).
> >=20
> > This patch renames the functions to make it clear they're only used for
> > a root bus.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> An optional nit: would it be nice to name the new functions as:
> pci_bus_root_*()?  Say, I would prefer pci_bus_root_new() than
> pci_root_bus_new() since root bus is still a specific type of bus.

Hrm,.  *_bus_root_* reads very strangely to me, I find it less clear
than ..._root_bus_...

>=20
> Anyways,
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> > ---
> >  hw/alpha/typhoon.c                  |  8 +++---
> >  hw/mips/gt64xxx_pci.c               | 12 ++++-----
> >  hw/pci-bridge/pci_expander_bridge.c |  4 +--
> >  hw/pci-host/apb.c                   | 10 ++++----
> >  hw/pci-host/bonito.c                |  8 +++---
> >  hw/pci-host/gpex.c                  |  6 ++---
> >  hw/pci-host/grackle.c               | 14 +++++------
> >  hw/pci-host/piix.c                  |  4 +--
> >  hw/pci-host/ppce500.c               |  6 ++---
> >  hw/pci-host/prep.c                  |  4 +--
> >  hw/pci-host/q35.c                   |  7 +++---
> >  hw/pci-host/uninorth.c              | 24 +++++++++---------
> >  hw/pci-host/versatile.c             |  6 ++---
> >  hw/pci-host/xilinx-pcie.c           |  6 ++---
> >  hw/pci/pci.c                        | 49 ++++++++++++++++++++---------=
--------
> >  hw/ppc/ppc4xx_pci.c                 |  6 ++---
> >  hw/ppc/spapr_pci.c                  |  8 +++---
> >  hw/s390x/s390-pci-bus.c             |  8 +++---
> >  hw/sh4/sh_pci.c                     | 12 ++++-----
> >  include/hw/pci/pci.h                | 25 ++++++++++---------
> >  20 files changed, 116 insertions(+), 111 deletions(-)
> >=20
> > diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> > index ae11e012c7..6a40869488 100644
> > --- a/hw/alpha/typhoon.c
> > +++ b/hw/alpha/typhoon.c
> > @@ -881,10 +881,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus =
**isa_bus,
> >      memory_region_add_subregion(addr_space, 0x801fc000000ULL,
> >                                  &s->pchip.reg_io);
> > =20
> > -    b =3D pci_register_bus(dev, "pci",
> > -                         typhoon_set_irq, sys_map_irq, s,
> > -                         &s->pchip.reg_mem, &s->pchip.reg_io,
> > -                         0, 64, TYPE_PCI_BUS);
> > +    b =3D pci_register_root_bus(dev, "pci",
> > +                              typhoon_set_irq, sys_map_irq, s,
> > +                              &s->pchip.reg_mem, &s->pchip.reg_io,
> > +                              0, 64, TYPE_PCI_BUS);
> >      phb->bus =3D b;
> >      qdev_init_nofail(dev);
> > =20
> > diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> > index 5a9dad9aae..a9c222a967 100644
> > --- a/hw/mips/gt64xxx_pci.c
> > +++ b/hw/mips/gt64xxx_pci.c
> > @@ -1171,12 +1171,12 @@ PCIBus *gt64120_register(qemu_irq *pic)
> >      phb =3D PCI_HOST_BRIDGE(dev);
> >      memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_M=
AX);
> >      address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
> > -    phb->bus =3D pci_register_bus(dev, "pci",
> > -                                gt64120_pci_set_irq, gt64120_pci_map_i=
rq,
> > -                                pic,
> > -                                &d->pci0_mem,
> > -                                get_system_io(),
> > -                                PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
> > +    phb->bus =3D pci_register_root_bus(dev, "pci",
> > +                                     gt64120_pci_set_irq, gt64120_pci_=
map_irq,
> > +                                     pic,
> > +                                     &d->pci0_mem,
> > +                                     get_system_io(),
> > +                                     PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS=
);
> >      qdev_init_nofail(dev);
> >      memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "=
isd-mem", 0x1000);
> > =20
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index 8c8ac737ad..b2fa829e29 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -230,9 +230,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
> > =20
> >      ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> >      if (pcie) {
> > -        bus =3D pci_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE=
_BUS);
> > +        bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB=
_PCIE_BUS);
> >      } else {
> > -        bus =3D pci_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PX=
B_BUS);
> > +        bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TY=
PE_PXB_BUS);
> >          bds =3D qdev_create(BUS(bus), "pci-bridge");
> >          bds->id =3D dev_name;
> >          qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->=
bus_nr);
> > diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> > index 64025cd8cc..1df998443d 100644
> > --- a/hw/pci-host/apb.c
> > +++ b/hw/pci-host/apb.c
> > @@ -714,11 +714,11 @@ PCIBus *pci_apb_init(hwaddr special_base,
> >      dev =3D qdev_create(NULL, TYPE_APB);
> >      d =3D APB_DEVICE(dev);
> >      phb =3D PCI_HOST_BRIDGE(dev);
> > -    phb->bus =3D pci_register_bus(DEVICE(phb), "pci",
> > -                                pci_apb_set_irq, pci_apb_map_irq, d,
> > -                                &d->pci_mmio,
> > -                                &d->pci_ioport,
> > -                                0, 32, TYPE_PCI_BUS);
> > +    phb->bus =3D pci_register_root_bus(DEVICE(phb), "pci",
> > +                                     pci_apb_set_irq, pci_apb_map_irq,=
 d,
> > +                                     &d->pci_mmio,
> > +                                     &d->pci_ioport,
> > +                                     0, 32, TYPE_PCI_BUS);
> >      qdev_init_nofail(dev);
> >      s =3D SYS_BUS_DEVICE(dev);
> >      /* apb_config */
> > diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> > index 9f61e27edc..f08593feab 100644
> > --- a/hw/pci-host/bonito.c
> > +++ b/hw/pci-host/bonito.c
> > @@ -714,10 +714,10 @@ static int bonito_pcihost_initfn(SysBusDevice *de=
v)
> >  {
> >      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> > =20
> > -    phb->bus =3D pci_register_bus(DEVICE(dev), "pci",
> > -                                pci_bonito_set_irq, pci_bonito_map_irq=
, dev,
> > -                                get_system_memory(), get_system_io(),
> > -                                0x28, 32, TYPE_PCI_BUS);
> > +    phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
> > +                                     pci_bonito_set_irq, pci_bonito_ma=
p_irq,
> > +                                     dev, get_system_memory(), get_sys=
tem_io(),
> > +                                     0x28, 32, TYPE_PCI_BUS);
> > =20
> >      return 0;
> >  }
> > diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> > index edf305b1fd..2583b151a4 100644
> > --- a/hw/pci-host/gpex.c
> > +++ b/hw/pci-host/gpex.c
> > @@ -89,9 +89,9 @@ static void gpex_host_realize(DeviceState *dev, Error=
 **errp)
> >          s->irq_num[i] =3D -1;
> >      }
> > =20
> > -    pci->bus =3D pci_register_bus(dev, "pcie.0", gpex_set_irq,
> > -                                pci_swizzle_map_irq_fn, s, &s->io_mmio,
> > -                                &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
> > +    pci->bus =3D pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
> > +                                     pci_swizzle_map_irq_fn, s, &s->io=
_mmio,
> > +                                     &s->io_ioport, 0, 4, TYPE_PCIE_BU=
S);
> > =20
> >      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
> >      pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
> > diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> > index 38cd279b6b..3caf1ccb37 100644
> > --- a/hw/pci-host/grackle.c
> > +++ b/hw/pci-host/grackle.c
> > @@ -82,13 +82,13 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *p=
ic,
> >      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> >                                  &d->pci_hole);
> > =20
> > -    phb->bus =3D pci_register_bus(dev, NULL,
> > -                                pci_grackle_set_irq,
> > -                                pci_grackle_map_irq,
> > -                                pic,
> > -                                &d->pci_mmio,
> > -                                address_space_io,
> > -                                0, 4, TYPE_PCI_BUS);
> > +    phb->bus =3D pci_register_root_bus(dev, NULL,
> > +                                     pci_grackle_set_irq,
> > +                                     pci_grackle_map_irq,
> > +                                     pic,
> > +                                     &d->pci_mmio,
> > +                                     address_space_io,
> > +                                     0, 4, TYPE_PCI_BUS);
> > =20
> >      pci_create_simple(phb->bus, 0, "grackle");
> >      qdev_init_nofail(dev);
> > diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> > index a684a7cca9..cf9070186c 100644
> > --- a/hw/pci-host/piix.c
> > +++ b/hw/pci-host/piix.c
> > @@ -361,8 +361,8 @@ PCIBus *i440fx_init(const char *host_type, const ch=
ar *pci_type,
> > =20
> >      dev =3D qdev_create(NULL, host_type);
> >      s =3D PCI_HOST_BRIDGE(dev);
> > -    b =3D pci_bus_new(dev, NULL, pci_address_space,
> > -                    address_space_io, 0, TYPE_PCI_BUS);
> > +    b =3D pci_root_bus_new(dev, NULL, pci_address_space,
> > +                         address_space_io, 0, TYPE_PCI_BUS);
> >      s->bus =3D b;
> >      object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev=
), NULL);
> >      qdev_init_nofail(dev);
> > diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> > index 39cd24464d..67edbf744c 100644
> > --- a/hw/pci-host/ppce500.c
> > +++ b/hw/pci-host/ppce500.c
> > @@ -465,9 +465,9 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
> >      /* PIO lives at the bottom of our bus space */
> >      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
> > =20
> > -    b =3D pci_register_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
> > -                         mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
> > -                         PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
> > +    b =3D pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
> > +                              mpc85xx_pci_map_irq, s, &s->busmem, &s->=
pio,
> > +                              PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI=
_BUS);
> >      h->bus =3D b;
> > =20
> >      /* Set up PCI view of memory */
> > diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> > index 92eed0f3e1..01f67f9db1 100644
> > --- a/hw/pci-host/prep.c
> > +++ b/hw/pci-host/prep.c
> > @@ -269,8 +269,8 @@ static void raven_pcihost_initfn(Object *obj)
> >      memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
> >                                          &s->pci_io_non_contiguous, 1);
> >      memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci=
_memory);
> > -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), =
NULL,
> > -                        &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
> > +    pci_root_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(o=
bj), NULL,
> > +                             &s->pci_memory, &s->pci_io, 0, TYPE_PCI_B=
US);
> > =20
> >      /* Bus master address space */
> >      memory_region_init(&s->bm, obj, "bm-raven", UINT32_MAX);
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index 6cb9a8d121..a36a1195e4 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -51,9 +51,10 @@ static void q35_host_realize(DeviceState *dev, Error=
 **errp)
> >      sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
> >      sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
> > =20
> > -    pci->bus =3D pci_bus_new(DEVICE(s), "pcie.0",
> > -                           s->mch.pci_address_space, s->mch.address_sp=
ace_io,
> > -                           0, TYPE_PCIE_BUS);
> > +    pci->bus =3D pci_root_bus_new(DEVICE(s), "pcie.0",
> > +                                s->mch.pci_address_space,
> > +                                s->mch.address_space_io,
> > +                                0, TYPE_PCIE_BUS);
> >      PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> >      qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
> >      qdev_init_nofail(DEVICE(&s->mch));
> > diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> > index ea5c265718..5d8ccaa711 100644
> > --- a/hw/pci-host/uninorth.c
> > +++ b/hw/pci-host/uninorth.c
> > @@ -233,12 +233,12 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
> >      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> >                                  &d->pci_hole);
> > =20
> > -    h->bus =3D pci_register_bus(dev, NULL,
> > -                              pci_unin_set_irq, pci_unin_map_irq,
> > -                              pic,
> > -                              &d->pci_mmio,
> > -                              address_space_io,
> > -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > +    h->bus =3D pci_register_root_bus(dev, NULL,
> > +                                   pci_unin_set_irq, pci_unin_map_irq,
> > +                                   pic,
> > +                                   &d->pci_mmio,
> > +                                   address_space_io,
> > +                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > =20
> >  #if 0
> >      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
> > @@ -299,12 +299,12 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
> >      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> >                                  &d->pci_hole);
> > =20
> > -    h->bus =3D pci_register_bus(dev, NULL,
> > -                              pci_unin_set_irq, pci_unin_map_irq,
> > -                              pic,
> > -                              &d->pci_mmio,
> > -                              address_space_io,
> > -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > +    h->bus =3D pci_register_root_bus(dev, NULL,
> > +                                   pci_unin_set_irq, pci_unin_map_irq,
> > +                                   pic,
> > +                                   &d->pci_mmio,
> > +                                   address_space_io,
> > +                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> > =20
> >      sysbus_mmio_map(s, 0, 0xf0800000);
> >      sysbus_mmio_map(s, 1, 0xf0c00000);
> > diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> > index 6394a520fc..8803ada925 100644
> > --- a/hw/pci-host/versatile.c
> > +++ b/hw/pci-host/versatile.c
> > @@ -399,9 +399,9 @@ static void pci_vpb_realize(DeviceState *dev, Error=
 **errp)
> >      memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << =
32);
> >      memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL <=
< 32);
> > =20
> > -    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), dev, "pci",
> > -                        &s->pci_mem_space, &s->pci_io_space,
> > -                        PCI_DEVFN(11, 0), TYPE_PCI_BUS);
> > +    pci_root_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), dev, "pc=
i",
> > +                             &s->pci_mem_space, &s->pci_io_space,
> > +                             PCI_DEVFN(11, 0), TYPE_PCI_BUS);
> >      h->bus =3D &s->pci_bus;
> > =20
> >      object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_=
PCI_HOST);
> > diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> > index 7659253090..d2f88d11dd 100644
> > --- a/hw/pci-host/xilinx-pcie.c
> > +++ b/hw/pci-host/xilinx-pcie.c
> > @@ -129,9 +129,9 @@ static void xilinx_pcie_host_realize(DeviceState *d=
ev, Error **errp)
> >      sysbus_init_mmio(sbd, &pex->mmio);
> >      sysbus_init_mmio(sbd, &s->mmio);
> > =20
> > -    pci->bus =3D pci_register_bus(dev, s->name, xilinx_pcie_set_irq,
> > -                                pci_swizzle_map_irq_fn, s, &s->mmio,
> > -                                &s->io, 0, 4, TYPE_PCIE_BUS);
> > +    pci->bus =3D pci_register_root_bus(dev, s->name, xilinx_pcie_set_i=
rq,
> > +                                     pci_swizzle_map_irq_fn, s, &s->mm=
io,
> > +                                     &s->io, 0, 4, TYPE_PCIE_BUS);
> > =20
> >      qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
> >      qdev_init_nofail(DEVICE(&s->root));
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index b2d139bd9a..232e7dacf8 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -376,10 +376,10 @@ const char *pci_root_bus_path(PCIDevice *dev)
> >      return rootbus->qbus.name;
> >  }
> > =20
> > -static void pci_bus_init(PCIBus *bus, DeviceState *parent,
> > -                         MemoryRegion *address_space_mem,
> > -                         MemoryRegion *address_space_io,
> > -                         uint8_t devfn_min)
> > +static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
> > +                              MemoryRegion *address_space_mem,
> > +                              MemoryRegion *address_space_io,
> > +                              uint8_t devfn_min)
> >  {
> >      assert(PCI_FUNC(devfn_min) =3D=3D 0);
> >      bus->devfn_min =3D devfn_min;
> > @@ -403,25 +403,27 @@ bool pci_bus_is_root(PCIBus *bus)
> >      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> >  }
> > =20
> > -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> > -                         const char *name,
> > -                         MemoryRegion *address_space_mem,
> > -                         MemoryRegion *address_space_io,
> > -                         uint8_t devfn_min, const char *typename)
> > +void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> > +                              const char *name,
> > +                              MemoryRegion *address_space_mem,
> > +                              MemoryRegion *address_space_io,
> > +                              uint8_t devfn_min, const char *typename)
> >  {
> >      qbus_create_inplace(bus, bus_size, typename, parent, name);
> > -    pci_bus_init(bus, parent, address_space_mem, address_space_io, dev=
fn_min);
> > +    pci_root_bus_init(bus, parent, address_space_mem, address_space_io,
> > +                      devfn_min);
> >  }
> > =20
> > -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> > -                    MemoryRegion *address_space_mem,
> > -                    MemoryRegion *address_space_io,
> > -                    uint8_t devfn_min, const char *typename)
> > +PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
> > +                         MemoryRegion *address_space_mem,
> > +                         MemoryRegion *address_space_io,
> > +                         uint8_t devfn_min, const char *typename)
> >  {
> >      PCIBus *bus;
> > =20
> >      bus =3D PCI_BUS(qbus_create(typename, parent, name));
> > -    pci_bus_init(bus, parent, address_space_mem, address_space_io, dev=
fn_min);
> > +    pci_root_bus_init(bus, parent, address_space_mem, address_space_io,
> > +                      devfn_min);
> >      return bus;
> >  }
> > =20
> > @@ -435,17 +437,18 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set=
_irq, pci_map_irq_fn map_irq,
> >      bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
> >  }
> > =20
> > -PCIBus *pci_register_bus(DeviceState *parent, const char *name,
> > -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_ir=
q,
> > -                         void *irq_opaque,
> > -                         MemoryRegion *address_space_mem,
> > -                         MemoryRegion *address_space_io,
> > -                         uint8_t devfn_min, int nirq, const char *type=
name)
> > +PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
> > +                              pci_set_irq_fn set_irq, pci_map_irq_fn m=
ap_irq,
> > +                              void *irq_opaque,
> > +                              MemoryRegion *address_space_mem,
> > +                              MemoryRegion *address_space_io,
> > +                              uint8_t devfn_min, int nirq,
> > +                              const char *typename)
> >  {
> >      PCIBus *bus;
> > =20
> > -    bus =3D pci_bus_new(parent, name, address_space_mem,
> > -                      address_space_io, devfn_min, typename);
> > +    bus =3D pci_root_bus_new(parent, name, address_space_mem,
> > +                           address_space_io, devfn_min, typename);
> >      pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
> >      return bus;
> >  }
> > diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> > index 4765dcecca..b7642bac01 100644
> > --- a/hw/ppc/ppc4xx_pci.c
> > +++ b/hw/ppc/ppc4xx_pci.c
> > @@ -314,9 +314,9 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
> >          sysbus_init_irq(dev, &s->irq[i]);
> >      }
> > =20
> > -    b =3D pci_register_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
> > -                         ppc4xx_pci_map_irq, s->irq, get_system_memory=
(),
> > -                         get_system_io(), 0, 4, TYPE_PCI_BUS);
> > +    b =3D pci_register_root_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
> > +                              ppc4xx_pci_map_irq, s->irq, get_system_m=
emory(),
> > +                              get_system_io(), 0, 4, TYPE_PCI_BUS);
> >      h->bus =3D b;
> > =20
> >      pci_create_simple(b, 0, "ppc4xx-host-bridge");
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 5a3122a9f9..9262682116 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1621,10 +1621,10 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >      memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
> >                                  &sphb->iowindow);
> > =20
> > -    bus =3D pci_register_bus(dev, NULL,
> > -                           pci_spapr_set_irq, pci_spapr_map_irq, sphb,
> > -                           &sphb->memspace, &sphb->iospace,
> > -                           PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS=
);
> > +    bus =3D pci_register_root_bus(dev, NULL,
> > +                                pci_spapr_set_irq, pci_spapr_map_irq, =
sphb,
> > +                                &sphb->memspace, &sphb->iospace,
> > +                                PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PC=
I_BUS);
> >      phb->bus =3D bus;
> >      qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
> > =20
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 2b1e1409bf..347329dd50 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -554,10 +554,10 @@ static int s390_pcihost_init(SysBusDevice *dev)
> > =20
> >      DPRINTF("host_init\n");
> > =20
> > -    b =3D pci_register_bus(DEVICE(dev), NULL,
> > -                         s390_pci_set_irq, s390_pci_map_irq, NULL,
> > -                         get_system_memory(), get_system_io(), 0, 64,
> > -                         TYPE_PCI_BUS);
> > +    b =3D pci_register_root_bus(DEVICE(dev), NULL,
> > +                              s390_pci_set_irq, s390_pci_map_irq, NULL,
> > +                              get_system_memory(), get_system_io(), 0,=
 64,
> > +                              TYPE_PCI_BUS);
> >      pci_setup_iommu(b, s390_pci_dma_iommu, s);
> > =20
> >      bus =3D BUS(b);
> > diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> > index cbb01af57f..4ec2e35500 100644
> > --- a/hw/sh4/sh_pci.c
> > +++ b/hw/sh4/sh_pci.c
> > @@ -131,12 +131,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
> >      for (i =3D 0; i < 4; i++) {
> >          sysbus_init_irq(dev, &s->irq[i]);
> >      }
> > -    phb->bus =3D pci_register_bus(DEVICE(dev), "pci",
> > -                                sh_pci_set_irq, sh_pci_map_irq,
> > -                                s->irq,
> > -                                get_system_memory(),
> > -                                get_system_io(),
> > -                                PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
> > +    phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
> > +                                     sh_pci_set_irq, sh_pci_map_irq,
> > +                                     s->irq,
> > +                                     get_system_memory(),
> > +                                     get_system_io(),
> > +                                     PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
> >      memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops=
, s,
> >                            "sh_pci", 0x224);
> >      memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 8d02a0a383..870ebcfd4b 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -400,26 +400,27 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *op=
aque, int pin);
> > =20
> >  bool pci_bus_is_express(PCIBus *bus);
> >  bool pci_bus_is_root(PCIBus *bus);
> > -void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> > -                         const char *name,
> > +void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> > +                              const char *name,
> > +                              MemoryRegion *address_space_mem,
> > +                              MemoryRegion *address_space_io,
> > +                              uint8_t devfn_min, const char *typename);
> > +PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
> >                           MemoryRegion *address_space_mem,
> >                           MemoryRegion *address_space_io,
> >                           uint8_t devfn_min, const char *typename);
> > -PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> > -                    MemoryRegion *address_space_mem,
> > -                    MemoryRegion *address_space_io,
> > -                    uint8_t devfn_min, const char *typename);
> >  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn =
map_irq,
> >                    void *irq_opaque, int nirq);
> >  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
> >  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
> >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> > -PCIBus *pci_register_bus(DeviceState *parent, const char *name,
> > -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_ir=
q,
> > -                         void *irq_opaque,
> > -                         MemoryRegion *address_space_mem,
> > -                         MemoryRegion *address_space_io,
> > -                         uint8_t devfn_min, int nirq, const char *type=
name);
> > +PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
> > +                              pci_set_irq_fn set_irq, pci_map_irq_fn m=
ap_irq,
> > +                              void *irq_opaque,
> > +                              MemoryRegion *address_space_mem,
> > +                              MemoryRegion *address_space_io,
> > +                              uint8_t devfn_min, int nirq,
> > +                              const char *typename);
> >  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
> >  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
> >  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlognCkACgkQbDjKyiDZ
s5IyihAA5C4ypCDK5mGMWvSAZ1xwTnTvyUijHFuptdRmXLeA+3TPAY3BKx+goIqs
ef0usQo70p1v4RSPP2lIrHocQheUFdg+HMk0RPzLxMAAkc4ezl56vyUyHMsa0df9
2hQk61xc0bf2qP4ODMhWqvBDPgNaja0CWaCah7+EA/VxU8ga9xBjmM6x7d4OWsZh
G2EY983hcQD5zPiwT+n2cjEGHBL/WLfwKLwTUEzPhLoaQAUzgiASSX8JBWgEYZ6y
8AEhhqVQ7K8/suv+hyfoSHeaXqOPnpYSe/uJxF+mEEl7m0jv66jjAwmpVSI3xo0y
u8N0jNTTktq00a/4+UvvWk327PcvYolqp66DiyrIPwq8m6SHgAE9LV2JAkb3NRbY
bnKeuPg0mj7njJa+g+L0JEjuQe+Yy3tAzoFaY5Fl9Ky+wyll5IlAQ5T2xx4wPGcn
eeTGGQOitmrUmwxTofYN+XlzPEm/h6XnQc9/cEny2Lky8e9Y1ND3vR2u51wFkH6v
95zShT8SNqXtpqi3PbaHqa3/lZYwaYo4lop3kCVuqhV8W5EQSnpJgmqUMB9Z5cyq
BqvN3haan/+9iik2OY8MZ8Ndw+zjD4W+9hgoYf+kpgIPCuDIqyWXWALfwPvJJhXE
g3Jud5bzyC/yrazg93Op73+qmX1A+nRKd+C0SKoo6scF72uN40w=
=BXHS
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
