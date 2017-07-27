Received: from eggs.gnu.org ([2001:4830:134:3::10]:50986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapPC-0004WE-VB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapPB-00070f-Lu
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:29:10 -0400
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
	<1499633493-19865-2-git-send-email-eric.auger@redhat.com>
	<66fca1dd-b731-c97f-b21b-af4ea75dcb47@semihalf.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b14389ac-c2c4-2185-8205-50a045e4e3ea@redhat.com>
Date: Thu, 27 Jul 2017 22:28:45 +0200
MIME-Version: 1.0
In-Reply-To: <66fca1dd-b731-c97f-b21b-af4ea75dcb47@semihalf.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 1/8] hw/arm/smmu-common: smmu base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomasz Nowicki <tn@semihalf.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

Hi Tomasz,

On 25/07/2017 14:12, Tomasz Nowicki wrote:
> Hi Eric,
> 
> I found out what is going on regarding vhost-net outgoing packet's
> payload corruption. My packets were corrupted because of inconsistent
> IOVA to HVA translation in IOTLB. Please see below.
> 
> On 09.07.2017 22:51, Eric Auger wrote:
>> Introduces the base device and class for the ARM smmu.
>> Implements VMSAv8-64 table lookup and translation. VMSAv8-32
>> is not implemented.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>>
>> ---
> 
> [...]
> 
>> +
>> +/**
>> + * smmu_page_walk_level_64 - Walk an IOVA range from a specific level
>> + * @baseaddr: table base address corresponding to @level
>> + * @level: level
>> + * @cfg: translation config
>> + * @start: end of the IOVA range
>> + * @end: end of the IOVA range
>> + * @hook_fn: the hook that to be called for each detected area
>> + * @private: private data for the hook function
>> + * @read: whether parent level has read permission
>> + * @write: whether parent level has write permission
>> + * @nofail: indicates whether each iova of the range
>> + *  must be translated or whether failure is allowed
>> + * @notify_unmap: whether we should notify invalid entries
>> + *
>> + * Return 0 on success, < 0 on errors not related to translation
>> + * process, > 1 on errors related to translation process (only
>> + * if nofail is set)
>> + */
>> +static int
>> +smmu_page_walk_level_64(dma_addr_t baseaddr, int level,
>> +                        SMMUTransCfg *cfg, uint64_t start, uint64_t end,
>> +                        smmu_page_walk_hook hook_fn, void *private,
>> +                        bool read, bool write, bool nofail,
>> +                        bool notify_unmap)
>> +{
>> +    uint64_t subpage_size, subpage_mask, pte, iova = start;
>> +    bool read_cur, write_cur, entry_valid;
>> +    int ret, granule_sz, stage;
>> +    IOMMUTLBEntry entry;
>> +
>> +    granule_sz = cfg->granule_sz;
>> +    stage = cfg->stage;
>> +    subpage_size = 1ULL << level_shift(level, granule_sz);
>> +    subpage_mask = level_page_mask(level, granule_sz);
>> +
>> +    trace_smmu_page_walk_level_in(level, baseaddr, granule_sz,
>> +                                  start, end, subpage_size);
>> +
>> +    while (iova < end) {
>> +        dma_addr_t next_table_baseaddr;
>> +        uint64_t iova_next, pte_addr;
>> +        uint32_t offset;
>> +
>> +        iova_next = (iova & subpage_mask) + subpage_size;
>> +        offset = iova_level_offset(iova, level, granule_sz);
>> +        pte_addr = baseaddr + offset * sizeof(pte);
>> +        pte = get_pte(baseaddr, offset);
>> +
>> +        trace_smmu_page_walk_level(level, iova, subpage_size,
>> +                                   baseaddr, offset, pte);
>> +
>> +        if (pte == (uint64_t)-1) {
>> +            if (nofail) {
>> +                return SMMU_TRANS_ERR_WALK_EXT_ABRT;
>> +            }
>> +            goto next;
>> +        }
>> +        if (is_invalid_pte(pte) || is_reserved_pte(pte, level)) {
>> +            trace_smmu_page_walk_level_res_invalid_pte(stage, level,
>> baseaddr,
>> +                                                       pte_addr,
>> offset, pte);
>> +            if (nofail) {
>> +                return SMMU_TRANS_ERR_WALK_EXT_ABRT;
>> +            }
>> +            goto next;
>> +        }
> 
> 
> vhost maintains its IOTLB cache and when there is no IOVA->HVA
> translation, it asks QEMU for help. However, IOTLB entries invalidations
> are guest initiative so for any DMA unmap at guest side we trap to SMMU
> emulation code and call:
> smmu_notify_all -> smmuv3_replay_single -> smmu_page_walk_64 ->
> smmu_page_walk_level_64 -> smmuv3_replay_hook -> vhost_iommu_unmap_notify
> 
> The thing is that smmuv3_replay_hook() is never called because guest
> zeros PTE before we trap to QEMU so that smmu_page_walk_level_64() fails
> on ^^^ is_invalid_pte(pte) check. This way we keep old IOTLB entry in
> vhost and subsequent translations may be broken.

Thank you for the time you spent on this. I will work on this vhost use
case asap and will let you know.

Thanks

Eric
> 
>> +
>> +        read_cur = read; /* TODO */
>> +        write_cur = write; /* TODO */
>> +        entry_valid = read_cur | write_cur; /* TODO */
>> +
>> +        if (is_page_pte(pte, level)) {
>> +            uint64_t gpa = get_page_pte_address(pte, granule_sz);
>> +            int perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
>> +
>> +            trace_smmu_page_walk_level_page_pte(stage, level,
>> entry.iova,
>> +                                                baseaddr, pte_addr,
>> pte, gpa);
>> +            if (!entry_valid && !notify_unmap) {
>> +                printf("%s entry_valid=%d notify_unmap=%d\n", __func__,
>> +                       entry_valid, notify_unmap);
>> +                goto next;
>> +            }
>> +            ret = call_entry_hook(iova, subpage_mask, gpa, perm,
>> +                                  hook_fn, private);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +            goto next;
>> +        }
>> +        if (is_block_pte(pte, level)) {
>> +            uint64_t block_size;
>> +            hwaddr gpa = get_block_pte_address(pte, level, granule_sz,
>> +                                               &block_size);
>> +            int perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
>> +
>> +            if (gpa == -1) {
>> +                if (nofail) {
>> +                    return SMMU_TRANS_ERR_WALK_EXT_ABRT;
>> +                } else {
>> +                    goto next;
>> +                }
>> +            }
>> +            trace_smmu_page_walk_level_block_pte(stage, level, baseaddr,
>> +                                                 pte_addr, pte, iova,
>> gpa,
>> +                                                 (int)(block_size >>
>> 20));
>> +
>> +            ret = call_entry_hook(iova, subpage_mask, gpa, perm,
>> +                                  hook_fn, private);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +            goto next;
>> +        }
>> +        if (level  == 3) {
>> +            goto next;
>> +        }
>> +        /* table pte */
>> +        next_table_baseaddr = get_table_pte_address(pte, granule_sz);
>> +        trace_smmu_page_walk_level_table_pte(stage, level, baseaddr,
>> pte_addr,
>> +                                             pte, next_table_baseaddr);
>> +        ret = smmu_page_walk_level_64(next_table_baseaddr, level + 1,
>> cfg,
>> +                                      iova, MIN(iova_next, end),
>> +                                      hook_fn, private, read_cur,
>> write_cur,
>> +                                      nofail, notify_unmap);
>> +        if (!ret) {
>> +            return ret;
>> +        }
>> +
>> +next:
>> +        iova = iova_next;
>> +    }
>> +
>> +    return SMMU_TRANS_ERR_NONE;
>> +}
> 
> Thanks,
> Tomasz
