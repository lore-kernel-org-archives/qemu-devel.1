Received: from eggs.gnu.org ([2001:4830:134:3::10]:56455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePA4q-0002hz-Dr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePA4p-0003Dj-I1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:40:12 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:41465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePA4p-0003CS-Cr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:40:11 -0500
Received: by mail-oi0-x231.google.com with SMTP id t78so1951978oie.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:40:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-4-git-send-email-peter.maydell@linaro.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-4-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 16:39:50 +0000
Message-ID: <CAFEAcA-mOzfHhGt0jXtTVMe4_GGp6bg_SK1R4JBbQxpw2+gokg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/8] cputlb: Support generating
 CPU exceptions on memory transaction failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 4 August 2017 at 18:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> Call the new cpu_transaction_failed() hook at the places where
> CPU generated code interacts with the memory system:
>  io_readx()
>  io_writex()
>  get_page_addr_code()

> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c

>  static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> +                      int mmu_idx,
>                        uint64_t val, target_ulong addr,
>                        uintptr_t retaddr, int size)
>  {
> @@ -783,6 +791,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      hwaddr physaddr = iotlbentry->addr;
>      MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
>      bool locked = false;
> +    MemTxResult r;
>
>      physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
>      if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu->can_do_io) {
> @@ -795,7 +804,12 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          qemu_mutex_lock_iothread();
>          locked = true;
>      }
> -    memory_region_dispatch_write(mr, physaddr, val, size, iotlbentry->attrs);
> +    r = memory_region_dispatch_write(mr, physaddr,
> +                                     val, size, iotlbentry->attrs);
> +    if (r != MEMTX_OK) {
> +        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,
> +                               mmu_idx, iotlbentry->attrs, r, retaddr);
> +    }

I was looking at a bug that involved stepping through this function,
and it turns out that the value in the variable "physaddr" here is
not in fact the physical address of the access. It's just the offset
into the memory region.

This doesn't matter for Arm or Alpha, which don't actually need the
physaddr for reporting the exceptions, and those are the only
current implementations of the transaction_failed hook.
But we should fix this so it doesn't bite us when we do eventually
have a cpu that needs the physaddr...

If we have a CPUIOTLBEntry how do we get back to the physaddr for it?

thanks
-- PMM
