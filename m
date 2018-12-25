Received: from eggs.gnu.org ([208.118.235.92]:57083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbgd0-0004cG-FT
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 01:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbgcv-0000nB-IE
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 01:55:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gbgcv-0000md-BP
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 01:55:41 -0500
Date: Tue, 25 Dec 2018 01:55:39 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181225065539.GA12687@flamenco>
References: <20181224191555.14187-1-cota@braap.org>
	<CAFEAcA8Bh4q8UdYznLF2E7wZR2p-bF7Zfog90dzeZOc4AfMrMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Bh4q8UdYznLF2E7wZR2p-bF7Zfog90dzeZOc4AfMrMQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Dec 24, 2018 at 21:38:52 +0000, Peter Maydell wrote:
> On Mon, 24 Dec 2018 at 19:16, Emilio G. Cota <cota@braap.org> wrote:
> > The added branch to the FMA ops is marked as unlikely and therefore
> > its impact on performance (measured with fp-bench) is within noise range
> > when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
> 
> > +        /* check whether avx is usable */
> > +        if (c & bit_OSXSAVE) {
> > +            int bv;
> > +
> > +            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
> > +            if ((bv & 6) == 6) {
> > +                has_avx = c & bit_AVX;
> > +            }
> > +        }
> 
> I note that the code in tcg/i386/tcg-target.inc.c
> that does something similar has the note:
>             /* The xgetbv instruction is not available to older versions of
>              * the assembler, so we encode the instruction manually.
>              */
>  -- does that concern apply here?

Yes.

> This will also be the fourth piece of code that has an
> inline xgetbv asm insn to try to query a property of the
> CPU (the other 3 are target/i386/hvf/x86_cpuid.c, util/bufferiszero.c
> and tcg/i386/tcg-target.inc.c), which strongly suggests that we
> should abstract this out a bit better. That also might help
> avoid bugs which exist in one version but not the other:
> see for instance https://bugs.launchpad.net/bugs/1758819

Agreed.

I'll be away until mid-January starting tomorrow, so I'll
send a v2 with the cpuid bits removed, which aren't needed
to fix the bug that Laurent hit.

We can later on address cpuid consolidation.

Thanks,

		Emilio
