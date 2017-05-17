Received: from eggs.gnu.org ([2001:4830:134:3::10]:38273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAv9O-0003jX-VP
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAv9L-000863-Iu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:21:46 -0400
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
	<20170517063547.23876-3-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6aada930-70e9-e82d-0b1a-174629b27dc6@redhat.com>
Date: Wed, 17 May 2017 11:21:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170517063547.23876-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/2] pseries: Restore PVR negotiation logic
 for pre-2.9 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, abologna@redhat.com, thuth@redhat.com
Cc: mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 17/05/2017 08:35, David Gibson wrote:
> "pseries" guests go through a hypervisor<->guest feature negotiation during
> early boot.  Part of this is finding a CPU compatibility mode which works
> for both.
> 
> In 152ef80 "pseries: Rewrite CAS PVR compatibility logic" this logic was
> changed to strongly prefer architecture defined CPU compatibility modes,
> rather than CPU "raw" modes.  However, this change was made universally,
> which introduces a guest visible change for the previously existing machine
> types (pseries-2.8 and earlier).  That's never supposed to happen.
> 
> This corrects the behaviour, reverting to the old PVR negotiation logic
> for machine types prior to pseries-2.9.
> 
> Fixes: 152ef803ceb1959e2380a1da7736b935b109222e
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c         |  3 ++
>  hw/ppc/spapr_hcall.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a9471b9..913355f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3308,9 +3308,12 @@ static void spapr_machine_2_8_instance_options(MachineState *machine)
>  
>  static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_9_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
>      mc->numa_mem_align_shift = 23;
> +    smc->pre_2_9_cas_pvr = true;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 007ae8d..4937019 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1047,6 +1047,89 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
>      }
>  }
>  
> +/*
> + * Old logic for PVR negotiation, used old <2.9 machine types for
> + * compatibility with old qemu versions
> + */
> +#define get_compat_level(cpuver) (                  \
> +        ((cpuver) == CPU_POWERPC_LOGICAL_2_05) ? 2050 : \
> +        ((cpuver) == CPU_POWERPC_LOGICAL_2_06) ? 2060 :  \
> +        ((cpuver) == CPU_POWERPC_LOGICAL_2_06_PLUS) ? 2061 :    \
> +        ((cpuver) == CPU_POWERPC_LOGICAL_2_07) ? 2070 : 0)
> +
> +static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
> +                                  unsigned max_lvl, unsigned *compat_lvl,
> +                                  unsigned *compat_pvr)
> +{
> +    unsigned lvl = get_compat_level(pvr);
> +    bool is205, is206, is207;
> +
> +    if (!lvl) {
> +        return;
> +    }
> +
> +    /* If it is a logical PVR, try to determine the highest level */
> +    is205 = (pcc->pcr_supported & PCR_COMPAT_2_05) &&
> +        (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_05));
> +    is206 = (pcc->pcr_supported & PCR_COMPAT_2_06) &&
> +        ((lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06)) ||
> +         (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06_PLUS)));
> +    is207 = (pcc->pcr_supported & PCR_COMPAT_2_07) &&
> +        (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_07));
> +
> +    if (is205 || is206 || is207) {
> +        if (!max_lvl) {
> +            /* User did not set the level, choose the highest */
> +            if (*compat_lvl <= lvl) {
> +                *compat_lvl = lvl;
> +                *compat_pvr = pvr;
> +            }
> +        } else if (max_lvl >= lvl) {
> +            /* User chose the level, don't set higher than this */
> +            *compat_lvl = lvl;
> +            *compat_pvr = pvr;
> +        }
> +    }
> +}
> +
> +static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *cpu, target_ulong list,
> +                                      Error **errp)
> +{
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    int counter;
> +    unsigned max_lvl = get_compat_level(cpu->max_compat);
> +    bool cpu_match = false;
> +    unsigned compat_lvl = 0, compat_pvr = 0;
> +
> +    for (counter = 0; counter < 512; ++counter) {
> +        uint32_t pvr, pvr_mask;
> +
> +        pvr_mask = ldl_be_phys(&address_space_memory, list);
> +        pvr = ldl_be_phys(&address_space_memory, list + 4);
> +        list += 8;
> +
> +        if (~pvr_mask & pvr) {
> +            break; /* Terminator record */
> +        }
> +
> +        trace_spapr_cas_pvr_try(pvr);
> +        if (!max_lvl &&
> +            ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask))) {
> +            cpu_match = true;
> +            compat_pvr = 0;
> +        } else if (pvr == cpu->compat_pvr) {
> +            cpu_match = true;
> +            compat_pvr = cpu->compat_pvr;
> +        } else if (!cpu_match) {
> +            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compat_pvr);
> +        }
> +    }
> +
> +    trace_spapr_cas_pvr(cpu->compat_pvr, cpu_match, compat_pvr);

Perhaps you can add a new function or a parameter to show which path
(pre_2_9 or not) we use to compute the CAS PVR?

anyway:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Laurent
