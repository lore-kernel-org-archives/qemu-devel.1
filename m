Received: from eggs.gnu.org ([2001:4830:134:3::10]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewQS7-00006Y-VT
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewQS4-0004gM-Sn
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:49:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:23071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewQS4-0004e0-Jb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:49:40 -0400
Message-ID: <5AAA5079.2000308@intel.com>
Date: Thu, 15 Mar 2018 18:52:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
	<20180314181137.GG3006@work-vm>
In-Reply-To: <20180314181137.GG3006@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] migration: API to clear bits of
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

On 03/15/2018 02:11 AM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   include/migration/misc.h |  2 ++
>>   migration/ram.c          | 21 +++++++++++++++++++++
>>   2 files changed, 23 insertions(+)
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
>> index 5e33e5c..e172798 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2189,6 +2189,27 @@ static int ram_init_all(RAMState **rsp)
>>       return 0;
>>   }
>>   
> This could do with some comments

OK, I'll add some.

>
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>  From your use I think the addr and len are coming raw from the guest;
> so we need to take some care.
>

Actually the "addr" here has been the host address that corresponds to 
the guest free page. It's from elem->in_sg[0].iov_base.

>
>> +        if (unlikely(offset + len > block->used_length)) {
> I think to make that overflow safe, that should be:
>    if (len > (block->used_length - offset)) {
>
> But we'll need another test before it, because qemu_ram_block_from_host
> seems to check max_length not used_length, so we need to check
> for offset > block->used_length first

OK, how about adding an assert above, like this:

block = qemu_ram_block_from_host(addr, false, &offset);
assert (offset  < block->used_length );
if (!block)
     ...

The address corresponds to a guest free page, which means it should be 
within used_length. If not, something weird happens, I think we'd better 
to assert it in that case.

Best,
Wei
