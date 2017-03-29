Received: from eggs.gnu.org ([2001:4830:134:3::10]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct2bm-0007yU-Rj
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct2bj-0006wy-Op
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:41:10 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ct2bj-0006wa-Ga
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:41:07 -0400
Received: by mail-pg0-x244.google.com with SMTP id 81so557055pgh.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:41:06 -0700 (PDT)
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
	<20170328114829.25656146@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8f7ad62d-0d1c-e917-5b87-f913dab6bb97@ozlabs.ru>
Date: Wed, 29 Mar 2017 12:41:01 +1100
MIME-Version: 1.0
In-Reply-To: <20170328114829.25656146@t450s.home>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On 29/03/17 04:48, Alex Williamson wrote:
> On Tue, 28 Mar 2017 20:05:28 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  include/exec/memory.h | 2 ++
>>  hw/ppc/spapr_iommu.c  | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index e39256ad03..925c10b35b 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -174,6 +174,8 @@ struct MemoryRegionIOMMUOps {
>>      void (*notify_flag_changed)(MemoryRegion *iommu,
>>                                  IOMMUNotifierFlag old_flags,
>>                                  IOMMUNotifierFlag new_flags);
>> +    /* Returns a kernel fd for IOMMU */
>> +    int (*get_fd)(MemoryRegion *iommu);
> 
> What if we used this as a prototype:
> 
> int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);
> 
> And then we defined:
> 
> typedef enum {
>     SPAPR_IOMMU_TABLE_FD = 0,
> } IOMMUFdType;


Where do I put this enum definition? include/exec/memory.h? It does not
have any mention of any platform yet...

I could pass char* instead of IOMMUFdType (and pass there something like
TYPE_SPAPR_TCE_TABLE), would it be any better?


> 
> Such that you're actually asking the IOMMUOps for a specific type of FD
> and it either has it or not, so the caller doesn't need to assume what
> it is they get back.
> 
> Furthermore, add:
> 
> int memory_region_iommu_get_fd(IOMMUFdType type, MemoryRegion *mr)
> {
>     assert(memory_region_is_iommu(mr));
> 
>     if (mr->iommu_ops && mr->iommu_ops->get_fd) {
>         return mr->iommu_ops->get_fd(type, mr);
>     }
> 
>     return -1;
> }
> 
>>  };
>>
> 
> This should be two patches, patch 1 above, patch 2 below
>   
>>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index 9e30e148d6..b61c8f053e 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -170,6 +170,13 @@ static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
>>      }
>>  }
>>  
>> +static int spapr_tce_get_fd(MemoryRegion *iommu)
>> +{
>> +    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
>> +
>> +    return tcet->fd;
> 
> 
> This would then be:
> 
>     return type == SPAPR_IOMMU_TABLE_FD ? tcet->fd : -1;
> 
>> +}
>> +
>>  static int spapr_tce_table_post_load(void *opaque, int version_id)
>>  {
>>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
>> @@ -251,6 +258,7 @@ static MemoryRegionIOMMUOps spapr_iommu_ops = {
>>      .translate = spapr_tce_translate_iommu,
>>      .get_min_page_size = spapr_tce_get_min_page_size,
>>      .notify_flag_changed = spapr_tce_notify_flag_changed,
>> +    .get_fd = spapr_tce_get_fd,
>>  };
>>  
>>  static int spapr_tce_table_realize(DeviceState *dev)
> 


-- 
Alexey
