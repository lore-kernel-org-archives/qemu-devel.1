Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eJPsM-00021q-0X
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eJPsI-0005Dy-RE
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:34 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eJPsI-0005Di-J4
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:30 -0500
References: <20171122063250.7674-1-jcd@tribudubois.net>
	<3d54e331-07f3-dd43-e2b6-aded54ccaf6f@ilande.co.uk>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <3a7ef463-a4ff-bc54-e250-705660bd078a@tribudubois.net>
Date: Mon, 27 Nov 2017 21:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <3d54e331-07f3-dd43-e2b6-aded54ccaf6f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Remove MemoryRegionSection check code from
 sparc_cpu_get_phys_page_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

Hello Mark,

Did you get any second opinion on this?

Also do you need me to resend the patch with the SPARC keyword in the 
patch subject line?

Regards

JC

Le 23/11/2017 à 20:49, Mark Cave-Ayland a écrit :
> On 22/11/17 06:32, Jean-Christophe Dubois wrote:
>
>> This code is preventing the MMU debug code from displaying virtual
>> mappings of IO devices (anything that is not located in the RAM).
>>
>> Before this patch, Qemu would output 0xffffffffffffffff (-1) as the
>> physical address corresponding to a IO device virtual address.
>>
>> With this patch the intended physical adresse is displayed.
>>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>> ---
>>   target/sparc/mmu_helper.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
>> index d5b6c1e48c..f2d2250e7a 100644
>> --- a/target/sparc/mmu_helper.c
>> +++ b/target/sparc/mmu_helper.c
>> @@ -857,18 +857,12 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>       CPUSPARCState *env = &cpu->env;
>>       hwaddr phys_addr;
>>       int mmu_idx = cpu_mmu_index(env, false);
>> -    MemoryRegionSection section;
>>   
>>       if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 2, mmu_idx) != 0) {
>>           if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 0, mmu_idx) != 0) {
>>               return -1;
>>           }
>>       }
>> -    section = memory_region_find(get_system_memory(), phys_addr, 1);
>> -    memory_region_unref(section.mr);
>> -    if (!int128_nz(section.size)) {
>> -        return -1;
>> -    }
>>       return phys_addr;
>>   }
>>   #endif
> Hi Jean-Christophe,
>
> Thanks for looking into this and providing the patch. I asked on IRC to
> see if anyone could explain what this code was trying to do and Peter
> suggested that it could be related to when cpu_get_phys_page_debug()
> used to have to be more resilient to bad conditions such as missing
> mappings.
>
> Tracing through the git log I see it was introduced as part of commit
> cc4aa830 "sparc: avoid cpu_get_physical_page_desc()":
>
> diff --git a/target-sparc/mmu_helper.c b/target-sparc/mmu_helper.c
> index 8cdc224..bdff1c3 100644
> --- a/target-sparc/mmu_helper.c
> +++ b/target-sparc/mmu_helper.c
> @@ -19,6 +19,7 @@
>
>   #include "cpu.h"
>   #include "trace.h"
> +#include "exec-memory.h"
>
>   /* Sparc MMU emulation */
>
> @@ -839,13 +840,15 @@ target_phys_addr_t
> cpu_get_phys_page_debug(CPUState *env, target_ulong addr)
>   {
>       target_phys_addr_t phys_addr;
>       int mmu_idx = cpu_mmu_index(env);
> +    MemoryRegionSection section;
>
>       if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 2, mmu_idx) != 0) {
>           if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 0, mmu_idx)
> != 0) {
>               return -1;
>           }
>       }
> -    if (cpu_get_physical_page_desc(phys_addr) == IO_MEM_UNASSIGNED) {
> +    section = memory_region_find(get_system_memory(), phys_addr, 1);
> +    if (!section.size) {
>           return -1;
>       }
>       return phys_addr;
>
> and cpu_get_physical_page_desc() used to look like this:
>
> /* XXX: temporary until new memory mapping API */
> uint32_t cpu_get_physical_page_desc(target_phys_addr_t addr)
> {
>      PhysPageDesc *p;
>
>      p = phys_page_find(addr >> TARGET_PAGE_BITS);
>      if (!p)
>          return IO_MEM_UNASSIGNED;
>      return p->phys_offset;
> }
>
> i.e. IO_MEM_UNASSIGNED indicates there is no physical mapping for this
> virtual address.
>
> Now I've had a look at some of the other *_get_phys_page_debug()
> functions and I don't see any similar logic (and in fact the git log for
> PPC details the simplification of the ppc_*_get_phys_page_debug()
> functions by removing permission checks etc.) so I'm inclined to think
> that commit cc4aa830 did the wrong thing by restricting lookups to the
> system memory address space and the patch is correct.
>
> I'd like a second opinion if possible before queuing this patch as I'm
> not overly familiar with this area of the code (and what the exact
> behaviour for debug MMIO accesses should be), but otherwise it looks
> good - the only part missing is a "sparc: " prefix to the subject line.
>
>
> ATB,
>
> Mark.
>
>
