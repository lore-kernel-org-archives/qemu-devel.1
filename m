Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9Ias-0004t0-Ri
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9Iao-0006XG-Rm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d9Iao-0006WH-Jb
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:22 -0400
Date: Fri, 12 May 2017 15:59:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170512155914.73bad777@t450s.home>
In-Reply-To: <1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/8] iommu: Introduce bind_pasid_table
 API function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>

On Wed, 26 Apr 2017 18:11:58 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM) use
> case in the guest:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> 
> As part of the proposed architecture, when a SVM capable PCI
> device is assigned to a guest, nested mode is turned on. Guest owns the
> first level page tables (request with PASID) and performs GVA->GPA
> translation. Second level page tables are owned by the host for GPA->HPA
> translation for both request with and without PASID.
> 
> A new IOMMU driver interface is therefore needed to perform tasks as
> follows:
> * Enable nested translation and appropriate translation type
> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> 
> This patch introduces new functions called iommu_(un)bind_pasid_table()
> to IOMMU APIs. Architecture specific IOMMU function can be added later
> to perform the specific steps for binding pasid table of assigned devices.
> 
> This patch also adds model definition in iommu.h. It would be used to
> check if the bind request is from a compatible entity. e.g. a bind
> request from an intel_iommu emulator may not be supported by an ARM SMMU
> driver.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbe7f65..f2da636 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1134,6 +1134,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>  
> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> +			struct pasid_table_info *pasidt_binfo)
> +{
> +	if (unlikely(!domain->ops->bind_pasid_table))
> +		return -EINVAL;
> +
> +	return domain->ops->bind_pasid_table(domain, dev, pasidt_binfo);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
> +
> +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	if (unlikely(!domain->ops->unbind_pasid_table))
> +		return -EINVAL;
> +
> +	return domain->ops->unbind_pasid_table(domain, dev);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0ff5111..491a011 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -131,6 +131,15 @@ struct iommu_dm_region {
>  	int			prot;
>  };
>  
> +struct pasid_table_info {
> +	__u64	ptr;	/* PASID table ptr */
> +	__u64	size;	/* PASID table size*/
> +	__u32	model;	/* magic number */
> +#define INTEL_IOMMU	(1 << 0)
> +#define ARM_SMMU	(1 << 1)
> +	__u8	opaque[];/* IOMMU-specific details */
> +};

This needs to be in uapi since you're expecting a user to pass it 

> +
>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> @@ -159,6 +168,8 @@ struct iommu_dm_region {
>   * @domain_get_windows: Return the number of windows for a domain
>   * @of_xlate: add OF master IDs to iommu grouping
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> + * @bind_pasid_table: bind pasid table pointer for guest SVM
> + * @unbind_pasid_table: unbind pasid table pointer and restore defaults
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -200,6 +211,10 @@ struct iommu_ops {
>  	u32 (*domain_get_windows)(struct iommu_domain *domain);
>  
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> +	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
> +				struct pasid_table_info *pasidt_binfo);
> +	int (*unbind_pasid_table)(struct iommu_domain *domain,
> +				struct device *dev);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -221,6 +236,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
>  extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
> +extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> +		struct device *dev, struct pasid_table_info *pasidt_binfo);
> +extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
> +				struct device *dev);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
> @@ -595,6 +614,18 @@ const struct iommu_ops *iommu_get_instance(struct fwnode_handle *fwnode)
>  	return NULL;
>  }
>  
> +static inline
> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> +			struct pasid_table_info *pasidt_binfo)
> +{
> +	return -EINVAL;
> +}
> +static inline
> +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
