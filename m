Received: from eggs.gnu.org ([2001:4830:134:3::10]:59732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O95-0006nO-JR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O91-00035e-Cr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:38:51 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O91-00034z-8l
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:38:47 -0400
Received: by mail-qk0-x244.google.com with SMTP id f199so12899959qke.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 20:38:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171019212109.11341-1-richard.henderson@linaro.org>
	<20171019212109.11341-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cab48a52-f103-be5f-fae8-2199daf6cc5c@amsat.org>
Date: Fri, 20 Oct 2017 00:38:38 -0300
MIME-Version: 1.0
In-Reply-To: <20171019212109.11341-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Don't set INSN_ARM_BE32
 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/19/2017 06:21 PM, Richard Henderson wrote:
> This matches translator behaviour in arm_lduw_code.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1724485
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index bc9d70df04..a0ed11c9a5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -478,6 +478,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      ARMCPU *ac = ARM_CPU(cpu);
>      CPUARMState *env = &ac->env;
> +    bool sctlr_b;
>  
>      if (is_a64(env)) {
>          /* We might not be compiled with the A64 disassembler
> @@ -506,7 +507,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>          info->cap_arch = CS_ARCH_ARM;
>          info->cap_mode = cap_mode;
>      }
> -    if (bswap_code(arm_sctlr_b(env))) {
> +
> +    sctlr_b = arm_sctlr_b(env);
> +    if (bswap_code(sctlr_b)) {
>  #ifdef TARGET_WORDS_BIGENDIAN
>          info->endian = BFD_ENDIAN_LITTLE;
>  #else
> @@ -514,9 +517,11 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  #endif
>      }
>      info->flags &= ~INSN_ARM_BE32;
> -    if (arm_sctlr_b(env)) {
> +#ifndef CONFIG_USER_ONLY
> +    if (sctlr_b) {
>          info->flags |= INSN_ARM_BE32;
>      }
> +#endif
>  }
>  
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
> 
