Received: from eggs.gnu.org ([209.51.188.92]:44279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkDxQ-0001B8-EW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkDxP-0007Ys-Ha
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:08:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gkDxP-0007WV-5N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:08:07 -0500
Date: Thu, 17 Jan 2019 15:08:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190117200805.GA14264@flamenco>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 17, 2019 at 18:55:33 +0000, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 18:30, Emilio G. Cota <cota@braap.org> wrote:
> > What are the contents of "int-to-float.err"?
> 
> linux1@lxub05:~$ cat qemu/build/all/tests/fp/int-to-float.err
> >> Testing i32_to_f16, rounding near_even
> 372 tests total.
> 372 tests performed.
> >> Testing i64_to_f16, rounding near_even
> 756 tests total.
> 756 tests performed.
> >> Testing i32_to_f32, rounding near_even
> 372 tests total.
> 372 tests performed.
> >> Testing i64_to_f32, rounding near_even
> 756 tests total.
> 756 tests performed.
> >> Testing i32_to_f64
> 372 tests total.
> 372 tests performed.
> >> Testing i64_to_f64, rounding near_even
> 756 tests total.
> 756 tests performed.
> >> Testing i32_to_f128
> 372 tests total.
> 21 tests performed; 20 errors found.

I see, so i32_to_f128 is failing on this host. Is there
a s390x machine I could access? I don't see one in the
gcc compile farm.

> > diff --git a/tests/fp/Makefile b/tests/fp/Makefile
> > index 5019dcdca0..5a35e7c210 100644
> > --- a/tests/fp/Makefile
> > +++ b/tests/fp/Makefile
> > @@ -65,8 +65,7 @@ QEMU_CFLAGS += $(TF_OPTS)
> >  TF_CFLAGS :=
> >  TF_CFLAGS += -Wno-strict-prototypes
> >  TF_CFLAGS += -Wno-unknown-pragmas
> > -TF_CFLAGS += -Wno-discarded-qualifiers
> > -TF_CFLAGS += -Wno-maybe-uninitialized
> > +TF_CFLAGS += -Wno-uninitialized
> >  TF_CFLAGS += -Wno-missing-prototypes
> >  TF_CFLAGS += -Wno-return-type
> >  TF_CFLAGS += -Wno-unused-function
> 
> configure has logic to check whether it can use particular
> warning enable/disable flags. Newer gcc (and I hope clang
> but forget) will happily silently allow -Wno-random-new-thing
> even if they don't support -Wrandom-new-thing) but I'm not
> sure our minimum compiler version is yet new enough to
> be able to rely on that (indeed the warning messages suggest
> it is not).

I figured that -Wno-unitialized is documented to work on both
gcc and clang, and the change in testfloat drops the need
for no-discarded-qualifiers, so we can go with this without
messing with configure.

> > diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
> > index ca9fa2ba05..5a59dcec19 160000
> > --- a/tests/fp/berkeley-testfloat-3
> > +++ b/tests/fp/berkeley-testfloat-3
> > @@ -1 +1 @@
> > -Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
> > +Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
> > diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
> > index fca576309c..2a35ef601d 100644
> > --- a/tests/fp/fp-test.c
> > +++ b/tests/fp/fp-test.c
> > @@ -789,7 +789,7 @@ static int set_init_flags(const char *flags)
> >      return 0;
> >  }
> >
> > -static uint8_t slow_clear_flags(void)
> > +static uint_fast8_t slow_clear_flags(void)
> >  {
> >      uint8_t prev = slowfloat_exceptionFlags;
> >
> > @@ -797,7 +797,7 @@ static uint8_t slow_clear_flags(void)
> >      return prev;
> >  }
> >
> > -static uint8_t qemu_clear_flags(void)
> > +static uint_fast8_t qemu_clear_flags(void)
> >  {
> >      uint8_t prev = qemu_flags_to_sf(qsf.float_exception_flags);
> 
> Why are we using uint_fast8_t here anyway? We switched
> softfloat to using plain old uint8_t everywhere a while
> back.

berkeley-testfloat-3 uses uint_fast8_t extensively,
and these function signatures come from it, not from our
softfloat implementation.

Thanks,

		E.
