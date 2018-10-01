Received: from eggs.gnu.org ([2001:4830:134:3::10]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zmJ-0007Ky-Kb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6zmF-0001wm-Pj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6zmF-0001uh-JC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:06:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so9163536wme.3
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 08:06:27 -0700 (PDT)
References: <20181001114421.1377-1-clg@kaod.org>
	<20181001114421.1377-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab3fdc91-9bf8-b532-2379-f518fd1dbecf@redhat.com>
Date: Mon, 1 Oct 2018 17:06:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181001114421.1377-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc440_pcix: convert SysBus init
 method to a realize method
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

On 01/10/2018 13:44, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/ppc440_pcix.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index 64ed07afa658..42ef76b6f58a 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -466,17 +466,18 @@ const MemoryRegionOps ppc440_pcix_host_data_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -static int ppc440_pcix_initfn(SysBusDevice *dev)
> +static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      PPC440PCIXState *s;
>      PCIHostState *h;
>  
>      h = PCI_HOST_BRIDGE(dev);
>      s = PPC440_PCIX_HOST_BRIDGE(dev);
>  
> -    sysbus_init_irq(dev, &s->irq);
> +    sysbus_init_irq(sbd, &s->irq);
>      memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
> -    h->bus = pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_irq,
> +    h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
>                           ppc440_pcix_map_irq, &s->irq, &s->busmem,
>                           get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
>  
> @@ -497,17 +498,14 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
>      memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
>      memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iomem);
> -    sysbus_init_mmio(dev, &s->container);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->container);
>  }
>  
>  static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    k->init = ppc440_pcix_initfn;
> +    dc->realize = ppc440_pcix_realize;
>      dc->reset = ppc440_pcix_reset;
>  }
>  
> 
