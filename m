Received: from eggs.gnu.org ([2001:4830:134:3::10]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3hmb-0003R3-4B
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3hmX-0000rv-Us
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:44:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f3hmX-0000ro-LG
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:44:53 -0400
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-11-git-send-email-mjc@sifive.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b9b4f754-911c-8f23-8809-1a2d463f784e@vivier.eu>
Date: Wed, 4 Apr 2018 14:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-11-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 10/23] RISC-V Linux User Emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

Le 02/03/2018 à 14:51, Michael Clark a écrit :
> Implementation of linux user emulation for RISC-V.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  linux-user/elfload.c              |  22 +++
>  linux-user/main.c                 |  99 +++++++++++++
>  linux-user/riscv/syscall_nr.h     | 287 ++++++++++++++++++++++++++++++++++++++
>  linux-user/riscv/target_cpu.h     |  18 +++
>  linux-user/riscv/target_elf.h     |  14 ++
>  linux-user/riscv/target_signal.h  |  23 +++
>  linux-user/riscv/target_structs.h |  46 ++++++
>  linux-user/riscv/target_syscall.h |  56 ++++++++
>  linux-user/riscv/termbits.h       | 222 +++++++++++++++++++++++++++++
>  linux-user/signal.c               | 203 ++++++++++++++++++++++++++-
>  linux-user/syscall.c              |   2 +
>  linux-user/syscall_defs.h         |  13 +-
>  target/riscv/cpu_user.h           |  13 ++
>  13 files changed, 1012 insertions(+), 6 deletions(-)
>  create mode 100644 linux-user/riscv/syscall_nr.h
>  create mode 100644 linux-user/riscv/target_cpu.h
>  create mode 100644 linux-user/riscv/target_elf.h
>  create mode 100644 linux-user/riscv/target_signal.h
>  create mode 100644 linux-user/riscv/target_structs.h
>  create mode 100644 linux-user/riscv/target_syscall.h
>  create mode 100644 linux-user/riscv/termbits.h
>  create mode 100644 target/riscv/cpu_user.h
> 
...
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 9a380b9..4d3f244 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
...
> +static abi_ulong get_sigframe(struct target_sigaction *ka,
> +                              CPURISCVState *regs, size_t framesize)
> +{
> +    abi_ulong sp = regs->gpr[xSP];
> +    int onsigstack = on_sig_stack(sp);
> +
> +    /* redzone */
> +    /* This is the X/Open sanctioned signal stack switching.  */
> +    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
> +        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
> +    }
> +
> +    sp -= framesize;
> +    sp &= ~3UL; /* align sp on 4-byte boundary */

kernel aligns using 0xf. Why do you use a different alignment?

> +
> +    /* If we are on the alternate signal stack and would overflow it, don't.
> +       Return an always-bogus address instead so we will die with SIGSEGV. */
> +    if (onsigstack && !likely(on_sig_stack(sp))) {
> +        return -1L;
> +    }
> +
> +    return sp;
> +}
Other question why don't you use the same logic as in kernel?

1- check for signal stack overflow
2- check for X/Open sanctioned signal stack switching

static inline void __user *get_sigframe(struct ksignal *ksig,
        struct pt_regs *regs, size_t framesize)
{
        unsigned long sp;
        /* Default to using normal stack */
        sp = regs->sp;

        /*
         * If we are on the alternate signal stack and would overflow
it, don't.
         * Return an always-bogus address instead so we will die with
SIGSEGV.
         */
        if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
                return (void __user __force *)(-1UL);

        /* This is the X/Open sanctioned signal stack switching. */
        sp = sigsp(sp, ksig) - framesize;

        /* Align the stack frame. */
        sp &= ~0xfUL;

        return (void __user *)sp;
}

Thanks,
Laurent
