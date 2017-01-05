Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCdC-0002TO-5t
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCdA-0008Gg-GX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:19:18 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:34654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPCdA-0008GY-BU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:19:16 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 34so345905561uac.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 10:19:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <74cd767f0c6943c4f0841e2c4874de20a901e6a3.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
	<74cd767f0c6943c4f0841e2c4874de20a901e6a3.1481121503.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 18:18:55 +0000
Message-ID: <CAFEAcA8cSL0ikup6wbx7abEbjr8Ni8-LzT-RQ65oujcdhoM4uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 5/6] Fix Thumb-1 BE32 execution and
 disassembly.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2016 at 14:49, Julian Brown <julian@codesourcery.com> wrote:
> Thumb-1 code has some issues in BE32 mode (as currently implemented). In
> short, since bytes are swapped within words at load time for BE32
> executables, this also swaps pairs of adjacent Thumb-1 instructions.
>
> This patch un-swaps those pairs of instructions again, both for execution,
> and for disassembly.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

Thanks. This patch looks pretty good but I have a few
tweaks to suggest below.

(PS: this doesn't depend on patches 1-4, right?)

> ---
>  disas.c               |  1 +
>  include/disas/bfd.h   |  7 +++++++
>  target-arm/arm_ldst.h | 10 +++++++++-
>  target-arm/cpu.c      | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/disas.c b/disas.c
> index 67f116a..506e56f 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -190,6 +190,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>
>      s.cpu = cpu;
>      s.info.read_memory_func = target_read_memory;
> +    s.info.read_memory_inner_func = NULL;
>      s.info.buffer_vma = code;
>      s.info.buffer_length = size;
>      s.info.print_address_func = generic_print_address;
> diff --git a/include/disas/bfd.h b/include/disas/bfd.h
> index 8a3488c..5c1e1c5 100644
> --- a/include/disas/bfd.h
> +++ b/include/disas/bfd.h
> @@ -291,6 +291,7 @@ typedef struct disassemble_info {
>       The bottom 16 bits are for the internal use of the disassembler.  */
>    unsigned long flags;
>  #define INSN_HAS_RELOC 0x80000000
> +#define INSN_ARM_THUMB1_BE32 0x00010000

I think we should just call this INSN_ARM_BE32, because it doesn't
actually matter whether we're disassembling Thumb1 or not, only
whether the disassembler wants a 16-bit quantity.

>    PTR private_data;
>
>    /* Function used to get bytes to disassemble.  MEMADDR is the
> @@ -302,6 +303,12 @@ typedef struct disassemble_info {
>      (bfd_vma memaddr, bfd_byte *myaddr, int length,
>              struct disassemble_info *info);
>
> +  /* A place to stash the real read_memory_func if read_memory_func wants to
> +     do some funky address arithmetic or similar (e.g. for ARM BE32 mode).  */
> +  int (*read_memory_inner_func)
> +    (bfd_vma memaddr, bfd_byte *myaddr, int length,
> +             struct disassemble_info *info);
> +
>    /* Function which should be called if we get an error that we can't
>       recover from.  STATUS is the errno value from read_memory_func and
>       MEMADDR is the address that we were trying to read.  INFO is a
> diff --git a/target-arm/arm_ldst.h b/target-arm/arm_ldst.h
> index a76d89f..01587b3 100644
> --- a/target-arm/arm_ldst.h
> +++ b/target-arm/arm_ldst.h
> @@ -39,7 +39,15 @@ static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
>  static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
>                                       bool sctlr_b)
>  {
> -    uint16_t insn = cpu_lduw_code(env, addr);
> +    uint16_t insn;
> +#ifndef CONFIG_USER_ONLY
> +    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
> +       within each word.  Undo that now.  */
> +    if (sctlr_b) {
> +        addr ^= 2;
> +    }
> +#endif
> +    insn = cpu_lduw_code(env, addr);
>      if (bswap_code(sctlr_b)) {
>          return bswap16(insn);
>      }
> diff --git a/target-arm/cpu.c b/target-arm/cpu.c
> index 6afb0d9..6099d50 100644
> --- a/target-arm/cpu.c
> +++ b/target-arm/cpu.c
> @@ -409,6 +409,30 @@ print_insn_thumb1(bfd_vma pc, disassemble_info *info)
>    return print_insn_arm(pc | 1, info);
>  }
>
> +static int arm_read_memory_func(bfd_vma memaddr, bfd_byte *myaddr,
> +                                int length, struct disassemble_info *info)
> +{
> +    assert(info->read_memory_inner_func);
> +
> +    if ((info->flags & INSN_ARM_THUMB1_BE32) != 0 && length == 2) {
> +        int status;
> +        unsigned char b[4];
> +        assert(info->endian == BFD_ENDIAN_LITTLE);
> +        status = info->read_memory_inner_func(memaddr & ~3, (bfd_byte *)b, 4,
> +                                              info);
> +        if ((memaddr & 2) == 0) {
> +            myaddr[0] = b[2];
> +            myaddr[1] = b[3];
> +        } else {
> +            myaddr[0] = b[0];
> +            myaddr[1] = b[1];
> +        }

Is there a reason why we need to read 4 bytes and then pick 2 of them,
rather than just doing a 2 byte read from the adjusted address ?

Might want to at least assert that length is either 2 or 4 if
BE32 (we could handle length 1 but the disassembler doesn't do
length 1 requests).

> +        return status;
> +    } else {
> +        return info->read_memory_inner_func(memaddr, myaddr, length, info);
> +    }
> +}
> +
>  static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      ARMCPU *ac = ARM_CPU(cpu);
> @@ -424,6 +448,10 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  #endif
>      } else if (env->thumb) {
>          info->print_insn = print_insn_thumb1;
> +        info->flags &= ~INSN_ARM_THUMB1_BE32;
> +        if (arm_sctlr_b(env)) {
> +            info->flags |= INSN_ARM_THUMB1_BE32;
> +        }

We should set the BE32 flag if arm_sctlr_b(), regardless
of whether env->thumb or not.

>      } else {
>          info->print_insn = print_insn_arm;
>      }
> @@ -434,6 +462,10 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>          info->endian = BFD_ENDIAN_BIG;
>  #endif
>      }
> +    if (info->read_memory_inner_func == NULL) {
> +        info->read_memory_inner_func = info->read_memory_func;
> +        info->read_memory_func = arm_read_memory_func;
> +    }
>  }
>
>  static void arm_cpu_initfn(Object *obj)

thanks
-- PMM
