Received: from eggs.gnu.org ([2001:4830:134:3::10]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpUl0-0008Lt-1P
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpUkw-0001xD-UG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:32:50 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fpUkw-0001wc-EA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:32:46 -0400
Received: by mail-wm0-x241.google.com with SMTP id y9-v6so11389790wma.5
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 01:32:46 -0700 (PDT)
References: <20180814002653.12828-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180814002653.12828-1-richard.henderson@linaro.org>
Date: Tue, 14 Aug 2018 09:32:44 +0100
Message-ID: <87bma5wdoz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Fix int64_to_float16
 double-rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> In 88808a022c0, I tried to fix an overflow problem that affected float16
> scaling by coverting first to float64 and then rounding after that.
>
> However, Laurent reported that -0x3ff40000000001 converted to float16
> resulted in 0xfbfe instead of the expected 0xfbff.  This is caused by
> the inexact conversion to float64.
>
> Rather than build more logic into target/arm to compensate, just add
> a function that takes a scaling parameter so that the whole thing is
> done all at once with only one rounding.
>
> I don't have a failing test case for the float-to-int paths, but it
> seemed best to apply the same solution.

Can't we add the constants to the fcvt test case?

>
>
> r~
>
>
> Richard Henderson (4):
>   softfloat: Add scaling int-to-float routines
>   softfloat: Add scaling float-to-int routines
>   target/arm: Use the int-to-float-scale softfloat routines
>   target/arm: Use the float-to-int-scale softfloat routines
>
>  include/fpu/softfloat.h | 169 ++++++++----
>  fpu/softfloat.c         | 579 +++++++++++++++++++++++++++++++---------
>  target/arm/helper.c     | 130 ++++-----
>  3 files changed, 628 insertions(+), 250 deletions(-)


--
Alex Benn=C3=A9e
