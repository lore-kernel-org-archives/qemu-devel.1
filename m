Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQeub-0008Mj-BC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQeua-00037Z-3r
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:15:33 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQeuZ-00037T-U6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:15:32 -0400
Received: by mail-it0-x242.google.com with SMTP id k3so1091642ita.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 12:15:31 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170629190405.1748-1-laurent@vivier.eu>
References: <20170629190405.1748-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Thu, 29 Jun 2017 16:15:30 -0300
Message-ID: <CAAdtpL5Zm6OX=FLAku_gcVyukQCrw5qhFDX9rcchOkEPr6yFCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] softfloat: define floatx80_default_inf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Jun 29, 2017 at 4:04 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  fpu/softfloat-specialize.h | 10 ++++++++++
>  fpu/softfloat.c            | 38 ++++++++++++++++++++++++++------------
>  include/fpu/softfloat.h    |  8 +++++++-
>  3 files changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
> index de2c5d5..139b197 100644
> --- a/fpu/softfloat-specialize.h
> +++ b/fpu/softfloat-specialize.h
> @@ -178,6 +178,16 @@ floatx80 floatx80_default_nan(float_status *status)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| The pattern for a default generated extended double-precision inf.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +#define floatx80_default_inf_high 0x7FFF
> +#define floatx80_default_inf_low  LIT64(0x8000000000000000)
> +
> +const floatx80 floatx80_default_inf
> +    =3D make_floatx80_init(floatx80_default_inf_high, floatx80_default_i=
nf_low);
> +
> +/*----------------------------------------------------------------------=
------
>  | The pattern for a default generated quadruple-precision NaN.
>  *-----------------------------------------------------------------------=
-----*/
>  float128 float128_default_nan(float_status *status)
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 7af14e2..67f1dd9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -913,7 +913,9 @@ static floatx80 roundAndPackFloatx80(int8_t roundingP=
recision, flag zSign,
>                 ) {
>                  return packFloatx80( zSign, 0x7FFE, ~ roundMask );
>              }
> -            return packFloatx80( zSign, 0x7FFF, LIT64( 0x800000000000000=
0 ) );
> +            return packFloatx80(zSign,
> +                                floatx80_default_inf_high,
> +                                floatx80_default_inf_low);
>          }
>          if ( zExp <=3D 0 ) {
>              isTiny =3D
> @@ -1885,7 +1887,9 @@ floatx80 float32_to_floatx80(float32 a, float_statu=
s *status)
>          if (aSig) {
>              return commonNaNToFloatx80(float32ToCommonNaN(a, status), st=
atus);
>          }
> -        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(aSign,
> +                            floatx80_default_inf_high,
> +                            floatx80_default_inf_low);
>      }
>      if ( aExp =3D=3D 0 ) {
>          if ( aSig =3D=3D 0 ) return packFloatx80( aSign, 0, 0 );
> @@ -3666,7 +3670,9 @@ floatx80 float64_to_floatx80(float64 a, float_statu=
s *status)
>          if (aSig) {
>              return commonNaNToFloatx80(float64ToCommonNaN(a, status), st=
atus);
>          }
> -        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(aSign,
> +                            floatx80_default_inf_high,
> +                            floatx80_default_inf_low);
>      }
>      if ( aExp =3D=3D 0 ) {
>          if ( aSig =3D=3D 0 ) return packFloatx80( aSign, 0, 0 );
> @@ -4927,8 +4933,8 @@ int64_t floatx80_to_int64(floatx80 a, float_status =
*status)
>          if ( shiftCount ) {
>              float_raise(float_flag_invalid, status);
>              if (    ! aSign
> -                 || (    ( aExp =3D=3D 0x7FFF )
> -                      && ( aSig !=3D LIT64( 0x8000000000000000 ) ) )
> +                 || ((aExp =3D=3D floatx80_default_inf_high)
> +                     && (aSig !=3D floatx80_default_inf_low))
>                 ) {
>                  return LIT64( 0x7FFFFFFFFFFFFFFF );
>              }
> @@ -5219,7 +5225,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx8=
0 b, flag zSign,
>              if ((uint64_t)(bSig << 1)) {
>                  return propagateFloatx80NaN(a, b, status);
>              }
> -            return packFloatx80( zSign, 0x7FFF, LIT64( 0x800000000000000=
0 ) );
> +            return packFloatx80(zSign,
> +                                floatx80_default_inf_high,
> +                                floatx80_default_inf_low);
>          }
>          if ( aExp =3D=3D 0 ) ++expDiff;
>          shift64ExtraRightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
> @@ -5294,7 +5302,8 @@ static floatx80 subFloatx80Sigs(floatx80 a, floatx8=
0 b, flag zSign,
>          if ((uint64_t)(bSig << 1)) {
>              return propagateFloatx80NaN(a, b, status);
>          }
> -        return packFloatx80( zSign ^ 1, 0x7FFF, LIT64( 0x800000000000000=
0 ) );
> +        return packFloatx80(zSign ^ 1, floatx80_default_inf_high,
> +                            floatx80_default_inf_low);
>      }
>      if ( aExp =3D=3D 0 ) ++expDiff;
>      shift128RightJamming( aSig, 0, - expDiff, &aSig, &zSig1 );
> @@ -5399,7 +5408,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float=
_status *status)
>              return propagateFloatx80NaN(a, b, status);
>          }
>          if ( ( bExp | bSig ) =3D=3D 0 ) goto invalid;
> -        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(zSign, floatx80_default_inf_high,
> +                                   floatx80_default_inf_low);
>      }
>      if ( bExp =3D=3D 0x7FFF ) {
>          if ((uint64_t)(bSig << 1)) {
> @@ -5410,7 +5420,8 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float=
_status *status)
>              float_raise(float_flag_invalid, status);
>              return floatx80_default_nan(status);
>          }
> -        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(zSign, floatx80_default_inf_high,
> +                                   floatx80_default_inf_low);
>      }
>      if ( aExp =3D=3D 0 ) {
>          if ( aSig =3D=3D 0 ) return packFloatx80( zSign, 0, 0 );
> @@ -5464,7 +5475,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float=
_status *status)
>              }
>              goto invalid;
>          }
> -        return packFloatx80( zSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(zSign, floatx80_default_inf_high,
> +                                   floatx80_default_inf_low);
>      }
>      if ( bExp =3D=3D 0x7FFF ) {
>          if ((uint64_t)(bSig << 1)) {
> @@ -5480,7 +5492,8 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float=
_status *status)
>                  return floatx80_default_nan(status);
>              }
>              float_raise(float_flag_divbyzero, status);
> -            return packFloatx80( zSign, 0x7FFF, LIT64( 0x800000000000000=
0 ) );
> +            return packFloatx80(zSign, floatx80_default_inf_high,
> +                                       floatx80_default_inf_low);
>          }
>          normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
>      }
> @@ -6303,7 +6316,8 @@ floatx80 float128_to_floatx80(float128 a, float_sta=
tus *status)
>          if ( aSig0 | aSig1 ) {
>              return commonNaNToFloatx80(float128ToCommonNaN(a, status), s=
tatus);
>          }
> -        return packFloatx80( aSign, 0x7FFF, LIT64( 0x8000000000000000 ) =
);
> +        return packFloatx80(aSign, floatx80_default_inf_high,
> +                                   floatx80_default_inf_low);
>      }
>      if ( aExp =3D=3D 0 ) {
>          if ( ( aSig0 | aSig1 ) =3D=3D 0 ) return packFloatx80( aSign, 0,=
 0 );
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index f1288ef..f0dff25 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -619,6 +619,11 @@ float64 floatx80_to_float64(floatx80, float_status *=
status);
>  float128 floatx80_to_float128(floatx80, float_status *status);
>
>  /*----------------------------------------------------------------------=
------
> +| The pattern for a default generated extended double-precision inf.
> +*-----------------------------------------------------------------------=
-----*/
> +extern const floatx80 floatx80_default_inf;
> +
> +/*----------------------------------------------------------------------=
------
>  | Software IEC/IEEE extended double-precision operations.
>  *-----------------------------------------------------------------------=
-----*/
>  floatx80 floatx80_round_to_int(floatx80, float_status *status);
> @@ -657,7 +662,8 @@ static inline floatx80 floatx80_chs(floatx80 a)
>
>  static inline int floatx80_is_infinity(floatx80 a)
>  {
> -    return (a.high & 0x7fff) =3D=3D 0x7fff && a.low =3D=3D 0x80000000000=
00000LL;
> +    return (a.high & 0x7fff) =3D=3D floatx80_default_inf.high &&
> +                       a.low =3D=3D floatx80_default_inf.low;
>  }
>
>  static inline int floatx80_is_neg(floatx80 a)
> --
> 2.9.4
>
>
