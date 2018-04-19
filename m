Received: from eggs.gnu.org ([2001:4830:134:3::10]:60659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9EtV-0006UA-0v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9EtQ-00073L-2c
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:06:57 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:40533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9EtP-00072L-PJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:06:51 -0400
Received: by mail-pg0-x22a.google.com with SMTP id e9so2932945pgr.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:06:51 -0700 (PDT)
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
	<20180417223837.GA25085@flamenco>
	<cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
	<CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
	<CAFEAcA9pOVf1LwMGgwfPWy8KRG8k-EFzscWGmPrUo-9NT7J=QA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e6e8316-b1fd-76ee-fe1d-1d78d5e1760a@linaro.org>
Date: Thu, 19 Apr 2018 09:06:45 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pOVf1LwMGgwfPWy8KRG8k-EFzscWGmPrUo-9NT7J=QA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------E77242E8A17B15D2EDC0F269"
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

This is a multi-part message in MIME format.
--------------E77242E8A17B15D2EDC0F269
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 04/17/2018 01:08 PM, Peter Maydell wrote:
> On 18 April 2018 at 00:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>> I don't have the original IEEE754 spec to hand though;
>> that may have left this unspecified.
> 
> Having located a copy of 754-1985 I think that also is
> clear enough that float-float conversion is an operation
> that must quieten SNaN and raise Invalid.

That does seem to match actual processor behaviour.
The attached test case produces

7fa00000
7ffc000000000000 - 1
7ff4000000000000
7fe00000 - 1

on both x86_64 and aarch64.

For ppc64, I believe there's a compiler bug:

7fa00000
7ff4000000000000 - 0
7ff4000000000000
7fe00000 - 536870912

convert float to double:
    1000074c:   60 00 01 c0     lfs     f0,96(r1)
    10000750:   68 00 01 d8     stfd    f0,104(r1)

convert double to float:
    100007a8:   68 00 01 c8     lfd     f0,104(r1)
    100007ac:   18 00 00 fc     frsp    f0,f0
    100007b0:   60 00 01 d0     stfs    f0,96(r1)

Floating point numbers are held in a "register" format that largely corresponds
to double-precision.  Thus the compiler believes that loading a
single-precision value and then storing it out again as a double is sufficient.
 However, as we can see above that does not consider SNaN.

There is no ppc "convert single to double" instruction, there is only a "round
to single precision" instruction -- frsp.  However, if we assume that the
single precision number is already properly rounded, then we can add an extra
frsp and it will not normally affect the value at all; it will only change the
contents for snan.

If I manually add the frsp insn to the code generated for the test case I get

7fa00000
7ffc000000000000 - 536870912
7ff4000000000000
7fe00000 - 536870912

exactly as we expect.  I'll file a bug vs gcc.


r~

--------------E77242E8A17B15D2EDC0F269
Content-Type: text/x-csrc;
 name="z.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="z.c"

#include <stdio.h>
#include <fenv.h>

int main() {
    volatile union { unsigned i; float f; } u;
    volatile union { unsigned long l; double d; } v;

    feclearexcept(FE_ALL_EXCEPT);
    u.f = __builtin_nansf("");
    v.d = u.f;
    printf("%08x\n", u.i);
    printf("%016lx - %d\n", v.l, fetestexcept(FE_INVALID));

    feclearexcept(FE_ALL_EXCEPT);
    v.d = __builtin_nans("");
    u.f = v.d;
    printf("%016lx\n", v.l);
    printf("%08x - %d\n", u.i, fetestexcept(FE_INVALID));

    return 0;
}

--------------E77242E8A17B15D2EDC0F269--
