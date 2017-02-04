Received: from eggs.gnu.org ([2001:4830:134:3::10]:50484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cZynU-0002RM-1u
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 06:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1cZynQ-0001XM-Vd
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 06:46:28 -0500
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com
	([104.47.41.44]:47776
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1cZynQ-0001X0-Em
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 06:46:24 -0500
Date: Sat, 4 Feb 2017 12:30:56 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170204113056.GL12995@toto>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-2-git-send-email-fred.konrad@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1486141597-13941-2-git-send-email-fred.konrad@greensocs.com>
Subject: Re: [Qemu-devel] [RFC 1/5] cputlb: cleanup get_page_addr_code to
 use VICTIM_TLB_HIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@xilinx.com, pbonzini@redhat.com, clg@kaod.org, mark.burton@greensocs.com

On Fri, Feb 03, 2017 at 06:06:33PM +0100, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This replaces env1 and page_index variables by env and index
> so we can use VICTIM_TLB_HIT macro later.
>

Hi Fred,

A question, wouldn't it be more readable to add env and index arguments to VICTIM_TLB_HIT?
VICTIM_TLB_HIT could perhaps even be made a static inline?

Cheers,
Edgar


 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  cputlb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/cputlb.c b/cputlb.c
> index 6c39927..665caea 100644
> --- a/cputlb.c
> +++ b/cputlb.c
> @@ -457,21 +457,21 @@ static void report_bad_exec(CPUState *cpu, target_ulong addr)
>   * is actually a ram_addr_t (in system mode; the user mode emulation
>   * version of this function returns a guest virtual address).
>   */
> -tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
> +tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>  {
> -    int mmu_idx, page_index, pd;
> +    int mmu_idx, index, pd;
>      void *p;
>      MemoryRegion *mr;
> -    CPUState *cpu = ENV_GET_CPU(env1);
> +    CPUState *cpu = ENV_GET_CPU(env);
>      CPUIOTLBEntry *iotlbentry;
>  
> -    page_index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> -    mmu_idx = cpu_mmu_index(env1, true);
> -    if (unlikely(env1->tlb_table[mmu_idx][page_index].addr_code !=
> +    index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
> +    mmu_idx = cpu_mmu_index(env, true);
> +    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
>                   (addr & TARGET_PAGE_MASK))) {
> -        cpu_ldub_code(env1, addr);
> +        cpu_ldub_code(env, addr);
>      }
> -    iotlbentry = &env1->iotlb[mmu_idx][page_index];
> +    iotlbentry = &env->iotlb[mmu_idx][index];
>      pd = iotlbentry->addr & ~TARGET_PAGE_MASK;
>      mr = iotlb_to_region(cpu, pd, iotlbentry->attrs);
>      if (memory_region_is_unassigned(mr)) {
> @@ -484,7 +484,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
>              exit(1);
>          }
>      }
> -    p = (void *)((uintptr_t)addr + env1->tlb_table[mmu_idx][page_index].addend);
> +    p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
>      return qemu_ram_addr_from_host_nofail(p);
>  }
>  
> -- 
> 1.8.3.1
> 
