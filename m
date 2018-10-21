Received: from eggs.gnu.org ([2001:4830:134:3::10]:42798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEFXx-0001Nu-6a
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEFXw-0004BL-D9
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:41 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:44433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEFXw-0004B7-7y
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:40 -0400
Received: by mail-oi1-x22b.google.com with SMTP id u74-v6so30261536oia.11
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 08:21:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_08zpaSh3g76dXXqzFoAepHzMzo_Bac8BrGJqGRL=n=A@mail.gmail.com>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
	<CAFEAcA-NEN7MymyzmeOwz7bX99P_o6D9dMraHYA8LcFS7w9=_A@mail.gmail.com>
	<12592ba3-ea47-e7c2-d67b-c58012c64287@linaro.org>
	<CAFEAcA_08zpaSh3g76dXXqzFoAepHzMzo_Bac8BrGJqGRL=n=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Oct 2018 16:21:19 +0100
Message-ID: <CAFEAcA-nwrSOzzO_xjTaML27fjQDJnGnSBO9uap1rRQFxahcZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 October 2018 at 16:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> Any idea what's going on here? tcg/tcg.h has a comment saying
>  * The cmpxchg functions are only defined if HAVE_CMPXCHG128
> so presumably the issue is that the helper-a64 code is
> trying to refer to them anyway. There certainly doesn't
> seem to be any kind of #defining around the listed functions
> in helper-a64.c to stop them being compiled in this situation.
>
> NB: I build with --enable-debug in this tree -- are you
> perhaps accidentally relying on the compiler's optimisation
> to discard these functions if they're not needed?

Adding a #if HAVE_CMPXCHG128 around the helper-a64.c
functions just pushes the link error back a step to the
references to those helpers:
  LINK    aarch64-softmmu/qemu-system-aarch64w.exe
tcg/tcg.o:tcg.c:(.rdata+0x9810): undefined reference to
`helper_paired_cmpxchg64_le_parallel'
tcg/tcg.o:tcg.c:(.rdata+0x9830): undefined reference to
`helper_paired_cmpxchg64_be_parallel'
tcg/tcg.o:tcg.c:(.rdata+0x9840): undefined reference to
`helper_casp_le_parallel'
tcg/tcg.o:tcg.c:(.rdata+0x9850): undefined reference to
`helper_casp_be_parallel'

which in turn I guess is because they're in the array
of all helpers in tcg.c, so we need to also #if out the
prototypes in helper-a64.h, which is awkward because
there we don't have the HAVE_CMPXCHG128 defined...

thanks
-- PMM
