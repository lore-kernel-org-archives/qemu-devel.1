Received: from eggs.gnu.org ([2001:4830:134:3::10]:54867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYaF-0005bm-QC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYaA-0000od-19
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:33409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1etYa9-0000nx-9g
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:54:09 -0500
Message-ID: <5A9FE1A0.8090700@intel.com>
Date: Wed, 07 Mar 2018 20:57:04 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
	<1519980450-3404-2-git-send-email-wei.w.wang@intel.com>
	<20180307122348.GC3089@work-vm>
In-Reply-To: <20180307122348.GC3089@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 03/07/2018 08:23 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>   include/migration/misc.h |  2 ++
>>   migration/ram.c          | 20 ++++++++++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 77fd4f5..fae1acf 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -14,11 +14,13 @@
>>   #ifndef MIGRATION_MISC_H
>>   #define MIGRATION_MISC_H
>>   
>> +#include "exec/cpu-common.h"
>>   #include "qemu/notify.h"
>>   
>>   /* migration/ram.c */
>>   
>>   void ram_mig_init(void);
>> +void qemu_guest_free_page_hint(void *addr, size_t len);
>>   
>>   /* migration/block.c */
>>   
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 5e33e5c..769a0f6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2189,6 +2189,26 @@ static int ram_init_all(RAMState **rsp)
>>       return 0;
>>   }
>>   
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>> +
>> +    for (used_len = len; len > 0; len -= used_len) {
>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>> +        if (unlikely(offset + len > block->used_length)) {
>> +            used_len = block->used_length - offset;
>> +            addr += used_len;
>> +        }
>> +
>> +        start = offset >> TARGET_PAGE_BITS;
>> +        npages = used_len >> TARGET_PAGE_BITS;
>> +        bitmap_clear(block->bmap, start, npages);
>> +        ram_state->migration_dirty_pages -= npages;

Hi Dave,

Thanks for reviewing this patch. There will be a little more change here 
about calculating "ram_state->migration_dirty_pages" since we just 
extend this optimization to all the stages now (instead of just bulk 
stage). Please have a check more explanations at the v4 cover-letter 
ChangeLog.

Best,
Wei
