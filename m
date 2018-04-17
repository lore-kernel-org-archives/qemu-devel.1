Received: from eggs.gnu.org ([2001:4830:134:3::10]:32870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8YQY-0007sw-4h
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8YQX-0007Ul-6Y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:46:14 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:43967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8YQW-0007RX-Uq
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:46:13 -0400
Received: by mail-ot0-x230.google.com with SMTP id d9-v6so23071638oth.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:46:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417212710.GA10948@flamenco>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 22:45:51 +0100
Message-ID: <CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 17 April 2018 at 22:27, Emilio G. Cota <cota@braap.org> wrote:
> BTW I just checked with -t host on an IBM Power8, and we get
> the same 1049 flag errors we get with -t soft plus two additional ones:
>
> +A 0xffb00000, expected: 0x7fa00000, returned: 0x7fa00000, \
>   expected exceptions: i, returned: none
> +error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:382:
> +b32A =0 S -> S i

That's Abs of an SNaN; the test expects Invalid, which is wrong,
because IEEE754 says absolute-value is a "quiet-computational
operation" that never signals an exception.

What's odd is that we don't report that error for the softfloat
implementation! I also don't understand why the expected value
isn't just the input value with the sign bit flipped.

> (...)
> +cff 0xffb00000, expected: 0x7ff8000000000000, returned: 0x7ff4000000000000, \
>   expected exceptions: i, returned: none
> +error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:26170:
> +b32b64cff =0 S -> Q i

SNaN conversion from 32 bit to 64 bit. Here I agree
with the test -- we should quieten the NaN and raise
Invalid -- which implies that the hardware is wrong ?!?

thanks
-- PMM
