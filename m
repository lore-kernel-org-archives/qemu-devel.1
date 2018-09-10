Received: from eggs.gnu.org ([2001:4830:134:3::10]:60966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzNtX-0000PQ-RV
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzNtT-0002BO-50
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:14:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzNtS-0002Az-Qn
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:14:27 -0400
Date: Mon, 10 Sep 2018 11:14:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180910151424.GC19941@flamenco>
References: <20180908191735.22861-1-cota@braap.org> <878t49d24d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t49d24d.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] softfloat tests based on berkeley's
 testfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On Mon, Sep 10, 2018 at 12:26:58 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > A few fixes since yesterday's v1:
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00884.html
> >
> > - Convert copy_qemu_to_soft80 to qemu_to_soft80, just like the other
> >   conversion functions
> > - Set fp-test as the program name as reported by itself
> > - Fix Makefile to include .d files so that dependencies are
> >   properly tracked
> > - Update commit log
> 
> Just some general comments:
> 
>  - I think this is a better way to go than the IBM test suite
>  - I'm ambivalent about maintaining our fp-test.c in close alignment to
>    softfloat unless we expect much upstreaming of changes.

I don't think there'll be any, to be honest. They have a git repo but
I doubt they'll take any patches. This was just a minimum attempt to
get some tests working (I don't have a lot of time to work on this)

>  - the coverage seems a bit low. Rebuilding everything with
>    --enable-gcov and running -all1 -all2 I get:
> 
>   tests/fp/fp-test.c - 53.5 % coverage 43.3 % branch coverage
>   fpu/softfloat.c - 32.5 % coverage 25.1 % branch coverage
> 
> But maybe I didn't pass enough options to fp-test? I could really do
> with a --just-run-everything-and-summarise-failing-functions option so I
> can then go through in more detail with fp-test fFOO_BAR.

Yes right now to get better coverage you need to run it several times.
After a few runs I got it to 58%, but still without testing some
rounding modes. So considering we're coming from 0% coverage, I'd
say coverage is pretty good!

But yes, we should add a flag to just test -all.

There are some functions that we are not testing yet though, but
that can be fixed over time (we can add more tests to fp-test even
though they're not in testfloat, such as testing flush-to-zero/
denormals-are-zero, or the muladd variants that we have).

I have basically no time left to work on this. What do you think about
the following plan?

1. Have our own clones (forks) of testfloat/softfloat in qemu servers.
2. Add those as submodules
3. Add fp-test with as you said an -all flag that reports all
   errors to get decent coverage.
4. Add hardfloat patches, with tests. This requires a small
   change to testfloat:
   https://github.com/cota/berkeley-testfloat-3/commit/ca9fa2ba05

I'd then leave adding further tests to increase coverage and fixing
the existing bugs (prior to hardfloat) to someone else with
more time/resources.

Thanks,

		Emilio
