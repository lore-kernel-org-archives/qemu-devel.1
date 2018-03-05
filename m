Received: from eggs.gnu.org ([2001:4830:134:3::10]:32951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eslTb-0008Nb-1S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eslTX-00086m-0j
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eslTW-00086T-Rh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:02 -0500
Date: Mon, 5 Mar 2018 16:27:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180305082743.GC7584@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Thu, Mar 01, 2018 at 06:33:31PM +0800, Liu, Yi L wrote:

[...]

> -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
> +void pci_device_notify_iommu(PCIDevice *dev, PCIDevNotifyType type)
>  {
> -    bus->iommu_fn = fn;
> +    PCIBus *bus = PCI_BUS(pci_get_bus(dev));
> +    PCIBus *iommu_bus = bus;
> +
> +    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> +        iommu_bus = PCI_BUS(pci_get_bus(iommu_bus->parent_dev));
> +    }
> +    if (iommu_bus && iommu_bus->notify_fn) {
> +        iommu_bus->notify_fn(bus,
> +                             iommu_bus->iommu_opaque,
> +                             dev->devfn,
> +                             type);

We didn't really check the return code for notify function.  What if
it failed?  If we care, we'd better handle the failure; or we can just
define the notify_fn() to return void (now it's int).

> +    }
> +    return;

I saw many places in the series that you added explicit return for
"void" return-typed functions.  IMHO all of them can be dropped.

> +}

Thanks,

-- 
Peter Xu
