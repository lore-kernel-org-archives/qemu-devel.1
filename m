Received: from eggs.gnu.org ([208.118.235.92]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gbXwJ-0007r3-F0
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gbXwH-0007f6-Rv
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:39:06 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gbXwG-0007dS-C7
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 16:39:05 -0500
Received: by mail-oi1-x242.google.com with SMTP id j21so10593672oii.8
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 13:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20181224191555.14187-1-cota@braap.org>
In-Reply-To: <20181224191555.14187-1-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Dec 2018 21:38:52 +0000
Message-ID: <CAFEAcA8Bh4q8UdYznLF2E7wZR2p-bF7Zfog90dzeZOc4AfMrMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] softfloat: enforce softfloat if the host's
 FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On Mon, 24 Dec 2018 at 19:16, Emilio G. Cota <cota@braap.org> wrote:
> The added branch to the FMA ops is marked as unlikely and therefore
> its impact on performance (measured with fp-bench) is within noise range
> when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

> +        /* check whether avx is usable */
> +        if (c & bit_OSXSAVE) {
> +            int bv;
> +
> +            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
> +            if ((bv & 6) == 6) {
> +                has_avx = c & bit_AVX;
> +            }
> +        }

I note that the code in tcg/i386/tcg-target.inc.c
that does something similar has the note:
            /* The xgetbv instruction is not available to older versions of
             * the assembler, so we encode the instruction manually.
             */
 -- does that concern apply here?

This will also be the fourth piece of code that has an
inline xgetbv asm insn to try to query a property of the
CPU (the other 3 are target/i386/hvf/x86_cpuid.c, util/bufferiszero.c
and tcg/i386/tcg-target.inc.c), which strongly suggests that we
should abstract this out a bit better. That also might help
avoid bugs which exist in one version but not the other:
see for instance https://bugs.launchpad.net/bugs/1758819

thanks
-- PMM
