Received: from eggs.gnu.org ([2001:4830:134:3::10]:60933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d305K-00072I-27
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d305H-0007X1-0W
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d305G-0007Wk-O6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:00:46 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <58FF38DE.4010902@huawei.com> (Hailiang Zhang's message of "Tue,
	25 Apr 2017 19:54:06 +0800")
References: <20170425101104.3818-1-quintela@redhat.com>
	<20170425101104.3818-2-quintela@redhat.com>
	<58FF38DE.4010902@huawei.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 15:00:42 +0200
Message-ID: <87r30gmykl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ram: Split dirty bitmap by RAMBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Hailiang Zhang <zhang.zhanghailiang@huawei.com> wrote:
> On 2017/4/25 18:11, Juan Quintela wrote:
>> Both the ram bitmap and the unsent bitmap are split by RAMBlock.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   include/exec/ram_addr.h          |  13 +-
>>   include/migration/postcopy-ram.h |   3 -
>>   migration/postcopy-ram.c         |   5 +-
>>   migration/ram.c                  | 257 +++++++++++++++------------------------
>>   4 files changed, 109 insertions(+), 169 deletions(-)
>>

>> +
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> ... ...
>> +        unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
>> +        unsigned long *bitmap = block->bmap;
>> +        unsigned long *unsentmap = block->unsentmap;
>> +
>> +        if (!unsentmap) {
>> +            /* We don't have a safe way to resize the sentmap, so
>> +             * if the bitmap was resized it will be NULL at this
>> +             * point.
>> +             */
>> +            error_report("migration ram resized during precopy phase");
>> +            rcu_read_unlock();
>> +            return -EINVAL;
>> +        }
>> +        /* Deal with TPS != HPS and huge pages */
>> +        ret = postcopy_chunk_hostpages(ms, block);
>> +        if (ret) {
>> +            rcu_read_unlock();
>> +            return ret;
>> +        }
>> +
>> +        /*
>> +         * Update the unsentmap to be unsentmap = unsentmap | dirty
>>            */
>> -        error_report("migration ram resized during precopy phase");
>> -        rcu_read_unlock();
>> -        return -EINVAL;
>> +        bitmap_or(unsentmap, unsentmap, bitmap, pages);
>>       }
>> -
>> -    /* Deal with TPS != HPS and huge pages */
>> -    ret = postcopy_chunk_hostpages(ms);
>> -    if (ret) {
>> -        rcu_read_unlock();
>> -        return ret;
>> -    }
>> -
>> -    /*
>> -     * Update the unsentmap to be unsentmap = unsentmap | dirty
>> -     */
>> -    bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>> -    bitmap_or(unsentmap, unsentmap, bitmap, last_ram_page());
>> -
>> -
>>       trace_ram_postcopy_send_discard_bitmap();
>>   #ifdef DEBUG_POSTCOPY
>>       ram_debug_dump_bitmap(unsentmap, true);
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> It seems that, you forgot to put the above codes in the loop:
>
>   QLIST_FOREACH_RCU(block, &ram_list.blocks, next)
>
> If DEBUG_POSTCOPY is defined, compiling will fail ...

Fixed, thanks.

Now I put that code inside the FOREACH with the "pages" parameter.

Later, Juan.
