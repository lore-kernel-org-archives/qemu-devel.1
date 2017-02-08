Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbBw-0006Vi-0a
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbBv-0007TC-0S
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:58:24 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbbBu-0007SZ-Or
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:58:22 -0500
Received: by mail-wr0-x22d.google.com with SMTP id 89so70416655wrr.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 14:58:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-3-laurent@vivier.eu>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 22:58:00 +0000
Message-ID: <CAFEAcA9dRrmY+86t6uzqnaRynvV4AW3vcCfaqRJKT1gt=E_OJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andreas Schwab <schwab@linux-m68k.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 7 February 2017 at 00:59, Laurent Vivier <laurent@vivier.eu> wrote:
> According to the comment, this definition of invalid encoding is given
> by intel developer's manual, and doesn't work with the behavior
> of 680x0 FPU.
>
> CC: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  fpu/softfloat.c         | 31 +++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h | 15 ---------------
>  2 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..f95b19f 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -4799,6 +4799,37 @@ int float64_unordered_quiet(float64 a, float64 b, =
float_status *status)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| Return whether the given value is an invalid floatx80 encoding.
> +| Invalid floatx80 encodings arise when the integer bit is not set, but
> +| the exponent is not zero. The only times the integer bit is permitted =
to
> +| be zero is in subnormal numbers and the value zero.
> +| This includes what the Intel software developer's manual calls pseudo-=
NaNs,
> +| pseudo-infinities and un-normal numbers. It does not include
> +| pseudo-denormals, which must still be correctly handled as inputs even
> +| if they are never generated as outputs.
> +*-----------------------------------------------------------------------=
-----*/
> +static inline bool floatx80_invalid_encoding(floatx80 a)
> +{
> +#if defined(TARGET_M68K)
> +    /*------------------------------------------------------------------=
-------
> +    |  M68000 FAMILY PROGRAMMER=E2=80=99S REFERENCE MANUAL
> +    |  1.6.2 Denormalized Numbers
> +    |  Since the extended-precision data format has an explicit integer =
bit,
> +    |  a number can be formatted with a nonzero exponent, less than the =
maximum
> +    |  value, and a zero integer bit.  The IEEE 754 standard does not de=
fine a
> +    |  zero integer bit. Such a number is an unnormalized number. Hardwa=
re does
> +    |  not directly support denormalized and unnormalized numbers, but
> +    |  implicitly supports them by trapping them as unimplemented data t=
ypes,
> +    |  allowing efficient conversion in software.
> +    *-------------------------------------------------------------------=
-----*/

This comment says that numbers of the form that this function
identifies (zero integer bit and nonzero exponent) are
supposed to trap on m68k. That suggests that the target/m68k code
is going to need to catch this case before it calls softfloat
code. So (a) we don't care what the softfloat code does
with these representations because they'll never get to it
and (b) the m68k code could probably use floatx80_invalid_encoding()
as a function to identify where it needs to trap, which it
can't do if it's moved out of softfloat.h.

Either way this change doesn't seem right given what the
comment describes...

thanks
-- PMM
