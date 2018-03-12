Received: from eggs.gnu.org ([2001:4830:134:3::10]:46507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLFf-0005HX-5J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evLFd-0007cf-Lm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:04:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96729f75-acd0-8b9e-c7c8-ceb4d274f1d2@amsat.org>
Date: Mon, 12 Mar 2018 12:04:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180306203103.25563-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/19] uninorth: move PCI host bridge bus
 initialisation into device realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/06/2018 09:30 PM, Mark Cave-Ayland wrote:
> Since the IO address space is fixed to use the standard system IO address
> space then we can also use the opportunity to remove the address_space_io
> parameter from pci_pmac_init() and pci_pmac_u3_init().
> 
> Note we also move the default mac99 PCI bus to the end of the initialisation
> list so that it becomes the default destination for any devices specified
> via -device without an explicit PCI bus provided.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/uninorth.c | 117 ++++++++++++++++++++++++++++---------------------
>  hw/ppc/mac.h           |   6 +--
>  hw/ppc/mac_newworld.c  |   6 +--
>  3 files changed, 72 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index fc59698f06..426b3c4e33 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -109,6 +109,27 @@ static const MemoryRegionOps unin_data_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static void pci_unin_main_realize(DeviceState *dev, Error **errp)
> +{
> +    UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
> +    PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +
> +    h->bus = pci_register_root_bus(dev, NULL,
> +                                   pci_unin_set_irq, pci_unin_map_irq,
> +                                   s->pic_irqs,
> +                                   &s->pci_mmio,
> +                                   get_system_io(),
> +                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +
> +    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
> +
> +    /* DEC 21154 bridge */
> +#if 0
> +    /* XXX: not activated as PPC BIOS doesn't handle multiple buses properly */
> +    pci_create_simple(h->bus, PCI_DEVFN(12, 0), "dec-21154");
> +#endif
> +}
> +
>  static void pci_unin_main_init(Object *obj)
>  {
>      UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(obj);
> @@ -129,6 +150,21 @@ static void pci_unin_main_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->data_mem);
>  }
>  
> +static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
> +{
> +    UNINState *s = U3_AGP_HOST_BRIDGE(dev);
> +    PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +
> +    h->bus = pci_register_root_bus(dev, NULL,
> +                                   pci_unin_set_irq, pci_unin_map_irq,
> +                                   s->pic_irqs,
> +                                   &s->pci_mmio,
> +                                   get_system_io(),
> +                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +
> +    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
> +}
> +
>  static void pci_u3_agp_init(Object *obj)
>  {
>      UNINState *s = U3_AGP_HOST_BRIDGE(obj);
> @@ -148,6 +184,19 @@ static void pci_u3_agp_init(Object *obj)
>      sysbus_init_mmio(sbd, &h->data_mem);
>  }
>  
> +static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
> +{
> +    UNINState *s = UNI_NORTH_AGP_HOST_BRIDGE(dev);
> +    PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +
> +    h->bus = pci_register_root_bus(dev, NULL,
> +                                   pci_unin_set_irq, pci_unin_map_irq,
> +                                   s->pic_irqs,
> +                                   &s->pci_mmio,
> +                                   get_system_io(),
> +                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> +}
> +
>  static void pci_unin_agp_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> @@ -177,49 +226,14 @@ static void pci_unin_internal_init(Object *obj)
>  }
>  
>  UNINState *pci_pmac_init(qemu_irq *pic,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io)
> +                         MemoryRegion *address_space_mem)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> -    PCIHostState *h;
>      UNINState *d;
>  
>      /* Use values found on a real PowerMac */
> -    /* Uninorth main bus */
> -    dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
> -    qdev_prop_set_ptr(dev, "pic-irqs", pic);
> -    qdev_init_nofail(dev);
> -    s = SYS_BUS_DEVICE(dev);
> -    h = PCI_HOST_BRIDGE(s);
> -    d = UNI_NORTH_PCI_HOST_BRIDGE(dev);
> -    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
> -                             0x80000000ULL, 0x10000000ULL);
> -    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> -                                &d->pci_hole);
> -
> -    h->bus = pci_register_root_bus(dev, NULL,
> -                                   pci_unin_set_irq, pci_unin_map_irq,
> -                                   d->pic_irqs,
> -                                   &d->pci_mmio,
> -                                   address_space_io,
> -                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> -
> -#if 0
> -    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
> -#endif
> -
> -    sysbus_mmio_map(s, 0, 0xf2800000);
> -    sysbus_mmio_map(s, 1, 0xf2c00000);
> -
> -    /* DEC 21154 bridge */
> -#if 0
> -    /* XXX: not activated as PPC BIOS doesn't handle multiple buses properly */
> -    pci_create_simple(h->bus, PCI_DEVFN(12, 0), "dec-21154");
> -#endif
> -
>      /* Uninorth AGP bus */
> -    pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
>      dev = qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
>      qdev_prop_set_ptr(dev, "pic-irqs", pic);
>      qdev_init_nofail(dev);
> @@ -239,16 +253,28 @@ UNINState *pci_pmac_init(qemu_irq *pic,
>      sysbus_mmio_map(s, 1, 0xf4c00000);
>  #endif
>  
> +    /* Uninorth main bus */
> +    dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
> +    qdev_prop_set_ptr(dev, "pic-irqs", pic);
> +    qdev_init_nofail(dev);
> +    s = SYS_BUS_DEVICE(dev);
> +    d = UNI_NORTH_PCI_HOST_BRIDGE(dev);
> +    memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
> +                             0x80000000ULL, 0x10000000ULL);
> +    memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> +                                &d->pci_hole);
> +
> +    sysbus_mmio_map(s, 0, 0xf2800000);
> +    sysbus_mmio_map(s, 1, 0xf2c00000);
> +
>      return d;
>  }
>  
>  UNINState *pci_pmac_u3_init(qemu_irq *pic,
> -                            MemoryRegion *address_space_mem,
> -                            MemoryRegion *address_space_io)
> +                            MemoryRegion *address_space_mem)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> -    PCIHostState *h;
>      UNINState *d;
>  
>      /* Uninorth AGP bus */
> @@ -256,7 +282,6 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
>      qdev_prop_set_ptr(dev, "pic-irqs", pic);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
> -    h = PCI_HOST_BRIDGE(dev);
>      d = U3_AGP_HOST_BRIDGE(dev);
>  
>      memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
> @@ -264,18 +289,9 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
>  
> -    h->bus = pci_register_root_bus(dev, NULL,
> -                                   pci_unin_set_irq, pci_unin_map_irq,
> -                                   d->pic_irqs,
> -                                   &d->pci_mmio,
> -                                   address_space_io,
> -                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> -
>      sysbus_mmio_map(s, 0, 0xf0800000);
>      sysbus_mmio_map(s, 1, 0xf0c00000);
>  
> -    pci_create_simple(h->bus, 11 << 3, "u3-agp");
> -
>      return d;
>  }
>  
> @@ -448,6 +464,7 @@ static void pci_unin_main_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->realize = pci_unin_main_realize;
>      dc->props = pci_unin_main_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> @@ -469,6 +486,7 @@ static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->realize = pci_u3_agp_realize;
>      dc->props = pci_u3_agp_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> @@ -490,6 +508,7 @@ static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->realize = pci_unin_agp_realize;
>      dc->props = pci_unin_agp_class_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index fcf13cb757..628415b255 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -89,11 +89,9 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
>  
>  /* UniNorth PCI */
>  UNINState *pci_pmac_init(qemu_irq *pic,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io);
> +                         MemoryRegion *address_space_mem);
>  UNINState *pci_pmac_u3_init(qemu_irq *pic,
> -                            MemoryRegion *address_space_mem,
> -                            MemoryRegion *address_space_io);
> +                            MemoryRegion *address_space_mem);
>  
>  /* Mac NVRAM */
>  #define TYPE_MACIO_NVRAM "macio-nvram"
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 34908d0dd7..f2b07207d3 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -346,12 +346,10 @@ static void ppc_core99_init(MachineState *machine)
>  
>      if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
>          /* 970 gets a U3 bus */
> -        uninorth_pci = pci_pmac_u3_init(pic, get_system_memory(),
> -                                        get_system_io());
> +        uninorth_pci = pci_pmac_u3_init(pic, get_system_memory());
>          machine_arch = ARCH_MAC99_U3;
>      } else {
> -        uninorth_pci = pci_pmac_init(pic, get_system_memory(),
> -                                     get_system_io());
> +        uninorth_pci = pci_pmac_init(pic, get_system_memory());
>          machine_arch = ARCH_MAC99;
>      }
>  
> 
