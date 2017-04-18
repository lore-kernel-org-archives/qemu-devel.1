Received: from eggs.gnu.org ([2001:4830:134:3::10]:48634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TQM-0007tQ-GB
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TQI-000193-Ok
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:44:06 -0400
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-6-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <cdec6fba-6cbd-1e17-7f45-36dba034c174@redhat.com>
Date: Tue, 18 Apr 2017 16:43:48 +0300
MIME-Version: 1.0
In-Reply-To: <20170417215916.12431-6-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/7] pci: Set phb->bus inside
 pci_register_bus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Paul Burton <paul.burton@imgtec.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

On 04/18/2017 12:59 AM, Eduardo Habkost wrote:
> Every single caller of of pci_register_bus() saves the return value in
> phb->bus. Do that inside pci_register_bus() to avoid code duplication
> and make it harder to break.
>

I personally find that more difficult to follow, maybe the function
name is misleading.
Maybe we can find a better function name or explain the side effect
in a comment?

Thanks,
Marcel

> Most (but not all) conversions done using the following Coccinelle script:
>
>   @@
>   identifier b;
>   expression phb;
>   @@
>   -b = pci_register_bus(phb, ARGS);
>   +phb->bus = pci_register_bus(phb, ARGS);
>    ...
>   -phb->bus = b;
>
>   @@
>   expression phb;
>   expression list ARGS;
>   @@
>   -phb->bus = pci_register_bus(phb, ARGS);
>   +pci_register_bus(phb, ARGS);
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/pci/pci.h      | 12 ++++++------
>  hw/alpha/typhoon.c        | 10 +++++-----
>  hw/mips/gt64xxx_pci.c     |  9 +++------
>  hw/pci-host/apb.c         |  7 ++-----
>  hw/pci-host/bonito.c      |  7 +++----
>  hw/pci-host/gpex.c        |  5 ++---
>  hw/pci-host/grackle.c     |  9 ++-------
>  hw/pci-host/ppce500.c     |  8 ++++----
>  hw/pci-host/uninorth.c    | 18 ++++++------------
>  hw/pci-host/xilinx-pcie.c |  6 +++---
>  hw/pci/pci.c              | 14 +++++++-------
>  hw/ppc/ppc4xx_pci.c       |  8 ++++----
>  hw/ppc/spapr_pci.c        | 10 +++++-----
>  hw/s390x/s390-pci-bus.c   | 10 +++++-----
>  hw/sh4/sh_pci.c           |  9 +++------
>  15 files changed, 60 insertions(+), 82 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 56387ccb0c..3b1e2c408a 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -408,12 +408,12 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
>  /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
>  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> -PCIBus *pci_register_bus(PCIHostState *phb, const char *name,
> -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> -                         void *irq_opaque,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, int nirq, const char *typename);
> +void pci_register_bus(PCIHostState *phb, const char *name,
> +                      pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> +                      void *irq_opaque,
> +                      MemoryRegion *address_space_mem,
> +                      MemoryRegion *address_space_io,
> +                      uint8_t devfn_min, int nirq, const char *typename);
>  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
>  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
>  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index ac0633a55e..5926686d79 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -883,11 +883,11 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
>      memory_region_add_subregion(addr_space, 0x801fc000000ULL,
>                                  &s->pchip.reg_io);
>
> -    b = pci_register_bus(phb, "pci",
> -                         typhoon_set_irq, sys_map_irq, s,
> -                         &s->pchip.reg_mem, &s->pchip.reg_io,
> -                         0, 64, TYPE_PCI_BUS);
> -    phb->bus = b;
> +    pci_register_bus(phb, "pci",
> +                     typhoon_set_irq, sys_map_irq, s,
> +                     &s->pchip.reg_mem, &s->pchip.reg_io,
> +                     0, 64, TYPE_PCI_BUS);
> +    b = phb->bus;
>      qdev_init_nofail(dev);
>
>      /* Host memory as seen from the PCI side, via the IOMMU.  */
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index bd131bcdc6..69963453f0 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1171,12 +1171,9 @@ PCIBus *gt64120_register(qemu_irq *pic)
>      phb = PCI_HOST_BRIDGE(dev);
>      memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_MAX);
>      address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
> -    phb->bus = pci_register_bus(phb, "pci",
> -                                gt64120_pci_set_irq, gt64120_pci_map_irq,
> -                                pic,
> -                                &d->pci0_mem,
> -                                get_system_io(),
> -                                PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
> +    pci_register_bus(phb, "pci", gt64120_pci_set_irq, gt64120_pci_map_irq,
> +                     pic, &d->pci0_mem, get_system_io(), PCI_DEVFN(18, 0), 4,
> +                     TYPE_PCI_BUS);
>      qdev_init_nofail(dev);
>      memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "isd-mem", 0x1000);
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 1156a54224..ea86260b04 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -671,11 +671,8 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      dev = qdev_create(NULL, TYPE_APB);
>      d = APB_DEVICE(dev);
>      phb = PCI_HOST_BRIDGE(dev);
> -    phb->bus = pci_register_bus(phb, "pci",
> -                                pci_apb_set_irq, pci_pbm_map_irq, d,
> -                                &d->pci_mmio,
> -                                get_system_io(),
> -                                0, 32, TYPE_PCI_BUS);
> +    pci_register_bus(phb, "pci", pci_apb_set_irq, pci_pbm_map_irq, d,
> +                     &d->pci_mmio, get_system_io(), 0, 32, TYPE_PCI_BUS);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
>      /* apb_config */
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 27842edc04..bbe595605d 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -714,10 +714,9 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
>  {
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>
> -    phb->bus = pci_register_bus(phb, "pci",
> -                                pci_bonito_set_irq, pci_bonito_map_irq, dev,
> -                                get_system_memory(), get_system_io(),
> -                                0x28, 32, TYPE_PCI_BUS);
> +    pci_register_bus(phb, "pci", pci_bonito_set_irq, pci_bonito_map_irq, dev,
> +                     get_system_memory(), get_system_io(), 0x28, 32,
> +                     TYPE_PCI_BUS);
>
>      return 0;
>  }
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 042d127271..66e2f3d29c 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -62,9 +62,8 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
>          sysbus_init_irq(sbd, &s->irq[i]);
>      }
>
> -    pci->bus = pci_register_bus(pci, "pcie.0", gpex_set_irq,
> -                                pci_swizzle_map_irq_fn, s, &s->io_mmio,
> -                                &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
> +    pci_register_bus(pci, "pcie.0", gpex_set_irq, pci_swizzle_map_irq_fn, s,
> +                     &s->io_mmio, &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
>
>      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->gpex_root));
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index a56c063be9..691af0a29e 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -82,13 +82,8 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
>
> -    phb->bus = pci_register_bus(phb, NULL,
> -                                pci_grackle_set_irq,
> -                                pci_grackle_map_irq,
> -                                pic,
> -                                &d->pci_mmio,
> -                                address_space_io,
> -                                0, 4, TYPE_PCI_BUS);
> +    pci_register_bus(phb, NULL, pci_grackle_set_irq, pci_grackle_map_irq, pic,
> +                     &d->pci_mmio, address_space_io, 0, 4, TYPE_PCI_BUS);
>
>      pci_create_simple(phb->bus, 0, "grackle");
>      qdev_init_nofail(dev);
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 4a1e99f426..43a06961d0 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -465,10 +465,10 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      /* PIO lives at the bottom of our bus space */
>      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
>
> -    b = pci_register_bus(h, NULL, mpc85xx_pci_set_irq,
> -                         mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
> -                         PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
> -    h->bus = b;
> +    pci_register_bus(h, NULL, mpc85xx_pci_set_irq,
> +                     mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
> +                     PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
> +    b = h->bus;
>
>      /* Set up PCI view of memory */
>      memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index b1b89183fc..4d709e5468 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -233,12 +233,9 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
>
> -    h->bus = pci_register_bus(h, NULL,
> -                              pci_unin_set_irq, pci_unin_map_irq,
> -                              pic,
> -                              &d->pci_mmio,
> -                              address_space_io,
> -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +    pci_register_bus(h, NULL, pci_unin_set_irq, pci_unin_map_irq, pic,
> +                     &d->pci_mmio, address_space_io, PCI_DEVFN(11, 0), 4,
> +                     TYPE_PCI_BUS);
>
>  #if 0
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
> @@ -299,12 +296,9 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
>
> -    h->bus = pci_register_bus(h, NULL,
> -                              pci_unin_set_irq, pci_unin_map_irq,
> -                              pic,
> -                              &d->pci_mmio,
> -                              address_space_io,
> -                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +    pci_register_bus(h, NULL, pci_unin_set_irq, pci_unin_map_irq, pic,
> +                     &d->pci_mmio, address_space_io, PCI_DEVFN(11, 0), 4,
> +                     TYPE_PCI_BUS);
>
>      sysbus_mmio_map(s, 0, 0xf0800000);
>      sysbus_mmio_map(s, 1, 0xf0c00000);
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index c951684148..6d53677f57 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -129,9 +129,9 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(sbd, &pex->mmio);
>      sysbus_init_mmio(sbd, &s->mmio);
>
> -    pci->bus = pci_register_bus(pci, s->name, xilinx_pcie_set_irq,
> -                                pci_swizzle_map_irq_fn, s, &s->mmio,
> -                                &s->io, 0, 4, TYPE_PCIE_BUS);
> +    pci_register_bus(pci, s->name, xilinx_pcie_set_irq,
> +                     pci_swizzle_map_irq_fn, s, &s->mmio, &s->io, 0, 4,
> +                     TYPE_PCIE_BUS);
>
>      qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->root));
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index f60d0497ef..d3adf806e5 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -421,19 +421,19 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>      bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
>  }
>
> -PCIBus *pci_register_bus(PCIHostState *phb, const char *name,
> -                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> -                         void *irq_opaque,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min, int nirq, const char *typename)
> +void pci_register_bus(PCIHostState *phb, const char *name,
> +                      pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
> +                      void *irq_opaque,
> +                      MemoryRegion *address_space_mem,
> +                      MemoryRegion *address_space_io,
> +                      uint8_t devfn_min, int nirq, const char *typename)
>  {
>      PCIBus *bus;
>
>      bus = pci_bus_new(phb, name, address_space_mem,
>                        address_space_io, devfn_min, typename);
>      pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
> -    return bus;
> +    phb->bus = bus;
>  }
>
>  int pci_bus_num(PCIBus *s)
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index f755c6faae..ab158b3ef1 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -314,10 +314,10 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
>
> -    b = pci_register_bus(h, NULL, ppc4xx_pci_set_irq,
> -                         ppc4xx_pci_map_irq, s->irq, get_system_memory(),
> -                         get_system_io(), 0, 4, TYPE_PCI_BUS);
> -    h->bus = b;
> +    pci_register_bus(h, NULL, ppc4xx_pci_set_irq,
> +                     ppc4xx_pci_map_irq, s->irq, get_system_memory(),
> +                     get_system_io(), 0, 4, TYPE_PCI_BUS);
> +    b = h->bus;
>
>      pci_create_simple(b, 0, "ppc4xx-host-bridge");
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0f293f9e75..5749f14d9f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1697,11 +1697,11 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
>                                  &sphb->iowindow);
>
> -    bus = pci_register_bus(phb, NULL,
> -                           pci_spapr_set_irq, pci_spapr_map_irq, sphb,
> -                           &sphb->memspace, &sphb->iospace,
> -                           PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
> -    phb->bus = bus;
> +    pci_register_bus(phb, NULL,
> +                     pci_spapr_set_irq, pci_spapr_map_irq, sphb,
> +                     &sphb->memspace, &sphb->iospace,
> +                     PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
> +    bus = phb->bus;
>      qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
>
>      /*
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 99aae965bb..466067a380 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -560,15 +560,15 @@ static int s390_pcihost_init(SysBusDevice *dev)
>
>      DPRINTF("host_init\n");
>
> -    b = pci_register_bus(phb, NULL,
> -                         s390_pci_set_irq, s390_pci_map_irq, NULL,
> -                         get_system_memory(), get_system_io(), 0, 64,
> -                         TYPE_PCI_BUS);
> +    pci_register_bus(phb, NULL,
> +                     s390_pci_set_irq, s390_pci_map_irq, NULL,
> +                     get_system_memory(), get_system_io(), 0, 64,
> +                     TYPE_PCI_BUS);
> +    b = phb->bus;
>      pci_setup_iommu(b, s390_pci_dma_iommu, s);
>
>      bus = BUS(b);
>      qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
> -    phb->bus = b;
>
>      s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));
>      qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index bca849c10f..bb43bad77d 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -131,12 +131,9 @@ static int sh_pci_device_init(SysBusDevice *dev)
>      for (i = 0; i < 4; i++) {
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
> -    phb->bus = pci_register_bus(phb, "pci",
> -                                sh_pci_set_irq, sh_pci_map_irq,
> -                                s->irq,
> -                                get_system_memory(),
> -                                get_system_io(),
> -                                PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
> +    pci_register_bus(phb, "pci", sh_pci_set_irq, sh_pci_map_irq, s->irq,
> +                     get_system_memory(), get_system_io(), PCI_DEVFN(0, 0), 4,
> +                     TYPE_PCI_BUS);
>      memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, s,
>                            "sh_pci", 0x224);
>      memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
>
