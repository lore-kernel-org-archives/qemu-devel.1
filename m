Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dPuyF-0008I0-Jm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dPuyA-0002h0-VL
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dPuyA-0002gR-Nb
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:12:10 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <87bmp98j17.fsf@secure.mitica> (Juan Quintela's message of "Tue,
	27 Jun 2017 18:58:12 +0200")
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
	<20170623095522.GB12689@stefanha-x1.localdomain>
	<20170626020501.xq54xlnqmhika3zw@hz-desktop>
	<20170626125651.GA7776@stefanha-x1.localdomain>
	<20170627143001.jsfmxqnaig7nfawx@hz-desktop>
	<87bmp98j17.fsf@secure.mitica>
Reply-To: quintela@redhat.com
Date: Tue, 27 Jun 2017 20:12:04 +0200
Message-ID: <874lv18fm3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>

Juan Quintela <quintela@redhat.com> wrote:
> Haozhong Zhang <haozhong.zhang@intel.com> wrote:
>
> ....
>
> Hi
>
> I am trying to see what is going on.
>
>>> 
>>
>> I managed to reproduce this bug. After bisect between good v2.8.0 and
>> bad edf8bc984, it looks a regression introduced by
>>     6b6712efccd "ram: Split dirty bitmap by RAMBlock"
>> This commit may result in guest crash after migration if any host
>> memory backend is used.
>>
>> Could you test whether the attached draft patch fixes this bug? If yes,
>> I will make a formal patch later.
>>
>> Thanks,
>> Haozhong
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 73d1bea8b6..2ae4ff3965 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -377,7 +377,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>                                                 uint64_t *real_dirty_pages)
>>  {
>>      ram_addr_t addr;
>> +    ram_addr_t offset = rb->offset;
>>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>> +    unsigned long dirty_page = BIT_WORD((start + offset) >> TARGET_PAGE_BITS);
>>      uint64_t num_dirty = 0;
>>      unsigned long *dest = rb->bmap;
>>  
>
>
> If this is the case, I can't understand how it ever worked :-(
>
> Investigating.

Further investigation, it gets as:
- pc.ram, by default is at slot 0
- so offset == 0
- rest of devices are not ram-lived

So it work well.

Only ram ends using that function, so we don't care.

When we use nvdimm device (don't know if any other), it just gets out of
ramblock 0, and then the offset is important.

# No NVDIMM

(qemu) info ramblock 
              Block Name    PSize              Offset               Used              Total
                  pc.ram    4 KiB  0x0000000000000000 0x0000000040000000 0x0000000040000000
                vga.vram    4 KiB  0x0000000040060000 0x0000000000400000 0x0000000000400000

# with NVDIMM

(qemu) info ramblock 
              Block Name    PSize              Offset               Used              Total
           /objects/mem1    4 KiB  0x0000000000000000 0x0000000040000000 0x0000000040000000
                  pc.ram    4 KiB  0x0000000040000000 0x0000000040000000 0x0000000040000000
                vga.vram    4 KiB  0x0000000080060000 0x0000000000400000 0x0000000000400000


I am still amused/confused/integrated? how we haven't discovered the
problem before.

The patch fixes the problem described on the thread.


Later, Juan.

>
> Later, Juan.
>
>> @@ -386,8 +388,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>          int k;
>>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>>          unsigned long * const *src;
>> -        unsigned long idx = (page * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>> -        unsigned long offset = BIT_WORD((page * BITS_PER_LONG) %
>> +        unsigned long idx = (dirty_page * BITS_PER_LONG) /
>> +                            DIRTY_MEMORY_BLOCK_SIZE;
>> +        unsigned long offset = BIT_WORD((dirty_page * BITS_PER_LONG) %
>>                                          DIRTY_MEMORY_BLOCK_SIZE);
>>  
>>          rcu_read_lock();
>> @@ -416,7 +419,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>      } else {
>>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>>              if (cpu_physical_memory_test_and_clear_dirty(
>> -                        start + addr,
>> +                        start + addr + offset,
>>                          TARGET_PAGE_SIZE,
>>                          DIRTY_MEMORY_MIGRATION)) {
>>                  *real_dirty_pages += 1;
