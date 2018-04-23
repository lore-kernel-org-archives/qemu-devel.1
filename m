Received: from eggs.gnu.org ([2001:4830:134:3::10]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fAaJD-0000bk-L9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fAaJ8-0002i0-NG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:11:03 -0400
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA84iZV8vUK4DxPpuO6LwUqE=LEoW63qy=FTiF6KHvYhEw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <677f3faa-24bd-0679-47ae-2dc9bd1c9bda@redhat.com>
Date: Mon, 23 Apr 2018 14:10:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84iZV8vUK4DxPpuO6LwUqE=LEoW63qy=FTiF6KHvYhEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 03/17] hw/arm/smmu-common: VMSAv8-64
 page table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

Hi Peter,

On 04/16/2018 02:59 PM, Peter Maydell wrote:
> On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
>> This patch implements the page table walk for VMSAv8-64.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> 
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 9a966bb..6a58948 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -27,6 +27,215 @@
>>
>>  #include "qemu/error-report.h"
>>  #include "hw/arm/smmu-common.h"
>> +#include "smmu-internal.h"
>> +
>> +/* VMSAv8-64 Translation */
>> +
>> +/**
>> + * get_pte - Get the content of a page table entry located t
>> + * @base_addr[@index]
>> + */
> 
> Comment appears to be truncated ?
> 
>> +static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
>> +                   SMMUPTWEventInfo *info)
>> +{
>> +    int ret;
>> +    dma_addr_t addr = baseaddr + index * sizeof(*pte);
>> +
>> +    /* TODO: guarantee 64-bit single-copy atomicity */
>> +    ret = dma_memory_read(&address_space_memory, addr,
>> +                          (uint8_t *)pte, sizeof(*pte));
>> +
>> +    if (ret != MEMTX_OK) {
>> +        info->type = SMMU_PTW_ERR_WALK_EABT;
>> +        info->addr = addr;
>> +        return -EINVAL;
>> +    }
>> +    trace_smmu_get_pte(baseaddr, index, addr, *pte);
>> +    return 0;
>> +}
>> +
> 
>> +/**
>> + * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>> + *
>> + * @cfg: translation configuration
>> + * @iova: iova to translate
>> + * @perm: tentative access type
>> + * @tlbe: returned entry
>> + * @info: ptw event handle
>> + *
>> + * return 0 on success
>> + */
>> +inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>> +             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>> +{
>> +    if (!cfg->aa64) {
>> +        /*
>> +         * This code path is not entered as we check this while decoding
>> +         * the configuration data in the derived SMMU model.
>> +         */
>> +        assert(0);
> 
> Prefer either g_assert_not_reached() or just assert(cfg->aa64).
> 
>> +    }
>> +
>> +    return smmu_ptw_64(cfg, iova, perm, tlbe, info);
>> +}
>>
> 
>> +
>> +/*
>> + * TODO: At the moment all transactions are considered as priviledged (EL1)
> 
> "privileged"
> 
>> + * as IOMMU translation callback does not pass user/priv attributes.
>> + */
>> +#define is_permission_fault(ap, perm) \
>> +    (((perm) & IOMMU_WO) && ((ap) & 0x2))
>> +
>> +#define PTE_AP_TO_PERM(ap) \
>> +    (IOMMU_ACCESS_FLAG(true, !((ap) & 0x2)))
>> +
>> +/* Level Indexing */
>> +
>> +static inline int level_shift(int level, int granule_sz)
>> +{
>> +    return granule_sz + (3 - level) * (granule_sz - 3);
>> +}
>> +
>> +static inline uint64_t level_page_mask(int level, int granule_sz)
>> +{
>> +    return ~(MAKE_64BIT_MASK(0, level_shift(level, granule_sz)));
>> +}
>> +
>> +/**
>> + * TODO: handle the case where the level resolves less than
>> + * granule_sz -3 IA bits.
>> + */
>> +static inline
>> +uint64_t iova_level_offset(uint64_t iova, int level, int granule_sz)
>> +{
>> +    return (iova >> level_shift(level, granule_sz)) &
>> +            MAKE_64BIT_MASK(0, granule_sz - 3);
>> +}
>> +
>> +#endif
> 
> When does the TODO case happen, and what goes wrong?
Sorry for the delay [back to the office].

This refers to
D4.2 of ARM ARM , Effect of granule size on translation table addressing
and indexing/ Reduced IA width.

"
Depending on the configuration and implementation choices, the required
input address width for the initial level of lookup might be smaller
than the number of address bits that can be resolved at that level"

For instance with 4k granule and IA limited to 35 bit, we use a 9-bit
mask here and initial level 1 offset is based on IA[30, 38] although IA
is limited to 35.

Thanks

Eric
> 
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -129,4 +129,18 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>>  {
>>      return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
>>  }
>> +
>> +/**
>> + * smmu_ptw - Perform the page table walk for a given iova / access flags
>> + * pair, according to @cfg translation config
>> + */
>> +int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>> +             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
>> +
>> +/**
>> + * select_tt - compute which translation table shall be used according
> 
> "according to"
> 
>> + * the input iova and tranlsation config and return the TT specific info
> 
> "translation"
> 
>> + */
>> +SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
>> +
>>  #endif  /* HW_ARM_SMMU_COMMON */
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 
