Received: from eggs.gnu.org ([2001:4830:134:3::10]:59518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uZ-0000Tj-3q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uV-0005vt-15
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:31 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz0uU-0005vf-TO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:37:26 -0400
Received: by mail-qt0-x244.google.com with SMTP id s18so7234662qta.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 06:37:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <122815c9-5a54-7d6f-58be-ff5e3918a0f6@amsat.org>
Date: Mon, 2 Oct 2017 10:37:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170928165414.7339-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 6/9] arm: Support Capstone in
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
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

aarch32 (not thumb), aarch64 (without switching to aarch32):

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas.c          |  3 +++
>   target/arm/cpu.c | 21 ++++++++++++++++++---
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/disas.c b/disas.c
> index 1c44514254..23c4742f8d 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -451,6 +451,7 @@ void disas(FILE *out, void *code, unsigned long size)
>       print_insn = print_insn_ppc;
>   #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
>       print_insn = print_insn_arm_a64;
> +    s.info.cap_arch = CS_ARCH_ARM64;
>   #elif defined(__alpha__)
>       print_insn = print_insn_alpha;
>   #elif defined(__sparc__)
> @@ -458,6 +459,8 @@ void disas(FILE *out, void *code, unsigned long size)
>       s.info.mach = bfd_mach_sparc_v9b;
>   #elif defined(__arm__)
>       print_insn = print_insn_arm;
> +    s.info.cap_arch = CS_ARCH_ARM;
> +    /* TCG only generates code for arm mode.  */
>   #elif defined(__MIPSEB__)
>       print_insn = print_insn_big_mips;
>   #elif defined(__MIPSEL__)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 4300de66e2..e5f84066b4 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -33,6 +33,7 @@
>   #include "sysemu/sysemu.h"
>   #include "sysemu/hw_accel.h"
>   #include "kvm_arm.h"
> +#include "disas/capstone.h"
>   
>   static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>   {
> @@ -489,10 +490,24 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   #if defined(CONFIG_ARM_A64_DIS)
>           info->print_insn = print_insn_arm_a64;
>   #endif
> -    } else if (env->thumb) {
> -        info->print_insn = print_insn_thumb1;
> +        info->cap_arch = CS_ARCH_ARM64;
>       } else {
> -        info->print_insn = print_insn_arm;
> +        int cap_mode;
> +        if (env->thumb) {
> +            info->print_insn = print_insn_thumb1;
> +            cap_mode = CS_MODE_THUMB;
> +        } else {
> +            info->print_insn = print_insn_arm;
> +            cap_mode = CS_MODE_ARM;
> +        }
> +        if (arm_feature(env, ARM_FEATURE_V8)) {
> +            cap_mode |= CS_MODE_V8;
> +        }
> +        if (arm_feature(env, ARM_FEATURE_M)) {
> +            cap_mode |= CS_MODE_MCLASS;
> +        }
> +        info->cap_arch = CS_ARCH_ARM;
> +        info->cap_mode = cap_mode;
>       }
>       if (bswap_code(arm_sctlr_b(env))) {
>   #ifdef TARGET_WORDS_BIGENDIAN
> 
