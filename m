Received: from eggs.gnu.org ([2001:4830:134:3::10]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f1D7w-000681-Gs
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f1D7t-0000YZ-95
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:36:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f1D7t-0000Y3-33
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:36:37 -0400
Date: Wed, 28 Mar 2018 11:36:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180328153633.GA18182@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-3-git-send-email-cota@braap.org>
	<87zi2t968i.fsf@linaro.org> <20180327180018.GC2693@flamenco>
	<87lgec8r4t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgec8r4t.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 02/14] tests: add fp-test,
 a floating point test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, Mar 28, 2018 at 10:51:30 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> >> So this is a unit test of our code rather than a test program running
> >> under QEMU?
> >
> > Having the -t host/soft flags allows you flexibility in what to test.
> >
> > With "host" mode, you're generating a binary that knows nothing
> > about QEMU, i.e. all its FP operations are native. You can use this
> > to (1) figure out whether your host diverts from the model [hopefully
> > it doesn't in anything substantial], and (2) test whether QEMU mimics
> > the corresponding host by running the binary under *-linux-user.
> 
> OK - there is no reason why we can't cross compile the single source
> file for multiple tests/tcg/targets. I'll look at that when I have
> another run at the cross compile stuff.

In fact I tried this first. I generated one executable per target,
compiling softfloat.o with the corresponding -DTARGET_FOO.

Then I realised this isn't good enough. The problem is that this
only buys you the target-specific part of softfloat, which boils
down to sNaN representation and little else. You still have to
pass your own float_status (with rounding etc.), and decide whether
to act or to ignore whatever flags softfloat sets after an op.

In short, having this without having the actual target code doesn't
buy you much.

I think a better alternative is to:
1- Compile fp-test using host mode on actual hardware. Let's call
   this executable fp-test-host-$arch.
2- Compare fp-test results of running on actual hardware against
   running fp-test-host-$arch on linux-user-$arch.

This will give us complete coverage of both softfloat and
the target code that calls softfloat (and raises exceptions etc.).

> >> If so we really should be building this automatically in make check.
> >
> > Yes, passing -soft mode would certainly be valuable and trivial
> > to integrate since there is nothing built that is target-dependent.
> 
> So the two bugs I'm currently fixing are guest dependent so can't be
> caught by soft mode:
> 
>   - ARM FP16 alternative format behaviour
>   - round_to_int_and_pack refactor broke TriCore ftoi insns (1759264)

Yes, passing soft mode is a necessary condition for correctness but
it isn't sufficient--arch-specific bugs can also happen! And those
bugs might be in softfloat and/or in target/$arch/*.

For that we'll need something like what I sketched above.

> I assume your bug was?
> 
>   - fix {min,max}nummag for same-abs-value inputs (from your series)

Yep.

Thanks,

		E.
