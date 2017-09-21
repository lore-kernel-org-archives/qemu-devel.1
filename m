Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dv2mu-0003S1-0F
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dv2mq-0005op-1d
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:49:12 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:53174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dv2mp-0005oI-RQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:49:07 -0400
Received: by mail-wr0-x22b.google.com with SMTP id c23so4762295wrg.9
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 07:49:07 -0700 (PDT)
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170919150313.10833-6-richard.henderson@linaro.org>
Date: Thu, 21 Sep 2017 15:49:09 +0100
Message-ID: <87efr0cdju.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] i386: Support Capstone in
 disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  disas.c           | 4 ++++
>  target/i386/cpu.c | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/disas.c b/disas.c
> index 4dbb492219..42fae735ee 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -439,9 +439,13 @@ void disas(FILE *out, void *code, unsigned long size)
>  #elif defined(__i386__)
>      s.info.mach = bfd_mach_i386_i386;
>      print_insn = print_insn_i386;
> +    s.info.cap_arch = CS_ARCH_X86;
> +    s.info.cap_mode = CS_MODE_32;
>  #elif defined(__x86_64__)
>      s.info.mach = bfd_mach_x86_64;
>      print_insn = print_insn_i386;
> +    s.info.cap_arch = CS_ARCH_X86;
> +    s.info.cap_mode = CS_MODE_64;
>  #elif defined(_ARCH_PPC)
>      s.info.disassembler_options = (char *)"any";
>      print_insn = print_insn_ppc;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b869a69c53..c3980b3864 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -51,6 +51,8 @@
>  #include "hw/i386/apic_internal.h"
>  #endif
>
> +#include "disas/capstone.h"
> +
>
>  /* Cache topology CPUID constants: */
>
> @@ -4108,6 +4110,11 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
>                    : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
>                    : bfd_mach_i386_i8086);
>      info->print_insn = print_insn_i386;
> +
> +    info->cap_arch = CS_ARCH_X86;
> +    info->cap_mode = (env->hflags & HF_CS64_MASK ? CS_MODE_64
> +                      : env->hflags & HF_CS32_MASK ? CS_MODE_32
> +                      : CS_MODE_16);
>  }
>
>  static Property x86_cpu_properties[] = {


--
Alex Bennée
