Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbAa-00070d-Ek
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAbAS-00064H-An
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:06:12 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAbAS-00062z-4O
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:06:04 -0400
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so17115852oth.1
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 06:06:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423075215.4572-5-christophe.lyon@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-5-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 14:05:42 +0100
Message-ID: <CAFEAcA954r6mp3ouyDS4qDWJusBQaP=MfyOsd+Pd1OTeRsGwBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 4/4] linux-user: ARM-FDPIC: Add
 support for signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 08:51, Christophe Lyon <christophe.lyon@st.com> wrote:
> The FDPIC restorer needs to deal with a function descriptor, hence we
> have to extend 'retcode' such that it can hold the instructions needed
> to perform this.
>
> The restorer sequence uses the same thumbness as the exception
> handler (mainly to support Thumb-only architectures).
>
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 8d9e6e8..d01b459 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -2045,13 +2045,13 @@ struct sigframe_v1
>  {
>      struct target_sigcontext sc;
>      abi_ulong extramask[TARGET_NSIG_WORDS-1];
> -    abi_ulong retcode;
> +    abi_ulong retcode[4];
>  };
>
>  struct sigframe_v2
>  {
>      struct target_ucontext_v2 uc;
> -    abi_ulong retcode;
> +    abi_ulong retcode[4];
>  };
>
>  struct rt_sigframe_v1
> @@ -2060,14 +2060,14 @@ struct rt_sigframe_v1
>      abi_ulong puc;
>      struct target_siginfo info;
>      struct target_ucontext_v1 uc;
> -    abi_ulong retcode;
> +    abi_ulong retcode[4];
>  };
>
>  struct rt_sigframe_v2
>  {
>      struct target_siginfo info;
>      struct target_ucontext_v2 uc;
> -    abi_ulong retcode;
> +    abi_ulong retcode[4];
>  };

I was slightly surprised to find that the kernel adds the extra
retcode slots to the signal frame unconditionally, but it does,
so we can too, which is nice.

>  #define TARGET_CONFIG_CPU_32 1
> @@ -2090,6 +2090,21 @@ static const abi_ulong retcodes[4] =3D {
>         SWI_SYS_RT_SIGRETURN,   SWI_THUMB_RT_SIGRETURN
>  };
>
> +/*
> + * Stub needed to make sure the FD register (r9) contains the right
> + * value.
> + */
> +static const unsigned long sigreturn_fdpic_codes[3] =3D {
> +    0xe59fc004, /* ldr r12, [pc, #4] to read function descriptor */
> +    0xe59c9004, /* ldr r9, [r12, #4] to setup GOT */
> +    0xe59cf000  /* ldr pc, [r12] to jump into restorer */
> +};
> +
> +static const unsigned long sigreturn_fdpic_thumb_codes[3] =3D {
> +    0xc008f8df, /* ldr r12, [pc, #8] to read function descriptor */
> +    0x9004f8dc, /* ldr r9, [r12, #4] to setup GOT */
> +    0xf000f8dc  /* ldr pc, [r12] to jump into restorer */
> +};
>
>  static inline int valid_user_regs(CPUARMState *regs)
>  {
> @@ -2149,7 +2164,21 @@ setup_return(CPUARMState *env, struct target_sigac=
tion *ka,
>  {
>      abi_ulong handler =3D ka->_sa_handler;
>      abi_ulong retcode;
> -    int thumb =3D handler & 1;
> +    abi_ulong funcdesc_ptr =3D 0;
> +
> +    int thumb;
> +    int is_fdpic =3D ((TaskState *)thread_cpu->opaque)->is_fdpic;
> +
> +    if (is_fdpic) {
> +        /* In FDPIC mode, ka->_sa_handler points to a function
> +         * descriptor (FD). The first word contains the address of the
> +         * handler. The second word contains the value of the PIC
> +         * register (r9).  */
> +        funcdesc_ptr =3D ka->_sa_handler;

You already have ka->_sa_handler in the 'handler' local, so you
can just use that.

> +        get_user_ual(handler, funcdesc_ptr);

You need to check whether get_user_ual() returned non-zero
(indicating that the descriptor isn't readable) and handle that.

> +    }
> +    thumb =3D handler & 1;
> +
>      uint32_t cpsr =3D cpsr_read(env);
>
>      cpsr &=3D ~CPSR_IT;
> @@ -2160,20 +2189,50 @@ setup_return(CPUARMState *env, struct target_siga=
ction *ka,
>      }
>
>      if (ka->sa_flags & TARGET_SA_RESTORER) {
> -        retcode =3D ka->sa_restorer;
> -    } else {
> -        unsigned int idx =3D thumb;
> +        if (is_fdpic) {
> +            /* For FDPIC we ensure that the restorer is called with a
> +             * correct r9 value.  For that we need to write code on
> +             * the stack that sets r9 and jumps back to restorer
> +             * value.
> +             */
> +            if (thumb) {
> +                __put_user(sigreturn_fdpic_thumb_codes[0], rc);
> +                __put_user(sigreturn_fdpic_thumb_codes[1], rc + 1);
> +                __put_user(sigreturn_fdpic_thumb_codes[2], rc + 2);
> +                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
> +            } else {
> +                __put_user(sigreturn_fdpic_codes[0], rc);
> +                __put_user(sigreturn_fdpic_codes[1], rc + 1);
> +                __put_user(sigreturn_fdpic_codes[2], rc + 2);
> +                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
> +            }
>
> -        if (ka->sa_flags & TARGET_SA_SIGINFO) {
> -            idx +=3D 2;
> +            retcode =3D rc_addr + thumb;
> +        } else {
> +            retcode =3D ka->sa_restorer;
>          }
> +    } else {
> +        if (is_fdpic) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "arm: FDPIC signal return not implemented");
> +            abort();

The kernel setup_return() doesn't seem to do anything special
for this case -- why do we need to abort() ?

> +        } else {
> +            unsigned int idx =3D thumb;
> +
> +            if (ka->sa_flags & TARGET_SA_SIGINFO) {
> +                idx +=3D 2;
> +            }
>
> -        __put_user(retcodes[idx], rc);
> +            __put_user(retcodes[idx], rc);
>
> -        retcode =3D rc_addr + thumb;
> +            retcode =3D rc_addr + thumb;
> +        }
>      }
>
>      env->regs[0] =3D usig;
> +    if (is_fdpic) {
> +        get_user_ual(env->regs[9], funcdesc_ptr + 4);

This also needs to check for unreadable memory. You might find it
easier to read both halves of the descriptor at the same point
in the code, the same way the kernel's setup_return() does.

> +    }

thanks
-- PMM
