Received: from eggs.gnu.org ([2001:4830:134:3::10]:54701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fB094-0007sG-0w
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fB090-0002PF-U7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:46:18 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41689
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1fB090-0002OT-Ga
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:46:14 -0400
References: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
	<1524046608-12906-3-git-send-email-frederic.konrad@adacore.com>
	<CAHNT7Nt5D6_7xUBPxkz-oAT5O-a0FZfyXXfiaEG8sFLRgfebAw@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <4d64e4dd-8a10-8778-2d97-e9005055aca2@adacore.com>
Date: Tue, 24 Apr 2018 17:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nt5D6_7xUBPxkz-oAT5O-a0FZfyXXfiaEG8sFLRgfebAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] riscv: htif: increase the priority
 of the htif subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>



On 04/20/2018 02:57 AM, Michael Clark wrote:
> On Wed, Apr 18, 2018 at 10:16 PM, KONRAD Frederic <
> frederic.konrad@adacore.com> wrote:
> 
>> The htif device is supposed to be mapped over an other subregion. So
>> increase
>> its priority to one to avoid any conflict.
>>
>> Here is the output of info mtree:
>>
>> Before:
>> (qemu) info mtree
>>   address-space: memory
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000000000f (prio 0, i/o): riscv.htif.uart
>>       0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
>>       0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
>>       0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram
>>
>>   address-space: I/O
>>     0000000000000000-000000000000ffff (prio 0, i/o): io
>>
>>   address-space: cpu-memory-0
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000000000f (prio 0, i/o): riscv.htif.uart
>>       0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
>>       0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
>>       0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram
>>
>> After:
>>   (qemu) info mtree
>>   address-space: memory
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000000000f (prio 1, i/o): riscv.htif.uart
>>       0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
>>       0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
>>       0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram
>>
>>   address-space: I/O
>>     0000000000000000-000000000000ffff (prio 0, i/o): io
>>
>>   address-space: cpu-memory-0
>>     0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>       0000000000000000-000000000000000f (prio 1, i/o): riscv.htif.uart
>>       0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
>>       0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
>>       0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>
> 
> Reviewed-by: Michael Clark <mjc@sifive.com>
> 
> BTW if you like I can incorporate these into the riscv tree. e.g. here,
> feel free to make a PR in GitHub:
> 
> https://github.com/riscv/riscv-qemu/tree/qemu-2.13-for-upstream
> 
> (however the riscv.org tree has a lot of changes in it so you might be
> better off getting these changes merged in upstream as the review backlog
> is large)
> 
> It's just that i'd like to keep the trees in sync with upstream while at
> the same time incorporating as many fixes as I can in the riscv tree
> (before they are in upstream) so that the riscv tree is complete for users
> who want to pull a branch that includes the outstanding riscv fixes. I have
> scripts that can merge mutliple branches into 'riscv-all' in the riscv
> github so if you make a PR against the riscv github I can merge them in
> that tree, and drop them if they get accepted upstream independently. I'm
> pulling from master frequently so its fine either way.
> 
> Just i'd like the riscv tree to accumulate all of the fixes that haven't
> yet made it upstream.

Hi Michael,

Ok I'll respin on the list then and try to do a PR on GitHub.

Thanks,
Fred

> 
> ---
>>   hw/riscv/riscv_htif.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
>> index 6e687f2..48e5452 100644
>> --- a/hw/riscv/riscv_htif.c
>> +++ b/hw/riscv/riscv_htif.c
>> @@ -253,8 +253,9 @@ HTIFState *htif_mm_init(MemoryRegion *address_space,
>> MemoryRegion *main_mem,
>>           htif_be_change, s, NULL, true);
>>       if (address_symbol_set) {
>>           memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
>> -                            TYPE_HTIF_UART, size);
>> -        memory_region_add_subregion(address_space, base, &s->mmio);
>> +                              TYPE_HTIF_UART, size);
>> +        memory_region_add_subregion_overlap(address_space, base,
>> +                                            &s->mmio, 1);
>>       }
>>
>>       return s;
>> --
>> 1.8.3.1
>>
>>
> 
