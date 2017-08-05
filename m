Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnhA-0003n2-6h
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnh9-00013J-2B
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:16:00 -0400
Date: Sat, 5 Aug 2017 03:15:52 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170805011551.GB4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-4-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501867249-1924-4-git-send-email-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Fri, Aug 04, 2017 at 06:20:44PM +0100, Peter Maydell wrote:
> Call the new cpu_transaction_failed() hook at the places where
> CPU generated code interacts with the memory system:
>  io_readx()
>  io_writex()
>  get_page_addr_code()
> 
> Any access from C code (eg via cpu_physical_memory_rw(),
> address_space_rw(), ld/st_*_phys()) will *not* trigger CPU exceptions
> via cpu_transaction_failed().  Handling for transactions failures for
> this kind of call should be done by using a function which returns a
> MemTxResult and treating the failure case appropriately in the
> calling code.
> 
> In an ideal world we would not generate CPU exceptions for
> instruction fetch failures in get_page_addr_code() but instead wait
> until the code translation process tried a load and it failed;
> however that change would require too great a restructuring and
> redesign to attempt at this point.

You're right but onsidering the lack of models for I caches and
prefetching, I don't think that matters much...

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  softmmu_template.h |  4 ++--
>  accel/tcg/cputlb.c | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/softmmu_template.h b/softmmu_template.h
> index 4a2b665..d756329 100644
> --- a/softmmu_template.h
> +++ b/softmmu_template.h
> @@ -101,7 +101,7 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
>                                                uintptr_t retaddr)
>  {
>      CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
> -    return io_readx(env, iotlbentry, addr, retaddr, DATA_SIZE);
> +    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, DATA_SIZE);
>  }
>  #endif
>  
> @@ -262,7 +262,7 @@ static inline void glue(io_write, SUFFIX)(CPUArchState *env,
>                                            uintptr_t retaddr)
>  {
>      CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
> -    return io_writex(env, iotlbentry, val, addr, retaddr, DATA_SIZE);
> +    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, DATA_SIZE);
>  }
>  
>  void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 85635ae..e72415a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -747,6 +747,7 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
>  }
>  
>  static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> +                         int mmu_idx,
>                           target_ulong addr, uintptr_t retaddr, int size)
>  {
>      CPUState *cpu = ENV_GET_CPU(env);
> @@ -754,6 +755,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      MemoryRegion *mr = iotlb_to_region(cpu, physaddr, iotlbentry->attrs);
>      uint64_t val;
>      bool locked = false;
> +    MemTxResult r;
>  
>      physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc = retaddr;
> @@ -767,7 +769,12 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          qemu_mutex_lock_iothread();
>          locked = true;
>      }
> -    memory_region_dispatch_read(mr, physaddr, &val, size, iotlbentry->attrs);
> +    r = memory_region_dispatch_read(mr, physaddr,
> +                                    &val, size, iotlbentry->attrs);
> +    if (r != MEMTX_OK) {
> +        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_LOAD,
> +                               mmu_idx, iotlbentry->attrs, r, retaddr);
> +    }
>      if (locked) {
>          qemu_mutex_unlock_iothread();
>      }
> @@ -776,6 +783,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>  }
>  
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
>      if (locked) {
>          qemu_mutex_unlock_iothread();
>      }
> @@ -845,6 +859,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>      MemoryRegion *mr;
>      CPUState *cpu = ENV_GET_CPU(env);
>      CPUIOTLBEntry *iotlbentry;
> +    hwaddr physaddr;
>  
>      index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx = cpu_mmu_index(env, true);
> @@ -868,6 +883,19 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>          }
>          qemu_mutex_unlock_iothread();
>  
> +        /* Give the new-style cpu_transaction_failed() hook first chance
> +         * to handle this.
> +         * This is not the ideal place to detect and generate CPU
> +         * exceptions for instruction fetch failure (for instance
> +         * we don't know the length of the access that the CPU would
> +         * use, and it would be better to go ahead and try the access
> +         * and use the MemTXResult it produced). However it is the
> +         * simplest place we have currently available for the check.
> +         */
> +        physaddr = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> +        cpu_transaction_failed(cpu, physaddr, addr, 0, MMU_INST_FETCH, mmu_idx,
> +                               iotlbentry->attrs, MEMTX_DECODE_ERROR, 0);
> +
>          cpu_unassigned_access(cpu, addr, false, true, 0, 4);
>          /* The CPU's unassigned access hook might have longjumped out
>           * with an exception. If it didn't (or there was no hook) then
> -- 
> 2.7.4
> 
> 
