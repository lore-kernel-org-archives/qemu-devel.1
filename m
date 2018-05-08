Received: from eggs.gnu.org ([2001:4830:134:3::10]:39239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFzqc-0005ob-7x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFzqb-00064z-B5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:27:54 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFzqb-00064j-5w
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:27:53 -0400
Received: by mail-oi0-x242.google.com with SMTP id k5-v6so21058573oiw.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:27:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180304173232.22814-4-laurent@vivier.eu>
References: <20180304173232.22814-1-laurent@vivier.eu>
	<20180304173232.22814-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 11:27:31 +0100
Message-ID: <CAFEAcA_GdDQnAe+BC1OmeDjEC-b3j1kJ03M3As=MJ-6MBCKcbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/5] target/m68k: add fmod/frem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4 March 2018 at 17:32, Laurent Vivier <laurent@vivier.eu> wrote:
> Using a local m68k floatx80_mod()
> [copied from previous:
> Written by Andreas Grabher for Previous, NeXT Computer Emulator.]
>
> The quotient byte of the FPSR is updated with
> the result of the operation.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20180224201802.911-3-laurent@vivier.eu>

Hi; Coverity points out that there's a bug in the
floatx80_mod() function this patch introduces (CID 1390568):

> +    expDiff -= 64;
> +    while (0 < expDiff) {
> +        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
> +        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
> +        mul64To128(bSig, qTemp, &term0, &term1);
> +        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
> +        shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
> +    }

This loop condition checks expDiff, but the loop body
never changes that variable, so if we go round the loop
at all then we'll do so forever.

thanks
-- PMM
