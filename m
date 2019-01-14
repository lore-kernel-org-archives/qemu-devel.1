Received: from eggs.gnu.org ([209.51.188.92]:60095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1giqMo-0008VH-2Z
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1giqMl-0001OK-PO
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:44:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1giqMg-0001Ko-SK
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:44:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so16568445oii.5
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 16:44:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190113185708.GA27922@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190101182745.GA17022@sx9>
	<BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190113185708.GA27922@sx9>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Jan 2019 01:44:27 +0100
Message-ID: <CAL1e-=je93qUvfcq3ftNxYucjLYPEZf=dPXv6tSuzsE3SdsWKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/tcg/mips: Test R5900
 three-operand MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, Aurelien Jarno <aurelien@aurel32.net>

On Sunday, January 13, 2019, Fredrik Noring <noring@nocrew.org> wrote:

> Hi Aleksandar,
>
> > - Suggestion: The next MIPS pull request is scehuled for Friday,
> > Jan 18, 2018. It would be fantastic if you could prepare the
> > following by Jan 14:
> >
> >   * Add 32 TCGv_i64 registers that would represent higher halves
> >   of R5900 general purpose registers.
>
> Done!


Awesome!

I am especially happy with your choice of naming "mmr" (MultiMedia
Registers) for these fieilds, since that is what they really are (and they
are certainly not "gprs"). Right on the money!


>
> >   * Add TCGv_i32 register SA (shift amount).
>
> See notes below.
>
> >   * Perhaps consider adding higher halves of registers HI an LO
> >   independently on HI/LO array used by DSP.
>
> For HI1 and LO1 only? I'm asking since HI0 and LO0 are implemented with
> the DSP array anyway, for all ISAs.
>
>
I leave it to your judgement. If you are not sure (or you find the current
implementation too sensitive or contrieved to touch), you can leave HI1/LO1
fields implementation as it is now. My motivation was avoiding usage of the
same data fields for two relatively independant purposes.


> >   * It is customary to implement R/W access while introducing
> >   such registers:
> >     * Implement R/W access instructions to higher halves of
> >     R5900 GPRs:
> >       * LQ
>
> Done, including PCPYUD and PCPYLD for proper testing!
>
>
Outstanding! I salute your including PCPYUD and PCPYLD in this group - they
too can be considered "basic R/W access to mmr".


> >       * SQ
>
> Done, including testing!
>
>
Perfect!


> >     * Implement R/W access instructions to SA register:
> >       * MFSA
>
> The TX79 manual says that "the sole purpose of this instruction is to
> permit the shift amount to be saved during a context switch" and that
> "the shift amount is encoded in SA in an implementation-defined manner"
> so it seems to make more sense for system mode rather than user mode?
>
> One may want to choose an implementation that matches the actual R5900
> hardware, even though the manual says it's arbitrary.
>
> >       * MTSA
>
> Likewise.
>
> >       * MTSAH
> >       * MTSAB
>
> These instructions do not appear to be usable unless the corresponding
> shift instructions are implemented as well?
>
>
The goal right now is to prepare basic stuff related to SA register, even
though there is possibly no immediate any application use case. However,
this will make potential future development considerably easier, so please
include handling of this register and these instructions.


> I will post an R5900 multimedia instruction patch series shortly.
>
>
Yes, go ahead, please!

I unfortunatelly will not have enough time for detailed review before
Tuesday, but I have a relatively simple hint right now:

Regarding segments:

+    int rs = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);

Please include them in gen_XXX() functions, rather than in decode_XXX()
functions. This will leave decode_XXX() functions with a single
responsibility of detecting what instruction is about to be processed,
which is cleaner from logical decomposition point of view (even if it would
sometimes result in the repetition of some code segments - logical
decomposition is of far greater importance).

Thanks for all efforts!!

Aleksandar




> Fredrik
>
>
