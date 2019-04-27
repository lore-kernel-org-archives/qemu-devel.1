Received: from eggs.gnu.org ([209.51.188.92]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKMzm-0006MQ-OO
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKMzl-0006Ba-Ib
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKMzl-0006AA-9x
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so7416128wmh.2
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 06:03:56 -0700 (PDT)
References: <20190427005124.12756-1-richard.henderson@linaro.org>
	<20190427005124.12756-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64849861-0d2f-efbe-85ea-2b1076d8d8d9@redhat.com>
Date: Sat, 27 Apr 2019 15:03:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190427005124.12756-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/alpha: Clean up
 alpha_cpu_dump_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 4/27/19 2:51 AM, Richard Henderson wrote:
> Drop the "RI" and "FIR" prefixes; use only the normal linux names.
> Add the FPCR to the dump.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/helper.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 7201576aae..31de9593b6 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -429,32 +429,33 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  
>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  {
> -    static const char *linux_reg_names[] = {
> -        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
> -        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
> -        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
> -        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
> +    static const char linux_reg_names[31][4] = {
> +        "v0",  "t0",  "t1", "t2",  "t3", "t4", "t5", "t6",
> +        "t7",  "s0",  "s1", "s2",  "s3", "s4", "s5", "fp",
> +        "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
> +        "t10", "t11", "ra", "t12", "at", "gp", "sp"
>      };
>      AlphaCPU *cpu = ALPHA_CPU(cs);
>      CPUAlphaState *env = &cpu->env;
>      int i;
>  
> -    qemu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
> +    qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
>                   env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
>      for (i = 0; i < 31; i++) {
> -        qemu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
> +        qemu_fprintf(f, "%-8s" TARGET_FMT_lx "%c",

I often wondered was this useful for (I mean, one would focus on one or
another, but having both displayed was not helpful IMO). Now the output
looks clearer, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                       linux_reg_names[i], cpu_alpha_load_gr(env, i),
>                       (i % 3) == 2 ? '\n' : ' ');
>      }
>  
> -    qemu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
> +    qemu_fprintf(f, "lock_a  " TARGET_FMT_lx " lock_v  " TARGET_FMT_lx "\n",
>                   env->lock_addr, env->lock_value);
>  
>      if (flags & CPU_DUMP_FPU) {
>          for (i = 0; i < 31; i++) {
> -            qemu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
> +            qemu_fprintf(f, "f%-7d%016" PRIx64 "%c", i, env->fir[i],
>                           (i % 3) == 2 ? '\n' : ' ');
>          }
> +        qemu_fprintf(f, "fpcr    %016" PRIx64 "\n", cpu_alpha_load_fpcr(env));
>      }
>      qemu_fprintf(f, "\n");
>  }
> 
