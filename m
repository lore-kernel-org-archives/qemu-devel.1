Received: from eggs.gnu.org ([2001:4830:134:3::10]:55326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpe2O-0002rv-LE
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpe29-0002OY-D6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:27:24 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpe28-0002Na-W7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:27:09 -0400
Date: Tue, 14 Aug 2018 14:27:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180814182703.GA24096@flamenco>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
	<20180813200116.GA18755@flamenco> <87d0ulfe1s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0ulfe1s.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/14] fp-test + hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Aug 14, 2018 at 11:17:03 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > Would be great to get this in for 3.1.
> 
> I would like this merged by 3.1 as well. However I think there is still
> some work to be done on the testing side. IIRC the fptest case works
> with whitelists and I'd like to understand more about why we can't use
> the whole test corpus? Is it testing features we don't have on all
> architectures or just because it wouldn't pass because of holes in our
> current softfloat?

Some test patterns are just strange. For instance:

d64+ =0 -1e-398 +0e-398 -> -1e-398

I think the IBM implementation uses 128 bits and then truncates to
whatever precision is required (64b in this case), so those tests
might make sense then. But for us, those tests don't make any sense.

The use of whitelists is a temporary workaround to avoid those weird
test patterns. The right fix is to keep our own set of test patterns,
without needing whitelisting.
BTW with this patchset we use 76572 out of 130471 test patterns, which
isn't bad at all. The whitelist is currently only 2% of the 130K.

> Our experience of SVE has shown that despite the fairly extensive
> testing we did there are still a bunch of corner cases we missed.
> Hopefully the last few patches have fixed that but I guess it pays to be
> exhaustive.

Agreed. That's why I wrote fp-test (and BTW found a bug in softfloat
thanks to it.)

> We now have the check-tcg infrastructure in place so it would be nice to
> have proper native tests in place for each architecture. My experience
> of the fcvt.c test case however is you end up using inline assembler to
> ensure you exercise the right guest opcodes which makes it hard to
> generalise for lots of architectures.

I think testing using assembly is necessary, but not sufficient.
That's why having tests that test the FP primitives directly
(like fp-test does with `-t soft`) is valuable, since you can
trivially exercise corner cases. Then you have to test that the
ISA's decoder does the right thing, but that's a separate test.

> I had written a bunch of patches
> against the fptest to get it built under check-tcg but it was painful:
> 
>   * needed a lot of boilerplate for each new operation

That depends on the op. If you want to test anything other than 32/64b
ops, then yes, you need to add some boilerplate. But otherwise it
is quite simple, for instance see patch 2.

>   * a bit hacky to build as unit test and as tcg test

It's not clear to me what the value as a TCG test is; each ISA
would have its own set of test patterns (and this set is distinct
from the test patterns we're using here, since those are only
a subset of the 754 standard).

So, my proposal for a v5:

- Commit the test files we need, instead of downloading them from
  the web. No whitelisting/exceptions except for tininess
  detection, which is necessary.

- fp-test is added to make test. This is a unit test of softfloat,
  not a TCG unit test.

- We defer TCG unit tests of FP to a later time.

How does that sound?

		Emilio
