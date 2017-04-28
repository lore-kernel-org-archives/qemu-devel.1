Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1d3z5X-0001nE-G2
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1d3z5T-0007JI-GA
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1d3z5T-0007HC-52
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:09:03 -0400
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-3-git-send-email-yi.l.liu@linux.intel.com>
	<20170427103221.GD1542@pxdev.xzpeter.org>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <a7cd779f-2cd6-3a3f-7e73-e79a49c48961@intel.com>
Date: Fri, 28 Apr 2017 14:00:15 +0800
MIME-Version: 1.0
In-Reply-To: <20170427103221.GD1542@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/20] intel_iommu: exposed
 extended-context mode to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com

On 2017年04月27日 18:32, Peter Xu wrote:
> On Wed, Apr 26, 2017 at 06:06:32PM +0800, Liu, Yi L wrote:
>> VT-d implementations reporting PASID or PRS fields as "Set", must also
>> report ecap.ECS as "Set". Extended-Context is required for SVM.
>>
>> When ECS is reported, intel iommu driver would initiate extended root entry
>> and extended context entry, and also PASID table if there is any SVM capable
>> device.
>>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> ---
>>  hw/i386/intel_iommu.c          | 131 +++++++++++++++++++++++++++--------------
>>  hw/i386/intel_iommu_internal.h |   9 +++
>>  include/hw/i386/intel_iommu.h  |   2 +-
>>  3 files changed, 97 insertions(+), 45 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 400d0d1..bf98fa5 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -497,6 +497,11 @@ static inline bool vtd_root_entry_present(VTDRootEntry *root)
>>      return root->val & VTD_ROOT_ENTRY_P;
>>  }
>>  
>> +static inline bool vtd_root_entry_upper_present(VTDRootEntry *root)
>> +{
>> +    return root->rsvd & VTD_ROOT_ENTRY_P;
>> +}
>> +
>>  static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
>>                                VTDRootEntry *re)
>>  {
>> @@ -509,6 +514,9 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
>>          return -VTD_FR_ROOT_TABLE_INV;
>>      }
>>      re->val = le64_to_cpu(re->val);
>> +    if (s->ecs) {
>> +        re->rsvd = le64_to_cpu(re->rsvd);
>> +    }
> 
> I feel it slightly hacky to play with re->rsvd. How about:
> 
> union VTDRootEntry {
>     struct {
>         uint64_t val;
>         uint64_t rsvd;
>     } base;
>     struct {
>         uint64_t ext_lo;
>         uint64_t ext_hi;
>     } extended;
> };
> 
> (Or any better way that can get rid of rsvd...)
> 
> Even:
> 
> struct VTDRootEntry {
>     union {
>         struct {
>                 uint64_t val;
>                 uint64_t rsvd;
>         } base;
>         struct {
>                 uint64_t ext_lo;
>                 uint64_t ext_hi;
>         } extended;
>     } data;
>     bool extended;
> };
> 
> Then we read the entry into data, and setup extended bit. A benefit of
> it is that we may avoid passing around IntelIOMMUState everywhere to
> know whether we are using extended context entries.
> 
>>      return 0;
>>  }
>>  
>> @@ -517,19 +525,30 @@ static inline bool vtd_context_entry_present(VTDContextEntry *context)
>>      return context->lo & VTD_CONTEXT_ENTRY_P;
>>  }
>>  
>> -static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
>> -                                           VTDContextEntry *ce)
>> +static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
>> +                 VTDRootEntry *root, uint8_t index, VTDContextEntry *ce)
>>  {
>> -    dma_addr_t addr;
>> +    dma_addr_t addr, ce_size;
>>  
>>      /* we have checked that root entry is present */
>> -    addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
>> -    if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
>> +    ce_size = (s->ecs) ? (2 * sizeof(*ce)) : (sizeof(*ce));
>> +    addr = (s->ecs && (index > 0x7f)) ?
>> +           ((root->rsvd & VTD_ROOT_ENTRY_CTP) + (index - 0x80) * ce_size) :
>> +           ((root->val & VTD_ROOT_ENTRY_CTP) + index * ce_size);
>> +
>> +    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
>>          trace_vtd_re_invalid(root->rsvd, root->val);
>>          return -VTD_FR_CONTEXT_TABLE_INV;
>>      }
>> -    ce->lo = le64_to_cpu(ce->lo);
>> -    ce->hi = le64_to_cpu(ce->hi);
>> +
>> +    ce[0].lo = le64_to_cpu(ce[0].lo);
>> +    ce[0].hi = le64_to_cpu(ce[0].hi);
> 
> Again, I feel this even hackier. :)
> 
> I would slightly prefer to play the same union trick to context
> entries, just like what I proposed to the root entries above...
> 
>> +
>> +    if (s->ecs) {
>> +        ce[1].lo = le64_to_cpu(ce[1].lo);
>> +        ce[1].hi = le64_to_cpu(ce[1].hi);
>> +    }
>> +
>>      return 0;
>>  }
>>  
>> @@ -595,9 +614,11 @@ static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
>>      return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
>>  }
>>  
>> -static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
>> +static inline uint32_t vtd_ce_get_type(IntelIOMMUState *s,
>> +                                       VTDContextEntry *ce)
>>  {
>> -    return ce->lo & VTD_CONTEXT_ENTRY_TT;
>> +    return s->ecs ? (ce->lo & VTD_CONTEXT_ENTRY_TT) :
>> +                    (ce->lo & VTD_EXT_CONTEXT_ENTRY_TT);
>>  }
>>  
>>  static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
>> @@ -842,16 +863,20 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>          return ret_fr;
>>      }
>>  
>> -    if (!vtd_root_entry_present(&re)) {
>> +    if (!vtd_root_entry_present(&re) ||
>> +        (s->ecs && (devfn > 0x7f) && (!vtd_root_entry_upper_present(&re)))) {
>>          /* Not error - it's okay we don't have root entry. */
>>          trace_vtd_re_not_present(bus_num);
>>          return -VTD_FR_ROOT_ENTRY_P;
>> -    } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
>> -        trace_vtd_re_invalid(re.rsvd, re.val);
>> -        return -VTD_FR_ROOT_ENTRY_RSVD;
>> +    }
>> +    if ((s->ecs && (devfn > 0x7f) && (re.rsvd & VTD_ROOT_ENTRY_RSVD)) ||
>> +        (s->ecs && (devfn < 0x80) && (re.val & VTD_ROOT_ENTRY_RSVD)) ||
>> +        ((!s->ecs) && (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)))) {
>> +            trace_vtd_re_invalid(re.rsvd, re.val);
>> +            return -VTD_FR_ROOT_ENTRY_RSVD;
> 
> Nit: I feel like we can better wrap these 0x7f and 0x80 into helper
> functions, especially if with above structure change...
> 
> (will hold here...)
> 
> Thanks,
> 


It's possible to add helper macro to check bits in context entry and
extend context entry and put the check of ecs mode into helper macro?

-- 
Best regards
Tianyu Lan
