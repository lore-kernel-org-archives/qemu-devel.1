Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g80HY-0005w8-Le
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g80HU-0001Iw-Da
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:50:56 -0400
References: <1538466491-2073-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2b7c7da7-2b33-78b8-3a3d-f77159e4ec9e@redhat.com>
Date: Thu, 4 Oct 2018 11:50:43 +0200
MIME-Version: 1.0
In-Reply-To: <1538466491-2073-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/s390-pci-bus: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yi Min Zhao <zyimin@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Pierre Morel <pmorel@linux.ibm.com>

On 02/10/2018 09:48, Thomas Huth wrote:
> The SysBusDeviceClass->init() interface is considered as a legacy interface
> and there are currently some efforts going on to get rid of it. Thus let's
> convert the init function in the s390x code to realize() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e3e0ebb..e42e1b8 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -692,27 +692,35 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>      object_unref(OBJECT(iommu));
>  }
>  
> -static int s390_pcihost_init(SysBusDevice *dev)
> +static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIBus *b;
>      BusState *bus;
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>      S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
> +    Error *local_err = NULL;
>  
>      DPRINTF("host_init\n");
>  
> -    b = pci_register_root_bus(DEVICE(dev), NULL,
> -                              s390_pci_set_irq, s390_pci_map_irq, NULL,
> -                              get_system_memory(), get_system_io(), 0, 64,
> -                              TYPE_PCI_BUS);
> +    b = pci_register_root_bus(dev, NULL, s390_pci_set_irq, s390_pci_map_irq,
> +                              NULL, get_system_memory(), get_system_io(), 0,
> +                              64, TYPE_PCI_BUS);
>      pci_setup_iommu(b, s390_pci_dma_iommu, s);
>  
>      bus = BUS(b);
> -    qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
> +    qbus_set_hotplug_handler(bus, dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      phb->bus = b;
>  
> -    s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));
> -    qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
> +    s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, dev, NULL));
> +    qbus_set_hotplug_handler(BUS(s->bus), dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  
>      s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
>                                             NULL, g_free);
> @@ -722,9 +730,10 @@ static int s390_pcihost_init(SysBusDevice *dev)
>      QTAILQ_INIT(&s->zpci_devs);
>  
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
> -                             S390_ADAPTER_SUPPRESSIBLE, &error_abort);
> -
> -    return 0;
> +                             S390_ADAPTER_SUPPRESSIBLE, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
>  }
>  
>  static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
> @@ -1018,12 +1027,11 @@ static void s390_pcihost_reset(DeviceState *dev)
>  
>  static void s390_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>  
>      dc->reset = s390_pcihost_reset;
> -    k->init = s390_pcihost_init;
> +    dc->realize = s390_pcihost_realize;
>      hc->plug = s390_pcihost_hot_plug;
>      hc->unplug = s390_pcihost_hot_unplug;
>      msi_nonbroken = true;
> 

So we really only overwrite sysbus_realize() here, which only does an
init call.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
