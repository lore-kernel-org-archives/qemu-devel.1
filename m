Received: from eggs.gnu.org ([2001:4830:134:3::10]:44678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXQ26-0008Qo-7H
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXQ22-0005qr-7O
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:19:30 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:48008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXQ21-0005ph-Vb
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:19:26 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 413B217F442
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 12:19:24 +0100 (CET)
Date: Fri, 5 Jan 2018 12:19:14 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180105121914.43064fe3@bahia.lan>
In-Reply-To: <20180105033806.14678-1-david@gibson.dropbear.id.au>
References: <20180105033806.14678-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] spapr: Correct compatibility mode
 setting for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, satheera@in.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Fri,  5 Jan 2018 14:38:06 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently the pseries machine sets the compatibility mode for the
> guest's cpus in two places: 1) at machine reset and 2) after CAS
> negotiation.
> 
> This means that if we set or negotiate a compatiblity mode, then
> hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> will incorrectly have the full native features.
> 
> To correct this, we set the compatibility mode on a cpu when it is
> brought online with the 'start-cpu' RTAS call.  Given that we no
> longer need to set the compatibility mode on all CPUs at machine
> reset, so we change that to only set the mode for the boot cpu.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> Changes since v1:
>  * Add an error_report_err() to display and free the error from
>    ppc_set_compat() in rtas_start_cpu().
>  

It looks like this change wasn't committed when git-send-email was
invoked, and you missed Daniel's comment (typo in commit message)
and R-b...

> 
>  hw/ppc/spapr.c      | 2 +-
>  hw/ppc/spapr_rtas.c | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e22888ba06..d1acfe8858 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas = spapr_ovec_new();
>  
> -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
>      }
>  
>      fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 4bb939d3d1..2ed00548c1 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>          CPUState *cs = CPU(cpu);
>          CPUPPCState *env = &cpu->env;
>          PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +        Error *local_err = NULL;
>  
>          if (!cs->halted) {
>              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>           * new cpu enters */
>          kvm_cpu_synchronize_state(cs);
>  
> +        /* Set compatibility mode to match existing cpus */
> +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &local_err);
> +        if (local_err) {

With a call to error_report_err() here, you can add:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +            return;
> +        }
> +
>          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
>  
>          /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
