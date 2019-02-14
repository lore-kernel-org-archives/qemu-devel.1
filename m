Received: from eggs.gnu.org ([209.51.188.92]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guEt1-00051h-2V
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guEoI-0000gY-12
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:04:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1guEoG-0000fG-3Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:04:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id q21so5631342wmc.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:04:03 -0800 (PST)
References: <20190214061154.30457-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214061154.30457-1-richard.henderson@linaro.org>
Date: Thu, 14 Feb 2019 11:04:00 +0000
Message-ID: <878syiiqcf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] softfloat: Support float_round_to_odd more
 places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, david@redhat.com, qemu-s390x@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Previously this was only supported for roundAndPackFloat64.
> Include support in round_canonical, round_to_int, roundAndPackFloat32,
> roundAndPackInt32, roundAndPackInt64, roundAndPackUint64.

If we extend the fp-test case we can exercise these routines:

  ./fp-test f16_roundToInt f32_roundToInt f64_roundToInt -r odd
  >> Testing f16_roundToInt, rounding odd, exact
  Not implemented.
  >> Testing f32_roundToInt, rounding odd, exact
  Not implemented.
  >> Testing f64_roundToInt, rounding odd, exact
  Not implemented.

See 4cb780920 for an example...

>
> This does not include any of the floatx80 routines, as we
> do not have users for that rounding mode there.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> David, if you could test this vs your s390 patches, vs real s390
> hardware, that would be lovely.
>
>
> r~
>
> ---
>  fpu/softfloat.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 9132d7a0b0..325c6e4e79 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -696,6 +696,7 @@ static FloatParts sf_canonicalize(FloatParts part, co=
nst FloatFmt *parm,
>  static FloatParts round_canonical(FloatParts p, float_status *s,
>                                    const FloatFmt *parm)
>  {
> +    const uint64_t frac_lsb =3D parm->frac_lsb;
>      const uint64_t frac_lsbm1 =3D parm->frac_lsbm1;
>      const uint64_t round_mask =3D parm->round_mask;
>      const uint64_t roundeven_mask =3D parm->roundeven_mask;
> @@ -731,6 +732,10 @@ static FloatParts round_canonical(FloatParts p, floa=
t_status *s,
>              inc =3D p.sign ? round_mask : 0;
>              overflow_norm =3D !p.sign;
>              break;
> +        case float_round_to_odd:
> +            overflow_norm =3D true;
> +            inc =3D frac & frac_lsb ? 0 : frac_lsbm1;
> +            break;
>          default:
>              g_assert_not_reached();
>          }
> @@ -778,9 +783,14 @@ static FloatParts round_canonical(FloatParts p, floa=
t_status *s,
>              shift64RightJamming(frac, 1 - exp, &frac);
>              if (frac & round_mask) {
>                  /* Need to recompute round-to-even.  */
> -                if (s->float_rounding_mode =3D=3D float_round_nearest_ev=
en) {
> +                switch (s->float_rounding_mode) {
> +                case float_round_nearest_even:
>                      inc =3D ((frac & roundeven_mask) !=3D frac_lsbm1
>                             ? frac_lsbm1 : 0);
> +                    break;
> +                case float_round_to_odd:
> +                    inc =3D frac & frac_lsb ? 0 : frac_lsbm1;
> +                    break;
>                  }
>                  flags |=3D float_flag_inexact;
>                  frac +=3D inc;
> @@ -1988,6 +1998,9 @@ static FloatParts round_to_int(FloatParts a, int rm=
ode,
>              case float_round_down:
>                  one =3D a.sign;
>                  break;
> +            case float_round_to_odd:
> +                one =3D true;
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> @@ -2021,6 +2034,9 @@ static FloatParts round_to_int(FloatParts a, int rm=
ode,
>              case float_round_down:
>                  inc =3D a.sign ? rnd_mask : 0;
>                  break;
> +            case float_round_to_odd:
> +                inc =3D a.frac & frac_lsb ? 0 : frac_lsbm1;
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> @@ -3314,6 +3330,9 @@ static int32_t roundAndPackInt32(flag zSign, uint64=
_t absZ, float_status *status
>      case float_round_down:
>          roundIncrement =3D zSign ? 0x7f : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement =3D absZ & 0x80 ? 0 : 0x7f;
> +        break;
>      default:
>          abort();
>      }
> @@ -3368,6 +3387,9 @@ static int64_t roundAndPackInt64(flag zSign, uint64=
_t absZ0, uint64_t absZ1,
>      case float_round_down:
>          increment =3D zSign && absZ1;
>          break;
> +    case float_round_to_odd:
> +        increment =3D !(absZ0 & 1) && absZ1;
> +        break;
>      default:
>          abort();
>      }
> @@ -3424,6 +3446,9 @@ static int64_t roundAndPackUint64(flag zSign, uint6=
4_t absZ0,
>      case float_round_down:
>          increment =3D zSign && absZ1;
>          break;
> +    case float_round_to_odd:
> +        increment =3D !(absZ0 & 1) && absZ1;
> +        break;
>      default:
>          abort();
>      }
> @@ -3526,6 +3551,8 @@ static float32 roundAndPackFloat32(flag zSign, int =
zExp, uint32_t zSig,
>      case float_round_down:
>          roundIncrement =3D zSign ? 0x7f : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement =3D zSig & 0x80 ? 0 : 0x7f;
>      default:
>          abort();
>          break;
> @@ -3536,8 +3563,10 @@ static float32 roundAndPackFloat32(flag zSign, int=
 zExp, uint32_t zSig,
>               || (    ( zExp =3D=3D 0xFD )
>                    && ( (int32_t) ( zSig + roundIncrement ) < 0 ) )
>             ) {
> +            bool overflow_to_inf =3D roundingMode !=3D float_round_to_od=
d &&
> +                                   roundIncrement !=3D 0;
>              float_raise(float_flag_overflow | float_flag_inexact, status=
);
> -            return packFloat32( zSign, 0xFF, - ( roundIncrement =3D=3D 0=
 ));
> +            return packFloat32(zSign, 0xFF, -!overflow_to_inf);
>          }
>          if ( zExp < 0 ) {
>              if (status->flush_to_zero) {
> @@ -3555,6 +3584,13 @@ static float32 roundAndPackFloat32(flag zSign, int=
 zExp, uint32_t zSig,
>              if (isTiny && roundBits) {
>                  float_raise(float_flag_underflow, status);
>              }
> +            if (roundingMode =3D=3D float_round_to_odd) {
> +                /*
> +                 * For round-to-odd case, the roundIncrement depends on
> +                 * zSig which just changed.
> +                 */
> +                roundIncrement =3D zSig & 0x80 ? 0 : 0x7f;
> +            }
>          }
>      }
>      if (roundBits) {


--
Alex Benn=C3=A9e
