Received: from eggs.gnu.org ([209.51.188.92]:52763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gj8Ng-0005Vq-OI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gj8Nf-000628-Ov
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:58:44 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:47542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gj8Nf-00060u-Bm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:58:43 -0500
Date: Mon, 14 Jan 2019 20:49:02 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20190114194902.GA29211@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190101182745.GA17022@sx9>
	<BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190113185708.GA27922@sx9>
	<CAL1e-=je93qUvfcq3ftNxYucjLYPEZf=dPXv6tSuzsE3SdsWKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=je93qUvfcq3ftNxYucjLYPEZf=dPXv6tSuzsE3SdsWKw@mail.gmail.com>
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
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Maciej W. Rozycki" <macro@linux-mips.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, Aurelien Jarno <aurelien@aurel32.net>

Hi Aleksandar,

> Awesome!
> 
> I am especially happy with your choice of naming "mmr" (MultiMedia
> Registers) for these fieilds, since that is what they really are (and they
> are certainly not "gprs"). Right on the money!

Great, thanks!

> > For HI1 and LO1 only? I'm asking since HI0 and LO0 are implemented with
> > the DSP array anyway, for all ISAs.
> 
> I leave it to your judgement. If you are not sure (or you find the current
> implementation too sensitive or contrieved to touch), you can leave HI1/LO1
> fields implementation as it is now. My motivation was avoiding usage of the
> same data fields for two relatively independant purposes.

I think the change is simple, but what should we call the new variables?

/* global register indices */
static TCGv cpu_gpr[32], cpu_PC;
static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
static TCGv cpu_HI1, cpu_LO1;    /* Upper half of 128-bit TX79 HI and LO */

Something like the last line?

By the way, what are your thoughts on "[PATCH v2 3/6] target/mips: Fix
HI[ac] and LO[ac] 32-bit truncation with MIPS64 DSP ASE"?

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01287.html

> Outstanding! I salute your including PCPYUD and PCPYLD in this group - they
> too can be considered "basic R/W access to mmr".

Good, many thanks!

> The goal right now is to prepare basic stuff related to SA register, even
> though there is possibly no immediate any application use case. However,
> this will make potential future development considerably easier, so please
> include handling of this register and these instructions.

Done, although I have some minor clean-ups left to do. I have checked with
R5900 hardware to match the implementation defined value of the SA register.

I will post MFSA, MTSA, MTSAB and MTSAH in v2 of this patch series.

> Regarding segments:
> 
> +    int rs = extract32(ctx->opcode, 21, 5);
> +    int rt = extract32(ctx->opcode, 16, 5);
> +    int rd = extract32(ctx->opcode, 11, 5);
> 
> Please include them in gen_XXX() functions, rather than in decode_XXX()
> functions. This will leave decode_XXX() functions with a single
> responsibility of detecting what instruction is about to be processed,
> which is cleaner from logical decomposition point of view (even if it would
> sometimes result in the repetition of some code segments - logical
> decomposition is of far greater importance).

Done!

Fredrik
