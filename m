Received: from eggs.gnu.org ([2001:4830:134:3::10]:34541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yVD-00029U-V9
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yVB-0003PH-7Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:19:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3908
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yVA-0003I2-KQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:19:25 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-9-git-send-email-zhang.zhanghailiang@huawei.com>
	<87lgqpoe0d.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FF30A7.2020706@huawei.com>
Date: Tue, 25 Apr 2017 19:19:03 +0800
MIME-Version: 1.0
In-Reply-To: <87lgqpoe0d.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v2 08/18] ram/COLO: Record the dirty
 pages that SVM received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com

On 2017/4/25 2:29, Juan Quintela wrote:
> zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
>> We record the address of the dirty pages that received,
>> it will help flushing pages that cached into SVM.
>>
>> Here, it is a trick, we record dirty pages by re-using migration
>> dirty bitmap. In the later patch, we will start the dirty log
>> for SVM, just like migration, in this way, we can record both
>> the dirty pages caused by PVM and SVM, we only flush those dirty
>> pages from RAM cache while do checkpoint.
>>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   migration/ram.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 05d1b06..0653a24 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2268,6 +2268,9 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>>   static inline void *colo_cache_from_block_offset(RAMBlock *block,
>>                                                    ram_addr_t offset)
>>   {
>> +    unsigned long *bitmap;
>> +    long k;
>> +
>>       if (!offset_in_ramblock(block, offset)) {
>>           return NULL;
>>       }
>> @@ -2276,6 +2279,17 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
>>                        __func__, block->idstr);
>>           return NULL;
>>       }
>> +
>> +    k = (memory_region_get_ram_addr(block->mr) + offset) >> TARGET_PAGE_BITS;
>> +    bitmap = atomic_rcu_read(&ram_state.ram_bitmap)->bmap;
>> +    /*
>> +    * During colo checkpoint, we need bitmap of these migrated pages.
>> +    * It help us to decide which pages in ram cache should be flushed
>> +    * into VM's RAM later.
>> +    */
>> +    if (!test_and_set_bit(k, bitmap)) {
>> +        ram_state.migration_dirty_pages++;
>> +    }
>>       return block->colo_cache + offset;
>>   }
>>   
>> @@ -2752,6 +2766,15 @@ int colo_init_ram_cache(void)
>>           memcpy(block->colo_cache, block->host, block->used_length);
>>       }
>>       rcu_read_unlock();
>> +    /*
>> +    * Record the dirty pages that sent by PVM, we use this dirty bitmap together
>> +    * with to decide which page in cache should be flushed into SVM's RAM. Here
>> +    * we use the same name 'ram_bitmap' as for migration.
>> +    */
>> +    ram_state.ram_bitmap = g_new0(RAMBitmap, 1);
>> +    ram_state.ram_bitmap->bmap = bitmap_new(last_ram_page());
>> +    ram_state.migration_dirty_pages = 0;
>> +
>>       return 0;
>>   
>>   out_locked:
>> @@ -2770,6 +2793,12 @@ out_locked:
>>   void colo_release_ram_cache(void)
>>   {
>>       RAMBlock *block;
>> +    RAMBitmap *bitmap = ram_state.ram_bitmap;
>> +
>> +    atomic_rcu_set(&ram_state.ram_bitmap, NULL);
>> +    if (bitmap) {
>> +        call_rcu(bitmap, migration_bitmap_free, rcu);
>> +    }
>>   
>>       rcu_read_lock();
>>       QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> You can see my Split bitmap patches, I am splitting the dirty bitmap per
> block, I think that it shouldn't make your life more difficult, but
> please take a look.

OK, I'll look at it.

> I am wondering if it is faster/easier to use the page_cache.c that
> xbzrle uses to store the dirty pages instead of copying the whole
> RAMBlocks, but I don't really know.

Hmm,  Yes, it takes long time (depends on VM's memory size) to backup the whole VM's memory data into cache.
And we can reduce the time by backup page one by one while loading the page during the first live migration round,
because we can know  if users enable COLO at the beginning of the first migration stage.
I'd like to send those optimization later in another series...

Thanks,
Hailiang

>
> Thanks, Juan.
>
> .
>
