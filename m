Received: from eggs.gnu.org ([2001:4830:134:3::10]:43033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHS-000214-Dx
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHM-0000Nl-Lj
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:29 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHM-0000NZ-H5
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id f1-v6so11913106qtj.6
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:54:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <465a2a6f-86b6-e571-6c97-ddd2fd2021fa@amsat.org>
Date: Sat, 12 May 2018 21:54:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/9] target/sparc: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sparc/cpu.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index ff6ed91f9a..0f090ece54 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -647,15 +647,18 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>          }
>      }
>  
> -    for (i = 0; i < TARGET_DPREGS; i++) {
> -        if ((i & 3) == 0) {
> -            cpu_fprintf(f, "%%f%02d: ", i * 2);
> -        }
> -        cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
> -        if ((i & 3) == 3) {
> -            cpu_fprintf(f, "\n");
> +    if (flags & CPU_DUMP_FPU) {
> +        for (i = 0; i < TARGET_DPREGS; i++) {
> +            if ((i & 3) == 0) {
> +                cpu_fprintf(f, "%%f%02d: ", i * 2);
> +            }
> +            cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
> +            if ((i & 3) == 3) {
> +                cpu_fprintf(f, "\n");
> +            }
>          }
>      }
> +
>  #ifdef TARGET_SPARC64
>      cpu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
>                  (unsigned)cpu_get_ccr(env));
> 
