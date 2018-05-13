Received: from eggs.gnu.org ([2001:4830:134:3::10]:42588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfDj-0006ZG-28
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfDi-0006Zn-3T
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:50:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfDh-0006Z9-Uv
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:50:38 -0400
Received: by mail-qk0-x243.google.com with SMTP id 11-v6so7343891qkk.4
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:50:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd368151-e776-1508-16e5-ee49777c779d@amsat.org>
Date: Sat, 12 May 2018 21:50:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/9] target/ppc: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/ppc/translate.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2a4140f420..fd66c80cc7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7048,14 +7048,20 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>      }
>      cpu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
>                  env->reserve_addr);
> -    for (i = 0; i < 32; i++) {
> -        if ((i & (RFPL - 1)) == 0)
> -            cpu_fprintf(f, "FPR%02d", i);
> -        cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
> -        if ((i & (RFPL - 1)) == (RFPL - 1))
> -            cpu_fprintf(f, "\n");
> +
> +    if (flags & CPU_DUMP_FPU) {
> +        for (i = 0; i < 32; i++) {
> +            if ((i & (RFPL - 1)) == 0) {
> +                cpu_fprintf(f, "FPR%02d", i);
> +            }
> +            cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
> +            if ((i & (RFPL - 1)) == (RFPL - 1)) {
> +                cpu_fprintf(f, "\n");
> +            }
> +        }
> +        cpu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
>      }
> -    cpu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
> +
>  #if !defined(CONFIG_USER_ONLY)
>      cpu_fprintf(f, " SRR0 " TARGET_FMT_lx "  SRR1 " TARGET_FMT_lx
>                     "    PVR " TARGET_FMT_lx " VRSAVE " TARGET_FMT_lx "\n",
> 
