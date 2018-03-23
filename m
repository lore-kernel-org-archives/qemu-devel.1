Received: from eggs.gnu.org ([2001:4830:134:3::10]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezHWA-0001wO-LA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezHW6-0005cb-7U
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:53:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezHW5-0005cF-Uo
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:53:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2N7nkKg053430
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 03:53:36 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gvtv85pps-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 03:53:36 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 07:53:33 -0000
References: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 08:53:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <18920e5a-d1dc-2146-96e5-4a3f1ba35e9b@de.ibm.com>
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
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, marcel@redhat.com

applied to my s390-next branch.


On 03/14/2018 06:14 AM, Yi Min Zhao wrote:
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
> 
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
