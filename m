Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAukS-0005G4-Ro
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAukP-0008A3-Tf
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:56:00 -0400
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
	<20170517063547.23876-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7252247d-ce4d-0e7d-7078-5d0d4af2d658@redhat.com>
Date: Wed, 17 May 2017 10:55:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170517063547.23876-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/2] pseries: Split CAS PVR negotiation out
 into a separate function
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
> Guests of the qemu machine type go through a feature negotiation process
> known as "client architecture support" (CAS) during early boot.  This does
> a number of things, one of which is finding a CPU compatibility mode which
> can be supported by both guest and host.
> 
> In fact the CPU negotiation is probably the single most complex part of the
> CAS process, so this splits it out into a helper function.  We've recently
> made some mistakes in maintaining backward compatibility for old machine
> types here.  Splitting this out will also make it easier to fix this.
> 
> This also adds a possibly useful error message if the negotiation fails
> (i.e. if there is CPU mode that's suitable for both guest and host).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0d608d6..007ae8d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1047,19 +1047,13 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
>      }
>  }
>  
> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> -                                                  sPAPRMachineState *spapr,
> -                                                  target_ulong opcode,
> -                                                  target_ulong *args)
> +static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong list,
> +                              Error **errp)
>  {
> -    target_ulong list = ppc64_phys_to_real(args[0]);
> -    target_ulong ov_table;
>      bool explicit_match = false; /* Matched the CPU's real PVR */
>      uint32_t max_compat = cpu->max_compat;
>      uint32_t best_compat = 0;
>      int i;
> -    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> -    bool guest_radix;
>  
>      /*
>       * We scan the supplied table of PVRs looking for two things
> @@ -1090,26 +1084,43 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>          /* We couldn't find a suitable compatibility mode, and either
>           * the guest doesn't support "raw" mode for this CPU, or raw
>           * mode is disabled because a maximum compat mode is set */
> -        return H_HARDWARE;
> +        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS");
> +        return 0;
>      }
>  
>      /* Parsing finished */
>      trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
>  
> -    /* Update CPUs */
> -    if (cpu->compat_pvr != best_compat) {
> -        Error *local_err = NULL;
> +    return best_compat;
> +}
> +
> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> +                                                  sPAPRMachineState *spapr,
> +                                                  target_ulong opcode,
> +                                                  target_ulong *args)
> +{
> +    /* @ov_table points to the first option vector */
> +    target_ulong ov_table = ppc64_phys_to_real(args[0]);
> +    uint32_t cas_pvr;
> +    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> +    bool guest_radix;
> +    Error *local_err = NULL;
>  
> -        ppc_set_compat_all(best_compat, &local_err);
> +    cas_pvr = cas_check_pvr(cpu, ov_table, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_HARDWARE;
> +    }
> +
> +    /* Update CPUs */
> +    if (cpu->compat_pvr != cas_pvr) {
> +        ppc_set_compat_all(cas_pvr, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return H_HARDWARE;
>          }
>      }
>  
> -    /* For the future use: here @ov_table points to the first option vector */
> -    ov_table = list;
> -

I think there is a change here: now ov_table is always
ppc64_phys_to_real(args[0]), as it is not updated by cas_check() as list
was by h_client_architecture_support().

>      ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
>      ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
>      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {

Laurent
