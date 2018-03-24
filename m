Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezXbf-0001k5-L7
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezXbd-0000UE-LS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:04:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180323225739.17329-1-laurent@vivier.eu>
	<20180323225739.17329-14-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb544a00-2239-1611-9132-d14e9512facf@amsat.org>
Date: Fri, 23 Mar 2018 22:04:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180323225739.17329-14-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 13/20] linux-user: move riscv
 signal.c parts to riscv directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

On 03/23/2018 07:57 PM, Laurent Vivier wrote:
> No code change, only move code from signal.c to
> riscv/signal.c, except adding includes and
> exporting setup_rt_frame().
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/riscv/signal.c        | 200 +++++++++++++++++++++++++++++++++++++++
>  linux-user/riscv/target_signal.h |   3 +
>  linux-user/signal.c              | 197 --------------------------------------
>  3 files changed, 203 insertions(+), 197 deletions(-)
> 
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 02ca338b6c..718f3a5679 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -16,3 +16,203 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> +#include "qemu/osdep.h"
> +#include "qemu.h"
> +#include "target_signal.h"
> +#include "signal-common.h"
> +#include "linux-user/trace.h"
> +
> +/* Signal handler invocation must be transparent for the code being
> +   interrupted. Complete CPU (hart) state is saved on entry and restored
> +   before returning from the handler. Process sigmask is also saved to block
> +   signals while the handler is running. The handler gets its own stack,
> +   which also doubles as storage for the CPU state and sigmask.
> +
> +   The code below is qemu re-implementation of arch/riscv/kernel/signal.c */
> +
> +struct target_sigcontext {
> +    abi_long pc;
> +    abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
> +    uint64_t fpr[32];
> +    uint32_t fcsr;
> +}; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
> +
> +struct target_ucontext {
> +    unsigned long uc_flags;
> +    struct target_ucontext *uc_link;
> +    target_stack_t uc_stack;
> +    struct target_sigcontext uc_mcontext;
> +    target_sigset_t uc_sigmask;
> +};
> +
> +struct target_rt_sigframe {
> +    uint32_t tramp[2]; /* not in kernel, which uses VDSO instead */
> +    struct target_siginfo info;
> +    struct target_ucontext uc;
> +};
> +
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
> +
> +    /* If we are on the alternate signal stack and would overflow it, don't.
> +       Return an always-bogus address instead so we will die with SIGSEGV. */
> +    if (onsigstack && !likely(on_sig_stack(sp))) {
> +        return -1L;
> +    }
> +
> +    return sp;
> +}
> +
> +static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
> +{
> +    int i;
> +
> +    __put_user(env->pc, &sc->pc);
> +
> +    for (i = 1; i < 32; i++) {
> +        __put_user(env->gpr[i], &sc->gpr[i - 1]);
> +    }
> +    for (i = 0; i < 32; i++) {
> +        __put_user(env->fpr[i], &sc->fpr[i]);
> +    }
> +
> +    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
> +    __put_user(fcsr, &sc->fcsr);
> +}
> +
> +static void setup_ucontext(struct target_ucontext *uc,
> +                           CPURISCVState *env, target_sigset_t *set)
> +{
> +    abi_ulong ss_sp = (target_ulong)target_sigaltstack_used.ss_sp;
> +    abi_ulong ss_flags = sas_ss_flags(env->gpr[xSP]);
> +    abi_ulong ss_size = target_sigaltstack_used.ss_size;
> +
> +    __put_user(0,    &(uc->uc_flags));
> +    __put_user(0,    &(uc->uc_link));
> +
> +    __put_user(ss_sp,    &(uc->uc_stack.ss_sp));
> +    __put_user(ss_flags, &(uc->uc_stack.ss_flags));
> +    __put_user(ss_size,  &(uc->uc_stack.ss_size));
> +
> +    int i;
> +    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
> +        __put_user(set->sig[i], &(uc->uc_sigmask.sig[i]));
> +    }
> +
> +    setup_sigcontext(&uc->uc_mcontext, env);
> +}
> +
> +static inline void install_sigtramp(uint32_t *tramp)
> +{
> +    __put_user(0x08b00893, tramp + 0);  /* li a7, 139 = __NR_rt_sigreturn */
> +    __put_user(0x00000073, tramp + 1);  /* ecall */
> +}
> +
> +void setup_rt_frame(int sig, struct target_sigaction *ka,
> +                    target_siginfo_t *info,
> +                    target_sigset_t *set, CPURISCVState *env)
> +{
> +    abi_ulong frame_addr;
> +    struct target_rt_sigframe *frame;
> +
> +    frame_addr = get_sigframe(ka, env, sizeof(*frame));
> +    trace_user_setup_rt_frame(env, frame_addr);
> +
> +    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> +        goto badframe;
> +    }
> +
> +    setup_ucontext(&frame->uc, env, set);
> +    tswap_siginfo(&frame->info, info);
> +    install_sigtramp(frame->tramp);
> +
> +    env->pc = ka->_sa_handler;
> +    env->gpr[xSP] = frame_addr;
> +    env->gpr[xA0] = sig;
> +    env->gpr[xA1] = frame_addr + offsetof(struct target_rt_sigframe, info);
> +    env->gpr[xA2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
> +    env->gpr[xRA] = frame_addr + offsetof(struct target_rt_sigframe, tramp);
> +
> +    return;
> +
> +badframe:
> +    unlock_user_struct(frame, frame_addr, 1);
> +    if (sig == TARGET_SIGSEGV) {
> +        ka->_sa_handler = TARGET_SIG_DFL;
> +    }
> +    force_sig(TARGET_SIGSEGV);
> +}
> +
> +static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
> +{
> +    int i;
> +
> +    __get_user(env->pc, &sc->pc);
> +
> +    for (i = 1; i < 32; ++i) {
> +        __get_user(env->gpr[i], &sc->gpr[i - 1]);
> +    }
> +    for (i = 0; i < 32; ++i) {
> +        __get_user(env->fpr[i], &sc->fpr[i]);
> +    }
> +
> +    uint32_t fcsr;
> +    __get_user(fcsr, &sc->fcsr);
> +    csr_write_helper(env, fcsr, CSR_FCSR);
> +}
> +
> +static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
> +{
> +    sigset_t blocked;
> +    target_sigset_t target_set;
> +    int i;
> +
> +    target_sigemptyset(&target_set);
> +    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
> +        __get_user(target_set.sig[i], &(uc->uc_sigmask.sig[i]));
> +    }
> +
> +    target_to_host_sigset_internal(&blocked, &target_set);
> +    set_sigmask(&blocked);
> +
> +    restore_sigcontext(env, &uc->uc_mcontext);
> +}
> +
> +long do_rt_sigreturn(CPURISCVState *env)
> +{
> +    struct target_rt_sigframe *frame;
> +    abi_ulong frame_addr;
> +
> +    frame_addr = env->gpr[xSP];
> +    trace_user_do_sigreturn(env, frame_addr);
> +    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
> +        goto badframe;
> +    }
> +
> +    restore_ucontext(env, &frame->uc);
> +
> +    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
> +            uc.uc_stack), 0, get_sp_from_cpustate(env)) == -EFAULT) {
> +        goto badframe;
> +    }
> +
> +    unlock_user_struct(frame, frame_addr, 0);
> +    return -TARGET_QEMU_ESIGRETURN;
> +
> +badframe:
> +    unlock_user_struct(frame, frame_addr, 0);
> +    force_sig(TARGET_SIGSEGV);
> +    return 0;
> +}
> diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
> index ce77f752e3..6ac8a88de6 100644
> --- a/linux-user/riscv/target_signal.h
> +++ b/linux-user/riscv/target_signal.h
> @@ -20,4 +20,7 @@ static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
>     return state->gpr[xSP];
>  }
>  
> +void setup_rt_frame(int sig, struct target_sigaction *ka,
> +                    target_siginfo_t *info,
> +                    target_sigset_t *set, CPURISCVState *env);
>  #endif /* TARGET_SIGNAL_H */
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5f05683b30..cc5b7d1456 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3032,203 +3032,6 @@ sigsegv:
>      return -TARGET_QEMU_ESIGRETURN;
>  }
>  
> -#elif defined(TARGET_RISCV)
> -
> -/* Signal handler invocation must be transparent for the code being
> -   interrupted. Complete CPU (hart) state is saved on entry and restored
> -   before returning from the handler. Process sigmask is also saved to block
> -   signals while the handler is running. The handler gets its own stack,
> -   which also doubles as storage for the CPU state and sigmask.
> -
> -   The code below is qemu re-implementation of arch/riscv/kernel/signal.c */
> -
> -struct target_sigcontext {
> -    abi_long pc;
> -    abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
> -    uint64_t fpr[32];
> -    uint32_t fcsr;
> -}; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
> -
> -struct target_ucontext {
> -    unsigned long uc_flags;
> -    struct target_ucontext *uc_link;
> -    target_stack_t uc_stack;
> -    struct target_sigcontext uc_mcontext;
> -    target_sigset_t uc_sigmask;
> -};
> -
> -struct target_rt_sigframe {
> -    uint32_t tramp[2]; /* not in kernel, which uses VDSO instead */
> -    struct target_siginfo info;
> -    struct target_ucontext uc;
> -};
> -
> -static abi_ulong get_sigframe(struct target_sigaction *ka,
> -                              CPURISCVState *regs, size_t framesize)
> -{
> -    abi_ulong sp = regs->gpr[xSP];
> -    int onsigstack = on_sig_stack(sp);
> -
> -    /* redzone */
> -    /* This is the X/Open sanctioned signal stack switching.  */
> -    if ((ka->sa_flags & TARGET_SA_ONSTACK) != 0 && !onsigstack) {
> -        sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
> -    }
> -
> -    sp -= framesize;
> -    sp &= ~3UL; /* align sp on 4-byte boundary */
> -
> -    /* If we are on the alternate signal stack and would overflow it, don't.
> -       Return an always-bogus address instead so we will die with SIGSEGV. */
> -    if (onsigstack && !likely(on_sig_stack(sp))) {
> -        return -1L;
> -    }
> -
> -    return sp;
> -}
> -
> -static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
> -{
> -    int i;
> -
> -    __put_user(env->pc, &sc->pc);
> -
> -    for (i = 1; i < 32; i++) {
> -        __put_user(env->gpr[i], &sc->gpr[i - 1]);
> -    }
> -    for (i = 0; i < 32; i++) {
> -        __put_user(env->fpr[i], &sc->fpr[i]);
> -    }
> -
> -    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
> -    __put_user(fcsr, &sc->fcsr);
> -}
> -
> -static void setup_ucontext(struct target_ucontext *uc,
> -                           CPURISCVState *env, target_sigset_t *set)
> -{
> -    abi_ulong ss_sp = (target_ulong)target_sigaltstack_used.ss_sp;
> -    abi_ulong ss_flags = sas_ss_flags(env->gpr[xSP]);
> -    abi_ulong ss_size = target_sigaltstack_used.ss_size;
> -
> -    __put_user(0,    &(uc->uc_flags));
> -    __put_user(0,    &(uc->uc_link));
> -
> -    __put_user(ss_sp,    &(uc->uc_stack.ss_sp));
> -    __put_user(ss_flags, &(uc->uc_stack.ss_flags));
> -    __put_user(ss_size,  &(uc->uc_stack.ss_size));
> -
> -    int i;
> -    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
> -        __put_user(set->sig[i], &(uc->uc_sigmask.sig[i]));
> -    }
> -
> -    setup_sigcontext(&uc->uc_mcontext, env);
> -}
> -
> -static inline void install_sigtramp(uint32_t *tramp)
> -{
> -    __put_user(0x08b00893, tramp + 0);  /* li a7, 139 = __NR_rt_sigreturn */
> -    __put_user(0x00000073, tramp + 1);  /* ecall */
> -}
> -
> -static void setup_rt_frame(int sig, struct target_sigaction *ka,
> -                           target_siginfo_t *info,
> -                           target_sigset_t *set, CPURISCVState *env)
> -{
> -    abi_ulong frame_addr;
> -    struct target_rt_sigframe *frame;
> -
> -    frame_addr = get_sigframe(ka, env, sizeof(*frame));
> -    trace_user_setup_rt_frame(env, frame_addr);
> -
> -    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> -        goto badframe;
> -    }
> -
> -    setup_ucontext(&frame->uc, env, set);
> -    tswap_siginfo(&frame->info, info);
> -    install_sigtramp(frame->tramp);
> -
> -    env->pc = ka->_sa_handler;
> -    env->gpr[xSP] = frame_addr;
> -    env->gpr[xA0] = sig;
> -    env->gpr[xA1] = frame_addr + offsetof(struct target_rt_sigframe, info);
> -    env->gpr[xA2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
> -    env->gpr[xRA] = frame_addr + offsetof(struct target_rt_sigframe, tramp);
> -
> -    return;
> -
> -badframe:
> -    unlock_user_struct(frame, frame_addr, 1);
> -    if (sig == TARGET_SIGSEGV) {
> -        ka->_sa_handler = TARGET_SIG_DFL;
> -    }
> -    force_sig(TARGET_SIGSEGV);
> -}
> -
> -static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
> -{
> -    int i;
> -
> -    __get_user(env->pc, &sc->pc);
> -
> -    for (i = 1; i < 32; ++i) {
> -        __get_user(env->gpr[i], &sc->gpr[i - 1]);
> -    }
> -    for (i = 0; i < 32; ++i) {
> -        __get_user(env->fpr[i], &sc->fpr[i]);
> -    }
> -
> -    uint32_t fcsr;
> -    __get_user(fcsr, &sc->fcsr);
> -    csr_write_helper(env, fcsr, CSR_FCSR);
> -}
> -
> -static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
> -{
> -    sigset_t blocked;
> -    target_sigset_t target_set;
> -    int i;
> -
> -    target_sigemptyset(&target_set);
> -    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
> -        __get_user(target_set.sig[i], &(uc->uc_sigmask.sig[i]));
> -    }
> -
> -    target_to_host_sigset_internal(&blocked, &target_set);
> -    set_sigmask(&blocked);
> -
> -    restore_sigcontext(env, &uc->uc_mcontext);
> -}
> -
> -long do_rt_sigreturn(CPURISCVState *env)
> -{
> -    struct target_rt_sigframe *frame;
> -    abi_ulong frame_addr;
> -
> -    frame_addr = env->gpr[xSP];
> -    trace_user_do_sigreturn(env, frame_addr);
> -    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
> -        goto badframe;
> -    }
> -
> -    restore_ucontext(env, &frame->uc);
> -
> -    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
> -            uc.uc_stack), 0, get_sp_from_cpustate(env)) == -EFAULT) {
> -        goto badframe;
> -    }
> -
> -    unlock_user_struct(frame, frame_addr, 0);
> -    return -TARGET_QEMU_ESIGRETURN;
> -
> -badframe:
> -    unlock_user_struct(frame, frame_addr, 0);
> -    force_sig(TARGET_SIGSEGV);
> -    return 0;
> -}
> -
>  #elif defined(TARGET_HPPA)
>  
>  struct target_sigcontext {
> 
