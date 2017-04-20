Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d14pW-0001cw-43
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d14pS-0003Rr-69
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d14pR-0003Rj-TI
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:40:30 -0400
Date: Thu, 20 Apr 2017 13:40:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420054018.GD26087@pxdev.xzpeter.org>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
	<20170418072717.GD22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439054360@shsmsx102.ccr.corp.intel.com>
	<672ae592-e6ba-9152-b775-ec2bde931ef1@intel.com>
	<20170420030427.GA26087@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390555FB@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390555FB@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>

On Thu, Apr 20, 2017 at 04:55:24AM +0000, Liu, Yi L wrote:

[...]

> > > In my previous RFC patchset of fault event reporting, I registered
> > > fault notifier when there is a VFIO group attached to VFIO container
> > > and used the address space to check whether vIOMMU is added. The
> > > address space is returned by vtd_host_dma_iommu(). vtd_find_add_as()
> > > initializes device's IOMMU memory region and put it into device's
> > > address space as root memory region.
> > > Does this make sense?
> > >
> > > @@ -1103,6 +1132,14 @@ static int vfio_connect_container(VFIOGroup
> > > *group, AddressSpace *as,
> > >          goto listener_release_exit;
> > >      }
> > >
> > > +    if (memory_region_is_iommu(container->space->as->root)) {
> > 
> > I would suggest we don't play with as->root any more. After vtd vfio series, this may
> > not be true if passthrough mode is enabled (then the root may be switched to an
> > system memory alias). I don't know the best way to check this, one alternative might
> > be that we check whether
> > container->space->as == system_memory(), it should be workable, but in

Sorry, I was meaning &address_space_memory.

> > a slightly hackish way.
> 
> In my understanding, container->space->as->root cannot work here no matter passthru-mode
> is enabled or not. The code here is aiming to check if vIOMMU exists. After the vfio series,
> the vtd_dev_as->root is not initialized to be a iommu MemoryRegion. Compared with checking
> if it is system_memory(), I think adding a mechanism to get the iommu MemoryRegion may
> be a better choice. Just like the current pci_device_iommu_address_space().

Isn't pci_device_iommu_address_space() used to get that IOMMU memory
region? And, one thing to mention is that container->space->as is
actually derived from pci_device_iommu_address_space() (when calling
vfio_get_group()).

I feel like that playing around with an IOMMU memory region is still
not clear enough in many cases. I still feel like some day we would
like an "IOMMU object". Then, we can register non-iotlb notifiers
against that IOMMU object, rather than memory regions...

Thanks,

-- 
Peter Xu
