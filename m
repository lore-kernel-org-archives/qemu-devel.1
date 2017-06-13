Received: from eggs.gnu.org ([2001:4830:134:3::10]:57519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKf2a-0002NL-1H
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKf2W-0003iK-LU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:10:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dKf2W-0003i8-CM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:10:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORH00B8Z2I19Q80@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:10:49 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <70f69591-8f94-8171-8a6b-684120723e0c@samsung.com>
Date: Tue, 13 Jun 2017 09:10:46 +0300
MIME-version: 1.0
In-reply-to: <20170613055949.GD11751@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p15097f154039365d5e135f92b72aad1bf@eucas1p1.samsung.com>
	<1496828798-27548-8-git-send-email-a.perevalov@samsung.com>
	<20170613055949.GD11751@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v8 07/11] migration: add bitmap for copied
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com

On 06/13/2017 08:59 AM, Peter Xu wrote:
> On Wed, Jun 07, 2017 at 12:46:34PM +0300, Alexey Perevalov wrote:
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
>> related bitmaps. Helpers are in migration/ram.c, due to
>> in this file is allowing to work with RAMBlock.
>>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> Hi, Alexey,
>
> Besides all the existing comments, I would suggest you do all the
> copied_map things in this single patch, so that it'll be easier for
> others to work upon your work. E.g., move the bit_set() operations
> here as well (currently it was in followup patches, and looks like
> that's not enough since we need to capture copied_map even for precopy
> phase), then this single patch can ideally be separated from the whole
> series (and then I can work upon it :-).
>
> Or, please just let me know if you want me to do this for you. I can
> post this as a standalone patch, with your s-o-b if you allow.

Hello Peter,
I'm working with this patch in another patch series too.
(it's about QEMU's shared memory and OVS-VSWITCHD,
vhost-user use case).
So if you need that I could resend this patch as separate patch.
And it will be convenient to base both my patch set and you patches
on top of it.
>
> Thanks,
>
>> ---
>>   include/exec/ram_addr.h |  2 ++
>>   migration/ram.c         | 36 ++++++++++++++++++++++++++++++++++++
>>   migration/ram.h         |  4 ++++
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 140efa8..6a3780b 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -47,6 +47,8 @@ struct RAMBlock {
>>        * of the postcopy phase
>>        */
>>       unsigned long *unsentmap;
>> +    /* bitmap of already copied pages in postcopy */
>> +    unsigned long *copiedmap;
>>   };
>>   
>>   static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f387e9c..a7c0db4 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -149,6 +149,25 @@ out:
>>       return ret;
>>   }
>>   
>> +static unsigned long int get_copied_bit_offset(uint64_t addr, RAMBlock *rb)
>> +{
>> +    uint64_t addr_offset = addr - (uint64_t)(uintptr_t)rb->host;
>> +    int page_shift = find_first_bit((unsigned long *)&rb->page_size,
>> +                                    sizeof(rb->page_size));
>> +
>> +    return addr_offset >> page_shift;
>> +}
>> +
>> +int test_copiedmap_by_addr(uint64_t addr, RAMBlock *rb)
>> +{
>> +    return test_bit(get_copied_bit_offset(addr, rb), rb->copiedmap);
>> +}
>> +
>> +void set_copiedmap_by_addr(uint64_t addr, RAMBlock *rb)
>> +{
>> +    set_bit_atomic(get_copied_bit_offset(addr, rb), rb->copiedmap);
>> +}
>> +
>>   /*
>>    * An outstanding page request, on the source, having been received
>>    * and queued
>> @@ -1449,6 +1468,8 @@ static void ram_migration_cleanup(void *opaque)
>>           block->bmap = NULL;
>>           g_free(block->unsentmap);
>>           block->unsentmap = NULL;
>> +        g_free(block->copiedmap);
>> +        block->copiedmap = NULL;
>>       }
>>   
>>       XBZRLE_cache_lock();
>> @@ -2517,6 +2538,14 @@ static int ram_load_postcopy(QEMUFile *f)
>>       return ret;
>>   }
>>   
>> +static unsigned long get_copiedmap_size(RAMBlock *rb)
>> +{
>> +    unsigned long pages;
>> +    pages = rb->max_length >> find_first_bit((unsigned long *)&rb->page_size,
>> +                                             sizeof(rb->page_size));
>> +    return pages;
>> +}
>> +
>>   static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>   {
>>       int flags = 0, ret = 0;
>> @@ -2544,6 +2573,13 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>       rcu_read_lock();
>>   
>>       if (postcopy_running) {
>> +        RAMBlock *rb;
>> +        RAMBLOCK_FOREACH(rb) {
>> +            /* need for destination, bitmap_new calls
>> +             * g_try_malloc0 and this function
>> +             * Attempts to allocate @n_bytes, initialized to 0'sh */
>> +            rb->copiedmap = bitmap_new(get_copiedmap_size(rb));
>> +        }
>>           ret = ram_load_postcopy(f);
>>       }
>>   
>> diff --git a/migration/ram.h b/migration/ram.h
>> index c9563d1..1f32824 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -67,4 +67,8 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
>>   int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>>   
>>   void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>> +
>> +int test_copiedmap_by_addr(uint64_t addr, RAMBlock *rb);
>> +void set_copiedmap_by_addr(uint64_t addr, RAMBlock *rb);
>> +
>>   #endif
>> -- 
>> 1.9.1
>>

-- 
Best regards,
Alexey Perevalov
