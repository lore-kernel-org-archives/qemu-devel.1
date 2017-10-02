Received: from eggs.gnu.org ([2001:4830:134:3::10]:38369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1DC-0001r1-JC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1D9-0001Bl-BC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:46 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1D9-0001Bc-6l
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:56:43 -0400
Received: by mail-qk0-x244.google.com with SMTP id w63so2329317qkd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 06:56:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0195edb6-f0bf-1486-1e29-76efc8cf8f78@amsat.org>
Date: Mon, 2 Oct 2017 10:56:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170928165414.7339-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 7/9] ppc: Support Capstone in
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   disas.c                     | 4 ++++
>   target/ppc/translate_init.c | 6 ++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/disas.c b/disas.c
> index 23c4742f8d..0d212f2ac5 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -449,6 +449,10 @@ void disas(FILE *out, void *code, unsigned long size)
>   #elif defined(_ARCH_PPC)
>       s.info.disassembler_options = (char *)"any";
>       print_insn = print_insn_ppc;
> +    s.info.cap_arch = CS_ARCH_PPC;
> +# ifdef _ARCH_PPC64
> +    s.info.cap_mode = CS_MODE_64;
> +# endif
>   #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
>       print_insn = print_insn_arm_a64;
>       s.info.cap_arch = CS_ARCH_ARM64;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 2863e2c0b0..69a9485f66 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -35,6 +35,7 @@
>   #include "mmu-book3s-v3.h"
>   #include "sysemu/qtest.h"
>   #include "qemu/cutils.h"
> +#include "disas/capstone.h"
>   
>   //#define PPC_DUMP_CPU
>   //#define PPC_DEBUG_SPR
> @@ -10699,6 +10700,11 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>       }
>       info->disassembler_options = (char *)"any";
>       info->print_insn = print_insn_ppc;
> +
> +    info->cap_arch = CS_ARCH_PPC;
> +#ifdef TARGET_PPC64
> +    info->cap_mode = CS_MODE_64;
> +#endif
>   }
>   
>   static Property ppc_cpu_properties[] = {
> 
