Received: from eggs.gnu.org ([2001:4830:134:3::10]:40442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL819-0000sb-D6
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL818-0001Sz-Ag
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:11:59 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<47281818-f0cf-0ed1-c479-fbcaca5c5167@redhat.com>
	<CAFEAcA-R9t4K488viYM9ipmfArA=ijMMJn+FD1wekPdAbNOHvQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <595dcb89-3856-3755-e8db-7791c1374284@redhat.com>
Date: Tue, 22 May 2018 16:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R9t4K488viYM9ipmfArA=ijMMJn+FD1wekPdAbNOHvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 05/22/2018 03:22 PM, Peter Maydell wrote:
> On 22 May 2018 at 13:58, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>> On 05/21/2018 04:03 PM, Peter Maydell wrote:
>>> If an IOMMU supports mappings that care about the memory
>>> transaction attributes, then it no longer has a unique
>>> address -> output mapping, but more than one. We can
>>> represent these using an IOMMU index, analogous to TCG's
>>> mmu indexes.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  include/exec/memory.h | 52 +++++++++++++++++++++++++++++++++++++++++++
>>>  memory.c              | 23 +++++++++++++++++++
>>>  2 files changed, 75 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 309fdfb89b..f6226fb263 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -206,6 +206,20 @@ enum IOMMUMemoryRegionAttr {
>>>   * to report whenever mappings are changed, by calling
>>>   * memory_region_notify_iommu() (or, if necessary, by calling
>>>   * memory_region_notify_one() for each registered notifier).
>>> + *
>>> + * Conceptually an IOMMU provides a mapping from input address
>>> + * to an output TLB entry.
>> actually it takes a source identifier too (ARM streamid + substreamID,
>> this latter is not yet supported).
>> At the moment we have 1 IOMMUMRRegion per sid on ARM. For each
>> IOMMUMRRegion we would now have 2 indexes (1 for secure and 1 for
>> unsecure). How do you see the implementation of PASIDs (substreamids).
>> Would that be based on indexes or not?
> 
> Good question. I guess we would set that up so that the
> substream ID is in the memory transaction attributes as the
> requester_id and then use that as part of the IOMMU index ?
> Or you could use the indirection between tx attrs and indexes
> to allow you to map down a potentially large space of substream
> ID values to a smaller set of actually different configurations.
> 
> How many substream IDs do we expect to see in practice?

Spec says max 20 bits, matching the max size of the PASID

Thanks

Eric

> 
>>> +/**
>>> + * memory_region_iommu_attrs_to_index: return the IOMMU index to
>>> + * use for translations with the given memory transaction attributes.
>>> + *
>>> + * @iommu_mr: the memory region
>>> + * @attrs: the memory transaction attributes
>>> + */
>>> +int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
>>> +                                       MemTxAttrs attrs);
>>> +
>>> +/**
>>> + * memory_region_iommu_num_indexes: return the total number of IOMMU
>>> + * indexes that this IOMMU supports.
>> is it IOMMU wide characteristics or per IOMMUMRRegion (SID)?
> 
> I generally in this API document have been treating "IOMMU" and
> "IOMMURegion" as synonymous, since from the perspective of the API
> we don't care whether there's a bigger underlying thing in common
> between IOMMURegions.
> 
> thanks
> -- PMM
> 
