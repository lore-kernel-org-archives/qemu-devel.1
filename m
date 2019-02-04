Received: from eggs.gnu.org ([209.51.188.92]:42361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqn9E-0005IL-Kr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqn2u-0006rl-Fc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:48:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60848
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gqn2s-0006qq-JD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:48:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14MXRSg098327
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 17:48:53 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qev70n54c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 17:48:53 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 4 Feb 2019 22:48:52 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-3-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 4 Feb 2019 17:48:49 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <83c38b9c-4b61-0067-2053-cdfe34b128bf@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/6] s390x/pci: Fix
 hotplugging of PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
> When hotplugging a PCI bridge right now to the root port, we resolve
> pci_get_bus(pdev)->parent_dev, which results in a SEGFAULT. Hotplugging
> really only works right now when hotplugging to another bridge.
> 
> Instead, we have to properly check if we are already at the root.
> 
> Let's cleanup the code while at it a bit and factor out updating the
> subordiante bus number into a separate function. The check for

s/subordiante/subordinate

> "old_nr < nr" is right now not strictly necessary, but makes it more
> obvious what is actually going on.
> 
> Most probably fixing up the topology is not our responsibility when
> hotplugging. The guest has to sort this out. But let's keep it for now
> and only fix current code to not crash.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b7c4613fde..9b5c5fff60 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -843,6 +843,21 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       }
>   }
>   
> +static void s390_pci_update_subordinate(PCIDevice *dev, uint32_t nr)
> +{
> +    uint32_t old_nr;
> +
> +    pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1);
> +    while (!pci_bus_is_root(pci_get_bus(dev))) {
> +        dev = pci_get_bus(dev)->parent_dev;
> +
> +        old_nr = pci_default_read_config(dev, PCI_SUBORDINATE_BUS, 1);
> +        if (old_nr < nr) {
> +            pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1);
> +        }
> +    }
> +} > +
>   static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>   {
> @@ -851,26 +866,21 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       S390PCIBusDevice *pbdev = NULL;
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
> -        BusState *bus;
>           PCIBridge *pb = PCI_BRIDGE(dev);
> -        PCIDevice *pdev = PCI_DEVICE(dev);
>   
> +        pdev = PCI_DEVICE(dev);
>           pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>           pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>   
> -        bus = BUS(&pb->sec_bus);
> -        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
> +        qbus_set_hotplug_handler(BUS(&pb->sec_bus), DEVICE(s), errp);
>   
>           if (dev->hotplugged) {
>               pci_default_write_config(pdev, PCI_PRIMARY_BUS,
>                                        pci_dev_bus_num(pdev), 1);
>               s->bus_no += 1;
>               pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
> -            do {
> -                pdev = pci_get_bus(pdev)->parent_dev;
> -                pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
> -                                         s->bus_no, 1);
> -            } while (pci_get_bus(pdev) && pci_dev_bus_num(pdev));
> +
> +            s390_pci_update_subordinate(pdev, s->bus_no);
>           }
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>           pdev = PCI_DEVICE(dev);
> 

Looks good to me...

Reviewed-by: Collin Walling <walling@linux.ibm.com>

Side note: unrelated to the changes here -- and if you can clarify for
me -- any idea why we do s->bus_no += 1? This throws me off a bit and
begs me to ask what exactly is the S390pciState object suppose to
represent? (My guess is that it is representative of the entire PCI
topology, and we increment the bus_no to denote the subordinate bus
number?)

(let me know if these kind of discussions are too noisy and deemed
inappropriate for the mailing list, and I'll start pestering you off-
list instead)
