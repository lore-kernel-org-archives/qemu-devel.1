Received: from eggs.gnu.org ([2001:4830:134:3::10]:52764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBIe-0000Xc-AH
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBIZ-0007TI-I6
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBIZ-0007T1-9D
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:38:19 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <2f01750b-8ab5-dd73-1d0e-2efc86f427ee@redhat.com> (Paolo
	Bonzini's message of "Wed, 28 Jun 2017 13:14:23 +0200")
References: <20170628083704.24997-1-haozhong.zhang@intel.com>
	<2f01750b-8ab5-dd73-1d0e-2efc86f427ee@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 13:38:13 +0200
Message-ID: <87k23w5om2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] exec: fix access to
 ram_list.dirty_memory when sync dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 28/06/2017 10:37, Haozhong Zhang wrote:
>> In cpu_physical_memory_sync_dirty_bitmap(rb, start, ...), the 2nd
>> argument 'start' is relative to the start of the ramblock 'rb'. When
>> it's used to access the dirty memory bitmap of ram_list (i.e.
>> ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]->blocks[]), an offset to
>> the start of all RAM (i.e. rb->offset) should be added to it, which has
>> however been missed since c/s 6b6712efcc. For a ramblock of host memory
>> backend whose offset is not zero, cpu_physical_memory_sync_dirty_bitmap()
>> synchronizes the incorrect part of the dirty memory bitmap of ram_list
>> to the per ramblock dirty bitmap. As a result, a guest with host
>> memory backend may crash after migration.
>> 
>> Fix it by adding the offset of ramblock when accessing the dirty memory
>> bitmap of ram_list in cpu_physical_memory_sync_dirty_bitmap().
>> 
>> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> ---
>> Changes in v2:
>>  * Avoid shadowing variable 'offset'. (Paolo)
>> ---
>>  include/exec/ram_addr.h | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 73d1bea8b6..c04f4f67f6 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -386,8 +386,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>          int k;
>>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>>          unsigned long * const *src;
>> -        unsigned long idx = (page * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>> -        unsigned long offset = BIT_WORD((page * BITS_PER_LONG) %
>> +        unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>> +        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>> +        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
>>                                          DIRTY_MEMORY_BLOCK_SIZE);
>>  
>>          rcu_read_lock();
>> @@ -414,9 +415,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>  
>>          rcu_read_unlock();
>>      } else {
>> +        ram_addr_t offset = rb->offset;
>> +
>>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>>              if (cpu_physical_memory_test_and_clear_dirty(
>> -                        start + addr,
>> +                        start + addr + offset,
>>                          TARGET_PAGE_SIZE,
>>                          DIRTY_MEMORY_MIGRATION)) {
>>                  *real_dirty_pages += 1;
>> 
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Juan, please take care of this yourself!  Thanks,

Already sent in a pull request 5 mins ago.
(so, it don't have your Ack :-)

Thanks, Juan.
