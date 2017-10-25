Received: from eggs.gnu.org ([2001:4830:134:3::10]:57282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lj5-0000Tf-1E
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lj1-0003VK-TN
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:28:07 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lj1-0003Un-OU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:28:03 -0400
Received: by mail-qk0-x242.google.com with SMTP id q83so30450759qke.6
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 06:28:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
	<20171022004621.28372-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0940372e-9d61-a1a3-e05c-7bbd89941aae@amsat.org>
Date: Wed, 25 Oct 2017 10:27:37 -0300
MIME-Version: 1.0
In-Reply-To: <20171022004621.28372-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 04/11] target/arm: Don't set
 INSN_ARM_BE32 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Hi Richard,

On 10/21/2017 09:46 PM, Richard Henderson wrote:
> This matches translator behaviour in arm_lduw_code.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1724485
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 82dad0b721..a92d86faa0 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -477,6 +477,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      ARMCPU *ac = ARM_CPU(cpu);
>      CPUARMState *env = &ac->env;
> +    bool sctlr_b;
>  
>      if (is_a64(env)) {
>          /* We might not be compiled with the A64 disassembler
> @@ -491,7 +492,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>      } else {
>          info->print_insn = print_insn_arm;
>      }
> -    if (bswap_code(arm_sctlr_b(env))) {
> +
> +    sctlr_b = arm_sctlr_b(env);
> +    if (bswap_code(sctlr_b)) {
>  #ifdef TARGET_WORDS_BIGENDIAN
>          info->endian = BFD_ENDIAN_LITTLE;
>  #else
> @@ -499,9 +502,11 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  #endif
>      }
>      info->flags &= ~INSN_ARM_BE32;
> -    if (arm_sctlr_b(env)) {
> +#ifndef CONFIG_USER_ONLY
> +    if (sctlr_b) {

Even though I could test the whole series, I couldn't hand-test this
particular case yet.

Not a big deal anyway ;)

>          info->flags |= INSN_ARM_BE32;
>      }
> +#endif
>  }
