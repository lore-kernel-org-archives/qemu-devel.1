Received: from eggs.gnu.org ([2001:4830:134:3::10]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxJ57-0007dL-5B
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dxJ53-0001NA-7y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:37:21 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:38822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dxJ53-0001FP-0s
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:37:17 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 4B8BC87DCF
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 22:37:07 +0200 (CEST)
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <af263f23-6e0d-49dc-0b48-88e8a7e6b7b7@kaod.org>
Date: Wed, 27 Sep 2017 22:36:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

On 07/17/2017 06:16 AM, Nikunj A Dadhania wrote:
> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
> 
> When reset happens, all the CPUs are in halted state. First CPU is brought out
> of reset and secondary CPUs would be initialized by the guest kernel using a
> rtas call start-cpu.
> 
> However, in case of TCG, decrementer interrupts keep on coming and waking the
> secondary CPUs up.
> 
> These secondary CPUs would see the decrementer interrupt pending, which makes
> cpu::has_work() to bring them out of wait loop and start executing
> tcg_exec_cpu().
> 
> The problem with this is all the CPUs wake up and start booting SLOF image,
> causing the following exception(4 CPUs TCG VM):
> 
> [   81.440850] reboot: Restarting system
> 
> SLOF
> S
> SLOF
> SLOFLOF[0[0m **********************************************************************
> QEMU Starting
>  Build Date = Mar  3 2017 13:29:19
>  FW Version = git-66d250ef0fd06bb8
> [0m **********************************************************************
> QEMU Starting
>  Build Date = Mar  3 2017 13:29:19
>  FW Version = git-66d250ef0fd06bb8
> [0m *************************************m**********[?25l **********************************************************************
> QEMU Starting
>  Build Date = Mar  3 2017 13:29:19
>  FW Version = git-66d250ef0fd06bb8
> ***********************
> QEMU Starting
>  Build Date = Mar  3 2017 13:29:19
>  FW Version = git-66d250ef0fd06bb8
> ERROR: Flatten device tree not available!
> 
>  exception 300
> SRR0 = 00000000000060e4  SRR1 = 800000008000000000000000
> SPRG2 = 0000000000400000  SPRG3 = 0000000000004bd8
> ERROR: Flatten device tree not available!
> 
>  exception 300
> SRR0 = 00000000000060e4  SRR1 = 800000008000000000000000
> SPRG2 = 0000000000400000  SPRG3 = 0000000000004bd8
> 
> During reset, disable decrementer interrupt for secondary CPUs and enable them
> when the secondary CPUs are brought online by rtas start-cpu call.
> 
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 9 +++++++++
>  hw/ppc/spapr_rtas.c     | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..bbfe8c2 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -87,6 +87,15 @@ static void spapr_cpu_reset(void *opaque)
>  
>      env->spr[SPR_HIOR] = 0;
>  
> +    /* Disable DECR for secondary cpus */
> +    if (cs != first_cpu) {
> +        if (env->mmu_model == POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] &= ~LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] &= ~LPCR_P8_PECE3;
> +        }
> +    }
>      /*
>       * This is a hack for the benefit of KVM PR - it abuses the SDR1
>       * slot in kvm_sregs to communicate the userspace address of the
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 94a2799..4623d1d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -174,6 +174,14 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>          kvm_cpu_synchronize_state(cs);
>  
>          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +
> +        /* Enable DECR interrupt */
> +        if (env->mmu_model == POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] |= LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] |= LPCR_P8_PECE3;
> +        }
>          env->nip = start;
>          env->gpr[3] = r3;
>          cs->halted = 0;


you should also disable the decrementer in the stop-cpu call
when a cpu is hot unplugged.

One thing I don't explain is why the decrementer interrupt 
does not wake up the cpu after being  hot unplugged. I am not 
sure the code doing :

	env->msr = 0;

is responsible of this behavior. 

With the xive patchset, I am having issues in that area. 
the decrementer wakes up the cpu just after hot unplugged
and I need to set the LPCR to disable it. 

I wonder why XICS is immune to that. 

C.
