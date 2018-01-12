Received: from eggs.gnu.org ([2001:4830:134:3::10]:52785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzxH-0006l1-0G
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzxC-0001SR-3R
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:05:10 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzxB-0001SB-Tv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:05:06 -0500
Received: by mail-ot0-x241.google.com with SMTP id w4so5113223otg.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 06:05:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-8-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 14:04:44 +0000
Message-ID: <CAFEAcA8GKN_shhnizPihdts0w-Tbg-+W-971Q6Mt5zFbT8hdYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/20] fpu/softfloat: propagate
 signalling NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> While a comparison between a QNaN and a number will return the number
> it is not the same with a signaling NaN. In this case the SNaN will
> "win" and after potentially raising an exception it will be quietened.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2
>   - added return for propageFloat
> ---
>  fpu/softfloat.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 3a4ab1355f..44c043924e 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -7683,6 +7683,7 @@ int float128_compare_quiet(float128 a, float128 b, =
float_status *status)
>   * minnum() and maxnum() functions. These are similar to the min()
>   * and max() functions but if one of the arguments is a QNaN and
>   * the other is numerical then the numerical argument is returned.
> + * SNaNs will get quietened before being returned.
>   * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
>   * and maxNum() operations. min() and max() are the typical min/max
>   * semantics provided by many CPUs which predate that specification.
> @@ -7703,11 +7704,14 @@ static inline float ## s float ## s ## _minmax(fl=
oat ## s a, float ## s b,     \
>      if (float ## s ## _is_any_nan(a) ||                                 =
\
>          float ## s ## _is_any_nan(b)) {                                 =
\
>          if (isieee) {                                                   =
\
> -            if (float ## s ## _is_quiet_nan(a, status) &&               =
\
> +            if (float ## s ## _is_signaling_nan(a, status) ||           =
\
> +                float ## s ## _is_signaling_nan(b, status)) {           =
\
> +                return propagateFloat ## s ## NaN(a, b, status);        =
\
> +            } else  if (float ## s ## _is_quiet_nan(a, status) &&       =
\
>                  !float ## s ##_is_any_nan(b)) {                         =
\
>                  return b;                                               =
\
>              } else if (float ## s ## _is_quiet_nan(b, status) &&        =
\
> -                       !float ## s ## _is_any_nan(a)) {                \
> +                       !float ## s ## _is_any_nan(a)) {                 =
\
>                  return a;                                               =
\
>              }                                                           =
\
>          }                                                               =
\
>          return propagateFloat ## s ## NaN(a, b, status);                =
\
>      }                                                                   =
\

[added a couple of extra lines of context at the end for clarity]

Am I misreading this patch? I can't see in what case it makes a
difference to the result. The code change adds an explicit "if
either A or B is an SNaN then return the propagateFloat*NaN() result".
But if either A or B is an SNaN then we won't take either of the
previously existing branches in this if() ("if A is a QNaN and B is
not a NaN" and "if B is a QNaN and A is not a NaN"), and so we'll
end up falling through to the "return propagateFloat*NaN" line after
the end of the "is (ieee) {...}".

thanks
-- PMM
