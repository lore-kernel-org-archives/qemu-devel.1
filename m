Received: from eggs.gnu.org ([209.51.188.92]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3MMo-0004sd-DW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3MEh-0006gs-BO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:49:04 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3MEh-0006gM-1s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:49:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id x187so3839817oia.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <1551978650-23207-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251FE1DD4630A150FFA1747C6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<CAFEAcA-5D7nHBgb2hY+BT6CtTbt_qBQUL1KdLsoQLWsfyvRt6Q@mail.gmail.com>
	<BN6PR2201MB125142E0D49100AA21CBFB36C6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<87ftrt5wb2.fsf@zen.linaroharston>
	<BN6PR2201MB12515708748670C8F930B088C6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12515708748670C8F930B088C6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 14:48:50 +0000
Message-ID: <CAFEAcA-osjnv83OL+uma-YekZvhCFGP8JpgZUzUniZHrQG2WFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/mips: Fix minor bug in FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Mon, 11 Mar 2019 at 14:35, Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
> I'll doublecheck, but I think "infzero" here is a misnomer.
>
> The variable/argument "infzero" actually denotes the cases:
>
>    - "Inf * Zero +/- NaN"
>    - "Inf * Zero +/- NaN"
>    - "Zero * Inf +/- NaN"
>    - "Zero * Inf +/- NaN"
>
> "Inf * Zero +/- !NaN (let's say, normal fp)" is handled
> somewhere else.
>
> Therefore, "infzero" should be rather called "infzeronan".
> This is from what I remember, but I will reanalyse the
> relevant softfloat code one more time.

Yes; we don't ask the target-dependent code to pick a NaN
in the case of 0 * inf + not-a-NaN because the IEEE spec
entirely defines the behaviour there (you get the default
NaN and Invalid is set), so that case is handled in the
generic softfloat code. (The flag is called 'infzero'
probably because in the calling code it indicates all
the inf * zero cases, not just the info * zero + nan ones).

It's specifically the (0,inf,qnan) and (inf,0,qnan) cases
where the spec allows the implementation to decide whether
they raise Invalid or not (and what qnan to return if they
do), so this is why we pass that flag through to the
pick-a-NaN routine.

It looks like this part of the MIPS-specific code was
incorrectly copied from the Arm implementation (which does
return the default NaN here).


As well as what the right NaN value should be, the other
question for this function for the (0, inf, qnan) case is
"should we raise Invalid?" -- what does the MIPS spec
require here?

thanks
-- PMM
