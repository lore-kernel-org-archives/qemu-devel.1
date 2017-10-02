Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uF-0000EP-AI
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uB-0005mt-7K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:11 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uB-0005mh-2X
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:07 -0400
Received: by mail-qk0-x242.google.com with SMTP id w63so2290136qkd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 06:37:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff0e961e-facf-337e-a928-ddd9622649f3@amsat.org>
Date: Mon, 2 Oct 2017 10:37:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170928165414.7339-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] i386: Support Capstone in
 disas_set_info
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 09/28/2017 01:54 PM, Richard Henderson wrote:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

i386, x86_64:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas.c           | 4 ++++
>   target/i386/cpu.c | 7 +++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/disas.c b/disas.c
> index 746d76c07d..1c44514254 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -439,9 +439,13 @@ void disas(FILE *out, void *code, unsigned long size)
>   #elif defined(__i386__)
>       s.info.mach = bfd_mach_i386_i386;
>       print_insn = print_insn_i386;
> +    s.info.cap_arch = CS_ARCH_X86;
> +    s.info.cap_mode = CS_MODE_32;
>   #elif defined(__x86_64__)
>       s.info.mach = bfd_mach_x86_64;
>       print_insn = print_insn_i386;
> +    s.info.cap_arch = CS_ARCH_X86;
> +    s.info.cap_mode = CS_MODE_64;
>   #elif defined(_ARCH_PPC)
>       s.info.disassembler_options = (char *)"any";
>       print_insn = print_insn_ppc;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 13b2f8fbc5..cf890b763b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -51,6 +51,8 @@
>   #include "hw/i386/apic_internal.h"
>   #endif
>   
> +#include "disas/capstone.h"
> +
>   
>   /* Cache topology CPUID constants: */
>   
> @@ -4106,6 +4108,11 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
>                     : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
>                     : bfd_mach_i386_i8086);
>       info->print_insn = print_insn_i386;
> +
> +    info->cap_arch = CS_ARCH_X86;
> +    info->cap_mode = (env->hflags & HF_CS64_MASK ? CS_MODE_64
> +                      : env->hflags & HF_CS32_MASK ? CS_MODE_32
> +                      : CS_MODE_16);
>   }
>   
>   static Property x86_cpu_properties[] = {
> 
