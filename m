Received: from eggs.gnu.org ([209.51.188.92]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkDzl-0002fY-Kw
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkDze-00032J-5v
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:10:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gkDzZ-0002gp-BF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:10:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id t6so12395545wrr.12
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:10:16 -0800 (PST)
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
Date: Thu, 17 Jan 2019 20:10:13 +0000
Message-ID: <871s5byriy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 17 Jan 2019 at 18:30, Emilio G. Cota <cota@braap.org> wrote:
>>
>> On Thu, Jan 17, 2019 at 17:37:54 +0000, Peter Maydell wrote:
>> > On Thu, 17 Jan 2019 at 13:27, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> > >
>> > > The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc9=
1319dbc:
>> > >
>> > >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-req=
uest' into staging (2019-01-15 17:24:00 +0000)
>> > >
>> > > are available in the Git repository at:
>> > >
>> > >   https://github.com/stsquad/qemu.git tags/pull-fpu-next-170119-1
>> (snip)
>> >
>> > FreeBSD, OSX, x86-64 Linux clang builds:
>> (snip)
>> > PPC64, AArch64:
>> (snip)
>> > NetBSD:
>> (snip)
>>
>> I have added a few commits to fix these -- diff below.
>> Note that one fix requires a small change in the testfloat
>> submodule, which I'm pulling here.
>>
>> Alex, can you cherry-pick the commits in this branch?
>>
>>   https://github.com/cota/qemu/tree/bennee-pull
>>
>> They should go in before adding fp-test to the automated build,
>> of course. I left them at the top to make it easier for
>> you to cherry-pick.
>>
>> Also, since this will require a respin, you might want to fix the
>> "Makfile" typo in patch 7's title.
>>
>> > S390X host:
>> > Looks like a failure running the tests, but no diagnostics about
>> > what exactly went wrong or clear "test failed" indicator:
>> >
>> > cd /home/linux1/qemu/build/all/tests/fp && ./fp-test -s -l 1
>> > i32_to_f16 i64_to_f16 i32_to_f32 i64_t
>> > o_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
>> > int-to-float.out 2>  int-to-float.err
>> > /home/linux1/qemu/tests/Makefile.include:913: recipe for target
>> > 'check-softfloat-conv' failed
>> > make: *** [check-softfloat-conv] Error 1
>>
>> What are the contents of "int-to-float.err"?
>
<snip>
>>> Testing i32_to_f128
> 372 tests total.
> 21 tests performed; 20 errors found.

It's probably not a regression but a failure in the old f128 code. When
I was enabling the tests I basically turned them all on and then
disabled what failed (all of which was exercising non-refactored code).
But of course this was all on x86_64 (although I also ran them on a
aarch64 host). It looks like more errors come out on a s390x host for
some reason. You can run manually for a more complete test with more
coverage:

  ./fp-test -l 2 -r all i32_to_f128

>
>
>> diff --git a/tests/fp/Makefile b/tests/fp/Makefile
>> index 5019dcdca0..5a35e7c210 100644
>> --- a/tests/fp/Makefile
>> +++ b/tests/fp/Makefile
>> @@ -65,8 +65,7 @@ QEMU_CFLAGS +=3D $(TF_OPTS)
>>  TF_CFLAGS :=3D
>>  TF_CFLAGS +=3D -Wno-strict-prototypes
>>  TF_CFLAGS +=3D -Wno-unknown-pragmas
>> -TF_CFLAGS +=3D -Wno-discarded-qualifiers
>> -TF_CFLAGS +=3D -Wno-maybe-uninitialized
>> +TF_CFLAGS +=3D -Wno-uninitialized
>>  TF_CFLAGS +=3D -Wno-missing-prototypes
>>  TF_CFLAGS +=3D -Wno-return-type
>>  TF_CFLAGS +=3D -Wno-unused-function
>
> configure has logic to check whether it can use particular
> warning enable/disable flags. Newer gcc (and I hope clang
> but forget) will happily silently allow -Wno-random-new-thing
> even if they don't support -Wrandom-new-thing) but I'm not
> sure our minimum compiler version is yet new enough to
> be able to rely on that (indeed the warning messages suggest
> it is not).
>
>> diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat=
-3
>> index ca9fa2ba05..5a59dcec19 160000
>> --- a/tests/fp/berkeley-testfloat-3
>> +++ b/tests/fp/berkeley-testfloat-3
>> @@ -1 +1 @@
>> -Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
>> +Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
>> diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
>> index fca576309c..2a35ef601d 100644
>> --- a/tests/fp/fp-test.c
>> +++ b/tests/fp/fp-test.c
>> @@ -789,7 +789,7 @@ static int set_init_flags(const char *flags)
>>      return 0;
>>  }
>>
>> -static uint8_t slow_clear_flags(void)
>> +static uint_fast8_t slow_clear_flags(void)
>>  {
>>      uint8_t prev =3D slowfloat_exceptionFlags;
>>
>> @@ -797,7 +797,7 @@ static uint8_t slow_clear_flags(void)
>>      return prev;
>>  }
>>
>> -static uint8_t qemu_clear_flags(void)
>> +static uint_fast8_t qemu_clear_flags(void)
>>  {
>>      uint8_t prev =3D qemu_flags_to_sf(qsf.float_exception_flags);
>
> Why are we using uint_fast8_t here anyway? We switched
> softfloat to using plain old uint8_t everywhere a while
> back.
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
