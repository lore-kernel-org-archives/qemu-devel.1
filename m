Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLpqk-0007mn-U9
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLpqh-0000pX-Qz
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:55:38 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:64617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLpqh-0000nI-IP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:55:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00G5E2GG6C40@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:55:29 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <6ee59bd7-658c-6fa2-1196-07efc505f9e6@samsung.com>
Date: Fri, 16 Jun 2017 14:55:25 +0300
MIME-version: 1.0
In-reply-to: <20170616090600.GH30118@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1497544575-18628-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170615163630eucas1p24f8f92a8acc7e408849696645f9557f2@eucas1p2.samsung.com>
	<1497544575-18628-4-git-send-email-a.perevalov@samsung.com>
	<20170616090600.GH30118@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

On 06/16/2017 12:06 PM, Peter Xu wrote:
> On Thu, Jun 15, 2017 at 07:36:15PM +0300, Alexey Perevalov wrote:
>
> [...]
>
>> +void init_receivedmap(void)
>> +{
>> +    RAMBlock *rb;
>> +
>> +    RAMBLOCK_FOREACH(rb) {
>> +        unsigned long pages;
>> +        pages = rb->max_length >> TARGET_PAGE_BITS;
> Nit: I would assert(!rb->receivedmap) before new it in case for leak.
ok,
>
>> +        rb->receivedmap = bitmap_new(pages);
>> +    }
>> +}
>> +
>> +static unsigned long int get_received_bit_offset(void *host_addr, RAMBlock *rb)
>> +{
>> +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
>> +                                                      - (void *)rb->host);
>> +    return host_addr_offset >> TARGET_PAGE_BITS;
>> +}
> Can we rename this function to ramblock_get_pfn() and export it in
> ramblock API (exec/ram_addr.h)?
if you need it, I'll place export into ram_addr.h
but name, PFN could confuse, because in case of hugepage
address this function will not return real PFN, due to

TARGET_PAGE_BITS usage.

>
> static inline uint64_t ramblock_get_pfn(RAMBlock *rb, void *host)
> {
>      return (host - rb->host) >> TARGET_PAGE_BITS;
> }
>
>> +
>> +int test_receivedmap_by_addr(void *host_addr, RAMBlock *rb)
>> +{
>> +    return test_bit(get_received_bit_offset(host_addr, rb), rb->receivedmap);
>> +}
>> +
>> +void set_receivedmap_by_addr(void *host_addr, RAMBlock *rb)
>> +{
>> +    set_bit_atomic(get_received_bit_offset(host_addr, rb), rb->receivedmap);
>> +}
>> +
>>   /*
>>    * An outstanding page request, on the source, having been received
>>    * and queued
>> @@ -2324,8 +2352,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
>>   
>>   static int ram_load_cleanup(void *opaque)
>>   {
>> +    RAMBlock *rb;
>>       xbzrle_load_cleanup();
>>       compress_threads_load_cleanup();
>> +
>> +    RAMBLOCK_FOREACH(rb) {
> Nit: I'd prefer: if (rb->receivedmap) {...}
g_free already contains it
>
>> +        g_free(rb->receivedmap);
> and: rb->receivedmap = NULL later.
why not )
>
>> +    }
>>       return 0;
>>   }
>>   
>> diff --git a/migration/ram.h b/migration/ram.h
>> index c081fde..7048ff9 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -52,4 +52,9 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>>   int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>>   
>>   void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>> +
>> +void init_receivedmap(void);
>> +int test_receivedmap_by_addr(void *host_addr, RAMBlock *rb);
>> +void set_receivedmap_by_addr(void *host_addr, RAMBlock *rb);
> Nit: I would name these names as: ramblock_recv_map_*().
>
>> +
>>   #endif
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 31158da..668d3bb 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1372,6 +1372,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>>           return -1;
>>       }
>>   
>> +    init_receivedmap();
>>       remote_pagesize_summary = qemu_get_be64(mis->from_src_file);
>>       local_pagesize_summary = ram_pagesize_summary();
>>   
>> -- 
>> 1.9.1
>>
> Again, did you trap precopy?
sorry, I really forgot, now it's not copied bitmap, it's
received bitmap. So, I know about
case RAM_SAVE_FLAG_PAGE, but it seems another cases exist 
(compressed/xbzrle)
and there is no single point where coping is doing.


>
> Thanks,
>

-- 
Best regards,
Alexey Perevalov
