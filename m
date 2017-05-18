Received: from eggs.gnu.org ([2001:4830:134:3::10]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBG9s-0002ed-2f
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBG9o-0002Tb-4S
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:47:40 -0400
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
	<20170518054522.13141-4-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <43cf4078-1362-dacd-2d38-461bf1d45aa1@redhat.com>
Date: Thu, 18 May 2017 09:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170518054522.13141-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] pseries: Improve tracing of CPU
 compatibility negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, abologna@redhat.com, thuth@redhat.com
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 18/05/2017 07:45, David Gibson wrote:
> This makes some improvements to the debug tracepoints around the
> negotiation of CPU compatibility mode during CAS.  The traces are
> reorganized to emphasise what the inputs and outputs of the process are,
> then distinguish the internal state of the two possible negotiation paths
> (current and pre-2.8 machine type compatibility).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/ppc/spapr_hcall.c | 14 ++++++++------
>  hw/ppc/trace-events  |  6 ++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index a790da7..cea5d99 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1109,7 +1109,6 @@ static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *cpu, target_ulong *addr,
>              break; /* Terminator record */
>          }
>  
> -        trace_spapr_cas_pvr_try(pvr);
>          if (!max_lvl &&
>              ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask))) {
>              cpu_match = true;
> @@ -1120,10 +1119,10 @@ static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *cpu, target_ulong *addr,
>          } else if (!cpu_match) {
>              cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compat_pvr);
>          }
> +        trace_cas_check_pvr_pre_2_9(pvr, pvr_mask, cpu_match,
> +                                    compat_lvl, compat_pvr);
>      }
>  
> -    trace_spapr_cas_pvr(cpu->compat_pvr, cpu_match, compat_pvr);
> -
>      return compat_pvr;
>  }
>  
> @@ -1158,6 +1157,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
>                  best_compat = pvr;
>              }
>          }
> +        trace_cas_check_pvr(pvr, pvr_mask, explicit_match, best_compat);
>      }
>  
>      if ((best_compat == 0) && (!explicit_match || max_compat)) {
> @@ -1168,9 +1168,6 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
>          return 0;
>      }
>  
> -    /* Parsing finished */
> -    trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
> -
>      return best_compat;
>  }
>  
> @@ -1188,6 +1185,9 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      bool guest_radix;
>      Error *local_err = NULL;
>  
> +    trace_cas_check_pvr_start(cpu->compat_pvr, cpu->max_compat,
> +                              cpu->env.spr[SPR_PVR]);
> +
>      if (smc->pre_2_9_cas_pvr) {
>          cas_pvr = cas_check_pvr_pre_2_9(cpu, &addr, &local_err);
>      } else {
> @@ -1198,6 +1198,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>          return H_HARDWARE;
>      }
>  
> +    trace_cas_check_pvr_complete(cpu->compat_pvr, cas_pvr);
> +
>      /* Update CPUs */
>      if (cpu->compat_pvr != cas_pvr) {
>          ppc_set_compat_all(cas_pvr, &local_err);
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 43d265f..5329740 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -14,8 +14,10 @@ spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld bytes"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
>  
>  # hw/ppc/spapr_hcall.c
> -spapr_cas_pvr_try(uint32_t pvr) "%x"
> -spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%x, explicit_match=%u, new=%x"
> +cas_check_pvr_pre_2_9(uint32_t pvr, uint32_t mask, bool match, unsigned lvl, uint32_t compat_pvr) "0x%08x/0x%08x match=%d lvl=%d compat_pvr=0x%x"
> +cas_check_pvr(uint32_t pvr, uint32_t pvr_mask, bool explicit_match, uint32_t best_compat) "0x%08x/0x%08x explicit_match=%d best_compat=0x%08x"
> +cas_check_pvr_start(uint32_t compat_pvr, uint32_t max_compat, uint32_t phys_pvr) "Initial compat PVR 0x%08x, max compat 0x%08x (real PVR 0x%08x)"
> +cas_check_pvr_complete(uint32_t old_pvr, uint32_t new_pvr) "Compatibility PVR was 0x%08x, now 0x%08x"
>  
>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
> 
