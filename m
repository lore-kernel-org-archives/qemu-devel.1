Received: from eggs.gnu.org ([2001:4830:134:3::10]:47652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcb4-0002zG-4y
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcZm-0008K3-AT
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:10 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZcZl-0008FA-Cx
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:02:49 -0500
Received: by mail-wm0-x231.google.com with SMTP id r141so24341397wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 04:02:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485504213-21632-3-git-send-email-bharata@linux.vnet.ibm.com>
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1485504213-21632-3-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 12:02:26 +0000
Message-ID: <CAFEAcA9icm0TpkxeMSp=KQLYnnwSepYU35pDPmSh0Up+CROJ8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/2] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 27 January 2017 at 08:03, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Power ISA 3.0 introduces a few quadruple precision floating point
> instructions that support round-to-odd rounding mode. The
> round-to-odd mode is explained as under:
>
> Let Z be the intermediate arithmetic result or the operand of a convert
> operation. If Z can be represented exactly in the target format, the
> result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
> Here Z1 and Z2 are the next larger and smaller numbers representable
> in the target format respectively.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  fpu/softfloat.c         | 17 ++++++++++++++++-
>  include/fpu/softfloat.h |  2 ++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index b04699c..1c322ad 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -623,6 +623,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
>      case float_round_down:
>          roundIncrement = zSign ? 0x3ff : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement = (zSig & 0x400) ? 0 : 0x3ff;
> +        break;
>      default:
>          abort();
>      }
> @@ -632,8 +635,10 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
>               || (    ( zExp == 0x7FD )
>                    && ( (int64_t) ( zSig + roundIncrement ) < 0 ) )
>             ) {
> +            bool overflow_to_inf = roundingMode != float_round_to_odd &&
> +                                   roundIncrement != 0;
>              float_raise(float_flag_overflow | float_flag_inexact, status);
> -            return packFloat64( zSign, 0x7FF, - ( roundIncrement == 0 ));
> +            return packFloat64( zSign, 0x7FF, - ( !overflow_to_inf ));

Can you follow the QEMU coding style, please? softfloat's coding
style is insane and we generally have been switching it to the
QEMU style as we touch lines of code.

>          }
>          if ( zExp < 0 ) {
>              if (status->flush_to_zero) {
> @@ -665,6 +670,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
>              case float_round_down:
>                  roundIncrement = zSign ? 0x3ff : 0;
>                  break;
> +            case float_round_to_odd:
> +                roundIncrement = (zSig & 0x400) ? 0 : 0x3ff;
> +                break;
>              default:
>                  abort();
>              }

Ah, this extra check does make a difference for the round-to-odd
case. But since it's a special for round-to-odd, better to
phrase as
  if (roundingMode == float_round_to_odd) {
      /* in this case roundIncrement depends on zSig, which just changed */
      roundIncrement = ...;
  }

rather than a case statement where most of the code is no-ops.

> @@ -1166,6 +1174,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>      case float_round_down:
>          increment = zSign && zSig2;
>          break;
> +    case float_round_to_odd:
> +        increment = !(zSig1 & 0x1) && zSig2;
> +        break;
>      default:
>          abort();
>      }
> @@ -1185,6 +1196,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>              if (    ( roundingMode == float_round_to_zero )
>                   || ( zSign && ( roundingMode == float_round_up ) )
>                   || ( ! zSign && ( roundingMode == float_round_down ) )
> +                 || ( roundingMode == float_round_to_odd )
>                 ) {
>                  return
>                      packFloat128(
> @@ -1232,6 +1244,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>              case float_round_down:
>                  increment = zSign && zSig2;
>                  break;
> +            case float_round_to_odd:
> +                increment = !(zSig1 & 0x1) && zSig2;
> +                break;
>              default:
>                  abort();
>              }
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 842ec6b..8a39028 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -180,6 +180,8 @@ enum {
>      float_round_up           = 2,
>      float_round_to_zero      = 3,
>      float_round_ties_away    = 4,
> +    /* Not an IEEE rounding mode: round to the closest odd mantissa value */
> +    float_round_to_odd       = 5,
>  };
>
>  /*----------------------------------------------------------------------------
> --
> 2.7.4
>

Otherwise:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
