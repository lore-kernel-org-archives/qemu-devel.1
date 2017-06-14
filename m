Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dL1yH-0004lt-SU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dL1yE-00041y-Lw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:40:05 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:59323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dL1yE-00040E-BW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:40:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORI0049JYIK0X00@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:39:56 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <516e826e-5469-81b6-b23b-12f9b759bd64@samsung.com>
Date: Wed, 14 Jun 2017 09:39:53 +0300
MIME-version: 1.0
In-reply-to: <20170614051223.GH11751@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	<20170614051223.GH11751@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
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

On 06/14/2017 08:12 AM, Peter Xu wrote:
> On Tue, Jun 13, 2017 at 12:36:33PM +0300, Alexey Perevalov wrote:
>> This patch adds ability to track down already copied
>> pages, it's necessary for calculation vCPU block time in
>> postcopy migration feature, maybe for restore after
>> postcopy migration failure.
>> Also it's necessary to solve shared memory issue in
>> postcopy livemigration. Information about copied pages
>> will be transferred to the software virtual bridge
>> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
>> already copied pages. fallocate syscall is required for
>> remmaped shared memory, due to remmaping itself blocks
>> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
>> error (struct page is exists after remmap).
>>
>> Bitmap is placed into RAMBlock as another postcopy/precopy
>> related bitmaps.
>>
>> copied bitmap is not releasing due to ramblocks is not releasing
>> too.
>>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   include/exec/ram_addr.h       |  3 +++
>>   include/migration/migration.h |  3 +++
>>   migration/postcopy-ram.c      |  7 ++++++
>>   migration/ram.c               | 54 ++++++++++++++++++++++++++++++++++++++++++-
>>   migration/ram.h               |  5 ++++
>>   migration/savevm.c            |  1 +
>>   6 files changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 140efa8..56cdf16 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -47,6 +47,9 @@ struct RAMBlock {
>>        * of the postcopy phase
>>        */
>>       unsigned long *unsentmap;
>> +    /* bitmap of already copied pages in postcopy */
>> +    unsigned long *copiedmap;
>> +    size_t nr_copiedmap;
> Do we really need this?
This and question about

ram_discard_range Juan already asked.
I just repeat nr_copiedmap - premature optimization )
ram_discard_range - I forgot to clean up patch.

>
>>   };
>>   
>>   static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 79b5484..8005c11 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -226,4 +226,7 @@ void savevm_skip_configuration(void);
>>   int global_state_store(void);
>>   void global_state_store_running(void);
>>   
>> +size_t get_copiedmap_size(RAMBlock *rb);
>> +void movecopiedmap(void *dst, RAMBlock *rb, size_t len);
>> +
>>   #endif
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index f6244ee..e13b22e 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -576,6 +576,13 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>>       copy_struct.len = pagesize;
>>       copy_struct.mode = 0;
>>   
>> +
>> +    /* copied page isn't feature of blocktime calculation,
>> +     * it's more general entity, so keep it here,
>> +     * but gup betwean two following operation could be high,
>> +     * and in this case blocktime for such small interval will be lost */
>> +    set_copiedmap_by_addr(host, rb);
>> +
> I guess this is not enough?
yes, zero pages were missed
>
> For postcopy, you may have missed to trap in
> postcopy_place_page_zero() when pagesize == getpagesize() (we used
> UFFDIO_ZEROPAGE there)?
>
> (Btw, why not we trap all these in ram_load_postcopy()?)
I tried to place

set_copiedmap_by_addr as closer as possible to ioctl. It could be important to reduce probability of
race, also when I inform OVS-VSWITCH (patches not yet published), it's important to reduce time between
mark page as copied and really coping.

>
> For precopy, looks like it's missing as well? I believe it's in
> ram_load().


