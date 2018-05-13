Received: from eggs.gnu.org ([2001:4830:134:3::10]:42304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfBm-00046u-Ol
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfBj-0005RQ-NQ
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:48:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfBj-0005RE-IW
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:48:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id m16-v6so11865113qtg.13
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:48:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c7f4ada-6b06-6490-56bc-6196e35fe25d@amsat.org>
Date: Sat, 12 May 2018 21:48:31 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/9] target/alpha: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/helper.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 8a6a948572..57e2c212b3 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -442,20 +442,19 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>      cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
>                  env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
>      for (i = 0; i < 31; i++) {
> -        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx " ", i,
> -                    linux_reg_names[i], cpu_alpha_load_gr(env, i));
> -        if ((i % 3) == 2)
> -            cpu_fprintf(f, "\n");
> +        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
> +                    linux_reg_names[i], cpu_alpha_load_gr(env, i),
> +                    (i % 3) == 2 ? '\n' : ' ');
>      }
>  
>      cpu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
>                  env->lock_addr, env->lock_value);
>  
> -    for (i = 0; i < 31; i++) {
> -        cpu_fprintf(f, "FIR%02d    " TARGET_FMT_lx " ", i,
> -                    *((uint64_t *)(&env->fir[i])));
> -        if ((i % 3) == 2)
> -            cpu_fprintf(f, "\n");
> +    if (flags & CPU_DUMP_FPU) {
> +        for (i = 0; i < 31; i++) {
> +            cpu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],

Cleaner :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +                        (i % 3) == 2 ? '\n' : ' ');
> +        }
>      }
>      cpu_fprintf(f, "\n");
>  }
> 
