Received: from eggs.gnu.org ([209.51.188.92]:59908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1guDUN-0001OG-4N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1guDUL-0000gA-5M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:39:27 -0500
References: <20190214061154.30457-1-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d6e95df9-4499-21fe-1b40-b68424498a3d@redhat.com>
Date: Thu, 14 Feb 2019 10:39:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190214061154.30457-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-s390x@nongnu.org

On 14.02.19 07:11, Richard Henderson wrote:
> Previously this was only supported for roundAndPackFloat64.
> Include support in round_canonical, round_to_int, roundAndPackFloat32,
> roundAndPackInt32, roundAndPackInt64, roundAndPackUint64.
> 
> This does not include any of the floatx80 routines, as we
> do not have users for that rounding mode there.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> David, if you could test this vs your s390 patches, vs real s390
> hardware, that would be lovely.

I wrote a quick test for LOAD FP INTEGER to test some of the code paths.

Real HW

PASS: selftest: fidbra(0.5) == 1 with RSP
PASS: selftest: fidbra(-0.5) == -1 with RSP
PASS: selftest: fidbra(9.5) == 9 with RSP
PASS: selftest: fidbra(-9.5) == -9 with RSP
PASS: selftest: fidbra(2.5) == 3 with RSP
PASS: selftest: fidbra(-2.5) == -3 with RSP
PASS: selftest: fiebra(0.5) == 1 with RSP
PASS: selftest: fiebra(-0.5) == -1 with RSP
PASS: selftest: fiebra(9.5) == 9 with RSP
PASS: selftest: fiebra(-9.5) == -9 with RSP
PASS: selftest: fiebra(2.5) == 3 with RSP
PASS: selftest: fiebra(-2.5) == -3 with RSP
PASS: selftest: fixbra(0.5) == 1 with RSP
PASS: selftest: fixbra(-0.5) == -1 with RSP
PASS: selftest: fixbra(9.5) == 9 with RSP
PASS: selftest: fixbra(-9.5) == -9 with RSP
PASS: selftest: fixbra(2.5) == 3 with RSP
PASS: selftest: fixbra(-2.5) == -3 with RSP


With round_to_zero

FAIL: selftest: fidbra(0.5) == 1 with RSP
FAIL: selftest: fidbra(-0.5) == -1 with RSP
PASS: selftest: fidbra(9.5) == 9 with RSP
PASS: selftest: fidbra(-9.5) == -9 with RSP
FAIL: selftest: fidbra(2.5) == 3 with RSP
FAIL: selftest: fidbra(-2.5) == -3 with RSP
FAIL: selftest: fiebra(0.5) == 1 with RSP
FAIL: selftest: fiebra(-0.5) == -1 with RSP
PASS: selftest: fiebra(9.5) == 9 with RSP
PASS: selftest: fiebra(-9.5) == -9 with RSP
FAIL: selftest: fiebra(2.5) == 3 with RSP
FAIL: selftest: fiebra(-2.5) == -3 with RSP
FAIL: selftest: fixbra(0.5) == 1 with RSP
FAIL: selftest: fixbra(-0.5) == -1 with RSP
PASS: selftest: fixbra(9.5) == 9 with RSP
PASS: selftest: fixbra(-9.5) == -9 with RSP
FAIL: selftest: fixbra(2.5) == 3 with RSP
FAIL: selftest: fixbra(-2.5) == -3 with RSP

With round_to_odd

PASS: selftest: fidbra(0.5) == 0 with RTZ
PASS: selftest: fidbra(0.5) == 1 with RSP
PASS: selftest: fidbra(-0.5) == -1 with RSP
PASS: selftest: fidbra(9.5) == 9 with RSP
PASS: selftest: fidbra(-9.5) == -9 with RSP
PASS: selftest: fidbra(2.5) == 3 with RSP
PASS: selftest: fidbra(-2.5) == -3 with RSP
PASS: selftest: fiebra(0.5) == 1 with RSP
PASS: selftest: fiebra(-0.5) == -1 with RSP
PASS: selftest: fiebra(9.5) == 9 with RSP
PASS: selftest: fiebra(-9.5) == -9 with RSP
PASS: selftest: fiebra(2.5) == 3 with RSP
PASS: selftest: fiebra(-2.5) == -3 with RSP
FAIL: selftest: fixbra(0.5) == 1 with RSP
FAIL: selftest: fixbra(-0.5) == -1 with RSP
QEMU Aborted

So something seems to go wrong when trying to round 9.5 in 128bit.

The 32/64 bit stuff seems to work :)

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
> @@ -696,6 +696,7 @@ static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
>  static FloatParts round_canonical(FloatParts p, float_status *s,
>                                    const FloatFmt *parm)
>  {
> +    const uint64_t frac_lsb = parm->frac_lsb;
>      const uint64_t frac_lsbm1 = parm->frac_lsbm1;
>      const uint64_t round_mask = parm->round_mask;
>      const uint64_t roundeven_mask = parm->roundeven_mask;
> @@ -731,6 +732,10 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
>              inc = p.sign ? round_mask : 0;
>              overflow_norm = !p.sign;
>              break;
> +        case float_round_to_odd:
> +            overflow_norm = true;
> +            inc = frac & frac_lsb ? 0 : frac_lsbm1;
> +            break;
>          default:
>              g_assert_not_reached();
>          }
> @@ -778,9 +783,14 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
>              shift64RightJamming(frac, 1 - exp, &frac);
>              if (frac & round_mask) {
>                  /* Need to recompute round-to-even.  */
> -                if (s->float_rounding_mode == float_round_nearest_even) {
> +                switch (s->float_rounding_mode) {
> +                case float_round_nearest_even:
>                      inc = ((frac & roundeven_mask) != frac_lsbm1
>                             ? frac_lsbm1 : 0);
> +                    break;
> +                case float_round_to_odd:
> +                    inc = frac & frac_lsb ? 0 : frac_lsbm1;
> +                    break;
>                  }
>                  flags |= float_flag_inexact;
>                  frac += inc;
> @@ -1988,6 +1998,9 @@ static FloatParts round_to_int(FloatParts a, int rmode,
>              case float_round_down:
>                  one = a.sign;
>                  break;
> +            case float_round_to_odd:
> +                one = true;
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> @@ -2021,6 +2034,9 @@ static FloatParts round_to_int(FloatParts a, int rmode,
>              case float_round_down:
>                  inc = a.sign ? rnd_mask : 0;
>                  break;
> +            case float_round_to_odd:
> +                inc = a.frac & frac_lsb ? 0 : frac_lsbm1;
> +                break;
>              default:
>                  g_assert_not_reached();
>              }
> @@ -3314,6 +3330,9 @@ static int32_t roundAndPackInt32(flag zSign, uint64_t absZ, float_status *status
>      case float_round_down:
>          roundIncrement = zSign ? 0x7f : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement = absZ & 0x80 ? 0 : 0x7f;
> +        break;
>      default:
>          abort();
>      }
> @@ -3368,6 +3387,9 @@ static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
>      case float_round_down:
>          increment = zSign && absZ1;
>          break;
> +    case float_round_to_odd:
> +        increment = !(absZ0 & 1) && absZ1;
> +        break;
>      default:
>          abort();
>      }
> @@ -3424,6 +3446,9 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
>      case float_round_down:
>          increment = zSign && absZ1;
>          break;
> +    case float_round_to_odd:
> +        increment = !(absZ0 & 1) && absZ1;
> +        break;
>      default:
>          abort();
>      }
> @@ -3526,6 +3551,8 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
>      case float_round_down:
>          roundIncrement = zSign ? 0x7f : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement = zSig & 0x80 ? 0 : 0x7f;
>      default:
>          abort();
>          break;
> @@ -3536,8 +3563,10 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
>               || (    ( zExp == 0xFD )
>                    && ( (int32_t) ( zSig + roundIncrement ) < 0 ) )
>             ) {
> +            bool overflow_to_inf = roundingMode != float_round_to_odd &&
> +                                   roundIncrement != 0;
>              float_raise(float_flag_overflow | float_flag_inexact, status);
> -            return packFloat32( zSign, 0xFF, - ( roundIncrement == 0 ));
> +            return packFloat32(zSign, 0xFF, -!overflow_to_inf);
>          }
>          if ( zExp < 0 ) {
>              if (status->flush_to_zero) {
> @@ -3555,6 +3584,13 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
>              if (isTiny && roundBits) {
>                  float_raise(float_flag_underflow, status);
>              }
> +            if (roundingMode == float_round_to_odd) {
> +                /*
> +                 * For round-to-odd case, the roundIncrement depends on
> +                 * zSig which just changed.
> +                 */
> +                roundIncrement = zSig & 0x80 ? 0 : 0x7f;
> +            }
>          }
>      }
>      if (roundBits) {
> 


-- 

Thanks,

David / dhildenb