>
>>       /* copy also acks to the kernel waking the stalled thread up
>>        * TODO: We can inhibit that ack and only do it if it was requested
>>        * which would be slightly cheaper, but we'd have to be careful
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4ed7c2c..8466e59 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -149,6 +149,58 @@ out:
>>       return ret;
>>   }
>>   
>> +void init_copiedmap(void)
>> +{
>> +    RAMBlock *rb;
> (Nit: better with a new line after parameters.)
>
>> +    RAMBLOCK_FOREACH(rb) {
>> +        unsigned long pages;
>> +        pages = rb->max_length >> find_first_bit(&rb->page_size,
>> +                8 * sizeof(rb->page_size));
>> +        /* need for destination, bitmap_new calls
>> +         * g_try_malloc0 and this function
>> +         * Attempts to allocate @n_bytes, initialized to 0'sh */
>> +        rb->copiedmap = bitmap_new(pages);
>> +        rb->nr_copiedmap = pages;
>> +    }
>> +}
>> +
>> +static unsigned long int get_copied_bit_offset(void *host_addr, RAMBlock *rb)
>> +{
>> +    uint64_t host_addr_offset = (uint64_t)(uintptr_t)(host_addr
>> +                                                      - (void *)rb->host);
>> +    int page_shift = find_first_bit(&rb->page_size, 8 * sizeof(rb->page_size));
>> +
>> +    return host_addr_offset >> page_shift;
>> +}
>> +
>> +int test_copiedmap_by_addr(void *host_addr, RAMBlock *rb)
>> +{
>> +    return test_bit(get_copied_bit_offset(host_addr, rb), rb->copiedmap);
>> +}
>> +
>> +void set_copiedmap_by_addr(void *host_addr, RAMBlock *rb)
>> +{
>> +    set_bit_atomic(get_copied_bit_offset(host_addr, rb), rb->copiedmap);
>> +}
>> +
>> +size_t get_copiedmap_size(RAMBlock *rb)
>> +{
>> +    return rb->nr_copiedmap;
>> +}
> As commented by Juan, I think we need per-TARGET_PAGE_SIZE bitmap. If
> so, we should be able to get rid of these helpers?
ok, it's significant argument, so TARGET_PAGE_SIZE will be
here. The size of bitmap will increase, and I pass that bitmap into 
OVS-VSWITCHD,
ok it is another story.
>
>> +
>> +/*
>> + * This function copies copiedmap from RAMBlock into
>> + * dst memory region
>> + *
>> + * @dst destination address
>> + * @rb RAMBlock source
>> + * @len length in bytes
>> + */
>> +void movecopiedmap(void *dst, RAMBlock *rb, size_t len)
>> +{
>> +    memcpy(dst, rb->copiedmap, len);
>> +}
>> +
>>   /*
>>    * An outstanding page request, on the source, having been received
>>    * and queued
>> @@ -1852,11 +1904,11 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>>   {
>>       int ret = -1;
>>   
>> -    trace_ram_discard_range(rbname, start, length);
>>   
>>       rcu_read_lock();
>>       RAMBlock *rb = qemu_ram_block_by_name(rbname);
>>   
>> +    trace_ram_discard_range(rbname, start, length);
> Why this move?
>
> And still, we need logic for the discard during postcopy?
>
> Thanks,
>
>>       if (!rb) {
>>           error_report("ram_discard_range: Failed to find block '%s'", rbname);
>>           goto err;
>> diff --git a/migration/ram.h b/migration/ram.h
>> index c9563d1..dc781c1 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -67,4 +67,9 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>>   int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>>   
>>   void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>> +
>> +void init_copiedmap(void);
>> +int test_copiedmap_by_addr(void *host_addr, RAMBlock *rb);
>> +void set_copiedmap_by_addr(void *host_addr, RAMBlock *rb);
>> +
>>   #endif
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 9c320f5..7b3726a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1385,6 +1385,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>>           return -1;
>>       }
>>   
>> +    init_copiedmap();
>>       remote_pagesize_summary = qemu_get_be64(mis->from_src_file);
>>       local_pagesize_summary = ram_pagesize_summary();
>>   
>> -- 
>> 1.9.1
>>
> Thanks,
>

-- 
Best regards,
Alexey Perevalov
