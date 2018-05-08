Received: from eggs.gnu.org ([2001:4830:134:3::10]:54286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fG0pJ-0003N4-1v
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fG0pD-0002NG-AQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:30:37 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fG0pD-0002Mu-3V
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:30:31 -0400
Received: by mail-wm0-x242.google.com with SMTP id y189-v6so2698784wmc.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 04:30:30 -0700 (PDT)
References: <20180504100547.14621-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180504100547.14621-1-peter.maydell@linaro.org>
Date: Tue, 08 May 2018 12:30:28 +0100
Message-ID: <87tvriv0yz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] softfloat: Handle default NaN mode after
 pickNaNMulAdd, not before
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, qemu-stable@nongnu.org


Peter Maydell <peter.maydell@linaro.org> writes:

> It is implementation defined whether a multiply-add of
> (0,inf,qnan) or (inf,0,qnan) raises InvalidaOperation or
> not, so we let the target-specific pickNaNMulAdd function
> handle this. This means that we must do the "return the
> default NaN in default NaN mode" check after the call,
> not before. Correct the ordering, and restore the comment
> from the old propagateFloat64MulAddNaN() that warned about
> this corner case.
>
> This fixes a regression from 2.11 for Arm guests where we would
> incorrectly fail to set the Invalid flag for these cases.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  fpu/softfloat.c | 52 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 70e0c40a1c..8401b37bd4 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -602,34 +602,42 @@ static FloatParts pick_nan(FloatParts a, FloatParts=
 b, float_status *s)
>  static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts=
 c,
>                                    bool inf_zero, float_status *s)
>  {
> +    int which;
> +
>      if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
>          s->float_exception_flags |=3D float_flag_invalid;
>      }
>
> -    if (s->default_nan_mode) {
> -        a.cls =3D float_class_dnan;
> -    } else {
> -        switch (pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
> -                              is_qnan(b.cls), is_snan(b.cls),
> -                              is_qnan(c.cls), is_snan(c.cls),
> -                              inf_zero, s)) {
> -        case 0:
> -            break;
> -        case 1:
> -            a =3D b;
> -            break;
> -        case 2:
> -            a =3D c;
> -            break;
> -        case 3:
> -            a.cls =3D float_class_dnan;
> -            return a;
> -        default:
> -            g_assert_not_reached();
> -        }
> +    which =3D pickNaNMulAdd(is_qnan(a.cls), is_snan(a.cls),
> +                          is_qnan(b.cls), is_snan(b.cls),
> +                          is_qnan(c.cls), is_snan(c.cls),
> +                          inf_zero, s);
>
> -        a.cls =3D float_class_msnan;
> +    if (s->default_nan_mode) {
> +        /* Note that this check is after pickNaNMulAdd so that function
> +         * has an opportunity to set the Invalid flag.
> +         */
> +        a.cls =3D float_class_dnan;
> +        return a;
>      }
> +
> +    switch (which) {
> +    case 0:
> +        break;
> +    case 1:
> +        a =3D b;
> +        break;
> +    case 2:
> +        a =3D c;
> +        break;
> +    case 3:
> +        a.cls =3D float_class_dnan;
> +        return a;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    a.cls =3D float_class_msnan;
> +
>      return a;
>  }


--
Alex Benn=C3=A9e
