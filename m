Received: from eggs.gnu.org ([2001:4830:134:3::10]:41342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGqEI-0005qX-D0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGqEE-0003nq-B5
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:51:34 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGqEE-0003nf-5i
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:51:30 -0500
Received: by mail-qt0-x243.google.com with SMTP id a19so15777693qtb.3
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 09:51:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-11-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2308a702-b436-8158-a905-9947277b8a6c@amsat.org>
Date: Mon, 20 Nov 2017 14:51:00 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-11-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/15] apb: remove pci_apb_init() and
 instantiate APB device using qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

Hi Mark,

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> By making the special_base and mem_base values qdev properties, we can move
> the remaining parts of pci_apb_init() into the pbm init() and realize()
> functions.
> 
> This finally allows us to instantiate the APB directly using standard qdev
> create/init functions in sun4u.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/apb.c         |  123 ++++++++++++++++++++++-----------------------
>  hw/sparc64/sun4u.c        |    6 ++-
>  include/hw/pci-host/apb.h |    4 +-
>  3 files changed, 68 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 823661a..6c20285 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -611,41 +611,56 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>      pci_bridge_update_mappings(PCI_BRIDGE(br));
>  }
>  
> -APBState *pci_apb_init(hwaddr special_base,
> -                       hwaddr mem_base)
> +static void pci_pbm_reset(DeviceState *d)
>  {
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    PCIHostState *phb;
> -    APBState *d;
> -    IOMMUState *is;
> +    unsigned int i;
> +    APBState *s = APB_DEVICE(d);
> +
> +    for (i = 0; i < 8; i++) {
> +        s->pci_irq_map[i] &= PBM_PCI_IMR_MASK;
> +    }
> +    for (i = 0; i < 32; i++) {
> +        s->obio_irq_map[i] &= PBM_PCI_IMR_MASK;
> +    }
> +
> +    s->irq_request = NO_IRQ_REQUEST;
> +    s->pci_irq_in = 0ULL;
> +
> +    if (s->nr_resets++ == 0) {
> +        /* Power on reset */
> +        s->reset_control = POR;
> +    }
> +}
> +
> +static const MemoryRegionOps pci_config_ops = {
> +    .read = apb_pci_config_read,
> +    .write = apb_pci_config_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void pci_pbm_realize(DeviceState *dev, Error **errp)
> +{
> +    APBState *s = APB_DEVICE(dev);
> +    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
>      PCIDevice *pci_dev;
> +    IOMMUState *is;
>  
> -    /* Ultrasparc PBM main bus */
> -    dev = qdev_create(NULL, TYPE_APB);
> -    d = APB_DEVICE(dev);
> -    phb = PCI_HOST_BRIDGE(dev);
> -    phb->bus = pci_register_bus(DEVICE(phb), "pci",
> -                                pci_apb_set_irq, pci_apb_map_irq, d,
> -                                &d->pci_mmio,
> -                                &d->pci_ioport,
> -                                0, 32, TYPE_PCI_BUS);
> -    qdev_init_nofail(dev);
> -    s = SYS_BUS_DEVICE(dev);
>      /* apb_config */
> -    sysbus_mmio_map(s, 0, special_base);
> +    sysbus_mmio_map(sbd, 0, s->special_base);

You might add a safety check than special_base is correctly initialize
(compare to -1?)

>      /* PCI configuration space */
> -    sysbus_mmio_map(s, 1, special_base + 0x1000000ULL);
> +    sysbus_mmio_map(sbd, 1, s->special_base + 0x1000000ULL);
>      /* pci_ioport */
> -    sysbus_mmio_map(s, 2, special_base + 0x2000000ULL);
> +    sysbus_mmio_map(sbd, 2, s->special_base + 0x2000000ULL);
>  
> -    memory_region_init(&d->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
> -    memory_region_add_subregion(get_system_memory(), mem_base, &d->pci_mmio);
> +    memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
> +    memory_region_add_subregion(get_system_memory(), s->mem_base,

Ditto with mem_base

> +                                &s->pci_mmio);
>  
>      pci_create_simple(phb->bus, 0, "pbm-pci");
>  
>      /* APB IOMMU */
> -    is = &d->iommu;
> +    is = &s->iommu;
>      memset(is, 0, sizeof(IOMMUState));
>  
>      memory_region_init_iommu(&is->iommu, sizeof(is->iommu),
> @@ -657,52 +672,30 @@ APBState *pci_apb_init(hwaddr special_base,
>      /* APB secondary busses */
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
>                                     TYPE_PBM_PCI_BRIDGE);
> -    d->bridgeB = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(d->bridgeB, "pciB", pci_pbm_map_irq);
> +    s->bridgeB = PCI_BRIDGE(pci_dev);
> +    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbm_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
>  
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
>                                     TYPE_PBM_PCI_BRIDGE);
> -    d->bridgeA = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(d->bridgeA, "pciA", pci_pbm_map_irq);
> +    s->bridgeA = PCI_BRIDGE(pci_dev);
> +    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbm_map_irq);
>      qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
>      qdev_init_nofail(&pci_dev->qdev);
> -
> -    return d;
>  }
>  
> -static void pci_pbm_reset(DeviceState *d)
> +static void pci_pbm_init(Object *obj)
>  {
> +    APBState *s = APB_DEVICE(obj);
> +    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      unsigned int i;
> -    APBState *s = APB_DEVICE(d);
> -
> -    for (i = 0; i < 8; i++) {
> -        s->pci_irq_map[i] &= PBM_PCI_IMR_MASK;
> -    }
> -    for (i = 0; i < 32; i++) {
> -        s->obio_irq_map[i] &= PBM_PCI_IMR_MASK;
> -    }
> -
> -    s->irq_request = NO_IRQ_REQUEST;
> -    s->pci_irq_in = 0ULL;
> -
> -    if (s->nr_resets++ == 0) {
> -        /* Power on reset */
> -        s->reset_control = POR;
> -    }
> -}
>  
> -static const MemoryRegionOps pci_config_ops = {
> -    .read = apb_pci_config_read,
> -    .write = apb_pci_config_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static int pci_pbm_init_device(DeviceState *dev)
> -{
> -    APBState *s = APB_DEVICE(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
> -    unsigned int i;
> +    phb->bus = pci_register_bus(DEVICE(phb), "pci",
> +                                pci_apb_set_irq, pci_apb_map_irq, s,
> +                                &s->pci_mmio,
> +                                &s->pci_ioport,
> +                                0, 32, TYPE_PCI_BUS);
>  
>      for (i = 0; i < 8; i++) {
>          s->pci_irq_map[i] = (0x1f << 6) | (i << 2);
> @@ -734,8 +727,6 @@ static int pci_pbm_init_device(DeviceState *dev)
>  
>      /* at region 2 */
>      sysbus_init_mmio(sbd, &s->pci_ioport);
> -
> -    return 0;
>  }
>  
>  static void pbm_pci_host_realize(PCIDevice *d, Error **errp)
> @@ -774,12 +765,19 @@ static const TypeInfo pbm_pci_host_info = {
>      },
>  };
>  
> +static Property pbm_pci_host_properties[] = {
> +    DEFINE_PROP_UINT64("special-base", APBState, special_base, 0),

UINT64_MAX for explicitly set correct base?

> +    DEFINE_PROP_UINT64("mem-base", APBState, mem_base, 0),

Ditto

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pbm_host_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->init = pci_pbm_init_device;
> +    dc->realize = pci_pbm_realize;
>      dc->reset = pci_pbm_reset;
> +    dc->props = pbm_pci_host_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>  
> @@ -787,6 +785,7 @@ static const TypeInfo pbm_host_info = {
>      .name          = TYPE_APB,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(APBState),
> +    .instance_init = pci_pbm_init,
>      .class_init    = pbm_host_class_init,
>  };
>  
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 47952be..0a30fb8 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -502,7 +502,11 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>  
>      prom_init(hwdef->prom_addr, bios_name);
>  
> -    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE);
> +    /* Init APB (PCI host bridge) */
> +    apb = APB_DEVICE(qdev_create(NULL, TYPE_APB));
> +    qdev_prop_set_uint64(DEVICE(apb), "special-base", APB_SPECIAL_BASE);
> +    qdev_prop_set_uint64(DEVICE(apb), "mem-base", APB_MEM_BASE);
> +    qdev_init_nofail(DEVICE(apb));

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      /* Wire up PCI interrupts to CPU */
>      for (i = 0; i < IVEC_MAX; i++) {
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index ae15d8c..f0074f7 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -62,6 +62,8 @@ typedef struct IOMMUState {
>  typedef struct APBState {
>      PCIHostState parent_obj;
>  
> +    hwaddr special_base;
> +    hwaddr mem_base;
>      MemoryRegion apb_config;
>      MemoryRegion pci_config;
>      MemoryRegion pci_mmio;
> @@ -93,6 +95,4 @@ typedef struct PBMPCIBridge {
>  #define PBM_PCI_BRIDGE(obj) \
>      OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
>  
> -APBState *pci_apb_init(hwaddr special_base,
> -                       hwaddr mem_base);
>  #endif
> 
