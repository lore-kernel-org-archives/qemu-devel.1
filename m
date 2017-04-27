Received: from eggs.gnu.org ([2001:4830:134:3::10]:54337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3ZYX-0006JT-69
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3ZYU-0007zi-4M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:53:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3ZYT-0007zD-Qg
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:53:18 -0400
Date: Thu, 27 Apr 2017 10:37:19 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170427023719.GA14925@sky-dev>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
	<0f2966cf-4e5a-a2cc-5eb3-7e7d4f62bb85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f2966cf-4e5a-a2cc-5eb3-7e7d4f62bb85@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 12/20] Memory: Add func to fire
 pasidt_bind notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe.brucker@arm.com, jasowang@redhat.com, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com

On Wed, Apr 26, 2017 at 03:50:16PM +0200, Paolo Bonzini wrote:
> 
> 
> On 26/04/2017 12:06, Liu, Yi L wrote:
> > +void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
> > +                                         void *data)
> > +{
> > +    IOMMUNotifier *iommu_notifier;
> > +    IOMMUNotifierFlag request_flags;
> > +
> > +    assert(memory_region_is_iommu(mr));
> > +
> > +    /*TODO: support other bind requests with smaller gran,
> > +     * e.g. bind signle pasid entry
> > +     */
> > +    request_flags = IOMMU_NOTIFIER_SVM_PASIDT_BIND;
> > +
> > +    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> > +        if (iommu_notifier->notifier_flags & request_flags) {
> > +            iommu_notifier->notify(iommu_notifier, data);
> > +            break;
> > +        }
> > +    }
> 
> Peter,
> 
> should this reuse ->notify, or should it be different function pointer
> in IOMMUNotifier?

Hi Paolo,

Thx for your review.

I think it should be “->notify” here. In this patchset, the new notifier
is registered with the existing notifier registration API. So the all the
notifiers are in the mr->iommu_notify list. And notifiers are labeled
by notify flag, so it is able to differentiate the IOMMUNotifier nodes.
When the flag meets, trigger it by “->notify”. The diagram below shows
my understanding , wish it helps to make me understood.

VFIOContainer
       |
       giommu_list(VFIOGuestIOMMU)
                \
                 VFIOGuestIOMMU1 ->   VFIOGuestIOMMU2 -> VFIOGuestIOMMU3 ...
                    |                     |                 |
mr->iommu_notify: IOMMUNotifier   ->    IOMMUNotifier  ->  IOMMUNotifier
                  (Flag:MAP/UNMAP)     (Flag:SVM bind)  (Flag:tlb invalidate)


Actually, compared with the MAP/UNMAP notifier, the newly added notifier has
no start/end check, and there may be other types of bind notfier flag in
future, so I added a separate fire func for SVM bind notifier.

Thanks,
Yi L

> Paolo
> 
