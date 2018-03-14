Received: from eggs.gnu.org ([2001:4830:134:3::10]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evz4h-0003Am-DW
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evz4e-0004Ri-B2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:35:43 -0400
References: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62501049-ae2b-f6cc-2f79-04e1b6072a2c@redhat.com>
Date: Wed, 14 Mar 2018 06:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: forbid multifunction pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, marcel@redhat.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 14.03.2018 06:14, Yi Min Zhao wrote:
> Currently we don't support pci multifunction. If a pci with
> multifucntion is plugged, the guest will spin forever. This patch fixes
> this.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 77a50cab36..10da87458e 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -816,6 +816,11 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
>          PCIBridge *pb = PCI_BRIDGE(dev);
>          PCIDevice *pdev = PCI_DEVICE(dev);

Off-topic: That "PCIDevice *pdev" shadows the pdev variable that is
declared at the beginning of this function. So I think we should rather
change the above line into "pdev = PCI_DEVICE(dev)" instead, without
re-declaring a variable here. (i.e. we should do this in a separate
patch later...).

> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +            error_setg(errp, "multifunction not supported in s390");
> +            return;
> +        }
> +
>          pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>          pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>  
> @@ -835,6 +840,11 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          pdev = PCI_DEVICE(dev);
>  
> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +            error_setg(errp, "multifunction not supported in s390");
> +            return;
> +        }
> +
>          if (!dev->id) {
>              /* In the case the PCI device does not define an id */
>              /* we generate one based on the PCI address         */
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
