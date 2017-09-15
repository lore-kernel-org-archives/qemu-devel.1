Received: from eggs.gnu.org ([2001:4830:134:3::10]:44852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsgfM-0003nF-Iy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsgfJ-0004NA-Gl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:47:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsgfJ-0004MP-Bf
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:47:37 -0400
Received: by mail-qt0-x242.google.com with SMTP id f24so733234qte.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:47:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<20170914183516.19537-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ea3d7d9-9839-a904-19cd-3b58f7b5575c@amsat.org>
Date: Thu, 14 Sep 2017 23:47:30 -0300
MIME-Version: 1.0
In-Reply-To: <20170914183516.19537-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] target/mips: Support Capstone in
 disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On 09/14/2017 03:35 PM, Richard Henderson wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.h            |  2 ++
>   target/mips/cpu.c            |  8 --------
>   target/mips/translate_init.c | 36 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 74f6a5b098..dca713825d 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1118,4 +1118,6 @@ static inline void QEMU_NORETURN do_raise_exception(CPUMIPSState *env,
>       do_raise_exception_err(env, exception, 0, pc);
>   }
>   
> +void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info);
> +
>   #endif /* MIPS_CPU_H */
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 1bb66b7a5a..898f1b3759 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -111,14 +111,6 @@ static void mips_cpu_reset(CPUState *s)
>   #endif
>   }
>   
> -static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
> -#ifdef TARGET_WORDS_BIGENDIAN
> -    info->print_insn = print_insn_big_mips;
> -#else
> -    info->print_insn = print_insn_little_mips;
> -#endif
> -}
> -

this clashes with the pending mips-cpu-qomify series, however the 
conflict is benign and easy fixable, I expect your series to enter first.

>   static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
> index 255d25bacd..1d43b3c36d 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -947,3 +947,39 @@ static void msa_reset(CPUMIPSState *env)
>       /* set proper signanling bit meaning ("1" means "quiet") */
>       set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
>   }
> +
> +#include "disas/capstone.h"
> +
> +void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
> +{
> +    MIPSCPU *cpu = MIPS_CPU(s);
> +    CPUMIPSState *env = &cpu->env;
> +    int insn_flags = env->cpu_model->insn_flags;
> +    int cap_mode;

int cap_mode = 0; ?

> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    info->print_insn = print_insn_big_mips;
> +#else
> +    info->print_insn = print_insn_little_mips;
> +#endif
> +
> +    cap_mode = 0;
> +    if (insn_flags & ISA_MIPS3) {
> +        cap_mode |= CS_MODE_MIPS3;
> +    }
> +    if (insn_flags & ISA_MIPS32) {
> +        cap_mode |= CS_MODE_MIPS32;
> +    }
> +    if (insn_flags & ISA_MIPS64) {
> +        cap_mode |= CS_MODE_MIPS64;
> +    }
> +    if (insn_flags & ISA_MIPS32R6) {
> +        cap_mode |= CS_MODE_MIPS32R6;
> +    }

quite an improvement for the MIPS target!

> +#ifdef TARGET_MIPS64
> +    cap_mode |= CS_MODE_MIPSGP64;
> +#endif
> +
> +    info->cap_arch = CS_ARCH_MIPS;
> +    info->cap_mode = cap_mode;
> +}
> 
