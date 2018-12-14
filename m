Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXax6-0003qt-T8
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXax1-00024e-G6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:03:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:58872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gXax0-0001lN-V6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:03:31 -0500
Message-ID: <0a60912dfd70d652fc48d7b20401499b0bcb2a90.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2018 11:03:17 +1100
In-Reply-To: <20181213235804.14956-3-benh@kernel.crashing.org>
References: <20181213235804.14956-1-benh@kernel.crashing.org>
	<20181213235804.14956-3-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc: Fix radix RC updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 2018-12-14 at 10:58 +1100, Benjamin Herrenschmidt wrote:
> They should be atomic for MTTCG. Note: a real POWER9 core doesn't actually
> implement atomic PTE updates, it always fault for SW to handle it. Only
> the nest MMU (used by some accelerator devices and GPUs) implements
> those HW updates.
> 
> However, the architecture does allow the core to do it, and doing so
> in TCG is faster than letting the guest do it.

Note: ppc hash MMU needs fixes too but of a different nature. I have
some queued up as well, but as-is, they are entangled with other ppc
target fixes, so I'll send them separately via David.

Cheers,
Ben.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  target/ppc/cpu.h         |  1 +
>  target/ppc/mmu-radix64.c | 70 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ab68abe8a2..afdef2af2f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -493,6 +493,7 @@ struct ppc_slb_t {
>  #define DSISR_AMR                0x00200000
>  /* Unsupported Radix Tree Configuration */
>  #define DSISR_R_BADCONFIG        0x00080000
> +#define DSISR_ATOMIC_RC          0x00040000
>  
>  /* SRR1 error code fields */
>  
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index ab76cbc835..dba95aabdc 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -28,6 +28,15 @@
>  #include "mmu-radix64.h"
>  #include "mmu-book3s-v3.h"
>  
> +static inline bool ppc_radix64_hw_rc_updates(CPUPPCState *env)
> +{
> +#ifdef CONFIG_ATOMIC64
> +    return true;
> +#else
> +    return !qemu_tcg_mttcg_enabled();
> +#endif
> +}
> +
>  static bool ppc_radix64_get_fully_qualified_addr(CPUPPCState *env, vaddr eaddr,
>                                                   uint64_t *lpid, uint64_t *pid)
>  {
> @@ -120,11 +129,18 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pte,
>          return true;
>      }
>  
> +    /* Check RC bits if necessary */
> +    if (!ppc_radix64_hw_rc_updates(env)) {
> +        if (!(pte & R_PTE_R) || ((rwx == 1) && !(pte & R_PTE_C))) {
> +            *fault_cause |= DSISR_ATOMIC_RC;
> +            return true;
> +        }
> +    }
> +
>      return false;
>  }
>  
> -static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
> -                               hwaddr pte_addr, int *prot)
> +static uint64_t ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte, hwaddr pte_addr)
>  {
>      CPUState *cs = CPU(cpu);
>      uint64_t npte;
> @@ -133,17 +149,38 @@ static void ppc_radix64_set_rc(PowerPCCPU *cpu, int rwx, uint64_t pte,
>  
>      if (rwx == 1) { /* Store/Write */
>          npte |= R_PTE_C; /* Set change bit */
> -    } else {
> -        /*
> -         * Treat the page as read-only for now, so that a later write
> -         * will pass through this function again to set the C bit.
> -         */
> -        *prot &= ~PAGE_WRITE;
>      }
> +    if (pte == npte) {
> +        return pte;
> +    }
> +
> +#ifdef CONFIG_ATOMIC64
> +    if (qemu_tcg_mttcg_enabled()) {
> +        uint64_t old_be = cpu_to_be32(pte);
> +        uint64_t new_be = cpu_to_be32(npte);
> +        MemTxResult result;
> +        uint64_t old_ret;
> +
> +        old_ret = address_space_cmpxchgq_notdirty(cs->as, pte_addr,
> +                                                  old_be, new_be,
> +                                                  MEMTXATTRS_UNSPECIFIED,
> +                                                  &result);
> +        if (result == MEMTX_OK) {
> +            if (old_ret != old_be && old_ret != new_be) {
> +                return 0;
> +            }
> +            return npte;
> +        }
>  
> -    if (pte ^ npte) { /* If pte has changed then write it back */
> -        stq_phys(cs->as, pte_addr, npte);
> +        /* Do we need to support this case where PTEs aren't in RAM ?
> +         *
> +         * For now fallback to non-atomic case
> +         */
>      }
> +#endif
> +
> +    stq_phys(cs->as, pte_addr, npte);
> +    return npte;
>  }
>  
>  static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
> @@ -234,6 +271,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>  
>      /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
>      page_size = PRTBE_R_GET_RTS(prtbe0);
> + restart:
>      pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>                                  prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
>                                  &raddr, &page_size, &fault_cause, &pte_addr);
> @@ -244,8 +282,16 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>      }
>  
>      /* Update Reference and Change Bits */
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
> -
> +    if (ppc_radix64_hw_rc_updates(env)) {
> +        pte = ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
> +        if (!pte) {
> +            goto restart;
> +        }
> +    }
> +    /* If the page doesn't have C, treat it as read only */
> +    if (!(pte & R_PTE_C)) {
> +        prot &= ~PAGE_WRITE;
> +    }
>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
>                   prot, mmu_idx, 1UL << page_size);
>      return 0;
