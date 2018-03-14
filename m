Received: from eggs.gnu.org ([2001:4830:134:3::10]:37509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ew35y-0003sV-UG
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ew35u-0005HF-1r
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:53:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57350)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ew35t-0005Gl-P3
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:53:13 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAMo8BfLuAdsdRScY+CgTzd0EBn3_kAFc=ysEwgp3MrM_+42viQ@mail.gmail.com>
	<000301d3bb73$e997a8e0$bcc6faa0$@ru>
	<CAMo8Bf+seSrT9HBFL1tspoDQ-9s9nGrXueYRt6v2nF4XzZbdfA@mail.gmail.com>
In-Reply-To: <CAMo8Bf+seSrT9HBFL1tspoDQ-9s9nGrXueYRt6v2nF4XzZbdfA@mail.gmail.com>
Date: Wed, 14 Mar 2018 12:53:08 +0300
Message-ID: <000401d3bb7a$418b9fb0$c4a2df10$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] regression in timer code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Max Filippov' <jcmvbkbc@gmail.com>
Cc: 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>, 'qemu-devel' <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> Sent: Wednesday, March 14, 2018 12:41 PM
> To: Pavel Dovgalyuk
> Cc: Pavel Dovgaluk; qemu-devel
> Subject: Re: regression in timer code?
> 
> On Wed, Mar 14, 2018 at 2:07 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> >> the commit b39e3f34c9de7ead6a11a74aa2de78baf41d81a7
> >> ("icount: fixed saving/restoring of icount warp timers") has changed
> >> something that made timers test for target/xtensa unstable.
> >> Specifically ccount_write case in the tests/tcg/xtensa/test_timer.S
> >> now fails for me about half of the times it is run. Given that it is run
> >> under -icount I guess this is a bug. Could you please take a look?
> >>
> >> The minimal test case is available here:
> >>   http://jcmvbkbc.spb.ru/~dumb/tmp/201803131306/test_timer.tst
> >> It is run as
> >>   qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting
> >> -icount 7  -kernel ./test_timer.tst
> >
> > I investigated your test and concluded the following.
> > First, update_ccount is inaccurate opration because of the division
> > with the remainder:
> >     env->sregs[CCOUNT] = env->ccount_base +
> >         (uint32_t)((now - env->time_base) *
> >                    env->config->clock_freq_khz / 1000000);
> >
> > Therefore, the following sequence in the test may give different result depending
> > of the actual value of "now" variable.
> 
> But the expression above depends on the difference between the now
> and env->time_base, both these values are read from
>  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) and, most importantly,
> the test is 100% deterministic, i.e. it runs under -icount and there's no
> external factors involved, no waiting for anything, not even interrupts.
> Thus the difference must be constant, i.e. I must see consistent results.
> Am I wrong somewhere?

icount is adjusted by icount_warp_rt when CPU sleeps.
These adjustments may be different in different runs.
And the first adjustment is performed at the start of the machine.
Therefore "now" value includes non-deterministic component from the beginning,
but its increments caused by instruction executions are deterministic.

> >     rsr     a3, ccount
> >     rsr     a4, ccount
> >     sub     a4, a4, a3
> >
> > Consider the code:
> >
> > test ccount_write
> >     rsr     a3, ccount
> >     rsr     a4, ccount
> >     sub     a4, a4, a3 ; usually 1, but sometimes 2 because of rounding
> >     movi    a2, 0x12345678
> >     wsr     a2, ccount
> >     esync
> >     rsr     a3, ccount
> >     sub     a3, a3, a2 ; usually 3 (esync + yield + rsr), but sometimes 4 because of
> rounding
> >     slli    a4, a4, 2  ; 4 or 8
> >     assert  ltu, a3, a4 ; (3 or 4) < (4 or 8) ?
> > test_end
> >
> > Therefore in some cases we get a4=4 and a3=4 that forces the test to fail.

Pavel Dovgalyuk
