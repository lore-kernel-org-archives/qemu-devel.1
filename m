Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dBIo0-0002aR-Ui
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dBInx-0005ec-RU
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:37:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:14597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1dBInx-0005e3-Go
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:37:13 -0400
Date: Wed, 17 May 2017 18:23:07 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170517102307.GD22110@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-4-git-send-email-yi.l.liu@intel.com>
	<20170512155924.755ee17f@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512155924.755ee17f@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH 3/8] iommu: Introduce iommu do
 invalidate API function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Fri, May 12, 2017 at 03:59:24PM -0600, Alex Williamson wrote:
> On Wed, 26 Apr 2017 18:12:00 +0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 

Hi Alex,

Pls refer to the open I mentioned in this email, I need your comments
on it to prepare the formal patchset for SVM virtualization. Thx.

> > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > 
> > When a SVM capable device is assigned to a guest, the first level page
> > tables are owned by the guest and the guest PASID table pointer is
> > linked to the device context entry of the physical IOMMU.
> > 
> > Host IOMMU driver has no knowledge of caching structure updates unless
> > the guest invalidation activities are passed down to the host. The
> > primary usage is derived from emulated IOMMU in the guest, where QEMU
> > can trap invalidation activities before pass them down the
> > host/physical IOMMU. There are IOMMU architectural specific actions
> > need to be taken which requires the generic APIs introduced in this
> > patch to have opaque data in the tlb_invalidate_info argument.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 13 +++++++++++++
> >  include/linux/iommu.h | 16 ++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index f2da636..ca7cff2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1153,6 +1153,19 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> >  
> > +int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info)
> > +{
> > +	int ret = 0;
> > +
> > +	if (unlikely(domain->ops->do_invalidate == NULL))
> > +		return -ENODEV;
> > +
> > +	ret = domain->ops->do_invalidate(domain, dev, inv_info);
> > +	return ret;
> 
> nit, ret is unnecessary.

yes, would modify it. Thx.
 
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_do_invalidate);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 491a011..a48e3b75 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -140,6 +140,11 @@ struct pasid_table_info {
> >  	__u8	opaque[];/* IOMMU-specific details */
> >  };
> >  
> > +struct tlb_invalidate_info {
> > +	__u32	model;
> > +	__u8	opaque[];
> > +};
> 
> I'm wondering if 'model' is really necessary here, shouldn't this
> function only be called if a bind_pasid_table() succeeded, and then the
> model would be set at that time?

For this model, I'm thinking about another potential usage which
is from Tianyu's idea to use tlb_invalidate_info to pass invalidations
for iova related mappings. In such case, there would be no bind_pasid_table()
before it, so a model check would be needed. But I may remove it since this
patchset is focusing on SVM.

Here, I have an open to check with you. I defined the tlb_invalidate_info
with full opaque data. The opaque would include the invalidate info for
different vendors. But we have two choices for the tlb_invalidate_info
definition.

a) as proposed in this patchset, passing raw data to host. Host pIOMMU
   driver submits invalidation request after replacing specific fields.
   Reject if the IOMMU model is not correct.
   * Pros: no need to do parse and re-assembling, better performance
   * Cons: unable to support the scenarios which emulates an Intel IOMMU
           on an ARM platform.
b) parse the invalidation info into specific data, e.g. gran, addr,
   size, invalidation type etc. then fill the data in a generic
   structure. In host, pIOMMU driver re-assemble the invalidation
   request and submit to pIOMMU.
   * Pros: may be able to support the scenario above. But it is still in
           question since different vendor may have vendor specific
           invalidation info. This would make it difficult to have vendor
           agnostic invalidation propagation API.

   * Cons: needs additional complexity to do parse and re-assembling.
           The generic structure would be a hyper-set of all possible
           invalidate info, this may be hard to maintain in future.

As the pros/cons show, I proposed a) as an initial version. But it is an
open. Jean from ARM has gave some comments on it and inclined to the opaque
way with generic part defined explicitly. Jean's reply is in the link below.

http://www.spinics.net/lists/kvm/msg149884.html

I'd like to see your comments on it before moving forward. I'm fine with
Jean's idea. For VT-d, I may define it as "generic part" + "raw data".

Thanks,
Yi L

> This also needs to be uapi since you're expecting a user to provide it
> to vfio.  The opaque data needs to be fully specified (relative to
> uapi) per model.
> 

would do it as you pointed.
 
> > +
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > @@ -215,6 +220,8 @@ struct iommu_ops {
> >  				struct pasid_table_info *pasidt_binfo);
> >  	int (*unbind_pasid_table)(struct iommu_domain *domain,
> >  				struct device *dev);
> > +	int (*do_invalidate)(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info);
> >  
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -240,6 +247,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> >  		struct device *dev, struct pasid_table_info *pasidt_binfo);
> >  extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
> >  				struct device *dev);
> > +extern int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info);
> > +
> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		     phys_addr_t paddr, size_t size, int prot);
> > @@ -626,6 +636,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> >  	return -EINVAL;
> >  }
> >  
> > +static inline int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  #endif /* __LINUX_IOMMU_H */
> 
