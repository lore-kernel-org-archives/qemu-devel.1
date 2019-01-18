Received: from eggs.gnu.org ([209.51.188.92]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkY99-0003eo-3A
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkY95-0003NJ-8E
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:41:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gkY91-0003C5-Fd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:41:29 -0500
Received: by mail-wr1-x42a.google.com with SMTP id s12so16075662wrt.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:41:17 -0800 (PST)
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<20190117200805.GA14264@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190117200805.GA14264@flamenco>
Date: Fri, 18 Jan 2019 17:41:15 +0000
Message-ID: <87va2lyibo.fsf@linaro.org>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Jan 17, 2019 at 18:55:33 +0000, Peter Maydell wrote:
>> On Thu, 17 Jan 2019 at 18:30, Emilio G. Cota <cota@braap.org> wrote:
>> > What are the contents of "int-to-float.err"?
>>
>> linux1@lxub05:~$ cat qemu/build/all/tests/fp/int-to-float.err
>> >> Testing i32_to_f16, rounding near_even
>> 372 tests total.
>> 372 tests performed.
>> >> Testing i64_to_f16, rounding near_even
>> 756 tests total.
>> 756 tests performed.
>> >> Testing i32_to_f32, rounding near_even
>> 372 tests total.
>> 372 tests performed.
>> >> Testing i64_to_f32, rounding near_even
>> 756 tests total.
>> 756 tests performed.
>> >> Testing i32_to_f64
>> 372 tests total.
>> 372 tests performed.
>> >> Testing i64_to_f64, rounding near_even
>> 756 tests total.
>> 756 tests performed.
>> >> Testing i32_to_f128
>> 372 tests total.
>> 21 tests performed; 20 errors found.
>
> I see, so i32_to_f128 is failing on this host. Is there
> a s390x machine I could access? I don't see one in the
> gcc compile farm.

I've managed to reproduce this in a s390x VM, for Debian install runes:

  https://wiki.qemu.org/Documentation/Platforms/S390X#Debian_Install_Exampl=
e_.28TCG.29

>
>> > diff --git a/tests/fp/Makefile b/tests/fp/Makefile
>> > index 5019dcdca0..5a35e7c210 100644
>> > --- a/tests/fp/Makefile
>> > +++ b/tests/fp/Makefile
>> > @@ -65,8 +65,7 @@ QEMU_CFLAGS +=3D $(TF_OPTS)
>> >  TF_CFLAGS :=3D
>> >  TF_CFLAGS +=3D -Wno-strict-prototypes
>> >  TF_CFLAGS +=3D -Wno-unknown-pragmas
>> > -TF_CFLAGS +=3D -Wno-discarded-qualifiers
>> > -TF_CFLAGS +=3D -Wno-maybe-uninitialized
>> > +TF_CFLAGS +=3D -Wno-uninitialized
>> >  TF_CFLAGS +=3D -Wno-missing-prototypes
>> >  TF_CFLAGS +=3D -Wno-return-type
>> >  TF_CFLAGS +=3D -Wno-unused-function
>>
>> configure has logic to check whether it can use particular
>> warning enable/disable flags. Newer gcc (and I hope clang
>> but forget) will happily silently allow -Wno-random-new-thing
>> even if they don't support -Wrandom-new-thing) but I'm not
>> sure our minimum compiler version is yet new enough to
>> be able to rely on that (indeed the warning messages suggest
>> it is not).
>
> I figured that -Wno-unitialized is documented to work on both
> gcc and clang, and the change in testfloat drops the need
> for no-discarded-qualifiers, so we can go with this without
> messing with configure.

Works for me, OK with you Peter?

--
Alex Benn=C3=A9e
