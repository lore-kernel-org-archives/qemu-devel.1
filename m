Received: from eggs.gnu.org ([2001:4830:134:3::10]:54286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctZh9-0005TX-1x
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctZh3-00079K-Lj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:00:55 -0400
References: <20170330124707.28142-1-aik@ozlabs.ru>
	<20170330124707.28142-3-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82c140ad-da36-5c2a-3f10-567d3108b15a@redhat.com>
Date: Thu, 30 Mar 2017 15:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170330124707.28142-3-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/5] spapr-iommu: Subclass
 TYPE_IOMMU_MEMORY_REGION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>



On 30/03/2017 14:47, Alexey Kardashevskiy wrote:
> +static int spapr_tce_get_fd(IOMMUMemoryRegion *iommu)
> +{
> +    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
> +
> +    return tcet->fd;
> +}
> +
>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
> @@ -266,7 +273,7 @@ static int spapr_tce_table_realize(DeviceState *dev)
>      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
>  
>      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> -    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
> +    memory_region_init_iommu_type(TYPE_SPAPR_IOMMU_MEMORY_REGION,
>                                    &tcet->iommu, tcetobj, &spapr_iommu_ops,
>                                    tmp, 0);
>  
> @@ -634,9 +641,25 @@ static TypeInfo spapr_tce_table_info = {
>      .class_init = spapr_tce_table_class_init,
>  };
>  
> +static void spapr_iommu_memory_region_class_init(ObjectClass *k, void *data)
> +{
> +    sPAPRIOMMUMemoryRegionClass *smrc = SPAPR_IOMMU_MEMORY_REGION_CLASS(k);
> +
> +    smrc->get_fd = spapr_tce_get_fd;
> +}
> +

You don't even need the virtual function.  Rather, make spapr_tce_get_fd
public and give it a sPAPRTCETable argument.  Then vfio_spapr_notify_kvm
can use SPAPR_IOMMU_MEMORY_REGION(iommumr).

Paolo
