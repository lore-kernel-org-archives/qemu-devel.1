Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWxFj-000627-0G
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWxFf-00062F-U3
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:35:39 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eWxFf-00061S-Od
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:35:35 -0500
Received: by mail-io0-x242.google.com with SMTP id i143so896773ioa.3
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 20:35:35 -0800 (PST)
References: <20180104042405.29773-1-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a624a7c3-3b4f-d5a4-defa-7ceae9db37a7@ozlabs.ru>
Date: Thu, 4 Jan 2018 15:35:28 +1100
MIME-Version: 1.0
In-Reply-To: <20180104042405.29773-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct compatibility mode setting
 for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com
Cc: satheera@in.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/01/18 15:24, David Gibson wrote:
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

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
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
> +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +            return;
> +        }
> +
>          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
>  
>          /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
> 


-- 
Alexey
