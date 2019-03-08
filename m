Received: from eggs.gnu.org ([209.51.188.92]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1h2PHR-0005vD-Gr
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1h2PHQ-0006gO-HY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:51:57 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:33702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1h2PHQ-0006ez-9U
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 18:51:56 -0500
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-2-git-send-email-sandra@codesourcery.com>
	<CAFEAcA8p9rSYEJQ7jPFvM9Q+UXi6r7Vr8voWQ_fhzzFX1=uVzw@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <97684d40-2a1a-1c3c-cb29-cf137fa00875@codesourcery.com>
Date: Fri, 8 Mar 2019 16:51:46 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8p9rSYEJQ7jPFvM9Q+UXi6r7Vr8voWQ_fhzzFX1=uVzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Andrew Jenner <andrew@codesourcery.com>

On 3/7/19 7:57 AM, Peter Maydell wrote:
>> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
>> index 5f0ab2f..c697047 100644
>> --- a/hw/nios2/boot.c
>> +++ b/hw/nios2/boot.c
>> @@ -140,6 +140,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>>           uint64_t entry, low, high;
>>           uint32_t base32;
>>           int big_endian = 0;
>> +        int kernel_space = 0;
>>
>>   #ifdef TARGET_WORDS_BIGENDIAN
>>           big_endian = 1;
>> @@ -155,10 +156,12 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>>                                      translate_kernel_address, NULL,
>>                                      &entry, NULL, NULL,
>>                                      big_endian, EM_ALTERA_NIOS2, 0, 0);
>> +            kernel_space = 1;
>>           }
>>
>>           /* Always boot into physical ram. */
>> -        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
>> +        boot_info.bootstrap_pc = ddr_base + (kernel_space ? 0xc0000000 : 0)
>> +                                 + (entry & 0x07ffffff);
> 
> It's not clear to me what's going on here, or why an
> entry address of 0xc000_0000 is special, but I don't
> know anything about NiosII -- maybe it's clear if you do?

The processor reference guide documents that the kernel is placed at 
virtual memory address 0xc0000000.

https://www.intel.com/content/www/us/en/programmable/documentation/iga1409256728501.html#iga1409332620358

The problem the patch to boot.c is trying to solve is that we found 
things like unwind info were screwed up when using -kernel to load 
executables with an entry address other than 0xc0000000.

> Why isn't the bootstrap_pc just always the entry address ?
> Some comments on what is being done here and the use cases
> being addressed might assist. I wasn't able to work out what
> the remarks in the commit message meant, I'm afraid.
> 
> Looking at the code, I don't think that the second call to
> load_elf() will return a different entry address to the first
> one (ie translate_kernel_address() is not applied to &entry).
> That means that kernel_space is only true if entry == 0xc0000000,
> and
>    (kernel_space ? 0xc0000000 : 0) + (entry & 0x07ffffff);
> is almost the same thing as just 'entry'.

It seems like these remarks are directed more at the existing code than 
the patch....  :-S  TBH, I don't know why it was done that way originally.

> 
>> +static void nios2_generic_nommu_init(MachineState *machine)
>> +{
>> +    Nios2CPU *cpu;
>> +    DeviceState *dev;
>> +    MemoryRegion *address_space_mem = get_system_memory();
>> +    MemoryRegion *phys_tcm = g_new(MemoryRegion, 1);
>> +    MemoryRegion *phys_tcm_alias = g_new(MemoryRegion, 1);
>> +    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>> +    MemoryRegion *phys_ram_alias = g_new(MemoryRegion, 1);
>> +    ram_addr_t tcm_base = 0x0;
>> +    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
>> +    ram_addr_t ram_base = 0x10000000;
>> +    ram_addr_t ram_size = 0x08000000;
>> +    qemu_irq *cpu_irq, irq[32];
>> +    int i;
> 
> The description says this is "generic", but it appears to
> be almost identical to the existing 10M50 board model,
> including having exactly the same devices at the same
> apparently arbitrary addresses.
> 
> Could we instead add a machine parameter to the existing
> board so you could say "-machine 10m50-ghrd,mmu=no"
> (and drop the other changes -- it's not clear what they're
> needed for) ?
> 
> If it really ought to be a separate board model, perhaps
> it should be in the same source file and share the common
> code.

I didn't write this code, but the intent was actually to allow 
executables linked for the 3c120 devboards we'd been using for hardware 
testing to run in this emulation; not to emulate a mmu-less 10m50 board. 
  The BSP that we contributed to libgloss locates the reset vector, etc 
appropriately for this emulation.

I can't comment on whether the peripherals copied from the 10m50 
emulation are actually necessary or useful for anything; we certainly 
don't intend to support manipulating them from the program being loaded, 
but maybe other parts of QEMU expect certain devices to be present (I've 
seen that on other targets like ARM).  Andrew, do you have any state on 
this left?

-Sandra
