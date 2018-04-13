Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70PW-0004Nv-6V
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70PV-0005iA-Bc
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:14:46 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70PV-0005hy-5g
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:14:45 -0400
Received: by mail-oi0-x244.google.com with SMTP id c3-v6so8675108oib.5
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:14:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406151752.10854-4-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-4-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:14:24 +0100
Message-ID: <CAFEAcA-BS44ZX8=T8_Aptwg5Z0Pynot5PG3UZAf3Qg0se1HKpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC 3/4] linux-user: ARM-FDPIC: Add support
 for signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
> The FDPIC restorer needs to deal with a function descriptor, hence we
> have to extend 'retcode' such that it can hold the instructions needed
> to perform this.
>
> The restorer sequence uses the same thumbness as the exception
> handler (mainly to support Thumb-only architectures).
>
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

> +#if defined(CONFIG_USE_FDPIC)
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
> +#endif
>
>  static inline int valid_user_regs(CPUARMState *regs)
>  {
> @@ -2143,7 +2160,19 @@ setup_return(CPUARMState *env, struct target_sigac=
tion *ka,
>  {
>      abi_ulong handler =3D ka->_sa_handler;
>      abi_ulong retcode;
> +
> +#ifdef CONFIG_USE_FDPIC
> +    int thumb;
> +
> +    if (env->is_fdpic) {
> +        thumb =3D (((abi_ulong *)g2h(ka->_sa_handler))[0]) & 1;
> +    } else {
> +        thumb =3D handler & 1;
> +    }

Dereferencing a pointer obtained by a raw g2h() is very likely
wrong. You want either to use one of the get_user_*() macros, or
a lock_user/__get_user/unlock_user sequence, so that you can
detect whether the guest actually has read access to the address,
and correctly handle the case where it does not.

thanks
-- PMM
