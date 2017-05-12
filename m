Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IbE-0005Ct-G1
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d9IbB-00073G-Oe
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d9IbB-00072Q-Ef
	for qemu-devel@nongnu.org; Fri, 12 May 2017 17:59:45 -0400
Date: Fri, 12 May 2017 15:59:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170512155918.5251fb94@t450s.home>
In-Reply-To: <1493201525-14418-5-git-send-email-yi.l.liu@intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-5-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/8] iommu/vt-d: Add iommu do
 invalidate function
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

On Wed, 26 Apr 2017 18:12:01 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> This patch adds Intel VT-d specific function to implement
> iommu_do_invalidate API.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h | 11 +++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6d5b939..0b098ad 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5042,6 +5042,48 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
>  	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
>  }
>  
> +static int intel_iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +	struct intel_iommu *iommu;
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_invalidate_data *inv_data;
> +	struct qi_desc *qi;
> +	u16 did;
> +	u8 bus, devfn;
> +
> +	if (!inv_info || !dmar_domain || (inv_info->model != INTEL_IOMMU))
> +		return -EINVAL;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	inv_data = (struct intel_invalidate_data *)&inv_info->opaque;
> +
> +	/* check SID */
> +	if (PCI_DEVID(bus, devfn) != inv_data->sid)
> +		return 0;
> +
> +	qi = &inv_data->inv_desc;
> +
> +	switch (qi->low & QI_TYPE_MASK) {
> +	case QI_DIOTLB_TYPE:
> +	case QI_DEIOTLB_TYPE:
> +		/* for device IOTLB, we just let it pass through */
> +		break;
> +	default:
> +		did = dmar_domain->iommu_did[iommu->seq_id];
> +		set_mask_bits(&qi->low, QI_DID_MASK, QI_DID(did));
> +		break;
> +	}
> +
> +	ret = qi_submit_sync(qi, iommu);
> +
> +	return ret;

nit, ret variable is unnecessary.

> +}
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  			   unsigned long iova, phys_addr_t hpa,
>  			   size_t size, int iommu_prot)
> @@ -5416,6 +5458,7 @@ static int intel_iommu_unbind_pasid_table(struct iommu_domain *domain,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	.bind_pasid_table	= intel_iommu_bind_pasid_table,
>  	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
> +	.do_invalidate		= intel_iommu_do_invalidate,
>  #endif
>  	.map		= intel_iommu_map,
>  	.unmap		= intel_iommu_unmap,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ac04f28..9d6562c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -29,6 +29,7 @@
>  #include <linux/dma_remapping.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/list.h>
> +#include <linux/bitops.h>
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
>  
> @@ -271,6 +272,10 @@ enum {
>  #define QI_PGRP_RESP_TYPE	0x9
>  #define QI_PSTRM_RESP_TYPE	0xa
>  
> +#define QI_DID(did)		(((u64)did & 0xffff) << 16)
> +#define QI_DID_MASK		GENMASK(31, 16)
> +#define QI_TYPE_MASK		GENMASK(3, 0)
> +
>  #define QI_IEC_SELECTIVE	(((u64)1) << 4)
>  #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
>  #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
> @@ -529,6 +534,12 @@ struct intel_svm {
>  extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
>  #endif
>  
> +struct intel_invalidate_data {
> +	u16 sid;
> +	u32 pasid;
> +	struct qi_desc inv_desc;
> +};

This needs to be uapi since the vfio user is expected to create it, so
we need a uapi version of qi_desc too.

> +
>  extern const struct attribute_group *intel_iommu_groups[];
>  extern void intel_iommu_debugfs_init(void);
>  extern struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
