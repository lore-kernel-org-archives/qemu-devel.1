Received: from eggs.gnu.org ([2001:4830:134:3::10]:58645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8XcS-0007Kx-AU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8XcP-00051p-BP
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:54:28 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:40425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8XcO-0004xc-T9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:54:25 -0400
Received: by mail-oi0-x233.google.com with SMTP id x9-v6so19341362oig.7
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 13:54:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417190439.GA28717@flamenco>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 21:54:03 +0100
Message-ID: <CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
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

On 17 April 2018 at 20:04, Emilio G. Cota <cota@braap.org> wrote:
> Note that in fp-test I am not checking for flags that are raised
> when none are expected, because doing so gives quite a few errors.
> Just noticed that enabling this check yields 1049 of these errors for
> v2.11, and before this patch that number was 1087. After this
> patch, it is again brought down to 1049. IOW, the test cases in
> fp-test raise exactly the same flags as v2.11, which is good to know.
>
> The 1049 errors are probably false positives -- at least a big
> chunk of them should be, given that "-t host" gives even more errors.
> I am tempted to keep the flag check and whitelist these errors
> though, which would catch regressions such as the one we're fixing here.

I strongly suspect we do have a few cases where we get the answers
wrong and/or don't report the flags right, so ideally we'd have
a look at them in more detail...

> Here is the report file with the 1049 failing test cases:
>   http://www.cs.columbia.edu/~cota/qemu/fp-test-after-inf-patch.txt

Syntax for interpreting the report:
https://www.research.ibm.com/haifa/projects/verification/fpgen/syntax.txt

Here's the first one, am I reading it right?

+ 0xffc00000 0xffb00000, expected: 0xffc00000, returned: 0xffc00000,
expected exceptions: none, returned: i
error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:1346:
b32+ =0 Q S -> Q

That's a float32 addition where the first input is a QNaN
and the second an SNaN (presumably the test is configured
for what in QEMU is snan_bit_is_one == 0), and it expects
the result to be the QNaN, with no exceptions set. But
we raise Invalid.
=0 is the rounding mode, not relevant here.

IEEE754-2008 s6.2 seems pretty clear that if there's
an SNaN as an operand then operations like addition should
signal Invalid. So this looks like a bug in the test case
input. (Which is weird, because IBM must have tested this,
so it's odd to see an obvious error in it.)

Most of the "expected none, returned i" lines look
like the same thing. We should look at the others, though.

thanks
-- PMM
