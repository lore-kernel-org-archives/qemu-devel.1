Received: from eggs.gnu.org ([209.51.188.92]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7aW-0002ja-BR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7aS-0004Jh-8z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:49:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7aM-0004Hk-6r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:48:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id w6so8835536otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-33-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:48:35 +0100
Message-ID: <CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 32/36] cpu: Move icount_decr to
 CPUNegativeOffsetState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Mar 2019 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Amusingly, we had already ignored the comment to keep this value at the
> end of CPUState.  This restores the minimum negative offset from TCG_AREG0
> for code generation.
>
> For the couple of uses within qom/cpu.c, add a pointer from the CPUState
> object to the IcountDecr object within CPUNegativeOffsetState.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 45ef41ebb2..032a62672e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -54,7 +54,7 @@ typedef struct SyncClocks {
>  #define MAX_DELAY_PRINT_RATE 2000000000LL
>  #define MAX_NB_PRINTS 100
>
> -static void align_clocks(SyncClocks *sc, const CPUState *cpu)
> +static void align_clocks(SyncClocks *sc, CPUState *cpu)
>  {
>      int64_t cpu_icount;
>
> @@ -62,7 +62,7 @@ static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>          return;
>      }
>
> -    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
> +    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
>      sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
>      sc->last_cpu_icount = cpu_icount;

Why does this require that we remove the 'const' from the cpu
argument to the function ?


> @@ -1404,7 +1405,7 @@ static void process_icount_data(CPUState *cpu)
>          cpu_update_icount(cpu);
>
>          /* Reset the counters */
> -        cpu->icount_decr.u16.low = 0;
> +        cpu_neg(cpu)->icount_decr.u16.low = 0;
>          cpu->icount_extra = 0;
>          cpu->icount_budget = 0;
>


>  int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
> @@ -265,7 +265,7 @@ static void cpu_common_reset(CPUState *cpu)
>      cpu->mem_io_pc = 0;
>      cpu->mem_io_vaddr = 0;
>      cpu->icount_extra = 0;
> -    atomic_set(&cpu->icount_decr.u32, 0);
> +    atomic_set(&cpu->icount_decr_ptr->u32, 0);
>      cpu->can_do_io = 1;
>      cpu->exception_index = -1;
>      cpu->crash_occurred = false;

What determines when we need to access the icount fields
via icount_decr_ptr versus when we can just directly
access icount_decr ?

thanks
-- PMM
