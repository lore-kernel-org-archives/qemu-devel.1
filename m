Received: from eggs.gnu.org ([2001:4830:134:3::10]:51771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zm9-0007Hw-Os
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zm1-0001ms-So
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6zly-0001lX-UX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so7701344wme.3
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 08:06:10 -0700 (PDT)
References: <20181001114421.1377-1-clg@kaod.org>
	<20181001114421.1377-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc2a8e71-565a-d5cd-8067-2c29ac748286@redhat.com>
Date: Mon, 1 Oct 2018 17:06:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181001114421.1377-3-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc4xx_pci: convert SysBus init method
 to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Hi Cédric,

On 01/10/2018 13:44, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/ppc4xx_pci.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index b7642bac016b..86981be71024 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -300,8 +300,9 @@ static const VMStateDescription vmstate_ppc4xx_pci = {
>  };
>  
>  /* XXX Interrupt acknowledge cycles not supported. */
> -static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
> +static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      PPC4xxPCIState *s;
>      PCIHostState *h;
>      PCIBus *b;
> @@ -311,10 +312,10 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
>      s = PPC4xx_PCI_HOST_BRIDGE(dev);
>  
>      for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
>  
> -    b = pci_register_root_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
> +    b = pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
>                                ppc4xx_pci_map_irq, s->irq, get_system_memory(),
>                                get_system_io(), 0, 4, TYPE_PCI_BUS);
>      h->bus = b;
> @@ -332,10 +333,8 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
>      memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
>      memory_region_add_subregion(&s->container, PCI_REG_BASE, &s->iomem);
> -    sysbus_init_mmio(dev, &s->container);
> +    sysbus_init_mmio(sbd, &s->container);
>      qemu_register_reset(ppc4xx_pci_reset, s);

While here, can you also convert to DeviceClass::reset()?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> -
> -    return 0;
>  }
>  
>  static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
> @@ -367,10 +366,9 @@ static const TypeInfo ppc4xx_host_bridge_info = {
>  
>  static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    k->init = ppc4xx_pcihost_initfn;
> +    dc->realize = ppc4xx_pcihost_realize;
>      dc->vmsd = &vmstate_ppc4xx_pci;
>  }
>  
> 
