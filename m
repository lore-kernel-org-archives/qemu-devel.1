Received: from eggs.gnu.org ([209.51.188.92]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqRD-0003mh-Gf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqRA-0003NZ-Jp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:37:42 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmqR7-0003GW-Oa
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:37:39 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so3737110ply.13
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 17:37:32 -0800 (PST)
References: <20190118140758.829-1-farosas@linux.ibm.com>
	<20190118140758.829-7-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8851177d-cb95-e9c5-beb8-1a7894efd6e0@ozlabs.ru>
Date: Fri, 25 Jan 2019 12:37:23 +1100
MIME-Version: 1.0
In-Reply-To: <20190118140758.829-7-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 6/7] target/ppc: Refactor
 kvm_handle_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com



On 19/01/2019 01:07, Fabiano Rosas wrote:
> There are four scenarios being handled in this function:
> 
> - single stepping
> - hardware breakpoints
> - software breakpoints
> - fallback (no debug supported)
> 
> A future patch will add code to handle specific single step and
> software breakpoints cases so let's split each scenario into its own
> function now to avoid hurting readability.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  target/ppc/kvm.c | 86 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 96a5895792..c27190d7fb 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1621,52 +1621,66 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>      return handle;
>  }
>  
> +static int kvm_handle_singlestep(void)
> +{
> +    return 1;
> +}
> +
> +static int kvm_handle_sw_breakpoint(void)
> +{
> +    return 1;
> +}
> +
>  static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>  {
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
>      struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
> -    int handle = 0;
>  
>      if (cs->singlestep_enabled) {
> -        handle = 1;
> -    } else if (arch_info->status) {
> -        handle = kvm_handle_hw_breakpoint(cs, arch_info);
> -    } else if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> -        handle = 1;
> -    } else {
> -        /* QEMU is not able to handle debug exception, so inject
> -         * program exception to guest;
> -         * Yes program exception NOT debug exception !!
> -         * When QEMU is using debug resources then debug exception must
> -         * be always set. To achieve this we set MSR_DE and also set
> -         * MSRP_DEP so guest cannot change MSR_DE.
> -         * When emulating debug resource for guest we want guest
> -         * to control MSR_DE (enable/disable debug interrupt on need).
> -         * Supporting both configurations are NOT possible.
> -         * So the result is that we cannot share debug resources
> -         * between QEMU and Guest on BOOKE architecture.
> -         * In the current design QEMU gets the priority over guest,
> -         * this means that if QEMU is using debug resources then guest
> -         * cannot use them;
> -         * For software breakpoint QEMU uses a privileged instruction;
> -         * So there cannot be any reason that we are here for guest
> -         * set debug exception, only possibility is guest executed a
> -         * privileged / illegal instruction and that's why we are
> -         * injecting a program interrupt.
> -         */
> +        return kvm_handle_singlestep();
> +    }
> +
> +    if (arch_info->status) {
> +        return kvm_handle_hw_breakpoint(cs, arch_info);
> +    }
>  
> -        cpu_synchronize_state(cs);
> -        /* env->nip is PC, so increment this by 4 to use
> -         * ppc_cpu_do_interrupt(), which set srr0 = env->nip - 4.
> -         */
> -        env->nip += 4;
> -        cs->exception_index = POWERPC_EXCP_PROGRAM;
> -        env->error_code = POWERPC_EXCP_INVAL;
> -        ppc_cpu_do_interrupt(cs);
> +    if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> +        return kvm_handle_sw_breakpoint();
>      }
>  
> -    return handle;
> +    /*
> +     * QEMU is not able to handle debug exception, so inject
> +     * program exception to guest;
> +     * Yes program exception NOT debug exception !!
> +     * When QEMU is using debug resources then debug exception must
> +     * be always set. To achieve this we set MSR_DE and also set
> +     * MSRP_DEP so guest cannot change MSR_DE.
> +     * When emulating debug resource for guest we want guest
> +     * to control MSR_DE (enable/disable debug interrupt on need).
> +     * Supporting both configurations are NOT possible.
> +     * So the result is that we cannot share debug resources
> +     * between QEMU and Guest on BOOKE architecture.
> +     * In the current design QEMU gets the priority over guest,
> +     * this means that if QEMU is using debug resources then guest
> +     * cannot use them;
> +     * For software breakpoint QEMU uses a privileged instruction;
> +     * So there cannot be any reason that we are here for guest
> +     * set debug exception, only possibility is guest executed a
> +     * privileged / illegal instruction and that's why we are
> +     * injecting a program interrupt.
> +     */
> +    cpu_synchronize_state(cs);
> +    /*
> +     * env->nip is PC, so increment this by 4 to use
> +     * ppc_cpu_do_interrupt(), which set srr0 = env->nip - 4.
> +     */
> +    env->nip += 4;
> +    cs->exception_index = POWERPC_EXCP_PROGRAM;
> +    env->error_code = POWERPC_EXCP_INVAL;
> +    ppc_cpu_do_interrupt(cs);
> +
> +    return 0;
>  }
>  
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> 

-- 
Alexey
