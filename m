Received: from eggs.gnu.org ([2001:4830:134:3::10]:34666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ1lI-0005FS-Ua
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ1lF-0002nz-1I
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:44:17 -0500
References: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <23319194-73e8-8edd-32e5-a8543b91fca9@vivier.eu>
Date: Wed, 1 Feb 2017 21:43:57 +0100
MIME-Version: 1.0
In-Reply-To: <1485900317-3256-1-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fill target sigcontext struct
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, qemu-ppc@nongnu.org

Le 31/01/2017 à 23:05, Jose Ricardo Ziviani a écrit :
> A segfault is noticed when an emulated program uses any of ucontext
> regs fields. Risu detected this issue in the following operation when
> handling a signal:
>   ucontext_t *uc = (ucontext_t*)uc;
>   uc->uc_mcontext.regs->nip += 4;
> 
> but this works fine:
>   uc->uc_mcontext.gp_regs[PT_NIP] += 4;
> 
> This patch set regs to a valid location as well as other sigcontext
> fields.
> 
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  linux-user/signal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5064de0..8209539 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -5155,6 +5155,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
>      target_ulong rt_sf_addr, newsp = 0;
>      int i, err = 0;
>  #if defined(TARGET_PPC64)
> +    struct target_sigcontext *sc = 0;
>      struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
>  #endif
>  
> @@ -5183,6 +5184,10 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
>  #if defined(TARGET_PPC64)
>      mctx = &rt_sf->uc.tuc_sigcontext.mcontext;
>      trampptr = &rt_sf->trampoline[0];
> +
> +    sc = &rt_sf->uc.tuc_sigcontext;
> +    __put_user(h2g(mctx), &sc->regs);
> +    __put_user(sig, &sc->signal);
>  #else
>      mctx = &rt_sf->uc.tuc_mcontext;
>      trampptr = (uint32_t *)&rt_sf->uc.tuc_mcontext.tramp;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

This is correct, but QEMU and kernel implementation are really different.

In the kernel:

handle_rt_signal64()
...
    frame = get_sigframe(ksig, get_tm_stackpointer(tsk),
                         sizeof(*frame), 0);
...
    err |= setup_sigcontext(&frame->uc.uc_mcontext, tsk, ksig->sig,
                            NULL,
                            (unsigned long)ksig->ka.sa.sa_handler,
                            1);

static long setup_sigcontext(struct sigcontext __user *sc,
                struct task_struct *tsk, int signr, sigset_t *set,
                unsigned long handler, int ctx_has_vsx_region)

        err |= __put_user(&sc->gp_regs, &sc->regs);
...
        err |= __put_user(signr, &sc->signal);
...

According to kernel definition of ucontext:

struct ucontext {
...
#ifdef __powerpc64__
        sigset_t        __unused[15];   /* Allow for uc_sigmask growth */
        struct sigcontext uc_mcontext;  /* last for extensibility */
#else
...
}

kernel &frame->uc.uc_mcontext is qemu &rt_sf->uc.tuc_sigcontext

uc_sigcontext.mcontext doesn't exit in the kernel.

But QEMU code works because tuc_sigcontext.mcontext is where we have the
CPU registers in sigcontext:

kernel:

struct sigcontext {
        unsigned long   _unused[4];
        int             signal;
#ifdef __powerpc64__
        int             _pad0;
#endif
        unsigned long   handler;
        unsigned long   oldmask;
        struct pt_regs  __user *regs;
#ifdef __powerpc64__
        elf_gregset_t   gp_regs;
        elf_fpregset_t  fp_regs;
...

Qemu:

struct target_sigcontext {
    target_ulong _unused[4];
    int32_t signal;
#if defined(TARGET_PPC64)
    int32_t pad0;
#endif
    target_ulong handler;
    target_ulong oldmask;
    target_ulong regs;      /* struct pt_regs __user * */
#if defined(TARGET_PPC64)
    struct target_mcontext mcontext;
#endif
};

struct target_mcontext {
    target_ulong mc_gregs[48];
    /* Includes fpscr.  */
    uint64_t mc_fregs[33];
...

I think we do like that to use the same
save_user_regs()/save_user_regs() functions with PPC and PPC64... but
comparison with kernel becomes harder.

Laurent
