Received: from eggs.gnu.org ([208.118.235.92]:36890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ehRPw-0007XR-Ri
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 21:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ehROs-0004Ym-P4
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 21:49:32 -0500
Message-ID: <1517539400.2332.22.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 02 Feb 2018 13:43:20 +1100
In-Reply-To: <20180131082749.1803-4-clg@kaod.org>
References: <20180131082749.1803-1-clg@kaod.org>
	<20180131082749.1803-4-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: generalize check on radix
 when in HV mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 2018-01-31 at 09:27 +0100, Cédric Le Goater wrote:
> On a POWER9 processor, the first doubleword of the PTCR indicates
> whether the partition uses HPT or Radix Trees translation. Use that
> bit to check for radix mode on powernv QEMU machines.

The above isn't quite right.

On a POWER9 processor, the first doubleword of the partition table
entry (as pointed to by the PTCR) indicates whether the host uses HPT
or Radix Tree translation for that partition.

> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  target/ppc/mmu-book3s-v3.c  | 17 ++++++++++++++++-
>  target/ppc/mmu-book3s-v3.h  |  8 +-------
>  target/ppc/mmu-hash64.h     |  1 +
>  target/ppc/mmu_helper.c     |  4 ++--
>  target/ppc/translate_init.c |  2 +-
>  5 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index e7798b3582b0..50b60fca3445 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -24,10 +24,25 @@
>  #include "mmu-book3s-v3.h"
>  #include "mmu-radix64.h"
>  
> +bool ppc64_radix(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env = &cpu->env;
> +
> +    if (msr_hv) {

I would prefer something like:

uint64_t prtbe0 = ldq_phys(...);
return prtbe0 & HR;

> +        return ldq_phys(CPU(cpu)->as, cpu->env.spr[SPR_PTCR] &
> +                        PTCR_PTAB) & PTCR_PTAB_HR;
> +    } else  {
> +        PPCVirtualHypervisorClass *vhc =
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +
> +        return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> +    }
> +}
> +
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx)
>  {
> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +    if (ppc64_radix(cpu)) { /* radix mode */
>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx,
> mmu_idx);
>      } else { /* Guest uses hash */
>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx,
> mmu_idx);
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 56095dab522c..3876cb51b35c 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -37,13 +37,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU
> *cpu)
>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
>  }
>  
> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> -{
> -    PPCVirtualHypervisorClass *vhc =
> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -
> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> -}
> +bool ppc64_radix(PowerPCCPU *cpu);
>  
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx);
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 4dc6b3968ec0..7e2ac64b6eeb 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -106,6 +106,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  /*
>   * Partition table definitions
>   */
> +#define PTCR_PTAB_HR            PPC_BIT(0)            /* 1:Host 

This isn't a bit in the partition table register, it is a bit in the
partition table entry. It should be defined in target/ppc/mmu-book3s-
v3.h as part of "/* Partition Table Entry Fields */"

Also to follow the naming, please call it:
#define PATBE0_HR	PPC_BIT(0)

:)

> Radix 0:HPT   */
>  #define PTCR_PTAB               0x0FFFFFFFFFFFF000ULL /* Partition
> Table Base */
>  #define PTCR_PTAS               0x000000000000001FULL /* Partition
> Table Size */
>  
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b1e660a4d16a..059863b99b2e 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1286,7 +1286,7 @@ void dump_mmu(FILE *f, fprintf_function
> cpu_fprintf, CPUPPCState *env)
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
>      case POWERPC_MMU_VER_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +        if (ppc64_radix(ppc_env_get_cpu(env))) {
>              /* TODO - Unsupported */
>          } else {
>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> @@ -1432,7 +1432,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState
> *cs, vaddr addr)
>      case POWERPC_MMU_VER_2_07:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>      case POWERPC_MMU_VER_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +        if (ppc64_radix(ppc_env_get_cpu(env))) {
>              return ppc_radix64_get_phys_page_debug(cpu, addr);
>          } else {
>              return ppc_hash64_get_phys_page_debug(cpu, addr);
> diff --git a/target/ppc/translate_init.c
> b/target/ppc/translate_init.c
> index a6eaa74244ca..07012ee75e81 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8965,7 +8965,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu,
> PPCVirtualHypervisor *vhyp)
>           * KVM but not under TCG. Update the default LPCR to keep
> new
>           * CPUs in sync when radix is enabled.
>           */
> -        if (ppc64_radix_guest(cpu)) {
> +        if (ppc64_radix(cpu)) {
>              lpcr->default_value |= LPCR_UPRT | LPCR_GTSE;
>          } else {
>              lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
