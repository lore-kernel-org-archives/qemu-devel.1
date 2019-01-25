Received: from eggs.gnu.org ([209.51.188.92]:36945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqCm-0007vY-SB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqCk-0005LZ-NS
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmqCk-0005Jt-8D
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id b7so3906253pfi.8
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 17:22:45 -0800 (PST)
References: <20190118140758.829-1-farosas@linux.ibm.com>
	<20190118140758.829-3-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <67f370d6-fc2f-141e-1813-ac14dbb60e10@ozlabs.ru>
Date: Fri, 25 Jan 2019 12:22:34 +1100
MIME-Version: 1.0
In-Reply-To: <20190118140758.829-3-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 2/7] target/ppc: Add
 ppc_get_trace_int_handler_addr
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
> The upcoming single step functionality (KVM HV) needs to write to the
> Trace Interrupt handler's address for its mechanism to work. The
> address is calculated by applying an offset according to the value of
> the Alternate Interrupt Location (AIL) bits in the LPCR register.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/cpu.h         |  1 +
>  target/ppc/excp_helper.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 486abaf99b..2185ef5e67 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1256,6 +1256,7 @@ struct PPCVirtualHypervisorClass {
>      OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
>                       TYPE_PPC_VIRTUAL_HYPERVISOR)
>  
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs);
>  void ppc_cpu_do_interrupt(CPUState *cpu);
>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 337a3ef8bb..5d13d05c3b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -746,6 +746,18 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>      check_tlb_flush(env, false);
>  }
>  
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    int ail;
> +
> +    ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
> +    return env->excp_vectors[POWERPC_EXCP_TRACE] |
> +        ppc_excp_vector_offset(cs, ail);
> +}
> +
> +


Extra empty line.

The entire patch seems to belong to 7/7, it does not make sense on its
own as the helper is not called by anyone and all the files which it is
changing belong to target/ppc/.


>  void ppc_cpu_do_interrupt(CPUState *cs)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> 

-- 
Alexey
