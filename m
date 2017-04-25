Received: from eggs.gnu.org ([2001:4830:134:3::10]:59173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yJD-0005P6-Oj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yJA-0006Jq-ET
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:07:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3855
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yJ9-0006IK-QZ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:07:00 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-8-git-send-email-zhang.zhanghailiang@huawei.com>
	<87pog1oe3k.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FF2DB8.2050307@huawei.com>
Date: Tue, 25 Apr 2017 19:06:32 +0800
MIME-Version: 1.0
In-Reply-To: <87pog1oe3k.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v2 07/18] COLO: Load dirty pages
 into SVM's RAM cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On 2017/4/25 2:27, Juan Quintela wrote:
> zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
>> We should not load PVM's state directly into SVM, because there maybe some
>> errors happen when SVM is receving data, which will break SVM.
>>
>> We need to ensure receving all data before load the state into SVM. We use
>> an extra memory to cache these data (PVM's ram). The ram cache in secondary side
>> is initially the same as SVM/PVM's memory. And in the process of checkpoint,
>> we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
>> always the same as PVM's memory at every checkpoint, then we flush this cached ram
>> to SVM after we receive all PVM's state.
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>> v2:
>> - Move colo_init_ram_cache() and colo_release_ram_cache() out of
>>    incoming thread since both of them need the global lock, if we keep
>>    colo_release_ram_cache() in incoming thread, there are potential
>>    dead-lock.
>> - Remove bool ram_cache_enable flag, use migration_incoming_in_state() instead.
>> - Remove the Reviewd-by tag because of the above changes.
>
>> +out_locked:
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        if (block->colo_cache) {
>> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
>> +            block->colo_cache = NULL;
>> +        }
>> +    }
>> +
>> +    rcu_read_unlock();
>> +    return -errno;
>> +}
>> +
>> +/* It is need to hold the global lock to call this helper */
>> +void colo_release_ram_cache(void)
>> +{
>> +    RAMBlock *block;
>> +
>> +    rcu_read_lock();
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        if (block->colo_cache) {
>> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
>> +            block->colo_cache = NULL;
>> +        }
>> +    }
>> +    rcu_read_unlock();
>> +}
> Create a function from the creation/removal?  We have exactly two copies
> of the same code.  Right now the code inside the function is very small,
> but it could be bigger, no?

Yes, we add more codes  in next patch (patch 08).  :)

> Later, Juan.
>
>
> .
>
