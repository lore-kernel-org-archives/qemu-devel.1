Received: from eggs.gnu.org ([2001:4830:134:3::10]:39774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpf4V-0007ox-1D
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpf4F-0007Ia-2V
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:33:38 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fpf4E-0007H5-Ht
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:33:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id c14-v6so13392969wmb.4
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 12:33:21 -0700 (PDT)
References: <1528768140-17894-1-git-send-email-cota@braap.org>
	<20180813200116.GA18755@flamenco> <87d0ulfe1s.fsf@linaro.org>
	<20180814182703.GA24096@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180814182703.GA24096@flamenco>
Date: Tue, 14 Aug 2018 20:33:19 +0100
Message-ID: <87a7pog2v4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/14] fp-test + hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Aug 14, 2018 at 11:17:03 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> > Would be great to get this in for 3.1.
>>
>> I would like this merged by 3.1 as well. However I think there is still
>> some work to be done on the testing side. IIRC the fptest case works
>> with whitelists and I'd like to understand more about why we can't use
>> the whole test corpus? Is it testing features we don't have on all
>> architectures or just because it wouldn't pass because of holes in our
>> current softfloat?
>
> Some test patterns are just strange. For instance:
>
> d64+ =3D0 -1e-398 +0e-398 -> -1e-398
>
> I think the IBM implementation uses 128 bits and then truncates to
> whatever precision is required (64b in this case), so those tests
> might make sense then. But for us, those tests don't make any sense.
>
> The use of whitelists is a temporary workaround to avoid those weird
> test patterns. The right fix is to keep our own set of test patterns,
> without needing whitelisting.
> BTW with this patchset we use 76572 out of 130471 test patterns, which
> isn't bad at all. The whitelist is currently only 2% of the 130K.
>
>> Our experience of SVE has shown that despite the fairly extensive
>> testing we did there are still a bunch of corner cases we missed.
>> Hopefully the last few patches have fixed that but I guess it pays to be
>> exhaustive.
>
> Agreed. That's why I wrote fp-test (and BTW found a bug in softfloat
> thanks to it.)
>
>> We now have the check-tcg infrastructure in place so it would be nice to
>> have proper native tests in place for each architecture. My experience
>> of the fcvt.c test case however is you end up using inline assembler to
>> ensure you exercise the right guest opcodes which makes it hard to
>> generalise for lots of architectures.
>
> I think testing using assembly is necessary, but not sufficient.
> That's why having tests that test the FP primitives directly
> (like fp-test does with `-t soft`) is valuable, since you can
> trivially exercise corner cases. Then you have to test that the
> ISA's decoder does the right thing, but that's a separate test.
>
>> I had written a bunch of patches
>> against the fptest to get it built under check-tcg but it was painful:
>>
>>   * needed a lot of boilerplate for each new operation
>
> That depends on the op. If you want to test anything other than 32/64b
> ops, then yes, you need to add some boilerplate. But otherwise it
> is quite simple, for instance see patch 2.

Well half-precision is the next obvious thing that needs adding. If we
ever re-factor the rest of the code for our weird 80 bit float cousins
that will need adding as well.

>
>>   * a bit hacky to build as unit test and as tcg test
>
> It's not clear to me what the value as a TCG test is; each ISA
> would have its own set of test patterns (and this set is distinct
> from the test patterns we're using here, since those are only
> a subset of the 754 standard).

Well nominally they are all IEEE right? But yeah I think directed tests
are the answer here.

>
> So, my proposal for a v5:
>
> - Commit the test files we need, instead of downloading them from
>   the web. No whitelisting/exceptions except for tininess
>   detection, which is necessary.

Sounds good to me. Perhaps we could do a one time conversion of the test
files so they are a little more readable if we are going to own/extend
them?

>
> - fp-test is added to make test. This is a unit test of softfloat,
>   not a TCG unit test.
>
> - We defer TCG unit tests of FP to a later time.

Yeah mashing the two together is probably more trouble than it's worth.

I was playing around trying to improve the fcvt test (horribly WIP):

 https://github.com/stsquad/qemu/tree/arm/more-fcvt-tests

Anyway I'm coming to the conclusion that what we need for the TCG tests
is a generalised op tester framework that make it easy to plug in new
tests with custom inline asm with a minimal amount of fuss. I'll have a
go at this tomorrow - lets see if I can have a common framework that
abstracts away the 1, 2 and 3 source specifics and result size handling.

--
Alex Benn=C3=A9e
