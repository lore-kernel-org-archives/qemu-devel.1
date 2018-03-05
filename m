Received: from eggs.gnu.org ([2001:4830:134:3::10]:41282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esm28-00006f-F7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esm22-0004MP-RT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:03:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:19630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1esm22-0004MC-He
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:03:42 -0500
Date: Mon, 5 Mar 2018 16:46:52 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305084652.GG2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<20180305082743.GC7584@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305082743.GC7584@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Mon, Mar 05, 2018 at 04:27:43PM +0800, Peter Xu wrote:
> On Thu, Mar 01, 2018 at 06:33:31PM +0800, Liu, Yi L wrote:
> 
> [...]
> 
> > -void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
> > +void pci_device_notify_iommu(PCIDevice *dev, PCIDevNotifyType type)
> >  {
> > -    bus->iommu_fn = fn;
> > +    PCIBus *bus = PCI_BUS(pci_get_bus(dev));
> > +    PCIBus *iommu_bus = bus;
> > +
> > +    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> > +        iommu_bus = PCI_BUS(pci_get_bus(iommu_bus->parent_dev));
> > +    }
> > +    if (iommu_bus && iommu_bus->notify_fn) {
> > +        iommu_bus->notify_fn(bus,
> > +                             iommu_bus->iommu_opaque,
> > +                             dev->devfn,
> > +                             type);
> 
> We didn't really check the return code for notify function.  What if
> it failed?  If we care, we'd better handle the failure; or we can just
> define the notify_fn() to return void (now it's int).

Good catch. I think we need to handle failure. User should be aware of
it. I'll try to add accordingly in next version.
 
> > +    }
> > +    return;
> 
> I saw many places in the series that you added explicit return for
> "void" return-typed functions.  IMHO all of them can be dropped.

Thanks for spotting it, would fix them in next version.

Regards,
Yi Liu
