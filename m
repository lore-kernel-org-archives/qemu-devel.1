Received: from eggs.gnu.org ([2001:4830:134:3::10]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9RH9-0004YI-6x
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9RH5-0008Kw-AD
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:20:11 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:41911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9RH5-0008KO-3G
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:20:07 -0400
Received: by mail-wr0-x22b.google.com with SMTP id v24-v6so20586155wra.8
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 01:20:07 -0700 (PDT)
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
	<20180417223837.GA25085@flamenco>
	<cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
	<CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
	<CAFEAcA9pOVf1LwMGgwfPWy8KRG8k-EFzscWGmPrUo-9NT7J=QA@mail.gmail.com>
	<7e6e8316-b1fd-76ee-fe1d-1d78d5e1760a@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7e6e8316-b1fd-76ee-fe1d-1d78d5e1760a@linaro.org>
Date: Fri, 20 Apr 2018 09:20:04 +0100
Message-ID: <87po2u9tmz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/17/2018 01:08 PM, Peter Maydell wrote:
>> On 18 April 2018 at 00:01, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>>> I don't have the original IEEE754 spec to hand though;
>>> that may have left this unspecified.
>>
>> Having located a copy of 754-1985 I think that also is
>> clear enough that float-float conversion is an operation
>> that must quieten SNaN and raise Invalid.
>
> That does seem to match actual processor behaviour.
> The attached test case produces
>
> 7fa00000
> 7ffc000000000000 - 1
> 7ff4000000000000
> 7fe00000 - 1
>
> on both x86_64 and aarch64.
>
> For ppc64, I believe there's a compiler bug:
>
> 7fa00000
> 7ff4000000000000 - 0
> 7ff4000000000000
> 7fe00000 - 536870912
>
> convert float to double:
>     1000074c:   60 00 01 c0     lfs     f0,96(r1)
>     10000750:   68 00 01 d8     stfd    f0,104(r1)
>
> convert double to float:
>     100007a8:   68 00 01 c8     lfd     f0,104(r1)
>     100007ac:   18 00 00 fc     frsp    f0,f0
>     100007b0:   60 00 01 d0     stfs    f0,96(r1)
>
> Floating point numbers are held in a "register" format that largely corre=
sponds
> to double-precision.  Thus the compiler believes that loading a
> single-precision value and then storing it out again as a double is suffi=
cient.
>  However, as we can see above that does not consider SNaN.
>
> There is no ppc "convert single to double" instruction, there is only a "=
round
> to single precision" instruction -- frsp.  However, if we assume that the
> single precision number is already properly rounded, then we can add an e=
xtra
> frsp and it will not normally affect the value at all; it will only chang=
e the
> contents for snan.
>
> If I manually add the frsp insn to the code generated for the test case I=
 get
>
> 7fa00000
> 7ffc000000000000 - 536870912
> 7ff4000000000000
> 7fe00000 - 536870912
>
> exactly as we expect.  I'll file a bug vs gcc.

It does seem to be floating point is a rabbit hole that everyone gets
something wrong if you look too closely!

--
Alex Benn=C3=A9e
