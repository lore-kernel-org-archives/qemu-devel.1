Received: from eggs.gnu.org ([2001:4830:134:3::10]:54416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdZ-0002yI-BF
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdU-0008Mz-Ej
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdU-0008Mf-9p
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so7960915qke.0
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 09:31:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-5-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2c7c7f9-5ad7-5944-573d-972c1c54f5c7@amsat.org>
Date: Sat, 8 Jul 2017 13:31:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-5-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/27] target/sh4: Keep env->flags clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, laurent@vivier.eu, aurelien@aurel32.net, glaubitz@debian.org

On 07/06/2017 11:20 PM, Richard Henderson wrote:
> If we mask off any out-of-band bits before we assign to the
> variable, then we don't need to clean it up when reading.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sh4/cpu.h | 2 +-
>   target/sh4/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 240ed36..6d179a7 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -391,7 +391,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>   {
>       *pc = env->pc;
>       *cs_base = 0;
> -    *flags = (env->flags & TB_FLAG_ENVFLAGS_MASK) /* Bits  0-2 */
> +    *flags = env->flags                                        /* Bits  0-2 */
>               | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>               | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>               | (env->sr & (1u << SR_FD))                        /* Bit 15 */
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 9da7e1e..8536f6d 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -39,7 +39,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
>       SuperHCPU *cpu = SUPERH_CPU(cs);
>   
>       cpu->env.pc = tb->pc;
> -    cpu->env.flags = tb->flags;
> +    cpu->env.flags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
>   }
>   
>   static bool superh_cpu_has_work(CPUState *cs)
> 
