Received: from eggs.gnu.org ([2001:4830:134:3::10]:52061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zn5-0007hb-Sf
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zn0-0002Vy-2B
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:07:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6zmz-0002Pv-NH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:07:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id b11-v6so14350043wru.9
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 08:07:10 -0700 (PDT)
References: <20181001150413.12955-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9616409-048e-08b2-3c6f-a8b93759a5f1@redhat.com>
Date: Mon, 1 Oct 2018 17:07:08 +0200
MIME-Version: 1.0
In-Reply-To: <20181001150413.12955-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] PPC: e500: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 01/10/2018 17:04, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/ppce500.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index eb75e080fc10..b8f8c112e662 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -436,8 +436,9 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *bus, void *opaque,
>      return &s->bm_as;
>  }
>  
> -static int e500_pcihost_initfn(SysBusDevice *dev)
> +static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      PCIHostState *h;
>      PPCE500PCIState *s;
>      PCIBus *b;
> @@ -447,7 +448,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      s = PPC_E500_PCI_HOST_BRIDGE(dev);
>  
>      for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
>  
>      for (i = 0; i < PCI_NUM_PINS; i++) {
> @@ -460,7 +461,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      /* PIO lives at the bottom of our bus space */
>      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
>  
> -    b = pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
> +    b = pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
>                                mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
>                                PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
>      h->bus = b;
> @@ -483,10 +484,8 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIE500_CFGADDR, &h->conf_mem);
>      memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->data_mem);
>      memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->iomem);
> -    sysbus_init_mmio(dev, &s->container);
> +    sysbus_init_mmio(sbd, &s->container);
>      pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
> -
> -    return 0;
>  }
>  
>  static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
> @@ -526,9 +525,8 @@ static Property pcihost_properties[] = {
>  static void e500_pcihost_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = e500_pcihost_initfn;
> +    dc->realize = e500_pcihost_realize;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->props = pcihost_properties;
>      dc->vmsd = &vmstate_ppce500_pci;
> 
