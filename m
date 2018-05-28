Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN6u4-0007wx-GQ
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN6u1-00008e-Bd
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:24:52 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:33722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN6u1-00008U-5m
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:24:49 -0400
Received: by mail-qt0-x22a.google.com with SMTP id e8-v6so13228116qth.0
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 18:24:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <32c7d281-7129-06a1-2dee-8f025d3a8d8b@amsat.org>
Date: Sun, 27 May 2018 22:24:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180527141324.11937-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/20] target/openrisc: Log interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 05/27/2018 11:13 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/interrupt.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index e28042856a..138ad17f00 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -32,6 +32,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>  #ifndef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = OPENRISC_CPU(cs);
>      CPUOpenRISCState *env = &cpu->env;
> +    int exception = cs->exception_index;
>  
>      env->epcr = env->pc;
>      if (env->dflag) {
> @@ -41,12 +42,12 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>      } else {
>          env->sr &= ~SR_DSX;
>      }
> -    if (cs->exception_index == EXCP_SYSCALL) {
> +    if (exception == EXCP_SYSCALL) {
>          env->epcr += 4;
>      }
>      /* When we have an illegal instruction the error effective address
>         shall be set to the illegal instruction address.  */
> -    if (cs->exception_index == EXCP_ILLEGAL) {
> +    if (exception == EXCP_ILLEGAL) {
>          env->eear = env->pc;
>      }
>  
> @@ -60,8 +61,27 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>      env->pmr &= ~PMR_SME;
>      env->lock_addr = -1;
>  
> -    if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
> -        hwaddr vect_pc = cs->exception_index << 8;
> +    if (exception > 0 && exception < EXCP_NR) {
> +        static const char * const int_name[EXCP_NR] = {
> +            [EXCP_RESET]    = "RESET",
> +            [EXCP_BUSERR]   = "BUSERR (bus error)",
> +            [EXCP_DPF]      = "DFP (data protection fault)",
> +            [EXCP_IPF]      = "IPF (code protection fault)",
> +            [EXCP_TICK]     = "TICK (timer interrupt)",
> +            [EXCP_ALIGN]    = "ALIGN",
> +            [EXCP_ILLEGAL]  = "ILLEGAL",
> +            [EXCP_INT]      = "INT (device interrupt)",
> +            [EXCP_DTLBMISS] = "DTLBMISS (data tlb miss)",
> +            [EXCP_ITLBMISS] = "ITLBMISS (code tlb miss)",
> +            [EXCP_RANGE]    = "RANGE",
> +            [EXCP_SYSCALL]  = "SYSCALL",
> +            [EXCP_FPE]      = "FPE",
> +            [EXCP_TRAP]     = "TRAP",
> +        };
> +
> +        qemu_log_mask(CPU_LOG_INT, "INT: %s\n", int_name[exception]);
> +
> +        hwaddr vect_pc = exception << 8;
>          if (env->cpucfgr & CPUCFGR_EVBARP) {
>              vect_pc |= env->evbar;
>          }
> @@ -70,7 +90,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>          }
>          env->pc = vect_pc;
>      } else {
> -        cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
> +        cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
>      }
>  #endif
>  
> 
