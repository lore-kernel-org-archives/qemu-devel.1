Received: from eggs.gnu.org ([2001:4830:134:3::10]:46330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ea4Ld-00070Z-QW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ea4LY-0008LV-U4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:46:37 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:57476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ea4LY-0008K9-JM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:46:32 -0500
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-3-laurent@vivier.eu>
	<755a005d-600e-7f39-bd90-314bd970ef8e@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <881a5160-2803-5418-9b68-7acdf69c778f@vivier.eu>
Date: Fri, 12 Jan 2018 19:46:29 +0100
MIME-Version: 1.0
In-Reply-To: <755a005d-600e-7f39-bd90-314bd970ef8e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 10/01/2018 à 21:12, Richard Henderson a écrit :
> On 01/08/2018 03:10 PM, Laurent Vivier wrote:
>> +static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>> +                                int *prot, target_ulong address,
>> +                                int access_type, target_ulong *page_size)
...
>> +    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
>> +        *page_size = 8192;
>> +        page_offset = address & 0x1fff;
>> +        *physical = (next & ~0x1fff) + page_offset;
>> +    } else {
>> +        *page_size = 4096;
>> +        page_offset = address & 0x0fff;
>> +        *physical = (next & ~0x0fff) + page_offset;
>> +    }
> 
> So...
> 
>> +    if (ret == 0) {
>> +        tlb_set_page(cs, address & TARGET_PAGE_MASK,
>> +                     physical & TARGET_PAGE_MASK,
>> +                     prot, mmu_idx, page_size);
> 
> ... this is going to go through the tlb_add_large_page path every time, since
> both 4K and 8K are larger than the default 1K page size.
> 
> Using the large page path by default means that any single-page tlb flush will
> quickly devolve to flushing the entire tlb.
> 
> Also, using page_size and TARGET_PAGE_MASK looks wrong.  I think you would have
> needed address & -page_size.
> 
> That said, you may want to compare the performance of passing page_size vs
> TARGET_PAGE_SIZE to tlb_set_page.

I've found several examples using TARGET_PAGE_MASK and page_size [1], so
I think we can use the mix of them, but I'm going to update
TARGET_PAGE_BITS to 12 to avoid to go through the tlb_add_large_page()
function (kernel uses 13 for coldfire or SUN3, and 12 for others).

Thanks,
Laurent

[1]

target/sparc/mmu_helper.c
    211 int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int
size, int rw,
    212                                int mmu_idx)
    213 {
...
    221     address &= TARGET_PAGE_MASK;
    222     error_code = get_physical_address(env, &paddr, &prot,
&access_index,
    223                                       address, rw, mmu_idx,
&page_size);
    224     vaddr = address;
    225     if (error_code == 0) {
...
    229         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
    230         return 0;
    231     }

or

target/unicore32/softmmu.c
    218 int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
    219                               int access_type, int mmu_idx)
...
    255     if (ret == 0) {
    256         /* Map a single page.  */
    257         phys_addr &= TARGET_PAGE_MASK;
    258         address &= TARGET_PAGE_MASK;
    259         tlb_set_page(cs, address, phys_addr, prot, mmu_idx,
page_size);
    260         return 0;
    261     }

or

target/xtensa/op_helper.c
     53 void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
     54               MMUAccessType access_type, int mmu_idx, uintptr_t
retaddr)
...
     68         tlb_set_page(cs,
     69                      vaddr & TARGET_PAGE_MASK,
     70                      paddr & TARGET_PAGE_MASK,
     71                      access, mmu_idx, page_size);

or

target/ppc/mmu-hash64.c
    694 int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
    695                                 int rwx, int mmu_idx)
...
    866     tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr &
TARGET_PAGE_MASK,
    867                  prot, mmu_idx, 1ULL << apshift);
