Received: from eggs.gnu.org ([2001:4830:134:3::10]:57734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZMju-0002zp-4t
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZMjp-0000zp-6V
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:12:46 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZMjp-0000zB-0J
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:12:41 -0500
Received: by mail-pg0-x243.google.com with SMTP id c194so265907pga.12
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:12:40 -0800 (PST)
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <755a005d-600e-7f39-bd90-314bd970ef8e@linaro.org>
Date: Wed, 10 Jan 2018 12:12:36 -0800
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 01/08/2018 03:10 PM, Laurent Vivier wrote:
> +static int get_physical_address(CPUM68KState *env, hwaddr *physical,
> +                                int *prot, target_ulong address,
> +                                int access_type, target_ulong *page_size)
> +{
> +    M68kCPU *cpu = m68k_env_get_cpu(env);
> +    CPUState *cs = CPU(cpu);
> +    uint32_t page_offset;
> +    uint32_t entry;
> +    uint32_t next;
> +
> +    /* Page Table Root Pointer */
> +    *prot = PAGE_READ | PAGE_WRITE;
> +    if (access_type & ACCESS_CODE) {
> +        *prot |= PAGE_EXEC;
> +    }
> +    if (access_type & ACCESS_SUPER) {
> +        next = env->mmu.srp;
> +    } else {
> +        next = env->mmu.urp;
> +    }
> +
> +    /* Root Index */
> +    entry = M68K_POINTER_BASE(next) | M68K_ROOT_INDEX(address);
> +
> +    next = ldl_phys(cs->as, entry);
> +    if (!M68K_UDT_VALID(next)) {
> +        return -1;
> +    }
> +    if (!(next & M68K_DESC_USED)) {
> +        stl_phys(cs->as, entry, next | M68K_DESC_USED);
> +    }

You may want to add ACCESS_DEBUG or some such so that probes from gdb and the
monitor interface do not alter the cpu state.

> +    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
> +        *page_size = 8192;
> +        page_offset = address & 0x1fff;
> +        *physical = (next & ~0x1fff) + page_offset;
> +    } else {
> +        *page_size = 4096;
> +        page_offset = address & 0x0fff;
> +        *physical = (next & ~0x0fff) + page_offset;
> +    }

So...

> +    if (ret == 0) {
> +        tlb_set_page(cs, address & TARGET_PAGE_MASK,
> +                     physical & TARGET_PAGE_MASK,
> +                     prot, mmu_idx, page_size);

... this is going to go through the tlb_add_large_page path every time, since
both 4K and 8K are larger than the default 1K page size.

Using the large page path by default means that any single-page tlb flush will
quickly devolve to flushing the entire tlb.

Also, using page_size and TARGET_PAGE_MASK looks wrong.  I think you would have
needed address & -page_size.

That said, you may want to compare the performance of passing page_size vs
TARGET_PAGE_SIZE to tlb_set_page.

> +++ b/target/m68k/op_helper.c
> @@ -360,7 +360,50 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>      sp = env->aregs[7];
>  
>      sp &= ~1;
> -    if (cs->exception_index == EXCP_ADDRESS) {
> +    if (cs->exception_index == EXCP_ACCESS) {
> +        static int mmu_fault;
> +        if (mmu_fault) {
> +            cpu_abort(cs, "DOUBLE MMU FAULT\n");
> +        }
> +        mmu_fault = 1;

This variable shouldn't be static -- it should be in CPUM68KState or M68kCPU.


r~
