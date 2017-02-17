Received: from eggs.gnu.org ([2001:4830:134:3::10]:58587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceZBn-0004vk-5Y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceZBi-0004rS-8Y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:26:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceZBh-0004qh-VU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:26:26 -0500
Date: Fri, 17 Feb 2017 11:26:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170217032619.GL15985@pxdev.xzpeter.org>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>

On Thu, Feb 16, 2017 at 05:36:06AM +0000, Liu, Yi L wrote:
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=intel.com@nongnu.org]
> > On Behalf Of Michael S. Tsirkin
> > Sent: Tuesday, January 10, 2017 1:40 PM
> > To: qemu-devel@nongnu.org
> > Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
> > <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Peter Xu
> > <peterx@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> > Henderson <rth@twiddle.net>
> > Subject: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
> > descriptor
> > 
> > From: Jason Wang <jasowang@redhat.com>
> > 
> > This patch enables device IOTLB support for intel iommu. The major work is to
> > implement QI device IOTLB descriptor processing and notify the device through
> > iommu notifier.
> >
> Hi Jason/Michael,
> 	
> Recently Peter Xu's patch also touched intel-iommu emulation. His patch shadows
> second-level page table by capturing iotlb flush from guest. It would result in page
> table updating in host. Does this patch also use the same map/umap API provided
> by VFIO? If it is, then I think it would also update page table in host.

I haven't considered complex scenarios, but if simply we have a VM
with one vhost device and one vfio-pci device, imho that should not be
a problem - device iotlb is targeting SID rather than DOMAIN. So
device iotlb invalidations for vhost will be sent to vhost device
only.

However, vhost may receive two invalidations here, but it won't matter
much since vhost is just flushing caches twice.

> It looks to be
> a duplicate update. Pls refer to the following snapshot captured from section 6.5.2.5
> of vtd spec. 
> 
> "Since translation requests from a device may be serviced by hardware from the IOTLB, software must
> always request IOTLB invalidation (iotlb_inv_dsc) before requesting corresponding Device-TLB
> (dev_tlb_inv_dsc) invalidation."
> 
> Maybe for device-iotlb, we need a separate API which just pass down the invalidate
> info without updating page table. Any thoughts?

Now imho I slightly prefer just use the current UNMAP notifier type
even for device iotlb device. But, we may need to do one more check
that we skip sending general iotlb invalidations to ATS enabled
devices like vhost, to avoid duplicated cache flushing. From virt-svm
side, do we have specific requirement to introduce a new flag for it?

Thanks,

-- peterx
