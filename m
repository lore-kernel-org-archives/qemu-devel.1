Received: from eggs.gnu.org ([2001:4830:134:3::10]:35454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSLkm-0006Qt-0l
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSLkh-0001iU-11
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:23 -0400
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <de2b65ba-ba93-258c-b280-d7c0b2470a20@redhat.com>
Date: Tue, 4 Jul 2017 13:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170704110126.26806-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>

On 04.07.2017 13:01, Laurent Vivier wrote:
> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> disables compatibility mode for POWER9 DD1 to allow to
> boot on POWER9 DD1 host with KVM.
> 
> As the workaround has been added in kvmppc_host_cpu_class_init(),
> it applies only on CPU created with "-cpu host".
> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> host, this patch moves the workaround from kvmppc_host_cpu_class_init()
> to init_proc_POWER9().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  target/ppc/kvm.c            | 11 -----------
>  target/ppc/translate_init.c | 15 ++++++++++++++-
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f2f7c53..9d76817 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2381,17 +2381,6 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>  
>  #if defined(TARGET_PPC64)
>      pcc->radix_page_info = kvm_get_radix_page_info();
> -
> -    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
> -        /*
> -         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> -         * compliant.  More importantly, advertising ISA 3.00
> -         * architected mode may prevent guests from activating
> -         * necessary DD1 workarounds.
> -         */
> -        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> -                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> -    }
>  #endif /* defined(TARGET_PPC64) */
>  }
>  
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 783bf98..a41fe66 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8811,6 +8811,8 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
>  
>  static void init_proc_POWER9(CPUPPCState *env)
>  {
> +    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      /* Common Registers */
>      init_proc_book3s_common(env);
>      gen_spr_book3s_207_dbg(env);
> @@ -8848,7 +8850,18 @@ static void init_proc_POWER9(CPUPPCState *env)
>  
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER8(env);
> -    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> +    ppcPOWER7_irq_init(cpu);
> +
> +    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
> +        /*
> +         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> +         * compliant.  More importantly, advertising ISA 3.00
> +         * architected mode may prevent guests from activating
> +         * necessary DD1 workarounds.
> +         */
> +        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> +                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> +    }
>  }
>  
>  static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
