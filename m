Received: from eggs.gnu.org ([2001:4830:134:3::10]:55351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tlO-0000XJ-Df
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 22:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7tlN-0000LC-1M
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 22:21:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180411185651.21351-1-laurent@vivier.eu>
	<20180411185651.21351-16-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6fb5452f-9e97-7cd0-cbb6-ff08791764a5@amsat.org>
Date: Sun, 15 Apr 2018 23:20:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180411185651.21351-16-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 15/19] linux-user: move s390x
 cpu loop to s390x directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>

On 04/11/2018 03:56 PM, Laurent Vivier wrote:
> No code change, only move code from main.c to
> s390x/cpu_loop.c.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/main.c           | 146 --------------------------------------------
>  linux-user/s390x/cpu_loop.c | 139 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+), 146 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 37cf3a7d6f..7f6cfa5548 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -149,143 +149,6 @@ void fork_end(int child)
>      }
>  }
>  
> -#ifdef TARGET_S390X
> -
> -/* s390x masks the fault address it reports in si_addr for SIGSEGV and SIGBUS */
> -#define S390X_FAIL_ADDR_MASK -4096LL
> -
> -void cpu_loop(CPUS390XState *env)
> -{
> -    CPUState *cs = CPU(s390_env_get_cpu(env));
> -    int trapnr, n, sig;
> -    target_siginfo_t info;
> -    target_ulong addr;
> -    abi_long ret;
> -
> -    while (1) {
> -        cpu_exec_start(cs);
> -        trapnr = cpu_exec(cs);
> -        cpu_exec_end(cs);
> -        process_queued_cpu_work(cs);
> -
> -        switch (trapnr) {
> -        case EXCP_INTERRUPT:
> -            /* Just indicate that signals should be handled asap.  */
> -            break;
> -
> -        case EXCP_SVC:
> -            n = env->int_svc_code;
> -            if (!n) {
> -                /* syscalls > 255 */
> -                n = env->regs[1];
> -            }
> -            env->psw.addr += env->int_svc_ilen;
> -            ret = do_syscall(env, n, env->regs[2], env->regs[3],
> -                             env->regs[4], env->regs[5],
> -                             env->regs[6], env->regs[7], 0, 0);
> -            if (ret == -TARGET_ERESTARTSYS) {
> -                env->psw.addr -= env->int_svc_ilen;
> -            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> -                env->regs[2] = ret;
> -            }
> -            break;
> -
> -        case EXCP_DEBUG:
> -            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
> -            if (sig) {
> -                n = TARGET_TRAP_BRKPT;
> -                goto do_signal_pc;
> -            }
> -            break;
> -        case EXCP_PGM:
> -            n = env->int_pgm_code;
> -            switch (n) {
> -            case PGM_OPERATION:
> -            case PGM_PRIVILEGED:
> -                sig = TARGET_SIGILL;
> -                n = TARGET_ILL_ILLOPC;
> -                goto do_signal_pc;
> -            case PGM_PROTECTION:
> -            case PGM_ADDRESSING:
> -                sig = TARGET_SIGSEGV;
> -                /* XXX: check env->error_code */
> -                n = TARGET_SEGV_MAPERR;
> -                addr = env->__excp_addr & S390X_FAIL_ADDR_MASK;
> -                goto do_signal;
> -            case PGM_EXECUTE:
> -            case PGM_SPECIFICATION:
> -            case PGM_SPECIAL_OP:
> -            case PGM_OPERAND:
> -            do_sigill_opn:
> -                sig = TARGET_SIGILL;
> -                n = TARGET_ILL_ILLOPN;
> -                goto do_signal_pc;
> -
> -            case PGM_FIXPT_OVERFLOW:
> -                sig = TARGET_SIGFPE;
> -                n = TARGET_FPE_INTOVF;
> -                goto do_signal_pc;
> -            case PGM_FIXPT_DIVIDE:
> -                sig = TARGET_SIGFPE;
> -                n = TARGET_FPE_INTDIV;
> -                goto do_signal_pc;
> -
> -            case PGM_DATA:
> -                n = (env->fpc >> 8) & 0xff;
> -                if (n == 0xff) {
> -                    /* compare-and-trap */
> -                    goto do_sigill_opn;
> -                } else {
> -                    /* An IEEE exception, simulated or otherwise.  */
> -                    if (n & 0x80) {
> -                        n = TARGET_FPE_FLTINV;
> -                    } else if (n & 0x40) {
> -                        n = TARGET_FPE_FLTDIV;
> -                    } else if (n & 0x20) {
> -                        n = TARGET_FPE_FLTOVF;
> -                    } else if (n & 0x10) {
> -                        n = TARGET_FPE_FLTUND;
> -                    } else if (n & 0x08) {
> -                        n = TARGET_FPE_FLTRES;
> -                    } else {
> -                        /* ??? Quantum exception; BFP, DFP error.  */
> -                        goto do_sigill_opn;
> -                    }
> -                    sig = TARGET_SIGFPE;
> -                    goto do_signal_pc;
> -                }
> -
> -            default:
> -                fprintf(stderr, "Unhandled program exception: %#x\n", n);
> -                cpu_dump_state(cs, stderr, fprintf, 0);
> -                exit(EXIT_FAILURE);
> -            }
> -            break;
> -
> -        do_signal_pc:
> -            addr = env->psw.addr;
> -        do_signal:
> -            info.si_signo = sig;
> -            info.si_errno = 0;
> -            info.si_code = n;
> -            info._sifields._sigfault._addr = addr;
> -            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> -            break;
> -
> -        case EXCP_ATOMIC:
> -            cpu_exec_step_atomic(cs);
> -            break;
> -        default:
> -            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
> -            cpu_dump_state(cs, stderr, fprintf, 0);
> -            exit(EXIT_FAILURE);
> -        }
> -        process_pending_signals (env);
> -    }
> -}
> -
> -#endif /* TARGET_S390X */
> -
>  #ifdef TARGET_TILEGX
>  
>  static void gen_sigill_reg(CPUTLGState *env)
> @@ -1720,15 +1583,6 @@ int main(int argc, char **argv, char **envp)
>          env->pc = regs->sepc;
>          env->gpr[xSP] = regs->sp;
>      }
> -#elif defined(TARGET_S390X)
> -    {
> -            int i;
> -            for (i = 0; i < 16; i++) {
> -                env->regs[i] = regs->gprs[i];
> -            }
> -            env->psw.mask = regs->psw.mask;
> -            env->psw.addr = regs->psw.addr;
> -    }
>  #elif defined(TARGET_TILEGX)
>      {
>          int i;
> diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
> index b7700a5561..99f5f1594f 100644
> --- a/linux-user/s390x/cpu_loop.c
> +++ b/linux-user/s390x/cpu_loop.c
> @@ -21,6 +21,145 @@
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
>  
> +/* s390x masks the fault address it reports in si_addr for SIGSEGV and SIGBUS */
> +#define S390X_FAIL_ADDR_MASK -4096LL
> +
> +void cpu_loop(CPUS390XState *env)
> +{
> +    CPUState *cs = CPU(s390_env_get_cpu(env));
> +    int trapnr, n, sig;
> +    target_siginfo_t info;
> +    target_ulong addr;
> +    abi_long ret;
> +
> +    while (1) {
> +        cpu_exec_start(cs);
> +        trapnr = cpu_exec(cs);
> +        cpu_exec_end(cs);
> +        process_queued_cpu_work(cs);
> +
> +        switch (trapnr) {
> +        case EXCP_INTERRUPT:
> +            /* Just indicate that signals should be handled asap.  */
> +            break;
> +
> +        case EXCP_SVC:
> +            n = env->int_svc_code;
> +            if (!n) {
> +                /* syscalls > 255 */
> +                n = env->regs[1];
> +            }
> +            env->psw.addr += env->int_svc_ilen;
> +            ret = do_syscall(env, n, env->regs[2], env->regs[3],
> +                             env->regs[4], env->regs[5],
> +                             env->regs[6], env->regs[7], 0, 0);
> +            if (ret == -TARGET_ERESTARTSYS) {
> +                env->psw.addr -= env->int_svc_ilen;
> +            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
> +                env->regs[2] = ret;
> +            }
> +            break;
> +
> +        case EXCP_DEBUG:
> +            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
> +            if (sig) {
> +                n = TARGET_TRAP_BRKPT;
> +                goto do_signal_pc;
> +            }
> +            break;
> +        case EXCP_PGM:
> +            n = env->int_pgm_code;
> +            switch (n) {
> +            case PGM_OPERATION:
> +            case PGM_PRIVILEGED:
> +                sig = TARGET_SIGILL;
> +                n = TARGET_ILL_ILLOPC;
> +                goto do_signal_pc;
> +            case PGM_PROTECTION:
> +            case PGM_ADDRESSING:
> +                sig = TARGET_SIGSEGV;
> +                /* XXX: check env->error_code */
> +                n = TARGET_SEGV_MAPERR;
> +                addr = env->__excp_addr & S390X_FAIL_ADDR_MASK;
> +                goto do_signal;
> +            case PGM_EXECUTE:
> +            case PGM_SPECIFICATION:
> +            case PGM_SPECIAL_OP:
> +            case PGM_OPERAND:
> +            do_sigill_opn:
> +                sig = TARGET_SIGILL;
> +                n = TARGET_ILL_ILLOPN;
> +                goto do_signal_pc;
> +
> +            case PGM_FIXPT_OVERFLOW:
> +                sig = TARGET_SIGFPE;
> +                n = TARGET_FPE_INTOVF;
> +                goto do_signal_pc;
> +            case PGM_FIXPT_DIVIDE:
> +                sig = TARGET_SIGFPE;
> +                n = TARGET_FPE_INTDIV;
> +                goto do_signal_pc;
> +
> +            case PGM_DATA:
> +                n = (env->fpc >> 8) & 0xff;
> +                if (n == 0xff) {
> +                    /* compare-and-trap */
> +                    goto do_sigill_opn;
> +                } else {
> +                    /* An IEEE exception, simulated or otherwise.  */
> +                    if (n & 0x80) {
> +                        n = TARGET_FPE_FLTINV;
> +                    } else if (n & 0x40) {
> +                        n = TARGET_FPE_FLTDIV;
> +                    } else if (n & 0x20) {
> +                        n = TARGET_FPE_FLTOVF;
> +                    } else if (n & 0x10) {
> +                        n = TARGET_FPE_FLTUND;
> +                    } else if (n & 0x08) {
> +                        n = TARGET_FPE_FLTRES;
> +                    } else {
> +                        /* ??? Quantum exception; BFP, DFP error.  */
> +                        goto do_sigill_opn;
> +                    }
> +                    sig = TARGET_SIGFPE;
> +                    goto do_signal_pc;
> +                }
> +
> +            default:
> +                fprintf(stderr, "Unhandled program exception: %#x\n", n);
> +                cpu_dump_state(cs, stderr, fprintf, 0);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +
> +        do_signal_pc:
> +            addr = env->psw.addr;
> +        do_signal:
> +            info.si_signo = sig;
> +            info.si_errno = 0;
> +            info.si_code = n;
> +            info._sifields._sigfault._addr = addr;
> +            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            break;
> +
> +        case EXCP_ATOMIC:
> +            cpu_exec_step_atomic(cs);
> +            break;
> +        default:
> +            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
> +            cpu_dump_state(cs, stderr, fprintf, 0);
> +            exit(EXIT_FAILURE);
> +        }
> +        process_pending_signals (env);
> +    }
> +}
> +
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  {
> +    int i;
> +    for (i = 0; i < 16; i++) {
> +        env->regs[i] = regs->gprs[i];
> +    }
> +    env->psw.mask = regs->psw.mask;
> +    env->psw.addr = regs->psw.addr;
>  }
> 
