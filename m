Received: from eggs.gnu.org ([2001:4830:134:3::10]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTXS-00024x-8o
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTXP-0003IO-3w
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:15:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3350
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxTXO-0003HF-BW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:14:59 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-16-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170407173902.GP2138@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58EB30B6.60603@huawei.com>
Date: Mon, 10 Apr 2017 15:13:58 +0800
MIME-Version: 1.0
In-Reply-To: <20170407173902.GP2138@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/15] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Juan Quintela <quintela@redhat.com>

On 2017/4/8 1:39, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> Don't need to flush all VM's ram from cache, only
>> flush the dirty pages since last checkpoint
>>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>   migration/ram.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 6227b94..e9ba740 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2702,6 +2702,7 @@ int colo_init_ram_cache(void)
>>       migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>>       migration_bitmap_rcu->bmap = bitmap_new(ram_cache_pages);
>>       migration_dirty_pages = 0;
>> +    memory_global_dirty_log_start();
> Shouldn't there be a stop somewhere?
> (Probably if you failover to the secondary and colo stops?)

Ha, good catch, i forgot to stop the dirty log in secondary side.

>>       return 0;
>>   
>> @@ -2750,6 +2751,15 @@ void colo_flush_ram_cache(void)
>>       void *src_host;
>>       ram_addr_t offset = 0;
>>   
>> +    memory_global_dirty_log_sync();
>> +    qemu_mutex_lock(&migration_bitmap_mutex);
>> +    rcu_read_lock();
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        migration_bitmap_sync_range(block->offset, block->used_length);
>> +    }
>> +    rcu_read_unlock();
>> +    qemu_mutex_unlock(&migration_bitmap_mutex);
> Again this might have some fun merging with Juan's recent changes - what's
> really unusual about your set is that you're using this bitmap on the destination;
> I suspect Juan's recent changes that trickier.
> Check 'Creating RAMState for migration' and 'Split migration bitmaps by ramblock'.

I have reviewed these two series, and i think it's not a big problem
for COLO here,  We can still re-use most of the codes.

Thanks,
Hailiang

> Dave
>>       trace_colo_flush_ram_cache_begin(migration_dirty_pages);
>>       rcu_read_lock();
>>       block = QLIST_FIRST_RCU(&ram_list.blocks);
>> -- 
>> 1.8.3.1
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
