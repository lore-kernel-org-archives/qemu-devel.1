Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9Ib2-00052K-SS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9Iay-0006q4-Re
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d9Iay-0006oR-J6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:32 -0400
Date: Fri, 12 May 2017 15:59:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170512155924.755ee17f@t450s.home>
In-Reply-To: <1493201525-14418-4-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Wed, 26 Apr 2017 18:12:00 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> When a SVM capable device is assigned to a guest, the first level page
> tables are owned by the guest and the guest PASID table pointer is
> linked to the device context entry of the physical IOMMU.
> 
> Host IOMMU driver has no knowledge of caching structure updates unless
> the guest invalidation activities are passed down to the host. The
> primary usage is derived from emulated IOMMU in the guest, where QEMU
> can trap invalidation activities before pass them down the
> host/physical IOMMU. There are IOMMU architectural specific actions
> need to be taken which requires the generic APIs introduced in this
> patch to have opaque data in the tlb_invalidate_info argument.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 13 +++++++++++++
>  include/linux/iommu.h | 16 ++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2da636..ca7cff2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1153,6 +1153,19 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
>  
> +int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(domain->ops->do_invalidate == NULL))
> +		return -ENODEV;
> +
> +	ret = domain->ops->do_invalidate(domain, dev, inv_info);
> +	return ret;

nit, ret is unnecessary.

> +}
> +EXPORT_SYMBOL_GPL(iommu_do_invalidate);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 491a011..a48e3b75 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -140,6 +140,11 @@ struct pasid_table_info {
>  	__u8	opaque[];/* IOMMU-specific details */
>  };
>  
> +struct tlb_invalidate_info {
> +	__u32	model;
> +	__u8	opaque[];
> +};

I'm wondering if 'model' is really necessary here, shouldn't this
function only be called if a bind_pasid_table() succeeded, and then the
model would be set at that time?

This also needs to be uapi since you're expecting a user to provide it
to vfio.  The opaque data needs to be fully specified (relative to
uapi) per model.

> +
>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> @@ -215,6 +220,8 @@ struct iommu_ops {
>  				struct pasid_table_info *pasidt_binfo);
>  	int (*unbind_pasid_table)(struct iommu_domain *domain,
>  				struct device *dev);
> +	int (*do_invalidate)(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -240,6 +247,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
>  		struct device *dev, struct pasid_table_info *pasidt_binfo);
>  extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
>  				struct device *dev);
> +extern int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info);
> +
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
> @@ -626,6 +636,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
>  	return -EINVAL;
>  }
>  
> +static inline int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
