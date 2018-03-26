Received: from eggs.gnu.org ([2001:4830:134:3::10]:42383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0ZyG-0001bw-Ku
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0ZyE-0003XF-6H
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:48:04 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0ZyD-0003Ww-V2
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:48:02 -0400
Received: by mail-ot0-x241.google.com with SMTP id v64-v6so1193036otb.13
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 14:48:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326191603.10217-18-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
	<20180326191603.10217-18-laurent@vivier.eu>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 26 Mar 2018 14:48:00 -0700
Message-ID: <CAHNT7NsaxqBxDxEL2BZZG=_N92oCvJQBJb3JpMLG5Pex6yrtKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.13 17/19] linux-user: move riscv cpu
 loop to riscv directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org

On Mon, Mar 26, 2018 at 12:16 PM, Laurent Vivier <laurent@vivier.eu> wrote:

> No code change, only move code from main.c to
> riscv/cpu_loop.c.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  linux-user/main.c           | 101 +-----------------------------
> --------------
>  linux-user/riscv/cpu_loop.c |  92 ++++++++++++++++++++++++++++++
> ++++++++++
>  2 files changed, 93 insertions(+), 100 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 3b3613cb89..78ff99bd00 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -149,100 +149,6 @@ void fork_end(int child)
>      }
>  }
>
> -#ifdef TARGET_RISCV
> -
> -void cpu_loop(CPURISCVState *env)
> -{
> -    CPUState *cs = CPU(riscv_env_get_cpu(env));
> -    int trapnr, signum, sigcode;
> -    target_ulong sigaddr;
> -    target_ulong ret;
> -
> -    for (;;) {
> -        cpu_exec_start(cs);
> -        trapnr = cpu_exec(cs);
> -        cpu_exec_end(cs);
> -        process_queued_cpu_work(cs);
> -
> -        signum = 0;
> -        sigcode = 0;
> -        sigaddr = 0;
> -
> -        switch (trapnr) {
> -        case EXCP_INTERRUPT:
> -            /* just indicate that signals should be handled asap */
> -            break;
> -        case EXCP_ATOMIC:
> -            cpu_exec_step_atomic(cs);
> -            break;
> -        case RISCV_EXCP_U_ECALL:
> -            env->pc += 4;
> -            if (env->gpr[xA7] == TARGET_NR_arch_specific_syscall + 15) {
> -                /* riscv_flush_icache_syscall is a no-op in QEMU as
> -                   self-modifying code is automatically detected */
> -                ret = 0;
> -            } else {
> -                ret = do_syscall(env,
> -                                 env->gpr[xA7],
> -                                 env->gpr[xA0],
> -                                 env->gpr[xA1],
> -                                 env->gpr[xA2],
> -                                 env->gpr[xA3],
> -                                 env->gpr[xA4],
> -                                 env->gpr[xA5],
> -                                 0, 0);
> -            }
> -            if (ret == -TARGET_ERESTARTSYS) {
> -                env->pc -= 4;
> -            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> -                env->gpr[xA0] = ret;
> -            }
> -            if (cs->singlestep_enabled) {
> -                goto gdbstep;
> -            }
> -            break;
> -        case RISCV_EXCP_ILLEGAL_INST:
> -            signum = TARGET_SIGILL;
> -            sigcode = TARGET_ILL_ILLOPC;
> -            break;
> -        case RISCV_EXCP_BREAKPOINT:
> -            signum = TARGET_SIGTRAP;
> -            sigcode = TARGET_TRAP_BRKPT;
> -            sigaddr = env->pc;
> -            break;
> -        case RISCV_EXCP_INST_PAGE_FAULT:
> -        case RISCV_EXCP_LOAD_PAGE_FAULT:
> -        case RISCV_EXCP_STORE_PAGE_FAULT:
> -            signum = TARGET_SIGSEGV;
> -            sigcode = TARGET_SEGV_MAPERR;
> -            break;
> -        case EXCP_DEBUG:
> -        gdbstep:
> -            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
> -            sigcode = TARGET_TRAP_BRKPT;
> -            break;
> -        default:
> -            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x -
> aborting\n",
> -                     trapnr);
> -            exit(EXIT_FAILURE);
> -        }
> -
> -        if (signum) {
> -            target_siginfo_t info = {
> -                .si_signo = signum,
> -                .si_errno = 0,
> -                .si_code = sigcode,
> -                ._sifields._sigfault._addr = sigaddr
> -            };
> -            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
> -        }
> -
> -        process_pending_signals(env);
> -    }
> -}
> -
> -#endif /* TARGET_RISCV */
> -
>  #ifdef TARGET_HPPA
>
>  static abi_ulong hppa_lws(CPUHPPAState *env)
> @@ -1319,12 +1225,7 @@ int main(int argc, char **argv, char **envp)
>
>      target_cpu_copy_regs(env, regs);
>
> -#if defined(TARGET_RISCV)
> -    {
> -        env->pc = regs->sepc;
> -        env->gpr[xSP] = regs->sp;
> -    }
> -#elif defined(TARGET_HPPA)
> +#if defined(TARGET_HPPA)
>      {
>          int i;
>          for (i = 1; i < 32; i++) {
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index b7700a5561..f137d39d7e 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -21,6 +21,98 @@
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
>
> +void cpu_loop(CPURISCVState *env)
> +{
> +    CPUState *cs = CPU(riscv_env_get_cpu(env));
> +    int trapnr, signum, sigcode;
> +    target_ulong sigaddr;
> +    target_ulong ret;
> +
> +    for (;;) {
> +        cpu_exec_start(cs);
> +        trapnr = cpu_exec(cs);
> +        cpu_exec_end(cs);
> +        process_queued_cpu_work(cs);
> +
> +        signum = 0;
> +        sigcode = 0;
> +        sigaddr = 0;
> +
> +        switch (trapnr) {
> +        case EXCP_INTERRUPT:
> +            /* just indicate that signals should be handled asap */
> +            break;
> +        case EXCP_ATOMIC:
> +            cpu_exec_step_atomic(cs);
> +            break;
> +        case RISCV_EXCP_U_ECALL:
> +            env->pc += 4;
> +            if (env->gpr[xA7] == TARGET_NR_arch_specific_syscall + 15) {
> +                /* riscv_flush_icache_syscall is a no-op in QEMU as
> +                   self-modifying code is automatically detected */
> +                ret = 0;
> +            } else {
> +                ret = do_syscall(env,
> +                                 env->gpr[xA7],
> +                                 env->gpr[xA0],
> +                                 env->gpr[xA1],
> +                                 env->gpr[xA2],
> +                                 env->gpr[xA3],
> +                                 env->gpr[xA4],
> +                                 env->gpr[xA5],
> +                                 0, 0);
> +            }
> +            if (ret == -TARGET_ERESTARTSYS) {
> +                env->pc -= 4;
> +            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> +                env->gpr[xA0] = ret;
> +            }
> +            if (cs->singlestep_enabled) {
> +                goto gdbstep;
> +            }
> +            break;
> +        case RISCV_EXCP_ILLEGAL_INST:
> +            signum = TARGET_SIGILL;
> +            sigcode = TARGET_ILL_ILLOPC;
> +            break;
> +        case RISCV_EXCP_BREAKPOINT:
> +            signum = TARGET_SIGTRAP;
> +            sigcode = TARGET_TRAP_BRKPT;
> +            sigaddr = env->pc;
> +            break;
> +        case RISCV_EXCP_INST_PAGE_FAULT:
> +        case RISCV_EXCP_LOAD_PAGE_FAULT:
> +        case RISCV_EXCP_STORE_PAGE_FAULT:
> +            signum = TARGET_SIGSEGV;
> +            sigcode = TARGET_SEGV_MAPERR;
> +            break;
> +        case EXCP_DEBUG:
> +        gdbstep:
> +            signum = gdb_handlesig(cs, TARGET_SIGTRAP);
> +            sigcode = TARGET_TRAP_BRKPT;
> +            break;
> +        default:
> +            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x -
> aborting\n",
> +                     trapnr);
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        if (signum) {
> +            target_siginfo_t info = {
> +                .si_signo = signum,
> +                .si_errno = 0,
> +                .si_code = sigcode,
> +                ._sifields._sigfault._addr = sigaddr
> +            };
> +            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
> +        }
> +
> +        process_pending_signals(env);
> +    }
> +}
> +
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  {
> +    env->pc = regs->sepc;
> +    env->gpr[xSP] = regs->sp;
>  }
> --
> 2.14.3
>
>
>
