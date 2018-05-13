Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfFa-00086s-4x
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfFZ-0007v6-6q
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:52:34 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfFZ-0007up-1y
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:52:33 -0400
Received: by mail-qk0-x242.google.com with SMTP id p186-v6so7354322qkd.1
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:52:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33e61f63-e2d4-de07-4fef-2c3037d384e7@amsat.org>
Date: Sat, 12 May 2018 21:52:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/riscv: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/cpu.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e5a56d4e3..4612f324c9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -199,6 +199,10 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
>      int i;
>  
>      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
> +    if (flags & CPU_DUMP_FPU) {
> +        cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "fcsr    ",
> +                    cpu_riscv_get_fcsr(env));
> +    }
>  #ifndef CONFIG_USER_ONLY
>      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> @@ -219,11 +223,13 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
>              cpu_fprintf(f, "\n");
>          }
>      }
> -    for (i = 0; i < 32; i++) {
> -        cpu_fprintf(f, " %s %016" PRIx64,
> -            riscv_fpr_regnames[i], env->fpr[i]);
> -        if ((i & 3) == 3) {
> -            cpu_fprintf(f, "\n");
> +    if (flags & CPU_DUMP_FPU) {
> +        for (i = 0; i < 32; i++) {
> +            cpu_fprintf(f, " %s %016" PRIx64,
> +                riscv_fpr_regnames[i], env->fpr[i]);
> +            if ((i & 3) == 3) {
> +                cpu_fprintf(f, "\n");
> +            }
>          }
>      }
>  }
> 
