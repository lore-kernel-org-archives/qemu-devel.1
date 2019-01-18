Received: from eggs.gnu.org ([209.51.188.92]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkV90-0005kc-Nr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkV8z-0004RY-MU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:29:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkV8z-0004No-I0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:29:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so14503160otl.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20190108180014.32386-1-peter.maydell@linaro.org>
In-Reply-To: <20190108180014.32386-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:29:00 +0000
Message-ID: <CAFEAcA-9otDEjp7Q4xmdRPbCxUiEQjaKuxaZMsC9A0jMLRQu2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/user-exec: Don't parse aarch64
 insns to test for read vs write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

Ping for review?

thanks
-- PMM

On Tue, 8 Jan 2019 at 18:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In cpu_signal_handler() for aarch64 hosts, currently we parse
> the faulting instruction to see if it is a load or a store.
> Since the 3.16 kernel (~2014), the kernel has provided us with
> the syndrome register for a fault, which includes the WnR bit.
> Use this instead if it is present, only falling back to
> instruction parsing if not.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Since I originally asked the kernel folks to add the ESR context
> so we could use it in QEMU, I figured that it was about time
> (five years later...) to write the code to make use of it.
>
> I wanted to say "everybody surely has at least a 3.16
> kernel for aarch64 machines" and delete the fallback code,
> but it turns out that the gcc compile farm box has 3.13.0...
> ---
>  accel/tcg/user-exec.c | 66 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 14 deletions(-)
>
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 941295ea49b..66cc818e3f3 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -479,28 +479,66 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>
>  #elif defined(__aarch64__)
>
> +#ifndef ESR_MAGIC
> +/* Pre-3.16 kernel headers don't have these, so provide fallback definitions */
> +#define ESR_MAGIC 0x45535201
> +struct esr_context {
> +    struct _aarch64_ctx head;
> +    uint64_t esr;
> +};
> +#endif
> +
> +static inline struct _aarch64_ctx *first_ctx(ucontext_t *uc)
> +{
> +    return (struct _aarch64_ctx *)&uc->uc_mcontext.__reserved;
> +}
> +
> +static inline struct _aarch64_ctx *next_ctx(struct _aarch64_ctx *hdr)
> +{
> +    return (struct _aarch64_ctx *)((char *)hdr + hdr->size);
> +}
> +
>  int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
>  {
>      siginfo_t *info = pinfo;
>      ucontext_t *uc = puc;
>      uintptr_t pc = uc->uc_mcontext.pc;
> -    uint32_t insn = *(uint32_t *)pc;
>      bool is_write;
> +    struct _aarch64_ctx *hdr;
> +    struct esr_context const *esrctx = NULL;
>
> -    /* XXX: need kernel patch to get write flag faster.  */
> -    is_write = (   (insn & 0xbfff0000) == 0x0c000000   /* C3.3.1 */
> -                || (insn & 0xbfe00000) == 0x0c800000   /* C3.3.2 */
> -                || (insn & 0xbfdf0000) == 0x0d000000   /* C3.3.3 */
> -                || (insn & 0xbfc00000) == 0x0d800000   /* C3.3.4 */
> -                || (insn & 0x3f400000) == 0x08000000   /* C3.3.6 */
> -                || (insn & 0x3bc00000) == 0x39000000   /* C3.3.13 */
> -                || (insn & 0x3fc00000) == 0x3d800000   /* ... 128bit */
> -                /* Ingore bits 10, 11 & 21, controlling indexing.  */
> -                || (insn & 0x3bc00000) == 0x38000000   /* C3.3.8-12 */
> -                || (insn & 0x3fe00000) == 0x3c800000   /* ... 128bit */
> -                /* Ignore bits 23 & 24, controlling indexing.  */
> -                || (insn & 0x3a400000) == 0x28000000); /* C3.3.7,14-16 */
> +    /* Find the esr_context, which has the WnR bit in it */
> +    for (hdr = first_ctx(uc); hdr->magic; hdr = next_ctx(hdr)) {
> +        if (hdr->magic == ESR_MAGIC) {
> +            esrctx = (struct esr_context const *)hdr;
> +            break;
> +        }
> +    }
>
> +    if (esrctx) {
> +        /* For data aborts ESR.EC is 0b10010x: then bit 6 is the WnR bit */
> +        uint64_t esr = esrctx->esr;
> +        is_write = extract32(esr, 27, 5) == 0x12 && extract32(esr, 6, 1) == 1;
> +    } else {
> +        /*
> +         * Fall back to parsing instructions; will only be needed
> +         * for really ancient (pre-3.16) kernels.
> +         */
> +        uint32_t insn = *(uint32_t *)pc;
> +
> +        is_write = ((insn & 0xbfff0000) == 0x0c000000   /* C3.3.1 */
> +                    || (insn & 0xbfe00000) == 0x0c800000   /* C3.3.2 */
> +                    || (insn & 0xbfdf0000) == 0x0d000000   /* C3.3.3 */
> +                    || (insn & 0xbfc00000) == 0x0d800000   /* C3.3.4 */
> +                    || (insn & 0x3f400000) == 0x08000000   /* C3.3.6 */
> +                    || (insn & 0x3bc00000) == 0x39000000   /* C3.3.13 */
> +                    || (insn & 0x3fc00000) == 0x3d800000   /* ... 128bit */
> +                    /* Ignore bits 10, 11 & 21, controlling indexing.  */
> +                    || (insn & 0x3bc00000) == 0x38000000   /* C3.3.8-12 */
> +                    || (insn & 0x3fe00000) == 0x3c800000   /* ... 128bit */
> +                    /* Ignore bits 23 & 24, controlling indexing.  */
> +                    || (insn & 0x3a400000) == 0x28000000); /* C3.3.7,14-16 */
> +    }
>      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>  }
>
> --
> 2.20.1
>
