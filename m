Received: from eggs.gnu.org ([2001:4830:134:3::10]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxgd-0005q8-Ne
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxgc-0004Ki-JB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:04:55 -0400
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
	<1494697399-352-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8SHP+=+hXB2D3XsCdeFg5NMSqTxtjH9aEU0bE5bL-2Dw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <aa138868-9f59-2023-926b-e2c4bc9219c6@redhat.com>
Date: Wed, 31 May 2017 09:04:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8SHP+=+hXB2D3XsCdeFg5NMSqTxtjH9aEU0bE5bL-2Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 1/5] hw/arm/smmu-common: smmu base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

Hi Peter,

On 30/05/2017 17:56, Peter Maydell wrote:
> On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
>> Introduces the base device and class for the ARM smmu.
>> Implements VMSAv8-64 table lookup and translation. VMSAv8-32
>> is not yet implemented.
>>
>> For VFIO integration we will need to notify mapping changes
>> of an input range and skipped unmapped regions. table walk
>> helper allows.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>>
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
>> + * @must_translate: indicates whether each iova of the range
>> + *  must be translated or whether failure is allowed
>> + * @notify_unmap: whether we should notify invalid entries
>> + *
>> + * Return 0 on success, < 0 on errors not related to translation
>> + * process, > 1 on errors related to translation process (only
>> + * if must_translate is set)
>> + */
>> +static int
>> +smmu_page_walk_level_64(dma_addr_t baseaddr, int level,
>> +                        SMMUTransCfg *cfg, uint64_t start, uint64_t end,
>> +                        smmu_page_walk_hook hook_fn, void *private,
>> +                        bool read, bool write, bool must_translate,
>> +                        bool notify_unmap)
>> +{
> 
>> +        /* table pte */
>> +        next_table_baseaddr = get_table_pte_address(pte, granule_sz);
>> +        trace_smmu_page_walk_level_table_pte(pte, next_table_baseaddr);
>> +        ret = smmu_page_walk_level_64(next_table_baseaddr, level + 1, cfg,
>> +                                      iova, MIN(iova_next, end),
>> +                                      hook_fn, private, read_cur, write_cur,
>> +                                      must_translate, notify_unmap);
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
> It seems a bit odd that this function is recursive -- I was
> expecting it just to loop through for each successive level
> until it hits a block/page entry, as the LPAE table walk
> code in target/arm/helper.c does...

welcome back ;-)

Thanks for the pointer to get_phys_addr_lpae(). Actually I got largely
inspired of vtd_page_walk and vtd_page_walk_level of
hw/i386/intel_iommu.c which also use the same recursive form.

The peculiarity compared to get_phys_addr_lpae() is that we scan a range
of iovas and do not translate a single iova. In case a level entry is
not implemented we want to jump to the next one at the same level and in
case the entry matches a table entry we want to scan the next level
entries matching that iova range.

Does that make more sense?

Thanks

Eric
> 
> thanks
> -- PMM
> 
