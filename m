Received: from eggs.gnu.org ([2001:4830:134:3::10]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnYE-0007qw-50
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnY7-0000q7-G2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:06:43 -0400
Date: Sat, 5 Aug 2017 03:06:22 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170805010622.GZ4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/8] cpu: Define new
 cpu_transaction_failed() hook
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

On Fri, Aug 04, 2017 at 06:20:43PM +0100, Peter Maydell wrote:
> Currently we have a rather half-baked setup for allowing CPUs to
> generate exceptions on accesses to invalid memory: the CPU has a
> cpu_unassigned_access() hook which the memory system calls in
> unassigned_mem_write() and unassigned_mem_read() if the current_cpu
> pointer is non-NULL.  This was originally designed before we
> implemented the MemTxResult type that allows memory operations to
> report a success or failure code, which is why the hook is called
> right at the bottom of the memory system.  The major problem with
> this is that it means that the hook can be called even when the
> access was not actually done by the CPU: for instance if the CPU
> writes to a DMA engine register which causes the DMA engine to begin
> a transaction which has been set up by the guest to operate on
> invalid memory then this will casue the CPU to take an exception
> incorrectly.  Another minor problem is that currently if a device
> returns a transaction error then this won't turn into a CPU exception
> at all.
> 
> The right way to do this is to have allow the CPU to respond
> to memory system transaction failures at the point where the
> CPU specific code calls into the memory system.
> 
> Define a new QOM CPU method and utility function
> cpu_transaction_failed() which is called in these cases.
> The functionality here overlaps with the existing
> cpu_unassigned_access() because individual target CPUs will
> need some work to convert them to the new system. When this
> transition is complete we can remove the old cpu_unassigned_access()
> code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> ---
>  include/qom/cpu.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 25eefea..fc54d55 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -85,8 +85,10 @@ struct TranslationBlock;
>   * @has_work: Callback for checking if there is work to do.
>   * @do_interrupt: Callback for interrupt handling.
>   * @do_unassigned_access: Callback for unassigned access handling.
> + * (this is deprecated: new targets should use do_transaction_failed instead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
>   * the target defines #ALIGNED_ONLY.
> + * @do_transaction_failed: Callback for handling failed memory transactions

Looks OK but I wonder if there you might want to clarify that this is a
bus/slave failure and not a failure within the CPU (e.g not an MMU fault).

Anyway:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



>   * @virtio_is_big_endian: Callback to return %true if a CPU which supports
>   * runtime configurable endianness is currently big-endian. Non-configurable
>   * CPUs can use the default implementation of this method. This method should
> @@ -153,6 +155,10 @@ typedef struct CPUClass {
>      void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr);
> +    void (*do_transaction_failed)(CPUState *cpu, hwaddr physaddr, vaddr addr,
> +                                  unsigned size, MMUAccessType access_type,
> +                                  int mmu_idx, MemTxAttrs attrs,
> +                                  MemTxResult response, uintptr_t retaddr);
>      bool (*virtio_is_big_endian)(CPUState *cpu);
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                             uint8_t *buf, int len, bool is_write);
> @@ -837,6 +843,21 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>  
>      cc->do_unaligned_access(cpu, addr, access_type, mmu_idx, retaddr);
>  }
> +
> +static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
> +                                          vaddr addr, unsigned size,
> +                                          MMUAccessType access_type,
> +                                          int mmu_idx, MemTxAttrs attrs,
> +                                          MemTxResult response,
> +                                          uintptr_t retaddr)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +
> +    if (cc->do_transaction_failed) {
> +        cc->do_transaction_failed(cpu, physaddr, addr, size, access_type,
> +                                  mmu_idx, attrs, response, retaddr);
> +    }
> +}
>  #endif
>  
>  #endif /* NEED_CPU_H */
> -- 
> 2.7.4
> 
> 
